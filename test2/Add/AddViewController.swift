//
//  AddViewController.swift
//  test2
//
//  Created by User1 on 10/05/2025.
//

import UIKit
import Moya
import CoreData

protocol Delegate: AnyObject {
    func getDataForEdit(at indexpath:IndexPath) -> getAllData
    func didReceiveData(_ data: String) -> String
}

protocol CoreDataDelegate:AnyObject {
    func getCoreDataForEdit(at indexpath:IndexPath) -> Task
}

class AddViewController: UIViewController {
    
    @IBOutlet var tfTitile:UITextField!
    @IBOutlet var tfdesc:UITextField!
    @IBOutlet var addBtn:UIButton!
    
    var callback:(() -> Void)!
    var idForEdit:String! = ""
//    var oldTitle:String = ""
//    var oldDesc:String = ""
    var indexpath:IndexPath?
    
    weak var coredataDelegate:CoreDataDelegate?
    weak var delegate:Delegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let asd:String = delegate?.didReceiveData("dsf") ?? "sdad"
//        print(asd)
        //Cách 1: truyền trực tiếp
//        if idForEdit != "" {
//            tfTitile.text = oldTitle
//            tfdesc.text = oldDesc
//        } else {
//            tfTitile.text = ""
//        }
        
        //Cách 2: dùng delegate
        if let indexpath = indexpath {
            
            if getPreviousViewControllerName() != "SecondViewController" {
                let data = delegate?.getDataForEdit(at: indexpath)
                tfTitile.text = data?.title
                tfdesc.text = data?.description
            } else {
                let data = coredataDelegate?.getCoreDataForEdit(at: indexpath)
                tfTitile.text = data?.title
                tfdesc.text = data?.desc
            }
        }
        else {
            tfTitile.text = ""
        }
        
        addBtn.addTarget(self, action: #selector(createTaskCoreData), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    func getPreviousViewControllerName() -> String? {
        guard let vcs = navigationController?.viewControllers, vcs.count >= 2 else { return nil }
        let previousVC = vcs[vcs.count - 2]
        return String(describing: type(of: previousVC))
    }
    
    @objc func createTaskCoreData(){
        let newTask = Task(context: ActionManager.shared.viewContext)
        newTask.title = tfTitile.text
        newTask.desc = tfdesc.text
        
        let currentDate = Date()
        DateFormatter().dateFormat = "dd-MM-yyyy"
        let dateString = DateFormatter().string(from: currentDate)
        
        newTask.datetime = dateString
        ActionManager.shared.saveContext()
        navigationController?.popViewController(animated: true)
        callback()
    }
    
    @IBAction func add(){
        guard let tfTitle = tfTitile.text, let tfDesc = tfdesc.text else {
            return
        }
        let provider = MoyaProvider<ActionTodo>()
        let newTask = AddData(
            title: tfTitle,
            description: tfDesc,
            dueDate: "2024-11-15",
            priority: "High",
            status: "Not Started",
            tags: ["JavaScript", "Learning"])
        if idForEdit != "" {
            provider.request(.update(id: idForEdit, data: newTask)){ result in
                switch result {
                case .success(let response):
                    print("edit successfully")
                    DispatchQueue.main.async {
                        self.callback()
                        self.delegate?.didReceiveData("alo")
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            provider.request(.create(data: newTask)){ result in
                switch result{
                case .success(let response):
                    do {
                        print("add successfully")
                        DispatchQueue.main.async {
                            self.callback()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    catch{
                        print("Lỗi \(error)")
                    }
                case .failure(let error):
                    print("Gọi api lỗi",error)
                
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
