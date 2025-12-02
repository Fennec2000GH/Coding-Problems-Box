with open(file='./input.txt') as f:
    counter = 0
    lines = list(map(lambda x: int(x), f.readlines()))
    prev = lines[0]
    print(f.readlines())
    for index, line in enumerate(lines[1:]):
        print(f'({index + 1}, {line})')
        if line - prev > 0:
            counter += 1
            print(f'counter: {counter}')
        prev = line
    print(counter)