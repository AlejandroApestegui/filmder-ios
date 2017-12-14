//
//  Pelicula+CoreDataProperties.swift
//  
//
//  Created by Italo Contreraz on 12/3/17.
//
//

import Foundation
import CoreData


extension Pelicula {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pelicula> {
        return NSFetchRequest<Pelicula>(entityName: "Pelicula")
    }

    @NSManaged public var actores: String?
    @NSManaged public var censura: Int16
    @NSManaged public var director: String?
    @NSManaged public var duracion: Int16
    @NSManaged public var fechaEstreno: String?
    @NSManaged public var genero: String?
    @NSManaged public var id: Int16
    @NSManaged public var productora: String?
    @NSManaged public var sinopsis: String?
    @NSManaged public var titulo: String?
    @NSManaged public var urlPortada: String?
    @NSManaged public var urlTrailer: String?
    @NSManaged public var agregado: Bool

}
