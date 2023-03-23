//  ViewModel.swift
//  counterDemo
//
//  Created by Chanon Latt on 23/3/23.
//  Copyright © 2023 pich. All rights reserved.

import Foundation
import RxCocoa
import ReactorKit
import RxSwift

// MARK: - Apply with ReactorKit

/** Notes:  Importance ReactorKit parts in ViewModel
 + Associated types:
 - Action
 - Mutation
 - State
 
 + mutataion process that convert input action to output state
 - func mutate()
 - func reduce()
 */

/** Notes:  View Model ReatorKit implementation
 1. import ReactorKit
 2. create three assciated type:
 + Action(enum): is the defined actions from User interaction at View Controller.
 - when receive an action from view -> func mutate() wil be called
 + Mutation(enum): is the defined middle link actions between action and state.
 - it returns as Observable type
 - when func mutate() called -> call func reduce()
 + State(struct): is pre defince result variable that you will need to use to bind to view
 3. init the initialState variable from protocol Reactor
 */

class ViewModel: Reactor {
    
    var initialState = State()
    
    enum Action {
        case tapIncrease
        case tapClear
    }
    
    enum Mutation {
        case increaseCurrentNumber
        case resetCurrentNumber
    }
    
    struct State {
        var currentNumber: Int = 0
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapIncrease:
            return .just(.increaseCurrentNumber)
            
        case .tapClear:
            return .just(.resetCurrentNumber)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseCurrentNumber:
            newState.currentNumber += 1
            
        case .resetCurrentNumber:
            newState.currentNumber = .zero
        }
        
        return newState
    }
}

// MARK: - Apply with Normal ViewModel
//class ViewModel {
//
//    var currentNumber = BehaviorRelay<Int>(value: 0)
//
//}
