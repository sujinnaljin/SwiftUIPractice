//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by 강수진 on 2020/01/08.
//  Copyright © 2020 강수진. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    var dueDate = Date()
    
    @State var showDetails = false
    @State var showGreeting = true
    
    var body: some View {
        //text
        let plainTxt = Text("Hello, World!\nWhat a nice world!What a nice world!What a nice world!What a nice world!")
            .lineLimit(2)
            .truncationMode(.middle)
            .font(.headline)
            .multilineTextAlignment(.center)
            .foregroundColor(.green)
            .lineSpacing(50)
        let dateTxt = Text("Task due date : \(dueDate, formatter: Self.taskDateFormat)")
        
        //image
        let sfSymbolCircle = Image(systemName: "circle") //sf symbols 사용하기 위함
            .foregroundColor(.blue)
        guard let image = UIImage(named: "cover") else {
            fatalError("fail to load image")
        }
        let img = Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
        let rectangle = Rectangle()
            .fill(Color.blue)
            .frame(width: 50, height: 50)
        let circle = Circle()
            .fill(Color.blue)
            .frame(width: 50, height: 50)
        let textWithImageBackground = Text("Swift UI tutorial")
            .background(
                Image("cover")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
            )
        
        //button
        let detailStack = VStack {
            Button(action: {
                //action
                self.showDetails.toggle()
            }) {
                //display
                Text("Show Detail Button")
            }
            if showDetails {
                Text("You should see me in a crown")
                    .font(.largeTitle)
                    .lineLimit(nil)
            }
        }
        
        //toggle
        let greetingStack = VStack {
            Toggle(isOn: $showGreeting) {
                Text("Welcome")
            }.padding()
            if showGreeting {
                Text("Hello Sujin")
            }
        }
        
        return greetingStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
