//
//  ContentView.swift
//  Bookworm
//
//  Created by Kimberly Brewer on 8/8/23.
//
// TODO: App Icon & Improve UI
// TODO: You can't edit books?
// TODO: You can't change the rating in the detail view
// TODO: BUG - the pictures aren't showing up (and i don't like them anyway)
// TODO: The optional formatting done in UP
// TODO: The other details you have to provide (background notifications maybe?) from UP for CoreData
// TODO: Would it be possible to have a screen that first lists all the titles by genre - more generic, Fiction, NonFiction, Educational or whatever
// TODO: This code needs comments (more)
// TODO: Compare datacontroller in UP to see what else we can add...
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
                    .opacity(book.rating == 1 ? 0.5 : 1)
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
