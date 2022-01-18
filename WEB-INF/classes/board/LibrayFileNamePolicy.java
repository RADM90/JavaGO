package board;
import java.io.File;
import java.io.*;
import com.oreilly.servlet.multipart.*;

public class LibrayFileNamePolicy implements FileRenamePolicy {

	public File rename(File file) {
		
        String name = file.getName();
        String body = null;
        String ext = null;
		
        int dot = name.lastIndexOf(".");
        if (dot != -1) {
             body = name.substring(0, dot);
             ext = name.substring(dot);
        }
        else {
             body = name;
             ext = "";
        }
        
        String newFileName = file.getPath().substring(file.getPath().charAt('~'), file.getPath().indexOf("_upload"))+"_"+body+ext;
        
        
        file = new File(file.getParent(), newFileName);
        
        if (createNewFile(file)) {
			return file;
		}
        
		return file;
	}

	private boolean createNewFile(File file) {
        try {
             return file.createNewFile();
        }
        catch (IOException ignored) {
             return false;
        }
   }

	
}
