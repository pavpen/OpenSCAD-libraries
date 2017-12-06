// Copyright 2017 Pavel Penev
// https://www.thingiverse.com/pavpen/about
//
// You can use this file under Attribution-ShareAlike 4.0 International
// (CC BY-SA 4.0).
//
// If you need to use it under another license, send me a message.

// Common list functions.


// Adds all elements in a list.
function pro_pavpen_list_sum(list, start_index = 0) =
    len(list) > 0 && start_index < len(list) ?
        list[start_index] + pro_pavpen_list_sum(list, start_index + 1) :
        0;

function pro_pavpen_list_elementwise_product(a, b) =
    [for (i = [0 : len(a) - 1])
        a[i] * b[i]
    ];

// Returns a given list with the last `drop_elements_count` elements removed.
function pro_pavpen_list_drop_last(list, drop_elements_count) =
    drop_elements_count >= len(list) ?
        [] :
        [for (i = [0 : len(list) - 1 - drop_elements_count])
            list[i]
        ];
