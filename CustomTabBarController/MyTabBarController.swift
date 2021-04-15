//
//  MyTabBarController.swift
//  TabBarController
//
//  Created by Duncan Champney on 3/31/21.
//

import UIKit



class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
//        tabBar.isTranslucent = false

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
