//
//  TableViewController.swift
//  pruebaAuth
//
//  Created by Abraham Barcenas M on 10/17/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KVNProgress

struct postStruct {
    let title : String!
    let content : String!
}

class TableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    let databaseRef = FIRDatabase.database().reference()
    
    var posts : [postStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddPopup))
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        self.databaseRef.child("Posts").queryOrderedByKey().observe(FIRDataEventType.childAdded, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let title = value?["Title"] as! String
            let content = value?["Content"] as! String
            
            self.posts.insert(postStruct(title: title, content: content), at: 0)
            self.tableView.reloadData()
        })
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPopover" {
            let popoverViewController = segue.destination as UIViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    func addItem(){
        let title = "Title"
        let content = "Content"
    
        let post : [String : String] = ["Title" : title,
                                        "Content" : content]
        
        
        self.databaseRef.child("Posts").childByAutoId().setValue(post)
        
        //self.posts.insert(postStruct(title: title, content: content), at: 0)
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let lblTexto = cell.viewWithTag(1) as! UILabel
        let lblContent = cell.viewWithTag(2) as! UILabel

        lblTexto.text = posts[indexPath.row].title
        lblContent.text = posts[indexPath.row].content
        
        return cell
    }

}
