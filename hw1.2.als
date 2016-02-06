module binarytree

one sig BinaryTree {	root: lone Node }
abstract sig Node {	left, right: lone Node }

pred Acyclic(t: BinaryTree) {
	all n: t.root.*(left + right) { // union of sets of nodes at right and left branches
		n !in n.^(left + right)	// n not in left or right subtrees
		no n.(left) & n.(right) // n.left != n.right
		lone n.~(left + right) // n has one parent node ONLY unless root
	}
}


-- 2.a Connectivity
fact DisconnectedNodesHaveSelfLoops {
	// the left and right fields of a node that is not in the
	// tree point to the node itself
	all n:Node, t:BinaryTree | n not in t.root.*(left + right) <=> 
		n.right = n and n.left = n 
}

-- 2.b Isomorphism
--run Acyclic
/*
Considering only the part of the instance reachable from the binary tree atom:

---INSTANCE 1 ---
integers={}
univ={BinaryTree$0, Node$0, Node$1}
Int={}
seq/Int={}
String={}
none={}
this/BinaryTree={BinaryTree$0}
this/BinaryTree<:root={BinaryTree$0->Node$1}
this/Node={Node$0, Node$1}
this/Node<:left={Node$1->Node$0}
this/Node<:right={}
skolem $Acyclic_t={BinaryTree$0}

---INSTANCE 2---
integers={}
univ={BinaryTree$0, Node$0, Node$1, Node$2}
Int={}
seq/Int={}
String={}
none={}
this/BinaryTree={BinaryTree$0}
this/BinaryTree<:root={BinaryTree$0->Node$2}
this/Node={Node$0, Node$1, Node$2}
this/Node<:left={Node$1->Node$1, Node$2->Node$0}
this/Node<:right={Node$1->Node$1}
skolem $Acyclic_t={BinaryTree$0}

*/


-- 2.c Linear order
one sig N0, N1, N2, N3 extends Node {}

one sig Ordering { // model a linear order on nodes
	first: Node, // the first node in the linear order
	order: Node -> Node 
	// for each node n, n.(Ordering.order) represents the
	// node (if any) immediately after n in order
}

fact LinearOrder {
	// the first node in the linear order is N0; and
	// the four nodes are ordered as [N0, N1, N2, N3]
	N0 = Ordering.first
 	N0.(Ordering.order) = N1
	N1.(Ordering.order) = N2
	N2.(Ordering.order) = N3 
	N3.(Ordering.order) = none //end ordering cycles
}


-- 2.d Non-isomorphic enumeration 
pred SymmetryBreaking(t: BinaryTree) {
	// if t has a root node, it is the first node according to the linear order; and
	// a "pre-order" traversal of the nodes in t visits them according to the linear order
	N0 = t.root or no t.root  
	all n: N0.*(left+right) {
	 	one n.left and no  n.right	=> n.left  = n.(Ordering.order)
		one n.left and one n.right	=> n.left  = n.(Ordering.order) and n.right in n.left.*(Ordering.order)
		no  n.left and one n.right 	=> n.right = n.(Ordering.order) 
		//n.left in n.right.*(Ordering.order)
	} 
}

pred NonIsomorphicTrees(t: BinaryTree) {
	Acyclic[t]
	SymmetryBreaking[t]
}

run NonIsomorphicTrees for 4 Node // enumerates non-isomorphic binary trees with up to 4 nodes

