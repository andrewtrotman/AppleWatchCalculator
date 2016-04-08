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

	var last_was_operator : Bool = false
	var last_operator : button = button.plus
	var register : Double = 0
	var integer_digits : Bool = true
	var last_was_equals : Bool = false
	var new_integer : Bool = true
	var decimal_factor : Int = 10

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
		new_integer = true

		return "0";
		}

	/*
		PRESS()
		-------
	*/
	public func press(key : button) -> String
		{
		var response : String

		switch (key)
			{
			case button.zero, button.one, button.two, button.three, button.four, button.five, button.six, button.seven, button.eight, button.nine:
				if (new_integer)
					{
					register = 0;
					integer_digits = true
					decimal_factor = 10
					new_integer = false
					}
				if (integer_digits)
					{
					register = register * 10 + Double(key.rawValue)
					response = String(Int(register))
					}
				else
					{
					register = register + (Double(key.rawValue) / Double(decimal_factor))
					decimal_factor *= 10
					response = String(register)
					}
				last_was_equals = false;
				last_was_operator = false;

			case button.dot:
				integer_digits = false
				response = String(Int(register)) + "."
				last_was_equals = false;
				last_was_operator = false;

			
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

				if (Double(Int(numeric_stack.last!)) == numeric_stack.last!)
					{
					response = String(Int(numeric_stack.last!))
					}
				else
					{
					response = String(numeric_stack.last!)
					}
				new_integer = true
				last_operator = key
				last_was_equals = false;
				last_was_operator = true;

			case button.equals:
				if (last_was_equals)
					{
					numeric_stack.append(register)
					reduce(last_operator);
					}
				else
					{
					numeric_stack.append(register)
					reduce(key);
					}
				new_integer = true
				last_was_equals = true;
				last_was_operator = false;
				
				if (Double(Int(numeric_stack.last!)) == numeric_stack.last!)
					{
					response = String(Int(numeric_stack.removeLast()))
					}
				else
					{
					response = String(numeric_stack.removeLast())
					}
			}
		return response;
		}
}