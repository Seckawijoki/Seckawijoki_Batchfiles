import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.io.IOException;
public class ChangeVersionCodeAndName{
  private static final String KEY_LINE_VERSION_CODE = "android:versionCode=";
  private static final String KEY_LINE_VERSION_NAME = "android:versionName=";
  private static final char QUOTE = '"';
  public static void main(String []args) throws IOException {
    if ( args == null ) {
      System.out.println("ChangeVersionCodeAndName.main(): args == null");
      return;
    }
    if (args.length <= 2){
      System.out.println("ChangeVersionCodeAndName.main(): Length of arguments less than 2.");
    }
    File readFile = new File(args[0]);
    File writtenFile = new File(args[1]);
    String versionName = new String(args[2]);
    System.out.println("ChangeVersionCodeAndName.main(): readFile = " + readFile);
    System.out.println("ChangeVersionCodeAndName.main(): writtenFile = " + writtenFile);
    System.out.println("ChangeVersionCodeAndName.main(): versionName = " + versionName);
    BufferedReader reader = new BufferedReader(
            new InputStreamReader(
                    new FileInputStream(readFile)
            )
    );
    BufferedWriter writer = new BufferedWriter(
            new OutputStreamWriter(
                    new FileOutputStream(writtenFile)
            )
    );
    System.out.println("ChangeVersionCodeAndName.main(): " + versionName.split("."));
    String line;
    int readLength = 0;
    boolean hasWrittenVersionCode = false;
    boolean hasWrittenVersionName = false;
    int readCount = 0;
    while ((line = reader.readLine()) != null){
      if (hasWrittenVersionCode == false || hasWrittenVersionName == false){
        System.out.println("ChangeVersionCodeAndName.main(): line = " + line);
      }
      if (hasWrittenVersionCode == true && hasWrittenVersionName == true){
        writer.write(line, 0, line.length());
        continue;
      }
      if (hasWrittenVersionCode == false && line.contains(KEY_LINE_VERSION_CODE)){
        int leftIndex = line.indexOf(QUOTE);
        int rightIndex = line.lastIndexOf(QUOTE);
        System.out.println("ChangeVersionCodeAndName.main(): leftIndex = " + leftIndex);
        System.out.println("ChangeVersionCodeAndName.main(): rightIndex = " + rightIndex);
        String []versionDigits = versionName.replaceAll(".", "|").split("|");
       if (versionDigits == null || versionDigits.length <= 0 || versionDigits.length > 3){
          System.out.println("ChangeVersionCodeAndName.main(): The input argument versionName invalid: " + versionName);
          return;
        }
        int versionCode = Integer.valueOf(versionDigits[0]) * 65536 + Integer.valueOf(versionDigits[1]) * 256 + Integer.valueOf(versionDigits[2]);
        String newVersionCodeLine = line.substring(0, leftIndex+1) + versionCode + line.substring(rightIndex);
        System.out.println("ChangeVersionCodeAndName.main(): newVersionCodeLine = " + newVersionCodeLine);
        writer.write(newVersionCodeLine);
        hasWrittenVersionCode = true;
      } else if (hasWrittenVersionName == false && line.contains(KEY_LINE_VERSION_NAME)) {
        hasWrittenVersionName = true;
      } else {
        writer.write(line, 0, line.length());
      }
    }
    System.out.println("ChangeVersionCodeAndName.main(): Writing finished.");
  }
}
