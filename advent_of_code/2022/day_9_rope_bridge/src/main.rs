use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;
use std::cmp::min;
use std::cmp::max;
use std::collections::hash_set::HashSet;

fn manhattan(p1: &(i64, i64), p2: &(i64, i64)) -> usize {
    ((p1.0 - p2.0).abs() + (p1.1 - p2.1).abs()) as usize
}

fn is_diagonally_adj(p1: &(i64, i64), p2: &(i64, i64)) -> bool {
    (p1.0 - p2.0).abs() == 1 && (p1.1 - p2.1).abs() == 1
}

// moving a knot only 1 distance unit and returns the appropriate move for 
// the next adjaacent know also oonly 1 unit (None means no move)
fn move_knot(rope: &mut Vec<(i64, i64)>, curr_idx: usize, next_idx: usize, direction: Option<Vec<char>>) -> Option<Vec<char>> {
    if direction == None {
        return None;
    }

    for dir in direction.unwrap().iter() {
        match dir {
            'L' => { rope[curr_idx].1 -= 1; },
            'R' => { rope[curr_idx].1 += 1; },
            'U' => { rope[curr_idx].0 += 1; },
            'D' => { rope[curr_idx].0 -= 1; },
            _ => unreachable!()
        };
    }

    let mdist: usize = manhattan(&rope[curr_idx], &rope[next_idx]);
    if mdist <= 1 || is_diagonally_adj(&rope[curr_idx], &rope[next_idx]) { 
        return None;
    }

    if rope[curr_idx].0 != rope[next_idx].0 && rope[curr_idx].1 != rope[next_idx].1 {
        return Option::Some(vec![
            if rope[curr_idx].0 > rope[next_idx].0 { 'U' } else { 'D' },
            if rope[curr_idx].1 > rope[next_idx].1 { 'R' } else { 'L' }
        ]);
    }
    
    if rope[curr_idx].0 == rope[next_idx].0 { 
        Option::Some(vec![if rope[curr_idx].1 > rope[next_idx].1 { 'R' } else { 'L' }])
    } else {
        Option::Some(vec![if rope[curr_idx].0 > rope[next_idx].0 { 'U' } else { 'D' }])
    }
}

fn main() {
    let mut path: &Path = Path::new("src/input.txt");
    let mut file: File = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };

    // PART 1
    // index 0 is row (y-value)
    // index 1 is col (x-value)
    let mut H: (i64, i64) = (0, 0);
    let mut T: (i64, i64) = (0, 0);

    // tracks all locations visited by tail
    let mut tail_visited: HashSet<(i64, i64)> = HashSet::new(); 

    for line in BufReader::new(file).lines() {
        let line: String = line.unwrap();
        let direction: char = line.chars().next().unwrap();
        let dist: i64 = line.split(" ").last().unwrap().parse::<i64>().unwrap();
        // println!("--------------------");
        // println!("direction: {}\tdist: {}", direction, dist);

        // change head location
        match direction {
            'L' => { H.1 -= dist; },
            'R' => { H.1 += dist; },
            'U' => { H.0 += dist; },
            'D' => { H.0 -= dist; },
            _ => unreachable!()
        };
        // println!("H: {:#?}\tT: {:#?}", H, T);

        // manhattan distance of 0 or 1 means tail has not moved afterwards
        let mdist: usize = manhattan(&H, &T);
        if mdist <= 1 || is_diagonally_adj(&H, &T) { 
            continue;
        }
        // println!("mdist: {}", mdist);

        // diagonal but not touching after head moves
        if H.0 != T.0 && H.1 != T.1 {
            tail_visited.insert((T.0, T.1));
            T.0 += if H.0 > T.0 { 1 } else { -1 };
            T.1 += if H.1 > T.1 { 1 } else { -1 };
            // println!("T (post-diagonal fix): {:#?}", T);
        }
        let mut offset: i64 = 0;

        // same row after head moves
        if H.0 == T.0 {
            offset = (T.1 > H.1) as i64;
            for j in min(H.1, T.1) + offset .. max(H.1, T.1) + offset {
                tail_visited.insert((H.0, j));
                // println!("insert {:#?}", (H.0, j));
            }
            T.1 = H.1 - (if H.1 > T.1 { 1 } else { -1 });
        } else if H.1 == T.1 {
            // same col after head moves
            offset = (T.0 > H.0) as i64;
            for i in min(H.0, T.0) + offset .. max(H.0, T.0) + offset {
                tail_visited.insert((i, H.1));
                // println!("insert {:#?}", (i, H.1));
            }
            T.0 = H.0 - (if H.0 > T.0 { 1 } else { -1 });
        }

        // println!("{:#?}", tail_visited);
    }

    // solution
    println!("{}", tail_visited.len());

    // PART 2
    file = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };
    tail_visited.clear();
    tail_visited.insert((0, 0));
    let mut rope: Vec<(i64, i64)> = vec![(0, 0); 11]; // last element is 1 past tail (padding)
     for line in BufReader::new(file).lines() {
        let line: String = line.unwrap();
        let direction: char = line.chars().next().unwrap();
        let mut move_knot_direction: Option<Vec<char>> = None;
        let dist: i64 = line.split(" ").last().unwrap().parse::<i64>().unwrap();
        // println!("direction: {:#?}", direction);

        for _ in 0 .. dist {
            move_knot_direction = Option::Some(vec![direction]);
            for k in 0 .. 10 {
                move_knot_direction = move_knot(&mut rope, k, k + 1, move_knot_direction)
            }
            tail_visited.insert((rope[9].0, rope[9].1));
        }
        // println!("rope: {:#?}", &rope[0 .. 10]);
    }

    // println!("knot 9: {:#?}", &rope[9]);

    // solution
    println!("{}", tail_visited.len());
}