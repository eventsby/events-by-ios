//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
    typealias PView = UIView
    typealias PEdgeInsets = UIEdgeInsets
#else
    import AppKit
    typealias PView = NSView
    typealias PEdgeInsets = NSEdgeInsets
#endif

class PinLayoutImpl: PinLayout {
    internal let view: PView
    internal let keepTransform: Bool

    internal var _top: CGFloat?       // offset from superview's top edge
    internal var _left: CGFloat?      // offset from superview's left edge
    internal var _bottom: CGFloat?    // offset from superview's top edge
    internal var _right: CGFloat?     // offset from superview's left edge
    
    internal var _hCenter: CGFloat?
    internal var _vCenter: CGFloat?
    
    internal var width: CGFloat?
    internal var minWidth: CGFloat?
    internal var maxWidth: CGFloat?
    internal var height: CGFloat?
    internal var minHeight: CGFloat?
    internal var maxHeight: CGFloat?

    internal var fitType: FitType?
    internal var legacyFitSize = false
    internal var _aspectRatio: CGFloat?

    internal var shouldKeepViewDimension: Bool {
        return fitType == nil && !legacyFitSize && _aspectRatio == nil
    }
    
    internal var marginTop: CGFloat?
    internal var marginLeft: CGFloat?
    internal var marginBottom: CGFloat?
    internal var marginRight: CGFloat?
    internal var shouldPinEdges = false
    
    internal var justify: HorizontalAlign?
    internal var align: VerticalAlign?
    
    internal var _marginTop: CGFloat { return marginTop ?? 0 }
    internal var _marginLeft: CGFloat { return marginLeft ?? 0 }
    internal var _marginBottom: CGFloat { return marginBottom ?? 0 }
    internal var _marginRight: CGFloat { return marginRight ?? 0 }
    
    internal var isLayouted = false

    init(view: PView, keepTransform: Bool) {
        self.view = view
        self.keepTransform = keepTransform

        #if os(iOS) || os(tvOS)
        Pin.initPinLayout()
        #endif
    }
    
    deinit {
        if !isLayouted && Pin.logMissingLayoutCalls {
            warn("PinLayout commands have been issued without calling the 'layout()' method to complete the layout. (These warnings can be disabled by setting Pin.logMissingLayoutCalls to false)")
        }
        apply()
    }

