//
//  ContentView.swift
//  TimerAndDataTaskPublisherDemo
//
//  Created by Xing Zhao on 2021/4/30.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.users.isEmpty {
                    ProgressView()
                        .padding()
                }
                else {
                    List{
                        Text(viewModel.time)
                            .listRowInsets(EdgeInsets())
                            .font(.system(size: 16,weight: .heavy))
                            .padding(.horizontal)
                        ForEach(viewModel.users) { user in
                            Text(user.name)
                                .padding(.horizontal)
                                .padding(.vertical,16)
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    .listStyle(InsetListStyle())
                }
            }
            .navigationBarTitle("Publisers")
        }
        .onAppear(perform: {
            viewModel.fetchUsers()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
