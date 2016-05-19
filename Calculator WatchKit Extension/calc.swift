/*
	CALC.SWIFT
	----------
	Copyright (c) 2016 Pinnated.  All rights reserved.
	Written by Andrew Trotman
*/

import Swift
import Foundation

/*
	CLASS CALC
	----------
*/
public class Calc
	{
	let max_digits : Int = 9
	let max_hex_value : Int64 = 0xFFFFFFFF

	public enum button : Int
		{
		case zero = 0, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen
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
		case hexadecimal, decimal
		case memory_plus, memory_minus, memory_clear, memory_recall
		case and, or, xor, not, shift_left, shift_right
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
	var last_answer_as_value : Double
	
	var memory : Double
	
	var numeric_base : Int64

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
		last_answer_as_value = 0
		memory = 0
		angle_format = trig_mode.degrees
		numeric_base = 10
		
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
		last_answer_as_value = 0

		/*
			Don't change:
				the base (ie Hex or Decimal)
				the value stored in the memory coz its common to compute a value, them m+, then ac, then use memory result.
				the angle mode coz that turns out to require the user to repeatedly click the mode button every time they click the AC button.
		*/
//		numeric_base = 10
//		memory = 0
//		angle_format = trig_mode.degrees

		return set_last_answer(result_to_display(0), as_Double: 0)
		}

	/*
		SET_LAST_ANSWER()
		-----------------
	*/
	func set_last_answer(as_string : String, as_Double : Double) -> String
		{
		last_answer = as_string
		last_answer_as_value = as_Double
		return last_answer
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
		GET_BASE()
		----------
		Returns 10 for base 10 and 16 fgor base 16
	*/
	public func get_base() -> Int
		{
		return Int(numeric_base)
		}
	
	/*
		GET_LAST_ANSWER_AS_VALUE()
		--------------------------
	*/
	public func get_last_answer_as_value() -> Double
		{
		return last_answer_as_value
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
				return angle * Double(M_PI) / 180
			case trig_mode.radians:
				return angle
			case trig_mode.gradians:
				return angle * Double(M_PI) / 200
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
				return radians * 180 / Double(M_PI)
			case trig_mode.radians:
				return radians
			case trig_mode.gradians:
				return radians * 200 / Double(M_PI)
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
			case button.or:
				return 1
			case button.xor:
				return 2
			case button.and:
				return 3
			case button.plus, button.minus:
				return 4
			case button.multiply, button.divide:
				return 5
			case button.power:
				return 6
			default:
				return -1
			}
		}

	/*
		LOG_BASE
	*/
	func log_base(value: Double, base: Double) -> Double
		{
		return Double(log(Double(value)) / log(Double(base)))
		}
	
	/*
		ROUND_TO_SIGNIFICANT_FIGURES()
		------------------------------
	*/
	func round_to_significant_figures(value : Double, base : Int) -> (rounded : Double, digits_before_dot : Int, digits_after_dot : Int)
		{
		if (value >= Double(pow(Double(base), Double(max_digits))))
			{
			return (Double(Double.infinity), 1, 0)
			}
		else if (value <= -Double(pow(Double(base), Double(max_digits))))
			{
			return (-Double(Double.infinity), 1, 0)
			}
		else
			{
			let sign : Int = value < 0 ? -1 : 1
			let digits = max_digits
			let integer_part = Double(floor(Double(abs(value))))
			var fractional_part = Double(abs(value)) - Double(integer_part)

			let digits_before_dot : Int = Int(integer_part == 0 ? 1 : ceil(Double(log_base(Double(integer_part + 1), base: Double(base)))))
			let decimal_places = Double(pow(Double(base), Double(digits - digits_before_dot)))

			fractional_part = Double(round(Double(fractional_part * decimal_places))) / decimal_places
			let answer = sign == -1 ? -(integer_part + fractional_part) : integer_part + fractional_part
			
			var digits_after_dot = digits - digits_before_dot
			var shift_register : Int64 = Int64(round(Double(fractional_part * decimal_places)))
			if (shift_register == 0)
				{
				digits_after_dot = 0
				}
			else
				{
				while (((shift_register / Int64(base)) * Int64(base)) == shift_register)
					{
					shift_register /= Int64(base)
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
		if (Double(value).isNaN)
			{
			register = value
			}
		else
			{
			register = round_to_significant_figures(value, base: Int(numeric_base)).rounded

			let negative_zero = -Double(pow(10, -Double(max_digits)))
			let positive_zero = -Double(pow(10, -Double(max_digits)))
			
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
	func set_trig_mode(key : button)
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
					check_and_push(Double(pow(Double(operand_1), Double(operand_2))))
				case button.and:
					check_and_push(Double(Int64(operand_1) & Int64(operand_2)))
				case button.or:
					check_and_push(Double(Int64(operand_1) | Int64(operand_2)))
				case button.xor:
					check_and_push(Double(Int64(operand_1) ^ Int64(operand_2)))
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
	func set_constant(operation : button) -> Double
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
				register = Double(M_E)
			case button.pi:
				register = Double(M_PI)
			case button.c:
				register = 299792458			// speed of light (m/s)
			default:
				break
			}
		return register
		}
	
	/*
		UNARY_FUNCTION
		--------------
	*/
	func unary_function(operation : button) -> Double
	{
	switch (operation)
		{
		case button.plus_minus:
			register = -register
		case button.square_root:
			register = Double(sqrt(Double(register)))
		case button.cube_root:
			register = Double(cbrt(Double(register)))
		case button.sine:
			register = Double(sin(Double(angle_to_radians(register))))
		case button.cosine:
			register = Double(cos(Double(angle_to_radians(register))))
		case button.tangent:
			register = Double(tan(Double(angle_to_radians(register))))
		case button.sine_inverse:
			register = Double(radians_to_angle(Double(asin(Double(register)))))
		case button.cosine_inverse:
			register = Double(radians_to_angle(Double(acos(Double(register)))))
		case button.tangent_inverse:
			register = Double(radians_to_angle(Double(atan(Double(register)))))
		case button.sine_hyperbolic:
			register = Double(sinh(Double(register)))
		case button.cosine_hyperbolic:
			register = Double(cosh(Double(register)))
		case button.tangent_hyperbolic:
			register = Double(tanh(Double(register)))
		case button.sine_hyperbolic_inverse:
			register = Double(asinh(Double(register)))
		case button.cosine_hyperbolic_inverse:
			register = Double(acosh(Double(register)))
		case button.tangent_hyperbolic_inverse:
			register = Double(atanh(Double(register)))
		case button.ln:
			register = Double(log(Double(register)))
		case button.log10:
			register = Double(log10(Double(register)))
		case button.log2:
			register = Double(log2(Double(register)))
		case button.shift_left:
			register = Double(Int64(register) << 1)
		case button.shift_right:
			register = Double(Int64(register) >> 1)
		case button.not:
			register = Double(~Int64(register) & max_hex_value)
		default:
			break
		}
	new_integer = true
	return register
	}

	/*
		RESULT_TO_DISPLAY_BASE()
		------------------------
	*/
	func result_to_display_base(original_value : Double, original_required_digits_after_dot : Int, base : Int64) -> String
		{
		let required_digits_after_dot = original_required_digits_after_dot;
		let letter = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
		var answer = ""

		/*
			break into sign, integer, and fractional parts
		*/
		let sign = original_value < 0 ? -1 : 1
		let value = abs(original_value)
		var integer_part : Int64 = Int64(value)
		let fractional_part_as_double = (value - Double(integer_part)) * pow(Double(base), Double(required_digits_after_dot))
		var fractional_part = Int64(fractional_part_as_double)
		
		/*
			round at the least significant digit
		*/
		let rounding = fractional_part_as_double - Double(fractional_part)
		if (rounding > 0.5)
			{
			fractional_part = fractional_part + 1;
			if (fractional_part >= Int64(pow(Double(base), Double(required_digits_after_dot))))
				{
				fractional_part = 0
				integer_part = integer_part + 1
				}
			}
		else if (rounding == 0.5 && (fractional_part == 0 || (fractional_part & 1) != 0))
			{
			fractional_part = fractional_part + 1   // don't ask.  This is described as "strange" in the algorithm!!!
			}
		/*
			Print out the fractinal part
		*/
		if (required_digits_after_dot > 0)
			{
			for _ in (1 ... required_digits_after_dot)
				{
				let digit = fractional_part % base
				answer = letter[Int(digit)] + answer;
				fractional_part = fractional_part / base
				}
			}
			
		/*
			put the dot in place
		*/
		answer = answer == "" ? answer : "." + answer

		/*
			Now print out the integer part
		*/
		if (integer_part == 0)
			{
			answer = "0" + answer
			}
		else
			{
			for power in (0 ... max_digits)
				{
				let divisor = Int64(pow(Double(base), Double(power)))
				
				if (integer_part >= divisor)
					{
					let digit = (integer_part / divisor) % base
					answer = letter[Int(digit)] + answer
					}
				}
			}

		/*
			put the sign back in (and check for zero)
		*/
		return answer == "" ? "0" : sign < 0 ? "-" + answer : answer
		}

	/*
		RESULT_TO_DISPLAY
		-----------------
	*/
	func result_to_display(value : Double) -> String
		{
		var digits_after_dot : Int
		
		if (Double(value).isNaN)
			{
			return "NaN"
			}
		else if (Double(value).isInfinite)
			{
			if (Double(value).isSignMinus)
				{
				return "-∞"
				}
			else
				{
				return "∞"
				}
			}
		else
			{
			let details = round_to_significant_figures(value, base: Int(numeric_base))
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
			
//			let got = result_to_display_base(details.rounded, required_digits_after_dot: digits_after_dot, base: numeric_base)
			let got = result_to_display_base(value, original_required_digits_after_dot: digits_after_dot, base: numeric_base)
			return got + (input_mode && decimal_factor == -1 ? "." : "")
			
//			return formatter.stringFromNumber(details.rounded)! + (input_mode && decimal_factor == -1 ? "." : "")
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
			case button.zero, button.one, button.two, button.three, button.four, button.five, button.six, button.seven, button.eight, button.nine, button.ten, button.eleven, button.twelve, button.thirteen, button.fourteen, button.fifteen:
				if (numeric_base == 10 && key.rawValue > 9)
					{
					return get_last_answer()
					}
				else
					{
					if (new_integer)
						{
						register = 0
						decimal_factor = 0
						new_integer = false
						}

					var formatted = round_to_significant_figures(register, base: Int(numeric_base))
					if (formatted.digits_before_dot + formatted.digits_after_dot < max_digits && formatted.digits_before_dot - decimal_factor < max_digits)
						{
						register = register * Double(decimal_factor == 0 ? numeric_base : 1) + Double(key.rawValue) * Double(pow(Double(numeric_base), Double(decimal_factor)))
						formatted = round_to_significant_figures(register, base: Int(numeric_base))
						register = formatted.rounded
						if (decimal_factor < 0)
							{
							decimal_factor -= 1
							}
						}
					last_was_equals = false
					last_was_operator = false
					input_mode = true;
					return set_last_answer(result_to_display(register), as_Double: register)
					}
			
			case button.dot:
				if (decimal_factor < -1)
					{
					return get_last_answer()
					}
				if (new_integer)
					{
					register = 0
					new_integer = false
					}
				decimal_factor = -1
				last_was_equals = false
				last_was_operator = false
				input_mode = true;
				return set_last_answer(result_to_display(register), as_Double: register)
			
			case button.plus, button.minus, button.multiply, button.divide, button.power,
				button.and, button.xor, button.or:
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
			
				return set_last_answer(result_to_display(numeric_stack.last!), as_Double: numeric_stack.last!)
			
			case button.plus_minus, button.square_root, button.cube_root,
				button.sine, button.cosine, button.tangent,
				button.sine_inverse, button.cosine_inverse, button.tangent_inverse,
				button.sine_hyperbolic, button.cosine_hyperbolic, button.tangent_hyperbolic,
				button.sine_hyperbolic_inverse, button.cosine_hyperbolic_inverse, button.tangent_hyperbolic_inverse,
				button.ln, button.log2, button.log10,
				button.shift_left, button.shift_right, button.not:
				
				register = unary_function(key)
				return set_last_answer(result_to_display(register), as_Double: register)
			
			case button.e, button.pi, button.c:
				register = set_constant(key)
				return set_last_answer(result_to_display(register), as_Double: register)
			
			case button.memory_plus:
				memory = memory + last_answer_as_value
				return get_last_answer()
			
			case button.memory_minus:
				memory = memory + last_answer_as_value
				return get_last_answer()
			
			case button.memory_clear:
				memory = 0
				return get_last_answer()
			
			case button.memory_recall:
				register = memory;
				return set_last_answer(result_to_display(register), as_Double: register)
			
			case button.degrees, button.radians, button.gradians:
				set_trig_mode(key)
				return get_last_answer()
			
			case button.hexadecimal:
				numeric_base = 16
				return set_last_answer(get_last_answer(), as_Double: get_last_answer_as_value())

			case button.decimal:
				numeric_base = 10
				return set_last_answer(get_last_answer(), as_Double: get_last_answer_as_value())

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
				
				let val = numeric_stack.isEmpty ? register : numeric_stack.removeLast()
				return set_last_answer(result_to_display(val), as_Double: val)
			}
		}
}
