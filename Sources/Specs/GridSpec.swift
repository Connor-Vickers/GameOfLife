import Speck
import Core

let GridSpec = describe("grid") {
  it("it can recieve and write a file") {
    let grid = Grid(file: "hello")
  	expect(grid.write()).to(equal: "hello")
  }
  it("detects how many rows there are") {
  	let grid = Grid(file: "row1\nrow2\nrow3")
  	expect(grid.getNumberOfRows()).to(equal: 3)
  }
  it("detects how many columns there are") {
  	let grid = Grid(file: "row1\nrow2\nrow3")
  	expect(grid.getNumberOfCols()).to(equal: 4)
  }
  it("detects when row lengths are not the same") {
  	expect(Grid.isValid(file: "row1\nrow2\nrow3")).to(equal: true)
  	expect(Grid.isValid(file: "row1\now2\nrow3")).to(equal: false)
  	expect(Grid.isValid(file: "row1\nrow2\nrow3\n")).to(equal: false)
  }
}
