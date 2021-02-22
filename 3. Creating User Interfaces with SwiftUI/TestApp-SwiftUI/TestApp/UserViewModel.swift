//
//  UserViewModel.swift
//  TestApp
//
//  Created by ghoshb on 12/28/20.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    // Input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    // Output
    @Published var isValid: Bool = false
    @Published var passwordMessage: String = ""
    @Published var usernameMessage: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    // debounce pauses after each value is sent, and then at the end of that pause it will send the last value through.
    private var isUsernameValid: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.2, scheduler: DispatchQueue.main )
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmpty: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.2, scheduler: DispatchQueue.main )
            .map { input in
                input == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqual: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordAgain)
            .debounce(for: 0.2, scheduler: DispatchQueue.main )
            .map {password, passwordAgain in
                password == passwordAgain
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordStrongEnough: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.2, scheduler: DispatchQueue.main )
            .map { pass in
                pass.count > 3
            }
            .eraseToAnyPublisher()
    }
    
    enum PasswordCheck {
        case valid
        case empty
        case noMatch
        case notStrongEnough
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest3(isPasswordEmpty, arePasswordsEqual, passwordStrongEnough)
            .map { passwordIsEmpty, passwordsAreEqual, passwordIsStrongEnough in
                if passwordIsEmpty {
                    return .empty
                } else if !passwordsAreEqual {
                    return .noMatch
                } else if !passwordIsStrongEnough {
                    return .notStrongEnough
                } else {
                    return .valid
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValid, isPasswordValidPublisher)
            .map {username, password in
                username == true && password == .valid
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isUsernameValid
            .receive(on: DispatchQueue.main )
            .map { valid in
                valid ? "" : "Username must have atleast 3 characters"
            }
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: DispatchQueue.main )
            .map { passwordCheck in
                switch passwordCheck {
                case .empty:
                    return "Password should not be empty"
                case .notStrongEnough:
                    return "Password not strong enough, must contain atleast 3 characters"
                case .noMatch:
                    return "Passwords do not match"
                default:
                    return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: DispatchQueue.main )
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
}
