//
//  ContentView.swift
//  ListPro
//
//  Created by Vinay Podili on 3/2/20.
//  Copyright © 2020 Vinay Podili. All rights reserved.
//

import SwiftUI
import CoreData
/*struct User: Identifiable {
    var id: Int
    
    let userName, message: String
}*/
struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @State var textFieldValue: String = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Name", text: $textFieldValue){
                        print("Entered value\(self.$textFieldValue.wrappedValue)")
                    }
                    .padding(.leading, 20)
                    Button("Add Name") {
                        let user = User(context: self.context)
                        user.id = UUID()
                        user.name = self.$textFieldValue.wrappedValue
                        self.saveUser()
                        //    print(<#T##items: Any...##Any#>)
                    }
                    .padding(.trailing, 20)
                }
                List(){
                    ForEach(users, id: \.id) { user in
                        Text(user.name ?? "Unknown")
                    }
                }
            }
            .navigationBarTitle("User Names")
        }
        //Text("Hello, World!")
        //List("Hello", "world")
    }
    func saveUser() {
        do {
            try self.context.save()
        }catch {
            print("Unable to save user: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
