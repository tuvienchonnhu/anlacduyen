import java.io.*;
import org.owasp.validator.html.*;
public class PolicyTest {
  public static void main(String[] a) throws Exception {
    InputStream in = new FileInputStream("C:/web/shopizer-2.17.0/sm-shop/target/classes/antisamy-slashdot.xml");
    Policy p = Policy.getInstance(in);
    String html = "<p>Hello <img src=\"/static/img/test.png\" alt=\"anh\" width=\"200\"/> <span class=\"x\">span</span> <table><tr><td colspan=\"2\">cell</td></tr></table></p>";
    AntiSamy as = new AntiSamy();
    CleanResults cr = as.scan(html, p);
    System.out.println("POLICY OK - cleaned output:");
    System.out.println(cr.getCleanHTML());
  }
}