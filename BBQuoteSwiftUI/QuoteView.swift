//
//  QuoteView.swift
//  BBQuoteSwiftUI
//
//  Created by David McDermott on 9/10/23.
//

import SwiftUI

struct QuoteView: View {
    
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    let show: String
    
    @State private var showCharacterInfo = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack { // so button doesn't jump around
                
                    VStack {
                        Spacer(minLength: 140)
                        
                        switch viewModel.status {
                        case .success(let data):
                            Text("\"\(data.quote.quote)\"")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .minimumScaleFactor(0.5)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: data.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                .onTapGesture {
                                    showCharacterInfo.toggle()
                                }
                                .sheet(isPresented: $showCharacterInfo) {
                                    CharacterView(show: show, character: data.character)
                                }
                                
                                Text(data.quote.character)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                // material is like a transparent blur
                            }
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .cornerRadius(80)
                        case .fetching:
                            ProgressView()
                        default:
                            EmptyView()
                            
                        }
                        
                        Spacer()
                    }
                    
                    Button {
                        Task {
                            await viewModel.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("\(show.noSpaces)Button"))
                            .cornerRadius(10)
                            .shadow(color: Color(.black), radius: 2)
                    }

                    Spacer(minLength: 180)
                }
                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)  // centers zstack
        }
        .ignoresSafeArea()
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(show: Constants.bbName)
            .preferredColorScheme(.dark)
    }
}
