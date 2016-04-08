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
		setTitle(calculator.press(Calc.button.equals))
		}
	
	/*
		POWER()
		-------
	*/
	@IBAction func power()
		{
		setTitle(calculator.press(Calc.button.power))
		}
		
	/*
		DIVIDE()
		--------
	*/
	@IBAction func divide()
		{
		setTitle(calculator.press(Calc.button.divide))
		}
	
	/*
		MULTIPLY()
		----------
	*/
	@IBAction func multiply()
		{
		setTitle(calculator.press(Calc.button.multiply))
		}
	
	/*
		MINUS()
		-------
	*/
	@IBAction func minus()
		{
		setTitle(calculator.press(Calc.button.minus))
		}
	
	/*
		PLUS()
		------
	*/
	@IBAction func plus()
		{
		setTitle(calculator.press(Calc.button.plus))
		}

	/*
		CLEAR()
		-------
	*/
	@IBAction func clear()
		{
		setTitle(calculator.clear())
		}
		
	/*
		DOT()
		-----
	*/
	@IBAction func dot()
		{
		setTitle(calculator.press(Calc.button.dot))
		}
	/*
		NINE()
		------
	*/
	@IBAction func nine()
		{
		setTitle(calculator.press(Calc.button.nine))
		}

	/*
		EIGHT()
		-------
	*/
	@IBAction func eight()
		{
		setTitle(calculator.press(Calc.button.eight))
		}

	/*
		SEVEN()
		-------
	*/
	@IBAction func seven()
		{
		setTitle(calculator.press(Calc.button.seven))
		}

	/*
		SIX()
		-----
	*/
	@IBAction func six()
		{
		setTitle(calculator.press(Calc.button.six))
		}

	/*
		FIVE()
		-----
	*/
	@IBAction func five()
		{
		setTitle(calculator.press(Calc.button.five))
		}

	/*
		FOUR()
		------
	*/
	@IBAction func four()
		{
		setTitle(calculator.press(Calc.button.four))
		}

	/*
		THREE()
		------
	*/
	@IBAction func three()
		{
		setTitle(calculator.press(Calc.button.three))
		}

	/*
		TWO()
		-----
	*/
	@IBAction func two()
		{
		setTitle(calculator.press(Calc.button.two))
		}

	/*
		ONE()
		-----
	*/
	@IBAction func one()
		{
		setTitle(calculator.press(Calc.button.one))
		}

	/*
		ZERO()
		------
	*/
	@IBAction func zero()
		{
		setTitle(calculator.press(Calc.button.zero))
		}
}
