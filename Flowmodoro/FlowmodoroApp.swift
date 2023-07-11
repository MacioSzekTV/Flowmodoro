//
//  FlowmodoroApp.swift
//  Flowmodoro
//
//  Created by Maciej Łabędź on 09/07/2023.
//

import SwiftUI

@main
struct FlowmodoroApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 250, idealWidth: 250, maxWidth: 250,
                    minHeight: 400, idealHeight: 400, maxHeight: 400, alignment: .center)
        }
        .windowResizability(.contentSize)
    }
}
