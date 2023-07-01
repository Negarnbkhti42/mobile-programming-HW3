//
//  SearchPage.swift
//  ClimaCast
//
//  Created by Ainaz Rafiei on 7/1/23.
//

import SwiftUI

struct SearchPage: View {
    @Binding var items: [String]
    @State var SearchVlue = "";
    var body: some View {
        NavigationView{
            Form{
                TextField("FavoriteLocation" ,text: $SearchVlue)
            }
            Button("Cancel" , role: .cancel){}
        }
        .navigationTitle(Text("Add new Favorite Location"))
        .toolbar{
            Button{
                
            }label:{
                Text("Add")
            }
        }
    }
    
}

struct SearchPage_Previews: PreviewProvider {
    @State static var stringArr  : [String] = []
    static var previews: some View {
        SearchPage(items: $stringArr)
    }
}
