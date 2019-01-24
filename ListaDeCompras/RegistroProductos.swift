//
//  RegistroProductos.swift
//  ListaDeCompras
//
//  Created by Fernando Jt on 6/4/18.
//  Copyright © 2018 Fernando Jumbo Tandazo. All rights reserved.
//

import UIKit
import CoreData

class RegistroProductos: UIViewController{

    @IBOutlet weak var nombreProducto: UITextField!
    
    @IBOutlet weak var cantidad: UITextField!
    
    @IBOutlet weak var estado: UISwitch!
    
    
    
    func conexion() ->NSManagedObjectContext{
        let delegate  = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
        
    }
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
     
    }

   
    
    @IBAction func guardar(_ sender: UIButton) {
        
        if nombreProducto.text == "" || cantidad.text == "" {
            let alerta = UIAlertController(title: "Alerta", message: "Tiene que llenar todos los campos", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alerta.addAction(ok)
            present(alerta, animated: true, completion: nil)
        }else{
            
        let contexto = conexion()
        let entidadListas = NSEntityDescription.entity(forEntityName: "Listas", in: contexto)
        let newLista = NSManagedObject(entity: entidadListas!, insertInto: contexto)
        let cantidadProducto = Int16(cantidad.text!)
        newLista.setValue(nombreProducto.text, forKey: "nombreProducto")
        newLista.setValue(cantidadProducto, forKey: "cantidad")
        newLista.setValue(estado.isOn, forKey: "estadoProducto")
        
        do {
            try contexto.save()
            print("guardo")
            nombreProducto.text = ""
            cantidad.text = ""
            estado.isOn = false
        } catch let error as NSError {
            print("no guardo",error)
        }
        
        }
        
        let alerta = UIAlertController(title: "Aviso", message: "Guardo con exito", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        alerta.addAction(ok)
        present(alerta, animated: true, completion: nil)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
