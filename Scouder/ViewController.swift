//
//  ViewController.swift
//  Scouder
//
//  Created by Vasisht Muduganti on 28/11/19.
//  Copyright © 2019 Vasisht Muduganti. All rights reserved.
//

import UIKit
import WebKit
import CoreData

enum scrollType{
    
    case up
    case down
}

class WebPage: UIViewController, UIGestureRecognizerDelegate, WKNavigationDelegate {

    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var baseBottomNav: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var nextLinkButtonOut: UIButton!
    var outWay:Bool?
    var pageNum:Int = 0
    var direction:scrollType?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func queueControl(_ sender: Any) {
        handleTap()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "QueueControl") as? UIViewController {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var topBarNav: UIView!
    
    
    @IBAction func backButton(_ sender: Any) {
        goBac()
        handleTap()
        outWay = false
        pageNum -= 1
        if(!webView.canGoBack){
              backButtonOut.isEnabled = false
          }
          else{
            backButtonOut.isEnabled = true
        }
          if(!webView.canGoForward){
              nextButtonOut.isEnabled = false
          }
          else{
            nextButtonOut.isEnabled = true
        }
    }
    
    
    @IBAction func nextLinkAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4) {
            self.baseBottomNav.alpha = 1.0
        }
        if(outWay == true){
            
            self.nextView.frame.origin.x -= 50  
        }
        
        outWay = false
        pageNum += 1
        loadPage(urlString: loadLink()[pageNum].url!)
        
    }
    
    @IBOutlet weak var backButtonOut: UIButton!
    
    @IBOutlet weak var nextButtonOut: UIButton!
    
    @IBAction func nextButton(_ sender: Any) {
        goFor()
        handleTap()
        outWay = false
        if(!webView.canGoBack){
              backButtonOut.isEnabled = false
          }
          else{
            backButtonOut.isEnabled = true
        }
          if(!webView.canGoForward){
              nextButtonOut.isEnabled = false
          }
          else{
            nextButtonOut.isEnabled = true
        }
    }
    func goFor(){
        
        if(webView.canGoForward == true){
            webView.goForward()
        }
        
    }
    func goBac(){
        if(webView.canGoBack == true){
            webView.goBack()
        }
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.4) {
            self.baseBottomNav.alpha = 1.0
        }
        if(outWay == true){
            
            
            
            UIView.animate(withDuration: 0.4) {
                
                    self.webView.frame.origin.y += 50
                    
                    self.webView.frame.size.height -= 50
                
                self.topBarNav.frame.origin.y += 50
                self.nextView.frame.origin.x -= 50
            }
        }
        
        outWay = false
    }
         func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print(pageNum)
            if(pageNum == loadLink().count - 1){
                nextLinkButtonOut.isEnabled = false
                nextLinkButtonOut.layer.opacity = 0.52
                nextView.layer.opacity = 0.52
            }
            else{
                nextLinkButtonOut.isEnabled = true
                nextLinkButtonOut.layer.opacity = 1.0
                nextView.layer.opacity = 1.0
            }
           
            if(!webView.canGoBack){
                  backButtonOut.isEnabled = false
              }
              else{
                backButtonOut.isEnabled = true
            }
              if(!webView.canGoForward){
                  nextButtonOut.isEnabled = false
              }
              else{
                nextButtonOut.isEnabled = true
            }
            
            
            
          }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(loadLink().count > 0){
            loadPage(urlString: loadLink()[0].url!)
        }
        if(pageNum == loadLink().count){
            nextLinkButtonOut.isEnabled = false
        }
        webView.navigationDelegate = self
        if(!webView.canGoBack){
              backButtonOut.isEnabled = false
          }
          else{
            backButtonOut.isEnabled = true
        }
          if(!webView.canGoForward){
              nextButtonOut.isEnabled = false
          }
          else{
            nextButtonOut.isEnabled = true
        }
        
        
        outWay = false
       nextView.layer.cornerRadius = 0.5 * nextView.bounds.size.width
       nextView.clipsToBounds = true
        outWay = false
        nextView.layer.zPosition = 2
        baseBottomNav.layer.zPosition = 2
        
       
        
        baseBottomNav.layer.cornerRadius = 10
        
        print(nextView.frame)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeUp.delegate = self
        swipeUp.direction = .up
        self.webView.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeDown.delegate = self
        swipeDown.direction = .down
        self.webView.addGestureRecognizer(swipeDown)
        
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        baseBottomNav.addGestureRecognizer(tap)
        
        
        
        
    }
    
    func loadLink() -> [Link]{
        var fomework:[Link] = [Link]()
        let request: NSFetchRequest<Link> = Link.fetchRequest()
        do{
            fomework = try context.fetch(request)
            
         
        }
        catch{
            print("error")
        }
        return fomework
    }
     func saveContext(){
        do{
            try self.context.save()
        }
        catch{
            print("error occurred")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        outWay = false
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
    }
    func loadPage(urlString: String){
        let url:URL = URL(string: urlString)!
        
        let urlRequest:URLRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction{
            case .up:
                
                print("up")
                if(outWay == false){
                    nextView.translatesAutoresizingMaskIntoConstraints = true
                    webView.translatesAutoresizingMaskIntoConstraints = true
                    
                    topBarNav.translatesAutoresizingMaskIntoConstraints = true
                    let options: UIView.AnimationOptions = [.allowUserInteraction]
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: options, animations: {
                        self.nextView.frame.origin.x += 50
                        
                            self.topBarNav.frame.origin.y -= 50
                            
                            
                            self.webView.frame.origin.y -= 50
                            
                            self.webView.frame.size.height += 50
                            
                        self.baseBottomNav.alpha = 0.2
                            
                            
                            self.view.layoutIfNeeded()
                    }, completion:nil)
                    
                        
                    
                   
                   
                        
                    
                    outWay = true
                }
            case .down:
                print("down")
                if(outWay == true){
                let options: UIView.AnimationOptions = [.allowUserInteraction]
                UIView.animate(withDuration: 0.4, delay: 0.0, options: options, animations: {
                    self.nextView.frame.origin.x -= 50
                        
                    self.topBarNav.frame.origin.y += 50
                    
                    self.webView.frame.origin.y += 50
                    
                    self.webView.frame.size.height -= 50
                    
                    self.baseBottomNav.alpha = 1.0
                }, completion: nil)
                
                    
                    print("before \(outWay)")
                    outWay = false
                    print("after \(outWay)")
                }
                
            default:
                print("default")
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Nigga bEANS")
        outWay = false
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("Nigga bEANS")
        outWay = false
    }
}
