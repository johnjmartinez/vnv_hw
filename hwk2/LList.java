
public class LList {
    Node header;
	int size;

	static class Node {
		int elem;
		Node next;
	}

	public boolean repOk() {
	// returns true if and only if (1) this is a loop-list and
	// (2) size is the number of nodes in this
        Set<Node> = new HashSet<Node>();
        
        if (header == null) {
            return ( size == 0 ? true :  false );
        }
        
        Node curr = header;
        while (curr !=  curr.next) {
            
        }
            
        
            
    
		return true;
	}

	public void addFirst(int x) {
	// adds a new node with element x at the *head* of the list; all other list nodes
	// remain unchanged

	}

	public void addLast(int x) {
	// adds a new node with element x at the *tail* of the list; all other list nodes
	// remain unchanged

	}

	public String toString() {
	// returns a string representation of the list of elements in this, where
	// consecutive elements are separated by a space
		return null;
	}

}
