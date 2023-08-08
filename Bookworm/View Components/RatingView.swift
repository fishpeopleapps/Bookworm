//
//  RatingView.swift
//  Bookworm
//
//  Created by Kimberly Brewer on 8/8/23.
//

import SwiftUI

struct RatingView: View {
    // THIS IS HOW YOU CONNECT VARIABLES FROM OTHER VIEWS!
    @Binding var rating: Int
    // More
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    // End
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                // TODO: Change this to ForegroundStyle - maybe if i use a custom color
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    /// Returns an image based on the user rating
    /// - Parameter num: User rating
    /// - Returns: Rating Image
    func image(for num: Int) -> Image {
        if num > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
