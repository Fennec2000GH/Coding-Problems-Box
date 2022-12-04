use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
use regex::Regex;

fn main() {
    let mut path: &Path = Path::new("src/input.txt");
    let mut file: File = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };
    let mut input: String = String::new();
    match file.read_to_string(&mut input) {
        Err(err) => panic!("{}", err),
        Ok(_) => ()
    };
    // println!("{}", input);

    let re: Regex = Regex::new(r"[-,]{1}").unwrap();
    let lines: Vec<Vec<i64>> = input.split("\n").map(|line: &str| re.split(line).map(|part: &str| part.parse::<i64>().unwrap()).collect()).collect();
    // println!("{:#?}", lines);

    // PART 1
    // solution
    println!("{}", lines.iter().fold(0i64, |acc: i64, bounds: &Vec<i64>| acc + 
        (bounds[2] >= bounds[0] && bounds[3] <= bounds[1] || 
        bounds[0] >= bounds[2] && bounds[1] <= bounds[3]) as i64));

    // PART 2
    // solution
    println!("{}", lines.iter().fold(0i64, |acc: i64, bounds: &Vec<i64>| acc + !(bounds[1] < bounds[2] || bounds[3] < bounds[0]) as i64));
}
