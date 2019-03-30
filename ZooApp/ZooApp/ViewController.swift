//
//  ViewController.swift
//  ZooApp
//
//  Created by LABMAC13 on 08/03/19.
//  Copyright © 2019 LABMAC13. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var AnimalType = ["Not killer", "Killer"]
    
    var listOfKillerAnimals = [Animal]()
    var listOfNonKillerAnimals = [Animal]()
    
    @IBOutlet weak var tvListAnimals: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listOfNonKillerAnimals.append(Animal(name:"Baboon", des: "Live in big place with trees", image: "Baboon"))
        listOfNonKillerAnimals.append(Animal(name:"Bulldog", des: "Bulldog live in big place with tree", image: "Bulldog"))
        listOfKillerAnimals.append(Animal(name:"Panda", des: "Panda live in big place with trees", image: "Panda"))
        listOfNonKillerAnimals.append(Animal(name:"Swallow Bird", des: "Swallow bird live in big place with trees", image: "Swallow_bird"))
        listOfKillerAnimals.append(Animal(name:"White tiger", des: "White tiger live in big place with trees", image: "White_tiger"))
        listOfNonKillerAnimals.append(Animal(name:"Zebra", des: "Zebra live in big place with trees", image: "Zebra"))
    
        tvListAnimals.delegate = self
        tvListAnimals.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return AnimalType[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listOfNonKillerAnimals.count
        } else {
            return listOfKillerAnimals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellAnimal:TVCAnimal = tableView.dequeueReusableCell(withIdentifier: "cellAnimal", for: indexPath) as! TVCAnimal
        
        if indexPath.section == 0 {
            cellAnimal.SetAnimal(animal: listOfNonKillerAnimals[indexPath.row])
        } else {
            cellAnimal.SetAnimal(animal: listOfKillerAnimals[indexPath.row])
        }
        
        return cellAnimal
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            //listOfNonKillerAnimals.remove(at: indexPath.row)
            listOfNonKillerAnimals.append(listOfNonKillerAnimals[indexPath.row])
        } else {
            //listOfKillerAnimals.remove(at: indexPath.row)
            listOfKillerAnimals.append(listOfKillerAnimals[indexPath.row])
        }
        
        tvListAnimals.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

