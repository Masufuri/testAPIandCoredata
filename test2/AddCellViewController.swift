//
//  AddCellViewController.swift
//  test2
//
//  Created by User1 on 27/04/2025.
//

import UIKit

protocol DataDelegate:AnyObject{
    func receiveData(data:String)
}

class AddCellViewController: UIViewController {
    weak var delegate:DataDelegate?
    @IBOutlet var tfname:UITextField!
    @IBOutlet var buttonAdd:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func pressedAdd(){
//        print(tfname.text)
        guard let name = tfname.text else{
            return
        }
        delegate?.receiveData(data: name)
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
