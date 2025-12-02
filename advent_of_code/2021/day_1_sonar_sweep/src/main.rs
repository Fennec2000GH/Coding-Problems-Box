use std::fs::File;
use std::io::{BufRead, BufReader};
use std::iter::Enumerate;

fn main() {
    let file = File::open("src/input.txt").expect("Cannot open input.txt!");
    let reader = BufReader::new(file);
    let lines: Vec<i64> = reader.lines().map(|line| line.unwrap().parse::<i64>().unwrap()).collect();
    // println!("{:#?}", lines);

    let mut counter: u64 = 0;
    for (index, line) in lines.iter().as_slice()[2..].iter().enumerate() {
        // println!("({}, {}) ", index + 1, line);
        if line - lines.get(index).unwrap() > 0 {
            counter = counter + 1;
            println!("counter: {}", counter);
        }
    }

    println!("{}", counter);
}

