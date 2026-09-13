import org.owasp.validator.html.*;
public class Check {
  public static void main(String[] args) throws Exception {
    Policy p = Policy.getInstance(args[0]);
    System.out.println("POLICY PARSE OK: " + p.getAllTags().size() + " tags");
  }
}
