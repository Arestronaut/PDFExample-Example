//
//  Strings.swift
//  PDFRenderer Example
//
//  Created by Raoul Schwagmeier on 09.02.20.
//  Copyright © 2020 Raoul Schwagmeier. All rights reserved.
//

import Foundation

enum Strings {
    enum Main {
        static let generatePDFButton: String = "Generate PDF Report"
    }

    enum DataReport {
        static let title: String = "Fancy Data"
        static let yAxis: String = "y"
        static let xAxis: String = "x"

        static func averageXValue(_ x: String) -> String {
            "Average X: \(x)"
        }

        static func averageYValue(_ y: String) -> String {
            "Average Y: \(y)"
        }
    }
}
