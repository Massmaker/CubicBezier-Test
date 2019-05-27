//
//  BezierMath.h
//  CubicBezier test
//
//  Created by Ivan Iavorin on 5/27/19.
//  Copyright © 2019 Ivan Iavorin. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGPoint CubicBezierPointAt(CGPoint p1, CGPoint p2, CGPoint p3, CGPoint p4, CGFloat t);
extern NSArray* CubicBezierExtremums(CGPoint p1, CGPoint p2, CGPoint p3, CGPoint p4);


extern CGPoint CGPoint_between(CGPoint a, CGPoint b, double ratio);
extern CGPoint CGPoint_mid(CGPoint a, CGPoint b);
extern CGFloat CGPoint_distance(CGPoint a, CGPoint b);
