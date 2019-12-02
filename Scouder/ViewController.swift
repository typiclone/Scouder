//
//  ViewController.swift
//  Scouder
//
//  Created by Vasisht Muduganti on 28/11/19.
//  Copyright © 2019 Vasisht Muduganti. All rights reserved.
//

import UIKit
import WebKit

enum scrollType{
    
    case up
    case down
}

class WebPage: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var baseBottomNav: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    var outWay:Bool?
    
    var direction:scrollType?
    
    
    @IBAction func queueControl(_ sender: Any) {
        handleTap()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "QueueControl") as? UIViewController {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4) {
            self.baseBottomNav.alpha = 1.0
        }
        outWay = false
    }
    
    
    @IBAction func nextLinkAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4) {
            self.baseBottomNav.alpha = 1.0
        }
        if(outWay == true){
            
            self.nextView.frame.origin.x -= 50  
        }
        outWay = false
        
        
        
    }
    @IBAction func nextButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4) {
            self.baseBottomNav.alpha = 1.0
        }
        outWay = false
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.4) {
            self.baseBottomNav.alpha = 1.0
        }
        if(outWay == true){
            UIView.animate(withDuration: 0.4) {
                self.nextView.frame.origin.x -= 50
            }
        }
        
        outWay = false
    }
        
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        outWay = false
       nextView.layer.cornerRadius = 0.5 * nextView.bounds.size.width
       nextView.clipsToBounds = true
        outWay = false
        nextView.layer.zPosition = 2
        baseBottomNav.layer.zPosition = 2
        
        loadPage(urlString: "https://www.google.com")
        
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
                    UIView.animate(withDuration: 0.4) {
                        self.nextView.frame.origin.x += 50
                    
                    
                    }
                    UIView.animate(withDuration: 0.4) {
                        self.baseBottomNav.alpha = 0.2
                    }
                    outWay = true
                }
            case .down:
                print("down")
                if(outWay == true){
                    UIView.animate(withDuration: 0.4) {
                        self.nextView.frame.origin.x -= 50
                    
                    
                    }
                    UIView.animate(withDuration: 0.4) {
                        self.baseBottomNav.alpha = 1.0
                    }
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

