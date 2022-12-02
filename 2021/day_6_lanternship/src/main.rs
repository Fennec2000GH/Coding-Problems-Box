use std::path::Path;
use std::fs::File;
use std::io::{BufRead, BufReader, Error};
use std::iter::FromIterator;
use std::collections::HashSet;
use hashbag::HashBag;

fn main() {
    // PARTS 1 and 2
    let path: &Path = Path::new("src/input.txt");
    let file = File::open(&path).expect("Cannot open 'input.txt'.");
    let data: Vec<u8> = BufReader::new(file).lines().map(|line: Result<String, Error>| line.unwrap().split(",").map(|num: &str| num.parse::<u8>().unwrap()).collect::<Vec<u8>>()).flatten().collect::<Vec<u8>>();
    // println!("{:#?}", &data);

    let mut hb: HashBag<u8> = HashBag::from_iter(data.into_iter());
    // println!("{:#?}", hb);

    // change 80 in end point to 256 for PART 2
    for i in 1 .. 256 + 1 {
        // println!("After {} days:", i);
        let set: HashSet<(u8, usize)> = hb.set_iter().map(|t: (&u8, usize)| (*t.0, t.1)).collect::<HashSet<(u8, usize)>>();
        let mut hb_new: HashBag<u8> = HashBag::new();
        // println!("{:#?}", &set);
        set.iter().for_each(|&(val, n): &(u8, usize) | {
            // println!("({}, {})", val, n);
            if val == 0u8 {
                hb_new.insert_many(6u8, n);
                hb_new.insert_many(8u8, n);
            } else {
                hb_new.insert_many(val - 1, n);
            }
            // println!("{:#?}", &hb_new);
        });
        hb = hb_new;
        // println!("len: {}\n{:#?}", hb.len(), &hb);
        // println!("{}", "-".repeat(10)); 
    }

    // solution
    println!("{}", hb.len());

}
