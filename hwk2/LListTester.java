import gov.nasa.jpf.vm.Verify; 
import org.junit.Test;

public class LListTester {

	@Test 
	public void test0() {
		LList l = new LList();	
		l.addFirst(1);
	}

	@Test 
	public void test1() {
		LList l = new LList();	
		l.addLast(1);
	}


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
