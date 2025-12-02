use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
use std::collections::hash_map::HashMap;

fn dec_to_snafu(dec: i64, pow_of_5: &Vec<i64>) -> String {
    let mut rem: i64 = dec;
    let mut snafu: Vec<char> = vec!['0'; (dec as f64).log(5.0) as usize + 1];

    while rem > 0 {
        let mut p: usize = (rem as f64).log(5.0) as usize;
        let mut multiples: usize = rem as usize / pow_of_5[p] as usize;
        // println!("rem: {}\tp: {}\tmultiples: {}", rem, p, multiples);
        rem -= multiples as i64 * pow_of_5[p];
        loop {
            match multiples {
                1 => { snafu[p] = '1'; break; },
                2 => { snafu[p] = '2'; break; },
                3 => { snafu[p] = '='; },
                4 => { snafu[p] = '-'; },
                _ => unreachable!()
            };
            
            p += 1;
            match snafu[p] {
                '=' => { snafu[p] = '-'; break; },
                '-' => { snafu[p] = '0'; break; },
                '0' => { snafu[p] = '1'; break; },
                '1' => { snafu[p] = '2'; break; },
                '2' => { snafu[p] = '='; multiples = 3; },
                _ => unreachable!()
            }
        }
    }

    snafu.into_iter().collect::<String>().as_str().trim_end_matches('0').chars().rev().collect::<String>()
}

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
    
    let translator: HashMap<char, i64> = HashMap::from([
        ('2', 2),
        ('1', 1),
        ('0', 0),
        ('-', -1),
        ('=', -2)
    ]);

    let mut pow_of_5: Vec<i64> = vec![1];
    for p in 1 .. 20 {
        pow_of_5.push(pow_of_5.iter().last().unwrap() * 5);
    }

    let v: Vec<i64> = input.split('\n')
        .map(|line: &str| line.chars()
            .rev()
            .map(|c: char| translator.get(&c).unwrap())
            .zip(pow_of_5.iter())
            .map(|(digit, power): (&i64, &i64)| digit * power)
            .sum())
        .collect();

    // println!("v:\n{:#?}", v);

    let solution_base_10: i64 = v.iter().sum();
    // println!("solution base 10: {}", solution_base_10);
    println!("{}", dec_to_snafu(solution_base_10, &pow_of_5))
}