    #if os(iOS) || os(tvOS)
    var safeArea: PEdgeInsets {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            return view.pinlayoutComputeSafeAreaInsets()
        }
    }
    #endif

    //
    // top, left, bottom, right
    //
    @discardableResult func top() -> PinLayout {
        top({ return "top()" })
        return self
    }

    @discardableResult
    func top(_ value: CGFloat) -> PinLayout {
        return top(value, { return "top(\(value))" })
    }
    
    @discardableResult
    func top(_ percent: Percent) -> PinLayout {
        func context() -> String { return "top(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTop(percent.of(layoutSuperviewRect.height), context)
        return self
    }

    @discardableResult
    func top(_ insets: PEdgeInsets) -> PinLayout {
        return top(insets.top, { return "top(\(insetsDescription(insets))" })
    }
    
    @discardableResult
    func left() -> PinLayout {
        return left({ return "left()" })
    }

    @discardableResult
    func left(_ value: CGFloat) -> PinLayout {
        return left(value, { return "left(\(value))" })
    }
    
    @discardableResult
    func left(_ percent: Percent) -> PinLayout {
        return left(percent, { return "left(\(percent.description))" })
    }

    @discardableResult
    func left(_ insets: PEdgeInsets) -> PinLayout {
        return left(insets.left, { return "left(\(insetsDescription(insets))" })
    }
    
    @discardableResult
    func start() -> PinLayout {
        func context() -> String { return "start()" }
        return isLTR() ? left(context) : right(context)
    }
    
    @discardableResult
    func start(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "start(\(value))" }
        return isLTR() ? left(value, context) : right(value, context)
    }
    
    @discardableResult
    func start(_ percent: Percent) -> PinLayout {
        func context() -> String { return "start(\(percent.description))" }
        return isLTR() ? left(percent, context) : right(percent, context)
    }

    @discardableResult
    func start(_ insets: PEdgeInsets) -> PinLayout {
        func context() -> String { return "start(\(insetsDescription(insets))" }
        return isLTR() ? left(insets.left, context) : right(insets.right, context)
    }
    
    @discardableResult func bottom() -> PinLayout {
        return bottom({ return "bottom()" })
    }

    @discardableResult
    func bottom(_ value: CGFloat) -> PinLayout {
        return bottom(value, { return "bottom(\(value))" })
    }
    
    @discardableResult
    func bottom(_ percent: Percent) -> PinLayout {
        return bottom(percent, { return "bottom(\(percent.description))" })
    }

    @discardableResult
    func bottom(_ insets: PEdgeInsets) -> PinLayout {
        return bottom(insets.bottom, { return "bottom(\(insetsDescription(insets))" })
    }

    @discardableResult func right() -> PinLayout {
        return right({ return "right()" })
    }

    @discardableResult
    func right(_ value: CGFloat) -> PinLayout {
        return right(value, { return "right(\(value))" })
    }
    
    @discardableResult
    func right(_ percent: Percent) -> PinLayout {
        return right(percent, { return "right(\(percent.description))" })
    }

    @discardableResult
    func right(_ insets: PEdgeInsets) -> PinLayout {
        return right(insets.right, { return "right(\(insetsDescription(insets))" })
    }
    
    @discardableResult func end() -> PinLayout {
        func context() -> String { return "end()" }
        return isLTR() ? right(context) : left(context)
    }
    
    @discardableResult
    func end(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "end(\(value))" }
        return isLTR() ? right(value, context) : left(value, context)
    }
    
    @discardableResult
    func end(_ percent: Percent) -> PinLayout {
        func context() -> String { return "end(\(percent.description))" }
        return isLTR() ? right(percent, context) : left(percent, context)
    }

    @discardableResult
    func end(_ insets: PEdgeInsets) -> PinLayout {
        func context() -> String { return "end(\(insetsDescription(insets))" }
        return isLTR() ? right(insets.right, context) : left(insets.left, context)
    }

    @discardableResult
    func hCenter() -> PinLayout {
        func context() -> String { return "hCenter()" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setHorizontalCenter(layoutSuperviewRect.width / 2, context)
        return self
    }
    
    @discardableResult
    func hCenter(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "hCenter(\(value))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setHorizontalCenter((layoutSuperviewRect.width / 2) + value, context)
        return self
    }
    
    @discardableResult
    func hCenter(_ percent: Percent) -> PinLayout {
        func context() -> String { return "hCenter(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setHorizontalCenter((layoutSuperviewRect.width / 2) + percent.of(layoutSuperviewRect.width), context)
        return self
    }

    @discardableResult
    func vCenter() -> PinLayout {
        func context() -> String { return "vCenter()" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setVerticalCenter(layoutSuperviewRect.height / 2, context)
        return self
    }
    
    @discardableResult
    func vCenter(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "vCenter(\(value))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setVerticalCenter((layoutSuperviewRect.height / 2) + value, context)
        return self
    }
    
    @discardableResult
    func vCenter(_ percent: Percent) -> PinLayout {
        func context() -> String { return "vCenter(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setVerticalCenter((layoutSuperviewRect.height / 2) + percent.of(layoutSuperviewRect.height), context)
        return self
    }
    
    @discardableResult
    func all() -> PinLayout {
        top({ "all() top coordinate" })
        bottom({ "all() bottom coordinate" })
        right({ "all() right coordinate" })
        left({ "all() left coordinate" })
        return self
    }

    @discardableResult
    func all(_ value: CGFloat) -> PinLayout {
        top(value,  { "all(\(value)) top coordinate" })
        bottom(value,  { "all(\(value)) bottom coordinate" })
        left(value,  { "all(\(value)) left coordinate" })
        right(value,  { "all(\(value)) right coordinate" })
        return self
    }

    func all(_ insets: PEdgeInsets) -> PinLayout {
        top(insets.top,  { "all(\(insets)) top coordinate" })
        bottom(insets.bottom,  { "all(\(insets)) bottom coordinate" })
        left(insets.left,  { "all(\(insets)) left coordinate" })
        right(insets.right,  { "all(\(insets)) right coordinate" })
        return self
    }
    
    @discardableResult
    func horizontally() -> PinLayout {
        right({ "horizontally() right coordinate" })
        left({ "horizontally() left coordinate" })
        return self
    }

    @discardableResult
    func horizontally(_ value: CGFloat) -> PinLayout {
        left(value, { return "horizontally(\(value)) left coordinate" })
        right(value, { return "horizontally(\(value)) right coordinate" })
        return self
    }

    @discardableResult
    func horizontally(_ percent: Percent) -> PinLayout {
        left(percent, { return "horizontally(\(percent.description)) left coordinate" })
        right(percent, { return "horizontally(\(percent.description)) right coordinate" })
        return self
    }

    @discardableResult
    func horizontally(_ insets: PEdgeInsets) -> PinLayout {
        left(insets.left, { return "horizontally(\(insets)) left coordinate" })
        right(insets.right, { return "horizontally(\(insets)) right coordinate" })
        return self
    }

    @discardableResult
    func vertically() -> PinLayout {
        top({ "vertically() top coordinate" })
        bottom({ "vertically() bottom coordinate" })
        return self
    }

    @discardableResult
    func vertically(_ value: CGFloat) -> PinLayout {
        top(value, { return "vertically(\(value)) top coordinate" })
        bottom(value, { return "vertically(\(value)) bottom coordinate" })
        return self
    }

    @discardableResult
    func vertically(_ percent: Percent) -> PinLayout {
        top(percent, { return "vertically(\(percent.description)) top coordinate" })
        bottom(percent, { return "vertically(\(percent.description)) bottom coordinate" })
        return self
    }

    @discardableResult
    func vertically(_ insets: PEdgeInsets) -> PinLayout {
        top(insets.top, { return "vertically(\(insets)) top coordinate" })
        bottom(insets.bottom, { return "vertically(\(insets)) bottom coordinate" })
        return self
    }

    //
    // top, left, bottom, right
    //
    @discardableResult
    func top(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "top", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setTop(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func vCenter(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "vCenter", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setVerticalCenter(coordinate, context)
        }
        return self
    }

    @discardableResult
    func bottom(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "bottom", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setBottom(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func left(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "left", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setLeft(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func hCenter(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "hCenter", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setHorizontalCenter(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func right(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "right", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setRight(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func start(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "start", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setStart(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func end(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "end", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setEnd(coordinate, context)
        }
        return self
    }
    
    //
    // topLeft, topCenter, topRight,
    // centerLeft, center, centerRight,
    // bottomLeft, bottomCenter, bottomRight,
    //
    @discardableResult
    func topLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topLeft", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTopLeft(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func topLeft() -> PinLayout {
        return topLeft({ return "topLeft()" })
    }
    
    fileprivate func topLeft(_ context: Context) -> PinLayout {
        setTopLeft(CGPoint(x: 0, y: 0), { return "topLeft()" })
        return self
    }
    
    @discardableResult
    func topStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topStart", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTop(coordinatesList[0].y, context)
            setStart(coordinatesList[0].x, context)
        }
        return self
    }

    @discardableResult
    func topStart() -> PinLayout {
        func context() -> String { return "topStart()" }
        return isLTR() ? topLeft(context) : topRight(context)
    }
  
    @discardableResult
    func topCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topCenter", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTopCenter(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func topCenter() -> PinLayout {
        func context() -> String { return "topCenter()" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTopCenter(CGPoint(x: layoutSuperviewRect.width / 2, y: 0), context)
        return self
    }

    @discardableResult
    func topRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topRight", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTopRight(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func topRight() -> PinLayout {
        return topRight({ return "topRight()" })
    }
    
    fileprivate func topRight(_ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTopRight(CGPoint(x: layoutSuperviewRect.width, y: 0), context)
        return self
    }
    
    @discardableResult
    func topEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topEnd", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTop(coordinatesList[0].y, context)
            setEnd(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func topEnd() -> PinLayout {
        func context() -> String { return "topEnd()" }
        return isLTR() ? topRight(context) : topLeft(context)
    }
    
    @discardableResult
    func centerLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerLeft", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setCenterLeft(coordinatesList[0], context)
        }
        return self
    }
    
    @discardableResult
    func centerLeft() -> PinLayout {
        return centerLeft({ return "centerLeft()" })
    }
    
    fileprivate func centerLeft(_ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setCenterLeft(CGPoint(x: 0, y: layoutSuperviewRect.height / 2), context)
        return self
    }

    @discardableResult
    func centerStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerStart", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setVerticalCenter(coordinatesList[0].y, context)
            setStart(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult 
    func centerStart() -> PinLayout {
        func context() -> String { return "centerStart()" }
        return isLTR() ? centerLeft(context) : centerRight(context)
    }
    
    @discardableResult
    func center(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "center", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setCenter(coordinatesList[0], context)
        }
        return self
    }
    
    @discardableResult
    func center() -> PinLayout {
        func context() -> String { return "center()" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setCenter(CGPoint(x: layoutSuperviewRect.width / 2, y: layoutSuperviewRect.height / 2), context)
        return self
    }
    
    @discardableResult
    func centerRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerRight", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setCenterRight(coordinatesList[0], context)
        }
        return self
    }
    
    @discardableResult
    func centerRight() -> PinLayout {
        return centerRight({ return "centerRight()" })
    }
    
    @discardableResult
    fileprivate func centerRight(_ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setCenterRight(CGPoint(x: layoutSuperviewRect.width, y: layoutSuperviewRect.height / 2), context)
        return self
    }
    
    @discardableResult
    func centerEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerEnd", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setVerticalCenter(coordinatesList[0].y, context)
            setEnd(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func centerEnd() -> PinLayout {
        func context() -> String { return "centerEnd()" }
        return isLTR() ? centerRight(context) : centerLeft(context)
    }
    
    @discardableResult
    func bottomLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomLeft", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottomLeft(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func bottomLeft() -> PinLayout {
        return bottomLeft({ return "bottomLeft()" })
    }
    
    @discardableResult
    fileprivate func bottomLeft(_ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottomLeft(CGPoint(x: 0, y: layoutSuperviewRect.height), context)
        return self
    }
    
    @discardableResult
    func bottomStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomStart", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottom(coordinatesList[0].y, context)
            setStart(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func bottomStart() -> PinLayout {
        func context() -> String { return "bottomStart()" }
        return isLTR() ? bottomLeft(context) : bottomRight(context)
    }

    @discardableResult
    func bottomCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomCenter", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottomCenter(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func bottomCenter() -> PinLayout {
        func context() -> String { return "bottomCenter()" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottomCenter(CGPoint(x: layoutSuperviewRect.width / 2, y: layoutSuperviewRect.height), context)
        return self
    }

    @discardableResult
    func bottomRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomRight", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottomRight(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func bottomRight() -> PinLayout {
        return bottomRight({ return "bottomRight()" })
    }
    
    @discardableResult
    fileprivate func bottomRight(_ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottomRight(CGPoint(x: layoutSuperviewRect.width, y: layoutSuperviewRect.height), context)
        return self
    }

    @discardableResult
    func bottomEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomEnd", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottom(coordinatesList[0].y, context)
            setEnd(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func bottomEnd() -> PinLayout {
        func context() -> String { return "bottomEnd()" }
        return isLTR() ? bottomRight(context) : bottomLeft(context)
    }

    //
    // width, height
    //
    @discardableResult
    func width(_ width: CGFloat) -> PinLayout {
        return setWidth(width, { return "width(\(width))" })
    }
    
    @discardableResult
    func width(_ percent: Percent) -> PinLayout {
        func context() -> String { return "width(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setWidth(percent.of(layoutSuperviewRect.width), context)
    }

    @discardableResult
    func width(of view: PView) -> PinLayout {
        return setWidth(view.bounds.width, { return "width(of: \(viewDescription(view)))" })
    }
    
    @discardableResult
    func minWidth(_ width: CGFloat) -> PinLayout {
        setMinWidth(width, { return "minWidth(\(width))" })
        return self
    }
    
    @discardableResult
    func minWidth(_ percent: Percent) -> PinLayout {
        func context() -> String { return "minWidth(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMinWidth(percent.of(layoutSuperviewRect.width), context)
    }
    
    @discardableResult
    func maxWidth(_ width: CGFloat) -> PinLayout {
        setMaxWidth(width, { return "maxWidth(\(width))" })
        return self
    }
    
    @discardableResult
    func maxWidth(_ percent: Percent) -> PinLayout {
        func context() -> String { return "maxWidth(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMaxWidth(percent.of(layoutSuperviewRect.width), context)
    }

    @discardableResult
    func height(_ height: CGFloat) -> PinLayout {
        return setHeight(height, { return "height(\(height))" })
    }
    
    @discardableResult
    func height(_ percent: Percent) -> PinLayout {
        func context() -> String { return "height(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setHeight(percent.of(layoutSuperviewRect.height), context)
    }

    @discardableResult
    func height(of view: PView) -> PinLayout {
        return setHeight(view.bounds.height, { return "height(of: \(viewDescription(view)))" })
    }
    
    @discardableResult
    func minHeight(_ height: CGFloat) -> PinLayout {
        setMinHeight(height, { return "minHeight(\(height))" })
        return self
    }
    
    @discardableResult
    func minHeight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "minHeight(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMinHeight(percent.of(layoutSuperviewRect.height), context)
    }
    
    @discardableResult
    func maxHeight(_ height: CGFloat) -> PinLayout {
        setMaxHeight(height, { return "maxHeight(\(height))" })
        return self
    }
    
    @discardableResult
    func maxHeight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "maxHeight(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMaxHeight(percent.of(layoutSuperviewRect.height), context)
    }
    
    //
    // size, sizeToFit
    //
    @discardableResult
    func size(_ size: CGSize) -> PinLayout {
        return setSize(size, { return "size(CGSize(width: \(size.width), height: \(size.height)))" })
    }
    
    @discardableResult
    func size(_ sideLength: CGFloat) -> PinLayout {
        return setSize(CGSize(width: sideLength, height: sideLength), { return "size(sideLength: \(sideLength))" })
    }
    
    @discardableResult
    func size(_ percent: Percent) -> PinLayout {
        func context() -> String { return "size(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        let size = CGSize(width: percent.of(layoutSuperviewRect.width), height: percent.of(layoutSuperviewRect.height))
        return setSize(size, context)
    }
    
    @discardableResult
    func size(of view: PView) -> PinLayout {
        func context() -> String { return "size(of \(viewDescription(view)))" }
        return setSize(view.bounds.size, context)
    }
    
//    @discardableResult
//    func wrapSubViews() -> PinLayout {
//        let neededWidth = view.subviews.max(by: { subview1, subview2 in subview1.frame.maxX < subview2.frame.maxX })?.frame.maxX ?? 0
//        let neededHeight = view.subviews.max(by: { subview1, subview2 in subview1.frame.maxY < subview2.frame.maxY })?.frame.maxY ?? 0
//
//        return setSize(CGSize(width: neededWidth, height: neededHeight), { return "wrapSubViews()" })
//    }
    
    @discardableResult
    func aspectRatio(_ ratio: CGFloat) -> PinLayout {
        return setAspectRatio(ratio, context: { "aspectRatio(\(ratio))" })
    }
    
    @discardableResult
    func aspectRatio(of view: PView) -> PinLayout {
        return setAspectRatio(view.bounds.width / view.bounds.height, context: { "aspectRatio(of: \(viewDescription(view)))" })
    }
    
    #if os(iOS) || os(tvOS)
    @discardableResult
    func aspectRatio() -> PinLayout {
        func context() -> String { return "aspectRatio()" }
        if let imageView = view as? UIImageView {
            if let imageSize = imageView.image?.size {
                setAspectRatio(imageSize.width / imageSize.height, context: context)
            } else {
                warnWontBeApplied("the layouted UIImageView's image hasn't been set", context)
            }
        } else {
            warnWontBeApplied("the layouted must be an UIImageView() to use the aspectRatio() method without parameter.", context)
        }
        return self
    }
    #endif
    
    @discardableResult
    func sizeToFit(_ fitType: FitType) -> PinLayout {
        return setFitSize(fitType: fitType, { return "sizeToFit(\(fitType.name))" })
    }

    #if os(iOS) || os(tvOS)
    @discardableResult
    func fitSize() -> PinLayout {
        return setFitSize(fitType: nil, { return "fitSize()" })
    }
    #endif

    @discardableResult
    func justify(_ value: HorizontalAlign) -> PinLayout {
        justify = value
        return self
    }
    
    @discardableResult
    func align(_ value: VerticalAlign) -> PinLayout {
        align = value
        return self
    }
    
    //
    // Margins
    //
    @discardableResult
    func marginTop(_ value: CGFloat) -> PinLayout {
        marginTop = value
        return self
    }

    @discardableResult
    func marginTop(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginTop(\(percent.description))" }
        return marginTop(percent, context)
    }

    @discardableResult
    private func marginTop(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginTop = percent.of(layoutSuperviewRect.height)
        return self
    }

    @discardableResult
    func marginLeft(_ value: CGFloat) -> PinLayout {
        marginLeft = value
        return self
    }

    @discardableResult
    func marginLeft(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginLeft(\(percent.description))" }
        return marginLeft(percent, context)
    }

    @discardableResult
    private func marginLeft(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginLeft = percent.of(layoutSuperviewRect.width)
        return self
    }

    @discardableResult
    func marginBottom(_ value: CGFloat) -> PinLayout {
        marginBottom = value
        return self
    }

    @discardableResult
    func marginBottom(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginBottom(\(percent.description))" }
        return marginBottom(percent, context)
    }

    @discardableResult
    private func marginBottom(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginBottom = percent.of(layoutSuperviewRect.height)
        return self
    }

    @discardableResult
    func marginRight(_ value: CGFloat) -> PinLayout {
        marginRight = value
        return self
    }

    @discardableResult
    func marginRight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginRight(\(percent.description))" }
        return marginRight(percent, context)
    }

    @discardableResult
    private func marginRight(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginRight = percent.of(layoutSuperviewRect.width)
        return self
    }
    
    @discardableResult
    func marginStart(_ value: CGFloat) -> PinLayout {
        return isLTR() ? marginLeft(value) : marginRight(value)
    }

    @discardableResult
    func marginStart(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginStart(\(percent.description))" }
        return isLTR() ? marginLeft(percent, context) : marginRight(percent, context)
    }
    
    @discardableResult
    func marginEnd(_ value: CGFloat) -> PinLayout {
        return isLTR() ? marginRight(value) : marginLeft(value)
    }

    @discardableResult
    func marginEnd(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginEnd(\(percent.description))" }
        return isLTR() ? marginRight(percent, context) : marginLeft(percent, context)
    }

    @discardableResult
    func marginHorizontal(_ value: CGFloat) -> PinLayout {
        marginLeft = value
        marginRight = value
        return self
    }

    @discardableResult
    func marginHorizontal(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginHorizontal(\(percent.description))" }
        return marginHorizontal(percent, context)
    }

    @discardableResult
    private func marginHorizontal(_ percent: Percent, _ context: Context) -> Self {
        return marginLeft(percent, context).marginRight(percent, context)
    }

    @discardableResult
    func marginVertical(_ value: CGFloat) -> PinLayout {
        marginTop = value
        marginBottom = value
        return self
    }

    @discardableResult
    func marginVertical(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginVertical(\(percent.description))" }
        return marginVertical(percent, context)
    }

    @discardableResult
    private func marginVertical(_ percent: Percent, _ context: Context) -> Self {
        return marginTop(percent, context).marginBottom(percent, context)
    }
    
    @discardableResult
    func margin(_ insets: PEdgeInsets) -> PinLayout {
        marginTop = insets.top
        marginBottom = insets.bottom
        marginLeft = insets.left
        marginRight = insets.right
        return self
    }

    #if os(iOS) || os(tvOS)
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> PinLayout {
        marginTop = directionalInsets.top
        marginBottom = directionalInsets.bottom
        marginStart(directionalInsets.leading)
        marginEnd(directionalInsets.trailing)
        return self
    }
    #endif

    @discardableResult
    func margin(_ value: CGFloat) -> PinLayout {
        marginTop = value
        marginLeft = value
        marginBottom = value
        marginRight = value
        return self
    }

    @discardableResult
    func margin(_ percent: Percent) -> PinLayout {
        func context() -> String { return "margin(\(percent.description))" }
        return marginTop(percent, context)
            .marginLeft(percent, context)
            .marginBottom(percent, context)
            .marginRight(percent, context)
    }

    @discardableResult
    func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> PinLayout {
        marginTop = top
        marginLeft = left
        marginBottom = bottom
        marginRight = right
        return self
    }

    @discardableResult
    func margin(_ top: Percent, _ left: Percent, _ bottom: Percent, _ right: Percent) -> PinLayout {
        func context() -> String {
            return "margin(top: \(top.description), left: \(left.description), bottom: \(bottom.description), right: \(right.description)"
        }
        return marginTop(top, context)
            .marginLeft(left, context)
            .marginBottom(bottom, context)
            .marginRight(right, context)
    }

    @discardableResult func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> PinLayout {
        marginTop = vertical
        marginLeft = horizontal
        marginBottom = vertical
        marginRight = horizontal
        return self
    }

    @discardableResult
    func margin(_ vertical: Percent, _ horizontal: Percent) -> PinLayout {
        func context() -> String { return "margin(vertical: \(vertical.description), horizontal: \(horizontal.description)"}
        return marginVertical(vertical, context).marginHorizontal(horizontal, context)
    }

    @discardableResult func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> PinLayout {
        marginTop = top
        marginLeft = horizontal
        marginBottom = bottom
        marginRight = horizontal
        return self
    }

    @discardableResult
    func margin(_ top: Percent, _ horizontal: Percent, _ bottom: Percent) -> PinLayout {
        func context() -> String { return "margin(top: \(top.description), horizontal: \(horizontal.description), bottom: \(bottom.description)"}
        return marginTop(top, context).marginHorizontal(horizontal, context).marginBottom(bottom, context)
    }

    @discardableResult
    func pinEdges() -> PinLayout {
        shouldPinEdges = true
        return self
    }
}

//
// MARK: Private methods
//
extension PinLayoutImpl {
    internal func setFitSize(fitType: FitType?, _ context: Context) -> PinLayout {
        if let aspectRatio = _aspectRatio {
            warnConflict(context, ["aspectRatio": aspectRatio])
        } else if fitType != nil && legacyFitSize {
            warn("PinLayout Conflict: \(context()) won't be applied since it conflicts with fitSize().")
        } else if let currentFitType = self.fitType, currentFitType != fitType {
            warn("PinLayout Conflict: \(context()) won't be applied since it conflicts with sizeToFit(\(currentFitType.name)).")
        } else {
            if fitType == nil {
                legacyFitSize = true
            } else {
                self.fitType = fitType
            }
        }
        return self
    }
    
    @discardableResult
    internal func setAspectRatio(_ ratio: CGFloat, context: Context) -> PinLayout {
        if let fitType = fitType {
            warn("PinLayout Conflict: \(context()) won't be applied since it conflicts with sizeToFit(\(fitType.name)).")
        } else if legacyFitSize {
            warn("PinLayout Conflict: \(context()) won't be applied since it conflicts with fitSize().")
        } else if ratio <= 0 {
            warnWontBeApplied("the aspectRatio (\(ratio)) must be greater than zero.", context)
        } else {
            _aspectRatio = ratio
        }
        return self
    }
    
    internal func layoutSuperviewRect(_ context: Context) -> CGRect? {
        if let superview = view.superview {
            return Coordinates.getViewRect(superview, keepTransform: keepTransform)
        } else {
            // Disable this warning: Using XIB, layoutSubview() is called even before views have been
            // added, and there is no way to modify that strange behaviour of UIKit.
            //warnWontBeApplied("the view must be added as a sub-view before being layouted using this method.", context)
            return nil
        }
    }
    
    internal func layoutSuperview(_ context: Context) -> PView? {
        if let superview = view.superview {
            return superview
        } else {
            // Disable this warning: Using XIB, layoutSubview() is called even before views have been
            // added, and there is no way to modify that strange behaviour of UIKit.
            //warnWontBeApplied("the view must be added as a sub-view before being layouted using this method.", context)
            return nil
        }
    }

    internal func referenceSuperview(_ referenceView: PView, _ context: Context) -> PView? {
        if let superview = referenceView.superview {
            return superview
        } else {
            warnWontBeApplied("the reference view \(viewDescription(referenceView)) must be added as a sub-view before being used as a reference.", context)
            return nil
        }
    }
}

