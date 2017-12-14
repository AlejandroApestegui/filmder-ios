//
//  PeliculaCardListViewController.swift
//  FilmderProy
//
//  Created by Alejandro Apestegui on 11/22/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit
import Koloda
import pop

private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

class PeliculaCardListViewController: UIViewController {
    
    @IBOutlet weak var kvPeliculas: PeliculaCard!
    
    var peliculas:NSMutableArray=[]
        var idPelicula : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = UserDefaults.standard.object(forKey: "id_sesion") as! Int

        let url: String = Constantes.BASE_URL+"peliculas/faltantes/\(id)"
        
        NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: nil, completion: { (finished, response) in
            if(finished){
                let d = response["data"] as! NSArray
                self.peliculas = NSMutableArray(array: d)
                
                self.kvPeliculas.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
                self.kvPeliculas.countOfVisibleCards = 1
                self.kvPeliculas.delegate = self
                self.kvPeliculas.dataSource = self
                self.kvPeliculas.animator = PeliculaBackgroundAnimator(koloda: self.kvPeliculas)
                self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                
            }else{
            }
        }, method: .get)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func leftButtonTapped(_ sender: Any) {
        kvPeliculas?.swipe(.left)
    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        kvPeliculas?.swipe(.right)
    }
    @IBAction func onDislike(_ sender: Any) {
        if(peliculas.count==0){
            Utils.utils.showAlert(mensaje: "Ya no hay mas peliculas", uIViewController: self)
            return
        }

        kvPeliculas?.swipe(.left)
    }
    
    @IBAction func OnLike(_ sender: Any) {
        if(peliculas.count==0){
            Utils.utils.showAlert(mensaje: "Ya no hay mas peliculas", uIViewController: self)
            return
        }
        
        kvPeliculas?.swipe(.right)
    }
    
    func match(match:Int){
        
        let id = UserDefaults.standard.object(forKey: "id_sesion") as! Int
        
        var param = Dictionary<String, AnyObject>()
        
        let p = peliculas[idPelicula] as! Dictionary<String,AnyObject>
        
        param ["pelicula"] = p["id"] as AnyObject
        param ["usuario"] =  id as AnyObject
        param ["matched"] =  match as AnyObject
        
        let url: String = Constantes.BASE_URL+"matches/registrar"
        
        if(NetworkManager.isConnectedToNetwork()){
            
            NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: param, completion: { (finished, response) in
                
                if(finished){
                    
                    let result = response["result"] as! Int
                    
                    if(result == 1){
                        print("matchado.")
                        if(match==0){
                            self.guardar()
                        }
                        
                        //self.peliculas.remove(p)
                        //self.kvPeliculas.reloadData()
                        
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
    
    func guardar() {
        
        let p = peliculas[idPelicula] as! Dictionary<String,AnyObject>
        
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
        a.agregado = true
        
        DataBaseManager.sharedInstance.savePeliculaDataBaseChanges()
        print("Pelicula -> "+a.titulo!+" (guardada)")
        
        
        
    }
    
    
}
extension PeliculaCardListViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kvPeliculas.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        DetallePeliculaVC.pelicula = peliculas[index] as! Dictionary<String,AnyObject>
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetallePeliculaVC") as! DetallePeliculaVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        if(peliculas.count>0){
            if(direction==SwipeResultDirection.right){
                self.match(match: 0)
            }
            else if(direction == SwipeResultDirection.left){
                self.match(match: 1)
            }
            
        }else{
            
            Utils.utils.showAlert(mensaje: "Ya no hay mas peliculas", uIViewController: self)
        }
        
        
        
    }
}

extension PeliculaCardListViewController: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return self.peliculas.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        //print(index)
        
        idPelicula = index - 1
        
        let peli:NSDictionary = self.peliculas[index] as! NSDictionary
        
        let nom = peli["url_portada"] as! String
        
      //  print(nom)
        
        let url:NSURL? = NSURL(string: nom)
        let data:NSData? = NSData(contentsOf : url! as URL)
        
        if(data == nil) {
            return UIImageView()
        }
        
        let imagen = UIImage(data : data! as Data)
        
        return UIImageView(image : imagen)
        
    }
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("PeliculaCard", owner: self, options: nil)?[0] as? OverlayView
    }
    
}

