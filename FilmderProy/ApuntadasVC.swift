//
//  ApuntadasVC.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 11/4/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import UIKit

class ApuntadasVC: UIViewController {
    
    
    @IBOutlet weak var tvApuntadas: UITableView!
    var lstApuntadas: NSMutableArray = []
    static var vc:ApuntadasVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listar()
        ApuntadasVC.vc = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listar()
    }
    
    func listar(){
        self.lstApuntadas = NSMutableArray(array: DataBaseManager.sharedInstance.getPeliArray())
        self.tvApuntadas.reloadData()

    }

}
extension ApuntadasVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstApuntadas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ApuntadaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ApuntadaTableViewCell", for: indexPath) as! ApuntadaTableViewCell
        cell.data = self.lstApuntadas[indexPath.row] as! Pelicula
        cell.initCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


