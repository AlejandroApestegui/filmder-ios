//
//  Utils.swift
//  FilmderProy
//
//  Created by Alejandro Apestegui on 11/22/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    
    static var utils:Utils = Utils()
    
    func showAlert(mensaje:String, uIViewController:UIViewController){
        
        let alerta  = UIAlertController(title: "Mensaje", message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
        alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        uIViewController.present(alerta, animated: true, completion: nil)
    }
    
}
