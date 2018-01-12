//
//  EAPeekingView.swift
//  Edit
//
//  Created by Ehud Adler on 1/1/18.
//  Copyright © 2018 Ehud Adler. All rights reserved.
//

import UIKit

@IBDesignable class Peekboo: UIView, UIGestureRecognizerDelegate {

    
/* ************ Inspectables *********** */

    @IBInspectable public var infoText : String = "Swipe Up" {
        didSet {
            self.infoLabel.text = infoText
            self.infoLabel.sizeToFit()
        }
    }
    
    @IBInspectable public var cornerRadius : CGFloat = 10.0 {
        didSet {
            self.contentView.layer.cornerRadius = cornerRadius
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var height : CGFloat = 5.0 {
        didSet {
            self.view_height = height
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var inset : CGFloat = 80.0 {
        didSet {
            self.view_inset = inset
            self.setNeedsLayout()
        }
    }
  
    @IBInspectable public var viewColor : UIColor = UIColor.white {
      didSet {
        self.contentView.backgroundColor = viewColor
        self.setNeedsLayout()
      }
    }
    
/* ************ End Inspectables *********** */
    
    
/* ************** Variables ************** */

    fileprivate var initalCenterY = CGFloat()
    fileprivate var view_inset:CGFloat = 5.0
    fileprivate var view_height:CGFloat = 80
    
/* ************ End Variables ************ */
    
    
/* ************* Shadow View ************* */

    let shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor                              = UIColor.black.cgColor
        view.layer.shadowOffset                             = .zero
        view.layer.shadowOpacity                            = 0.7
        view.layer.shadowRadius                             = 20
        view.clipsToBounds                                  = false
        view.backgroundColor                                = .white
        view.translatesAutoresizingMaskIntoConstraints      = false
        return view
    }()
    
/* *********** End Shadow View *********** */
    
/* ************* Content View ************* */

    let contentView: UIView = {
        let view                                                = UIView()
        view.backgroundColor                                    = .white
        view.translatesAutoresizingMaskIntoConstraints          = false

        return view
    }()
    
/* ************* End Content View ************* */

/* ************* Info Label ************* */
    
    let infoLabel: UILabel = {
        let label                                       = UILabel()
        label.text                                      = "Swipe Up"
        label.font                                      = UIFont.systemFont(ofSize: 10)
        label.textColor                                 = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
/* ************* End Info Label ************* */

/* *************** INIT's **************** */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.cornerRadius = 10.0
        self.addSubview(shadowView)
        self.addSubview(contentView)
        contentView.addSubview(infoLabel)
        infoLabel.sizeToFit()
        
        setUpGestures()

    }

/* *************** End INIT's **************** */

/* *************** Gestures **************** */
    
    private func setUpGestures() {
        let slideUp = UIPanGestureRecognizer(target: self, action: #selector(handleSlide(_:)))
        slideUp.delegate = self
        self.contentView.addGestureRecognizer(slideUp)
    }
    
    @objc func handleSlide(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began || gesture.state == .changed {
            let translation = gesture.translation(in: self.superview)
            if self.center.y + translation.y >= (self.superview?.frame.height)! - self.frame.height/2 - 10 && self.center.y + translation.y <= initalCenterY {
                self.center = CGPoint(x: self.center.x, y: self.center.y + translation.y)
                gesture.setTranslation(CGPoint.zero, in: self.superview)
            }else{
                // gesture.isEnabled = false
                // gesture.isEnabled = true
            }
        }else if gesture.state == .cancelled || gesture.state == .ended {
            let velocity = gesture.velocity(in: self.superview)

            if velocity.y < 0 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.center = CGPoint(x: self.center.x, y: (self.superview?.frame.height)! - self.frame.height/2 - 10)
                    self.infoLabel.alpha = 0
                })
            }else{
                UIView.animate(withDuration: 0.25, animations: {
                    self.center = CGPoint(x: self.center.x, y: self.initalCenterY)
                    self.infoLabel.alpha = 1
                })
            }
        }
    }
    
/* *************** End Gestures **************** */


    override func layoutSubviews() {

        let safe = superview?.safeAreaLayoutGuide
        self.leadingAnchor.constraintEqualToSystemSpacingAfter((safe?.leadingAnchor)!, multiplier: 1.0).isActive             = true
        safe?.trailingAnchor.constraintEqualToSystemSpacingAfter(self.trailingAnchor, multiplier: 1.0).isActive              = true
        safe?.bottomAnchor.constraintEqualToSystemSpacingBelow(self.topAnchor, multiplier: view_inset).isActive              = true
        self.heightAnchor.constraint(equalToConstant: view_height).isActive                                                  = true
        
        contentView.leadingAnchor.constraintEqualToSystemSpacingAfter((safe?.leadingAnchor)!, multiplier: 1.0).isActive      = true
        safe?.trailingAnchor.constraintEqualToSystemSpacingAfter(contentView.trailingAnchor, multiplier: 1.0).isActive       = true
        safe?.bottomAnchor.constraintEqualToSystemSpacingBelow(contentView.topAnchor, multiplier: view_inset).isActive       = true
        contentView.heightAnchor.constraint(equalToConstant: view_height).isActive                                           = true
        
        shadowView.leadingAnchor.constraintEqualToSystemSpacingAfter(contentView.leadingAnchor, multiplier: 1.0).isActive    = true
        contentView.trailingAnchor.constraintEqualToSystemSpacingAfter(shadowView.trailingAnchor, multiplier: 1.0).isActive  = true
        contentView.bottomAnchor.constraintEqualToSystemSpacingBelow(shadowView.bottomAnchor, multiplier: 1.0).isActive      = true
        shadowView.topAnchor.constraintEqualToSystemSpacingBelow(contentView.topAnchor, multiplier: 1.0).isActive            = true
        
        infoLabel.leadingAnchor.constraintEqualToSystemSpacingAfter(contentView.leadingAnchor, multiplier: 2.0).isActive     = true
        infoLabel.topAnchor.constraintEqualToSystemSpacingBelow(contentView.topAnchor, multiplier: 1.0).isActive             = true
        
        initalCenterY = self.center.y

    }

}

extension Peekboo {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
