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
public class WriteProjectVersion {
  private interface ChangeOption{
    int CHANGE_ANDROID_ANDROID_MANIFEST_XML = 0;
    int CHANGE_CLIENT_MAMAGER_CPP = 1;
    int CHANGE_CLIENT_PREREQUISITES_H = 2;
  }
  private static final String DEFAULT_READ_CHARSET = "GBK";
  private static final String DEFAULT_WRITE_CHARSET = "GBK";
  private static final String KEY_LINE_VERSION_CODE = "android:versionCode=";
  private static final String KEY_LINE_VERSION_NAME = "android:versionName=";
  private static final String KEY_LINE_BUGLY_ENALBE_DEBUG = "BUGLY_ENABLE_DEBUG";
  private static final String KEY_LINE_S_CLIENT_VERSION = "static const char *sClientVersion";
  private static final String KEY_LINE_DEFINE_IWORLD_DEV_BUILD = "#define IWORLD_DEV_BUILD";
  private static final char QUOTE = '"';
  private static final char POINT = '.';
  private static BufferedReader mReader;
  private static BufferedWriter mWriter;
  private static String mReadLine;

  private static int[] splitVersionName(String versionName) throws IOException {
    if (versionName == null || versionName.length() <= 0)return null;
    int[] versionDigits = new int[3];
    int firstIndex = versionName.indexOf(POINT);
    int lastIndex = versionName.lastIndexOf(POINT);
    System.out.println("splitVersionName(): firstIndex = " + firstIndex);
    System.out.println("splitVersionName(): lastIndex = " + lastIndex);
    versionDigits[0] = Integer.valueOf(versionName.substring(0,firstIndex));
    versionDigits[1] = Integer.valueOf(versionName.substring(firstIndex+1, lastIndex-firstIndex+1));
    versionDigits[2] = Integer.valueOf(versionName.substring(lastIndex+1));
    System.out.println("splitVersionName(): versionDigits[0]= " + versionDigits[0]);
    System.out.println("splitVersionName(): versionDigits[1]= " + versionDigits[1]);
    System.out.println("splitVersionName(): versionDigits[2]= " + versionDigits[2]);
    return versionDigits;
  }

  private static void changeClientPrerequisitesH(boolean annotate) throws IOException {
    boolean hasAnnotated = false;
    while (( mReadLine = mReader.readLine()) != null){
      if (hasAnnotated == false && mReadLine.contains(KEY_LINE_DEFINE_IWORLD_DEV_BUILD)){
        String newLine = "";
        if (annotate){
          newLine = "//" + KEY_LINE_DEFINE_IWORLD_DEV_BUILD + '\n';
        } else {
          newLine = KEY_LINE_DEFINE_IWORLD_DEV_BUILD + '\n';
        }
        System.out.println("changeClientPrerequisitesH(): oldLine = " + mReadLine);
        System.out.println("changeClientPrerequisitesH(): newLine = " + newLine);
        mWriter.write(newLine);
        hasAnnotated = true;
      } else {
        mWriter.write(mReadLine);
        mWriter.write('\n');
      }
    }
    if (hasAnnotated)
      System.out.println("changeClientPrerequisitesH(): Writing finished.");
    else
      System.out.println("changeClientPrerequisitesH(): Writing failed.");
  }

  private static void changeClientManageCpp(String versionName) throws IOException {
    if (versionName == null || versionName.isEmpty()){
      System.out.println("changeClientManageCpp(): Empty version name");
      return;
    }
    boolean hasWritten = false;
    while (( mReadLine = mReader.readLine()) != null){
      if (hasWritten == false && mReadLine.contains(KEY_LINE_S_CLIENT_VERSION)){
        int leftIndex = mReadLine.indexOf(QUOTE);
        int rightIndex = mReadLine.lastIndexOf(QUOTE);
        System.out.println("changeClientManageCpp(): leftIndex = " + leftIndex);
        System.out.println("changeClientManageCpp(): rightIndex = " + rightIndex);
        String newVersionNameLine = mReadLine.substring(0, leftIndex+1) + versionName + mReadLine.substring(rightIndex) + '\n';
        System.out.println("changeClientManageCpp(): oldLine = " + mReadLine);
        System.out.println("changeClientManageCpp(): newLine = " + newVersionNameLine);
        mWriter.write(newVersionNameLine);
        hasWritten = true;
      } else {
        mWriter.write(mReadLine);
        mWriter.write('\n');
      }
    }
    if (hasWritten)
      System.out.println("changeClientManageCpp(): Writing finished.");
    else
      System.out.println("changeClientManageCpp(): Writing failed.");
  }


