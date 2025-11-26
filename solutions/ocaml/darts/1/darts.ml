let score (x: float) (y: float): int =
  let square z = z *. z in
  let dist = sqrt (square x +. square y) in
  match dist with
    | d when d <= 1. -> 10
    | d when d <= 5. -> 5
    | d when d <= 10. -> 1
    | _ -> 0
;;
