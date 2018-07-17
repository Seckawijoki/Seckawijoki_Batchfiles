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
public class ChangeAndroidManifestXml{
  private static final String DEFAULT_READ_CHARSET = "GBK";
  private static final String DEFAULT_WRITE_CHARSET = "GBK";
  private static final String KEY_LINE_VERSION_CODE = "android:versionCode=";
  private static final String KEY_LINE_VERSION_NAME = "android:versionName=";
  private static final String KEY_LINE_BUGLY_ENALBE_DEBUG = "BUGLY_ENABLE_DEBUG";
  private static final char QUOTE = '"';
  private static final char POINT = '.';
  private static int[] splitVersionName(String versionName){
    if (versionName == null || versionName.length() <= 0)return null;
    int[] versionDigits = new int[3];
    int firstIndex = versionName.indexOf(POINT);
    int lastIndex = versionName.lastIndexOf(POINT);
    System.out.println("ChangeAndroidManifestXml.splitVersionName(): firstIndex = " + firstIndex);
    System.out.println("ChangeAndroidManifestXml.splitVersionName(): lastIndex = " + lastIndex);
    versionDigits[0] = Integer.valueOf(versionName.substring(0,firstIndex));
    versionDigits[1] = Integer.valueOf(versionName.substring(firstIndex+1, lastIndex-firstIndex+1));
    versionDigits[2] = Integer.valueOf(versionName.substring(lastIndex+1));
    System.out.println("ChangeAndroidManifestXml.splitVersionName(): versionDigits[0]= " + versionDigits[0]);
    System.out.println("ChangeAndroidManifestXml.splitVersionName(): versionDigits[1]= " + versionDigits[1]);
    System.out.println("ChangeAndroidManifestXml.splitVersionName(): versionDigits[2]= " + versionDigits[2]);
    return versionDigits;
  }
  public static void main(String []args) throws IOException {
    if ( args == null ) {
      System.out.println("ChangeAndroidManifestXml.main(): args == null");
      return;
    }
    if (args.length <= 2){
      System.out.println("ChangeAndroidManifestXml.main(): Length of arguments less than 2.");
    }
    String readCharset = DEFAULT_READ_CHARSET;
    String writeCharset = DEFAULT_WRITE_CHARSET;
    if (args[3] != null || !args[3].equals("")){
      readCharset = args[3];
    }
    if (args[4] != null || !args[4].equals("")){
      writeCharset = args[4];
    }
    File readFile = new File(args[0]);
    File writtenFile = new File(args[1]);
    String versionName = new String(args[2]);
    System.out.println("ChangeAndroidManifestXml.main(): readFile = " + readFile);
    System.out.println("ChangeAndroidManifestXml.main(): writtenFile = " + writtenFile);
    System.out.println("ChangeAndroidManifestXml.main(): versionName = " + versionName);
    BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(readFile), readCharset));
    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(writtenFile), writeCharset));
    
    int []versionDigits = splitVersionName(versionName);
    if (versionDigits == null || versionDigits.length < 3){
      System.out.println("ChangeAndroidManifestXml.main(): Invalid version name: " + versionName);
      return;
    }
    int versionCode = versionDigits[0] * 65536 + versionDigits[1] * 256 + versionDigits[2];
    String line;
    boolean hasWrittenVersionCode = false;
    boolean hasWrittenVersionName = false;
    boolean hasChangedBuglyEnableDebug = false;
    
    while ((line = reader.readLine()) != null){
      if (line.startsWith("<!-")){
        System.out.println("ChangeAndroidManifestXml.main(): line = " + line);
      }
      if (hasWrittenVersionCode == false && line.contains(KEY_LINE_VERSION_CODE)){
        int leftIndex = line.indexOf(QUOTE);
        int rightIndex = line.lastIndexOf(QUOTE);
        System.out.println("ChangeAndroidManifestXml.main(): leftIndex = " + leftIndex);
        System.out.println("ChangeAndroidManifestXml.main(): rightIndex = " + rightIndex);
        System.out.println("ChangeAndroidManifestXml.main(): oldLine = " + line);
        String newVersionCodeLine = line.substring(0, leftIndex+1) + versionCode + line.substring(rightIndex) + '\n';
        System.out.println("ChangeAndroidManifestXml.main(): newVersionCodeLine = " + newVersionCodeLine);
        writer.write(newVersionCodeLine);
        hasWrittenVersionCode = true;
      } else if (hasWrittenVersionName == false && line.contains(KEY_LINE_VERSION_NAME)) {
        int leftIndex = line.indexOf(QUOTE);
        int rightIndex = line.lastIndexOf(QUOTE);
        System.out.println("ChangeAndroidManifestXml.main(): leftIndex = " + leftIndex);
        System.out.println("ChangeAndroidManifestXml.main(): rightIndex = " + rightIndex);
        System.out.println("ChangeAndroidManifestXml.main(): oldLine = " + line);
        String newVersionNameLine = line.substring(0, leftIndex+1) + versionName + line.substring(rightIndex) + '\n';
        System.out.println("ChangeAndroidManifestXml.main(): newVersionNameLine = " + newVersionNameLine);
        writer.write(newVersionNameLine);
        hasWrittenVersionName = true;
      } else if (hasChangedBuglyEnableDebug == false && line.contains(KEY_LINE_BUGLY_ENALBE_DEBUG)) {
        writer.write(line);
        writer.write('\n');
        line = reader.readLine();
        String newLine = line.replace("true", "false");
        System.out.println("ChangeAndroidManifestXml.main(): oldLine = " + line);
        System.out.println("ChangeAndroidManifestXml.main(): newLine = " + newLine);
        writer.write(newLine);
        writer.write('\n');
        hasChangedBuglyEnableDebug = true;
      } else {
        writer.write(line);
        writer.write('\n');
      }
    }
    reader.close();
    writer.close();
    if (hasWrittenVersionCode && hasWrittenVersionName  && hasChangedBuglyEnableDebug)
      System.out.println("ChangeAndroidManifestXml.main(): Writing finished.");
    else 
      System.out.println("ChangeAndroidManifestXml.main(): Writing failed.");
  }
}
