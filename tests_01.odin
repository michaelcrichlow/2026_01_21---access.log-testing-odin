package test

import "core:fmt"
import p_str "python_string_functions"
print :: fmt.println

main :: proc() {
    lines := get_lines_from_file("access.log")
    lines_filtered := make([dynamic]string, context.temp_allocator)
    
    for line in lines {
        if p_str.startswith(line, "200") {
            append(&lines_filtered, line)
        }
    }

    percent := (f64(len(lines_filtered)) / f64(len(lines))) * 100
    print("Percent of requests that were successful:", format_f64(percent, 2), "%")
    
    c := Counter(lines_filtered[:])
    sorted_values := map_sorted_by_value(c, descending=true)
    
    for val in sorted_values {
        print(val.key[4:], val.value)
    }

    free_all(context.temp_allocator)
}

/*
The Challenge: The "Log Analyzer"

The Scenario: You have a log file (let's call it access.log) where each line represents a web request. 
The lines look like this: 200 /home 404 /secret 200 /login 500 /upload 200 /home

The Problem:

    Read the file.

    Filter out any request that isn't a 200 (success).

    Calculate the percentage of total requests that were successful.

    Print a list of the unique "Success URLs" and how many times each was accessed, sorted by most hits to least.
*/

/*
OUTPUT:
/home 6
/login 4
/products 3
/about 1
*/
