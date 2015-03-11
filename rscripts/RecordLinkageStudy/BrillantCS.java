import java.io.OutputStream;
import java.io.PrintWriter;

public class BrillantCS {
	public static void main(String[] args) /*throws IOException*/ {
		int a = 0, b = 1, r = 0;
		PrintWriter pw = new PrintWriter(new OutputStream(System.out), true);
		for(int x=0; x<1000000000; x++) {
			a = b - a;
			b = a + b;
			pw.println(b);
		}
	}
}