//
//  ViewController.swift
//  pruebaAuth
//
//  Created by Abraham Barcenas M on 10/13/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var txtUsuario: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func CreateUser(_ sender: UIButton) {
        
        let user = txtUsuario.text
        let password = txtPassword.text
        
        
        FIRAuth.auth()?.createUser(withEmail: user!, password: password!, completion: { (user, error) in
            
            if error != nil {
                self.login()
            }else{
                print("User Created")
                let alert = UIAlertController(title: "Exito", message: "Usuario creado correctamente", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
                self.login()
            }
        })
    }
    
    func login(){
        FIRAuth.auth()?.signIn(withEmail: txtUsuario.text!, password: txtPassword.text!, completion: { (user, error) in
            
            if error != nil {
                print("Incorrect password")
                let alert = UIAlertController(title: "Oops", message: "Usuario/Contraseña incorrecta", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                print("Hecho")
                /*let alert = UIAlertController(title: "Exito", message: "Te has logueado", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(okAction)*/
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        })
    }
    
    
}

