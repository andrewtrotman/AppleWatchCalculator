//
//  TipInterfaceController.swift
//  Calculator
//
//  Created by Andrew Trotman on 7/05/16.
//  Copyright © 2016 Pinnated. All rights reserved.
//

import WatchKit
import Foundation

/*
	CLASS TIPINTERFACECONTROLLER
	----------------------------
*/
class TipInterfaceController: WKInterfaceController
{
	@IBOutlet var tip15: WKInterfaceLabel!
	@IBOutlet var total15: WKInterfaceLabel!
	@IBOutlet var tip20: WKInterfaceLabel!
	@IBOutlet var tip17: WKInterfaceLabel!
	@IBOutlet var total17: WKInterfaceLabel!
	@IBOutlet var total20: WKInterfaceLabel!
	@IBOutlet var percent: WKInterfaceLabel!
	@IBOutlet var tip: WKInterfaceLabel!
	@IBOutlet var total_picker: WKInterfacePicker!
	
	var price_list : [(String, Int64)] = []

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
		super.willActivate()
		
		let score : Int64 = Int64(ceil(calculator.get_last_answer_as_value() * 100))
		setTitle("$" + String(format:"%.2f", Double(score) / 100))

		var tip : Int64 = Int64(ceil(Double(score) * 0.15))
		var total : Int64 = score + tip
		
		tip15.setText(String(format:"%.2f", Double(tip) / 100))
		total15.setText(String(format:"%.2f", Double(total) / 100))

		tip = Int64(ceil(Double(score) * 0.17))
		total = score + tip
		tip17.setText(String(format:"%.2f", Double(tip) / 100))
		total17.setText(String(format:"%.2f", Double(total) / 100))

		tip = Int64(ceil(Double(score) * 0.20))
		total = score + tip
		tip20.setText(String(format:"%.2f", Double(tip) / 100))
		total20.setText(String(format:"%.2f", Double(total) / 100))
		
		price_list = []
		let starting_price = ((score + 499) / 500) * 500
		
		for choices in starting_price.stride(to: starting_price * 3, by: 500)
			{
			price_list = price_list + [("$" + String(format:"%.2f", Double(choices) / 100), choices)]
			}

		let pickerItems: [WKPickerItem] = price_list.map
			{
			let pickerItem = WKPickerItem()
			pickerItem.title = $0.0
			pickerItem.caption = "Total"

			return pickerItem
			}

		total_picker.setItems(pickerItems)
		picker(0)
		}
	
	/*
		DIDACTIVATE()
		-------------
	*/
	override func didDeactivate()
		{
		super.didDeactivate()
		}

	/*
		PICKER()
		--------
	*/
	@IBAction func picker(value: Int)
		{
		let cost : Int64 = Int64(ceil(calculator.get_last_answer_as_value() * 100))
		percent.setText("Tip:" + String(format:"%.0f", ((Double(price_list[value].1) / (Double(cost))) - 1) * 100) + "%")
		tip.setText("$" + String(format:"%.2f", Double((price_list[value].1 - cost)) / 100))
		}
}
