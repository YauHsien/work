
/*
D:\work\hello>mvn compile
(bypassed)

D:\work\hello>cd target\classes

D:\work\hello\target\classes>java DanglingReference
delete a.
ask a: java.lang.NullPointerException
        at DanglingReference.ask(DanglingReference.java:42)
        at DanglingReference.main(DanglingReference.java:33)
ask b: world: ref to "hello"

delete b.
ask a: java.lang.NullPointerException
        at DanglingReference.ask(DanglingReference.java:42)
        at DanglingReference.main(DanglingReference.java:36)
ask b: java.lang.NullPointerException
        at DanglingReference.ask(DanglingReference.java:48)
        at DanglingReference.main(DanglingReference.java:36)

*/

public class DanglingReference {
    public static void main(String[] args) {
	A a = new A("hello");
	A b = new A("world");
	a.ObjRef = b;
	b.ObjRef = a;
	System.out.println("delete a.");
	a = null;
	ask(a, b);
	System.out.println("\ndelete b.");
	b = null;
	ask(a, b);
    }

    static void ask(A a, A b) {
	System.out.print("ask a: ");
	try {
	    System.out.println(a.toString());
	} catch(Exception ex) {
	    ex.printStackTrace();
	}
	System.out.print("ask b: ");
	try {
	    System.out.println(b.toString());
	} catch(Exception ex) {
	    ex.printStackTrace();
	}
    }
}

class A {
    public A ObjRef;
    private String name;

    public A(String name) {
	this.name = name;
    }

    public String getName() {
	return this.name;
    }

    @Override
    public String toString() {
	return "" + this.name + ": ref to \"" + ObjRef.getName() + "\"";
    }
}
