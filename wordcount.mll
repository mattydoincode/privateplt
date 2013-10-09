

{ 
	type token = EOF | Word of string
	module StringMap = Map.Make(String) 
}
rule token = parse
| eof { EOF }
| ['a'-'z' 'A'-'Z']+ as word { Word(word) }
| _ { token lexbuf }
{

let lexbuf = Lexing.from_channel stdin in
let wordlist =
	let rec next l =
		match token lexbuf with
			EOF -> l
		| Word(s) -> next (s :: l)
	in next []
in
let rec getwordmap mymap mylist = match mylist
	with [] -> mymap
	| h :: t -> 
			let newmap = getwordmap mymap t in
			if StringMap.mem h newmap
				then
					let count = StringMap.find h newmap in
					StringMap.add h (count+1) newmap
				else
					StringMap.add h 1 newmap
in
let wordmap = StringMap.empty in
let wordmap = getwordmap wordmap wordlist in
let wordchunks = StringMap.fold (fun k d a -> (k,d) :: a) wordmap [] in
let wordchunks = List.sort (fun (_, c1) (_, c2) ->
	Pervasives.compare c2 c1)
	wordchunks in
List.iter print_endline (List.map (fun t-> fst t ^ ": " ^ (string_of_int (snd t))) wordchunks)
}