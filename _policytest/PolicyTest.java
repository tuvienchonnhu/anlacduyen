import java.io.*;
import org.owasp.validator.html.*;
public class PolicyTest {
  public static void main(String[] a) throws Exception {
    InputStream in = new FileInputStream("C:/web/shopizer-2.17.0/sm-shop/target/classes/antisamy-slashdot.xml");
    Policy p = Policy.getInstance(in);
    String html = "<img src=\"/static/img/test.png\" alt=\"anh\" class=\"img-responsive\" width=\"200\" style=\"margin: 10px 20px; border-width: 10px; border-style: solid; float: left;\"/>";
    AntiSamy as = new AntiSamy();
    CleanResults cr = as.scan(html, p);
    System.out.println("OUTPUT:");
    System.out.println(cr.getCleanHTML());
  }
}
