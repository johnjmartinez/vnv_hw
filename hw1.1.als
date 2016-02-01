module list
-- Def of Loop list : single linked == uni-directional
-- I.  empty or 
-- II. last node points to itself

sig List { // Denoted as 'a'
	header: set Node
}

sig Node { // Denoted as 'b'
	link: set Node,
	elem: set Int
}

-- 1.a
fact CardinalityConstraints {
  // each list has at most one header node
	all a:List | lone a.header

  // each node has at most one link  
  // SHOULDN'T IT BE EXACTLY ONE?? (last link to nothing???)
	all b:Node | lone b.link 
  
  // each node has exactly one elem
	all b:Node | one b.elem

}

fact EveryNodeInList { all b:Node, a:List | b in a.header.*link}


-- 1.b Class invariant
pred Loop(This:List) {
	// <This> is a valid loop-list
	no This.header or  //(I)
	one b:This.header.*link | b.^link = b.*link //(II)    
	
  //MESSY:    all b:This.header.*link | one y in b.^link and y = b.^link
  //NOT UNIV: all b:Node | y in This.header.*link  
}
pred Sorted(This:List) {
	// <This> has elements in sorted order (?<=?)
	all b:This.header.*link | b.elem <= b.link.elem
}

pred RepOk(This:List) { // class invariant for List
	Loop[This]
	Sorted[This]
}

// scope: #List <= 1, #Node <= 3, ints = { -2, -1, 0, 1 }
--run RepOk for 1 List, 3 Node, 2 int


-- 1.c Specifying the count method
pred Count(This:List, x:Int, result:Int) {
	// count correctly returns the number of occurences of <x> in <This>
	// <result> represents the return value of count
  result = #{ b:This.header.*link | b.elem = x } 

	RepOk[This] // assume This is a valid list
}

// scope: #List <= 1, #Node <= 3, ints = { -2, -1, 0, 1 }
--run Count for 1 List, 3 Node, 2 int


-- 1.d Specifying the contains method 
abstract sig Boolean {}
one sig True, False extends Boolean {}
pred Contains(This:List, x:Int, result:Boolean) {
	// contains returns true if and only if <x> is in <This>
	// <result> represents the return value of contains
	result = Boolean { some b:This.header.*link | b.elem = x } 

	RepOk[This] // assume This is a valid list
}

// scope: #List <= 1, #Node <= 3, ints = { -2, -1, 0, 1 }
run Contains for 1 List, 3 Node, 2 int



