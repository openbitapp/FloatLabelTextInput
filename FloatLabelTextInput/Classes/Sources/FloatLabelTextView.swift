//
//  FloatLabelTextView.swift
//  FloatLabelTextInput
//
//  Created by Roberto Casula on 08/12/2018.
//


import UIKit

@IBDesignable public class FloatLabelTextView: UITextView {
    let animationDuration = 0.3
    fileprivate var isIB = false
    fileprivate var title = UILabel()
    fileprivate var hintLabel = UILabel()
    fileprivate var initialTopInset:CGFloat = 0

    // MARK:- Properties
    override public var accessibilityLabel:String? {
        get {
            if text.isEmpty {
                return title.text!
            } else {
                return text
            }
        }
        set {
        }
    }



    @IBInspectable var hint: String = "" {
        didSet {
            title.text = hint
            title.sizeToFit()
            var r = title.frame
            r.size.width = frame.size.width
            title.frame = r
            hintLabel.text = hint
            hintLabel.sizeToFit()
        }
    }

    @IBInspectable open var hintYPadding: CGFloat = 0.0 {
        didSet {
            adjustTopTextInset()
        }
    }

    @IBInspectable open var titleYPadding: CGFloat = 0.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }

    @IBInspectable open var titleTextColour:UIColor = UIColor.gray {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }

    @IBInspectable open var titleActiveTextColour:UIColor = UIColor.cyan {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }

    @IBInspectable open var placeholderTextColor: UIColor = UIColor.lightGray.withAlphaComponent(0.65) {
        didSet {
            if !isFirstResponder {
                hintLabel.textColor = placeholderTextColor
            }
        }
    }

    open var titleFont: UIFont = .boldSystemFont(ofSize: 12.0) {
        didSet {
            title.font = titleFont
        }
    }

    open var textFont: UIFont = .preferredFont(forTextStyle: .body) {
        didSet {
            self.font = textFont
        }
    }


    // MARK:- Init
    required public init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }

    override init(frame:CGRect, textContainer:NSTextContainer?) {
        super.init(frame:frame, textContainer:textContainer)
        setup()
    }

    deinit {
        if !isIB {
            let nc = NotificationCenter.default
            nc.removeObserver(self, name:UITextView.textDidChangeNotification, object:self)
            nc.removeObserver(self, name:UITextView.textDidBeginEditingNotification, object:self)
            nc.removeObserver(self, name:UITextView.textDidEndEditingNotification, object:self)
        }
    }

    // MARK:- Overrides
    override public func prepareForInterfaceBuilder() {
        isIB = true
        setup()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        adjustTopTextInset()
        hintLabel.alpha = text.isEmpty ? 1.0 : 0.0
        let r = textRect()
        hintLabel.frame = CGRect(x:r.origin.x, y:r.origin.y, width:hintLabel.frame.size.width, height:hintLabel.frame.size.height)
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if isResp && !text.isEmpty {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if text.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
    }

    // MARK:- Private Methods
    fileprivate func setup() {
        initialTopInset = textContainerInset.top
        textContainer.lineFragmentPadding = 0.0
        titleActiveTextColour = tintColor
        // Placeholder label
        hintLabel.font = font
        hintLabel.text = hint
        hintLabel.numberOfLines = 0
        hintLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        hintLabel.backgroundColor = UIColor.clear
        hintLabel.textColor = placeholderTextColor
        insertSubview(hintLabel, at:0)
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        title.backgroundColor = backgroundColor
        if !hint.isEmpty {
            title.text = hint
            title.sizeToFit()
        }
        self.addSubview(title)
        // Observers
        if !isIB {
            let nc = NotificationCenter.default
            nc.addObserver(self, selector:#selector(UIView.layoutSubviews), name:UITextView.textDidChangeNotification, object:self)
            nc.addObserver(self, selector:#selector(UIView.layoutSubviews), name:UITextView.textDidBeginEditingNotification, object:self)
            nc.addObserver(self, selector:#selector(UIView.layoutSubviews), name:UITextView.textDidEndEditingNotification, object:self)
        }
    }

    fileprivate func adjustTopTextInset() {
        var inset = textContainerInset
        inset.top = initialTopInset + title.font.lineHeight + hintYPadding
        textContainerInset = inset
    }

    fileprivate func textRect()->CGRect {
        var r = bounds.inset(by: contentInset)
        r.origin.x += textContainer.lineFragmentPadding
        r.origin.y += textContainerInset.top
        return r.integral
    }

    fileprivate func setTitlePositionForTextAlignment() {
        var titleLabelX = textRect().origin.x
        var placeholderX = titleLabelX
        if textAlignment == NSTextAlignment.center {
            titleLabelX = (frame.size.width - title.frame.size.width) * 0.5
            placeholderX = (frame.size.width - hintLabel.frame.size.width) * 0.5
        } else if textAlignment == NSTextAlignment.right {
            titleLabelX = frame.size.width - title.frame.size.width
            placeholderX = frame.size.width - hintLabel.frame.size.width
        }
        var r = title.frame
        r.origin.x = titleLabelX
        title.frame = r
        r = hintLabel.frame
        r.origin.x = placeholderX
        hintLabel.frame = r
    }

    fileprivate func showTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations:{
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding + self.contentOffset.y
            self.title.frame = r
        }, completion:nil)
    }

    fileprivate func hideTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations:{
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion:nil)
    }
}

