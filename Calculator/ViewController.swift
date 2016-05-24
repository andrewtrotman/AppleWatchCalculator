//
//  ViewController.swift
//  Calculator
//
//  Created by Andrew Trotman on 8/04/16.
//  Copyright © 2016 Pinnated. All rights reserved.
//

import UIKit

var calculator = Calc()

class ViewController: UIViewController
	{
	@IBOutlet weak var display: UILabel!

	/*
		VIEWDIDLOAD()
		-------------
	*/
	override func viewDidLoad()
		{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		}

	/*
		DIDRECEIVEMEMORYWARNING()
		-------------------------
	*/
	override func didReceiveMemoryWarning()
		{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		}
	
	/*
		DISPLAY_RESULTS()
		-----------------
	*/
	func display_results(what : String)
		{
		display.text = what
		}
		
	/*
		SIN()
		-----
	*/
	@IBAction func sin(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.sine))
		}

	/*
		COS()
		-----
	*/
	@IBAction func cos(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.cosine))
		}

	/*
		TAN()
		-----
	*/
	@IBAction func tan(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.tangent))
		}

	/*
		INVERSE_SIN()
		-------------
	*/
	@IBAction func inverse_sin(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.sine_inverse))
		}
	
	/*
		INVERSE_COS()
		-------------
	*/
	@IBAction func inverse_cos(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.cosine_inverse))
		}
	
	/*
		INVERSE_TAN()
		-------------
	*/
	@IBAction func inverse_tan(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.tangent_inverse))
		}
	
	/*
		HYPERBOLIC_SIN()
		----------------
	*/
	@IBAction func hyperbolic_sin(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.sine_hyperbolic))
		}
	
	/*
		HYPERBOLIC_COS()
		----------------
	*/
	@IBAction func hyperbolic_cos(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.cosine_hyperbolic))
		}
	
	/*
		HYPERBOLIC_TAN()
		----------------
	*/
	@IBAction func hyperbolic_tan(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.tangent_hyperbolic))
		}
	
	/*
		INVERSE_HYPERBOLIC_SIN()
		------------------------
	*/
	@IBAction func inverse_hyperbolic_sin(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.sine_hyperbolic_inverse))
		}
	
	/*
		INVERSE_HYPERBOLIC_COS()
		------------------------
	*/
	@IBAction func inverse_hyperbolic_cos(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.cosine_hyperbolic_inverse))
		}

	/*
		INVERSE_HYPERBOLIC_TAN()
		------------------------
	*/
	@IBAction func inverse_hyperbolic_tan(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.tangent_hyperbolic_inverse))
		}
	
	/*
		MEMORY_RECALL()
		---------------
	*/
	@IBAction func memory_recall(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.memory_recall))
		}
	
	/*
		MEMORY_MINUS()
		--------------
	*/
	@IBAction func memory_minus(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.memory_minus))
		}
	
	/*
		MEMORY_PLUS()
		-------------
	*/
	@IBAction func memory_plus(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.memory_plus))
		}
	
	/*
		MEMORY_CLEAR()
		--------------
	*/
	@IBAction func memory_clear(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.memory_clear))
		}
	
	/*
		SHIFT_RIGHT()
		-------------
	*/
	@IBAction func shift_right(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.shift_right))
		}
	
	/*
		OR()
		----
	*/
	@IBAction func or(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.or))
		}
	
	/*
		XOR()
		----
	*/
	@IBAction func xor(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.xor))
		}
	
	/*
		AND()
		-----
	*/
	@IBAction func and(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.and))
		}
	
	/*
		SHIFT_LEFT()
		------------
	*/
	@IBAction func shift_left(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.shift_left))
		}
	
	/*
		ALL_CLEAR()
		-----------
	*/
	@IBAction func all_clear(sender: AnyObject)
		{
		display_results(calculator.clear())
		}

	/*
		EQUALS()
		--------
	*/
	@IBAction func equals(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.equals))
		}
	
	@IBAction func plus_minus(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.plus_minus))
		}
	/*
		DIVIDE()
		--------
	*/
	@IBAction func divide(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.divide))
		}
	
	/*
		MULTIPLY()
	*/
	@IBAction func multiply(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.multiply))
		}
	
	/*
		MINUS()
		-------
	*/
	@IBAction func minus(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.minus))
		}
	
	/*
		PLUS()
		------
	*/
	@IBAction func plus(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.plus))
		}
	
	/*
		FIFTEEN()
		---------
	*/
	@IBAction func fifteen(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.fifteen))
		}
	
	/*
		FOURTEEN()
		----------
	*/
	@IBAction func fourteen(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.fourteen))
		}
	
	/*
		THIRTEEN()
		----------
	*/
	@IBAction func thirteen(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.thirteen))
		}

	/*
		TWELVE()
		--------
	*/
	@IBAction func twelve(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.twelve))
		}

	/*
		ELEVEN()
		--------
	*/
	@IBAction func eleven(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.eleven))
		}
	
	/*
		TEN()
		-----
	*/
	@IBAction func ten(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.ten))
		}
	
	/*
		NINE()
		------
	*/
	@IBAction func nine(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.nine))
		}
	
	/*
		EIGHT()
		-------
	*/
	@IBAction func eight(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.eight))
		}
	
	/*
		SEVEN()
		-------
	*/
	@IBAction func seven(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.seven))
		}
	
	/*
		SIX()
		-----
	*/
	@IBAction func six(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.six))
		}
	
	/*
		FIVE()
		------
	*/
	@IBAction func five(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.five))
		}
	
	/*
		FOUR()
		------
	*/
	@IBAction func four(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.four))
		}
	
	/*
		THREE()
		-------
	*/
	@IBAction func three(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.three))
		}
	
	/*
		TWO()
		-----
	*/
	@IBAction func two(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.two))
		}
	
	/*
		ONE()
		-----
	*/
	@IBAction func one(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.one))
		}
	
	/*
		ZERO()
		------
	*/
	@IBAction func zero(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.zero))
		}
	
	/*
		DOT()
		-----
	*/
	@IBAction func dot(sender: AnyObject)
		{
		display_results(calculator.press(Calc.button.dot))
		}
}

