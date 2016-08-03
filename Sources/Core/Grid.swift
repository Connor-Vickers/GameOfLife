import Foundation

public class Grid {
	var cells: [Bool]
	var numberOfRows: Int { return self.getNumberOfRows() }
	var numberOfColumns: Int { return self.getNumberOfCols() }
	let input: String

	static let aliveSymbol = "*"
	static let deadSymbol = " "

	public init(file: String){
		input = file
		cells = []
		for character in file.replacingOccurrences(of: "\n", with: "").characters{
			cells.append(charToBool(char: String(character)))
		}
	}

	public func write() -> String{
		var toWrite = ""
		for row in 0..<numberOfRows {
			for column in 0..<numberOfColumns{
				let bool = cells[row*numberOfColumns + column]
				toWrite.append(boolToChar(bool: bool))
			}
			if row != numberOfRows - 1 {
				toWrite.append("\n")
			}
		}
		return toWrite
	}

	public func getNumberOfRows() -> Int{
		return input.components(separatedBy: "\n").count
	}

	public func getNumberOfCols() -> Int{
		return input.components(separatedBy: "\n")[0].characters.count 
	}

	public static func isValid(file: String) -> Bool {
		var lengths = file.components(separatedBy: "\n").map(){$0.characters.count}
		lengths.sort()
		return lengths.first == lengths.last
	}

	func charToBool(char: String) -> Bool{
		switch(char){
			case Grid.aliveSymbol:
				return true
			case Grid.deadSymbol:
				return false
			default:
				assert(false, "invalid cell")
		}
    }

    func boolToChar(bool: Bool) -> String{
		return (bool ? Grid.aliveSymbol : Grid.deadSymbol)
    }

    static func isNextCellAlive(currentCellIsAlive: Bool, numberOfNeighbors: Int) -> Bool{
    	if currentCellIsAlive {
    		if rule1(numberOfNeighbors: numberOfNeighbors) {
    			return false
    		}else if rule2(numberOfNeighbors: numberOfNeighbors) {
    			return true
    		}else{ // numberOfNeighbors is > 3 therefore rule 3 applies
    			return false
    		}
    	}else{
    		return rule4(numberOfNeighbors: numberOfNeighbors)
    	}
    }

    static func rule1(numberOfNeighbors: Int) -> Bool {
    	return numberOfNeighbors < 2
    }
	static func rule2(numberOfNeighbors: Int) -> Bool {
    	return numberOfNeighbors == 2 || numberOfNeighbors == 3
    }
    static func rule4(numberOfNeighbors: Int) -> Bool {
    	return numberOfNeighbors == 3
    }

    func indexesOfNeighbors(forIndex: Int) -> [Int] {
    	var possibleNeighbors: [String: Int] = [:]
    	possibleNeighbors["top"] = forIndex - numberOfColumns
    	possibleNeighbors["bottom"] = forIndex + numberOfColumns
    	possibleNeighbors["left"] = forIndex - 1
    	possibleNeighbors["right"] = forIndex + 1
    	possibleNeighbors["topLeft"] = forIndex - numberOfColumns - 1
    	possibleNeighbors["topRight"] = forIndex - numberOfColumns + 1
    	possibleNeighbors["bottomLeft"] = forIndex + numberOfColumns - 1
    	possibleNeighbors["bottomRight"] = forIndex + numberOfColumns + 1
    	let validNeibors = removeInvalidNeighbors(index: forIndex, neighbors: possibleNeighbors) 
    	return Array(validNeibors.values)
    }

    func removeInvalidNeighbors(index: Int, neighbors: [String: Int]) -> [String:Int]{
    	var neighbors = neighbors
    	if isTopRow(index: index){
    		neighbors.removeValue(forKey: "topLeft")
    		neighbors.removeValue(forKey: "top")
    		neighbors.removeValue(forKey: "topRight")
    	}
    	if isBottomRow(index: index){
    		neighbors.removeValue(forKey: "bottomLeft")
    		neighbors.removeValue(forKey: "bottom")
    		neighbors.removeValue(forKey: "bottomRight")
    	}
    	if isLeftColumn(index: index){
    		neighbors.removeValue(forKey: "topLeft")
    		neighbors.removeValue(forKey: "left")
    		neighbors.removeValue(forKey: "bottomLeft")
    	}
    	if isRightColumn(index: index){
    		neighbors.removeValue(forKey: "topRight")
    		neighbors.removeValue(forKey: "right")
    		neighbors.removeValue(forKey: "bottomRight")
    	}
    	return neighbors
    }

    func isTopRow(index: Int) -> Bool {
    	return index < numberOfColumns
    }
    func isBottomRow(index: Int) -> Bool {
    	return index >= numberOfColumns * (numberOfRows - 1)
    }
    func isLeftColumn(index: Int) -> Bool {
    	return index % numberOfColumns == 0
    }
    func isRightColumn(index: Int) -> Bool {
    	return (index + 1) % numberOfColumns == 0
    }

    func numberOfAliveNeighbors(forIndex: Int) -> Int{
    	var aliveNeighbors = 0
    	for indexesOfNeighbor in indexesOfNeighbors(forIndex: forIndex){
    		if cells[indexesOfNeighbor]{
    			aliveNeighbors += 1
    		}
    	}
    	return aliveNeighbors
    }

    public func tick(){
    	 var newCells = cells
    	 var indexesOfCellsToConsider: [Int] = []
    	 for index in 0..<cells.count{
    	 	if cells[index]{
    	 		indexesOfCellsToConsider.append(index)
    			indexesOfCellsToConsider.append(contentsOf: indexesOfNeighbors(forIndex: index))
    	 	}
    	 }
    	 for index in Set(indexesOfCellsToConsider){
    	 	let numberOfNeighbors = numberOfAliveNeighbors(forIndex: index)
         	newCells[index] = Grid.isNextCellAlive(currentCellIsAlive: cells[index], numberOfNeighbors: numberOfNeighbors)
    	 }
    	 cells = newCells
    }








}
