use std::path::Path;
use std::fs::File;
use std::io::Read;
use std::iter::Iterator;
use std::fmt::{Debug, Formatter};

fn main() {
    let path: &Path = Path::new("src/input.txt");
    let mut file: File = File::open(&path).unwrap();
    let mut content: String = String::new();
    file.read_to_string(&mut content).unwrap();
    println!("{}", content);

    let inputs: Vec<String> = content.split("\r\n\r\n").map(|s| String::from(s)).collect::<Vec<String>>();
    println!("{:#?}", inputs);

    let mut boards: Vec<Bingo> = Vec::new();
    unsafe {
        inputs[1..].into_iter().for_each(|s: &String| {
            let flatboard: Vec<u8> = s.split_whitespace().map(|x: &str| x.parse::<u8>().unwrap()).collect::<Vec<u8>>();
            println!("size: {}\n{:#?}", flatboard.len(), &flatboard);

            let mut board: [[u8; 5]; 5] = std::mem::uninitialized(); 
            for i in 0 .. 5 {
                for j in 0 .. 5 {
                    board[i][j] = flatboard.as_slice()[i * 5 + j];
                }
            }

            boards.push(Bingo::new(board));
            // dbg!("{:#?}", boards.last());
        });
    }

    println!("{:#?}", (&boards));
    println!("{}", boards.len());

    for (n, num) in inputs[0].split(",").map(|x: &str| x.parse::<u8>().unwrap()).enumerate() {
        for bingo in boards.iter_mut() {
            let flatboard: Vec<u128> = bingo.board.into_iter().flatten().map(|&x: &u8| x as u128).collect::<Vec<u128>>();
            for i in 0 .. 5 {
                for j in 0 .. 5 {
                    if bingo.board[i][j] == num as u8 {
                        bingo.mask[i * 5 + j] = true;
                        if bingo.checkRow(i) || bingo.checkCol(j) {
                            let unmarked_sum: u128 = (0 .. 25).into_iter().filter_map(|x: usize| if bingo.mask[x] { None } else { Some(flatboard[x]) }).sum();
                            println!("Bingo n: {}\nSolution: {}", n, unmarked_sum * num as u128);
                            return;
                        }
                    }
                }
            }
        } 
    }

}

pub struct Bingo {
    pub board: [[u8; 5]; 5], // actual board of numbers
    pub mask: [bool; 25], // flattened boolean mask of numbers that were mentioned
}

impl Bingo {
    fn new(board: [[u8; 5]; 5]) -> Self {
        Bingo {
            board: board,
            mask: [false; 25],
        }
    }

    fn checkRow(&self, index: usize) -> bool {
        self.mask[index * 5 .. (index + 1) * 5].into_iter().all(|&x: &bool| x)
    }

    fn checkCol(&self, index: usize) -> bool {
        let mask_indexes: Vec<u8> = (0 .. 5).into_iter().map(|row| (row * 5 + index) as u8).collect::<Vec<u8>>();
        mask_indexes.into_iter().map(|i: u8| self.mask[i as usize]).all(|x: bool| x)
    }
}

impl Debug for Bingo {
    fn fmt(&self, f: &mut Formatter) -> std::fmt::Result {
        write!(f, "{:#?}", self.board)
    }
}