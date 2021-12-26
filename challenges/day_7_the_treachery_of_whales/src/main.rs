use std::fs::File;
use std::io::Read;
use std::path::Path;
use std::iter::FromIterator;
use hashbag::HashBag;

fn main() {
    // PART 1
    let path: &Path = Path::new("src/input.txt");
    let mut file = File::open(&path).expect("Cannot open 'input.txt'.");
    let mut content: String = String::new();
    file.read_to_string(&mut content)
        .expect("Cannot read 'input.txt' to string.");
    let mut data: Vec<i32> = content
        .split(",")
        .map(|s: &str| s.parse::<i32>().unwrap())
        .collect::<Vec<i32>>();
    data.sort();
    // println!("{:#?}", &data);

    let median: i32 = data[data.len() / 2];
    let cost: i32 = data.iter().map(|&x: &i32| (x - median).abs()).sum();

    println!("median: {}", median);
    println!("cost: {}", cost);

    // PART 2
    let triangles: Vec<u128> = (0 .. data.last().unwrap() + 1).map(|x: i32| {
        let x: u128 = x as u128;
        x * (x + 1) / 2
    }).collect::<Vec<u128>>();
    // println!("triangle numbers:\n{:#?}", &triangles);

    let hb: HashBag<i32> = HashBag::from_iter(data.clone().into_iter());

    // for each unique position (index), the costs fo all crabs at that specific position accumulates into a vector
    let pos_costs: Vec<Vec<u128>> = hb.set_iter().map(
        |(&val, n): (&i32, usize)| {
            println!("({}, {})", val, n);
            (0 .. data.last().unwrap() + 1).map(|idx: i32| triangles[(idx - val).abs() as usize]).map(|cost: u128| cost * n as u128).collect::<Vec<u128>>()
        }
    ).collect::<Vec<Vec<u128>>>();
    // println!("pos_costs:\n{:#?}", &pos_costs);

    let total_costs: Vec<u128> = (0 .. data.last().unwrap() + 1).map(|idx: i32| pos_costs.iter().map(|v: &Vec<u128>| v[idx as usize]).sum()).collect::<Vec<u128>>();
    // println!("total_costs:\n{:#?}", &total_costs);

    // solution
    let best_pos: i32 =  (0 .. data.last().unwrap() + 1).min_by_key(|&x: &i32| total_costs[x as usize]).unwrap();
    println!("cost: {}", total_costs[best_pos as usize]);
    println!("best_pos: {}", best_pos);
}
