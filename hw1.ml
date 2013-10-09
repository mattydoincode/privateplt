(*part 1*)
module StringMap = Map.Make(String)

let rec uniq = function
	| [] -> []
	| [x] -> [x]
	| h :: t -> if List.hd t = h then uniq t else h :: uniq t


let rec getwordmap mymap mylist = match mylist
	with [] -> mymap
	| h :: t -> 
			let newmap = getwordmap mymap t in
			if StringMap.mem h mymap
				then
					let count = StringMap.find h mymap in
					StringMap.add h (count+1) newmap
				else
					StringMap.add h 1 newmap

					