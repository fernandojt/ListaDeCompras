//
//  TablaProductos.swift
//  ListaDeCompras
//
//  Created by Fernando Jt on 7/4/18.
//  Copyright © 2018 Fernando Jumbo Tandazo. All rights reserved.
//

import UIKit
import CoreData

class TablaProductos: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var listas : [Listas] = []
    @IBOutlet weak var tabla: UITableView!
    
    func conexion() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.reloadData()
        tabla.delegate = self
        tabla.dataSource = self
        mostrarDatos()
        
    }

    //num, num, cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let lista = listas[indexPath.row]
        
        
        if lista.estadoProducto {
            cell.textLabel?.text = "✅ \(lista.nombreProducto!)"
            cell.detailTextLabel?.text = "\(lista.cantidad)"
        }else{
            cell.textLabel?.text = "❌ \(lista.nombreProducto!)"
            cell.detailTextLabel?.text = "\(lista.cantidad)"
            
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "enviarEditar", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviarEditar"{
            if let id = tabla.indexPathForSelectedRow{
                let fila =  listas[id.row]
                let destino  = segue.destination as! EditarProducto
                destino.productoEditar = fila
            }
        }
        
       
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let contexto = conexion()
        let lista = listas[indexPath.row]
        
        if editingStyle == .delete{
            contexto.delete(lista)
            
            do {
                try contexto.save()
            }catch let error as NSError {
                print("no borro nada",error)
            }
        }
        
        mostrarDatos()
        tabla.reloadData()
    }
    
    
//funciones
    
    func mostrarDatos(){
        
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Listas> = Listas.fetchRequest()
        
        do {
            listas =  try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("no mostro nada", error)
        }
        
    }
}
