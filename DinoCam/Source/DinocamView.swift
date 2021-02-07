//
//  DinocamView.swift
//  DinoCam
//
//  Created by Mario Vanegas on 2/7/21.
//

import SwiftUI

struct DinocamView: View {
    @ObservedObject var viewModel: DinocamViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: viewModel.chosenImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: viewModel.takePhotoTapPublisher.send) {
                Image("dinocam-logo")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .clipShape(Circle())
            }
            .padding()
        }
    }
}

struct DinocamView_Previews: PreviewProvider {
    static var previews: some View {
        DinocamView(viewModel: DinocamViewModel())
    }
}
