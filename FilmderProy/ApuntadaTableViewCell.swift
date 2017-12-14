//
//  ApuntadaTableViewCell.swift
//  FilmderProy
//
//  Created by Alejandro Apestegui on 12/6/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit

class ApuntadaTableViewCell: UITableViewCell {
    
    var data:Pelicula!
    @IBOutlet weak var lblTitulo: UILabel!
    var id:Int16!;

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func initCell(){
        self.lblTitulo.text = self.data.titulo
        self.id = self.data.id;
    }
    
    @IBAction func borrar(_ sender: Any) {
        
        let id = UserDefaults.standard.object(forKey: "id_sesion") as! Int
        
        var param = Dictionary<String, AnyObject>()
        
        param ["pelicula"] = self.id as AnyObject
        param ["usuario"] =  id as AnyObject
        
        let url: String = Constantes.BASE_URL+"matches/actualizar"
        
        if(NetworkManager.isConnectedToNetwork()){
            
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: param, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    if(result == 1){
                        
                        let pelicula:Pelicula = DataBaseManager.sharedInstance.getPeliById(attribute: "id", value: self.id as AnyObject)
                        DataBaseManager.sharedInstance.deletePeli(p: pelicula)
                        ApuntadasVC.vc.listar()
                        
                    }else{
                        print(response["message"] as! String)
                    }
                    
                }else{
                    print("Error en la conexión")
                }
            }, method: .post)
        }else{
            print("No hay una conexión a internet")
        }
        
    }
}
