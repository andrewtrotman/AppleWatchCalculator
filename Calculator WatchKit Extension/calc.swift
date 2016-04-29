/*
	CALC.SWIFT
	----------
	Copyright (c) 2016 Pinnated.  All rights reserved.
	Written by Andrew Trotman
*/

import Foundation

/*
	CLASS CALC
	----------
*/
public class Calc
	{
	let max_digits : Int = 10

	public enum button : Int
		{
		case zero = 0, one, two, three, four, five, six, seven, eight, nine
		case dot, plus_minus, equals
		case plus, minus, multiply, divide, power
		case square_root, cube_root
		case sine, cosine, tangent
		case sine_inverse, cosine_inverse, tangent_inverse
		case sine_hyperbolic, cosine_hyperbolic, tangent_hyperbolic
		case sine_hyperbolic_inverse, cosine_hyperbolic_inverse, tangent_hyperbolic_inverse
		case e, pi, c
		case ln, log2, log10
		case degrees, radians, gradians
		}
	
	public enum trig_mode : String
		{
		case degrees = "d"
		case radians = "r"
		case gradians = "g"
		}
	
	var angle_format : trig_mode
	var numeric_stack = [Double]()
	var operator_stack = [button]()

	var last_operand : Double
	var last_was_operator : Bool
	var last_operator : button
	var register : Double
	var last_was_equals : Bool
	var new_integer : Bool
	var decimal_factor : Int
	var input_mode : Bool
	
	var last_answer : String

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
		input_mode = true
		decimal_factor = 0
		last_answer = "0"
		angle_format = trig_mode.degrees
		
		clear()
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
		input_mode = true
		decimal_factor = 0
		last_answer = "0"
		
		/*
			Don't change the angle mode coz that turns out to require the user to repeatedly click the mode button every
			time they click the AC button.
		*/
//		angle_format = trig_mode.degrees

		return set_last_answer(result_to_display(0))
		}

	/*
		SET_LAST_ANSWER()
		-----------------
	*/
	func set_last_answer(value : String) -> String
		{
		last_answer = value
		return value
		}
	
	/*
		GET_TRIG_MODE
		-------------
	*/
	public func get_trig_mode() -> trig_mode
		{
		return angle_format
		}
	
	/*
		GET_LAST_ANSWER()
		-----------------
	*/
	public func get_last_answer() -> String
		{
		return last_answer
		}

	/*
		ANGLE_TO_RADIANS()
		------------------
	*/
	func angle_to_radians(angle : Double) -> Double
		{
		switch (angle_format)
			{
			case trig_mode.degrees:
				return angle * M_PI / 180
			case trig_mode.radians:
				return angle
			case trig_mode.gradians:
				return angle * M_PI / 200
			}
		}


	/*
		RADIANS_TO_ANGLE()
		------------------
	*/
	func radians_to_angle(radians : Double) -> Double
		{
		switch (angle_format)
			{
			case trig_mode.degrees:
				return radians * 180 / M_PI
			case trig_mode.radians:
				return radians
			case trig_mode.gradians:
				return radians * 200 / M_PI
			}
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
		ROUND_TO_SIGNIFICANT_FIGURES()
		------------------------------
	*/
	func round_to_significant_figures(value : Double) -> (rounded : Double, digits_before_dot : Int, digits_after_dot : Int)
		{
		if (value >= pow(10, Double(max_digits)))
			{
			return (Double.infinity, 1, 0)
			}
		else if (value <= -pow(10, Double(max_digits)))
			{
			return (-Double.infinity, 1, 0)
			}
		else
			{
			let sign : Int = value < 0 ? -1 : 1
			let digits = max_digits
			let integer_part = floor(abs(value))
			var fractional_part = abs(value) - integer_part

			let digits_before_dot : Int = Int(integer_part == 0 ? 1 : ceil(log10(integer_part + 1)))
			let decimal_places = pow(10, Double(digits - digits_before_dot))
		
			fractional_part = round(fractional_part * decimal_places) / decimal_places
			let answer = sign == -1 ? -(integer_part + fractional_part) : integer_part + fractional_part
			
			var digits_after_dot = digits - digits_before_dot
			var shift_register : Int = Int(round(fractional_part * decimal_places))
			if (shift_register == 0)
				{
				digits_after_dot = 0
				}
			else
				{
				while (((shift_register / 10) * 10) == shift_register)
					{
					shift_register /= 10
					digits_after_dot -= 1
					if (shift_register == 0)
						{
						break;
						}
					}
				}
			return (answer, digits_before_dot, digits_after_dot)
			}
		}

	/*
		CHECK_AND_PUSH()
		----------------
	*/
	func check_and_push(value : Double)
		{
		if (value.isNaN)
			{
			register = value
			}
		else
			{
			register = round_to_significant_figures(value).rounded
			let negative_zero = -pow(10, -Double(max_digits))
			let positive_zero = pow(10, -Double(max_digits))
			
			if (register >= negative_zero && register <= positive_zero)
				{
				register = 0
				}
			}
		numeric_stack.append(register)
		}
	
	/*
		SET_TRIG_MODE()
		---------------
	*/
	func set_trig_mode(key : button) -> String
		{
		switch (key)
			{
			case button.degrees:
				angle_format = trig_mode.degrees
			case button.radians:
				angle_format = trig_mode.radians
			case button.gradians:
				angle_format = trig_mode.gradians
			default:
				angle_format = trig_mode.degrees
			}

		return get_last_answer()
		}

	/*
		REDUCE()
		--------
	*/
	func reduce(next_operator : button)
		{
		while (!operator_stack.isEmpty && precidence(operator_stack.last!) >= precidence(next_operator))
			{
			/*
				Binary operators
			*/
			let operand_2 = numeric_stack.removeLast()
			let operand_1 = numeric_stack.removeLast()
			let operation = operator_stack.removeLast()
			switch (operation)
				{
				case button.plus:
					check_and_push(operand_1 + operand_2)
				case button.minus:
					check_and_push(operand_1 - operand_2)
				case button.multiply:
					check_and_push(operand_1 * operand_2)
				case button.divide:
					check_and_push(operand_1 / operand_2)
				case button.power:
					check_and_push(pow(operand_1, operand_2))
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
		SET_CONSTANT()
		--------------
	*/
	func set_constant(operation : button) -> String
		{
		if (new_integer)
			{
			register = 0
			decimal_factor = 0
			new_integer = false
			}

		last_was_equals = false
		last_was_operator = false

		switch (operation)
			{
			case button.e:
				register = M_E
			case button.pi:
				register = M_PI
			case button.c:
				register = 299792458			// speed of light (m/s)
			default:
				break
			}
		return result_to_display(register)
		}
	
	/*
		UNARY_FUNCTION
		--------------
	*/
	func unary_function(operation : button) -> String
	{
	switch (operation)
		{
		case button.plus_minus:
			register = -register
		case button.square_root:
			register = sqrt(register)
		case button.cube_root:
			register = cbrt(register)
		case button.sine:
			register = sin(angle_to_radians(register))
		case button.cosine:
			register = cos(angle_to_radians(register))
		case button.tangent:
			register = tan(angle_to_radians(register))
		case button.sine_inverse:
			register = radians_to_angle(asin(register))
		case button.cosine_inverse:
			register = radians_to_angle(acos(register))
		case button.tangent_inverse:
			register = radians_to_angle(atan(register))
		case button.sine_hyperbolic:
			register = sinh(register)
		case button.cosine_hyperbolic:
			register = cosh(register)
		case button.tangent_hyperbolic:
			register = tanh(register)
		case button.sine_hyperbolic_inverse:
			register = asinh(register)
		case button.cosine_hyperbolic_inverse:
			register = acosh(register)
		case button.tangent_hyperbolic_inverse:
			register = atanh(register)
		case button.ln:
			register = log(register)
		case button.log10:
			register = log10(register)
		case button.log2:
			register = log2(register)
		default:
			break
		}
	new_integer = true
	return result_to_display(register)
	}

	/*
		RESULT_TO_DISPLAY
		-----------------
	*/
	func result_to_display(value : Double) -> String
		{
		var digits_after_dot : Int
		
		if (value.isNaN)
			{
			return "NaN"
			}
		else if (value.isInfinite)
			{
			if (value.isSignMinus)
				{
				return "-∞"
				}
			else
				{
				return "∞"
				}
			}
		else if (decimal_factor == 1 && round(value) == value)
			{
			return String(Int64(value))
			}
		else
			{
			let details = round_to_significant_figures(value)
			if (!input_mode)
				{
				digits_after_dot = details.digits_after_dot
				}
			else
				{
				digits_after_dot = -decimal_factor - 1
				}
				
			let formatter = NSNumberFormatter()
			formatter.minimumIntegerDigits = 1
			formatter.maximumFractionDigits = digits_after_dot
			formatter.minimumFractionDigits = digits_after_dot
			
			return formatter.stringFromNumber(details.rounded)! + (input_mode && decimal_factor == -1 ? "." : "")
			}
		}

	/*
		PRESS()
		-------
	*/
	public func press(key : button) -> String
		{
		input_mode = false;
		switch (key)
			{
			case button.zero, button.one, button.two, button.three, button.four, button.five, button.six, button.seven, button.eight, button.nine:
				if (new_integer)
					{
					register = 0
					decimal_factor = 0
					new_integer = false
					}

				var formatted = round_to_significant_figures(register)
				if (formatted.digits_before_dot + formatted.digits_after_dot < max_digits && formatted.digits_before_dot - decimal_factor < max_digits)
					{
					register = register * (decimal_factor == 0 ? 10 : 1) + Double(key.rawValue) * pow(10.0, Double(decimal_factor))
					formatted = round_to_significant_figures(register)
					register = formatted.rounded
					if (decimal_factor < 0)
						{
						decimal_factor -= 1
						}
					}
				last_was_equals = false
				last_was_operator = false
				input_mode = true;
				return set_last_answer(result_to_display(register))

			case button.dot:
				if (new_integer)
					{
					register = 0
					new_integer = false
					}
				decimal_factor = -1
				last_was_equals = false
				last_was_operator = false
				input_mode = true;
				return set_last_answer(result_to_display(register))
			
			case button.plus, button.minus, button.multiply, button.divide, button.power:
				if (!last_was_operator)
					{
					numeric_stack.append(register)
					reduce(key)
					}
				else
					{
					/*
						This is for when the user goes 4 + * 4 which should equal 16 not 8.
					*/
					operator_stack.removeLast()
					operator_stack.append(key)
					}
				new_integer = true
				last_operator = key
				last_was_equals = false
				last_was_operator = true
			
				return set_last_answer(result_to_display(numeric_stack.last!))
			
			case button.plus_minus, button.square_root, button.cube_root,
				button.sine, button.cosine, button.tangent,
				button.sine_inverse, button.cosine_inverse, button.tangent_inverse,
				button.sine_hyperbolic, button.cosine_hyperbolic, button.tangent_hyperbolic,
				button.sine_hyperbolic_inverse, button.cosine_hyperbolic_inverse, button.tangent_hyperbolic_inverse,
				button.ln, button.log2, button.log10:
				
				return set_last_answer(unary_function(key))
			
			case button.e, button.pi, button.c:
				return set_last_answer(set_constant(key))
			
			case button.degrees, button.radians, button.gradians:
				return set_last_answer(set_trig_mode(key))

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
					reduce(key)
					}
				new_integer = true
				last_was_equals = true
				last_was_operator = false
				return set_last_answer(result_to_display(numeric_stack.isEmpty ? register : numeric_stack.removeLast()))
			}
		}
}
