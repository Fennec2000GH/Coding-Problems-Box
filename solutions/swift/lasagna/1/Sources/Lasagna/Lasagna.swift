// TODO: define the 'expectedMinutesInOven' constant
let expectedMinutesInOven: Int = 40
// TODO: define the 'remainingMinutesInOven' function
func remainingMinutesInOven(elapsedMinutes:Int) -> Int {
  expectedMinutesInOven - elapsedMinutes
}
// TODO: define the 'preparationTimeInMinutes' function
func preparationTimeInMinutes(layers:Int) -> Int {
  2 * layers
}
// TODO: define the 'totalTimeInMinutes' function
func totalTimeInMinutes(layers:Int, elapsedMinutes:Int) -> Int {
  preparationTimeInMinutes(layers: layers) + elapsedMinutes
}