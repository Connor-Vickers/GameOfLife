import Speck
@testable import Core

let deadSymbol = Grid.deadSymbol
let aliveSymbol = Grid.aliveSymbol

let GridSpec = describe("grid") {
  it("it can recieve and write a file") {
    let grid = Grid(file: "\(aliveSymbol)\(aliveSymbol)\(deadSymbol)\(deadSymbol)\(aliveSymbol)")
  	expect(grid.write()).to(equal: "\(aliveSymbol)\(aliveSymbol)\(deadSymbol)\(deadSymbol)\(aliveSymbol)")
  }
  it("it can recieve and write a file with multiable lines") {
    let grid = Grid(file: "\(aliveSymbol)\(aliveSymbol)\n\(deadSymbol)\(deadSymbol)\n\(aliveSymbol)\(aliveSymbol)")
  	expect(grid.write()).to(equal: "\(aliveSymbol)\(aliveSymbol)\n\(deadSymbol)\(deadSymbol)\n\(aliveSymbol)\(aliveSymbol)")
  }
  it("detects how many rows there are") {
  	let grid = Grid(file: "\(aliveSymbol)\(aliveSymbol)\n\(deadSymbol)\(deadSymbol)\n\(aliveSymbol)\(aliveSymbol)")
  	expect(grid.getNumberOfRows()).to(equal: 3)
  }
  it("detects how many columns there are") {
  	let grid = Grid(file: "\(aliveSymbol)\(deadSymbol)\(aliveSymbol)\(deadSymbol)\n\(deadSymbol)\(deadSymbol)\(aliveSymbol)\(deadSymbol)\n\(aliveSymbol)\(deadSymbol)\(deadSymbol)\(aliveSymbol)")
  	expect(grid.getNumberOfCols()).to(equal: 4)
  }
  it("detects when row lengths are not the same") {
  	expect(Grid.isValid(file: "row1\nrow2\nrow3")).to(equal: true)
  	expect(Grid.isValid(file: "row1\now2\nrow3")).to(equal: false)
  	expect(Grid.isValid(file: "row1\nrow2\nrow3\n")).to(equal: false)
  }
  it("determines if a cell should live or die") {
  	expect(Grid.isNextCellAlive(currentCellIsAlive: false, numberOfNeighbors: 0)).to(equal: false)  	
  	expect(Grid.isNextCellAlive(currentCellIsAlive: true, numberOfNeighbors: 1)).to(equal: false)
	expect(Grid.isNextCellAlive(currentCellIsAlive: true, numberOfNeighbors: 2)).to(equal: true)
	expect(Grid.isNextCellAlive(currentCellIsAlive: true, numberOfNeighbors: 3)).to(equal: true)
	expect(Grid.isNextCellAlive(currentCellIsAlive: true, numberOfNeighbors: 4)).to(equal: false)
	expect(Grid.isNextCellAlive(currentCellIsAlive: false, numberOfNeighbors: 2)).to(equal: false)
	expect(Grid.isNextCellAlive(currentCellIsAlive: false, numberOfNeighbors: 3)).to(equal: true)  	
	expect(Grid.isNextCellAlive(currentCellIsAlive: false, numberOfNeighbors: 4)).to(equal: false)  	
  }
   it("can step one step") {
   	let grid = Grid(file: "   \n***\n   ")
   	grid.tick()
   	grid.tick()
   	grid.tick()
   	expect(grid.write()).to(equal: " * \n * \n * ")
   }
}

