//
//  SecondViewController.swift
//  test2
//
//  Created by User1 on 24/04/2025.
//

import UIKit
import CoreData

class SecondViewController: UIViewController,CoreDataDelegate {
    
    func getCoreDataForEdit(at indexpath: IndexPath) -> Task {
        return tasks[indexpath.row]
    }
    
    
    @IBOutlet var tableView:UITableView!
    var tasks:[Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createTask()
        tasks = ActionManager.shared.fetchAllTask()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        let registCell = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(registCell, forCellReuseIdentifier: "homecell")
    }
    
    
    @IBAction func clickedAddButton(){
        let addVC = AddViewController.init(nibName: "AddViewController", bundle: nil)
        navigationController?.pushViewController(addVC, animated: true)
        addVC.callback = {
//            self.tasks = ActionManager.shared.fetchAllTask()
            self.tableView.reloadData()
        }
        
    }
    
    func createTask(){
        let newTask = Task(context: ActionManager.shared.viewContext)
        newTask.title = "ádasd"
        ActionManager.shared.saveContext()
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

extension SecondViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell
//        cell.lbTitle.text = (tasks[indexPath.row].value(forKey: "title") as! String)
        cell.lbTitle.text = (tasks[indexPath.row].title)
        cell.lbDesc.text = tasks[indexPath.row].desc
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("task: \(tasks.count)")
        tasks = ActionManager.shared.fetchAllTask()
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        ActionManager.shared.deleteContext(tasks[indexPath.row])
//        tasks = ActionManager.shared.fetchAllTask()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addVC = AddViewController.init(nibName: "AddViewController", bundle: nil)
        navigationController?.pushViewController(addVC, animated: true)
        addVC.coredataDelegate = self
        addVC.indexpath = indexPath
    }
    
}
