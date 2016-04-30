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
		display_results("", pling: false);
		}

	/*
		WILLACTIVATE()
		--------------
	*/
	override func willActivate()
		{
		// This method is called when watch view controller is about to be visible to user
		super.willActivate()
		display_results(calculator.get_last_answer(), pling: false);
		}
	
	/*
		WILLDISAPPEAR()
		---------------
	*/
	override func willDisappear()
		{
		super.willDisappear()
		display_results("", pling: false);
		}
	
	/*
		DIDAPPEAR()
		-----------
	*/
	override func didAppear()
		{
		super.didAppear()
		display_results(calculator.get_last_answer(), pling: false);
		}

	/*
		DIDDEACTIVATE()
		---------------
	*/
	override func didDeactivate()
		{
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
		display_results("", pling: false)
		}

	/*
		DISPLAY_RESULTS()
		-----------------
	*/
	func display_results(result : String, pling : Bool = true)
		{
		var mode : String = ""
		
		if (calculator.get_trig_mode() != Calc.trig_mode.degrees)
			{
			mode = calculator.get_trig_mode().rawValue + (result.hasPrefix("-") ? "" : " ")
			}
		setTitle(mode + result)
		if (pling)
			{
			WKInterfaceDevice.currentDevice().playHaptic(.Click)
			}
		}

	/*
		DEGREES()
		---------
	*/
	@IBAction func degrees()
		{
		display_results(calculator.press(Calc.button.degrees))
		}
	
	/*
		RADIANS()
		---------
	*/
	@IBAction func radians()
		{
		display_results(calculator.press(Calc.button.radians))
		}
	
	/*
		GRADIANS()
		----------
	*/
	@IBAction func gradians()
		{
		display_results(calculator.press(Calc.button.gradians))
		}

	/*
		AND()
		-----
	*/
	@IBAction func and()
		{
		display_results(calculator.press(Calc.button.and))
		}

	/*
		OR()
		----
	*/
	@IBAction func or()
		{
		display_results(calculator.press(Calc.button.or))
		}

	/*
		XOR()
		-----
	*/
	@IBAction func xor()
		{
		display_results(calculator.press(Calc.button.xor))
		}

	/*
		NOT()
		-----
	*/
	@IBAction func not()
		{
		display_results(calculator.press(Calc.button.not))
		}
	
	/*
		SHIFT_LEFT()
		------------
	*/
	@IBAction func shift_left()
		{
		display_results(calculator.press(Calc.button.shift_left))
		}
	
	/*
		SHIFT_RIGHT()
		-------------
	*/
	@IBAction func shift_right()
		{
		display_results(calculator.press(Calc.button.shift_right))
		}
	/*
		MEMORY_CLEAR()
		--------------
	*/
	@IBAction func memory_clear()
		{
		display_results(calculator.press(Calc.button.memory_clear))
		}
	
	/*
		MEMORY_RECALL()
		---------------
	*/
	@IBAction func memory_recall()
		{
		display_results(calculator.press(Calc.button.memory_recall))
		}

	/*
		MEMORY_PLUS()
		-------------
	*/
	@IBAction func memory_plus()
		{
		display_results(calculator.press(Calc.button.memory_plus))
		}
	
	/*
		MEMORY_MINUS()
		--------------
	*/
	@IBAction func memory_minus()
		{
		display_results(calculator.press(Calc.button.memory_minus))
		}
	
	/*
		LN()
		----
	*/
	@IBAction func ln()
		{
		display_results(calculator.press(Calc.button.ln))
		}
	
	/*
		LOG2()
		------
	*/
	@IBAction func log2()
		{
		display_results(calculator.press(Calc.button.log2))
		}
	
	/*
		LOG10()
		-------
	*/
	@IBAction func log10()
		{
		display_results(calculator.press(Calc.button.log10))
		}
		
	/*
		E()
		---
	*/
	@IBAction func e()
		{
		display_results(calculator.press(Calc.button.e))
		}
	
	/*
		C()
		---
	*/
	@IBAction func c()
		{
		display_results(calculator.press(Calc.button.c))
		}
	/*
		PI()
		----
	*/
	@IBAction func pi()
		{
		display_results(calculator.press(Calc.button.pi))
		}
	
	/*
		SINE()
		------
	*/
	@IBAction func sine()
		{
		display_results(calculator.press(Calc.button.sine))
		}
	
	/*
		SINE_INVERSE()
		--------------
	*/
	@IBAction func sine_inverse()
		{
		display_results(calculator.press(Calc.button.sine_inverse))
		}
	
	/*
		SINE_HYPERBOLIC()
		-----------------
	*/
	@IBAction func sine_hyperbolic()
		{
		display_results(calculator.press(Calc.button.sine_hyperbolic))
		}
	
	/*
		SINE_HYPERBOLIC_INVERSE()
		-------------------------
	*/
	@IBAction func sine_hyperbolic_inverse()
		{
		display_results(calculator.press(Calc.button.sine_hyperbolic_inverse))
		}
	
	/*
		COSINE()
		--------
	*/
	@IBAction func cosine()
		{
		display_results(calculator.press(Calc.button.cosine))
		}
	
	/*
		COSINE_INVERSE()
		----------------
	*/
	@IBAction func cosine_inverse()
		{
		display_results(calculator.press(Calc.button.cosine_inverse))
		}
	
	/*
		COSINE_HYPERBOLIC()
		-------------------
	*/
	@IBAction func cosine_hyperbolic()
		{
		display_results(calculator.press(Calc.button.cosine_hyperbolic))
		}
	
	/*
		COSINE_HYPERBOLIC_INVERSE()
		---------------------------
	*/
	@IBAction func cosine_hyperbolic_inverse()
		{
		display_results(calculator.press(Calc.button.cosine_hyperbolic_inverse))
		}
	
	/*
		TANGENT()
		---------
	*/
	@IBAction func tangent()
		{
		display_results(calculator.press(Calc.button.tangent))
		}

	/*
		TANGENT_INVERSE()
		-----------------
	*/
	@IBAction func tangent_inverse()
		{
		display_results(calculator.press(Calc.button.tangent_inverse))
		}
	
	/*
		TANGENT_HYPERBOLIC()
		--------------------
	*/
	@IBAction func tangent_hyperbolic()
		{
		display_results(calculator.press(Calc.button.tangent_hyperbolic))
		}
	
	/*
		TANGENT_HYPERBOLIC_INVERSE()
		----------------------------
	*/
	@IBAction func tangent_hyperbolic_inverse()
		{
		display_results(calculator.press(Calc.button.tangent_hyperbolic_inverse))
		}

	/*
		CUBE_ROOT()
		-----------
	*/
	@IBAction func cube_root()
		{
		display_results(calculator.press(Calc.button.cube_root))
		}
	/*
		SQUARE_ROOT()
		-------------
	*/
	@IBAction func square_root()
		{
		display_results(calculator.press(Calc.button.square_root))
		}
	
	/*
		PLUS_MINUS()
		------------
	*/
	@IBAction func plus_minus()
		{
		display_results(calculator.press(Calc.button.plus_minus))
		}
	
	/*
		EQUALS()
		--------
	*/
	@IBAction func equals()
		{
		display_results(calculator.press(Calc.button.equals))
		}
	
	/*
		POWER()
		-------
	*/
	@IBAction func power()
		{
		display_results(calculator.press(Calc.button.power))
		}
		
	/*
		DIVIDE()
		--------
	*/
	@IBAction func divide()
		{
		display_results(calculator.press(Calc.button.divide))
		}
	
	/*
		MULTIPLY()
		----------
	*/
	@IBAction func multiply()
		{
		display_results(calculator.press(Calc.button.multiply))
		}
	
	/*
		MINUS()
		-------
	*/
	@IBAction func minus()
		{
		display_results(calculator.press(Calc.button.minus))
		}
	
	/*
		PLUS()
		------
	*/
	@IBAction func plus()
		{
		display_results(calculator.press(Calc.button.plus))
		}

	/*
		CLEAR()
		-------
	*/
	@IBAction func clear()
		{
		display_results(calculator.clear())
		}
		
	/*
		DOT()
		-----
	*/
	@IBAction func dot()
		{
		display_results(calculator.press(Calc.button.dot))
		}
	/*
		NINE()
		------
	*/
	@IBAction func nine()
		{
		display_results(calculator.press(Calc.button.nine))
		}

	/*
		EIGHT()
		-------
	*/
	@IBAction func eight()
		{
		display_results(calculator.press(Calc.button.eight))
		}

	/*
		SEVEN()
		-------
	*/
	@IBAction func seven()
		{
		display_results(calculator.press(Calc.button.seven))
		}

	/*
		SIX()
		-----
	*/
	@IBAction func six()
		{
		display_results(calculator.press(Calc.button.six))
		}

	/*
		FIVE()
		-----
	*/
	@IBAction func five()
		{
		display_results(calculator.press(Calc.button.five))
		}

	/*
		FOUR()
		------
	*/
	@IBAction func four()
		{
		display_results(calculator.press(Calc.button.four))
		}

	/*
		THREE()
		------
	*/
	@IBAction func three()
		{
		display_results(calculator.press(Calc.button.three))
		}

	/*
		TWO()
		-----
	*/
	@IBAction func two()
		{
		display_results(calculator.press(Calc.button.two))
		}

	/*
		ONE()
		-----
	*/
	@IBAction func one()
		{
		display_results(calculator.press(Calc.button.one))
		}

	/*
		ZERO()
		------
	*/
	@IBAction func zero()
		{
		display_results(calculator.press(Calc.button.zero))
		}
}
