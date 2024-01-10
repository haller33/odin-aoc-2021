package aoc202101

import "core:fmt"
import md "core:math/big"
import "core:os"
import strc "core:strconv"
import "core:strings"

TEST_EXAMPLE :: false

count_incrising_values :: proc(arr_values: ^map[int]int) -> int {

  previous: int = 0
  count: int = 0

  for idx, number in arr_values {

    if !(idx == 0) {

      if number > previous {

        count += 1
      }
    }

    previous = number
  }

  return count
}

first_part :: proc() -> bool {

  file_path_name := "input"

  if TEST_EXAMPLE {
    file_path_name = "example"
  }

  counter := 0

  data, ok := os.read_entire_file(file_path_name, context.allocator)
  if !ok {
    // could not read file
    fmt.println("cannot read file")
    return false
  }
  defer delete(data, context.allocator)

  it := string(data)

  split_string: []string = strings.split_after(it, "\n")

  strings_values: []string = split_string[:len(split_string) - 1]

  arr_values: map[int]int
  defer delete(arr_values)

  for item, index in strings_values {

    arr_values[index] = strc.atoi(item)
  }

  count: int = count_incrising_values(&arr_values)

  fmt.println(count)

  return true
}

array_split_space_file_string_path :: proc(
  file_path_name: string,
) -> []string {

  counter := 0

  data, ok := os.read_entire_file(file_path_name, context.allocator)
  if !ok {
    // could not read file
    fmt.println("cannot read file")
    return []string{}
  }
  // defer delete(data, context.allocator) // strange behaviour after free memory out of scoupe.

  it := string(data)

  split_string: []string = strings.split_after(it, "\n")

  return split_string[:len(split_string) - 1]
}

split_sum_of_thre_regions :: proc(arrStr: []string) -> map[int]int {

  sizeArr := len(arrStr)
  values: map[int]int

  for item, idx in arrStr {

    if idx <= sizeArr - 3 {

      values[idx] =
        strc.atoi(item) +
        strc.atoi(arrStr[idx + 1]) +
        strc.atoi(arrStr[idx + 2])
    }
  }

  return values
}


second_part :: proc() -> bool {

  file_name: string = "input"

  file_values_arr: []string

  if TEST_EXAMPLE {
    file_name = "example"
  }

  file_values_arr = array_split_space_file_string_path(file_name)
  defer delete(file_values_arr, context.allocator)

  mapsValues: map[int]int = split_sum_of_thre_regions(file_values_arr)
  defer delete(mapsValues)

  count: int = count_incrising_values(&mapsValues)

  fmt.println(count)

  return true
}

test :: proc() {

  // fmt.println ( len ( []string{ "some", "soma" } ) )
}

main :: proc() {

  first_part()
  second_part()
  // test ()
}
