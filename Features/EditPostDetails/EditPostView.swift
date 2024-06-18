//
//  EditPostView.swift
//  JSONSuite
//
//  Created by Wael Saad on 2/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import SwiftData

// MARK: - EditPostView

/// This view displays a list of all posts.

struct EditPostView: View {
    
    @EnvironmentObject var router: Router
    
    @State var showDeleteAlert = false
    @State private var isRefreshing = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query var posts: [Post]
    
    @StateObject var viewModel: EditPostViewModel
    
    // MARK: - Main View

    var body: some View {
        mainView
    }
    
    @ViewBuilder
    private var mainView: some View {
        NavigationView {
            ZStack {
                UI.gradient
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    titleView
                    PostEditItem(post: $viewModel.post)
                        .padding(.top, UI.Padding.PostEditItem.top)
                    Spacer()
                    actionButtons
                }
            }
            .navigationViewStyle(.stack)
            .accessibilityLabel(Content.title)
            .navigationBarItems(trailing: closeButton)
        }
    }
    
    private var titleView: some View {
        HStack {
            Text(Content.title)
                .bold()
                .font(Font(.systemFont(ofSize: UI.FontSize.title)))
        }
        .multilineTextAlignment(.center)
    }
    
    private var actionButtons: some View {
        HStack {
            deleteButton
            saveButton
        }
        .padding(.bottom, UI.Padding.xSmall)
    }
    
    private var saveButton: some View {
        Button {
            do {
                try modelContext.save()
            } catch {
                print("Error saving changes: \(error)")
            }
            dismiss()
        } label: {
            ButtonLabel(
                text: GlobalContent.update,
                icon: ImageView(systemImage: .update, foreground: .yellow)
            )
        }
        .saveButton()
        .frame(height: UI.Button.height)
        
    }
    
    private var deleteButton: some View {
        Button {
            showDeleteAlert = true
        } label: {
            ButtonLabel(
                text: GlobalContent.delete,
                icon: ImageView(systemImage: .trash, foreground: .yellow)
            )
        }
        .deleteButton()
        .frame(height: UI.Button.height)
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text(Content.alertTitle),
                message: Text(Content.alertMessage),
                primaryButton: .destructive(Text(Content.alertButtonTitle)) {
                    router.popToRoot()
                    viewModel.deletePost()
                    showDeleteAlert = false
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private var closeButton: some View {
        Button {
            viewModel.resetPost()
            withAnimation { dismiss() }
        }
        .close()
    }
    
}

// MARK: - Preview

#Preview {
    EditPostView(viewModel: .init(post: Post(userId: 1, id: 1, title: "Sample Post", body: "This is a sample post.", isFavorite: false)))
}
