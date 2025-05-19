//
//  ViewController.swift
//  test2
//
//  Created by User1 on 25/04/2025.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet var button:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: -50)
//        var config = UIButton.Configuration.plain()
//        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
//        config.imagePadding = 50
//        config.imagePlacement = .leading
//
//
//        button.contentHorizontalAlignment = .center
//        button.semanticContentAttribute = .forceLeftToRight
//        // Đẩy text sang phải để không bị đè lên icon
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
//        button.configuration = config
//        button.contentHorizontalAlignment = .center
//        button.titleLabel?.text = "Nút Bấm"
//        button.imageView?.image = UIImage(systemName: "star.fill")
//        button.setTitle("Nút bấm", for: .normal)
//        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
//        let buttonwidth = button.frame.width
//        let imageWidth = button.imageView!.frame.width
//        let contetntWidth = button.titleLabel!.frame.width
//        let imagePadding = (buttonwidth - imageWidth - contetntWidth)/2
//        print(imageWidth)
//        print(contetntWidth)
//
//        var config = UIButton.Configuration.plain()
//        config.title = "Nút bấm"
//        config.baseForegroundColor = .white
//        config.image = UIImage(systemName: "star.fill")
//        // Đặt vị trí image bên trái
////        config.imagePlacement = .leading
//
//        // Khoảng cách giữa icon và text
//
//        config.imagePadding = imagePadding

        // Căn giữa toàn bộ nội dung trong button
//        config.contentInsets = .init(top: 8, leading: 10, bottom: 8, trailing: 10)

//        button.configuration = config

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
