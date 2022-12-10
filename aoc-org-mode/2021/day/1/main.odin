package aoc202101

import "core:fmt"
import "core:os"
import "core:strings"
import md "core:math/big"
import strc "core:strconv"

main :: proc () {

    file_path_name := "input"

    // file_path_name = "example"

    // sizeofs : i64 = os.file_size_from_path("input")
    // fmt.println(sizeofs)
    counter := 0
    
    data, ok := os.read_entire_file(file_path_name, context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return
    }
    defer delete(data, context.allocator)

    it := string(data)

    previous : int = 0
    numint : int = 0
    count : i64 = -1 // because every frist check is true to be bigger
    
    for line in strings.split_lines_iterator(&it) {
	
	numint = strc.atoi(line)

	if numint > previous {
	    previous = numint
	    count += 1
	} else {
	    previous = numint
	}
    }

    fmt.println(count)
    
}
