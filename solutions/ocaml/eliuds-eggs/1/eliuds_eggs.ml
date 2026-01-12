let rec egg_count (number: int): int =
  if number = 0 then 0
  else (number land 1) + egg_count (number lsr 1)

  (* old code *)
  (* let num = ref number in
  let cnt = ref 0 in
  while !num > 0 do
    match !num with 
      | n when n land 1 = 1 -> incr cnt
      | _ -> ()
    ;
    num := !num lsr 1;
    let num_s = string_of_int !num in 
    print_endline num_s
  done;
  !cnt *)
;;
