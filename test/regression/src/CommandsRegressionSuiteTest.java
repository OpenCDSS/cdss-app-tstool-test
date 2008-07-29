/*
 */

import java.io.File;
import junit.framework.TestSuite;

/**
 * This class is suffixed SuiteTest so that it gets executed by the
 * default ant test collector and to distinguish that it is a suite.
 * 
 * This could be modified to be a base class that just requires arguments for
 * declaring the rootDirectory, pattern, etc.
 * @author iws
 */
public class CommandsRegressionSuiteTest extends TestSuite {
    
    public CommandsRegressionSuiteTest() {
        super("Regression Suite");
        
        // this is like a test collector but for commands files.
        CommandsTestBuilder builder = new CommandsTestBuilder();
        // lets start here
        builder.setRootDirectory(new File("test/regression/commands/general"));
        // only run the setXXXX tests
        builder.setFileNamePattern("set.*");
        // this populates this suite
        builder.generateTestCases(this);
    }            

    public static TestSuite suite() {
        return new CommandsRegressionSuiteTest();
    }
    
}
