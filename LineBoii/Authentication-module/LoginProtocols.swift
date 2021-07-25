//
//  LoginProtocols.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import Foundation
import UIKit

typealias EntryPoint = LoginViewProtocol & UIViewController

protocol LoginRouterProtocol {
    var entry: EntryPoint? {get}
    static func start() -> LoginRouterProtocol
}

protocol LoginViewProtocol {
    var presenter: LoginPresenterProtocol? {get set}
    func update()
}

protocol LoginPresenterProtocol {
    var router: LoginRouterProtocol? {get set}
    var view: LoginViewProtocol? {get set}
    var interactor: LoginInteractorProtocol? {get set}
}

protocol LoginInteractorProtocol {
    var presenter: LoginPresenterProtocol? { get set }
}
