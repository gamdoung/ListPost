//
//  ViewController.swift
//  Posts
//
//  Created by Gam Doung on 23/2/2564 BE.
//

import UIKit
import Foundation

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var posts: [DummyPost] = []
    var post: DummyPost?
    var comments: [DummyComment] = []
    var comment: DummyComment?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        
        Network.getPosts{[weak self] (result) in
            if let post = result?.posts{
                self?.posts = post
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? TableViewController{
            if let indexPath = tableView.indexPathForSelectedRow{
                nextVC.id = posts[indexPath.item].id
                nextVC.headerImage = posts[indexPath.item].image
                nextVC.nameF = posts[indexPath.item].owner?.firstName
                nextVC.nameL = posts[indexPath.item].owner?.lastName
                nextVC.Labeltext = posts[indexPath.item].text

                
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
        
        if let image = posts[indexPath.row].image,
           let picture = posts[indexPath.row].owner?.picture,
           let firstName = posts[indexPath.row].owner?.firstName,
           let lastName = posts[indexPath.row].owner?.lastName,
           let likes = posts[indexPath.row].likes,
           
           let picURL = URL(string: picture),
           let imageURL = URL(string: image),
           
           let img = try? Data(contentsOf: imageURL),
           let pic = try? Data(contentsOf: picURL){

            cell.numlikes.text = ("\(likes)")
            cell.imgURL.image = UIImage(data: img)
            cell.imgProfile.image = UIImage(data: pic)
            cell.FNlabel.text = ("\(firstName) \(lastName)")
                        
          }
            let post = posts[indexPath.row]
            cell.email.text = post.owner?.email
            cell.labelText.text = post.text
            cell.date.text = post.publishDate
        
        return cell
        
       }
        return UITableViewCell()
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 400
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTableView2", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

