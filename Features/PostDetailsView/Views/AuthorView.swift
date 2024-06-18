//
//  PostItemView.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct AuthorView: View {
    
    let author: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: UI.Space.xxSmall) {
            Text("Author")
                .bold()
                .foregroundColor(.black)
                .font(.montserrat.bold(size: UI.FontSize.PostItemView.title))
            
            rowView(icon: "person.fill", text: author.name)
            rowView(icon: "phone.fill", text: author.phone)
            rowView(icon: "envelope.fill", text: author.email)
            rowView(icon: "location.fill", text: author.address.city)
            rowView(icon: "building.fill", text: author.company.name)
            rowView(icon: "globe", text: author.website)
        }
        .padding()
        .align(.top)
    }
    
    private func rowView(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.black)
                .font(.montserrat.bold(size: UI.FontSize.PostItemView.title))
            
            Text(text)
                .font(.body)
                .foregroundColor(.black)
            
            Spacer()
        }
    }
    
}

// MARK: - Preview

#Preview {
    let sampleUser = User(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", phone: "1-770-736-8031 x56442", website: "hildegard.org", company: Company(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets"), address: Address(street: "Kulas Light", city: "Apt. 556", zipcode: "Gwenborough", suite: "92998-3874"))
    return AuthorView(author: sampleUser)
}
