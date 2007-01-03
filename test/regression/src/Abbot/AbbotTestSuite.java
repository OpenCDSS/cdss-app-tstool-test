import java.io.File;
import junit.extensions.abbot.ScriptFixture;
import junit.extensions.abbot.ScriptTestSuite;
import junit.extensions.abbot.TestHelper;
import junit.framework.Test;

public class AbbotTestSuite extends ScriptFixture {
    
public AbbotTestSuite(String name) 
{ 
   super(name); 
}

public static Test suite() 
{
    String dir = "test" + File.separator +
        "regression" + File.separator + "scripts";
   return new ScriptTestSuite(AbbotTestSuite.class, dir) 
   {
      public boolean accept(File file) 
      {
         String name = file.getName();
         return name.endsWith(".xml");
      }
   };
}

public static void main(String[] args) {
        TestHelper.runTests(args, AbbotTestSuite.class);
    }
}

