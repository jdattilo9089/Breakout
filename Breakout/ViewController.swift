//
//  ViewController.swift
//  Breakout
//
//  Created by student1 on 3/17/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var blocks = [UIView]()
    
    var dynamicAnimator = UIDynamicAnimator()
    
    var allItems = [UIView]()
    
    let length:CGFloat = 55.0
    
    let hieght:CGFloat = 15.0
    
    var bothArray:[UIView] = []
    
    var counter = 0
    
    var collisionBehavior = UICollisionBehavior()
    
    var dynamicBehavior = UIDynamicItemBehavior()
    
    var paddle = UIView()

    var ball = UIView()
    
    var x1:CGFloat = 325


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        ball = UIView(frame: CGRectMake(277,565,30,30))
        
        ball.layer.cornerRadius = ball.frame.width / 2.0
        ball.backgroundColor = UIColor.blackColor()
        view.addSubview(ball)
        allItems.append(ball)
        bothArray.append(ball)
        
        paddle = UIView(frame: CGRectMake(325,844,150,25))
        paddle.backgroundColor = UIColor.blackColor()
        view.addSubview(paddle)
        collisionBehavior.addItem(paddle)
        allItems.append(paddle)
        bothArray.append(paddle)
        
        //add 60 to each x
        //add 30 to each y starting at 50
        
        
        
        addDynamicBehavior()
        
        createBlocks()
        
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 
    func addDynamicBehavior (){
        
        dynamicBehavior  = UIDynamicItemBehavior(items: blocks)
        dynamicBehavior.density = 10000000.0
        dynamicBehavior.elasticity = 1.0
        
        dynamicAnimator.addBehavior(dynamicBehavior)
        
        dynamicBehavior  = UIDynamicItemBehavior(items: [paddle])
        dynamicBehavior.density = 10000000.0
        dynamicBehavior.elasticity = 1.0
        
        dynamicAnimator.addBehavior(dynamicBehavior)
        
        
        let dynamicItemBehaviorBlocks  = UIDynamicItemBehavior(items: [ball])
        dynamicItemBehaviorBlocks.density = 1.0
        dynamicItemBehaviorBlocks.friction = 0.0
        dynamicItemBehaviorBlocks.resistance = 0.0
        dynamicItemBehaviorBlocks.elasticity = 1.0
        
        dynamicAnimator.addBehavior(dynamicItemBehaviorBlocks)
        
        let pushBehavior = UIPushBehavior(items: [ball], mode: .Instantaneous)
        pushBehavior.magnitude = 0.4
        pushBehavior.active = true
        pushBehavior.pushDirection = CGVectorMake(1, 1)
        dynamicAnimator.addBehavior(pushBehavior)
        
        dynamicAnimator.updateItemUsingCurrentState(ball)
        
        
        
        collisionBehavior = UICollisionBehavior(items: allItems)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    
    func createBlocks()
    {
        
        var x:CGFloat = 24
        var y:CGFloat = 50
        var block = UIView()

        
        for _ in 1...5
        {
            for _ in 1...12
            {
                //it has a vowel 
                //its a word
                block = UIView(frame: CGRectMake(x, y, length, hieght))
                block.backgroundColor = UIColor.blackColor()
                view.addSubview(block)
                
                blocks.append(block)
                allItems.append(block)
                collisionBehavior.addItem(block)
                dynamicBehavior.addItem(block)
              
                
                x += 60
            }
            x = 20
            y += 30
        }
    
    }
    @IBAction func moveRight(sender: UIButton) {
        x1+=55
        
        paddle.frame = CGRectMake(x1, 844, 150, 25)
        
        //(325,844,150,25)
        
    }
    @IBAction func moveLeft(sender: UIButton) {
    }
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        for block in blocks{
            if item1.isEqual(ball) && item2.isEqual(block) || item1.isEqual(block) && item2.isEqual(ball){
                if block.backgroundColor == UIColor.blackColor(){
                block.backgroundColor = UIColor.yellowColor()
                }
                else if block.backgroundColor == UIColor.yellowColor(){
                block.backgroundColor = UIColor.redColor()
                }
                else if block.backgroundColor == UIColor.redColor(){
                block.removeFromSuperview()
                collisionBehavior.removeItem(block)
                    
                }
            }
        }
    }
}