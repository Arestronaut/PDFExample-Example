//
//  ReportGraphView.swift
//  PDFRenderer Example
//
//  Created by Raoul Schwagmeier on 09.02.20.
//  Copyright © 2020 Raoul Schwagmeier. All rights reserved.
//

import SwiftChart
import UIKit

final class ReportGraphView: UIView {
    // MARK: - Properties
    var graphEntries: [(x: Double, y: Double)] = [] {
        didSet {
            updateView()
        }
    }

    private let chart: Chart = .init()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Methods
    private func setupView() {
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.isUserInteractionEnabled = false

        addSubview(chart)
        [
            chart.topAnchor.constraint(equalTo: topAnchor),
            chart.leadingAnchor.constraint(equalTo: leadingAnchor),
            chart.bottomAnchor.constraint(equalTo: bottomAnchor),
            chart.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].forEach { $0.isActive = true }
    }

    private func updateView() {
        let series: ChartSeries = .init(data: graphEntries)
        series.area = false
        if let darkGrayColor = Colors.main {
            series.color = darkGrayColor
        }

        chart.add(series)
    }
}
