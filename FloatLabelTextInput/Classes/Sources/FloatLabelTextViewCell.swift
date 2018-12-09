//
//  FloatLabelTextViewCell.swift
//  FloatLabelTextInput
//
//  Created by Roberto Casula on 09/12/2018.
//

import UIKit
import Eureka


class FloatLabelTextViewCell: TextAreaCell {

    @IBOutlet weak var floatTextView: FloatLabelTextView!


    override func setup() {
        floatTextView.delegate = self
        self.textView = floatTextView
        super.setup()

        self.updateConstraints()
    }

    open override func update() {
        super.update()
        textLabel?.text = nil
        detailTextLabel?.text = nil
        floatTextView.hint = row.title ?? ""
        floatTextView.text = row.displayValueFor?(row.value)
        floatTextView.isEditable = !row.isDisabled
        floatTextView.titleTextColour = .lightGray
        floatTextView.textColor = row.isDisabled ? .gray : .black
        floatTextView.alpha = row.isDisabled ? 0.6 : 1
    }

    deinit {
        textView?.delegate = nil
    }


    open override func cellCanBecomeFirstResponder() -> Bool {
        return !row.isDisabled && floatTextView.canBecomeFirstResponder
    }

    open override func cellBecomeFirstResponder(withDirection direction: Direction) -> Bool {
        // workaround to solve https://github.com/xmartlabs/Eureka/issues/887 UIKit issue
        floatTextView.perform(#selector(UITextView.becomeFirstResponder), with: nil, afterDelay: 0.0)
        return true
    }

    open override func cellResignFirstResponder() -> Bool {
        return floatTextView.resignFirstResponder()
    }

}

//public class _TextAreaFloatCell<T>: Cell<T>, UITextViewDelegate, AreaCell where T: Equatable, T: InputTypeInitiable {
//
//    public var textView: UITextView! { return floatLabelTextView }
//
//    open var dynamicConstraints = [NSLayoutConstraint]()
//
//
//    lazy public var floatLabelTextView: FloatLabelTextView = {
//        let floatTextView = FloatLabelTextView()
//        floatTextView.translatesAutoresizingMaskIntoConstraints = false
//        floatTextView.font = .preferredFont(forTextStyle: .body)
//        floatTextView.titleFont = .boldSystemFont(ofSize: 11.0)
//        //        floatTextView.hintYPadding = -20
//
//        return floatTextView
//    }()
//
//
//
//    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    deinit {
//        textView?.delegate = nil
//        //        if !awakeFromNibCalled {
//        //            imageView?.removeObserver(self, forKeyPath: "image")
//        //        }
//    }
//

//    open override func setup() {
//        super.setup()
//        let textAreaRow = row as! TextAreaConformance
//
//        switch textAreaRow.textAreaHeight {
//        case .dynamic(_):
//            height = { UITableView.automaticDimension }
//            floatLabelTextView.isScrollEnabled = false
//        case .fixed(let cellHeight):
//            height = { cellHeight }
//        }
//
//        selectionStyle = .none
//        contentView.addSubview(floatLabelTextView)
//        floatLabelTextView.delegate = self
//        setNeedsUpdateConstraints()
//    }

//    open override func update() {
//        super.update()
//        textLabel?.text = nil
//        detailTextLabel?.text = nil
//        floatLabelTextView.hint = row.title ?? ""
//        floatLabelTextView.text = row.displayValueFor?(row.value)
//        floatLabelTextView.isEditable = !row.isDisabled
//        floatLabelTextView.titleTextColour = .lightGray
//        floatLabelTextView.textColor = row.isDisabled ? .gray : .black
//        floatLabelTextView.alpha = row.isDisabled ? 0.6 : 1
//    }
//
//    open override func cellCanBecomeFirstResponder() -> Bool {
//        return !row.isDisabled && floatLabelTextView.canBecomeFirstResponder
//    }
//
//    open override func cellBecomeFirstResponder(withDirection direction: Direction) -> Bool {
//        // workaround to solve https://github.com/xmartlabs/Eureka/issues/887 UIKit issue
//        floatLabelTextView.perform(#selector(UITextView.becomeFirstResponder), with: nil, afterDelay: 0.0)
//        return true
//    }
//
//    open override func cellResignFirstResponder() -> Bool {
//        return floatLabelTextView.resignFirstResponder()
//    }
//
//
//    open override func updateConstraints() {
//        customConstraints()
//        super.updateConstraints()
//    }

//    open func customConstraints() {
//        let views = ["floatLabeledTextView": floatLabelTextView]
//        let metrics = ["vMargin": 8.0]
//        contentView.removeConstraints(dynamicConstraints)
//        dynamicConstraints = []
//
//        let h = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[floatLabeledTextView]-|",
//                                               options: .alignAllLastBaseline,
//                                               metrics: metrics, views: views)
//
//        dynamicConstraints.append(h)
//        if let textAreaConformance = row as? TextAreaConformance,
//            case .dynamic(let initialTextViewHeight) = textAreaConformance.textAreaHeight {
//            let m = metrics + ["initialHeight": initialTextViewHeight]
//            let v = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(vMargin)-[floatLabeledTextView(>=initialHeight@1000)]-(vMargin)-|",
//                                                   options: [],
//                                                   metrics: m,
//                                                   views: views)
//            dynamicConstraints.append(v)
//        } else {
//            let v = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(vMargin)-[floatLabeledTextView]-(vMargin)-|",
//                                                   options: .alignAllLastBaseline,
//                                                   metrics: metrics,
//                                                   views: views)
//            dynamicConstraints.append(v)
//        }
//        contentView.addConstraints(dynamicConstraints)
//    }

