//
//  PomodoroRepository.swift
//  PomodoroApp
//
//  Created by Douglas Taquary on 28/08/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation
import CoreData

public protocol PomodoroRepository {

    mutating func fetch(_ completion: @escaping (_ results: [Section]) -> Void)
    func save(_ object: Sample, completion: @escaping (_ error: Swift.Error?) -> Void)

}
