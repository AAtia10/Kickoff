//
//  FavPresenter.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 02/06/2025.
//

import Foundation
class FavPresenter {
    
    var view: FavViewProtocol?

    init(view: FavViewProtocol) {
        self.view = view
    }

    func fetchFav() {
       
        let list = LocalDataSource.instance.getFavLeagues()
        view?.showFavoriteLeagues(list)
        }
    
    func removeLeague(id:Int){
        LocalDataSource.instance.removeLeague(byKey:id){
            fetchFav()
        }
        
    }
    }

