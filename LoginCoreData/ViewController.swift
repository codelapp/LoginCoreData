import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    func conexion()->NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func entrar(_ sender: UIButton) {
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Login> = Login.fetchRequest()
        let predicado = NSPredicate(format: "user == %@ AND pass == %@", user.text!, pass.text!)
        fetchRequest.predicate = predicado
        
        do {
            let resultado = try contexto.fetch(fetchRequest)
            
            if resultado.count == 1 {
                performSegue(withIdentifier: "entrar", sender: self)
            }else{
                print("no entro")
            }
            
        } catch let error as NSError {
            print("hubo un error en el login", error)
        }
        
    }
    
    @IBAction func registrar(_ sender: UIButton) {
        let contexto = conexion()
        
        let entityLogin = NSEntityDescription.entity(forEntityName: "Login", in: contexto)
        let newLogin = NSManagedObject(entity: entityLogin!, insertInto: contexto)
        
        newLogin.setValue("pepe", forKey: "user")
        newLogin.setValue("1234", forKey: "pass")
        
        do {
            try contexto.save()
            print("guardo correctamente")
        } catch let error as NSError {
            print("error al guardar", error)
        }
        
    }
    
    
    @IBAction func mostrar(_ sender: UIButton) {
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Login> = Login.fetchRequest()
        
        do {
            
            let resultados = try contexto.fetch(fetchRequest)
            
            print("numero de registros= \(resultados.count)")
            
            for res in resultados as [NSManagedObject] {
                let user = res.value(forKey: "user")
                let pass = res.value(forKey: "pass")
                print("User: \(user!) - Pass: \(pass!)")
            }
            
        } catch let error as NSError  {
            print("no mostro nada", error)
        }

    }
    
    
    
}












