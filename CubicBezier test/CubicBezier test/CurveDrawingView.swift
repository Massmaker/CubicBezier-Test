//
//  CurveDrawingView.swift
//  CubicBezier test
//
//  Created by Ivan Iavorin on 5/27/19.
//  Copyright © 2019 Ivan Iavorin. All rights reserved.
//

import UIKit

class CurveDrawingView: UIView {

    override func draw(_ rect: CGRect) {
      
      let start = CGPoint(x: 10, y: rect.midY)
      let end = CGPoint(x:rect.maxX-10, y:start.y + 50)
      let distance = CGPoint_distance(start, end)
      //swap(&end, &start)
      let cp1 = CGPoint(x:rect.midX - distance / 3.0, y:50)
      let cp2 = CGPoint(x:rect.midX + distance / 4.0 ,y:rect.maxY - 50)
      //swap(&cp1, &cp2)
      let curve = UIBezierPath()
      curve.lineWidth = 2.0
      curve.move(to: start)
      curve.addCurve(to: end,
                     controlPoint1: cp1,
                     controlPoint2: cp2)
      
      UIColor.black.setStroke()
      curve.stroke()
      
      let point1dot = UIBezierPath()
      point1dot.move(to: cp1)
      point1dot.addArc(withCenter: cp1, radius: 3, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
      
      UIColor.red.setFill()
      point1dot.fill()
      
      let point2dot = UIBezierPath()
      point2dot.addArc(withCenter: cp2, radius: 3, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
      
      point2dot.fill()
      
      let t:CGFloat = 0.5
      //tweak the t value 0.0->1.0 to move the point on arc further to the arc`s end or beginninng
      let pointOnArc = CubicBezierPointAt(start, cp1, cp2, end, t)
      let arcDot = UIBezierPath()
      arcDot.addArc(withCenter: pointOnArc, radius: 3, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
      UIColor.blue.setFill()
      arcDot.fill()
      
      
      UIColor.green.setFill()
      let midDot = CGPoint_mid(start, end)
      let betweenEdgeDots = UIBezierPath()
      betweenEdgeDots.addArc(withCenter:midDot ,
                             radius: 3,
                             startAngle: 0,
                             endAngle: CGFloat.pi * 2,
                             clockwise: true)
      betweenEdgeDots.fill()
      
      let midBetweenControlPoints = CGPoint_mid(cp1, cp2)
      let midCPDot = UIBezierPath()
      midCPDot.addArc(withCenter: midBetweenControlPoints,
                      radius: 3,
                      startAngle: 0,
                      endAngle: CGFloat.pi * 2,
                      clockwise: true)
      
      midCPDot.fill()
      
      
      if let extremae = CubicBezierExtremums(start, cp1, cp2, end) as? [CGPoint], extremae.count == 2 {
         let tlPoint = extremae[0]
         let brPoint = extremae[1]
         let width = brPoint.x - tlPoint.x
         let height = brPoint.y - tlPoint.y
         let rect = CGRect(origin: tlPoint, size: CGSize(width: width, height: height))
         let boundingBox = UIBezierPath(rect: rect)
         UIColor.brown.setStroke()
         boundingBox.stroke()
      }
      
      
      let startEndLine = UIBezierPath()
      startEndLine.move(to: start)
      startEndLine.addLine(to: end)
      var lineDash:[CGFloat] = [3.0,3.0]
      startEndLine.setLineDash(&lineDash, count: 2, phase: 0)
      
      UIColor.black.setStroke()
      startEndLine.stroke()
    }
 
}
