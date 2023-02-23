//
//  MainError.swift
//  Products-App
//
//  Created by Peter Murin on 23/02/2023.
//

import SwiftUI

struct MainError: View {
    let errorMessage: String
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(.red)
        }
    }
}

struct MainError_Previews: PreviewProvider {
    static var previews: some View {
        MainError(errorMessage: "")
    }
}
