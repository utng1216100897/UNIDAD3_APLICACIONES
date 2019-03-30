//
//  VCFoodsDetail.swift
//  FoodApp
//
//  Created by LABMAC13 on 22/03/19.
//  Copyright © 2019 LABMAC13. All rights reserved.
//

import UIKit

class VCFoodsDetail: UIViewController {

    @IBOutlet weak var ivFoodImage: UIImageView!
    @IBOutlet weak var laFoodName: UILabel!
    @IBOutlet weak var laFoodDes: UITextView!
    var food:Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        laFoodName.text = food?.name!
        laFoodDes.text = food?.des!
        ivFoodImage.image = UIImage(named: (food?.image!)!)
    }


    @IBAction func buBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
