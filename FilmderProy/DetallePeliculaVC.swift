//
//  DetallePeliculaVC.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 11/4/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit
import SDWebImage

class DetallePeliculaVC: UIViewController {

   static var pelicula:Dictionary<String,AnyObject>!
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblSinopsis: UILabel!
    @IBOutlet weak var imgPortada: UIImageView!
    @IBOutlet weak var lblGenero: UILabel!
    @IBOutlet weak var lblDuracion: UILabel!
    @IBOutlet weak var lblReparto: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblProductora: UILabel!
    @IBOutlet weak var wvTrailer: UIWebView!
    var id:Int32!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pel = DetallePeliculaVC.pelicula!;
        
        self.id = pel["id"] as! Int32
        self.lblTitulo.text = pel["titulo"] as! String
        self.lblSinopsis.text = "Sinopsis : " + (pel["sinopsis"] as! String)
        self.lblGenero.text = "Género : " + (pel["genero"] as! String)
        self.lblDuracion.text = "Duración : " + String(pel["duracion"] as! Int32)+(" mins.")
        self.lblProductora.text = "Productora : " + (pel["productora"] as! String)
        let url = pel["url_portada"] as! String
        self.imgPortada.sd_setImage(with: URL(string: url))
        self.lblReparto.text = "Actores : " + (pel["actores"] as! String)
        self.lblDirector.text = "Director : " + (pel["director"] as! String)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func volver(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
