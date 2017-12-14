//
//  RecuperarContrasenaViewController.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 11/1/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit

class RecuperarContrasenaViewController: UIViewController {

    
    @IBOutlet weak var btnEnviarCorreo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //----------------
        //GRAFICA
        //----------------
        
        //btn Enviar Correo.
        
        self.btnEnviarCorreo.layer.cornerRadius = 10
        self.btnEnviarCorreo.layer.borderWidth = 3
        self.btnEnviarCorreo.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBOutlet weak var tfCorreo: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnEnviarCorreo(_ sender: Any) {
        
        print("Si")
        
        let correo = tfCorreo.text
        
        print(correo as String!)
        let url: String = Constantes.BASE_URL + "usuarios/recuperar-contrasena/" + correo!
        
        
        if(NetworkManager.isConnectedToNetwork()){
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: nil, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    print(result)
                    
                    if(result == 1 ){
                        
                        Utils.utils.showAlert(mensaje: "Mensaje enviado exitosamente, revisa tu correo", uIViewController: self)
                        
                        self.tfCorreo.text = ""
                        
                    }else{
                        Utils.utils.showAlert(mensaje: "El correo no existe", uIViewController: self)
                    }
                    
                    
                    
                }else{
                    Utils.utils.showAlert(mensaje: "No se pudo conectar correctamente", uIViewController: self)
                }
            }, method: .get)
        }else{
            Utils.utils.showAlert(mensaje: "No se logró conectar a Internet, saludos.", uIViewController: self)
        }
        

        
        
    }
    //Accion
    /*@IBAction func pressOlvideMiClave(_ sender: Any) {
        
        print("Entro al accion")
        //let correo = tfCorreo.text
        
        print(correo as String!)
        let url: String = Constantes.BASE_URL + "usuarios/recuperar-contrasena/" + correo!
        
        
        if(NetworkManager.isConnectedToNetwork()){
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: nil, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    print(result)
                    
                    if(result == 1 ){
                        
                        Utils.utils.showAlert(mensaje: "Mensaje enviado exitosamente, revisa tu correo", uIViewController: self)
                        
                    }else{
                        Utils.utils.showAlert(mensaje: "El correo no existe", uIViewController: self)
                    }
                    
                    
                    
                }else{
                    Utils.utils.showAlert(mensaje: "No se pudo conectar correctamente", uIViewController: self)
                }
            }, method: .get)
        }else{
            Utils.utils.showAlert(mensaje: "No se logró conectar a Internet, saludos.", uIViewController: self)
        }

    }*/

}
