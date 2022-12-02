use std::path::Path;
use std::fs::File;
use std::collections::BinaryHeap;
use std::io::prelude::*;

fn main() {
	let path: &Path = Path::new("src/input.txt");
	let mut input: String = String::new();
    let mut file: File = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };
    match file.read_to_string(&mut input) {
        Err(err) => panic!("{}", err),
        Ok(_) => ()
    }
    // println!("{}", input);

    // PART 1
    let sums: Vec<i64> = input.split("\n\n").map(|group: &str| group.split("\n").map(|x: &str| x.to_string().parse::<i64>().unwrap()).sum::<i64>()).collect::<Vec<i64>>();
    // println!("{:#?}", sums);

    // solution
    println!("{}", sums.iter().max().unwrap());

    // PART 2
    let mut min_heap_largest_3: BinaryHeap<i64> = BinaryHeap::new();
    for s in sums[..3].iter() {
        min_heap_largest_3.push(*s);
    }
    for s in sums[3..].iter() {
        if s > &min_heap_largest_3.peek().unwrap().abs() {
            min_heap_largest_3.pop();
            min_heap_largest_3.push(-(*s));
        }
    }
    println!("{}", min_heap_largest_3.iter().sum::<i64>().abs());
}
