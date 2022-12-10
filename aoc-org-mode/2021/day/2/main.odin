package aoc202102

import "core:fmt"
import "core:os"
import "core:strings"
import md "core:math/big"
import strc "core:strconv"


main :: proc () {

    map_simbols := make(map[string]string)
    map_simbols["forward"] = "forward"
    map_simbols["up"] = "up"
    map_simbols["down"] = "down"
        
    defer delete(map_simbols)

    
    file_path_name := "input"

    // file_path_name = "example"

    counter := 0
    
    data, ok := os.read_entire_file(file_path_name, context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return
    }
    defer delete(data, context.allocator)

    it := string(data)

    atoms : []string
    digite : int
    
    depth : int = 0
    horizontal : int = 0
    
    for line in strings.split_lines_iterator(&it) {

	atoms = strings.split_after(line, " ")
	digite = strc.atoi(atoms[1])

	if strings.contains (atoms[0], map_simbols["forward"]) {
	    horizontal += digite
	} else if strings.contains (atoms[0], map_simbols["up"]) {
	    depth -= digite
	} else if strings.contains (atoms[0], map_simbols["down"]) {
	    depth += digite
	}
	
	if depth < 0 || horizontal < 0 {
	    fmt.println("error overflow")
	}
    }
    
    fmt.println(horizontal * depth)
}
