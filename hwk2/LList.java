import java.util.Set;
import java.util.HashSet;


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
        Set<Node> nodes = new HashSet<Node>();
        
        if (header == null) {
            return ( size == 0 ? true :  false );
        }
        
        Node curr = header;
        while (curr !=  curr.next) {
            if ( !nodes.add(curr) ) return false; //node already transversed and not loop'd to itself
            curr = curr.next;
        }
   
        return ( size == nodes.size() ? true :  false );	
    }

	public void addFirst(int x) {
	// adds a new node with element x at the *head* of the list; all other list nodes
	// remain unchanged
        Node n = new Node();
        n.elem = x;
       
        if (header==null) { 
            header = n ;
            n.next = n;
        }
        else {
            n.next = header;
            header = n;
        }
        size++;
        return;
	}

	public void addLast(int x) {
	// adds a new node with element x at the *tail* of the list; all other list nodes
	// remain unchanged
        Node n = new Node();
        n.elem = x;   
        n.next = n; //last node MUST point to itself
    
        if (header==null) { 
            header = n ;
        }
        else {
            Node curr = header;
            while (curr !=  curr.next) { //transverse list until end
                curr = curr.next;
            }
            curr.next = n;
        }
        size++;
        return;        
	}

	public String toString() {
	// returns a string representation of the list of elements in this, where
	// consecutive elements are separated by a space
        if (!this.repOk()) return "-- invalid LList! --"; //needed?
        if (header == null) return "";
        
        String out = "";
        Node curr = header;
        while (curr !=  curr.next) {
            out += curr.elem+" ";
            curr = curr.next;
        }
		return out;
	}

}
