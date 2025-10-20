//
//  HomeCoordinating.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

public protocol HomeCoordinating: AnyObject {
    func onPressRepository(ownerName: String, repositoryName: String) -> Void
}
