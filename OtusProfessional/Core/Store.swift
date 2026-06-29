//
//  Store.swift
//  OtusProfessional
//
//  Created by Alex on 12.06.2026.
//

import Combine
import Foundation

typealias Middleware<State, Action> = (State, Action) async -> Action?

@MainActor
final class Store<State, Action>: ObservableObject {

    @Published private(set) var state: State

    private let reducer: (inout State, Action) -> Void
    private let middlewares: [Middleware<State, Action>]

    init(
        initial: State,
        reducer: @escaping (inout State, Action) -> Void,
        middlewares: [Middleware<State, Action>] = []
    ) {
        self.state = initial
        self.reducer = reducer
        self.middlewares = middlewares
    }

    func dispatch(_ action: Action) {
        reducer(&state, action)

        guard !middlewares.isEmpty else { return }

        Task { [middlewares] in
            for middleware in middlewares {
                if let followUp = await middleware(state, action) {
                    dispatch(followUp)
                }
            }
        }
    }
}
