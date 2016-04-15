//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by Andrew Trotman on 8/04/16.
//  Copyright © 2016 Pinnated. All rights reserved.
//

import WatchKit
import Foundation

var calculator = Calc()

/*
	CLASS INTERFACECONTROLLER
	-------------------------
*/
class InterfaceController: WKInterfaceController
	{
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
		setTitle(calculator.get_last_answer());
		}
	
	/*
		WILLDISAPPEAR()
		---------------
	*/
	override func willDisappear()
		{
		super.willDisappear()
		setTitle("");
		}
	
	/*
		DIDAPPEAR()
		-----------
	*/
	override func didAppear()
		{
		super.didAppear()
		setTitle(calculator.get_last_answer());
		}

	/*
		DIDDEACTIVATE()
		---------------
	*/
	override func didDeactivate()
		{
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
		setTitle("")
		}

	/*
		SINE()
		------
	*/
	@IBAction func sine()
		{
		setTitle(calculator.press(Calc.button.sine))
		}
	
	/*
		SINE_INVERSE()
		--------------
	*/
	@IBAction func sine_inverse()
		{
		setTitle(calculator.press(Calc.button.sine_inverse))
		}
	
	/*
		SINE_HYPERBOLIC()
		-----------------
	*/
	@IBAction func sine_hyperbolic()
		{
		setTitle(calculator.press(Calc.button.sine_hyperbolic))
		}
	
	/*
		SINE_HYPERBOLIC_INVERSE()
		-------------------------
	*/
	@IBAction func sine_hyperbolic_inverse()
		{
		setTitle(calculator.press(Calc.button.sine_hyperbolic_inverse))
		}
	
	/*
		COSINE()
		--------
	*/
	@IBAction func cosine()
		{
		setTitle(calculator.press(Calc.button.cosine))
		}
	
	/*
		COSINE_INVERSE()
		----------------
	*/
	@IBAction func cosine_inverse()
		{
		setTitle(calculator.press(Calc.button.cosine_inverse))
		}
	
	/*
		COSINE_HYPERBOLIC()
		-------------------
	*/
	@IBAction func cosine_hyperbolic()
		{
		setTitle(calculator.press(Calc.button.cosine_hyperbolic))
		}
	
	/*
		COSINE_HYPERBOLIC_INVERSE()
		---------------------------
	*/
	@IBAction func cosine_hyperbolic_inverse()
		{
		setTitle(calculator.press(Calc.button.cosine_hyperbolic_inverse))
		}
	
	/*
		TANGENT()
		---------
	*/
	@IBAction func tangent()
		{
		setTitle(calculator.press(Calc.button.tangent))
		}

	/*
		TANGENT_INVERSE()
		-----------------
	*/
	@IBAction func tangent_inverse()
		{
		setTitle(calculator.press(Calc.button.tangent_inverse))
		}
	
	/*
		TANGENT_HYPERBOLIC()
		--------------------
	*/
	@IBAction func tangent_hyperbolic()
		{
		setTitle(calculator.press(Calc.button.tangent_hyperbolic))
		}
	
	/*
		TANGENT_HYPERBOLIC_INVERSE()
		----------------------------
	*/
	@IBAction func tangent_hyperbolic_inverse()
		{
		setTitle(calculator.press(Calc.button.tangent_hyperbolic_inverse))
		}

	/*
		SQUARE_ROOT()
		-------------
	*/
	@IBAction func square_root()
		{
		setTitle(calculator.press(Calc.button.square_root))
		}
	
	/*
		PLUS_MINUS()
		------------
	*/
	@IBAction func plus_minus()
		{
		setTitle(calculator.press(Calc.button.plus_minus))
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
