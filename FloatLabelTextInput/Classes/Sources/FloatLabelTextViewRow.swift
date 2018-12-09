//
//  FloatLabelTextViewRow.swift
//  FloatLabelTextInput
//
//  Created by Roberto Casula on 09/12/2018.
//

import Foundation
import Eureka

public final class FloatLabelTextViewRow: AreaRow<FloatLabelTextViewCell>, RowType {

    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<FloatLabelTextViewCell>(nibName: "FloatLabelTextViewCell")

    }
}

