use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() {
    let mut path: &Path = Path::new("src/input.txt");
    let mut file: File = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };

    // PART 1
    let mut clock: i64 = 0;
    let mut register: i64 = 1;
    let mut signal_strength_vec: Vec<i64> = Vec::new();
    for (i, line) in BufReader::new(file).lines().enumerate() {
        // println!("--------------------");
        // println!("i: {}", i);
        let line: String = line.unwrap();
        let op: String = line.split(" ").next().unwrap().to_string();
        // println!("op: {}", op);
        if op == "noop" {
            clock += 1;
            if clock >= 20 && (clock - 20) % 40 == 0 {
                signal_strength_vec.push((clock - clock % 2) * register);
            }
            // println!("clock: {}", clock);
            // println!("register: {}", register);
            // println!("signal strength: {}", if signal_strength_vec.is_empty() { 0i64 } else { *signal_strength_vec.last().unwrap() });
            continue;
        }
        let delta: i64 = line.split(" ").last().unwrap().parse::<i64>().unwrap();
        clock += 2;
        if clock >= 20 && (clock - 20) % 40 == 0 || (clock - 21) % 40 == 0 {
            signal_strength_vec.push((clock - clock % 2) * register);
        }
       
        register += delta;
        // println!("clock: {}", clock);
        // println!("register: {}", register);
        // println!("signal strength: {}", if signal_strength_vec.is_empty() { 0i64 } else { *signal_strength_vec.last().unwrap() });
    }

    // solution
    println!("{}", signal_strength_vec.iter().sum::<i64>());

    // PART 2
    file = match File::open(path) {
        Err(err) => panic!("{}", err),
        Ok(file) => file
    };
    clock = 0;
    register = 1;
    let mut canvas: Vec<Vec<char>> = Vec::new();
    for (i, line) in BufReader::new(file).lines().enumerate() {
        // println!("--------------------");
        // println!("i: {}", i);
        let line: String = line.unwrap();
        let op: String = line.split(" ").next().unwrap().to_string();
        // println!("op: {}", op);
        if op == "noop" {
            clock += 1;
            if clock % 40 == 1 {
                canvas.push(vec!['?'; 40]);
            }
            canvas[(clock as usize - 1) / 40][(clock as usize - 1) % 40] = if vec![register - 1, register, register + 1].contains(&((clock - 1) % 40)) { '#' } else { '.' };
            // println!("{}", canvas[(clock as usize - 1) / 40][(clock as usize - 1) % 40]);
        } else {
            let delta: i64 = line.split(" ").last().unwrap().parse::<i64>().unwrap();
            // println!("delta: {}", delta);
            clock += 2;
            if clock % 40 == 1 || clock % 40 == 2 {
                canvas.push(vec!['?'; 40]);
            }
            canvas[(clock as usize - 2) / 40][(clock as usize - 2) % 40] = if vec![register - 1, register, register + 1].contains(&((clock - 2) % 40)) { '#' } else { '.' };
            canvas[(clock as usize - 1) / 40][(clock as usize - 1) % 40] = if vec![register - 1, register, register + 1].contains(&((clock - 1) % 40)) { '#' } else { '.' };
            register += delta;
            // println!("{}{}", canvas[(clock as usize - 2) / 40][(clock as usize - 2) % 40], canvas[(clock as usize - 1) / 40][(clock as usize - 1) % 40]);
        }
        // println!("clock: {}", clock);
        // println!("register: {}", register);
    }

    println!("{}", canvas.iter().map(|row: &Vec<char>| row.iter().collect::<String>()).collect::<Vec<String>>().join("\n").to_string());
}
