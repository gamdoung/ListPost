//
//  TableViewController.swift
//  Posts
//
//  Created by Gam Doung on 23/2/2564 BE.
//

import UIKit
class TableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    
    var posts: [DummyPost] = []
    var post: DummyPost?
    var id: String?
    var comments:[DummyComment] = []
    var comment: DummyComment?
    var headerImage: String?
    var nameF: String?
    var nameL: String?
    var Labeltext: String?
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.loadView()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "NextTableViewCell", bundle: .main)
        let nibHeader = UINib(nibName: "NextComment", bundle: .main)
        tableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: "NextComment")
        tableView.register(nib, forCellReuseIdentifier: "NextTableViewCell")
        
        
        Network.getPosts{[weak self] (result) in
            if let post = result?.posts{
                self?.posts = post
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }

            
        Network.getComentID(id: self.id ?? "") { [weak self] (result) in
            if let comment = result?.comments{
                self?.comments = comment
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NextTableViewCell") as? NextTableViewCell{
            
            if let picture = comments[indexPath.row].owner?.picture,
               let firstName = comments[indexPath.row].owner?.firstName,
               let lastName = comments[indexPath.row].owner?.lastName,
               
                 let pictureURL = URL(string: picture),
                 let pic = try? Data(contentsOf: pictureURL){
                    
                cell.imageProfile.image = UIImage(data: pic)
                cell.FLname.text = ("\(firstName) \(lastName)")
            }
            
            let comment = comments[indexPath.row]
        
            cell.date.text = comment.publishDate
            cell.commentPost.text = comment.message
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130
        
}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NextComment") as? NextComment {
            
            if let headerImageX = self.headerImage,
               let img = try? Data(contentsOf: URL(string: headerImageX)!),
               let image = UIImage(data: img),
               
               let HeadernameF = self.nameF,
               let HeadernameL = self.nameL,
               
               let textLabel = self.Labeltext
      
            
            {
                view.labelText.text = textLabel
                view.imagePosts.image = image
                view.nameFL.text = ("\(HeadernameF) \(HeadernameL)")

            }
            
            return view
        }
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }


}
