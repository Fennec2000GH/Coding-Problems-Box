use std::path::Path;
use std::fs::File;
use std::io::{prelude::*, BufReader};
use std::collections::hash_map::HashMap;

fn main() {
    let mut path: &Path = Path::new("src/input.txt");
    let mut file: File = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };

    let mut input: String = String::new();
    match file.read_to_string(&mut input) {
        Err(err) => panic!("{}", err),
        Ok(input) => input
    };
    // println!("{}", input);

    // PART 1
    let indexer: HashMap<char, i64> = [
        ('A', 1),
        ('B', 2),
        ('C', 3),
        ('X', 1),
        ('Y', 2),
        ('Z', 3)
    ].into();
    // println!("{:#?}", indexer);

    let scores: Vec<i64> = input.split("\n").map(|line: &str| { 
        let p1: i64 = indexer[&line.chars().next().unwrap()];
        let p2: i64 = indexer[&line.chars().last().unwrap()];
        p2 + (if p2 - p1 == 1 || p2 % 3 - p1 % 3 == 1 { 6 } else { if p1 == p2 { 3 } else { 0 }})
    }).collect();
    // println!("{:#?}", scores);

    // solution
    println!("{}", scores.iter().sum::<i64>());

    // PART 2
    let scores: Vec<i64> = input.split("\n").map(|line: &str| { 
        let p1: i64 = indexer[&line.chars().next().unwrap()];
        let p2: i64 = indexer[&line.chars().last().unwrap()];
        (match p2 {
            3 => { if p1 == 3 { 1 } else { p1 + 1} },
            2 => p1,
            1 =>  { if p1 == 1 { 3 } else { p1 - 1 } }, 
            _ => unreachable!()
        }) + (p2 - 1) * 3
    }).collect();
    
    // solution
    println!("{}", scores.iter().sum::<i64>());
}
