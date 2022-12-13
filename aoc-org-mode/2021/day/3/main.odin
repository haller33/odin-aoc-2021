package aoc202103

import "core:fmt"
import "core:os"
import "core:strings"
import strc "core:strconv"
import mi "core:math/big"
import "core:intrinsics"

WORD :: u16

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

reason_about_gama_rate_one_bit_be_one :: proc ( arrBits : map[int]string, idx : int ) -> bool {

    count_ones : int = 0
    count_zeros : int = 0
    
    for _, itm in arrBits {

	if itm[idx] == 49 { // 49 == 1
	    count_ones += 1
	} else {
	    count_zeros += 1
	}
	
	if DEBUG_STUFF {
	    fmt.printf ("%v == 49 :: %v\n", itm[0], itm[0] == '1' )
	}
    }
    
    if DEBUG_STUFF {
	fmt.printf ("ones %v and zeros %v\n", count_ones, count_zeros )
    }

    if count_ones == 1 && count_zeros == 1 {
	return true
    }
    
    if count_ones > count_zeros {
	return true
    } else {
	return false
    }
}

reason_about_epsilon_rate_get_binary :: proc ( arrData : map[int]string ) -> map[int]string {
    return reason_about_gama_rate_get_binary_digit ( arrData, true )
}

filter_report_diagnostic_rating_oxygen_co2 :: proc ( arrData : map[int]string, size_td : int, flag_invert : bool = false ) -> map[int]string {

    flag_is_one : bool
    digits_filtered : map[int]string
    lenarr : int = len(arrData)
    relative_related_count : int = 0
        
    flag_is_one = reason_about_gama_rate_one_bit_be_one ( arrData, size_td )

    if flag_invert {
	flag_is_one = !flag_is_one
    }

    relative_related_count = 0
    
    for item_idx, item in arrData {

	if DEBUG_STUFF {
	    fmt.println ( item_idx, " - ", size_td, " # ",arrData )
	}

	if len ( arrData ) == 2 {
	    relative_related_count = 0
	}

	if flag_is_one && item[size_td] == 49 { // arrData[0] == "1"
	    
	    digits_filtered[relative_related_count] = item
	} else if !flag_is_one && item[size_td] == 48 { // arrData[0] == "0"

	    digits_filtered[relative_related_count] = item
	}
	
	relative_related_count += 1
    }

    return digits_filtered
}

reason_about_gama_rate_get_binary_digit :: proc ( arrData : map[int]string, flag_invert : bool = false ) -> map[int]string {

    flag : bool
    digit : map[int]string
    lenstring : int = len(arrData[0])
    
    for size_td in 0..<lenstring {
	
	flag = reason_about_gama_rate_one_bit_be_one ( arrData, size_td )

	if flag_invert {
	    flag = !flag
	}
	
	if flag {
	    digit[size_td] = "1"
	} else {
	    digit[size_td] = "0"
	}
    }

    return digit
}

mapstring_to_string :: proc ( data : map[int]string ) -> string {

    lenMap := len ( data )
    stringResul := make([]string, lenMap)
    result : int = 0
    powerNum : int
    
    for idx in 0..<lenMap {
	item := data[idx]
	stringResul[idx] = item
    }
    
    return strings.concatenate ( stringResul )
}


rune_to_string :: proc(r: rune) -> (res: string) {
	res = fmt.tprintf("%08x", int(r))
	for len(res) > 2 && res[:2] == "00" {
		res = res[2:]
	}
	return fmt.tprintf("rune(0x%v)", res)
}

string_binary_to_binary_integer_decimal :: proc ( value : string ) -> int {

    lenmax : int = len(value)
    digit : int
    digit_pow : int
    flag : bool
    
    for idx := len(value) - 1; idx >= 0; idx -= 1 {

	flag = value[lenmax-idx-1] == 49
	
	if flag {
	   
	    digit += cast(int) mi.pow( 2, auto_cast idx ) * 1
	}

	if DEBUG_STUFF {
	    fmt.println (idx, " = ", mi.pow( 2, auto_cast idx ) )
	}
    }

    return digit
}

