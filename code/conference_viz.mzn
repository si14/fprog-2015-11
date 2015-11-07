string: viz_conference_file_path = file_path()++".html";

function string: conference_viz(array[int] of int: duration,
  array[int] of int: theme,
  array[int] of var int: start) =
  let { array[int] of int: idx = set2array(index_set(duration)) } in
  "%%%mzn-json:"++viz_conference_file_path++"\n[\n"++
    concat(
    [join(", \n",["{\"duration\":\(duration[i]), "++
     "\"idx\":\(idx[i]), "++
     "\"theme\":\(theme[i]), "++
     "\"start\":\(start[i])}" | i in index_set(duration)])])
    ++"]\n%%%mzn-json-end\n";

