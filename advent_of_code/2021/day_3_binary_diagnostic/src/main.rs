use std::path::Path;
use std::fs::File;
use std::io::Read;
use std::str::FromStr;

fn main() {
    // PART 1
    let path: &Path = Path::new("src/input.txt");
    let mut file: File = File::open(&path).expect("Cannot open 'input.txt.'");
    let mut content: String = String::new();
    file.read_to_string(&mut content).expect("Reading file to string failed.");
    // println!("{}", content);

    // vector of binary strings
    let v: Vec<String> = content.split("\r\n").map(|s| String::from(s)).collect::<Vec<String>>();
    // println!("{:#?}", v);

    // transpose of v
    let t: Vec<String> = (0..v[0].len()).into_iter()
        .map(|index| (&v).into_iter()
            .map(|s| String::from_str(&(s.as_str()[index .. index + 1])).unwrap()).collect::<Vec<String>>().join("")).collect::<Vec<String>>();
    // println!("{:#?}", t);

    let gamma_str: String = (&t).into_iter().map(|s| (count_ones(&s) as usize >= v.len() / 2) as u8).map(|digit| digit.to_string()).collect::<Vec<String>>().join("");
    let gamma: u128 = isize::from_str_radix(&gamma_str, 2).unwrap() as u128;
    // println!("{}", gamma_str);
    // println!("{}", gamma);

    let epsilon_str: String = String::from_str(&format!("{:#128b}", !gamma).as_str()[(2 + 128 - v[0].len())..]).unwrap();
    let epsilon: u128 = isize::from_str_radix(&epsilon_str, 2).unwrap() as u128;
    // println!("{}", epsilon_str);
    // println!("{}", epsilon);

    println!("{}", gamma * epsilon);

    // PART 2
    let (mut o2, mut co2): (String, String) = (String::new(), String::new());
    let (mut o2_filtered, mut co2_filtered): (Vec<String>, Vec<String>) = (v.clone(), v.clone());
    let mut num_ones: u128 = 0;
    let mut digit: u8 = 0;
    let mut index = 0;

    // filter by matching longest prefix possible
    while index < v[0].len() {
        // filtering oxygen binary strings
        if o2_filtered.len() > 1 {
            num_ones = (&o2_filtered).into_iter().filter(|s| s.as_bytes()[index] - 48 == 1).count() as u128;
            digit = (num_ones > o2_filtered.len() as u128 / 2 || num_ones > (o2_filtered.len() as u128 - 1) / 2) as u8; // most ocmmon digit
            o2_filtered = o2_filtered.into_iter().filter(|s| s.as_bytes()[index] - 48 == digit).collect::<Vec<String>>();
            // println!("-----\no2\n-----\nindex: {}, num_ones: {}, digit: {}\n {:#?}", index, num_ones, digit, o2_filtered);
        }

        // filtering oxygen binary strings
        if co2_filtered.len() > 1 {
            num_ones = (&co2_filtered).into_iter().filter(|s| s.as_bytes()[index] - 48 == 1).count() as u128;
            digit = if co2_filtered.len() % 2 == 1 { num_ones <= co2_filtered.len() as u128 / 2} else { num_ones < co2_filtered.len() as u128 / 2 } as u8; // least common digit
            co2_filtered = co2_filtered.into_iter().filter(|s| s.as_bytes()[index] - 48 == digit).collect::<Vec<String>>();
            // println!("-----\nco2\n-----\nindex: {}, num_ones: {}, digit: {}\n {:#?}", index, num_ones, digit, co2_filtered);
        }

        index += 1; 
    }

    println!("{}", isize::from_str_radix(o2_filtered[0].as_str(), 2).unwrap() * isize::from_str_radix(co2_filtered[0].as_str(), 2).unwrap());
}

fn count_ones(s: &str) -> u128 {
    let mut counter: u128 = 0;
    s.as_bytes().to_vec().into_iter().for_each(
        |digit| {
            if digit == "1".as_bytes()[0] {
                counter += 1;
            }
        }
    );
    counter
}
