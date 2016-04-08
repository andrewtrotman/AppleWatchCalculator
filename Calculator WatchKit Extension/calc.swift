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
	var last_operator : button = button.equals

	var register : Double = 0
	var integer_digits : Bool = true
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
					numeric_stack.append(operand_1 + operand_2)
				case button.minus:
					numeric_stack.append(operand_1 - operand_2)
				case button.multiply:
					numeric_stack.append(operand_1 * operand_2)
				case button.divide:
					numeric_stack.append(operand_1 / operand_2)
				case button.power:
					numeric_stack.append(pow(operand_1, operand_2))
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
	public func clear() -> Double
		{
		numeric_stack.removeAll()
		operator_stack.removeAll()
		register = 0
		integer_digits = true
		decimal_factor = 10

		return 0;
		}
		
	/*
		PRESS()
		-------
	*/
	public func press(key : button) -> Double
		{
		var response : Double

		switch (key)
			{
			case button.zero, button.one, button.two, button.three, button.four, button.five, button.six, button.seven, button.eight, button.nine:
				if (integer_digits)
					{
					register = register * 10 + Double(key.rawValue)
					}
				else
					{
					register = register + (Double(key.rawValue) / Double(decimal_factor))
					decimal_factor *= 10
					}
				response = register
			case button.dot:
				integer_digits = false;
				response = register;
			case button.plus, button.minus, button.multiply, button.divide, button.power:
				numeric_stack.append(register);
				last_operator = key;
				reduce(key);
				register = 0;
				integer_digits = true;
				decimal_factor = 10;
				response = numeric_stack.last!;
			case button.equals:
				numeric_stack.append(register);
				reduce(key);
				response = numeric_stack.removeLast();
			}
		return response;
		}
}