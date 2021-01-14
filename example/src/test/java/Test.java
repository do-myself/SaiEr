import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class Test {
    public static void main(String[] args) throws IOException {
        File file = new File("/home/mao/Mao/Documents/check1.txt");
        if(file.isFile() && file.exists()){
            FileInputStream fileInputStream = new FileInputStream(file);
            InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream);
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

            String lineStr;
            while((lineStr = bufferedReader.readLine()) != null){
                System.out.println(lineStr);
            }
        }
    }

}
