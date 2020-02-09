//
//  PDFRenderableViewController.swift
//  PDFRenderer Example
//
//  Created by Raoul Schwagmeier on 09.02.20.
//  Copyright © 2020 Raoul Schwagmeier. All rights reserved.
//

import UIKit

class PDFRenderableViewController: UIViewController {
    // MARK: - Properties
    private var didRenderViewHandler: ((PDFRenderableViewController, Data) -> Void)?

    // MARK: - Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard view.bounds != .zero else { return }

        let renderer = UIGraphicsPDFRenderer(bounds: view.bounds)
        let pdfData = renderer.pdfData { context in
            context.beginPage()
            view.layer.render(in: context.cgContext)
        }

        didRenderViewHandler?(self, pdfData)
    }

    func onDidRenderView(_ handler: @escaping (PDFRenderableViewController, Data) -> Void) {
        didRenderViewHandler = handler
    }
}
