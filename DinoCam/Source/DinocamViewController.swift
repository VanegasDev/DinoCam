//
//  DinocamViewController.swift
//  DinoCam
//
//  Created by Mario Vanegas on 2/7/21.
//

import UIKit
import Combine
import TinyConstraints

class DinocamViewController: UIViewController {
    // MARK: Properties
    private let viewModel: DinocamViewModel
    private var cancellables = Set<AnyCancellable>()
    lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(savePhotoOnLibrary))
        
        return button
    }()
    
    // MARK: Inits
    init(viewModel: DinocamViewModel = DinocamViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DinoCam"
        
        setupViews()
        setupBindings()
        addHosting(DinocamView(viewModel: viewModel))
    }
    
    // MARK: Setup
    private func setupViews() {
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupBindings() {
        let openImagePicker = viewModel.openImagePickerPublisher.receive(on: DispatchQueue.main)
        
        openImagePicker.sink(receiveValue: takePhoto)
        .store(in: &cancellables)
    }
    
    // MARK: Functionality
    @objc private func savePhotoOnLibrary() {
        guard let image = viewModel.image else {
            present(UIAlertController.showErrorAlert(description: "There is no image to save!"), animated: true)
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        guard let error = error else {
            viewModel.image = nil
            present(UIAlertController.showSuccessAlert(description: "Image Saved Successfully!"), animated: true)
            return
        }
        
        present(UIAlertController.showErrorAlert(description: error.localizedDescription), animated: true)
    }
    
    private func takePhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        
        present(pickerController, animated: true)
    }
}

// MARK: Extensions
extension DinocamViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        viewModel.image = image
    }
}
