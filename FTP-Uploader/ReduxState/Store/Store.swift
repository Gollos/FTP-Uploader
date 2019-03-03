//
//  Store.swift
//  FTP-UploaderReduxState
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

final class Store<State> {
    
    private let reduce: (State, Action) -> State
    private var state: State
    
    private var observers: Set<CommandWith<State>> = []
    
    init(state: State, reduce: @escaping (State, Action) -> State) {
        self.state = state
        self.reduce = reduce
    }
    
    func observe(with command: CommandWith<State>) {
        observers.insert(command)
        command.perform(with: state)
    }
    
    func observe(with action: @escaping (State) -> Void) {
        let command = CommandWith(action: action)
        observe(with: command)
    }
    
    func dispatch(action: Action) {
        self.state = reduce(state, action)
        observers.forEach { $0.perform(with: self.state) }
    }
}
