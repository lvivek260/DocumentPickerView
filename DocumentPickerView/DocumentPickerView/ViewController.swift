//
//  ViewController.swift
//  DocumentPickerView
//
//  Created by PHN MAC 1 on 18/07/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import PDFKit

class ViewController: UIViewController {
  
    @IBOutlet weak var pdfContainer: UIView!
    var pdfView = PDFView()
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

// MARK: - IBActions
    @IBAction func openDocumentBtnClick(_ sender: Any) {
        let documentPickerVC = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPickerVC.delegate = self
        documentPickerVC.allowsMultipleSelection = false
        
        documentPickerVC.modalPresentationStyle = .formSheet
        present(documentPickerVC, animated: true)
    }
}

// MARK: - Methods
extension ViewController{
    private func configuration(){
        // configuration of pdfView
        pdfView.frame.size =  pdfContainer.frame.size
        pdfView.backgroundColor = .systemGray
        pdfContainer.addSubview(pdfView)
        
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.usePageViewController(true,withViewOptions: nil)
    }
}

extension ViewController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let pickedURL = urls.first else {return}
        pdfView.document = PDFDocument(url: pickedURL)
    }
}
