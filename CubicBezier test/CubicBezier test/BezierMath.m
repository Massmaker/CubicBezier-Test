//
//  BezierMath.m
//  CubicBezier test
//
//  Created by Ivan Iavorin on 5/27/19.
//  Copyright © 2019 Ivan Iavorin. All rights reserved.
//

#import "BezierMath.h"

#pragma mark - Cubic Bezier

/// p1, p4 - ends of a line, p2, p3 - control point values, t - distance from line start (0.0 up to 1.0)
CGFloat CubicBezier(CGFloat p1, CGFloat p2, CGFloat p3, CGFloat p4, CGFloat t) {
   
   CGFloat result = p1*pow(1-t, 3) + 3.0*p2*pow(1-t, 2)*t + 3*p3*(1-t)*pow(t,2) + p4*pow(t,3);
   return result;
}

CGPoint CubicBezierPointAt(CGPoint p1, CGPoint p2, CGPoint p3, CGPoint p4, CGFloat t) {
   CGFloat x = CubicBezier(p1.x, p2.x, p3.x, p4.x, t);
   CGFloat y = CubicBezier(p1.y, p2.y, p3.y, p4.y, t);
   
   return CGPointMake(x, y);
}

NSArray* CubicBezierExtremums(CGPoint p1, CGPoint p2, CGPoint p3, CGPoint p4) {
   
   // adapted to OBJ-c from here
   // https://stackoverflow.com/questions/2587751/an-algorithm-to-find-bounding-box-of-closed-bezier-curves
   
   
   CGFloat a, b, c, t, t1, t2, b2ac, sqrtb2ac;
   NSMutableArray *tValues = [NSMutableArray new];
   
   for (int i = 0; i < 2; i++) {
      if (i == 0) {
         a = 3 * (-p1.x + 3 * p2.x - 3 * p3.x + p4.x);
         b = 6 * (p1.x - 2 * p2.x +  p3.x);
         c = 3 * (p2.x - p1.x);
      }
      else {
         a = 3 * (-p1.y + 3 * p2.y - 3 * p3.y + p4.y);
         b = 6 * (p1.y - 2 * p2.y +  p3.y);
         c = 3 * (p2.y - p1.y);
      }
      
      if(ABS(a) < CGFLOAT_MIN) {// Numerical robustness
         if (ABS(b) < CGFLOAT_MIN) {// Numerical robustness
            continue;
         }
         
         t = -c / b;
         
         if (t > 0 && t < 1) {
            [tValues addObject:[NSNumber numberWithDouble:t]];
         }
         continue;
      }
      
      b2ac = pow(b, 2) - 4 * c * a;
      
      if (b2ac < 0) {
         continue;
      }
      
      sqrtb2ac = sqrt(b2ac);
      
      t1 = (-b + sqrtb2ac) / (2 * a);
      
      if (t1 > 0.0 && t1 < 1.0) {
         [tValues addObject:[NSNumber numberWithDouble:t1]];
      }
      
      t2 = (-b - sqrtb2ac) / (2 * a);
      
      if (t2 > 0.0 && t2 < 1.0) {
         [tValues addObject:[NSNumber numberWithDouble:t2]];
      }
   }
   
   int j = (int)tValues.count;

   CGFloat x = 0;
   CGFloat y = 0;
   NSMutableArray *xValues = [NSMutableArray new];
   NSMutableArray *yValues = [NSMutableArray new];
   
   while (j--) {
      t = [[tValues objectAtIndex:j] doubleValue];
      x = CubicBezier(p1.x, p2.x, p3.x, p4.x, t);
      y = CubicBezier(p1.y, p2.y, p3.y, p4.y, t);
      [xValues addObject:[NSNumber numberWithDouble:x]];
      [yValues addObject:[NSNumber numberWithDouble:y]];
   }
   
   [xValues addObject:[NSNumber numberWithDouble:p1.x]];
   [xValues addObject:[NSNumber numberWithDouble:p4.x]];
   [yValues addObject:[NSNumber numberWithDouble:p1.y]];
   [yValues addObject:[NSNumber numberWithDouble:p4.y]];
   
   //find minX, minY, maxX, maxY
   CGFloat minX = [[xValues valueForKeyPath:@"@min.self"] doubleValue];
   CGFloat minY = [[yValues valueForKeyPath:@"@min.self"] doubleValue];
   CGFloat maxX = [[xValues valueForKeyPath:@"@max.self"] doubleValue];
   CGFloat maxY = [[yValues valueForKeyPath:@"@max.self"] doubleValue];
   
   CGPoint origin = CGPointMake(minX, minY);
   CGPoint bottomRight = CGPointMake(maxX, maxY);
   
   NSArray *toReturn = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:origin],
                        [NSValue valueWithCGPoint:bottomRight],
                        nil];
   
   return toReturn;
}


double dbl_between(double min, double max, double ratio) {
   return (min + ratio * (max - min));
}

double dbl_mid(double min, double max) {
   return dbl_between(min, max, 0.5);
}

double dbl_relative(double min, double max, double value) {
   return ((min != max) ? ((value - min) / (max - min)) : 0.0);
}



CGPoint CGPoint_between(CGPoint a, CGPoint b, double ratio) {
   return CGPointMake(dbl_between(a.x, b.x, ratio),
                      dbl_between(a.y, b.y, ratio));
}

CGFloat CGPoint_distance(CGPoint a, CGPoint b) {
   return hypot((b.x - a.x), (b.y - a.y));
}

extern CGPoint CGPoint_mid(CGPoint a, CGPoint b) {
   return CGPoint_between(a, b, 0.5);
}
