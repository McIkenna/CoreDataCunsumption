//
//  ViewController.swift
//  CoreDataCunsumption
//
//  Created by New Account on 10/31/21.
//

import UIKit

class ViewController: UITableViewController{
 
  
    
    var gamer : [GamerPower] = []
    let persisitent = PersistentStorage.shared
    let controller = ControllerManager.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
      
      
    }
    
    func setup(){
        let url = "https://www.gamerpower.com/api/giveaways"
        controller.request(url){[weak self] (result) in
            switch result {
            case .success(let data):
                do{
                    guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {return}
                    let gamers: [GamerPower] = jsonData.compactMap{
                    guard
                        let strongSelf = self,
                        let title = $0["title"] as? String,
                        let worth = $0["worth"] as? String
                        else{return nil}
                        let gmer = GamerPower(context: strongSelf.persisitent.context)
                        gmer.title = title
                        gmer.worth = worth
                        return gmer
                }
                    self?.gamer = gamers
                    DispatchQueue.main.async {
                        self?.persisitent.saveContext()
                        self?.tableView.reloadData()
                    }
            }
                catch{
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gamer.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let gamerObj = self.gamer[indexPath.row]
        cell.textLabel?.text = gamerObj.title + " ------> " + gamerObj.worth
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    
   
}

