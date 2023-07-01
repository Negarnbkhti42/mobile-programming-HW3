//
//  SearchPage.swift
//  ClimaCast
//
//  Created by Ainaz Rafiei on 7/1/23.
//

import SwiftUI

struct SearchPage: View {
    @Environment(\.dismiss) var dismiss

    @Binding var items: [String]
    @State var SearchVlue = "";
    @State var presentAlert = false;
    @State var IsSearching = false
    @State var GotResult = false

    func search() async {
        do {
            let result = try await WeatherService().getSearchResult(searchValue: SearchVlue)
            print(result ?? "")
            IsSearching = false
            if result != nil {
            
                items.append(result!)
                
               GotResult = true
            } else {
                presentAlert = true
            }
        } catch {
            print(error)
        }
    }

    var body: some View {
        NavigationView{
            Form{
                TextField("FavoriteLocation" ,text: $SearchVlue)
            }
            Button("Cancel" , role: .cancel){}

            .alert("no result found!", isPresented: $presentAlert){
                Button("OK", role: .cancel){}
                
            }
        }
        .navigationTitle(Text("Add new Favorite Location"))
        .toolbar{
            Button{
                IsSearching = true
                Task{
                    await search()
                    if GotResult{
                        dismiss()
                    }
                }
            }label:{
                Text("Add")
                
            }
            .disabled(IsSearching)
        }
    }
    
}

struct SearchPage_Previews: PreviewProvider {
    @State static var stringArr  : [String] = []
    static var previews: some View {
        SearchPage(items: $stringArr)
    }
}
