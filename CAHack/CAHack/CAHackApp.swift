//
//  CAHackApp.swift
//  CAHack
//
//  Created by Artemiy Malyshau on 29/07/2023.
//

import SwiftUI

@main
struct CAHackApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(CartManager())
        }
    }
}
