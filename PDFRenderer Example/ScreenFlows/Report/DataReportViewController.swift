//
//  DataReportViewController.swift
//  PDFRenderer Example
//
//  Created by Raoul Schwagmeier on 09.02.20.
//  Copyright © 2020 Raoul Schwagmeier. All rights reserved.
//

import UIKit

final class DataReportViewController: UIViewController {
    // MARK: - Subtypes
    private enum Constants {
        static let inset: CGFloat = 15.0
        static let titleViewTopInset: CGFloat = 30.0
        static let titleViewHeight: CGFloat = 60.0
        static let titleViewCornerRadius: CGFloat = 10.0
        static let graphHeight: CGFloat = 240.0
    }

    // MARK: - Properties
    var viewModel: DataReportViewModel? {
        didSet {
            updateView()
        }
    }

    private let titleView: UIView = {
        let enclosingView: UIView = .init()
        enclosingView.backgroundColor = Colors.main?.withAlphaComponent(0.8)
        enclosingView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel: UILabel = .init()
        titleLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        titleLabel.text = Strings.DataReport.title
        titleLabel.textColor = Colors.darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        enclosingView.addSubview(titleLabel)
        [
            titleLabel.leadingAnchor.constraint(equalTo: enclosingView.leadingAnchor, constant: Constants.inset),
            titleLabel.centerYAnchor.constraint(equalTo: enclosingView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: enclosingView.trailingAnchor, constant: Constants.inset)
        ].forEach { $0.isActive = true }

        return enclosingView
    }()
    private let graphView: ReportGraphView = .init()
    private lazy var averageXValueLabel: UILabel = makeLabel()
    private lazy var averageYValueLabel: UILabel = makeLabel()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        titleView.layer.cornerRadius = Constants.titleViewCornerRadius
        titleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }

    private func makeLabel() -> UILabel {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        label.textColor = Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }

    private func setupView() {
        view.backgroundColor = Colors.background

        view.addSubview(titleView)
        [
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleViewTopInset),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.widthAnchor.constraint(equalToConstant: view.bounds.width / 3),
            titleView.heightAnchor.constraint(equalToConstant: Constants.titleViewHeight)
        ].forEach { $0.isActive = true }

        view.addSubview(graphView)
        graphView.translatesAutoresizingMaskIntoConstraints = false
        [
            graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset),
            graphView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.inset),
            graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.inset),
            graphView.heightAnchor.constraint(equalToConstant: Constants.graphHeight)
        ].forEach { $0.isActive = true }

        view.addSubview(averageXValueLabel)
        [
            averageXValueLabel.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: Constants.inset),
            averageXValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset)
        ].forEach { $0.isActive = true }

        view.addSubview(averageYValueLabel)
        [
            averageYValueLabel.topAnchor.constraint(equalTo: averageXValueLabel.bottomAnchor, constant: Constants.inset),
            averageYValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset)
        ].forEach { $0.isActive = true }
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }

        graphView.graphEntries = viewModel.graphData
        averageXValueLabel.text = Strings.DataReport.averageXValue(String(viewModel.averageX))
        averageYValueLabel.text = Strings.DataReport.averageYValue(String(viewModel.averageY))
    }
}
