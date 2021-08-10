//
//  KeyboardResponder.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/4/21.
//

import Foundation
import SwiftUI

// TODO: Added for Login but didn't end up using it
class KeyboardResponder: ObservableObject {
	@Published var currentHeight: CGFloat = 0

	var _center: NotificationCenter

	init(center: NotificationCenter = .default) {
		_center = center

		_center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		_center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	@objc func keyBoardWillShow(notification: Notification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			withAnimation {
				currentHeight = keyboardSize.height
			}
		}
	}
	
	@objc func keyBoardWillHide(notification: Notification) {
		withAnimation {
			currentHeight = 0
		}
	}
}
