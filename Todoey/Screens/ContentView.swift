//
//  ContentView.swift
//  Todoey
//
//  Created by Carlos Amaral on 01/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var db
        
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "data", ascending: false)]) var items : FetchedResults<Item>
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.content ?? "Erro")
                        Spacer()
                        
                        if item.checked {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        } else {
                        }
                        
                        Image(systemName: "trash.circle.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                db.delete(item)
                            }
                    }
                    .onTapGesture {
                        if item.checked {
                            item.checked = false
                            try? db.save()
                        }
                        
                        else {
                            item.checked = true
                            try? db.save()

                        }
                    }
                }
                
            }
            .navigationTitle("Todoey")
            .navigationBarItems(
                trailing:
                    
                    NavigationLink(destination: {
                        AddItemView()
                    }, label: {
                        Image(systemName: "plus")
                    })
                
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
