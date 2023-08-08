//
//  ContentView.swift
//  Bookworm
//
//  Created by Kimberly Brewer on 8/8/23.
//

import SwiftUI

struct ContentView: View {
    /// make a new fetch request with no sorting
    /// then put it into a property called books with a type of FetchedResults<Book>
    /// now it's almost like a regular swift Array
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.author),
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book>
    @Environment(\.managedObjectContext) var moc
    @State private var showingAddBook = false
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton() // I don't like this
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddBook = true
                        } label: {
                            Label("Add New", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddBook) {
                    AddBookView()
                }
        }
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
       // try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
