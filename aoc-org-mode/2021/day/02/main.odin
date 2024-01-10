package aoc202102

import "core:fmt"
import md "core:math/big"
import "core:os"
import "core:runtime"
import strc "core:strconv"
import "core:strings"

TEST_EXAMPLE :: false
DEBUG_STUFF :: false

instructions :: proc() -> map[string]string {

  map_simbols := make(map[string]string)
  map_simbols["forward"] = "forward"
  map_simbols["up"] = "up"
  map_simbols["down"] = "down"
  // defer delete(map_simbols)

  return map_simbols
}

interpret :: proc(
  file_path_name: string,
  map_simbols: ^map[string]string,
) -> (
  string,
  ^[]u8,
  bool,
) {

  data, ok := os.read_entire_file(file_path_name, context.allocator)
  if !ok {
    // could not read file
    fmt.println("cannot read file")
    return "", &data, false
  }
  // defer delete(data, context.allocator)

  it := string(data)

  return it, &data, true
}

first_part :: proc() -> bool {

  file_path_name: string = "input"

  if TEST_EXAMPLE {
    file_path_name = "example"
  }

  atoms: []string
  digite: int

  depth: int = 0
  horizontal: int = 0

  map_simbols := instructions()
  defer delete(map_simbols)

  it, data, ok := interpret(file_path_name, &map_simbols)
  if !ok {
    fmt.print("error on interpretation")
    return false
  }
  // defer delete(data, context.allocator) // TODO :: error of free memory, need to manual allocate later on on interpret

  for line in strings.split_lines_iterator(&it) {

    atoms = strings.split_after(line, " ")
    digite = strc.atoi(atoms[1])

    if strings.contains(atoms[0], map_simbols["forward"]) {
      horizontal += digite
    } else if strings.contains(atoms[0], map_simbols["up"]) {
      depth -= digite
    } else if strings.contains(atoms[0], map_simbols["down"]) {
      depth += digite
    }


    if depth < 0 || horizontal < 0 {
      fmt.println("error overflow")
    }
  }

  fmt.println(horizontal * depth)

  return true
}

second_part :: proc() -> bool {

  file_path_name: string = "input"

  if TEST_EXAMPLE {
    file_path_name = "example"
  }

  atoms: []string
  digite: int

  depth: int = 0
  horizontal: int = 0
  aim: int = 0

  map_simbols := instructions()
  defer delete(map_simbols)

  it, data, ok := interpret(file_path_name, &map_simbols)
  if !ok {
    fmt.print("error on interpretation")
    return false
  }
  // defer delete(data, context.allocator) // TODO :: error of free memory, need to manually allocate later on procedure interpret

  for line in strings.split_lines_iterator(&it) {

    atoms = strings.split_after(line, " ")
    digite = strc.atoi(atoms[1])

    if strings.contains(atoms[0], map_simbols["forward"]) {
      horizontal += digite
      depth += (aim * digite)

      if DEBUG_STUFF {
        fmt.printf(
          "forward %v :: horizontal %v, depth %v, aim %v\n",
          digite,
          horizontal,
          depth,
          aim,
        )
      }
    } else if strings.contains(atoms[0], map_simbols["up"]) {
      // depth -= digite
      aim -= digite

      if DEBUG_STUFF {
        fmt.printf(
          "up %v :: horizontal %v, depth %v, aim %v\n",
          digite,
          horizontal,
          depth,
          aim,
        )
      }
    } else if strings.contains(atoms[0], map_simbols["down"]) {
      aim += digite
      // depth += digite
      if DEBUG_STUFF {
        fmt.printf(
          "down %v :: horizontal %v, depth %v, aim %v\n",
          digite,
          horizontal,
          depth,
          aim,
        )
      }
    }

    if depth < 0 || horizontal < 0 {
      fmt.println("error overflow")
    }
  }


  // fmt.printf ("horizontal %v, depth %v\n", horizontal, depth)
  fmt.println(horizontal * depth)

  return true
}

main :: proc() {

  first_part()
  second_part()
}
