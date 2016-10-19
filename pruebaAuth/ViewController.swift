//
//  ViewController.swift
//  pruebaAuth
//
//  Created by Abraham Barcenas M on 10/13/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var txtUsuario: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsuario.delegate = self
        txtPassword.delegate =  self
        self.hideKeyboardWhenTap()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hace que cuando le orpimas al boton enter en el teclado se esconda el teclado
        textField.resignFirstResponder()
        return true
    }

    func hideKeyboardWhenTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        //oculta el teclado cuando se presiona cualquier lugar de la pantalla afuera del teclado
        view.endEditing(true)
    }
    
    @IBAction func CreateUser(_ sender: UIButton) {
        
        let user = txtUsuario.text
        let password = txtPassword.text
        
        KVNProgress.show(withStatus: "Verificando")
        
        FIRAuth.auth()?.createUser(withEmail: user!, password: password!, completion: { (user, error) in
            
            if error != nil {
                self.login()
            }else{
                print("User Created")
                /*let alert = UIAlertController(title: "Exito", message: "Usuario creado correctamente", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)*/
                
                KVNProgress.showSuccess(withStatus: "Exito, usuario creado exitosamente")
                
                self.login()
            }
        })
    }
    
    func login(){
        FIRAuth.auth()?.signIn(withEmail: txtUsuario.text!, password: txtPassword.text!, completion: { (user, error) in
            
            if error != nil {
                print("Incorrect password")
                /*let alert = UIAlertController(title: "Oops", message: "Usuario/Contraseña incorrecta", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)*/
                KVNProgress.showError(withStatus: "Error, Usuario/Contraseña incorrecta")
            }else{
                print("Hecho")
                /*let alert = UIAlertController(title: "Exito", message: "Te has logueado", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(okAction)*/
                KVNProgress.showSuccess(withStatus: "Nos da gusto volver a verte", completion: { 
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                })
                //self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        })
    }
    
    @IBAction func logout(segue: UIStoryboardSegue){
        KVNProgress.show()
        do{
            try FIRAuth.auth()?.signOut()
            txtUsuario.text = ""
            txtPassword.text = ""
            KVNProgress.showSuccess(withStatus: "Te esperamos pronto 👋🏻")
            
        } catch {
            KVNProgress.showError(withStatus: "Oops Ocurrio un error en el proceso, intente mas tarde")
            performSegue(withIdentifier: "loginSegue", sender: segue)
            
        }
    }
    
    
}

