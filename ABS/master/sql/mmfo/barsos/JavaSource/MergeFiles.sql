create or replace and compile java source named "MergeFiles" as
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.FilenameFilter;
import java.nio.channels.FileChannel;

public class MergeFiles {
/*
lypskykh 13.08.2018
special for "Very Important Files" uploads, also could be used for any huge file ( > 4 GB)
Собирает файлы по маске из директории и мерджит в один результирующий;
*/
    public static void merge(String dirPath, String mask, String mergedFilePath) throws java.io.FileNotFoundException, IOException {
        File dir = new File(dirPath);
        final String l_mask = mask;
        // собираем файлы из каталога по маске
        File[] files = dir.listFiles(new FilenameFilter() {
            @Override
            public boolean accept(File dir, String name) {
                return name.startsWith(l_mask);
            }
        });
        // результирующий ("склеенный") файл
        File mergedFile = new File(mergedFilePath);
        // склейка
        FileOutputStream os = new FileOutputStream(mergedFilePath);
        FileChannel out = os.getChannel();
        try {
            for(int ix=0, n=files.length; ix<n; ix++) {
                FileInputStream is = new FileInputStream(files[ix]);
                FileChannel in = is.getChannel();
                try {
                    for(long p=0, l=in.size(); p<l; )
                        p+=in.transferTo(p, l-p, out);
                } 
                finally {
                    if (in != null) in.close();
                    if (is != null) is.close();
                }
          }
        } 
        finally {
            if (out != null) out.close();
            if (os != null) os.close();
        }
        // удаление "чанков"
        for (File f : files) {
            if (!mergedFile.getAbsolutePath().equalsIgnoreCase(f.getAbsolutePath()))
                f.delete();
        }
    }
}