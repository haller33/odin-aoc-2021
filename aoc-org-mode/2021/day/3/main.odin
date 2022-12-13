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
    
    if count_ones > count_zeros {
	return true
    } else {
	return false
    }
}

reason_about_epsilon_rate_get_binary :: proc ( arrData : map[int]string ) -> map[int]string {
    return reason_about_gama_rate_get_binary_digit ( arrData, true )
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

convert_mapstring_integer :: proc ( data : map[int]string ) -> string {

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

    data, ok := os.read_entire_file(file_path_name, context.allocator)
    if !ok {
	// could not read file
	fmt.println("cannot read file")
	return
    }
    defer delete(data, context.allocator)

    file_text : string = string ( data )

    strings_values := texto_to_lines_int ( file_text )
    defer delete ( strings_values )

    resultstr : map[int]string = reason_about_gama_rate_get_binary_digit ( strings_values )
    defer delete ( resultstr )
    
    resultstr_invert : map[int]string = reason_about_epsilon_rate_get_binary ( strings_values )
    defer delete ( resultstr_invert )
    
    // fmt.println ( resultstr )
    // fmt.println ( resultstr_invert )

    gama_rate_str : string = convert_mapstring_integer ( resultstr )
    defer delete ( gama_rate_str )

    epsilon_rate_str : string = convert_mapstring_integer ( resultstr_invert )
    defer delete ( epsilon_rate_str )

    gama_num := string_binary_to_binary_integer_decimal ( gama_rate_str )
    epsilon_num := string_binary_to_binary_integer_decimal ( epsilon_rate_str )

    fmt.println ( gama_num * epsilon_num )
    // fmt.println ( epsilon_num )
    
    return
}


test :: proc () {

    fmt.println ( mi.pow ( 10, 2 ) )
}

main :: proc () {

    first_part()
    // test () 
}
