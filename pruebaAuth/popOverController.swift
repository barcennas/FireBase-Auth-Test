//
//  popOverController.swift
//  pruebaAuth
//
//  Created by Abraham Barcenas M on 10/19/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KVNProgress

class popOverController: UIViewController {
    
    @IBOutlet var lblTitulo: UITextField!
    @IBOutlet var lblContenido: UITextField!
    
    let databaseRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPost(_ sender: UIButton) {
        let title = lblTitulo.text
        let content = lblContenido.text
        
        if let title = title , let content = content {
            
            let post : [String : String] = ["Title" : title,
                                            "Content" : content]
            
            self.databaseRef.child("Posts").childByAutoId().setValue(post)
            
        }else{
            KVNProgress.show(withStatus: "Oops, parece que dejaste un campo vacio")
        }
        
        dismiss(animated: true, completion: nil)
        //self.tableView.reloadData()
        
    }

}
