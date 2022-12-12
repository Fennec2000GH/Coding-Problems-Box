use std::path::Path;
use std::fs::File;
use std::io::prelude::*;
use std::cmp::min;
use std::collections::hash_map::HashMap;

/*
#[derive(Debug)]
struct Node {
    name: String,
    size: usize,
    parent: Option<&'static mut Node>,
    children: HashMap<String, Option<Node>>
}

impl Node {
    fn new(name: String) -> Self {
        Self::from(name, 0)
    }

    fn from(name: String, size: usize) -> Self {
        Self {
            name: name,
            size: size,
            parent: None,
            children: HashMap::new()
        }
    }

    fn resize(&mut self, size: usize) -> usize {
        let old_size: usize = self.size;
        self.size = size;
        old_size
    }

    fn insert(&mut self, name: String) -> &Option<Node> {
        if self.children.contains_key(&name.clone()) {
            return &None;
        }
        self.children.insert(name.clone(), Option::Some(Node::new(name.clone())));
        self.children.get(&name).unwrap()
    }
}

#[derive(Debug)]
struct FS {
    root: Node,
    cwd: &'static mut Node
}

impl FS {
    fn new() -> Self {
        let mut root_boxed: Box<Node: 'static> = Box::new(Node::new(String::from("/")));
        let fs: FS = Self {
            cwd: &mut *root_boxed,
            root: *root_boxed
        };
        fs
    }

    fn resize(&mut self, size: usize) -> i64 {
        let size_delta: i64 = size as i64 - self.cwd.resize(size) as i64;
        let ptr: &mut Node = self.cwd;
        while let Some(p) = ptr.parent {
            p.resize((p.size as i64 + size_delta) as usize);
            ptr = p;
        }
        size_delta
    }
}
*/

const LIMIT: usize = 1e5 as usize;
const DISK_SPACE: usize = 7e7 as usize;
const REQUIRED_SPACE: usize = 3e7 as usize;
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

    // PART 1
    let mut dir_size: HashMap<String, usize> = HashMap::new();
    dir_size.insert(String::from("/"), 0usize);
    let mut file_size: HashMap<String, usize> = HashMap::new();
    let mut cwd: Vec<String> = vec![String::from("/")];
    let mut cwd_string: String = cwd.join("/");
    for line in input.split("\n").skip(1) {
        let terminal: Vec<String> = line.split(" ").map(|part: &str| part.to_string()).collect();
        match terminal.len() {
            2 => {
                cwd.push(String::from(terminal.last().unwrap()));
                let first_part: String = String::from(terminal.first().unwrap());
                if first_part.chars().next().unwrap().is_digit(10) {
                    let size_delta: usize = first_part.as_str().parse::<usize>().unwrap();
                    cwd_string = cwd.iter().skip(1).map(|s: &String| String::from(s)).collect::<Vec<String>>().join("/");
                    file_size.insert(String::from(format!("/{}", cwd_string.as_str())), size_delta);
                    for i in 2 .. cwd.len() {
                        dir_size.entry(String::from(format!("/{}", cwd_string.as_str().rsplitn(i, "/").last().unwrap().to_string()))).and_modify(|size: &mut usize| *size += size_delta);
                    }
                    dir_size.entry(String::from("/")).and_modify(|size: &mut usize| *size += size_delta);
                }
                cwd.pop();
            },
            3 => {
                if let Some(dir) = terminal.last() {
                    match dir.as_str() {
                        ".." => { cwd.pop(); },
                        _ => {
                            cwd.push(String::from(dir));
                            cwd_string = format!("/{}", cwd.iter().skip(1).map(|s: &String| String::from(s)).collect::<Vec<String>>().join("/"));
                            dir_size.entry(String::from(cwd_string)).or_default();
                        }
                    }
                }
            },
            _ => unreachable!()
        }
    }

    // println!("{:#?}", dir_size);
    // println!("{:#?}", file_size);

    // solution
    println!("{}", dir_size.values().filter(|size: &&usize| **size <= LIMIT).into_iter().sum::<usize>());

    // PART 2
    let additional_space: usize = (REQUIRED_SPACE as i64 - (DISK_SPACE as i64 - *dir_size.get(&String::from("/")).unwrap() as i64)) as usize;
    // println!("{}", additional_space);

    // solution
    println!("{}", dir_size.values().fold(usize::MAX, |acc: usize, size: &usize| if *size >= additional_space { min(acc, *size) } else { acc }));
}
