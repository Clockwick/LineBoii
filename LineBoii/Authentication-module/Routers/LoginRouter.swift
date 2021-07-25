//
//  LoginRouter.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import Foundation
import UIKit


class LoginRouter: LoginRouterProtocol {
    
    var entry: EntryPoint?
    
    static func start() -> LoginRouterProtocol {
        let router = LoginRouter()
        
        // Assign VIP
        var view: LoginViewProtocol = LoginViewController()
        var interactor: LoginInteractorProtocol = LoginInteractor()
        var presenter: LoginPresenterProtocol = LoginPresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}

