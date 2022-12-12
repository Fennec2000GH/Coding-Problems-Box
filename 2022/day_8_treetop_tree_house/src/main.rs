use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;
use std::cmp::max;
use std::panic;
use std::collections::hash_map::HashMap;

fn main() {
    let mut path: &Path = Path::new("src/input.txt");
    let mut file: File = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };
    let mut matrix: Vec<Vec<usize>> = Vec::new();
    for line in BufReader::new(file).lines() {
        matrix.push(line.unwrap().chars().map(|h: char| h.to_digit(10).unwrap() as usize).collect());
    }
    // println!("{:#?}", matrix);

    // PART 1
    let m: usize = matrix.len();
    let n: usize = matrix.as_slice().first().unwrap().len();
    let mut visible: Vec<Vec<bool>> = vec![vec![false; n]; m];
    
    visible[0].fill(true);
    visible[n - 1].fill(true);
    let mut max_height_so_far: usize = 0;

    // reserved for part 2
    let mut prefix_max_height_dist: HashMap<String, Vec<Vec<usize>>> = HashMap::new();
    for direction in vec!["left", "right", "up", "down"] {
       prefix_max_height_dist.insert(String::from(direction), vec![vec![0; n]; m]);
    }
    prefix_max_height_dist.get_mut(&String::from("left")).unwrap()[0].fill(0);
    prefix_max_height_dist.get_mut(&String::from("left")).unwrap()[m - 1].fill(0);
    prefix_max_height_dist.get_mut(&String::from("right")).unwrap()[0].fill(0);
    prefix_max_height_dist.get_mut(&String::from("right")).unwrap()[m - 1].fill(0);

    // testing visibility from left and right
    let mut stack: Vec<usize> = Vec::new();
    for i in 1 .. m - 1 {
        let from_left: &mut Vec<Vec<usize>> = prefix_max_height_dist.get_mut(&String::from("left")).unwrap();
        from_left[i][0] = 0;
        from_left[i][n - 1] = 0;

        visible[i][0] = true;
        visible[i][n - 1] = true;
        max_height_so_far = matrix[i][0];
        stack.push(0);
        for j in 1 .. n - 1 {
            if matrix[i][j] > max_height_so_far {
                visible[i][j] = true;
                max_height_so_far = matrix[i][j];
            }
            while !stack.is_empty() && matrix[i][*stack.last().unwrap()] < matrix[i][j] {
                stack.pop();
            }
            if stack.is_empty() {
                from_left[i][j] = j;
                stack.push(0);
            } else {
                from_left[i][j] = (j as i64 - *stack.last().unwrap() as i64) as usize;
            }
            stack.push(j);
        }

        let from_right: &mut Vec<Vec<usize>> = prefix_max_height_dist.get_mut(&String::from("right")).unwrap();
        from_right[i][0] = 0;
        from_right[i][n - 1] = 0;

        max_height_so_far = matrix[i][n - 1];
        stack.clear();
        stack.push(n - 1);
        for j in (1 .. n - 1).rev() {
            if matrix[i][j] > max_height_so_far {
                visible[i][j] = true;
                max_height_so_far = matrix[i][j];
            }
            while !stack.is_empty() && matrix[i][*stack.last().unwrap()] < matrix[i][j] {
                stack.pop();
            }
            if stack.is_empty() {
                from_right[i][j] = (n as i64 - 1i64 - j as i64) as usize;
                stack.push(n - 1);
            } else {
                from_right[i][j] = (*stack.last().unwrap() as i64 - j as i64) as usize;
            }
            stack.push(j);
        }
        stack.clear();
    }

    // testing visibility from up and down
    for j in 1 .. n - 1 {
        let from_up: &mut Vec<Vec<usize>> = prefix_max_height_dist.get_mut(&String::from("up")).unwrap();

        max_height_so_far = matrix[0][j];
        stack.push(0);
        for i in 1 .. m - 1 {
            if matrix[i][j] > max_height_so_far {
                visible[i][j] = true;
                max_height_so_far = matrix[i][j];
            }
            while !stack.is_empty() && matrix[*stack.last().unwrap()][j] < matrix[i][j] {
                stack.pop();
            }
            if stack.is_empty() {
                from_up[i][j] = i;
                stack.push(0);
            } else {
                from_up[i][j] = (i as i64 - *stack.last().unwrap() as i64) as usize;
            }
            stack.push(i);
        }

        let from_down: &mut Vec<Vec<usize>> = prefix_max_height_dist.get_mut(&String::from("down")).unwrap();

        max_height_so_far = matrix[m - 1][j];
        stack.clear();
        stack.push(m - 1);
        for i in (1 .. m - 1).rev() {
            if matrix[i][j] > max_height_so_far {
                visible[i][j] = true;
                max_height_so_far = matrix[i][j];
            }
            while !stack.is_empty() && matrix[*stack.last().unwrap()][j] < matrix[i][j] {
                stack.pop();
            }
            if stack.is_empty() {
                from_down[i][j] = (m as i64 - 1i64 - i as i64) as usize;
                stack.push(m - 1);
            } else {
                from_down[i][j] = (*stack.last().unwrap() as i64 - i as i64) as usize;
            }
            stack.push(i);
            stack.clear();
        }
    }

    // solution
    println!("{}", visible.iter().flatten().filter(|x: &&bool| **x).count());

    // PART 2
    let rows: Vec<usize> = (1 .. m - 1).collect();
    let cols: Vec<usize> = (1 .. n - 1).collect();

    let prod: Vec<(usize, usize)> = rows
        .iter()
        .flat_map(|r: &usize| cols.iter()
            .map(move |c: &usize| (*r, *c)))
        .collect();

    // solution
    println!("{}", prod.iter().map(|(r, c): &(usize, usize)| {
            let left: usize = prefix_max_height_dist.get(&String::from("left")).unwrap()[*r][*c];
            let right: usize = prefix_max_height_dist.get(&String::from("right")).unwrap()[*r][*c];
            let up: usize = prefix_max_height_dist.get(&String::from("up")).unwrap()[*r][*c];
            let down: usize = prefix_max_height_dist.get(&String::from("down")).unwrap()[*r][*c];
            return left * right * up * down;
        }).max().unwrap());

    /*
    let from_left: &Vec<Vec<usize>> = prefix_max_height_dist.get(&String::from("left")).unwrap();
    let from_right: &Vec<Vec<usize>> = prefix_max_height_dist.get(&String::from("right")).unwrap();
    let from_up: &Vec<Vec<usize>> = prefix_max_height_dist.get(&String::from("up")).unwrap();
    let from_down: &Vec<Vec<usize>> = prefix_max_height_dist.get(&String::from("down")).unwrap();
    let mut max_scenic_score: usize = 0;
    for r in &rows {
        for c in &cols {
            // println!("r: {}\tc: {}\theight: {}", r, c, matrix[*r][*c]);
            // println!("{}", max_scenic_score);

            max_scenic_score = max(
                max_scenic_score, 
                {
                    let result = panic::catch_unwind(|| from_left[*r][*c] * from_right[*r][*c] * from_up[*r][*c] * from_down[*r][*c]);
                    if result.is_ok() { 
                        from_left[*r][*c] * from_right[*r][*c] * from_up[*r][*c] * from_down[*r][*c]
                    } else {
                        // println!("{}\n{}\n{}\n{}\n", from_left[*r][*c], from_right[*r][*c], from_up[*r][*c], from_down[*r][*c]);
                        0
                    }
                }
            );
        }
    }
    */
}
