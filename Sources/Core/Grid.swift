import Foundation

public class Grid {
	var cells: [String]
	var numberOfRows: Int { return self.getNumberOfRows() }
	var numberOfColumns: Int { return self.getNumberOfCols() }
	let input: String

	public init(file: String){
		input = file
		cells = []
		for character in file.replacingOccurrences(of: "\n", with: "").characters{
			cells.append(String(character))
		}
		print(cells)

	}
	public func write() -> String{
		return cells.reduce(""){ acc, element in			
			return acc.appending(element)
		}
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
}
