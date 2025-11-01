
import Foundation

func sliceSize(diameter: Double?, slices: Int?) -> Double? {
  switch (diameter, slices) {
      case let (.some(_diameter), .some(_slices)):
        guard _diameter >= 0 && _slices >= 1 else {
          return nil
        }
        let area: Double = Double.pi * pow((_diameter / 2), 2)
        return (1 / Double(_slices)) * area
      default:
        return nil
  }
}

func biggestSlice(
  diameterA: String, slicesA: String,
  diameterB: String, slicesB: String
) -> String {
  let sliceSizeA: Double? = sliceSize(diameter: Double(diameterA), slices: Int(slicesA))
  let sliceSizeB: Double? = sliceSize(diameter: Double(diameterB), slices: Int(slicesB))

  switch (sliceSizeA, sliceSizeB) {
    case let (.some(_sA), .some(_sB)):
      if _sA == _sB {
        return "Neither slice is bigger"
      }
      return "Slice \(_sA > _sB ? "A": "B") is bigger"
    case let (nil, .some(_sB)):
      return "Slice B is bigger"
    case let (.some(_sA), nil):
      return "Slice A is bigger"
    default:
      return "Neither slice is bigger"
  }
}
