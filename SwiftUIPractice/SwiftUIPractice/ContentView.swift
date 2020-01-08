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
        
        return plainTxt
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
