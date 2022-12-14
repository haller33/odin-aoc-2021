package aoc202104

import "core:fmt"
import "core:os"
import "core:strings"


TEST_EXAMPLE :: false

DEBUG_STUFF :: false


texto_to_lines_int :: proc ( file_text : string ) -> map[int]string {
    
    split_string : []string = strings.split_after ( file_text, "\n" )
    
    strings_values : []string = split_string[:len(split_string)-1]

    arr_values : map[int]string
    // defer delete(arr_values)

    for item, index in strings_values {

	arr_values[index] = strings.trim_space ( item )
    }

    return arr_values
}


mapstring_to_string :: proc ( data : map[int]string ) -> string {

    lenMap := len ( data )
    powerNum : int
    
    stringResul := make([]string, lenMap)
    defer delete ( stringResul )
    
    for idx in 0..<lenMap {
	item := data[idx]
	stringResul[idx] = item
    }
    
    return strings.concatenate ( stringResul )
}


first_part :: proc () {

    fmt.println ("hello world!")

    return
}

second_part :: proc () {

    return
}

test_2 :: proc () {

    test_one := make(map[int]string)
    defer delete ( test_one )
    test_one[1] = "something"
    test_one[0] = "something"
    ret_str := mapstring_to_string (test_one)
    // defer delete ( ret_str )
    
    fmt.println ( ret_str )

    return
}

test :: proc () {

    
    data_text_digest, ok := os.read_entire_file("example", context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return 
    }
    defer delete(data_text_digest, context.allocator)
    
    fmt.println ( ok )
    fmt.println ( string(data_text_digest) )
}

main :: proc () {

    test ( ) 
    // first_part ()
    return
}