  private static void changeAndroidManifestXml(String versionName) throws IOException {
    if (versionName == null || versionName.isEmpty()){
      System.out.println("changeClientManageCpp(): Empty version name");
      return;
    }
    int []versionDigits = splitVersionName(versionName);
    if (versionDigits == null || versionDigits.length < 3){
      System.out.println("changeAndroidManifestXml(): Invalid version name: " + versionName);
      return;
    }
    int versionCode = versionDigits[0] * 65536 + versionDigits[1] * 256 + versionDigits[2];
    boolean hasWrittenVersionCode = false;
    boolean hasWrittenVersionName = false;
    boolean hasChangedBuglyEnableDebug = false;
    while (( mReadLine = mReader.readLine()) != null){
      if ( mReadLine.startsWith("<!-")){
        System.out.println("changeAndroidManifestXml(): mReadLine = " + mReadLine);
      }
      if (hasWrittenVersionCode == false && mReadLine.contains(KEY_LINE_VERSION_CODE)){
        int leftIndex = mReadLine.indexOf(QUOTE);
        int rightIndex = mReadLine.lastIndexOf(QUOTE);
        System.out.println("changeAndroidManifestXml(): leftIndex = " + leftIndex);
        System.out.println("changeAndroidManifestXml(): rightIndex = " + rightIndex);
        System.out.println("changeAndroidManifestXml(): oldLine = " + mReadLine);
        String newVersionCodeLine = mReadLine.substring(0, leftIndex+1) + versionCode + mReadLine.substring(rightIndex) + '\n';
        System.out.println("changeAndroidManifestXml(): newVersionCodeLine = " + newVersionCodeLine);
        mWriter.write(newVersionCodeLine);
        hasWrittenVersionCode = true;
      } else if (hasWrittenVersionName == false && mReadLine.contains(KEY_LINE_VERSION_NAME)) {
        int leftIndex = mReadLine.indexOf(QUOTE);
        int rightIndex = mReadLine.lastIndexOf(QUOTE);
        System.out.println("changeAndroidManifestXml(): leftIndex = " + leftIndex);
        System.out.println("changeAndroidManifestXml(): rightIndex = " + rightIndex);
        System.out.println("changeAndroidManifestXml(): oldLine = " + mReadLine);
        String newVersionNameLine = mReadLine.substring(0, leftIndex+1) + versionName + mReadLine.substring(rightIndex) + '\n';
        System.out.println("main(): newVersionNameLine = " + newVersionNameLine);
        mWriter.write(newVersionNameLine);
        hasWrittenVersionName = true;
      } else if (hasChangedBuglyEnableDebug == false && mReadLine.contains(KEY_LINE_BUGLY_ENALBE_DEBUG)) {
        mWriter.write(mReadLine);
        mWriter.write('\n');
        mReadLine = mReader.readLine();
        String newLine = mReadLine.replace("true", "false");
        System.out.println("changeAndroidManifestXml(): oldLine = " + mReadLine);
        System.out.println("changeAndroidManifestXml(): newLine = " + newLine);
        mWriter.write(newLine);
        mWriter.write('\n');
        hasChangedBuglyEnableDebug = true;
      } else {
        mWriter.write(mReadLine);
        mWriter.write('\n');
      }
    }
    if (hasWrittenVersionCode && hasWrittenVersionName  && hasChangedBuglyEnableDebug)
      System.out.println("changeAndroidManifestXml(): Writing finished.");
    else
      System.out.println("changeAndroidManifestXml(): Writing failed.");
  }

  public static void main(String []args){
    if ( args == null ) {
      System.out.println("main(): args == null");
      return;
    }
    if (args.length <= 3){
      System.out.println("main(): Length of arguments less than 3.");
      return;
    }
    File readFile = new File(args[0]);
    File writtenFile = new File(args[1]);
    int changeOption = Integer.valueOf(args[2]);
    String arg3 = args[3];
    String readCharset = DEFAULT_READ_CHARSET;
    String writeCharset = DEFAULT_WRITE_CHARSET;
    if (args[4] != null || !args[4].equals("")){
      readCharset = args[4];
    }
    if (args[5] != null || !args[5].equals("")){
      writeCharset = args[5];
    }
    System.out.println("main(): readFile = " + readFile);
    System.out.println("main(): writtenFile = " + writtenFile);
    System.out.println("main(): changeOption = " + changeOption);
    System.out.println("main(): readCharset = " + readCharset);
    System.out.println("main(): writeCharset = " + writeCharset);
    
    try {
      mReader = new BufferedReader(new InputStreamReader(new FileInputStream(readFile), readCharset));
      mWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(writtenFile), writeCharset));
      switch ( changeOption ){
        case ChangeOption.CHANGE_ANDROID_ANDROID_MANIFEST_XML:
          changeAndroidManifestXml(arg3);
          break;
        case ChangeOption.CHANGE_CLIENT_MAMAGER_CPP:
          changeClientManageCpp(arg3);
          break;
        case ChangeOption.CHANGE_CLIENT_PREREQUISITES_H:
          changeClientPrerequisitesH(Boolean.valueOf(arg3));
          break;
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if ( mReader != null )mReader.close();
        if ( mWriter != null )mWriter.close();
      } catch (IOException ignored) {

      }
    }
  }
}
