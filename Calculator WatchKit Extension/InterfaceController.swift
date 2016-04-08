//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by Andrew Trotman on 8/04/16.
//  Copyright © 2016 Pinnated. All rights reserved.
//

import WatchKit
import Foundation

/*
	CLASS INTERFACECONTROLLER
	-------------------------
*/
class InterfaceController: WKInterfaceController
	{
	var calculator = Calc()
	
	/*
		AWAKEWITHCONTEXT()
		------------------
	*/
	override func awakeWithContext(context: AnyObject?)
		{
		super.awakeWithContext(context)
		// Configure interface objects here.
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
		DIDDEACTIVATE()
		---------------
	*/
	override func didDeactivate()
		{
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
		}
		
	/*
		EQUALS()
		--------
	*/
	@IBAction func equals()
		{
		setTitle(String(calculator.press(Calc.button.equals)))
		}
	
	/*
		POWER()
		-------
	*/
	@IBAction func power()
		{
		setTitle(String(calculator.press(Calc.button.power)))
		}
		
	/*
		DIVIDE()
		--------
	*/
	@IBAction func divide()
		{
		setTitle(String(calculator.press(Calc.button.divide)))
		}
	
	/*
		MULTIPLY()
		----------
	*/
	@IBAction func multiply()
		{
		setTitle(String(calculator.press(Calc.button.multiply)))
		}
	
	/*
		MINUS()
		-------
	*/
	@IBAction func minus()
		{
		setTitle(String(calculator.press(Calc.button.minus)))
		}
	
	/*
		PLUS()
		------
	*/
	@IBAction func plus()
		{
		setTitle(String(calculator.press(Calc.button.plus)))
		}

	/*
		CLEAR()
		-------
	*/
	@IBAction func clear()
		{
		setTitle(String(calculator.clear()))
		}
		
	/*
		DOT()
		-----
	*/
	@IBAction func dot()
		{
		setTitle(String(calculator.press(Calc.button.dot)))
		}
	/*
		NINE()
		------
	*/
	@IBAction func nine()
		{
		setTitle(String(calculator.press(Calc.button.nine)))
		}

	/*
		EIGHT()
		-------
	*/
	@IBAction func eight()
		{
		setTitle(String(calculator.press(Calc.button.eight)))
		}

	/*
		SEVEN()
		-------
	*/
	@IBAction func seven()
		{
		setTitle(String(calculator.press(Calc.button.seven)))
		}

	/*
		SIX()
		-----
	*/
	@IBAction func six()
		{
		setTitle(String(calculator.press(Calc.button.six)))
		}

	/*
		FIVE()
		-----
	*/
	@IBAction func five()
		{
		setTitle(String(calculator.press(Calc.button.five)))
		}

	/*
		FOUR()
		------
	*/
	@IBAction func four()
		{
		setTitle(String(calculator.press(Calc.button.four)))
		}

	/*
		THREE()
		------
	*/
	@IBAction func three()
		{
		setTitle(String(calculator.press(Calc.button.three)))
		}

	/*
		TWO()
		-----
	*/
	@IBAction func two()
		{
		setTitle(String(calculator.press(Calc.button.two)))
		}

	/*
		ONE()
		-----
	*/
	@IBAction func one()
		{
		setTitle(String(calculator.press(Calc.button.one)))
		}

	/*
		ZERO()
		------
	*/
	@IBAction func zero()
		{
		setTitle(String(calculator.press(Calc.button.zero)))
		}
}
