//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Ali Berkay BERBER on 5.03.2023.
//

import UIKit

class FeedViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.likeLabel.text = "0"
        cell.commentLabel.text = "My comment"
        cell.userEmailLabel.text = "user@email.com"
        cell.userImageView.image = UIImage(named: "selectImage.png")
        return cell
    }
    
    
}
