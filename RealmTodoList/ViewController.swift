
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactTableView: UITableView!
    
    var contactArray = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configration()
        print(contactArray)
    }
    
    @IBAction func addContactButtonTapped(_ sender: Any) {
        contactConfig(isAdd: true, index: 0)
    }
    
    func contactConfig(isAdd:Bool,index:Int){
        let alertController = UIAlertController(title: isAdd ? "Add Contact" : "Update Contact", message: isAdd ? "Please Add Contact" : "Please Update Contact", preferredStyle:  .alert)
        
        let save = UIAlertAction(title: isAdd ? "Save":"Update", style: .default){ _ in
            if alertController.textFields?.first?.text == "" && alertController.textFields?[1].text=="" {
                print("Invalid")
            }
            else{
                if let firstName = alertController.textFields?.first?.text,
                   let lastName = alertController.textFields?[1].text{
                    print("\(firstName) \(lastName)")
                    let contact = Contact(firstName: firstName, lastName: lastName)
                    if isAdd{
                        self.contactArray.append(contact)
                        DatabaseHelper.shared.saveContact(contact: contact)
                        self.contactTableView.reloadData()
                    }else{
                        //self.contactArray[index] = contact
                        DatabaseHelper.shared.updateContact(oldContact: self.contactArray[index], newContact: contact)
                        self.contactTableView.reloadData()
                    }
                }
            }
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { firstNameField in
            firstNameField.placeholder = isAdd ? "Enter Your First Name":self.contactArray[index].firstName
        }
        
        alertController.addTextField { lastNameField in
            lastNameField.placeholder = isAdd ? "Enter Your Last Name":self.contactArray[index].lastName
        }
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}



extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
       
        cell?.textLabel?.text = "\(contactArray[indexPath.row].firstName) \(contactArray[indexPath.row].lastName)"
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit"){ _,_,_ in
            self.contactConfig(isAdd: false, index: indexPath.row)
        }
        edit.backgroundColor = .systemOrange
        
        let delete = UIContextualAction(style: .destructive, title: "Delete"){_,_,_ in
            DatabaseHelper.shared.deleteContact(contact: self.contactArray[indexPath.row])
            self.contactArray.remove(at: indexPath.row)
            self.contactTableView.reloadData()
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [delete,edit])
        return swipeConfig
    }
    
}

extension ViewController{
    func configration() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        contactTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contactArray = DatabaseHelper.shared.getAllContacts()
    }
}
