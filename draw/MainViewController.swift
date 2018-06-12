//
//  MyViewController.swift
//  draw
//
//  Created by pete on 2018-05-30.
//  Copyright © 2018 pete. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var window: NSWindow!
    
    @IBOutlet weak var frameOrigin_x: NSTextField!
    @IBOutlet weak var frameOrigin_y: NSTextField!
    @IBOutlet weak var mainView: NSView!
    @IBOutlet weak var topLeft_x: NSTextField!
    @IBOutlet weak var topLeft_y: NSTextField!
    @IBOutlet weak var topRight_x: NSTextField!
    @IBOutlet weak var topRight_y: NSTextField!
    @IBOutlet weak var bottomLeft_x: NSTextField!
    @IBOutlet weak var bottomLeft_y: NSTextField!
    @IBOutlet weak var bottomRight_x: NSTextField!
    @IBOutlet weak var bottomRight_y: NSTextField!
    @IBOutlet weak var origin_x: NSTextField!
    @IBOutlet weak var origin_y: NSTextField!
    
    var mouseDownPoint: CGPoint = NSZeroPoint
    var myFrame = NSZeroRect
    var dragging = false
    var myView: MyView!
    var myViewRect: NSRect!
    var myViewTag:Int!
    var i:Int = 0
    var oldPoint: NSPoint = NSZeroPoint
    var newPoint: NSPoint = NSZeroPoint
    var trackingArea: NSTrackingArea!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        myView = MyView()
        myView.wantsLayer = true // must be used if you want to set the background colour of the view
        myView.layer?.backgroundColor = CGColor(red: 0, green: 255, blue: 0, alpha: 0.5)

        myView.frame  = NSRect(x: 300.0, y: 300.0, width: 40.0, height: 40.0)
        myView.bounds = NSRect(x:   0.0, y:   0.0, width: 40.0, height: 40.0)


        print("MainViewController: myView frame is \(myView.frame)")
        print("MainViewController: myView bounds is \(myView.bounds)")
        myView.draw(myView.bounds)
        
        mainView.addSubview(myView)
        
  
        // Do view setup here.
        print("MainViewController: view did load")
        displayCoords()
        
        // try to get cursor to change when entering the subview
        self.trackingArea = NSTrackingArea(rect: myView.frame, options: [NSTrackingArea.Options.mouseEnteredAndExited,
                                                                        NSTrackingArea.Options.activeAlways,
                                                                        NSTrackingArea.Options.enabledDuringMouseDrag], owner: self, userInfo: nil)
        mainView.addTrackingArea(self.trackingArea)


    }
    
    // Mouse Functions
    override func mouseEntered(with event: NSEvent)
    {
        if dragging == true
        {   NSCursor.closedHand.set()   }
        else
        {   NSCursor.openHand.set()     }
    }

    override func mouseExited(with event: NSEvent)
    {
        NSCursor.arrow.set()
    }
    
    override func mouseUp(with event: NSEvent)
    {
        dragging = false;
 
    // finished dragging, restore the cursor
    
    }

    override func mouseDown(with event: NSEvent)
   {
        // get the location in the window where the mouse button is pressed
        // set "dragging" to false
        // check whether the mouse down point is within the view rectangle to be dragged
        // If it is within the rectangle, set the dragging status to TRUE and set the "oldPoint variable to the initial mouse down point
        // Note that you dont have to single press the mouse to get a mouseDown event.
        // A drag will also cause a single mouseDown event at the start of the drag
        let mouseDownPoint = (window?.mouseLocationOutsideOfEventStream)!
        dragging = false
 
        if (mouseDownPoint.x > myView.frame.minX) && (mouseDownPoint.x < myView.frame.maxX)
        {
            if (mouseDownPoint.y > myView.frame.minY) && (mouseDownPoint.y < myView.frame.maxY)
            {
                dragging  = true
                oldPoint = mouseDownPoint
                NSCursor.closedHand.set()

            }
        }
    // print ( "MouseDown: MouseDown Point: (\(mouseDownPoint.x), \(mouseDownPoint.y) dragging = \(dragging)")
   }

    override func mouseDragged(with event: NSEvent)
    {
        // Redraw the view rectangle by calculating a new coordinate for the bottom left point
        // The origin is the current bottom left point of the view rectangle
        // The MouseDown function determine whether we are dragging
        // If we are dragging, get the current mouse position in the window frame as "newPoint"
        // Get the size of the subView rectangle
        // Calculate a new frame which is located at the old frame origin plus the difference between the current and the last mouse coordinates
        // Update the previous mouse position with the current mouse position
        let origin:   NSPoint = self.myView.frame.origin  // this is the bottom corner of the view rectangle
        if dragging == true
        {
            newPoint = (window?.mouseLocationOutsideOfEventStream)!
            
                // find the location of the mouse within the bounds of myView subview (myView coords, not mainview coords)
                let size   = self.myView.bounds.size
                i += 1

                // define a new frame for the subview
                myView.frame = NSRect(x:  origin.x + (newPoint.x - oldPoint.x), y: origin.y + (newPoint.y - oldPoint.y) , width: size.width, height: size.height)
            
            
            oldPoint = newPoint
            // print("MouseDragged: \(i) - minX: \(myView.frame.minX), minY: \(myView.frame.minY) maxX: \(myView.frame.maxX), maxY: \(myView.frame.maxY)")
        
            // try to get cursor to change when entering the subview
            
            mainView.removeTrackingArea( self.trackingArea)
            self.trackingArea = NSTrackingArea(rect: myView.frame, options: [NSTrackingArea.Options.mouseEnteredAndExited,
                                                                            NSTrackingArea.Options.activeAlways,
                                                                            NSTrackingArea.Options.enabledDuringMouseDrag], owner: self, userInfo: nil)
            mainView.addTrackingArea(trackingArea)

        }
        displayCoords()
 

        
    }
    
    func displayCoords()
    {
        origin_x.stringValue = "\(myView.frame.origin.x.rounded())"
        origin_y.stringValue = "\(myView.frame.origin.y.rounded())"
        
        topLeft_x.stringValue = "\(self.myView.frame.minX.rounded())"
        topLeft_y.stringValue = "\(self.myView.frame.maxY.rounded())"
        
        topRight_x.stringValue = "\(self.myView.frame.maxX.rounded())"
        topRight_y.stringValue = "\(self.myView.frame.maxY.rounded())"
        
        bottomLeft_x.stringValue = "\(self.myView.frame.minX.rounded())"
        bottomLeft_y.stringValue = "\(self.myView.frame.minY.rounded())"
        
        bottomRight_x.stringValue = "\(self.myView.frame.maxX.rounded())"
        bottomRight_y.stringValue = "\(self.myView.frame.minY.rounded())"

    }
    
}
