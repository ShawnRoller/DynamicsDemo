//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Shawn Roller on 4/5/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var colorView = UIView()
    private var animator: UIDynamicAnimator!
    private var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addView()
        createGesture(on: colorView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDynamicAnimator()
    }
    
    private func setupDynamicAnimator() {
        animator = UIDynamicAnimator(referenceView: view)
        snap = UISnapBehavior(item: colorView, snapTo: view.center)
    }
    
    private func addView() {
        colorView = UIView(frame: CGRect(x: 0, y: 0, width: 175, height: 275))
        colorView.center = view.center
        colorView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.addSubview(colorView)
    }

    private func createGesture(on view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:)))
        view.addGestureRecognizer(pan)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func handlePan(_ pan: UIPanGestureRecognizer) {
        guard let pannedView = pan.view else { return }
        switch pan.state {
        case .began:
            animator.removeBehavior(snap)
        case .changed:
            let translation = pan.translation(in: view)
            pannedView.center = CGPoint(x: pannedView.center.x + translation.x, y: pannedView.center.y + translation.y)
            pan.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            animator.addBehavior(snap)
        default:
            ()
        }
    }


}

