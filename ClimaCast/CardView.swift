//
//  CardView.swift
//  ClimaCast
//
//  Created by Saee Saadat on 6/19/23.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
                .shadow(radius: 5)
            
            HStack {
                Text("15 C")
            }
            .padding(20)
        }
        .frame(width: .infinity, height: 100)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
