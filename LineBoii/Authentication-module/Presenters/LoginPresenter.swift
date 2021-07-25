//
//  LoginPresenters.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import Foundation



class LoginPresenter: LoginPresenterProtocol {
    var router: LoginRouterProtocol?
    
    var interactor: LoginInteractorProtocol?
    
    var view: LoginViewProtocol?
    
}
