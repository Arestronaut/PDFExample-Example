//
//  ViewController.swift
//  PDFRenderer Example
//
//  Created by Raoul Schwagmeier on 03.02.20.
//  Copyright © 2020 Raoul Schwagmeier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Subtypes
    private enum Constants {
        static let inset: CGFloat = 15.0
        static let buttonHeight: CGFloat = 45.0
        static let buttonCornerRadius: CGFloat = 10.0
    }

    // MARK: - Properties
    private lazy var generateReportButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(touchUpInsideGenerateReportButton), for: .touchUpInside)
        button.setTitle(Strings.Main.generatePDFButton, for: .normal)
        button.backgroundColor = Colors.main?.withAlphaComponent(0.8)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.darkGray, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRadius

        return button
    }()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        view.backgroundColor = Colors.background

        view.addSubview(generateReportButton)
        [
            generateReportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset),
            generateReportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.inset),
            generateReportButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            generateReportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateReportButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ].forEach { $0.isActive = true }
    }

    @objc
    private func touchUpInsideGenerateReportButton() {
        let mockGraphData = GraphData.mockEntries
        let xEntries: [Double] = mockGraphData.map { $0.x }
        let averageX: Double = xEntries.reduce(0, +) / Double(xEntries.count)

        let yEntries: [Double] = mockGraphData.map { $0.y }
        let averageY: Double = yEntries.reduce(0, +) / Double(yEntries.count)

        let viewModel: DataReportViewModel = .init(
            graphData: mockGraphData,
            averageX: averageX,
            averageY: averageY
        )

        let reportViewController = DataReportViewController()
        reportViewController.viewModel = viewModel

        present(reportViewController, animated: true, completion: nil)
    }
}

