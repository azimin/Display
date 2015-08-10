import Foundation
import UIKit

class InteractiveTransitionGestureRecognizer: UIPanGestureRecognizer {
    var validatedGesture = false
    var firstLocation: CGPoint = CGPoint()
    
    override init(target: AnyObject?, action: Selector) {
        super.init(target: target, action: action)
        
        self.maximumNumberOfTouches = 1
    }
    
    override func reset() {
        super.reset()
        
        validatedGesture = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        self.firstLocation = touches.first!.locationInView(self.view)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        let location = touches.first!.locationInView(self.view)
        let translation = CGPoint(x: location.x - firstLocation.x, y: location.y - firstLocation.y)
        
        if !validatedGesture {
            if self.firstLocation.x < 16.0 {
                validatedGesture = true
            } else if translation.x < 0.0 {
                self.state = .Failed
            } else if abs(translation.y) > 2.0 && abs(translation.y) > abs(translation.x) * 2.0 {
                self.state = .Failed
            } else if abs(translation.x) > 2.0 && abs(translation.y) * 2.0 < abs(translation.x) {
                validatedGesture = true
            }
        }
        
        if validatedGesture {
            super.touchesMoved(touches, withEvent: event)
        }
    }
}