first_part :: proc () {

    file_path_name : string = "input"

    if TEST_EXAMPLE {
	file_path_name = "example"
    }

    data_text_digest, ok := os.read_entire_file(file_path_name, context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return
    }
    defer delete(data_text_digest, context.allocator)

    file_text : string = string ( data_text_digest )

    strings_values := texto_to_lines_int ( file_text )
    defer delete ( strings_values )

    map_string_of_bits_gama_rate : map[int]string = reason_about_gama_rate_get_binary_digit ( strings_values )
    defer delete ( map_string_of_bits_gama_rate )
    
    map_string_of_bits_epsilon_rate : map[int]string = reason_about_epsilon_rate_get_binary ( strings_values )
    defer delete ( map_string_of_bits_epsilon_rate )
    

    
    gama_rate_str : string = mapstring_to_string ( map_string_of_bits_gama_rate )
    defer delete ( gama_rate_str )

    epsilon_rate_str : string = mapstring_to_string ( map_string_of_bits_epsilon_rate )
    defer delete ( epsilon_rate_str )


    
    gama_dec_num := string_binary_to_binary_integer_decimal ( gama_rate_str )
    epsilon_dec_num := string_binary_to_binary_integer_decimal ( epsilon_rate_str )

    fmt.println ( gama_dec_num, " * ", epsilon_dec_num )
    fmt.println ( gama_dec_num * epsilon_dec_num )
    
    return
}

loop_to_filter_map_string_oxygen_co2 :: proc ( lenstringvalues : int, filtered_map_strings_proc : map[int]string, is_co2_check : bool = false ) -> map[int]string {

    filtered_map_strings : map[int]string = filtered_map_strings_proc
    
    loop_colum_digit: for colum_idx in 0..<lenstringvalues {
	filtered_map_strings = filter_report_diagnostic_rating_oxygen_co2 ( filtered_map_strings, colum_idx, is_co2_check )

	if DEBUG_STUFF {
	    fmt.println ( lenstringvalues, " - ", colum_idx, " - ", filtered_map_strings )
	}
	
	if (len(filtered_map_strings) == 1) {
	    break loop_colum_digit
	}
    }
    
    return filtered_map_strings
}

loop_to_filter_map_string_co2 :: proc ( len_strings : int, filtered_map_strings : map[int]string ) -> map[int]string {

    return loop_to_filter_map_string_oxygen_co2 ( len_strings, filtered_map_strings, true )
}

second_part :: proc () {

    file_path_name : string = "input"

    if TEST_EXAMPLE {
	file_path_name = "example"
    }
    
    data_text_digest, ok := os.read_entire_file(file_path_name, context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return
    }
    defer delete(data_text_digest, context.allocator)

    filtered_map_strings := make ( map[int]string )
    filtered_oxygen_map_strings := make ( map[int]string )
    filtered_co2_map_strings := make ( map[int]string )
    defer delete ( filtered_oxygen_map_strings )
    defer delete ( filtered_co2_map_strings )
    defer delete ( filtered_map_strings )

    file_text : string = string ( data_text_digest )

    strings_values : map[int]string = texto_to_lines_int ( file_text )
    defer delete ( strings_values )

    filtered_map_strings = strings_values

    len_strings := len(strings_values)

    filtered_oxygen_map_strings = loop_to_filter_map_string_oxygen_co2 ( len_strings, filtered_map_strings )

    filtered_co2_map_strings = loop_to_filter_map_string_co2 ( len_strings, filtered_map_strings )
    
    oxygen_generator_num : int = string_binary_to_binary_integer_decimal ( filtered_oxygen_map_strings[0] )
    
    co2_rate_num : int = string_binary_to_binary_integer_decimal ( filtered_co2_map_strings[0] )

    fmt.println( oxygen_generator_num , " * ", co2_rate_num )
    fmt.println( oxygen_generator_num * co2_rate_num )
    
    return
}


test :: proc () {

    fmt.println ( mi.pow ( 10, 2 ) )
}

main :: proc () {

    first_part()
    second_part()
    // test () 
}
