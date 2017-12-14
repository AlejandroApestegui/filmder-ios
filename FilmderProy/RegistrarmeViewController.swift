//
//  RegistrarmeViewController.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 11/1/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit

class RegistrarmeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var lstSexo: [String] = ["Masculino","Femenino"]
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtApellido: UITextField!
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtContrasena: UITextField!
    
    @IBOutlet weak var txtFecha: UIDatePicker!
    
    @IBOutlet weak var txtSexo: UIPickerView!
    
    @IBOutlet weak var btnRegistrarme: UIButton!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.lstSexo[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // btn Entrar
        //self.txtSexo.dataSource = self
        //self.txtSexo.delegate = self
        self.btnRegistrarme.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressRegistrarme(_ sender: Any) {
        
        let formato = DateFormatter()
        formato.dateFormat = "yyyy/MM/dd"
        
        let nacimiento = formato.string(from: txtFecha.date)
        
        let nombre = txtNombre.text
        let apellido = txtApellido.text
        let correo = txtCorreo.text
        let contrasena = txtContrasena.text
        
        let genero = 0
        
        var param = Dictionary<String, AnyObject>()
        
        param ["nombre"] = nombre as AnyObject
        param ["apellido"] = apellido as AnyObject
        param ["correo"] = correo as AnyObject
        param ["contrasena"] = contrasena as AnyObject
        param ["nacimiento"] = nacimiento as AnyObject
        param ["genero"] = genero as AnyObject

        
        let url: String = Constantes.BASE_URL + "usuarios/registrar"
        
        if(NetworkManager.isConnectedToNetwork()){
            
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: param, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    if(result == 1){
                        Utils.utils.showAlert(mensaje: "Registrado correctamente", uIViewController: self)
                        
                        self.txtNombre.text = ""
                        self.txtApellido.text = ""
                        self.txtCorreo.text = ""
                        self.txtContrasena.text = ""
                        
                        
                    }else{
                        Utils.utils.showAlert(mensaje: "Error al registrar", uIViewController: self)
                    }
                    
                    print(result)
                    
                }else{
                    // error de conexion
                }
            }, method: .post)
        }else{
            // debo indicar que no hay internet
        }
    }
    

}
