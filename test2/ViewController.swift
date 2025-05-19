//
//  ViewController.swift
//  test2
//
//  Created by User1 on 22/04/2025.
//

import UIKit
import Moya
//import Nimble
//struct todo:Decodable {
//    let _id:String
//    let title:String
//    let description:String
//    let dueDate: String
//    let priority: String
//    let status: String
//    let tags:String
//    let createdAt:String
//    let updatedAt:String
//    let __v:Int
//}

class ATest {
    var name: String = "cuong"
    
    deinit {
        print("ATest deinit")
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, Delegate {
    func getDataForEdit(at indexpath: IndexPath) -> getAllData {
        return task[indexpath.row]
    }
    
    var textToSend = "Hello từ ViewControllerA!"
    func didReceiveData(_ data: String) -> String {
        print(data)
        return data
//            print("B đã yêu cầu dữ liệu, A gửi: \(textToSend)")
//        data = "B đã yêu cầu dữ liệu, A gửi: \(textToSend)"
//        print(data)
            // Nếu muốn, có thể truyền biến textToSend sang B ở đây.
            // Bạn có thể sửa hàm delegate để truyền dữ liệu theo chiều ngược
            // hoặc gán giá trị cho B trước khi push.
        }
    
//    func receiveData(data: String) {
//        cells.append(data)
//        tableView.reloadData()
//    }
    var task:[getAllData]=[]
    

    @IBOutlet var tableView:UITableView!
    @IBOutlet var add:UIButton!
//    @IBOutlet var label:UILabel!
//    @IBOutlet var en:UIButton!
//    @IBOutlet var vi:UIButton!
    
    @IBAction func buttonClick(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let sv = storyBoard.instantiateViewController(withIdentifier: "secondVC")
        sv.modalPresentationStyle = .fullScreen
        present(sv, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = ATest()
        print(a.name)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let customCell = UINib.init(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(customCell, forCellReuseIdentifier: "homecell")
        
//        let hello = tabBarController?.viewControllers?[1] as? AddCellViewController
//        hello?.delegate = self
        
//        add.addTarget(Any?, action: #selector(addCell), for: .touchUpInside)
        showAllData()
        
        
    }
    
    func showAllData(){
        let provider = MoyaProvider<ActionTodo>()
        provider.request(.getAll) { [unowned self] result in
            switch result{
            case .success(let response):
                do {
//                            let json = try JSONSerialization.jsonObject(with: response.data, options: [])
                    self.task = try JSONDecoder().decode([getAllData].self, from: response.data)
                    print (self.task.count)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                        } catch {
                            print("Lỗi parse JSON: \(error)")
                        }
            case .failure(let error):
                print("Lỗi gọi API: \(error)")

            }
        }
    }
    
    @IBAction func addCell(){
        let ui = AddViewController.init(nibName: "AddViewController", bundle: nil)
        ui.callback = { [weak self] in
            self?.showAllData()
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(ui, animated: true)
    }
    
//    func parseJSON(data: Data) {
//        let decoder = JSONDecoder()
//        do {
//            let posts = try decoder.decode([todo].self, from: data)
//            // Bây giờ bạn có mảng các đối tượng 'Post'
//            for post in posts {
//                print("ID: \(post.title), Tiêu đề: \(post.title)")
//            }
//        } catch {
//            print("Lỗi phân tích JSON: \(error)")
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell
        let perTask = task[indexPath.row]
        cell.lbTitle.text = perTask.title
        cell.lbDate.text = perTask.createdAt
        cell.lbDesc.text = perTask.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ui = AddViewController.init(nibName: "AddViewController", bundle: nil)
        navigationController?.pushViewController(ui, animated: true)
        ui.idForEdit = task[indexPath.row].id
//        ui.oldTitle = task[indexPath.row].title
//        ui.oldDesc = task[indexPath.row].description
        ui.delegate = self
//        didReceiveData("hello \(textToSend)")
        ui.indexpath = indexPath
        ui.callback = { [weak self] in
            self?.showAllData()
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let provider = MoyaProvider<ActionTodo>()
        provider.request(.delete(id: task[indexPath.row].id)){result in
            switch result {
            case .success:
                print("deleted")
                DispatchQueue.main.async {
                    self.showAllData()
                    tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}


