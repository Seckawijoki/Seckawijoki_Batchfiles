import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
public class ChangeClientManagerCpp{
  private static final String KEY_LINE_S_CLIENT_VERSION = "static const char *sClientVersion";
  private static final char QUOTE = '"';
  public static void main(String []args) throws IOException {
    if ( args == null ) {
      System.out.println("ChangeClientManagerCpp.main(): args == null");
      return;
    }
    if (args.length <= 2){
      System.out.println("ChangeClientManagerCpp.main(): Length of arguments less than 2.");
    }
    File readFile = new File(args[0]);
    File writtenFile = new File(args[1]);
    String versionName = new String(args[2]);
    System.out.println("ChangeClientManagerCpp.main(): readFile = " + readFile);
    System.out.println("ChangeClientManagerCpp.main(): writtenFile = " + writtenFile);
    System.out.println("ChangeClientManagerCpp.main(): versionName = " + versionName);
    BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(readFile), "UTF-8"));
    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(writtenFile), "UTF-8"));
  }
}
