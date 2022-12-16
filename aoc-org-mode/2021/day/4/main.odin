package aoc202104

import "core:fmt"
import "core:os"
import "core:strings"
import strc "core:strconv"
import "core:slice"
import "core:container/queue"


TEST_EXAMPLE :: true

DEBUG_STUFF :: false

MAX_PUZZLE_SIZE_SIDE :: 5    

GamePuzzleGrid :: struct {
    values: [5][5]int,
    founds: [5][5]bool,
    sum_columns: [dynamic]int,
}

read_entire_file_from_path :: proc (file_path_name : string) -> (string, bool) {

    data_text_digest, ok := os.read_entire_file(file_path_name, context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return "", false
    }
    defer delete(data_text_digest, context.allocator)

    return string(data_text_digest), ok
}

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

parser_puzzles :: proc ( map_arr_string : map[int]string, beginfrom : int = 0 ) -> []GamePuzzleGrid {

    
    relative_count_coluns : int = 0
    lines_relative_count : int = 0
    
    puzzeles_count : int = 0

    tmp_strings : []string
    tmp_filtered : []string

    filtered_strings : [MAX_PUZZLE_SIZE_SIDE][MAX_PUZZLE_SIZE_SIDE]u8
    
    
    puzzles : []GamePuzzleGrid
    swap : int

    is_empty :: proc ( itm : string ) -> bool {
	return ! ( itm == " " )
    }

    to_trim :: proc ( items : []string ) -> []string {

	len_strings := len ( items )
	tmp_strigs := make( []string, len_strings )

	for item,idx in items {
	    tmp_strigs[idx] = strings.trim_space ( item )
	}

	return tmp_strigs
    }

    for idx in beginfrom..<len(map_arr_string) {

	if map_arr_string[idx] == "" {    
	    
	    tmp_strings = strings.split_after ( map_arr_string[idx], " " )

	    tmp_filtered = slice.filter ( tmp_strings, is_empty )

	    // fmt.println ( tmp_filtered [ idx ] )
	    for idx_colums in 0..<len(tmp_filtered) {
		fmt.println ( " ", idx, " ", idx_colums," " )//, tmp_filtered [ idx ][ idx_colums ])
		// filtered_strings[idx][idx_colums] = tmp_filtered [ idx ][ idx_colums ]
	    }
	}
	// filtered_strings[idx] = 
    }
    
/*    
    for i in beginfrom..<len(map_arr_string) {
	
	if ! ( map_arr_string[i] == "" ) {

	    if relative_count == MAX_PUZZLE_SIZE_SIDE {

		
		relative_count = 0
	    }
	    
	    if puzzeles_count == MAX_PUZZLE_SIZE_SIDE {
		puzzeles_count = 0
	    }
	    // fmt.println ( map_arr_string [i] )
	    
	    tmp_filtered_trim := to_trim ( tmp_filtered )
	    // fmt.println ( tmp_filtered_trim )
	    
	    for idx in 0..<MAX_PUZZLE_SIZE_SIDE {

		if idx == MAX_PUZZLE_SIZE_SIDE-1 {
		    
		    lines_relative_count += 1
		}

		if ! ( tmp_filtered_trim[idx] == " " ) {
		    swap = strc.atoi ( tmp_filtered_trim[idx] )
		    // fmt.print ( " ", swap, " " )
		    fmt.print ( puzzeles_count, " ", relative_count, " ", idx, " \n" )
		    // puzzles[puzzeles_count].values[relative_count][idx] = swap
		    // fmt.print ( " ", tmp_strings[idx], " " )
		}
	    }
	}
    }
    */

    return puzzles
}

shift_array :: proc ( map_arr_string : map[int]string, offset : int = 0 ) -> map[int]string {

    map_new_shift := make ( map[int]string, len(map_arr_string) )
    relative_counter := 0
    
    for idx in offset..<len(map_arr_string) {
	fmt.print ( map_arr_string[idx] )
	map_new_shift[relative_counter] = map_arr_string[idx]
	relative_counter += 1
    }
    fmt.print ( "\n" )
    fmt.println ( map_new_shift )
    
    return map_new_shift
}

first_part :: proc () {
    
    file_name_path : string = "input"

    if TEST_EXAMPLE {
	file_name_path = "example"
    }
    
    data_text_digest, ok := os.read_entire_file(file_name_path, context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return 
    }
    defer delete(data_text_digest, context.allocator)
    
    str_data := string(data_text_digest)

    lines_data_text := texto_to_lines_int ( str_data )
    
    combinations := lines_data_text[0]

    something : GamePuzzleGrid

    lines_correct_text := shift_array ( lines_data_text, 1 )
    // defer delete ( lines_correct_text )

    parser_puzzles ( map_arr_string = lines_correct_text )

    return
}

test :: proc () {

}

main :: proc () {

    // test ( ) 
    first_part ()
    return
}
