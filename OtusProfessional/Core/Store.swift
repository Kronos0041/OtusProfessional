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
    private var effectTask: Task<Void, Never>?

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
        
        runTask(action)
    }
    
    private func runTask(_ action: Action) {
        effectTask?.cancel()
        let snapshotState = state
        effectTask = Task<Void, Never> { [middlewares] in
            for middleware in middlewares {
                guard !Task.isCancelled else { return }
                if let followUp = await middleware(snapshotState, action) {
                    guard !Task.isCancelled else { return }
                    dispatch(followUp)
                }
            }
        }
    }
}

