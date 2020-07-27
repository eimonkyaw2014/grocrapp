//
//  DetailViewController.swift
//  Grocr
//
//  Created by eimonkyaw on 7/16/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var item :Task?
    @IBOutlet weak var nameTextField: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField!.text = item?.name
        
        // Do any additional setup after loading the view.
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
