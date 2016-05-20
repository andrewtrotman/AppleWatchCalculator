//
//  StartInterfaceController.swift
//  Calculator
//
//  Created by Andrew Trotman on 20/05/16.
//  Copyright © 2016 Pinnated. All rights reserved.
//

import WatchKit
import Foundation

/*
	CLASS STARTINTERFACECONTROLLER
	------------------------------
*/
class StartInterfaceController: InterfaceController
	{
	
	/*
		AWAKEWITHCONTEXT()
		------------------
	*/
	override func awakeWithContext(context: AnyObject?)
		{
		super.awakeWithContext(context)
		// Configure interface objects here.
		self.becomeCurrentPage()
		}

	/*
		WILLACTIVATE()
		--------------
	*/
	override func willActivate()
		{
		// This method is called when watch view controller is about to be visible to user
		super.willActivate()
		}
	
	/*
		WILLDISAPPEAR()
		---------------
	*/
	override func willDisappear()
		{
		super.willDisappear()
		}
	
	/*
		DIDAPPEAR()
		-----------
	*/
	override func didAppear()
		{
		super.didAppear()
		}

	/*
		DIDDEACTIVATE()
		---------------
	*/
	override func didDeactivate()
		{
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
		}
}