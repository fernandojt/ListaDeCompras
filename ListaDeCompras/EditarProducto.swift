//
//  EditarProducto.swift
//  ListaDeCompras
//
//  Created by Fernando Jt on 7/4/18.
//  Copyright © 2018 Fernando Jumbo Tandazo. All rights reserved.
//

import UIKit
import CoreData

class EditarProducto: UIViewController {

    var productoEditar : Listas!
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var estado: UISwitch!
    @IBOutlet weak var cantidad:UITextField!
    
    func conexion() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.text = productoEditar.nombreProducto
        cantidad.text = "\(productoEditar.cantidad)"
        if productoEditar.estadoProducto{
            estado.isOn = true
        }else{
            estado.isOn = false
        }
       
    }

   
    @IBAction func guardar(_ sender: UIButton) {
        
        let contexto = conexion()
        
        let cantidadProducto = Int16(cantidad.text!)
        productoEditar.setValue(nombre.text, forKey: "nombreProducto")
        productoEditar.setValue(cantidadProducto, forKey: "cantidad")
       productoEditar.setValue(estado.isOn, forKey: "estadoProducto")
        
        do {
            try contexto.save()
            performSegue(withIdentifier: "enviarTabla", sender: self)
            
        } catch let error as NSError {
            print("no guardo",error)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  

}
