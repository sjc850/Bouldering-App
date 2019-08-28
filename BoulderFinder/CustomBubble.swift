//
//  CustomBubble.swift
//  BoulderFinder
//
//  Created by Shane on 2/23/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import UIKit
import MapKit

    

class CalloutView: UIView, MKMapViewDelegate{
    

    
    enum BubblePointerType {
        case rounded
        case straight(angle: CGFloat)
    }
    
    private let bubblePointerType = BubblePointerType.rounded
    
    
    private let inset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
    
    
    private let bubbleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.blue.cgColor
        layer.lineWidth = 0.5
        return layer
    }()
    
    
    let AnnotationView: MKMapViewDelegate = {
        let AnnotationView = UIView()
        AnnotationView.translatesAutoresizingMaskIntoConstraints = false
        return AnnotationView as! AnnotationView as! MKMapViewDelegate
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Should not call init(coder:)")
    }
    
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(AnnotationView as! UIView)
        NSLayoutConstraint.activate([
            AnnotationView.topAnchor.constraint(equalTo:topAnchor, constant: inset.top / 2.0),
            AnnotationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom - inset.right / 2.0),
            AnnotationView.leftAnchor.constraint(equalTo: leftAnchor, constant: inset.left / 2.0),
            AnnotationView.rightAnchor.constraint(equalTo: rightAnchor, constant: -inset.right / 2.0),
            AnnotationView.widthAnchor.constraint(greaterThanOrEqualToConstant: inset.left + inset.right),
            AnnotationView.heightAnchor.constraint(greaterThanOrEqualToConstant: inset.top + inset.bottom)
            ])
        
        addBackgroundButton(to: AnnotationView as! UIView)
        
        layer.insertSublayer(bubbleLayer, at: 0)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatePath()
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> AnnotationView? {
        let AnnotationViewPoint = convert(point, to: AnnotationView)
        return AnnotationView.hitTest(AnnotationViewPoint, with: event)
    }
    
    /// Update `UIBezierPath` for callout bubble
    ///
    /// The setting of the bubblePointerType dictates whether the pointer at the bottom of the
    /// bubble has straight lines or whether it has rounded corners.
    
    private func updatePath() {
        let path = UIBezierPath()
        
        var point: CGPoint
        
        var controlPoint: CGPoint
        
        point = CGPoint(x: bounds.size.width - inset.right, y: bounds.size.height - inset.bottom)
        path.move(to: point)
        
        switch bubblePointerType {
        case .rounded:
            // lower right
            point = CGPoint(x: bounds.size.width / 2.0 + inset.bottom, y: bounds.size.height - inset.bottom)
            path.addLine(to: point)
            
            // right side of arrow
            
            controlPoint = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height - inset.bottom)
            point = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height)
            path.addQuadCurve(to: point, controlPoint: controlPoint)
            
            // left of pointer
            controlPoint = CGPoint(x: point.x, y: bounds.size.height - inset.bottom)
            point = CGPoint(x: point.x - inset.bottom, y: controlPoint.y)
            path.addQuadCurve(to: point, controlPoint: controlPoint)
        case .straight(let angle):
            // lower right
            point = CGPoint(x: bounds.size.width / 2.0 + tan(angle) * inset.bottom, y: bounds.size.height - inset.bottom)
            path.addLine(to: point)
            
            // right side of arrow
            
            point = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height)
            path.addLine(to: point)
            
            // left of pointer
            
            point = CGPoint(x: bounds.size.width / 2.0 - tan(angle) * inset.bottom, y: bounds.size.height - inset.bottom)
            path.addLine(to: point)
        }
        
        // bottom left
        
        point.x = inset.left
        path.addLine(to: point)
        
        // lower left corner
        
        controlPoint = CGPoint(x: 0, y: bounds.size.height - inset.bottom)
        point = CGPoint(x: 0, y: controlPoint.y - inset.left)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // left
        
        point.y = inset.top
        path.addLine(to: point)
        
        // top left corner
        
        controlPoint = CGPoint.zero
        point = CGPoint(x: inset.left, y: 0)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // top
        
        point = CGPoint(x: bounds.size.width - inset.left, y: 0)
        path.addLine(to: point)
        
        // top right corner
        
        controlPoint = CGPoint(x: bounds.size.width, y: 0)
        point = CGPoint(x: bounds.size.width, y: inset.top)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // right
        
        point = CGPoint(x: bounds.size.width, y: bounds.size.height - inset.bottom - inset.right)
        path.addLine(to: point)
        
        // lower right corner
        
        controlPoint = CGPoint(x:bounds.size.width, y: bounds.size.height - inset.bottom)
        point = CGPoint(x: bounds.size.width - inset.right, y: bounds.size.height - inset.bottom)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        path.close()
        
        bubbleLayer.path = path.cgPath
    }
    
    /// Add this `CalloutView` to an annotation view (i.e. show the callout on the map above the pin)
    ///
    /// - Parameter annotationView: The annotation to which this callout is being added.
    
    func add(to annotationView: MKAnnotationView) {
        annotationView.addSubview(self)
        
        // constraints for this callout with respect to its superview
        
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: annotationView.topAnchor, constant: annotationView.calloutOffset.y),
            centerXAnchor.constraint(equalTo: annotationView.centerXAnchor, constant: annotationView.calloutOffset.x)
            ])
    }
}

// MARK: - Background button related code
extension CalloutView {
    
    /// Add background button to callout
    ///
    /// This adds a button, the same size as the callout's `contentView`, to the `contentView`.
    /// The purpose of this is two-fold: First, it provides an easy method, `didTouchUpInCallout`,
    /// that you can `override` in order to detect taps on the callout. Second, by adding this
    /// button (rather than just adding a tap gesture or the like), it ensures that when you tap
    /// on the button, that it won't simultaneously register as a deselecting of the annotation,
    /// thereby dismissing the callout.
    ///
    /// This serves a similar functional purpose as `_MKSmallCalloutPassthroughButton` in the
    /// default system callout.
    ///
    /// - Parameter view: The view to which we're adding this button.
    
    fileprivate func addBackgroundButton(to view: UIView) {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        button.addTarget(self, action: #selector(didTouchUpInCallout(_:)), for: .touchUpInside)
    }
    
    /// Callout tapped.
    ///
    /// If you want to detect a tap on the callout, override this method. By default, this method does nothing.
    ///
    /// - Parameter sender: The actual hidden button that was tapped, not the callout, itself.
    
    func didTouchUpInCallout(_ sender: Any) {
        // this is intentionally blank
    }
}
