//
//  ViewModelable.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/9/25.
//

import SwiftUI
import Combine

protocol ViewModelable: ObservableObject {
  associatedtype Action
  associatedtype State
  
  var state: State { get }
  
  func action(_ action: Action)
}
