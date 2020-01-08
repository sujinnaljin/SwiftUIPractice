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
    @State var name = "sujin"
    @State var users = ["Hohyeon", "Gomin", "Durup"]
    
    struct Family: Identifiable {
        var id = UUID()
        var name: String
    }
    
    struct FamilyRow: View {
        var family: Family
        var body: some View {
            Text("Family: \(family.name)")
        }
    }
    
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
        
        //View 시스템
        //VStack or HStack
        let vStack = VStack(alignment: .trailing, spacing: 50) {
            Text("Hello SwiftUI")
            Divider()
            Text("Sujin")
                .padding(.bottom, 100) //인자 안전달하면 디폴트
            Text("Naljin")
        }
        
        //zStack은 뷰 겹칠때 사용하는 코드
        let zStack = ZStack {
            Image("cover")
            Text("sujinnaljinsujinnaljin")
        }
        
        //someview는 특정한 하나의 뷰타입이 리턴한다고 이해. 따라서 다양한 뷰 타입을 한번에 리턴할 수 없음.
        //1. 그룹으로 감싸준다
        let group = Group {
            if Bool.random() {
                Image("cover")
            } else {
                Text("fail")
            }
        }
        //2. Any뷰로 각각의 뷰를 감싸서 특정한 리턴 뷰 타입을 없앤다
        if Bool.random() {
            //return AnyView(Image("cover"))
        } else {
            //return AnyView(Text("fail"))
        }

        //safe area
        //safe area 넘고 싶을때
        let textOverSafeArea = Text("sujinnaljinsujinnaljin")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.yellow)
            .edgesIgnoringSafeArea([.top, .bottom])
        
        //textField
        let plainTextField = VStack {
            //첫번째 인자값이 place holder
            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
            SecureField("Enter your pwd", text: $name)
            Text("hello \(name)")
        }
        
        //list
        let first = Family(name: "Hohyeon")
        let second = Family(name: "Gomin")
        let third = Family(name: "Durup")
        let families = [first, second, third]
        let basicList = List(families) { family in
            FamilyRow(family: family)
        }
        
        let listWithDelete =
            NavigationView {
                List {
                    Section(header: Text("sec1")) {
                        ForEach(users, id: \.self) { user in
                            Text(user)
                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                    }
                    Section(header: Text("sec2")) {
                        ForEach(users, id: \.self) { user in
                            Text(user)
                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                    }
                }
                .navigationBarItems(trailing: EditButton())
                .listStyle(GroupedListStyle()) //List를 그룹화
            }
        
        func delete(at offsets: IndexSet) {
            users.remove(atOffsets: offsets)
        }
        
        func move(from source: IndexSet, to destination: Int) {
            users.move(fromOffsets: source, toOffset: destination)
        }
        
        return listWithDelete
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
