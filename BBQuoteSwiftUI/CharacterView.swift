//
//  CharacterView.swift
//  BBQuoteSwiftUI
//
//  Created by David McDermott on 9/10/23.
//

import SwiftUI

struct CharacterView: View {
    
    let show: String
    let character: Character
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    // wrapping image in a vstack allows modifiers to work varying sizes
                    // could use Group but VStack allows better use with animations
                    VStack {
                        /*
                        Image("jessepinkman")
                            .resizable()
                            .scaledToFill()
                         */
                        AsyncImage(url: character.images.randomElement()) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                    .cornerRadius(25)
                    .padding(.top, 60)
                    
                    // character info
                    // Swift UI you can only have 10 views within. so use Group
                    VStack(alignment: .leading) {
                        Group {
                            Text(character.name)
                                .font(.largeTitle)
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            
                            Text("Born \(character.birthday)")
                            Divider()
                        }

                        Group {
                            Text("Occupations")
                            
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("•\(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            Text("Nicknames")
                            
                            if (character.aliases.count > 0) {
                                ForEach(character.aliases, id: \.self) { alias in
                                    Text("•\(alias)")
                                        .font(.subheadline)
                                }
                            } else {
                                Text("None")
                                    .font(.subheadline)
                            }

                        }
                        
                    }
                    .padding([.leading, .bottom], 40)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(show: Constants.bbName, character: Constants.previewCharacter)
            .preferredColorScheme(.dark)
    }
}
