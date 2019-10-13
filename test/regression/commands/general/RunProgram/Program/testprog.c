/*
This is a simple program with command line options to test running a program.
*/

#define MAXC 256

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Prototypes
void parseCommandLine ( int argc, char **argv, char **env,
	int *exitcode, char *exitcodeenv,
	char *inputfile, char *inputfileenv,
	char *outputfile, char *outputfileenv,
	char *stderrfile, char *stderrfileenv,
	char *stdoutfile, char *stdoutfileenv );
void printUsage ();

/*
Main program.
*/
void main ( int argc, char **argv, char **env ) {

	// Initialize variables - see printUsage() for meaning of each
	int exitcode = 0;
	char exitcodeenv[MAXC] = "";
	char inputfile[MAXC] = "";
	char inputfileenv[MAXC] = "";
	char outputfile[MAXC] = "";
	char outputfileenv[MAXC] = "";
	char stderrfile[MAXC] = "";
	char stderrfileenv[MAXC] = "";
	char stdoutfile[MAXC] = "";
	char stdoutfileenv[MAXC] = "";

	// Parse the command line arguments
	parseCommandLine ( argc, argv, env,
		&exitcode, exitcodeenv,
		inputfile, inputfileenv,
		outputfile, outputfileenv,
		stderrfile, stderrfileenv,
		stdoutfile, stdoutfileenv );

	// If environment variables were requested, get those values
	if ( strlen(exitcodeenv) > 0 ) {
		if ( getenv(exitcodeenv) != NULL ) {
			exitcode = atoi(getenv(exitcodeenv));
		}
	}
	if ( (strlen(inputfileenv) > 0) && (getenv(inputfileenv) != NULL) ) {
		strcpy(inputfile,getenv(inputfileenv));
	}
	if ( (strlen(outputfileenv) > 0) && (getenv(outputfileenv) != NULL) ) {
		strcpy(outputfile,getenv(outputfileenv));
	}
	if ( (strlen(stdoutfileenv) > 0) && (getenv(stdoutfileenv) != NULL) ) {
		strcpy(stdoutfile,getenv(stdoutfileenv));
	}
	if ( (strlen(stderrfileenv) > 0) && (getenv(stderrfileenv) != NULL) ) {
		strcpy(stderrfile,getenv(stderrfileenv));
	}

	// If specified read the input file and write to the output file
	// - both must be specified
	char line[MAXC] = "";
	if ( (strlen(inputfile) > 0) && (strlen(outputfile) > 0) ) {
		FILE *inputf = fopen(inputfile, "r");
		if ( inputf != NULL ) {
			FILE *outputf = fopen(outputfile, "w");
			if ( outputf != NULL ) {
				while ( fgets(line, MAXC, inputf) != NULL ) {
					fputs(line,outputf);
				}
				fclose(outputf);
			}
			fclose(inputf);
		}
	}

	// If specified, write a file to stdout
	if ( (strlen(stdoutfile) > 0) ) {
		FILE *stdoutf = fopen(stdoutfile, "r");
		if ( stdoutf != NULL ) {
			while ( fgets(line, MAXC, stdoutf) != NULL ) {
				fputs(line,stdout);
			}
		}
		fclose(stdoutf);
	}

	// If specified, write a file to stderr
	if ( (strlen(stderrfile) > 0) ) {
		FILE *stderrf = fopen(stderrfile, "r");
		if ( stderrf != NULL ) {
			while ( fgets(line, MAXC, stderrf) != NULL ) {
				fputs(line,stderr);
			}
		}
		fclose(stderrf);
	}

	// Exit the program
	exit(exitcode);
}

/*
Parse the command line.
See the printUsage function for command line options.
*/
void parseCommandLine ( int argc, char **argv, char **env,
	int *exitcode, char *exitcodeenv,
	char *inputfile, char *inputfileenv,
	char *outputfile, char *outputfileenv,
	char *stderrfile, char *stderrfileenv,
	char *stdoutfile, char *stdoutfileenv ) {
	int i;
	for ( i = 0; i < argc; i++ ) {
		// printf ( "Parsing argv=%s\n", argv[i] );
		if ( !strcasecmp(argv[i],"--exitcode") ) {
			*exitcode = atoi(argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--exitcodeenv") ) {
			strcpy(exitcodeenv,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--inputfile") ) {
			strcpy(inputfile,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--inputfileenv") ) {
			strcpy(inputfileenv,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--outputfile") ) {
			strcpy(outputfile,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--outputfileenv") ) {
			strcpy(outputfileenv,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--stderrfile") ) {
			strcpy(stderrfile,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--stderrfileenv") ) {
			strcpy(stderrfileenv,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--stdoutfile") ) {
			strcpy(stdoutfile,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--stdoutfileenv") ) {
			strcpy(stdoutfileenv,argv[++i]);
		}
		else if ( !strcasecmp(argv[i],"--help") ) {
			printUsage();
			exit(0);
		}
	}
}

/**
Print program usage.
*/
void printUsage() {
	printf ( "\n"
	"testprog [options]\n"
	"\n"
	"--exitcode Code           Program exit code (integer).\n"
	"--exitcodeenv EnvVar      Environment variable indicating the program exit code (integer).\n"
	"--help                    Print usage.\n"
	"--stderrfile File         Read the file and print to stderr.\n"
	"--stderrfileenv EnvVar    Environment variable indicating file and print to stderr.\n"
	"--stdoutfile File         Read the file and print to stdout.\n"
	"--stdoutfileenv EnvVar    Environment variable indicating file to print to stdout.\n"
	"--inputfile File          Input file to read.\n"
	"--inputfileenv EnvVar     Environment variable indicating input file to read.\n"
	"--outputfile File         Output file to create.\n"
	"--outputfileenv EnvVar    Environment variable indicating output file to create.\n"
	"\n" );
}
