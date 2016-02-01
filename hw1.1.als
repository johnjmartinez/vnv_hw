module list
-- Def of Loop list : single linked == uni-directional
-- 1. empty or 
-- 2. last node points to itself

sig List {
	header: set Node
}

sig Node {
	link: set Node,
	elem: set Int
}

-- 1.a
fact CardinalityConstraints {
  // each list has at most one header node
	all x:List | lone x.header

  // each node has at most one link  
  // SHOULDN'T IT BE EXACTLY ONE?? (last link to nothing???)
	all y:Node | lone y.link 
  
  // each node has exactly one elem
	all y:Node | one y.elem

}

fact EveryNodeInList { all y:Node, x:List | y in x.header.*link}

-- 1.b Class invariant
pred Loop(This:List) {
	// <This> is a valid loop-list
	no This.header or  //(1.)
	one y:This.header.*link | y.^link = y //(2.) -- SUSPECT case: header -> a -> b -> c -> b ?   
	//MESSY --all y:This.header.*link | one y in y.^link and y = y.^link
	-- all y:Node | y in This.header.*link 
}
pred Sorted(This:List) {
	// <This> has elements in sorted order (‘<=’)
	all y:This.header.*link | y.elem <= y.link.elem
}
pred RepOk(This:List) { // class invariant for List
	Loop[This]
	Sorted[This]
}

// scope: #List <= 1, #Node <= 3, ints = { -2, -1, 0, 1 }
run RepOk for 1 List, 7 Node, 4 int
