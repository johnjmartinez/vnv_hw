import gov.nasa.jpf.vm.Verify; 
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class LListTester {
/* (a)
Write some JUnit tests such that each test makes exactly one invocation of
addLast and running all the tests provides full statement coverage for the method
addLast
*/
	@Test 
	public void test0() { //add to non-empty list
		LList l = new LList();	
		l.addFirst(1);
        l.addLast(0);
        assertEquals(l.toString(), "1 0");
	}

	@Test 
	public void test1() { //add to empty list
		LList l = new LList();	
		l.addLast(2);
        assertEquals(l.toString(), "2");
	}

/* (b)
Implement the following main method such that running it using the JPF JVM
generates all method sequences of length up to SEQUENCE LENGTH , where the
first method in each sequence is a constructor call, which is followed by up
to SEQUENCE LENGTH - 1 invocations of addFirst or addLast , and each invocation 
of addFirst and addLast uses only integers { 0, ..., ELEM UPPER BOUND } as
parameter values
*/
	public static void main(String[] a) {
		if (a.length != 2) throw new IllegalArgumentException();
		final int SEQUENCE_LENGTH = Integer.parseInt(a[0]);
		final int ELEM_UPPER_BOUND = Integer.parseInt(a[1]);

		//@DEBUG -- final int SEQUENCE_LENGTH = 3;
		//@DEBUG -- final int ELEM_UPPER_BOUND = 1;

		int num = ELEM_UPPER_BOUND+1;
		int possibilities = num*2;

		String [] add = {"\tl.addFirst","\tl.addLast"};
		String [] ops = new String[possibilities];
		String out = "";

		for (int i=0; i<ops.length; i++) {
			ops[i] = add[i%2] + "(" + i/2 +");\n"; 
			//@DEBUG -- System.out.print(ops[i]);
		}

		///* --JPF
        
		int p;
		int s = Verify.getInt(0,SEQUENCE_LENGTH-1); //@DEBUG -- System.out.print(Verify.getCounter(0) + " s:"+s);
		for (int i=0; i<s; i++){
			 p = Verify.getInt(0,possibilities-1); //% (possibilities-1); 
			 //@DEBUG -- System.out.print(", p:"+p);
			 out += ops[p];
		}
        
        String header = "\tLList l = new LList();\n";
		System.out.println("@Test public void test" + Verify.getCounter(0) + "() {\n" + header + out + "}\n" );
		Verify.incrementCounter(0); //@DEBUG -- System.out.print("\n");
        
		//*/
	}

	        

}
