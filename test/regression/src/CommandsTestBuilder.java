
import RTi.Util.IO.CommandLogRecord;
import RTi.Util.IO.CommandPhaseType;
import RTi.Util.IO.CommandStatus;
import RTi.Util.IO.CommandStatusProvider;
import RTi.Util.IO.CommandStatusType;
import java.io.File;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Vector;
import java.util.regex.Pattern;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import rti.tscommandprocessor.core.TSCommandFileRunner;

/**
 * Generate a List of TestCase objects by finding tstool commands files.
 * @author iws
 */
public class CommandsTestBuilder {

    private String javaRegexPattern;
    private File root;

    public CommandsTestBuilder() {
        javaRegexPattern = ".*";
    }

    /**
     * Set the pattern used to match commands file names. This
     * is a java regular expression pattern.
     * The default value is to match everything.
     * @param javaRegexPattern
     */
    public void setFileNamePattern(String javaRegexPattern) {
        this.javaRegexPattern = javaRegexPattern;
    }

    /**
     * Set the root directory to begin searching in. The default value
     * is "test" or the root of the projects test directory.
     * @param root
     */
    public void setRootDirectory(File root) {
        this.root = root;
    }

    /**
     * Fill the provided TestSuite with commands file test cases.
     * @param suite
     */
    public void generateTestCases(TestSuite suite) {
        File start = root;
        if (start == null) {
            start = new File("test");
        }
        
        if (!start.isDirectory()) {
            throw new IllegalArgumentException("root directory " + start.getAbsolutePath() + " is not a directory");
        }
        
        
        LinkedList dirs = new LinkedList();
        dirs.add(start);
        Pattern pattern = Pattern.compile(javaRegexPattern);
        while (dirs.size() > 0) {
            File dir = (File) dirs.removeFirst();
            File[] list = dir.listFiles();
            for (int i = 0; i < list.length; i++) {
                if (list[i].isFile()) {
                    String path = list[i].getAbsolutePath();
                    if (path.endsWith(".TSTool") && pattern.matcher(path).find()) {
                        suite.addTest(createTestCase(list[i]));
                    }
                } else {
                    dirs.add(list[i]);
                }
            }
        }
    }

    /**
     * A sub class could override this to provide other test implementations.
     * @param file
     * @return
     */
    protected TestCase createTestCase(File file) {
        return new CommandsFileTestCase(file);
    }

    /**
     * This class is what does to real work.
     */
    static class CommandsFileTestCase extends TestCase {

        private final File file;

        public CommandsFileTestCase(File f) {
            super(f.getName());
            this.file = f;
        }

        protected void runTest() throws Throwable {
            TSCommandFileRunner runner = new TSCommandFileRunner();
            
            try {
                runner.readCommandFile(file.getAbsolutePath());
            } catch (IOException ioe) {
                ioe.printStackTrace();
                fail("problem loading commands file " + file.getAbsolutePath());
            }
            
            try {
                runner.runCommands();
            } catch (Throwable ex) {
                ex.printStackTrace();
                fail("execution exception " + ex.getMessage());
            }
            
            Vector commands = runner.getProcessor().getCommands();
            for (int i = 0; i < commands.size(); i++) {
                Object command = commands.get(i);
                if (command instanceof CommandStatusProvider) {
                    CommandStatus status = ((CommandStatusProvider) command).getCommandStatus();
                    check(status, CommandPhaseType.INITIALIZATION);
                    check(status, CommandPhaseType.DISCOVERY);
                    check(status, CommandPhaseType.RUN);
                }
            }
        }

        private void check(CommandStatus status, CommandPhaseType phase) {
            Vector statusLog = status.getCommandLog(phase);
            for (int i = 0; i < statusLog.size(); i++) {
                CommandLogRecord record = (CommandLogRecord) statusLog.get(i);
                // you could set the CommandStatusType that causes the test to fail
                if (record.getSeverity() == CommandStatusType.FAILURE) {
                    fail(record.getProblem());
                }
            }
        }
    }
}