    //Mark: Helpers

//    private func displayValue(useFormatter: Bool) -> String? {
//        guard let v = row.value else { return nil }
//        if let formatter = (row as? FormatterConformance)?.formatter, useFormatter {
//            return textView?.isFirstResponder == true ? formatter.editingString(for: v) : formatter.string(for: v)
//        }
//        return String(describing: v)
//    }

    //MARK: TextFieldDelegate
//    public func textViewDidBeginEditing(_ textView: UITextView) {
//        formViewController()?.beginEditing(of: self)
//        formViewController()?.textInputDidBeginEditing(textView, cell: self)
//        if let textAreaConformance = (row as? TextAreaConformance), let _ = textAreaConformance.formatter, textAreaConformance.useFormatterOnDidBeginEditing ?? textAreaConformance.useFormatterDuringInput {
//            textView.text = self.displayValue(useFormatter: true)
//        } else {
//            textView.text = self.displayValue(useFormatter: false)
//        }
//    }

//    public func textViewDidEndEditing(_ textView: UITextView) {
//        formViewController()?.endEditing(of: self)
//        formViewController()?.textInputDidEndEditing(textView, cell: self)
//        textViewDidChange(textView)
//        textView.text = displayValue(useFormatter: (row as? FormatterConformance)?.formatter != nil)
//    }
//
//    public func textViewDidChange(_ textView: UITextView) {
//        if let textAreaConformance = row as? TextAreaConformance, case .dynamic = textAreaConformance.textAreaHeight, let tableView = formViewController()?.tableView {
//            let currentOffset = tableView.contentOffset
//            UIView.setAnimationsEnabled(false)
//            tableView.beginUpdates()
//            tableView.endUpdates()
//            UIView.setAnimationsEnabled(true)
//            tableView.setContentOffset(currentOffset, animated: false)
//        }
//        guard let textValue = textView.text else {
//            row.value = nil
//            return
//        }
//        guard let fieldRow = row as? FieldRowConformance, let formatter = fieldRow.formatter else {
//            row.value = textValue.isEmpty ? nil : (T.init(string: textValue) ?? row.value)
//            return
//        }
//        if fieldRow.useFormatterDuringInput {
//            let value: AutoreleasingUnsafeMutablePointer<AnyObject?> = AutoreleasingUnsafeMutablePointer<AnyObject?>.init(UnsafeMutablePointer<T>.allocate(capacity: 1))
//            let errorDesc: AutoreleasingUnsafeMutablePointer<NSString?>? = nil
//            if formatter.getObjectValue(value, for: textValue, errorDescription: errorDesc) {
//                row.value = value.pointee as? T
//                guard var selStartPos = textView.selectedTextRange?.start else { return }
//                let oldVal = textView.text
//                textView.text = row.displayValueFor?(row.value)
//                selStartPos = (formatter as? FormatterProtocol)?.getNewPosition(forPosition: selStartPos, inTextInput: textView, oldValue: oldVal, newValue: textView.text) ?? selStartPos
//                textView.selectedTextRange = textView.textRange(from: selStartPos, to: selStartPos)
//                return
//            }
//        } else {
//            let value: AutoreleasingUnsafeMutablePointer<AnyObject?> = AutoreleasingUnsafeMutablePointer<AnyObject?>.init(UnsafeMutablePointer<T>.allocate(capacity: 1))
//            let errorDesc: AutoreleasingUnsafeMutablePointer<NSString?>? = nil
//            if formatter.getObjectValue(value, for: textValue, errorDescription: errorDesc) {
//                row.value = value.pointee as? T
//            }
//        }
//    }
//
//    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        return formViewController()?.textInput(textView, shouldChangeCharactersInRange: range, replacementString: text, cell: self) ?? true
//    }
//
//    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        if let textAreaRow = self.row as? _TextAreaRow, textAreaRow.textAreaMode == .readOnly {
//            return false
//        }
//        return formViewController()?.textInputShouldBeginEditing(textView, cell: self) ?? true
//    }
//
//    open func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        return formViewController()?.textInputShouldEndEditing(textView, cell: self) ?? true
//    }

//}
