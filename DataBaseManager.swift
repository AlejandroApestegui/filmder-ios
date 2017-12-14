//
//  DataBaseManager.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 12/3/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import Foundation
import MagicalRecord

class DataBaseManager{

    static let sharedInstance = DataBaseManager()
    
    func createPeli() -> Pelicula {
    
        let p = Pelicula.mr_createEntity()
        p?.id = -1
        p?.actores = ""
        p?.censura = -1
        p?.director = ""
        p?.fechaEstreno = ""
        p?.genero = ""
        p?.productora = ""
        p?.sinopsis = ""
        p?.titulo = ""
        p?.urlPortada = ""
        p?.urlTrailer = ""
        p?.agregado = false
        
        self.savePeliculaDataBaseChanges()
        
        return p!
    }
    
    
    func savePeliculaDataBaseChanges() {
        
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        
    }
    
    func getPeliArray() -> NSArray {
        let array: NSArray = Pelicula.mr_findAll()! as NSArray
        return array
    }
    
    func getPeliById(attribute: String, value: AnyObject) -> Pelicula {
        let a = Pelicula.mr_find(byAttribute: attribute, withValue: value)
        
        return a![0] as! Pelicula
    }
    
    func getPelisAgregadas() -> NSArray {
        let array: NSArray = Pelicula.mr_findAll()! as NSArray
        
        return array

    }
 
    
    func deletePeli(p:Pelicula){
        p.mr_deleteEntity()
        self.savePeliculaDataBaseChanges()
    }
    
    func deletePeliTable(){
        Pelicula.mr_truncateAll()
        self.savePeliculaDataBaseChanges()
    }

    
}
