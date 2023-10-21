//
//  ViewController.swift
//  Repository Retriever
//
//  Created by Ammar Yasser on 20/10/2023.
//


import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var repositories: [Repository] = []
    
    var repPerPage = 10
    var limit = 10
    var paginationRepositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repository Retriever"
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "customCell")
        fetchRepositories()
    }
    //MARK: - Functions to Create and Delete Footer
    
    func createSpinnerFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footer.center
        footer.addSubview(spinner)
        spinner.startAnimating()
        
        return footer
    }
    
    func createFooter(){
        self.tableView.tableFooterView = createSpinnerFooter()
        
    }
    func deleteFooter(){
        self.tableView.tableFooterView = nil
    }
    
    //MARK: - Function to fetch repositories from API
    func fetchRepositories() {
        
        createFooter()
        
        let urlString: String = "https://api.github.com/repositories"
        let urlRequest = URLRequest(url: URL(string: "\(urlString)")!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                print(error)
                self.deleteFooter()
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.repositories = try decoder.decode([Repository].self, from: data)
            } catch {
                print(error)
                self.deleteFooter()
                return
            }
            
            self.repositories = self.repositories
            self.limit = self.repositories.count
            
            for i in 0..<10 {
                self.paginationRepositories.append(self.repositories[i])
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.deleteFooter()
            }
        }.resume()
    }
    
    //MARK: - Function to set Secondary Repo array (for pagination)
    func setPaginationRepos(repPerPage: Int){
        if repPerPage >= limit {
            return
        }
        else if repPerPage >= limit - 10 {
            for i in repPerPage..<limit {
                paginationRepositories.append(repositories[i])
            }
            self.repPerPage += 10
        }
        else {
            for i in repPerPage..<repPerPage + 10 {
                paginationRepositories.append(repositories[i])
            }
            self.repPerPage += 10
        }
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            
            
        }
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let repository = paginationRepositories[indexPath.row]
        cell.repoNameLabel.text = repository.name
        cell.ownerNameLabel.text = repository.owner.login
        cell.ownerImage.sd_setImage(with: URL(string: repository.owner.avatar_url), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        
        let url = URL(string: repository.html_url)!
        UIApplication.shared.open(url)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)
            {
                setPaginationRepos(repPerPage: repPerPage)
                
            }
            
        }
    }
}



