//
//  Logo.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import Foundation
import SwiftUI

struct Logo: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.5 * width, y: height))
        path.addCurve(to: CGPoint(x: width, y: 0.5 * height), control1: CGPoint(x: 0.77614 * width, y: height), control2: CGPoint(x: width, y: 0.77614 * height))
        path.addCurve(to: CGPoint(x: 0.5 * width, y: 0), control1: CGPoint(x: width, y: 0.22386 * height), control2: CGPoint(x: 0.77614 * width, y: 0))
        path.addCurve(to: CGPoint(x: 0, y: 0.5 * height), control1: CGPoint(x: 0.22386 * width, y: 0), control2: CGPoint(x: 0, y: 0.22386 * height))
        path.addCurve(to: CGPoint(x: 0.5 * width, y: height), control1: CGPoint(x: 0, y: 0.77614 * height), control2: CGPoint(x: 0.22386 * width, y: height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.51016 * width, y: 0.99987 * height))
        path.addCurve(to: CGPoint(x: width, y: 0.5 * height), control1: CGPoint(x: 0.78161 * width, y: 0.99446 * height), control2: CGPoint(x: width, y: 0.77274 * height))
        path.addCurve(to: CGPoint(x: 0.99972 * width, y: 0.48409 * height), control1: CGPoint(x: width, y: 0.49468 * height), control2: CGPoint(x: 0.99989 * width, y: 0.48938 * height))
        path.addLine(to: CGPoint(x: 0.75107 * width, y: 0.23544 * height))
        path.addLine(to: CGPoint(x: 0.63605 * width, y: 0.43729 * height))
        path.addLine(to: CGPoint(x: 0.29461 * width, y: 0.7599 * height))
        path.addLine(to: CGPoint(x: 0.38499 * width, y: 0.85028 * height))
        path.addLine(to: CGPoint(x: 0.37092 * width, y: 0.86062 * height))
        path.addLine(to: CGPoint(x: 0.51016 * width, y: 0.99987 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.41568 * width, y: 0.72633 * height))
        path.addLine(to: CGPoint(x: 0.37091 * width, y: 0.72633 * height))
        path.addLine(to: CGPoint(x: 0.37091 * width, y: 0.86063 * height))
        path.addLine(to: CGPoint(x: 0.41568 * width, y: 0.86063 * height))
        path.addLine(to: CGPoint(x: 0.41568 * width, y: 0.72633 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.35973 * width, y: 0.7599 * height))
        path.addLine(to: CGPoint(x: 0.72125 * width, y: 0.7599 * height))
        path.addCurve(to: CGPoint(x: 0.76262 * width, y: 0.71853 * height), control1: CGPoint(x: 0.7441 * width, y: 0.7599 * height), control2: CGPoint(x: 0.76262 * width, y: 0.74138 * height))
        path.addLine(to: CGPoint(x: 0.76262 * width, y: 0.26408 * height))
        path.addCurve(to: CGPoint(x: 0.72125 * width, y: 0.22271 * height), control1: CGPoint(x: 0.76262 * width, y: 0.24123 * height), control2: CGPoint(x: 0.7441 * width, y: 0.22271 * height))
        path.addLine(to: CGPoint(x: 0.35973 * width, y: 0.22271 * height))
        path.addLine(to: CGPoint(x: 0.35973 * width, y: 0.7599 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.72125 * width, y: 0.2227 * height))
        path.addLine(to: CGPoint(x: 0.55948 * width, y: 0.2227 * height))
        path.addLine(to: CGPoint(x: 0.55948 * width, y: 0.7599 * height))
        path.addLine(to: CGPoint(x: 0.72125 * width, y: 0.7599 * height))
        path.addCurve(to: CGPoint(x: 0.76262 * width, y: 0.71853 * height), control1: CGPoint(x: 0.7441 * width, y: 0.7599 * height), control2: CGPoint(x: 0.76262 * width, y: 0.74138 * height))
        path.addLine(to: CGPoint(x: 0.76262 * width, y: 0.26408 * height))
        path.addCurve(to: CGPoint(x: 0.72125 * width, y: 0.2227 * height), control1: CGPoint(x: 0.76263 * width, y: 0.24123 * height), control2: CGPoint(x: 0.7441 * width, y: 0.2227 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.37599 * width, y: 0.22269 * height))
        path.addLine(to: CGPoint(x: 0.29461 * width, y: 0.22269 * height))
        path.addLine(to: CGPoint(x: 0.29461 * width, y: 0.7599 * height))
        path.addLine(to: CGPoint(x: 0.37599 * width, y: 0.7599 * height))
        path.addLine(to: CGPoint(x: 0.37599 * width, y: 0.22269 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.64746 * width, y: 0.41172 * height))
        path.addCurve(to: CGPoint(x: 0.62373 * width, y: 0.41698 * height), control1: CGPoint(x: 0.63897 * width, y: 0.41172 * height), control2: CGPoint(x: 0.63094 * width, y: 0.41362 * height))
        path.addCurve(to: CGPoint(x: 0.56321 * width, y: 0.37513 * height), control1: CGPoint(x: 0.6145 * width, y: 0.39253 * height), control2: CGPoint(x: 0.59089 * width, y: 0.37513 * height))
        path.addCurve(to: CGPoint(x: 0.5027 * width, y: 0.41698 * height), control1: CGPoint(x: 0.53553 * width, y: 0.37513 * height), control2: CGPoint(x: 0.51193 * width, y: 0.39253 * height))
        path.addCurve(to: CGPoint(x: 0.47897 * width, y: 0.41172 * height), control1: CGPoint(x: 0.49549 * width, y: 0.41361 * height), control2: CGPoint(x: 0.48745 * width, y: 0.41172 * height))
        path.addCurve(to: CGPoint(x: 0.42281 * width, y: 0.46789 * height), control1: CGPoint(x: 0.44795 * width, y: 0.41172 * height), control2: CGPoint(x: 0.42281 * width, y: 0.43687 * height))
        path.addCurve(to: CGPoint(x: 0.47897 * width, y: 0.52405 * height), control1: CGPoint(x: 0.42281 * width, y: 0.4989 * height), control2: CGPoint(x: 0.44795 * width, y: 0.52405 * height))
        path.addCurve(to: CGPoint(x: 0.49301 * width, y: 0.52225 * height), control1: CGPoint(x: 0.48382 * width, y: 0.52405 * height), control2: CGPoint(x: 0.48852 * width, y: 0.5234 * height))
        path.addLine(to: CGPoint(x: 0.49301 * width, y: 0.66445 * height))
        path.addLine(to: CGPoint(x: 0.63342 * width, y: 0.66445 * height))
        path.addLine(to: CGPoint(x: 0.63342 * width, y: 0.52225 * height))
        path.addCurve(to: CGPoint(x: 0.64746 * width, y: 0.52405 * height), control1: CGPoint(x: 0.63791 * width, y: 0.5234 * height), control2: CGPoint(x: 0.64261 * width, y: 0.52405 * height))
        path.addCurve(to: CGPoint(x: 0.70362 * width, y: 0.46788 * height), control1: CGPoint(x: 0.67847 * width, y: 0.52405 * height), control2: CGPoint(x: 0.70362 * width, y: 0.4989 * height))
        path.addCurve(to: CGPoint(x: 0.64746 * width, y: 0.41172 * height), control1: CGPoint(x: 0.70362 * width, y: 0.43687 * height), control2: CGPoint(x: 0.67847 * width, y: 0.41172 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.64746 * width, y: 0.41172 * height))
        path.addCurve(to: CGPoint(x: 0.62373 * width, y: 0.41698 * height), control1: CGPoint(x: 0.63897 * width, y: 0.41172 * height), control2: CGPoint(x: 0.63094 * width, y: 0.41362 * height))
        path.addCurve(to: CGPoint(x: 0.56321 * width, y: 0.37513 * height), control1: CGPoint(x: 0.6145 * width, y: 0.39253 * height), control2: CGPoint(x: 0.59089 * width, y: 0.37513 * height))
        path.addCurve(to: CGPoint(x: 0.55949 * width, y: 0.37528 * height), control1: CGPoint(x: 0.56196 * width, y: 0.37513 * height), control2: CGPoint(x: 0.56072 * width, y: 0.37521 * height))
        path.addLine(to: CGPoint(x: 0.55949 * width, y: 0.66445 * height))
        path.addLine(to: CGPoint(x: 0.63342 * width, y: 0.66445 * height))
        path.addLine(to: CGPoint(x: 0.63342 * width, y: 0.52224 * height))
        path.addCurve(to: CGPoint(x: 0.64746 * width, y: 0.52404 * height), control1: CGPoint(x: 0.63791 * width, y: 0.5234 * height), control2: CGPoint(x: 0.64261 * width, y: 0.52404 * height))
        path.addCurve(to: CGPoint(x: 0.70362 * width, y: 0.46788 * height), control1: CGPoint(x: 0.67847 * width, y: 0.52404 * height), control2: CGPoint(x: 0.70362 * width, y: 0.4989 * height))
        path.addCurve(to: CGPoint(x: 0.64746 * width, y: 0.41172 * height), control1: CGPoint(x: 0.70362 * width, y: 0.43687 * height), control2: CGPoint(x: 0.67847 * width, y: 0.41172 * height))
        path.closeSubpath()
        return path
    }
}
