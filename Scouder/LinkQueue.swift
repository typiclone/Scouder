//
//  LinkQueue.swift
//  Scouder
//
//  Created by Vasisht Muduganti on 01/12/19.
//  Copyright © 2019 Vasisht Muduganti. All rights reserved.
//

import UIKit
import CoreData

class LinkQueue: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var fomework:[Link] = [Link]()
    var opened:Bool = false
    var header1 = UILabel.init()
    var header2 = UILabel.init()
    var field1 = UITextField()
    var field2 = UITextField()
    let button = UIButton()
    var sections:[String] = [String]()
    var sectionz:Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    @IBAction func saveLinkChanges(_ sender: Any) {
        for n in 0 ... loadLink().count - 1{
            
                let indexPath = IndexPath(row: 0, section: n)
                let cell = tableView.cellForRow(at: indexPath) as? urlCell
                print("YEET")
                print()
                if(cell?.urlField.text != loadLink()[n].url!){
                    loadLink()[n].url! = (cell?.urlField.text)!
                    saveContext()
                }
                print("YEET")
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell") as! urlCell
        print(sectionz)
    print("NIGGA BEAnS")
       print(loadLink())
        
        
        cell.urlField?.text = loadLink()[sectionz].url
         
        sectionz += 1
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return loadLink().count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return loadLink()[section].name
    }
    
   
    @IBOutlet weak var cContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addLinkOut: UIButton!
    @IBAction func addLink(_ sender: Any) {
        cContainer.translatesAutoresizingMaskIntoConstraints = true
        
        addLinkOut.translatesAutoresizingMaskIntoConstraints = true
        
            if(self.opened == false){
              
                view.addSubview(field1)
                showButtons()
                UIView.animate(withDuration: 0.5) { self.cContainer.frame.size.height += 1000
                
                
            self.cContainer.frame.size.width += 1000
            
            self.cContainer.frame.origin.x -= 600
            
            self.cContainer.frame.origin.y -= 100
            self.addLinkOut.setTitle("+", for: .normal)
                
            self.addLinkOut.frame.origin.x += 600
            self.addLinkOut.frame.origin.y += 100
            
            self.cContainer.layer.cornerRadius = 0.5 * self.cContainer.bounds.size.width
                
                self.addLinkOut.titleLabel?.font = .systemFont(ofSize: 40)
                
                self.addLinkOut.setTitle("X", for: .normal)
                
                self.opened = true
                
                
                
               
                    self.field1.layer.opacity = 1.0
                    
                    self.header1.layer.opacity = 1.0
                    
                    self.header2.layer.opacity = 1.0
                        
                        self.field2.layer.opacity = 1.0
               
                    self.button.layer.opacity = 1.0
                
                    
                }
                    
            }
            else{
                
                
                view.addSubview(field1)
               UIView.animate(withDuration: 0.5) {
                
                self.cContainer.frame.size.height -= 1000
                self.cContainer.frame.size.width -= 1000
                
                self.cContainer.frame.origin.x += 600
                
                self.cContainer.frame.origin.y += 100
                
                    
                self.addLinkOut.frame.origin.x -= 600
                self.addLinkOut.frame.origin.y -= 100
                
                self.cContainer.layer.cornerRadius = 0.5 * self.cContainer.bounds.size.width
                
                self.addLinkOut.titleLabel?.font = .systemFont(ofSize: 70)
                
                self.addLinkOut.setTitle("+", for: .normal)
                    
                
                
                
                
                self.opened = false
                
                  
                    self.field1.layer.opacity = 1.0
                    
                    self.header1.layer.opacity = 1.0
                    
                    
                    self.header2.layer.opacity = 1.0
                    
                    self.field2.layer.opacity = 1.0
                }
                
               
                UIView.animate(withDuration: 0.5, animations: {
                    self.field1.layer.opacity = 0.0
                    
                    self.header1.layer.opacity = 0.0
                    
                    
                    self.header2.layer.opacity = 0.0
                    
                    self.field2.layer.opacity = 0.0
                    self.button.layer.opacity = 0.0
                }) { (isFinished) in
                    if(isFinished){
                        self.hideButtons()
                    }
                }
                
            }
            
        
       tableView.reloadData()
        sectionz = 0
    }
    func showButtons(){
        
        
        header1.textAlignment = .center
        header1.textColor = .white
        header1.backgroundColor = .blue
        header1.frame = CGRect(x: header1.frame.origin.x, y: 200, width: 300, height: 50)
        
        header1.frame = CGRect(x: self.view.center.x - header1.frame.width/2, y: 200, width: 300, height: 50)
        
        header1.layer.cornerRadius = 0.05 * header1.bounds.size.width
            header1.clipsToBounds = true
        
        header1.layer.zPosition = 3
        header1.layer.opacity = 0.0
        header1.text = "Link Name"
        view.addSubview(header1)
        
        
        header2.textAlignment = .center
        header2.textColor = .white
        header2.backgroundColor = .red
        header2.frame = CGRect(x: header2.frame.origin.x, y: 200, width: 300, height: 50)
        header2.frame = CGRect(x: self.view.center.x - header2.frame.width/2, y: 300, width: 300, height: 50)
        
        header2.layer.cornerRadius = 0.05 * header2.bounds.size.width
            header2.clipsToBounds = true
        
        header2.layer.zPosition = 3
        header2.layer.opacity = 0.0
        header2.text = "Link URL"
        view.addSubview(header2)
        
        
        field1.frame = CGRect(x: field1.frame.origin.x, y: 262, width: 300, height: 38)
        
        field1.frame = CGRect(x: self.view.center.x - field1.frame.width/2, y: 256, width: 300, height: 38)
        field1.backgroundColor = .white
        field1.textColor = .black
        field1.layer.cornerRadius = 0.05 * field1.bounds.size.width
            field1.clipsToBounds = true
        
        field1.layer.zPosition = 3
        field1.layer.opacity = 0.0
        view.addSubview(field1)
        
        field2.frame = CGRect(x: field2.frame.origin.x, y: 262, width: 300, height: 38)
        
        field2.frame = CGRect(x: self.view.center.x - field2.frame.width/2, y: 357, width: 300, height: 38)
        field2.backgroundColor = .white
        field2.textColor = .black
        field2.layer.cornerRadius = 0.05 * field2.bounds.size.width
            field2.clipsToBounds = true
        
        field2.layer.zPosition = 3
        field2.layer.opacity = 0.0
        view.addSubview(field2)
        
        
        // let preferred over var here
        
        button.frame = CGRect(x: self.view.center.x - button.frame.width/2, y: 200, width: 200, height: 50)
        
        button.frame = CGRect(x: self.view.center.x - button.frame.width/2, y: 470, width: 200, height: 50)
        button.layer.zPosition = 3
        button.backgroundColor = .systemPink
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(addLinkTap), for: .touchUpInside)
        button.layer.cornerRadius = 0.05 * button.bounds.size.width
        button.clipsToBounds = true
        self.view.addSubview(button)
    }
    
    
    func hideButtons(){
        
        header1.removeFromSuperview()
        header2.removeFromSuperview()
        field1.removeFromSuperview()
        field2.removeFromSuperview()
        button.removeFromSuperview()
    }
    
    @objc func addLinkTap(){
        var newLink:Link = Link(context: context)
        print("NIGGA CHEES")
        print(field2.text)
        newLink.name = field1.text!
        newLink.url = field2.text! 
        print(newLink.url)
        
        saveContext()
        print(loadLink()[loadLink().count - 1].url)
        print(loadLink())
        addLink(self)
        tableView.reloadData()
        sectionz = 0
        
    }
    func saveContext(){
        do{
            try self.context.save()
        }
        catch{
            print("error occurred")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*let request: NSFetchRequest<Link> = Link.fetchRequest()
        do{
            fomework = try context.fetch(request)
           for item in fomework {
               context.delete(item)
           }
        }
        catch{
            print("error")
        }
        saveContext()*/
        
        
        
        
        field1.delegate = self
        field2.delegate = self
        loadLink()
        tableView.layer.zPosition = -1
        cContainer.layer.cornerRadius = 0.5 * cContainer.bounds.size.width
        cContainer.clipsToBounds = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //textField code

        textField.resignFirstResponder()  //if desired
    
        return true
    }
    func loadLink() -> [Link]{
        
        let request: NSFetchRequest<Link> = Link.fetchRequest()
        do{
            fomework = try context.fetch(request)
           
        }
        catch{
            print("error")
        }
        return fomework
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
