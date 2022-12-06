use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
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
        Ok(_) => ()
    };
    // println!("{}", input);

    let v: Vec<char> = input.chars().collect();
    let mut counter: HashMap<char, usize> = HashMap::new();
    let mut solution: usize = 0;
    
    for i in 0 .. 4 {
        counter.entry(v[i]).and_modify(|cnt: &mut usize| *cnt += 1).or_insert(1);
    }

    // println!("{:#?}", v);
    // println!("{:#?}", counter);

    // PART 1
    for i in 4 .. input.len() {
        match counter.get(&v[i - 4]) {
            None => panic!("Cannot fetch counter value at index {}", i - 4),
            Some(&cnt) => { if cnt == 1 { counter.remove(&v[i - 4]); } else { counter.entry(v[i - 4]).and_modify(|cnt: &mut usize| *cnt -= 1); } }
        }
        counter.entry(v[i]).and_modify(|cnt: &mut usize| *cnt += 1).or_insert(1);
        // println!("{:#?}", counter);
        if counter.len() == 4 {
            solution = i + 1;
            break;
        }
    }

    // solution
    println!("{}", solution);

    // PART 2
    counter.clear();
    for i in 0 .. 14 {
        counter.entry(v[i]).and_modify(|cnt: &mut usize| *cnt += 1).or_insert(1);
    }
    for i in 14 .. input.len() {
        match counter.get(&v[i - 14]) {
            None => panic!("Cannot fetch counter value at index {}", i - 14),
            Some(&cnt) => { if cnt == 1 { counter.remove(&v[i - 14]); } else { counter.entry(v[i - 14]).and_modify(|cnt: &mut usize| *cnt -= 1); } }
        }
        counter.entry(v[i]).and_modify(|cnt: &mut usize| *cnt += 1).or_insert(1);
        // println!("{:#?}", counter);
        if counter.len() == 14 {
            solution = i + 1;
            break;
        }
    }

    // solution
    println!("{}", solution);
}
