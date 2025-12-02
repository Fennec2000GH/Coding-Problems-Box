use std::path::Path;
use std::fs::File;
use std::io::Read;
use std::collections::hash_set::HashSet;

fn main() {
    let mut path: &Path = Path::new("src/input.txt");
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
    let odd_ones_out: Vec<char> = input.split("\n").map(|line: &str| {
        let n: usize = line.len();
        let first_half_types: HashSet<char> = line[.. (n / 2)].chars().collect();
        for c in line[(n / 2) ..].chars() {
            if first_half_types.contains(&c) {
                return c;
            }
        }
        '\n'
    }).collect();
    // println!("{:#?}", odd_ones_out);

    // solution
    println!("{}", odd_ones_out.iter().map(|c: &char| c.to_lowercase().next().unwrap() as i64 - 'a' as i64 + (if c.is_uppercase() { 27i64 } else { 1i64 })).sum::<i64>());

    // PART 2
    let lines: Vec<String> = input.split("\n").map(|line: &str| line.to_string()).collect();
    let n: usize = lines.len();
    let odd_ones_out: Vec<char> = (0 .. n / 3).map(|x: usize| {
        let set1: HashSet<char> = lines[x * 3].chars().collect();
        let set2: HashSet<char> = lines[x * 3 + 1].chars().collect();
        let set3: HashSet<char> = lines[x * 3 + 2].chars().collect();
        *set1.intersection(&set2).map(|c: &char| *c).collect::<HashSet<char>>().intersection(&set3).next().unwrap()
    }).collect();
    println!("{:#?}", odd_ones_out);

    // solution
    println!("{:#?}", odd_ones_out.iter().map(|c: &char| c.to_lowercase().next().unwrap() as i64 - 'a' as i64 + (if c.is_uppercase() { 27i64 } else { 1i64 })).sum::<i64>());
}
