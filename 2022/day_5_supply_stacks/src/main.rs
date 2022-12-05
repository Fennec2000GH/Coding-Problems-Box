use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
use std::str::Chars;
use std::iter::StepBy;
use regex::Regex;
use std::mem::swap;

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
    let mut stacks: Vec<Vec<char>> = Vec::new();
    let re: Regex = Regex::new(r"[^0-9]+").unwrap();
    let mut PART1: bool = false;
    {
        let parts: Vec<String> = input.split("\n\n").map(|p: &str| p.to_string()).collect();
        let stacks_size: usize = (parts[0].split("\n").last().unwrap().len() as f64 / 4.0).ceil() as usize;
        stacks.resize(stacks_size, Vec::new());
        // println!("{}\n{}", parts[0], stacks.len());
        // println!("{}", parts[1]);

        for line in parts[0].rsplit("\n").take(stacks_size) {
            let mut it: Chars = line.chars();
            it.next();
            let mut step_it: StepBy<Chars> = it.step_by(4);
            for i in 0 .. stacks_size {
                match step_it.next() {
                    None => panic!("No chars left!"),
                    Some(c) => { if c.is_alphabetic() { stacks[i].push(c); } }
                };
            }
        }
        // println!("{:#?}", stacks);
        
        for line in parts[1].split("\n") {
            let nums: Vec<usize> = re.split(line).skip(1).map(|x: &str| x.parse::<usize>().unwrap()).collect();
            let n: usize = stacks[nums[2] - 1].len(); // original size of stack receiving new crates
            // println!("{:#?}", nums);

            if !PART1 {
                stacks[nums[2] - 1].resize(n + nums[0], '*');
            }
            for i in 0 .. nums[0] {
                match stacks[nums[1] - 1].pop() {
                    None => panic!("No value popped!"),
                    Some(c) => { 
                        if PART1 { stacks[nums[2] - 1].push(c); }
                        else { stacks[nums[2] - 1][n + nums[0] - 1 - i] = c; }
                    }
                }
            }
        }
    }
    // println!("{:#?}", stacks);

    // solution
    println!("{}", stacks.iter().map(|st: &Vec<char>| st.last().unwrap()).collect::<String>());
}