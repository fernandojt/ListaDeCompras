//
//  ViewController.swift
//  ListaDeCompras
//
//  Created by Fernando Jt on 6/4/18.
//  Copyright © 2018 Fernando Jumbo Tandazo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    func conexion() ->NSManagedObjectContext{
        let delegate  = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.popToRootViewController(animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func mostrar(_ sender: UIButton) {
        
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Listas> = Listas.fetchRequest()
        
        do {
            
            let resultados = try contexto.fetch(fetchRequest)
            print("numero de registros = \(resultados.count)")
            
            for res in resultados as [NSManagedObject] {
                let nombreProducto = res.value(forKey: "nombreProducto")
                let cantidad = res.value(forKey: "cantidad")
                let estadoProducto = res.value(forKey: "estadoProducto")
                print("nombre: \(nombreProducto!) - cantidad: \(cantidad!) - estado: \(estadoProducto!)")
            }
        } catch let error as NSError {
            print("no mostró",error)
        }
    }
    
    
    
    @IBAction func borrar(_ sender: UIButton) {
        let contexto = conexion()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Listas")
        let borrar = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try contexto.execute(borrar)
            print("Registros eliminados")
        } catch let error as NSError {
            print("No mostro nada",error)
        }
    }
    
    

}

