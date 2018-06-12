//
//  MyView.swift
//  draw
//
//  Created by pete on 2018-05-27.
//  Copyright © 2018 pete. All rights reserved.
//

import Cocoa

class MyView: NSView
{
    var dragging :Bool = false
    var ctx: CGContext?
    
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
        print ("MyView: draw called")
        // Drawing code here.
        if let ctx = NSGraphicsContext.current?.cgContext
        {
            // do drawing
            ctx.saveGState()
            shape()
            ctx.restoreGState()
        }
        
    }
    
    func shape()
    {
        
        //// shape Drawing
        print ("MyView: func shape")
        
            //// Star Drawing
        
        let path = NSBezierPath()
        path.move(to: NSPoint(x: self.bounds.minX + 0.50625 * self.bounds.width, y: self.bounds.minY + 0.93750 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.61165 * self.bounds.width, y: self.bounds.minY + 0.61286 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.95503 * self.bounds.width, y: self.bounds.minY + 0.61360 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.67679 * self.bounds.width, y: self.bounds.minY + 0.41371 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.78361 * self.bounds.width, y: self.bounds.minY + 0.08952 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.50625 * self.bounds.width, y: self.bounds.minY + 0.29063 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.22889 * self.bounds.width, y: self.bounds.minY + 0.08952 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.33571 * self.bounds.width, y: self.bounds.minY + 0.41371 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.05747 * self.bounds.width, y: self.bounds.minY + 0.61360 * self.bounds.height))
        path.line(to: NSPoint(x: self.bounds.minX + 0.40085 * self.bounds.width, y: self.bounds.minY + 0.61286 * self.bounds.height))
        path.close()
        NSColor.red.setStroke()
        path.lineWidth = 1
        path.stroke()
        
        let outlinePath = NSBezierPath(roundedRect: NSRect(x: self.bounds.minX , y: self.bounds.minY, width: self.bounds.width, height: self.bounds.height), xRadius: 6, yRadius: 6)
        NSColor.black.setStroke()
        outlinePath.lineWidth = 4
        outlinePath.stroke()
        
    }
    



}
