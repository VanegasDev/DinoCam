//
//  DinocamViewModel.swift
//  DinoCam
//
//  Created by Mario Vanegas on 2/7/21.
//

import SwiftUI
import Combine

class DinocamViewModel: ObservableObject {
    // MARK: Input
    let takePhotoTapPublisher = PassthroughSubject<Void, Never>()
    
    // MARK: Output
    @Published var image: UIImage?
    let openImagePickerPublisher = PassthroughSubject<Void, Never>()
    
    // MARK: Properties
    private var cancellables = Set<AnyCancellable>()
    var chosenImage: UIImage {
        image ?? UIImage(named: "dino") ?? UIImage()
    }
    
    init() {
        setupBindings()
    }
    
    // MARK: Setup
    private func setupBindings() {
        let takePhotoTap = takePhotoTapPublisher.receive(on: DispatchQueue.main)
        
        takePhotoTap.sink(receiveValue: openImagePickerPublisher.send)
            .store(in: &cancellables)
    }
}
