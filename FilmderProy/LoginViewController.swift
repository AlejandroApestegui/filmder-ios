//
//  LoginViewController.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 11/1/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //Botones
    @IBOutlet weak var btnEntrar: UIButton!
    
    @IBOutlet weak var btnRegistrar: UIButton!
    
    @IBOutlet weak var btnOlvideContrasena: UIButton!
    
    //TextFilds
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtContrasena: UITextField!
    
    var peliculas:NSArray=[]

    override func viewWillAppear(_ animated: Bool) {
        if(UserDefaults.standard.object(forKey: "id_sesion") != nil){
            
            let c = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
            c.selectedViewController = c.viewControllers? [1]
            
            self.present(c,animated: true,completion: nil)
            
            return
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //GRAFICA
        //----------------
        
        //txtCorreo.text = "alejandro.apestegui@gmail.com"
        
        //txtContrasena.text = "12345"
        
        //btn entrar
        self.btnEntrar.layer.cornerRadius = 10
        
        //btn registrar
        self.btnRegistrar.layer.cornerRadius = 10
        self.btnRegistrar.layer.borderWidth = 3
        self.btnRegistrar.layer.borderColor = UIColor.white.cgColor
        
        self.navigationItem.title = "Bienvenido"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-----------------------
    //Transición de Pantallas
    //-----------------------
    
    @IBAction func btnOlvideContrasenaAction(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecuperarContrasenaViewController") as! RecuperarContrasenaViewController
        
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func btnRegistrarAction(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegistrarmeViewController") as! RegistrarmeViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    //-----------------------
    //Login
    //-----------------------
    @IBAction func btnEntrarAction(_ sender: Any) {
        
        let correo = txtCorreo.text
        let contrasena = txtContrasena.text
        
        // Servicios:
        var param = Dictionary<String, AnyObject>()
        
        param ["correo"] = correo as AnyObject
        param ["contrasena"] = contrasena as AnyObject
        
        
        let url: String = Constantes.BASE_URL+"usuarios/login"
        
        if(NetworkManager.isConnectedToNetwork()){
            
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: param, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    
                    if(result == 1){
                    
                        
                        let data = response["data"] as? NSDictionary
                        
                        let id = data?["id"] as! Int
                        
                        
                       self.traerPeliculas(id: id)
                        
                        
                        //user default
                        
                        UserDefaults.standard.set(id, forKey: "id_sesion")
                        UserDefaults.standard.synchronize()
                        
                        
                        let c = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
                        c.selectedViewController = c.viewControllers? [1]
                        
                        self.present(c,animated: true,completion: nil)
                        
                    }else{
                        Utils.utils.showAlert(mensaje: response["message"] as! String, uIViewController: self)
                    }
                    
                }else{
                    Utils.utils.showAlert(mensaje: "Error en la conexión", uIViewController: self)                }
            }, method: .post)
        }else{
            Utils.utils.showAlert(mensaje: "No hay tiene una conexión a internet", uIViewController: self)
        }
       
    }
    
    func traerPeliculas(id: Int){
        
        let url: String = Constantes.BASE_URL+"peliculas/agregadas/\(id)"
        
        if(NetworkManager.isConnectedToNetwork()){
            
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: nil, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    
                    if(result == 1){
                        
                        let data = response["data"] as! NSArray
                        
                        self.peliculas = NSArray(array: data)
                        
                        for i in 0 ..< self.peliculas.count {
                            
                            var p = self.peliculas[i] as! Dictionary<String,AnyObject>
                        
                            let a: Pelicula = DataBaseManager.sharedInstance.createPeli()
                        
                            a.id            = p["id"] as! Int16
                            a.actores       = p["actores"] as? String
                            a.censura       = p["censura"] as! Int16
                            a.director      = p["director"] as? String
                            a.duracion      = p["duracion"] as! Int16
                            a.fechaEstreno  = p["fecha_estreno"] as? String
                            a.genero        = p["genero"] as? String
                            a.productora    = p["productora"] as? String
                            a.sinopsis      = p["sinopsis"] as? String
                            a.titulo        = p["titulo"] as? String
                            a.urlPortada    = p["url_portada"] as? String
                            a.urlTrailer    = p["url_trailer"] as? String
                        
                            DataBaseManager.sharedInstance.savePeliculaDataBaseChanges()
                        
                        }
                        //print(data)
                        
                        //let data = response["data"] as! Dictionary<String,AnyObject>;()
                    
                    
                        
                    }else{
                        Utils.utils.showAlert(mensaje: response["message"] as! String, uIViewController: self)
                    }
                    
                }else{
                    Utils.utils.showAlert(mensaje: "Error en la conexión", uIViewController: self)                }
            }, method: .get)
        }else{
            Utils.utils.showAlert(mensaje: "No hay tiene una conexión a internet", uIViewController: self)
        }

        
    }

}
