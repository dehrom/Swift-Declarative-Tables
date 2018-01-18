//
//  ResizableCellViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by Pei Sun on 2018-01-17.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation

class ResizableCellViewController: UIViewController {
	
	var tableView = UITableView(frame: CGRect.zero, style: .grouped)
	let functionalData = FunctionalTableData()
	var tableLayoutMargins = UIEdgeInsets.zero
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "CarouselCell Resizable Cell Demo"
		view.addSubview(tableView)
		tableView.pinToSuperView()
		functionalData.tableView = tableView
		render()
	}
	
	func render() {
		var rows = [CellConfigType]()

		let fourGridCell = resizableCell(key: "fourGridCell", color: .yellow, height: 100, itemsPerRow: [1, 3])
		rows.append(fourGridCell)

		let fiveGridCell = resizableCell(key: "fiveGridCell", color: .blue, height: 100, itemsPerRow: [2, 3])
		rows.append(fiveGridCell)
		
		let sixGridCell = resizableCell(key: "sixGridCell", color: .orange, height: 100, itemsPerRow: [3, 3])
		rows.append(sixGridCell)

		let nineGridCell = resizableCell(key: "nineGridCell", color: .green, height: 100, itemsPerRow: [3, 3, 3])
		rows.append(nineGridCell)
		
		let sections = [TableSection(key: "section", rows: rows)]
		functionalData.renderAndDiff(sections)
	}
	
	private func resizableCell(key: String, color: UIColor, height: CGFloat, itemsPerRow: [Int]) -> CellConfigType {

		let numberOfRows = itemsPerRow.count
		let collectionHeight = numberOfRows * Int(height) + (numberOfRows - 1) * 10 + 16
		
		var states = [CarouselItemResizableState]()
		for itemsInThisRow in itemsPerRow {
			for _ in 0..<itemsInThisRow {
				let state = CarouselItemResizableState(color: color, height: height, itemsInThisRow: CGFloat(itemsInThisRow))
				states.append(state)
			}
		}
		
		return CarouselResizableCell(
			key: key,
			state: CarouselState<CarouselItemResizableCell>(
				itemModels: states,
				collectionHeight: CGFloat(collectionHeight),
				didSelectCell: { indexPath in
					print("Did tap item \(indexPath.row)")}))
	}
}