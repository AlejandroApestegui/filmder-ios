//
//  PeliculaCardOverylay.swift
//  FilmderProy
//
//  Created by Alejandro Apestegui on 11/22/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import Foundation
import UIKit
import Koloda

private let overlayRightImageName = "overlay_like"
private let overlayLeftImageName = "overlay_skip"

class PeliculaCardOverlay : OverlayView{
    
    @IBOutlet lazy var imgPelicula: UIImageView! = {
        [unowned self] in
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        return imageView
        }()
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            switch overlayState {
            case .left? :
                imgPelicula.image = UIImage(named: overlayLeftImageName)
            case .right? :
                imgPelicula.image = UIImage(named: overlayRightImageName)
            default:
                imgPelicula.image = nil
            }
            
        }
    }
}
