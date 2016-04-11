//
//  Calc.swift
//  Calculator
//
//  Created by Andrew Trotman on 8/04/16.
//  Copyright © 2016 Pinnated. All rights reserved.
//

import Foundation

/*
	CLASS CALC
	----------
*/
public class Calc
	{
	public enum button : Int
		{
		case zero = 0, one, two, three, four, five, six, seven, eight, nine
		case dot, equals
		case plus, minus, multiply, divide, power;
		}
	
	var numeric_stack = [Double]()
	var operator_stack = [button]()

	var last_operand : Double
	var last_was_operator : Bool
	var last_operator : button
	var register : Double
	var last_was_equals : Bool
	var new_integer : Bool
	var decimal_factor : Int

	/*
		INIT()
		------
	*/
	init()
		{
		numeric_stack.removeAll()
		operator_stack.removeAll()

		last_operand = 0
		last_was_operator = false
		last_operator = button.equals
		register = 0
		last_was_equals = true
		new_integer = true
		decimal_factor = 0
		
		clear()
		}
	
	/*
		PRECIDENCE()
		------------
	*/
	func precidence(operation : button) -> Int
		{
		switch (operation)
			{
			case button.equals:
				return 0
			case button.plus, button.minus:
				return 1
			case button.multiply, button.divide:
				return 2
			case button.power:
				return 3
			default:
				return -1
			}
		}

	/*
		REDUCE()
		--------
	*/
	func reduce(next_operator : button)
		{
		while (!operator_stack.isEmpty && precidence(operator_stack.last!) >= precidence(next_operator))
			{
			let operand_2 = numeric_stack.removeLast()
			let operand_1 = numeric_stack.removeLast()
			let operation = operator_stack.removeLast()
			switch (operation)
				{
				case button.plus:
					register = operand_1 + operand_2
					numeric_stack.append(register)
				case button.minus:
					register = operand_1 - operand_2
					numeric_stack.append(register)
				case button.multiply:
					register = operand_1 * operand_2
					numeric_stack.append(register)
				case button.divide:
					register = operand_1 / operand_2
					numeric_stack.append(register)
				case button.power:
					register = pow(operand_1, operand_2)
					numeric_stack.append(register)
				default:
					break
				}
		}
	if (next_operator != button.equals)
		{
		operator_stack.append(next_operator)
		}
	}

	/*
		CLEAR()
		-------
	*/
	public func clear() -> String
		{
		numeric_stack.removeAll()
		operator_stack.removeAll()

		last_operand = 0
		last_was_operator = false
		last_operator = button.equals
		register = 0
		last_was_equals = true
		new_integer = true
		decimal_factor = 0

		return result_to_display(0)
		}

	/*
		RESULT_TO_DISPLAY
		-----------------
	*/
	func result_to_display(value : Double) -> String
		{
		let max_digits : Int = 10
		var digits_after_dot : Int
		
		if (value.isNaN)
			{
			return "NaN";
			}
		else if (value.isInfinite)
			{
			if (value.isSignMinus)
				{
				return "-∞";
				}
			else
				{
				return "∞";
				}
			}
		else if (decimal_factor == 1 && round(value) == value)
			{
			return String(Int64(value))
			}
		else
			{
			if (last_was_equals)
				{
				let decimal_part = value - round(value)
				digits_after_dot = decimal_part == 0 ? 0 : Int(log10(decimal_part))
				}
			else
				{
				digits_after_dot = -decimal_factor - 1
				}
				
			let formatter = NSNumberFormatter()
			formatter.minimumIntegerDigits = 1
			formatter.maximumFractionDigits = max_digits
			formatter.minimumFractionDigits = digits_after_dot
			return formatter.stringFromNumber(value)! + (decimal_factor == -1 ? "." : "")
			}
		}

	/*
		PRESS()
		-------
	*/
	public func press(key : button) -> String
		{
		switch (key)
			{
			case button.zero, button.one, button.two, button.three, button.four, button.five, button.six, button.seven, button.eight, button.nine:
				if (new_integer)
					{
					register = 0;
					decimal_factor = 0
					new_integer = false
					}
				register = register * (decimal_factor == 0 ? 10 : 1) + Double(key.rawValue) * pow(10.0, Double(decimal_factor))
				if (decimal_factor < 0)
					{
					decimal_factor -= 1
					}
				last_was_equals = false
				last_was_operator = false
				return result_to_display(register)

			case button.dot:
				if (new_integer)
					{
					register = 0;
					new_integer = false;
					}
				decimal_factor = -1;
				last_was_equals = false
				last_was_operator = false
				return result_to_display(register)
			
			case button.plus, button.minus, button.multiply, button.divide, button.power:
				if (!last_was_operator)
					{
					numeric_stack.append(register)
					reduce(key)
					}
				else
					{
					operator_stack.removeLast()
					operator_stack.append(key)
					}
				new_integer = true
				last_operator = key
				last_was_equals = false
				last_was_operator = true
			
				return result_to_display(numeric_stack.last!)

			case button.equals:
				if (last_was_equals)
					{
					numeric_stack.append(register)
					numeric_stack.append(last_operand)
					operator_stack.append(last_operator)
					reduce(key)
					}
				else
					{
					last_operand = register
					numeric_stack.append(register)
					reduce(key);
					}
				new_integer = true
				last_was_equals = true
				last_was_operator = false
				return result_to_display(numeric_stack.isEmpty ? register : numeric_stack.removeLast())
			}
		}
}
