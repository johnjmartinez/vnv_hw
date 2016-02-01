one sig List { //set of list atoms (?) ---> adding one makes it unique
	header: lone Node //header: List x Node --> adding lone, makes it a partial function
}

sig Node {
	link: lone Node //link : Node x Node
}

pred Acyclic (l:List) { //predicate acyclic, desired property
	all n: l.header.*link | n !in n.^link 	// ForAll n in set of transversal from header (every node reachable from header), 
															// n doesnot belong to set of transversal starting from n
}

pred Acyclic2 (l:List) {
	no l.header or // (1)
	some  n: l.header.*link | no n.^link 
}

check {
	all l: List | Acyclic[l] <=> Acyclic2[l] // the two predicates are equivalent (implication both ways)
} // fails on empty list (fixed with (1))

--fact { //constrains model 
--	List.header.*link = Node // Starting from list's header every member is a node
--} 

-- run Acyclic // default bound = 3
--run Acyclic for exactly 4 Node
