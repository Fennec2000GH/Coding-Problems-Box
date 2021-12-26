use std::path::Path;
use std::fs::File;
use std::io::{BufRead, BufReader, Error};
use std::collections::HashMap;
use std::cmp::*;
use regex::Regex;

fn main() {
    // PART 1
    let path: &Path = Path::new("src/input.txt");
    let file = File::open(&path).expect("Cannot open 'input.txt'");
    let re: Regex = Regex::new("[^0-9]+").unwrap();
    let mut tmp: Vec<Vec<i32>> = BufReader::new(file).lines().map(
            |line: Result<String, Error>| 
            re.split(line.unwrap().as_str()).map(|s: &str| s.parse::<i32>().unwrap()).collect::<Vec<i32>>()
        ).collect::<Vec<Vec<i32>>>();

    let mut data: Vec<Vec<(i32, i32)>> = Vec::new();
    tmp.iter_mut().for_each(|x: &mut Vec<i32>| {
        let mut coordinates: Vec<(i32, i32)> = Vec::new();
        x.chunks_exact(2).map(|c: &[i32]| c.to_vec()).for_each(|v: Vec<i32>| coordinates.push((v[0], v[1])));
        data.push(coordinates);
    });

    // println!("{:#?}", data);

    let mut counter: HashMap<(i32, i32), i32> = HashMap::new();
    (&data).into_iter().for_each(|line: &Vec<(i32, i32)>| unit_points(&mut counter, &line[0], &line[1], false));
    // println!("{:#?}", counter);

    // solution
    println!("{}", counter.values().filter(|val| *val > &1i32).count());

    // PART 2
    counter.clear();
    (&data).into_iter().for_each(|line: &Vec<(i32, i32)>| unit_points(&mut counter, &line[0], &line[1], true));

    // solution
    println!("{}", counter.values().filter(|val| *val > &1i32).count());

}

// increment visits to points units apart along line
fn unit_points(counter: &mut HashMap<(i32, i32), i32>, p1: &(i32, i32), p2: &(i32, i32), part2: bool) {
    // x's are equal
    if p1.0 == p2.0 {
        (min(p1.1, p2.1) .. max(p1.1, p2.1) + 1).for_each(|x: i32| {
            let key: (i32, i32) = (p1.0, x);
            counter.insert(key, counter.get(&key).unwrap_or(&0i32) + 1);
        });
    } else if p1.1 == p2.1 {
        // y's are equal
        (min(p1.0, p2.0) .. max(p1.0, p2.0) + 1).for_each(|x: i32| {
            let key: (i32, i32) = (x, p1.1);
            counter.insert(key, counter.get(&key).unwrap_or(&0i32) + 1);
        });
    } else {
        if !part2 { return () }
        (p1.0 .. p2.0 + (if p2.0 > p1.0 { 1 } else { -1 })).zip((p1.1 .. p2.1 + (if p2.1 > p1.1 { 1 } else { -1 }))).for_each(|(a, b): (i32, i32)| {
            let key: (i32, i32) = (a, b);
            counter.insert(key, counter.get(&key).unwrap_or(&0i32) + 1);
        });
        // panic!("Lines are neither vertical nor horizontal.");
    }
}

