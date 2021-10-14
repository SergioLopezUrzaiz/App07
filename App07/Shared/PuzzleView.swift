//
//  ContentView.swift
//  Shared
//
//  Created by user194222 on 10/14/21.
//

import SwiftUI
import MobileCoreServices

struct PuzzleView: View {
    
    @StateObject var dataModel = DataModel()
    
    var columns : [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 4)
    
    @State var isCompleted : bool = true
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    Button {
                        dataModel.images.shuffle()
                        isCompleted = false
                    } label: {
                        HStack {
                            Image(systemName: "shuffle")
                                .font(.largeTitle)
                            Text("Shuffle")
                                .font(.largeTitle)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                    }
                    .padding(.top,40)
                    .padding(.bottom,20)
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(dataModel.images) { image in
                                Image(image.image)
                                    .resizable()
                                    .frame(width: (geo.size.width-20)/4, height: (geo.size.width-20)/4)
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color
                                                        .black, lineWidth: isCompleted ? 0 : 1)
                                    )
                                    .onDrag {
                                        
                                        dataModel.currentImage = image
                                        
                                        return NSItemProvider(item: .some(URL(string: image.image)! as NSSecureCoding),
                                                              typeIdentifier: String(kUTTypeURL))
                                    }
                                    .onDrop(of: [.url], delegate: DropViewDelegate(dataModel: dataModel, image: image, isCompleted: isCompleted))
                            }
                        }
                        .padding(.horizontal, 10)
                        Image(isCompleted ? "completed" : "santacruz")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/2)
                            .padding(.top,20)
                    }
                    .navigationBarTitle("Puzzle")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
