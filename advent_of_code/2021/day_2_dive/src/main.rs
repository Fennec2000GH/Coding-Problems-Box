use std::path::Path;
use std::fs::File;
use std::io::{BufRead, BufReader, Read};

fn main() {
    // PART 1
    let path: &Path = Path::new("src/input.txt");
    let mut file: File = File::open(&path).expect("Cannot open 'input.txt'.");
    let lines: Vec<String> = BufReader::new(file).lines().map(|x| x.unwrap()).collect::<Vec<String>>();
    println!("{:#?}", lines);

    let (mut horizontal, mut depth): (u64, u64) = (0, 0);
    lines.into_iter().for_each(|x| { 
        let split_vec: Vec<&str> = x.split(" ").collect::<Vec<&str>>();
        let (dir, num): (String, u64) = (String::from(split_vec[0]), split_vec[1].parse::<u64>().unwrap());
        match dir.as_str() {
            "forward" => horizontal += num,
            "up" =>  depth -= num,
            "down" => depth += num,
            _ => panic!("Invalid direction name!")
        }
    });

    println!("horizontal: {}", horizontal);
    println!("depth: {}", depth);
    println!("{}", horizontal * depth);

    // PART 2
    // Snippet identical to Part 1
    let path: &Path = Path::new("src/input.txt");
    let mut file: File = File::open(&path).expect("Cannot open 'input.txt'.");
    let lines: Vec<String> = BufReader::new(file).lines().map(|x| x.unwrap()).collect::<Vec<String>>();
    println!("{:#?}", lines);
    //

    let (mut horizontal, mut depth, mut aim): (u64, u64, u64) = (0, 0, 0);

    lines.into_iter().for_each(|x| { 
        let split_vec: Vec<&str> = x.split(" ").collect::<Vec<&str>>();
        let (dir, num): (String, u64) = (String::from(split_vec[0]), split_vec[1].parse::<u64>().unwrap());
        match dir.as_str() {
            "forward" => {
                horizontal += num;
                depth += aim * num;
            },
            "up" => aim -= num,
            "down" => aim += num,
            _ => panic!("Invalid direction name!")
        }
    });

    println!("horizontal: {}", horizontal);
    println!("depth: {}", depth);
    println!("{}", horizontal * depth);
    
}
