# Simple tests to verify GUI File...Open...Commaand File operation

Test 1 - Confirm empty file does not get saved:

1. Open commands1.TSTool
2. Clear all commands
3. Exit TSTool
4. Inspect commands1.TSTool - should contain original content

Test 2 - Confirm empyt file does not get saved:

1. Open commands1.TSTool
2. Clear all commands
3. Open commands2.TSTool
4. Exit TSTool
5. Inspect commands1.TSTool and commands2.TSTool - both should contain original content

Test 3 - confirm that both files retain content:

1. Open commands1.TSTool
2. Open commands2.TSTool
3. Exit TSTool
4. Inspect commands1.TSTool and commands2.TSTool - should contain original content

Test 4 - confirm that auto-save is not occurring:

1. Open commands1.TSTool
2. Add comment line # Edited
3. Open commands2.TSTool 
4. When prompted, say NOT to save commands1.TSTool
5. Inspect commands1.TSTool and commands2.TSTool - should contain original content
