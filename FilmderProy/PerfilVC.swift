//
//  PerfilVC.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 11/4/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit

class PerfilVC: UIViewController {

    
    @IBOutlet weak var tfNombres: UITextField!
    
    @IBOutlet weak var tfApellidos: UITextField!
    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var tfFecha: UITextField!
    @IBAction func btnCerrarSesion(_ sender: Any) {
        
        DataBaseManager.sharedInstance.deletePeliTable()
        
        UserDefaults.standard.removeObject(forKey: "id_sesion")
        
        let c = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.present(c,animated: true,completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let id = UserDefaults.standard.object(forKey: "id_sesion") as! Int

        let url: String = Constantes.BASE_URL+"usuarios/\(id)"
        
        if(NetworkManager.isConnectedToNetwork()){
            
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: nil, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    print(result)
                    
                    if(result == 1){
                        
                        let data = response["data"] as? NSDictionary
                        
                        let nombre = data?["nombre"] as! String
                        
                        let apellido = data?["apellido"] as! String
                        
                        let correo = data?["correo"] as! String
                        
                        let fecha = data?["nacimiento"] as! String
                        
                        self.tfNombres.text = nombre
                        self.tfApellidos.text = apellido
                        self.tfCorreo.text = correo
                        self.tfFecha.text = fecha
                        
                        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
