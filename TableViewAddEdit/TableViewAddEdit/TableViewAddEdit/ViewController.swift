//
//  ViewController.swift
//  TableViewAddEdit
//
//  Created by Iphone XR on 10/12/22.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Create tableview
    private let  tableview:UITableView  = {
        let tableview = UITableView()
        tableview.frame = CGRect(x: 0, y: 100, width: 500, height: 600)
        tableview.register(TableViewCell.self,forCellReuseIdentifier: "TableViewCell")
        return tableview
    }()
    var nametext: UITextField?
    var nameArray = ["Anjali","Kiran","Pratibha","Nirmala","Chhaya","Dipali","Sonali"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        AddBtn()
        
        tableview.backgroundColor = .yellow
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
         
    }
    func AddBtn(){
        let myAddButton = UIButton()
        myAddButton.setTitle("+", for: .normal)
        myAddButton.setTitleColor(UIColor.blue, for: [])
        myAddButton.addTarget(self,action: #selector(AddbuttonAction),for: .touchUpInside)
        myAddButton.backgroundColor = UIColor.gray
        myAddButton.center = view.center
        view.addSubview(myAddButton)
        //Add Constraint to Button
        myAddButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: myAddButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: myAddButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 300.0).isActive = true
        NSLayoutConstraint(item: myAddButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -15.0).isActive = true
        
    }
    @objc func AddbuttonAction(_ sender:UIButton!){
        //print("Add button clicked")
        let alert = UIAlertController(title: "Add New Name", message: "Enter your New name", preferredStyle: .alert)
                alert.addTextField { (UITextField) in
                }
                alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                    let content = alert.textFields![0] as UITextField
                    self.nameArray.append(content.text!)
                    
                    self.tableview.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
       cell.textLabel?.text = nameArray[indexPath.row]
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nameselected = nameArray[indexPath.row]
        let alertmsg = UIAlertController(title: "Edit name", message: "edit name of the person", preferredStyle: .alert)
        let update = UIAlertAction(title: "update", style: .default) { (action) in
            let updatename = self.nametext?.text!
            self.nameArray[indexPath.row] = updatename!
            DispatchQueue.main.async {
                self.tableview.reloadData()
                print("data updated in tableview")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("edit operation deleted by user")
        }
        alertmsg.addAction(update)
        alertmsg.addAction(cancel)
        alertmsg.addTextField {(textfield) in
            self.nametext = textfield
            self.nametext?.placeholder = "update person name here"
            self.nametext?.text = nameselected
            
        }
        self.present(alertmsg, animated: true,completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            nameArray.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

class TableViewCell: UITableViewCell, UITextFieldDelegate {
    static let identifier = "CustomTableViewCell"
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        

    }
}




//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
//            self.nameArray.remove(at: indexPath.row)
//            self.tableview.deleteRows(at: [indexPath], with: .automatic)
//            print("Edit button tapped.")
//        }
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
//            self.nameArray.remove(at: indexPath.row)
//            self.tableview.deleteRows(at: [indexPath], with: .automatic)
//            print("Delete button tapped.")
//        }
//        let swipeconfiguration = UISwipeActionsConfiguration(actions: [edit,delete])
//        return swipeconfiguration
//    }





