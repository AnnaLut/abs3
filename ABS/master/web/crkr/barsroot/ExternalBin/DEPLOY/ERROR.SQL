1.0.0 SQLBase Errors Guide
Errors that occur because of FETCH operations are documented in this section
of the Error Guide.  These errors are generally more informational than
actual errors.  A FETCH operation can be disguised by the various frontend
products, but basically, these errors are all the result of making the
sqlfet API function call.

00001 FET EOF End of Fetch

      Reason: A FETCH has attempted to fetch beyond the end of a result set.

      Remedy: None, informational only.

00002 FET UPD Row has been updated

      Reason: A FETCH in result set mode returns this code if the row has been
	      updated at least once some time in the past since the result set
	      was formed, but cannot know when or how often.

      Remedy: Add the ROWID to the select list.  The ROWID retrieved will be
	      the ROWID of the newly update row.  The application should deal
	      with rows that have been modified while part of a result set
	      appropriately.

00003 FET NF  Row has not been found

      Reason: A FETCH in result set mode returns this code if the row has been
	      deleted since the result set was formed.

      Remedy: None.  This error code is informational and lets the application
	      know that the row has been deleted from the database since the
	      current result set was formed.

00004 FET COC INTERNAL USE ONLY -- Row was updated by CURRENT OF cursor

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
errors or Application Programming Interface errors.
00101 SQL TNF Translation error not found

      Reason: The application program was attempting to convert a SQLBase
	      error return code to another "resultant" error code and the
	      original SQLBase error return code could not be found in the
	      translation file.  This error indicates that the translation
	      table was found but the error within the translation table was
	      not found.

      Remedy: Add the SQLBase error code to the error translation file or add
	      an asterisk as a global error catch-all.	The translation table
	      consists of x,y entries, where x is the SQLBase code to be
	      converted to y.  An entry of *,999, for example, will return a
	      translated error code of 999 instead of this message.  See the
	      SQLBase configuration parameter ERRORFILE= for more information
	      on the translation file and its usage.

00102 SQL STS Select buffer <number> is too small

      Reason: One of the application's sqlssb function calls set up a fetch
	      buffer that is insufficient to hold the data that was fetched.

      Remedy: Determine which select buffer is too small and increase the size
	      of that buffer.  Checking the fetch status code for each column
	      selected can help determine the column with the problem.

00103 SQL DNC OS/2 Operation did not cancel

      Reason: The application program running at a client workstation is
	      attempting to perform a cancel API database request using the
	      API function call sqlcan() and the cancel operation was not
	      successful.

      Remedy: Verify that you are using this function from an OS/2 client
	      workstation communicating with a OS/2 SQLBase Server.  Try the
	      cancel operation again.

00104 SQL DNN Attempt to fetch non-numeric data into numeric column <number>

      Reason: One of the application's sqlssb function calls set up a fetch
	      buffer that is defined as numeric but the data that was fetched
	      cannot be converted to a numeric value.

      Remedy: Modify the program or data so that non-numeric data is not
	      attempted to be fetched into a numeric format.

00105 SQL NOF Attempt to fetch into numeric column <number> that is too small

      Reason: One of the application's sqlssb function calls set up a fetch
	      buffer that is defined as numeric but the buffer provided is not
	      large enough to hold the numeric value.

      Remedy: Modify the program so the the select buffer is large enough to
	      accomodate the fetched value.

00106 SQL DTN Application Programming Error: Data type not supported

      Reason: The application program is attempting to bind or set up a select
	      buffer and is specifying a program data type that is not
	      supported by SQLBase.

      Remedy: Verify that the program data type specified in the sqlssb,
	      sqlbnn, and sqlbnd calls are valid.  Valid program data types
	      can be found in SQL.H file.

00107 SQL LNE Application Programming Error: Long operation not ended

      Reason: The application program is attempting to perform a non-long
	      operation before ending the long operation that is in progress.

      Remedy: Perform an end long operation (sqlelo) before proceeding with
	      any other operations.

00108 SQL AFE Row already fetched before enabling fetch backward

      Reason: The application program is attempting to perform an enable fetch
	      backwards (sqlefb) function call after already fetching forward.

      Remedy: Correct the application program.	The enable fetch backwards
	      (sqlefb) function must be called before any fetch is performed.

00109 SQL NOP MAIN database not open to the public

      Reason: Cannot create, delete, install, or deinstall the MAIN database.
	      Furthermore, you cannot shutdown or set the default database
	      name to the MAIN database either.

      Remedy: None.  The MAIN database is not open to the public.  The MAIN
	      database cannot be created, deleted, installed, or deinstalled.
	      The main database cannot be shutdown by a user and a user cannot
	      have the MAIN database as the default database name.

00110 SQL LNS Long columns cannot be accessed from this database

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00111 SQL APR SQL Application Programming Interface (API) recursively entered

      Reason: The application is in error by re-entering the SQL Application
	      Programming Interface (API).  This can happen under the Windows
	      environment where the application's yield function is called
	      and the application then re-enters the SQL API.  This can also
	      happen where multiple applications are sharing a cursor and
	      attempting to use the cursor simultaneously, that is, making a
	      second API request without first receiving a resulting return
	      code from the first API request.

      Remedy: Modify the Windows application(s) to prevent re-entry into the
	      SQL Application Programming Interface (API).

00112 SQL LBS Application Programming Error: Long bind already exists

      Reason: The application program is attempting to perform a bind long
	      operation and one has already been performed.

      Remedy: Correct the application program.	Verify that the long data was
	      only bound once.

00113 SQL TMB Application Programming Error: Too many binds

      Reason: The application program is attempting to perform a bind
	      operation and has exceeded the number of binds necessary.

      Remedy: Correct the application program.	The number of bind function
	      calls should equal the number of bind variables.

00114 SQL IVC Application Programming Error: Invalid bind name or bind number

      Reason: The application program is attempting to perform a bind
	      operation and it has not correctly specified the bind name or
	      the bind number.

      Remedy: Correct the application program.	Verify that the bind name
	      pointer or bind number is correctly specified.

00115 SQL PDT Invalid program data type <pdt> for select buffer #<number>

      Reason: The application program is attempting to perform a set select
	      buffer (sqlssb) function call and has specified an invalid
	      program data type.

      Remedy: Correct the set select buffer (sqlssb) function call in the
	      application program.  Verify that the program data type is one
	      of the program data types defined in the file SQL.H.

00116 SQL MLB Programming Error: Missing long bind before write long

      Reason: The application program is attempting to perform a write long
	      (sqlwlo) function call and no long data has been bound.

      Remedy: Correct the the application program.  Long data must be bound to
	      a write long operation before attempting to write it with either
	      a bind long data by number (sqlbln) or bind long data by data
	      name (sqlbld) function call.

00117 SQL IPB Invalid (null) parameter buffer pointer

      Reason: The application program has performed a sqlset API function
	      call without providing a pointer to a buffer, that is, the
	      third parameter, a pointer, is zero or null.

      Remedy: Correct the sqlset API function call by providing a pointer to
	      a buffer for the third parameter of the sqlset function call.

00118 SQL MSC Must follow a successful compile of a SELECT statement

      Reason: The application program is attempting to call sqldes, sqldsc, or
	      sqlfqn without performing a successfully compile of a SELECT
	      statement.

      Remedy: Correct the application program.	Verify that a successful
	      compile of a SELECT statement precedes the sqldes, sqldsc, or
	      sqlfqn function call.

00119 SQL DND Fetched data for column <number> is not in DATE-like or TIME-like format

      Reason: The application program is attempting to fetch data into a
	      buffer with a program data type of date (SQLPDAT) and the data
	      in the database is not defined as a DATETIME, TIMESTAMP, DATE,
	      or TIME field.

      Remedy: Correct the set select buffer (sqlssb) function call so the
	      field does not ask for a program data type of date.

00120 SQL IEV Found incorrect version of ERROR.SQL file

      Reason: SQLBase has located incompatible version of ERROR.SQL.

      Remedy: Verify the correct ERROR.SQL is in either your current
	      directory, the \SQLBASE subdirectory under the root directory,
	      in the root directory, or in a directory specified by the PATH
	      environment variable.

00121 SQL IVD Attempt to insert or update with an invalid date

      Reason: The application program is attempting to insert or update a date
	      that is invalid.

      Remedy: Verify that the date is a valid date.

00122 SQL MVC Number of SELECT columns & number of INSERT columns do not match

      Reason: The application program is attempting to perform a copy (sqlcpy)
	      function call and the number of variables in the select list of
	      the SELECT statement does not equal the number of variables
	      being inserted by the INSERT statement.

      Remedy: Correct the application program so that the number of variables
	      in the select list of the SELECT statement match the number of
	      variables in the INSERT statement.

00123 SQL CEX CURRENT OF cursor not allowed with sqlcex API function call

      Reason: A CURRENT OF cursorname clause is not permitted in a SQL
	      statement that is compiled and executed with the sqlcex API
	      function call.

      Remedy: Separate the compile and execute (sqlcex) API function call into
	      two distinct API function calls.	First, compile the SQL
	      statement using the sqlcom() API function call and execute the
	      SQL statement using the sqlexe() API function call.

00124 SQL CBR Out of memory at the client workstation (SQL CBR)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00125 SQL NTL Name parameter is too long

      Reason: The application program is attempting to perform a get number of
	      rows (sqlgnr) function call and the table name specified is too
	      large.

      Remedy: Correct the application program so that the table conforms to
	      the rules of USERID.TABLENAME where the USERID can be 8
	      characters and the TABLENAME can be any long identifier (18
	      characters or less).

00126 SQL NCC Named cursor does not exist or is not open

      Reason: The application program is attempting to execute an SQL
	      statement using the CURRENT OF cursorname or ADJUSTING
	      cursorname and the named cursor does not exist or is not open.

      Remedy: Correct the application program.	Check for previous SQL return
	      codes that may have closed or disconnected the cursor.  Correct
	      the logic of the application program to ensure that the
	      specified cursor is in fact open when this SQL statement is
	      executed.

00127 SQL NCR Cursor identified in the SQL command is not positioned on a row

      Reason: The application program is attempting to execute an SQL
	      statement using the CURRENT OF cursorname or ADJUSTING
	      cursorname and the named cursor is not positioned at a row.
	      The cursor must be positioned on the row that is to be updated,
	      deleted, or adjusted by an insert.  Note that the cursor is no
	      longer positioned on a row if the row is deleted or an index
	      column of the row is updated by another cursor in the same
	      application program.

      Remedy: Correct the logic of the application program to ensure that the
	      cursor is correctly positioned on the intended row of the target
	      table before the SQL statement is executed.  Note that the
	      cursor is not positioned on a row if FETCH returned an end of
	      fetch return code.

00128 SQL CAE Cursor name already exists or is already open

      Reason: The application program is attempting to name a cursor using the
	      set cursor name (sqlscn) function call and the specified cursor
	      name already exists.

      Remedy: Correct the logic of the application program to ensure that it
	      does not attempt to name or open a cursor that is already open.

00129 SQL CAI Out of memory at the client workstation (SQL CAI)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00130 SQL DNT Database/user/password is too large

      Reason: The database/user/password name specified at connect time or in
	      the SQL.INI configuration file is too large.

      Remedy: Correct the application program or the SQL.INI configuration
	      file to conform to the maximums.	The maximums are defined in
	      the file SQL.H.  A constant SQLMDNM defines the maximum database
	      name length as 8 and a constant SQLMSID defines the maximum
	      username or password length as 8.

00131 SQL OMS Output message size is too small

      Reason: The output message buffer is too small to hold the current
	      output message.

      Remedy: The output message buffer should never be too small to hold the
	      current output message as it should be dynamically increased if
	      necessary.  Contact your local Centura Software Corporation
	      certified technical support center for assistance.

00132 SQL IMS Input message size is too small

      Reason: The input message buffer is too small to hold the current input
	      message.

      Remedy: The input message buffer should never be too small for the
	      current input message as it should be dynamically increased if
	      necessary.  Contact your local Centura Software Corporation
	      certified technical support center for assistance.

00133 SQL IVE Invalid error return code

      Reason: SQLBase is attempting to find a error code in the error file
	      ERROR.SQL that does not exist.

      Remedy: Find out why the application program is looking up an error code
	      that does not exist.

00134 SQL CNO Could not open file 'error.sql'

      Reason: SQLBase is trying to open the file ERROR.SQL but can't find it.

      Remedy: Verify that ERROR.SQL is in either your current directory, the
	      \SQLBASE subdirectory under the root directory, in the root
	      directory, or in a directory specified by the PATH environment
	      variable.

00135 SQL ICN Invalid cursor number

      Reason: The application program is attempting to perform a function
	      call and is using an invalid cursor number.  Or, the
	      application program may be using an old or mismatching version
	      of a .DLL file.  Also, if this is a shared cursor, it may be
	      that the shared cursor is no longer valid because the owner
	      application has been terminated.

      Remedy: Correct the application program.	Verify that the cursor is
	      valid.  To verify the cursor value, print the value of cursor
	      after the connect and then before and after the function call
	      that returned this error.  Alternately, verify that the .DLL
	      being used is the current version that matches the version of
	      the database software being used.  If using a shared cursor,
	      verify that the owning application of the shared cursor has not
	      been terminated.

00136 SQL CCS Out of memory at the client workstation (SQL CCS)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00137 SQL NFC No row fetched for current of cursor

      Reason: The application program is attempting to execute an SQL
	      statement using the CURRENT OF cursorname or ADJUSTING
	      cursorname and the named cursor is not positioned at a row.
	      The cursor must be positioned on the row that is to be updated,
	      deleted, or adjusted by an insert.  Note that the cursor is no
	      longer positioned on a row if the row is deleted or an index
	      column of the row is updated by another cursor in the same
	      application program.

      Remedy: Correct the logic of the application program to ensure that the
	      cursor is correctly positioned on the intended row of the target
	      table before the SQL statement is executed.  Note that the
	      cursor is not positioned on a row if FETCH returned an end of
	      fetch return code.

00138 SQL IPI Application Programming Error: Invalid picture specified

      Reason: The picture specified in a number to picture (sqlxnp) function
	      call does not conform to rules.

      Remedy: Correct application program.  Verify that the picture conforms
	      to rules as documented in the number to picture (sqlxnp)
	      function call.  Also, check that the picture pointer accurately
	      points at the specified picture string.

00139 SQL OSP Application Programming Error: Output buffer too small

      Reason: The output buffer is too small to hold the formatted number in a
	      number to picture (sqlxnp) function call.

      Remedy: Correct application program.  Verify that the output buffer is
	      large enough to hold the specified picture.

00140 SQL DNI Database system not installed

      Reason: The application program is attempting to communicate with a
	      database and the database system is not installed.

      Remedy: Verify that DBROUTER, DBXROUTR, DBXCOMBO, DBLOCAL, OR DBXLOCAL
	      are started prior to running the application program.

00141 SQL CSS Out of memory at the client workstation (SQL CSS)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00142 SQL CBS Out of memory at the client workstation (SQL CBS)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00143 SQL IMT Invalid error message type specified

      Reason: Attempting to retrieve text associated with an error code but
	      the specified error text type is invalid.

      Remedy: Specify a valid error text type.	The valid error text types are
	      defined in SQL.H as SQLXMSG(1), SQLXREA (2), or SQLXREM (4).
	      Text types can be summed together so that multiple text types
	      are retrieved simulatenously, but a valid text type must be
	      greater than zero and less than or equal to seven (all text
	      types).

00144 SQL IRN Invalid row number

      Reason: The application program is trying to position (sqlprs) within a
	      result set at a row outside the range of the result set.

      Remedy: Verify that the row position is within the existing result set.
	      Remember, rows are not considered a part of the result set until
	      fetched.	Row positioning within a result set is relative to
	      zero, i.e., the first row in a result set is row zero.

00145 SQL OOM Out of memory at the client workstation (SQL OOM)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00146 SQL EMS Input message buffer set too small

      Reason: Attempting to set a smaller input message buffer and the
	      specified size is too small.  The size may be smaller than the
	      minimum required size or too small for the current operation
	      currently in progress.

      Remedy: None.  Don't set the input message buffer size smaller than the
	      necessary size.

00147 SQL ELE Got error looking up error message

      Reason: The application program is attempting to look up an error in the
	      error file ERROR.SQL and a problem occurred during the process.

      Remedy: Check error that occurred during the lookup and address that
	      problem.

00148 SQL DNO Specified database not on specified database server

      Reason: During an operation that requires both a SQLBase Server handle
	      and a SQLBase database cursor it was determined that the
	      database specified is not on the SQLBase Server specified.

      Remedy: Correct application so the database cursor specified is for a
	      database that resides on the specified SQLBase Server.

00149 SQL BNE Online backup not properly ended

      Reason: Attempting some other operation before ending an online backup
	      operation.

      Remedy: End online backup before doing any other operation.

00150 SQL RNE Restore not properly ended

      Reason: Attempting some other operation before ending an online restore
	      operation.

      Remedy: End the online restore before attempting any other operation.

00151 SQL MTS Cannot set input message buffer smaller than current message length

      Reason: Attempting to set the input message buffer size smaller than
	      the current input message length.

      Remedy: None.  You cannot make the input message buffer length less
	      than the current input message length.

00152 SQL DAE Database already exists

      Reason: Attempting to create or restore a database that already exists.

      Remedy: None.  Do not attempt to create or restore an existing database.

00153 SQL RAA Result set processing already active

      Reason: Attempting to start (sqlsrs) or restart (sqlrrs) result set mode
	      and result set mode is already active.

      Remedy: None.  Do not attempt to start or restart result set mode if
	      result set mode is already active.

00154 SQL RSM Result set processing must already be active

      Reason: The application program is attempting to start restriction mode
	      (sqlstr) or stop restriction mode (sqlspr) and result mode
	      (sqlsrs) has not been started.

      Remedy: Verify that the application program has previously started
	      result set mode with a sqlsrs() function call.

00155 SQL CIA Named cursor must be performing a SELECT

      Reason: Attempting to use the INSERT...ADJUSTING cursorname syntax but
	      the named cursor is not performing a SELECT.

      Remedy: Modify the application program so the named cursor is performing
	      a SELECT.

00156 SQL CTC Command does not support CURRENT OF or ADJUSTING CURSOR

      Reason: Using the CURRENT OF cursorname or ADJUSTING cursorname syntax
	      when the SQL verb does not support these clauses.

      Remedy: Modify the SQL statement attempting to use the CURRENT OF
	      cursorname clause or ADJUSTING cursorname clause.

00157 SQL NRM Named cursor is not in result set mode

      Reason: Attempting to do an INSERT ...  ADJUSTING cursorname when the
	      named cursor is not in result set mode.

      Remedy: Make a change so that the named cursor is in result set mode.

00158 SQL 058 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00159 SQL FNS Fetch backwards not allowed with result sets

      Reason: Using a fetch backwards (sqlfbk) when in result set mode.

      Remedy: Remove the fetch backwards (sqlfbk).  If you want to fetch the
	      previous row you can position (sqlprs) to the desired row when
	      in result set mode and then fetch it.

00160 SQL CSB Out of memory at the client workstation (SQL CSB)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00161 SQL ACL Out of memory at the client workstation (SQL ACL)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

00162 SQL IDN Invalid database name

      Reason: The specified database name is invalid system identifier.

      Remedy: A valid database identifier is a maximum of 8 characters which
	      start with a letter followed by letters or numbers.  System
	      identifiers include usernames, database names, and database
	      server names.

00163 SQL RNA Result sets not active

      Reason: Attempting to get the number of rows in a result set with the
	      API function call sqlnrr() or attempting to set a position
	      within a result with the API function call sqlprs() and the
	      application program is not in result set mode.

      Remedy: Correct the application.	The application must be result set
	      mode before attempting to get the number of rows in a result set
	      or before attempting to position within a result set.

00164 SQL NRS No result set

      Reason: Attempting to position within a front-end result set when the
	      application is not in result set mode.

      Remedy: Correct the application.	The application must be in front-end
	      result set mode before attempting to position within a result
	      set.

00165 SQL 065 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00166 SQL CRS Cannot create a front-end result set

      Reason: This error can occur because the client workstation is out of
	      memory, or a temporary file name could not be created, or
	      because the temporary front-end result set file could not be
	      opened.

      Remedy: Verify that there is sufficient memory at the client
	      workstation.  Verify that the FILES configuration parameter of
	      your operating system is set high enough to support multiple
	      files.

00167 SQL NET Network check error (front end)

      Reason: A network transmission problem has occurred while operating with
	      NETCHECK=1.  A network transmission error was detected at the
	      client workstation.  When the database server receives the bad
	      network reqeust an information message "Back end receives a NAK"
	      is displayed.  If the error is not recoverable, the messsage
	      "Back end give up" is displayed on the server F2 screen and this
	      error is returned to the client workstation.

      Remedy: Try again to see if the error is reproducible.  If reproducible,
	      try the same scenario on another client workstation computer to
	      double check if the problem is reproducible regardless of client
	      workstations.  If the problem is reproducible on any client
	      workstation, then the network hardware problem may be at the
	      database server computer.  Switching database server machines
	      may also help to diagnose the problem.  Check for loose cabling.

00168 SQL FMG Error in reading from temporary Front-End Result Set file

      Reason: A read error occurred reading from the front-end result set
	      temporary file on the local client workstaion.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

00169 SQL SAV Error in writing to temporary Front-End Result Set file

      Reason: Attempting to write to a front-end result set file and a disk
	      write failure has occurred at the local client workstation.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

00170 SQL DSB Requested operation is disabled for foreign DBMS

      Reason: The requested operation is not valid for the current active
	      database because front-end result sets are being employed.

      Remedy: None.  This operation cannot be performed when operating with
	      front-end result sets.

00171 SQL 071 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00172 SQL NSP API CANcel (sqlcan) is only supported under the OS/2 environment

      Reason: The API CANcel, sqlcan(), function call is not valid under the
	      current operating system.

      Remedy: None.  The API function call sqlcan() is only valid from an OS/2
	      client workstation communicating with a OS/2 SQLBase Server.

00173 SQL 073 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00174 SQL 074 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00175 SQL OLC Cannot open local client workstation file

      Reason: Attempting to copy a file from a SQLBase Server to a client
	      workstation OR attempting to copy a file from the client
	      workstation to the SQLBase Server AND the local file at the
	      client workstation cannot be opened or created.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

00176 SQL WRI Cannot write to local client workstation file

      Reason: Attempting to copy a file from a SQLBase Server to a client
	      workstation and a disk write failure has occurred at the local
	      client workstation.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

00177 SQL REA Cannot read from local client workstation file

      Reason: Attempting to copy a file from the client workstation to a
	      SQLBase Server and a disk read failure has occurred on the file
	      at the local client workstation.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

00178 SQL SFW Cannot write to remote SQLBase Server file

      Reason: Attempting to copy a file from the client workstation to a
	      SQLBase Server and a disk write failure has occurred at the
	      remote SQLBase Server machine.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

00179 SQL ISI NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00180 SQL ISH Invalid database server handle

      Reason: Attempting a SQLBase Server administrative operation and a
	      connect to a valid Server handle has not been performed.

      Remedy: Obtain a valid database server handle by connecting to a SQLBase
	      Server.  Use the SET SERVER command in SQLTalk or the API
	      function call sqlcsv() to establish a Server connection.

00181 SQL BFE Backup destination file already exists

      Reason: Backing up the database or transaction log files and the backup
	      destination file already exists.

      Remedy: Backup database or transaction log files to another disk file
	      name or remove or rename the existing file of the same name.

00182 SQL CCB Cannot create backup file

      Reason: Backing up the database and the backup destination file cannot
	      be created.

      Remedy: Determine why the database could not create the backup
	      destination file.  Verify the existence of the backup directory.
	      The BACKUP commands will not make the destination directory.
	      Run a check disk utility (CHKDSK) for the current operating
	      system to verify the status of disk.  Verify that sufficient
	      disk space is available and verify that the number of files
	      allowed open for the operating system permits the additional
	      file, that is, check the FILES= configuration parameter setting.

00183 SQL NED Not enough disk space to complete Backup or Restore operation

      Reason: Attempting to Backup the database or transaction log files or
	      attempting to Restore the database or transaction log files and
	      the system has run out of disk space.

      Remedy: Provide for additional disk space.

00184 SQL ISN Invalid server name

      Reason: The specified database server name is not valid.

      Remedy: Correct the database server name.  The maximum length of a
	      server name is 8 characters and must begin with a letter and
	      cannot contain special characters.

00185 SQL CNB Cannot open backup file on local (client) computer

      Reason: Attempting a local (client) restore database or restore
	      snapshot and the system cannot open the backup file on the
	      local (client) computer.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file name was correctly specified
	      and exists on the local (client) computer.  Verify that the
	      number of files allowed open for the operating system permits
	      the additional file, that is, check the FILES= configuration
	      parameter setting.

00186 SQL CAB Cannot allocate Backup or Restore memory buffer

      Reason: Out of memory at the remote SQLBase Server when using the
	      ON SERVER clause, otherwise the system is out of memory at the
	      client workstation.

      Remedy: Check available memory.  Attempt to make more memory available.

00187 SQL CNC Cannot connect to server

      Reason: Failure attempting to connect to the specified database server.

      Remedy: Verify that the correct database server name is used.

00188 SQL NV4 Specified operation is not valid for SQLBase 4.0 or later

      Reason: The specified operation is no longer valid for SQLBase 4.0 or
	      later.

      Remedy: The specified operation has been replaced with an alternative
	      way of doing the same operation.	Check the documentation to
	      determine the alternate technique.  The obsolete function are
	      described in the SQLBase C API Reference Manual, Chapter 5:
	      C/API Functions by Category.

00189 SQL EAS Database already exists on another database server

      Reason: Attempting to install or create a database and the named
	      database already exists on another database server.

      Remedy: Install or create the database with an alternate name or verify
	      why a database already exists with the same database name.

00190 SQL FUP CURRENT OF cursor requires SELECT FOR UPDATE

      Reason: Performing an UPDATE or DELETE with the CURRENT OF cursorname
	      clause and operating in DB2 compatibility mode where a SELECT
	      FOR UPDATE is required to use the CURRENT OF cursorname clause.

      Remedy: Modify SQL statements to either use the SELECT FOR UPDATE clause
	      or don't use the CURRENT OF cursorname clause.

00191 SQL FIP CURRENT OF cursor processing cannot be used; fetch in-progress

      Reason: Performing a DELETE or UPDATE with the CURRENT OF cursorname
	      clause and the named cursor was named after the SELECT statement
	      was already in progress.

      Remedy: Name the cursor before beginning the SELECT statement.  This is
	      caused by naming the cursor with a sqlscn function call after
	      the sqlexe function call.  By naming the cursor after the
	      execution (sqlexe), SQLBase cannot properly prepare for the SQL
	      command to allow for CURRENT OF cursorname processing.  The
	      cursor needs to be named before the sqlexe function call.

00192 SQL LAE Log files already exists

      Reason: Attempting to Restore transaction log files that already exist.

      Remedy: None.  Log files that already exist cannot be restored.

00193 SQL FRT Local result set directory name string too big

      Reason: The specified directory name for the local result set directory
	      is too large.

      Remedy: Modify the directory name so it does not exceed 40 characters.

00194 SQL MTT More than two slashes in connect

      Reason: Attempting to connect to a database and the specified database
	      name, username, and password string contains more than two
	      forward slashes.	The forward slash separates the database name,
	      username, and password, therefore a maximum of only two forward
	      slashes are necessary.

      Remedy: Modify the connect string containing the database, username, and
	      password so it is of the form "databasename/username/password".

00195 SQL ISP Invalid SET parameter

      Reason: Attempting to set a database parameter and the specified
	      parameter is invalid. The parameter may be legal for multi-user
	      servers, but illegal for single-user systems. SQLPCLN is an
	      example of this.

      Remedy: Verify and correct the specified parameter type.

00196 SQL IGP Invalid GET parameter

      Reason: Attempting to get a database parameter and the specified
	      parameter is invalid. The parameter may be legal for multi-user
	      servers, but illegal for single user systems. SQLPCLN is an
	      example of this.

      Remedy: Verify and correct the specified parameter type.

00197 SQL GNE Global cursor does not exists

      Reason: Attempting to retrieve the current global cursor and a global
	      cursor does not exist.

      Remedy: To retrieve a global cursor the global cursor must exist.  A
	      global cursor is established by setting the global cursor with
	      the API function call sqlset() using the SQLPGBC set parameter.

00198 SQL IPL Invalid SET parameter length

      Reason: Attempting a SET command with a numeric value and the specified
	      numeric value length is incorrectly specified.

      Remedy: Specify the correct numeric value length.  Generally, the
	      correct numeric length is the size of a field defined with data
	      type of SQLTDPV.	The easiest way to insure the correct length
	      is to use the length of zero whereby SQLBase will then calculate
	      the correct length.

00199 SQL NBR Backend result sets not supported

      Reason: Attempting to turn off backend result sets when backend results
	      do not exist.

      Remedy: None.  Cannot turn off backend result sets if they do not exist.

00200 SQL NTT No error translation table found

      Reason: The application program was attempting to convert a SQLBase
	      error return code to another "resultant" error code and the
	      translation table can not be found.

      Remedy: Add the ERRORFILE keyword to the SQL.INI configuration file.
	      This keyword specifies the name of the translation file.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
database operation errors.
00201 DBO NCC No compiled command

      Reason: Application program is attempting to perform a read long
	      (sqlrlo), write long (sqlwlo), long seek (sqllsk), store command
	      (sqlsto), or execute (sqlexe) without first compiling an SQL
	      statement.

      Remedy: Revise application to compile an SQL statement prior to
	      attempting the above operations.

00202 DBO NSE Not a SELECT command

      Reason: Trying to fetch or position within a result set when the SQL
	      statement is not a SELECT.

      Remedy: Revise application to compile a SQL SELECT statement prior to
	      attempting the above operations.

00203 DBO NEX Command has not been executed

      Reason: Attempting a fetch or position within a result set without a
	      successful SQL SELECT statement.

      Remedy: Revise application to compile an SQL SELECT statement prior to
	      attempting the above operations.

00204 DBO NST Fetch backward not allowed with this query

      Reason: Application program is attempting to enable fetch backwards
	      (sqlefb) when the compiled SQL SELECT statement accesses more
	      than one table.  Backward fetch calls are restricted to queries
	      on a single table.

      Remedy: Revise application to comply with fetch backward restrictions.

00205 DBO ORD ORDER BY with fetch backward

      Reason: Application program is attempting to enable fetch backwards
	      (sqlefb) when the compiled SQL SELECT statement contains an
	      ORDER BY clause and the column or columns to be ordered on are
	      not indexed.

      Remedy: Revise application to comply with fetch backward restrictions.

00206 DBO RTL Row too long for fetch

      Reason: The data being fetched is too big to fit into the input message
	      buffer which SQLBase increases dynamically but, the database
	      router has run out of memory on the client workstation computer.

      Remedy: If you are using DBROUTER.EXE, you can increase the size of the
	      SQL.INI configuration parameter called HEAP or try using the
	      extended memory version of this program called DBXROUTR.EXE if
	      extended memory is available.  If you are already using
	      DBXROUTR.EXE then you can provide more extended memory.  And
	      finally, as a last resort, you could decrease the number of
	      column being fetched.

00207 DBO CNF Command not found for retrieval

      Reason: Attempting to retrieve (sqlret) a stored command from the
	      database and the named stored command is not found.

      Remedy: Store the command before attempting the retrieve or use the
	      correct name when attempting the retrieve.

00208 DBO CIN Stored command has been invalidated

      Reason: Attempting to retrieve (sqlret) a stored command that has been
	      invalidated by the system.

      Remedy: A stored command will become invalidated by SQLBase if an index
	      or field is dropped that was available when the command was
	      originally stored.

00209 DBO STO Command has been stored

      Reason: Trying to seek a position in a long data column (sqllsk), read a
	      long data column (sqlrlo), or write a long data column (sqlwlo)
	      and the SQL command was previously stored and is not available.

      Remedy: Compile the SQL statement before attempting any of the long data
	      column operations mentioned above.

00210 DBO IFN Invalid long field number

      Reason: Attempting to read long data (sqlrlo) or seek a position within
	      long data (sqllsk) and the column number specified is not a
	      database data type of LONG VARCHAR.

      Remedy: Modify the column number so that corresponds to the long data in
	      the select list.	For a statement like

		   SELECT EMPNO, DOB, HISTORY FROM PERSONAL

	      the long data field HISTORY would be column three regardless of
	      where it was defined when performing the CREATE TABLE PERSONAL
	      (HISTORY LONG VARCHAR, DOB DATE, EMPNO SMALLINT).

00211 DBO NBK On-line backup not allowed in read only isolation level

      Reason: On-line backup is not allowed while using the read-only
	      isolation level.

      Remedy: Change the isolation level to RR, CS, or RL and retry the
	      backup.

00212 DBO SDD Cannot store a DDL command

      Reason: Attempting to store a data definition language command.

      Remedy: None.  SQLBase does not allow the storing of data definition
	      language commands.  Data definition language statements should
	      only be executed once to establish tables, indexes, views, etc.
	      Performing DDL operation in a production envinoment is
	      discouraged as it can reduce user currency.

00213 DBO NTL Stored command name <name> is too long

      Reason: Attempting to store (sqlsto), retrieve (sqlret), or drop
	      (sqldst) a stored command and the specified name is too long.

      Remedy: Correct the specified name so that it not greater than the
	      maximum bind name length, SQLMBNL (18), found in SQL.H.

00214 DBO NLB Not a long bind variable

      Reason: Attempting a write long data column operation and the SQL
	      statement is not an UPDATE or INSERT statement.  Or, the column
	      that is attempting to be updated or inserted is not a LONG
	      VARCHAR data column.

      Remedy: Do not perform a write long data operation with an SQL statement
	      that is not an UPDATE or INSERT.	If the SQL statement is an
	      UPDATE or INSERT then verify that the column number used with
	      the write long data (sqlwlo) operation is associated with a LONG
	      VARCHAR data column in the SQL statement.

00215 DBO GBY GROUP BY with fetch backward

      Reason: Attempting to enable fetch backwards (sqlefb) and the the SELECT
	      statement contains a GROUP BY clause.

      Remedy: Backward fetching is not allowed with a SELECT that contains a
	      GROUP BY clause.	Modify the application.

00216 DBO SFN Set functions with fetch backward

      Reason: Attempting a set function within a fetch backward operation.

      Remedy: None.  Set functions are not allowed with a fetch backward
	      operation.

00217 DBO RNA Recovery not active

      Reason: Attempting a rollback and recovery is not active.

      Remedy: Modify the application so that connections is made with recovery
	      active.  Use sqlcnc rather than sqlcnr.

00218 DBO STD Stored command <name> does not exist

      Reason: Attempting to drop a stored command that does not exist.

      Remedy: Modify the drop store command so that it specifies a stored
	      command name that exists.

00219 DBO FBV Cannot fetch backward on this view

      Reason: Attempting a enable fetch backward (sqlefb) function call and
	      the query is on a view.

      Remedy: Modify the application program.

00220 DBO LSK Long seek past end of long data

      Reason: The application program is trying to position within long data
	      and the position specified is beyond the end of the long data.

      Remedy: Modify the application program so that it does not position
	      beyond the end of the long data.	Remember that the position is
	      relative to zero, i.e. the first character is position zero.  To
	      determine the entire length of the long data you can perform the
	      get long data size (sqlgls) function call.

00221 DBO CNL Current command type is not Load/Unload

      Reason: The specified database parameter type can be retrieved, only if
	      currently compiled command for this cursor is a Load/Unload
	      command. In this case the currently compiled command is neither
	      a Load nor an Unload command.

      Remedy: Get this parameter only after compiling a Load/Unload command.

00224 DBO CSD Cannot open start database

      Reason: The application is trying to initialize a new database (sqlins)
	      and SQLBase cannot find the file START.DBS in the "home"
	      database directory.

      Remedy: Verify that the file START.DBS is available in the "home"
	      database directory.  A definition of the "home" database
	      directory can be found in the Installation and Operations Guide.

00225 DBO IRF Initialize read failure

      Reason: The application is trying to initialize a new database (sqlins)
	      and a read error has been encountered on the file START.DBS.

      Remedy: Try to determine why SQLBase cannot read the file START.DBS
	      before contacting your local Centura Software Corporation
	      certified technical support center.

00226 DBO IWF Initialize write failure

      Reason: The application is trying to initialize a new database (sqlins)
	      and a write error has been encountered.  This is a Fatal Error.

      Remedy: Try to determine why SQLBase cannot perform the write operation
	      before contacting your local Centura Software Corporation
	      certified technical support center.

00227 DBO IIL Invalid isolation level <invalid setting>

      Reason: Trying to set the isolation level (sqlsil) and specifying an
	      invalid isolation level.

      Remedy: The valid isolation levels are defined in the file SQL.H which
	      include the following stings (or defined contants):

		   "RR" (SQLILRR) - read repeatibility
		   "CS" (SQLILCS) - cursor stability
		   "RO" (SQLILRO) - read only
		   "RL" (SQLILRL) - release lock

00228 DBO IDP INTERNAL ERROR ONLY - Invalid database parameter type

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00229 DBO SNL SELECT must be the last cmd in chained command

      Reason: SELECT commands are allowed in a chained command but only as
	      the last command.

      Remedy: Put the select command as the last command.

00230 DBO IFD Invalid or non-existent directory name

      Reason: User specified a directory that is either invalid or
	      or the directory does not exist.

      Remedy: Make sure that you have spelt the directory name correctly
	      and it is the name of a valid, existing directory.

00231 DBO IVR Invalid version

      Reason: The application is using mismatching versions of software or the
	      database version does not correspond to the software.

      Remedy: Verify that the software and database are from the same release
	      of SQLBase.

00232 DBO DBA Must be a DBA for this operation

      Reason: Attempting an operation reserved for users with DBA authority.

      Remedy: None.  The statement cannot be executed.	Operator must have DBA
	      authority.

00233 DBO ILS Input message length too small

      Reason: SQLBase is attempting to set the input message buffer to a size
	      smaller than the minimum size required.

      Remedy: The input message buffer should never be set so small that it is
	      smaller than the minimum size required.  Contact your local
	      Centura Software Corporation certified technical support center.

00234 DBO CAI Out of memory on the database computer (DBO CAI)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00235 DBO NBI No on behave user information

      Reason: This error is only used internally by the SQLBase system.

      Remedy: Reason#18


00236 DBO ISO Invalid security options

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00239 DBO MBR Must be in result set mode to turn on restriction mode

      Reason: An application is attempting to stop restriction mode (sqlspr)
	      or start restriction mode (sqlstr) and the application is not in
	      result set mode.

      Remedy: Modify the application so that it is in result set mode before
	      attempting to start or stop restriction mode.  Restriction set
	      mode is a submode of result set mode.

00240 DBO RMA Restriction mode already on

      Reason: An application is attempting to start restriction mode (sqlstr)
	      and the application is already in restriction mode.

      Remedy: Modify the application so that it does not attempt to start
	      restriction mode while already in restriction mode.

00241 DBO RAO Restriction mode already off

      Reason: An application is attempting to stop restriction mode (sqlspr)
	      and the application is not in restriction mode.

      Remedy: Modify the application so that it does not attempt to stop
	      restriction mode while not in restriction mode.

00242 DBO RSN Result set processing not in effect

      Reason: An application is attempting to get the number of rows in a
	      result set (sqlnrr) and the application is not in result set
	      mode.

      Remedy: Modify the application so that it does not attempt to get the
	      number of rows in a result set (sqlnrr) while not in result set
	      mode.

00243 DBO CIB Out of memory on the database computer (DBO CIB)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00244 DBO DIU Deinstall with other users

      Reason: Attempting to deinstall a database while other users are
	      connected to the database.

      Remedy: Verify that everyone have logged off of the database before
	      trying to deinstall the database.

00245 DBO SDC SELECT disallowed in chained commands

      Reason: SQL SELECT statements are not allowed in a sequence of chained
	      commands.

      Remedy: Eliminate any stored SELECT commands from the chained command
	      sequence.

00246 DBO CDC CURRENT OF CURSOR in chained commands

      Reason: A DELETE or UPDATE is not allowed with the CURRENT OF cursorname
	      clause within a chained command.

      Remedy: Eliminate any stored DELETE or UPDATE statements that use the
	      CURRENT OF cursorname clause from the chained command sequence.

00247 DBO DAR DBA authority required for this operation

      Reason: Attempting to shutdown a database without DBA authority.

      Remedy: None.  Only a user with DBA authority can shutdown a database.

00248 DBO COF Cannot open the remote file <filename> on the SQLBase Server

      Reason: Attempting to open a remote file or create a directory
	      on the remote SQLBase Server and a failure has occurred.

      Remedy: Determine and correct the cause of the open failure.
	      Verify the specified file or directory path is valid.

00249 DBO SAR SYSADM authority required

      Reason: Only SYSADM can initialize a new database.

      Remedy: None.  Only SYSADM can initialize a new database.

00250 DBO CDF Cannot delete the remote file <filename> on the SQLBase Server

      Reason: Attempting to delete a remote file or remove an existing directory
	      on the remote SQLBase Server and a failure has occurred.

      Remedy: Determine and correct the cause of the delete failure.
	      Verify the specified file exists.

00251 DBO REA Read failure on remote file at the SQLBase Server

      Reason: Attempting to read a file and a disk read failure has occurred.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

00252 DBO WRI Write failure to a remote file at the SQLBase Server

      Reason: Attempting to write to a file and a disk write failure has
	      occurred.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

00253 DBO CSK Seek failure on remote file at the SQLBase Server

      Reason: Attempting to lseek within a file and a lseek failure has
	      occurred.

      Remedy: Determine and correct the cause of the disk lseek failure.  Run
	      a check disk utility (CHKDSK) for the current operating system
	      to verify the status of the disk.

00254 DBO SYS System command cannot be retrieved/executed/erased

      Reason: System commands are created and owned by the system.

      Remedy: None.

00255 DBO INC Invalid cursor number

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00256 DBO OOM Out of memory at the database computer (DBO OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00257 DBO CAL Out of memory at the database computer (DBO CAL)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00258 DBO RDO Read-only mode is disabled for this database

      Reason: Attempting to switch to Read Only Locking isolation mode and the
	      database is not prepared to handle read only transactions.

      Remedy: To use the Read Only Locking isolation mode, the database must
	      have the READONLY keyword enabled.

00259 DBO NV4 Specified operation is not valid for SQLBase 4.0 or later

      Reason: The specified operation is no longer valid for SQLBase 4.0 or
	      later.

      Remedy: The specified operation has been replaced with an alternative
	      way of doing the same operation.	Check the documentation to
	      determine the alternate technique.  The obsolete function are
	      described in the SQLBase C API Reference Manual, Chapter 5:
	      C/API Functions by Category.

00260 DBO DNS Datetime not specified with ROLLFORWARD to specific datetime

      Reason: ROLLFORWARD TO TIME specified but not datetime specified.

      Remedy: Specify the datetime when performing a ROLLFORWARD TO TIME.

00261 DBO IDS Invalid datetime <value> specified with ROLLFORWARD

      Reason: ROLLFORWARD to a specific datetime specified an invalid
	      datetime.

      Remedy: Specify the correct datetime format of "mm/dd/yy hh:mm:ss".

00262 DBO ICM INTERNAL USE ONLY - Invalid connect mode

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00263 DBO LFS Transaction Log file size <value> is too small

      Reason: Attempting to set the transaction log file size too small.

      Remedy: Modify transaction log file size being set.  Generally, the
	      minimum size is 100K, unless you are using partitioned
	      databases, in which case, the minimum size is 1MB (1000K).

00264 DBO IRM Illegal rollforward mode <value>

      Reason: The specified rollforward mode is invalid.

      Remedy: Correct the rollforward mode.  The following modes are the valid
	      choices: (1)  SQLMEOL  Rollforward to end of all available logs.
		       (2)  SQLMEOB  Rollforward to end of backup.
		       (3)  SQLMTIM  Rollforward to a specified time.

00265 DBO CTI Checkpoint time interval of <value> minutes is too long

      Reason: Cannot set the checkpoint interval greater than 30 minutes.

      Remedy: Use a valid checkpoint interval not greater than 30 minutes.

00266 DBO RFS Get Next Log is only valid after Rollforward has been initiated

      Reason: A Get Next Log command has been issued before beginning the
	      Rollforward recovery process.

      Remedy: Start Rollforward recovery before doing a Get Next Log.

00267 DBO NSD Not connect to the same database

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00268 DBO HSS History file size must be a positive value

      Reason: Cannot set the History file size to zero or less than zero.

      Remedy: Correct history file size setting to be a positive value.

00269 DBO NSC Stored command cannot be found.

      Reason: Command is missing from SYSCOMMANDS.

      Remedy: None.

00270 DBO RFI Rollforward interrupted - must restore database backup again

      Reason: The Rollforward operation has been interrupted.

      Remedy: Restart the restore of database backup again.

00271 DBO LNE Logging not enabled

      Reason: Attempting a Backup and Recovery operation, Rollback operation,
	      or attempting to set the logfilesize, nextlog, or spanlimit and
	      transaction logging (recovery) is not enabled.

      Remedy: Backup and Recovery, and transaction Rollbacks are not possible
	      with transaction logging (recovery) turned off.  Connect with
	      recovery ON to perform Backup and Recovey, and transaction
	      Rollbacks.  Also, you cannot set the logfilesize, nextlog, or
	      spanlimit with recovery turned off.

00272 DBO CAF Out of memory on the database computer (DBO CAF)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00273 DBO COP Database open copy file failure

      Reason: Attempting to open an existing file and a failure has occurred.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

00274 DBO CCR Database create copy file failure

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

00275 DBO NPW No password can be retrieved for connecting to database.

      Reason: Attempts to read the user's password failed.

      Remedy: Check the password to the database and retry later.

00276 DBO FCS Cannot generate connection string

      Reason: The system failed to construct a connection string.

      Remedy: None.

00277 DBO LBD Log backup disabled

      Reason: Attempting to backup logs or get the next log or set the next
	      log and transaction logging is disabled.

      Remedy: Enabled logging before attempting to backup logs, get the next
	      log, or set the next log.

00278 DBO LCU Long varchar column was updated or deleted

      Reason: The row from which you are fetching has been updated or
	      deleted between the time you fetched the non-long varchar
	      data and the time you issued the read long request.

      Remedy: Re-fetch the row to get the most up-to-date data or to find
	      out that the row has been deleted.  If you receive this error
	      frequently, review your application for possible data
	      contention problems or poor sequencing of operations
	      (SELECT/FETCH/DELETE/UPDATE).  Try to prevent other
	      applications, or cursors in the same transaction, from
	      changing data while your are fetching it.  For example,
	      running the fetch operation in RR or CS isolation mode
	      prevents other applications from updating or deleting data
	      that you have accessed.  Be aware that these isolation levels
	      offer no such protection against a cursor from the same
	      transaction.

00279 DBO SLS Transaction span limit too small

      Reason: Trying to set the transaction span limit to less than zero.

      Remedy: Set the transaction span limit using a valid number.  The
	      transaction span limit is the number of log files an active
	      transaction is allowed to span.  Any transaction that violates
	      the limit is rolled back.  A span limit of zero indicates that
	      transaction span limit checking is disabled.

00280 DBO ITO Invalid timeout value

      Reason: Trying to set an invalid database lock timeout value.

      Remedy: Set the lock wait timeout value using a valid number.  The
	      number represent seconds to wait for a database lock to be
	      acquired.  After the specified time has elapsed, the transaction
	      is rolled back.  The default setting is 300 seconds.  Valid
	      timeout values are:
		 1 to 1800 Seconds to wait for a lock (1 second to 30 minutes)
		-1	   Wait forever for a lock held by another transaction
		 0	   Never wait for a lock and immediately return a
			   timeout error (nowait locking).

00281 DBO IVS Invalid version string

      Reason: Attempting to set an invalid version number.

      Remedy: Set the version number with a valid version number string.
	      For example, "6.0.0".

00282 DBO RNS INTERNAL USE ONLY - Request not supported

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00283 DBO LFL Transaction Log file size <value> is too large

      Reason: Attempting to set the transaction log file size too large.

      Remedy: Modify transaction log file size being set.
	      The mamixum size is  2,097,152K.

00284 DBO LBM LOGBACKUP must be ON for BACKUP DATABASE; try BACKUP SNAPSHOT

      Reason: Transaction log backup must be ON for a BACKUP DATABASE

      Remedy: Try doing a BACKUP SNAPSHOT.

00285 DBO NSR Cannot store SELECT commands or procedures in restriction mode

      Reason: Cannot store a SELECT statement or procedures while operating
	      in restriction mode.

      Remedy: Store the SELECT command or procedure while not operating in
	      restriction mode.

00286 DBO CBL Next Log# <value> less than the Next Log# <value> that should be backed up

      Reason: Specifying log files in an incorrect fashion.  Subsequent log
	      files should always have the next higher transaction log file
	      numbers.

      Remedy: Specify the correct next transaction log file.

00287 DBO CBG Next Log# <value> greater than current active log # <value>

      Reason: Specifying log files in an incorrect fashion.  A subsequent log
	      file can never be greater than the current active log file.

      Remedy: Specify the correct next transaction log file.

00288 DBO IFE Database file size extension too small

      Reason: The specified database file size extension is too small.

      Remedy: Correct database file size extension size.  If you are using
	      partitioned databases, the minimal size is 1024, otherwise the
	      size can be any positive value.

00289 DBO RSR Cannot retrieve SELECT stored command/procedure <user>.<name> in restriction mode

      Reason: A SQL SELECT statement or stored procedure cannot be
	      retrieved when operating in restriction mode.

      Remedy: Retrieve the stored SELECT statement or procedure while NOT
	      in restriction mode.

00290 DBO NDB Invalid NEWDB value

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00291 DBO BME LOGBACKUP mode already enabled

      Reason: Trying to set LOGBACKUP mode ON and the mode is already ON.

      Remedy: None.  Informational only.

00292 DBO BMD LOGBACKUP mode already disabled

      Reason: Trying to set LOGBACKUP mode OFF and the mode is already OFF.

      Remedy: None.  Informational only.

00293 DBO FEV (Incompatible) client cannot invoke attempted function

      Reason: Client and server do not have compatible versions for launching
	      the attempted function/feature.

      Remedy: Use a configuration consisting of compatible client and server.

00294 DBO NOL RECOVERY is OFF, there is no log

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00295 DBO NSS Not a server session

      Reason: Trying to compile or execute a server command in a
	      non-server session

      Remedy: Use a server session to compile or execute a server command.

00296 DBO IVC Backend code page is not same, check SQL.INI file and country.sql

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00297 DBO CSC Cannot store the command, <command name>

      Reason: Trying to store a server command

      Remedy: Run the command directly instead of storing the command and
	      executing it later.

00298 DBO CRM Cannot restore/rollforward MAIN while partitioned db enabled

      Reason: While partitioned databases are enabled the MAIN database
	      must be available to SQLBase to access partitioned databases.
	      The availability of the MAIN database prevents it from being
	      restored from a backup.

      Remedy: Disconnect all clients accessing partitioned databases and
	      disable partitioned databases.

00299 DBO IOL Invalid optimizer level <value>

      Reason: Optimizer level must be 1 or 2.

      Remedy: Use correct optimizer level, 1 or 2.

00300 DBO ITV Invalid command timeout value

      Reason: Trying to set an invalid command timeout value.

      Remedy: Set the command timeout value using a valid number.  The number
	      represents the maximum seconds allowed to perform a compile and
	      execute for a command.  After the specified time has elapsed,
	      the command is aborted. The default setting is 0 seconds which
	      disables the command timeout check.
	      Valid timeout values are:
	      1 to 43,200 Seconds before timing out (1 second to 12 hours)
	      0 	  Never timeout.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are errors that
generally occur during the execution of a SQL operation.
00301 EXE NCH Can only modify CHAR data type

      Reason: Attempting to alter the size of an existing column and the
	      column is not defined as CHAR or VARCHAR.

      Remedy: Do not attempt to change to size of a column that is not defined
	      as CHAR or VARCHAR.

00302 EXE NAV ALTER privilege not allowed on views

      Reason: Cannot grant ALTER privileges on a VIEW

      Remedy: None.  Views cannot be altered, only tables can be altered.
	      Therefore the granting of ALTER on a VIEW is not allowed.

00303 EXE CRI Cannot create a VIEW using ROWID column

      Reason: Trying to use the ROWID column in a VIEW.

      Remedy: None.  The ROWID is not allowed as a column within a VIEW.

00304 EXE CDT Cannot drop another's table

      Reason: A user is attempting to drop a table that s/he did not create
	      and s/he does not have DBA authority.

      Remedy: None.  Do not attempt to drop someone else's table unless you
	      have DBA authority.

00305 EXE CDI Cannot drop indexed column <column name>

      Reason: Attempting to drop a column that has an index on it.

      Remedy: Drop all indexes associated with the column before dropping the
	      column.

00306 EXE CDS Cannot drop system information <column, index, or table name>

      Reason: Attempting to drop a column, index, or table that is considered
	      system information.

      Remedy: None.  Do not attempt to drop columns, indexes, or tables that
	      are considered system catalog information.

00307 EXE STO Cannot execute after store

      Reason: Attempting to execute a command that was just previously stored.
	      You cannot execute a command that was just stored.

      Remedy: You must retrieve the stored commands and then execute it or
	      compile the command after storing and execute it.  A stored
	      command is stored in the database and is not available for
	      immediate execution until it is retreived.

00308 EXE CIL Cannot index long data

      Reason: Attempting to create an index on a column that is defined as
	      long data.

      Remedy: None.  You cannot create an index on a long data column.

00309 EXE MSC Cannot modify system column <column name>

      Reason: Attempting to modify a system column.

      Remedy: None.  You cannot modify a system column.

00310 EXE RSC Cannot rename system column <name>

      Reason: Attempting to rename a system column.

      Remedy: None.  You cannot rename a system column.

00311 EXE RST Cannot rename system table <table name>

      Reason: Attempting to rename a system table.

      Remedy: None.  You cannot rename a system table.

00312 EXE RCD Cannot revoke connect from a DBA <user name>

      Reason: Attempting to revoke connect from a user with DBA authority.

      Remedy: None.  SYSADM must revoke DBA authority before being able to
	      revoke connect authority.

00313 EXE RND Cannot revoke DBA from a non-DBA <user name>

      Reason: Attempting to revoke DBA authority from a user that does not
	      have DBA authority.

      Remedy: None.  You cannot revoke an authority a user does not hold.

00314 EXE RRD Cannot revoke resource from a DBA <user name>

      Reason: Attempting to revoke RESOURCE authority from a user that has DBA
	      authority.

      Remedy: None.  You cannot revoke RESOURCE authority from a user who has
	      DBA authority.  Having DBA authority automatically means that
	      s/he has all privileges on any table in the database, including
	      the right to grant, modify, or revoke the privileges of any
	      other user in the database.  A DBA may not, however, create new
	      users, nor may a DBA change the passwords or authority levels of
	      existing users.  These privileges are restricted to SYSADM.
	      Having DBA authority means you also have RESOURCE authority.

00315 EXE CAE Column <column name> already exists

      Reason: Attempting to add or rename a column and the column name already
	      exists.

      Remedy: Use a different column name from the one currently being used in
	      the ALTER TABLE statement.

00316 EXE CST Column <name> specified twice

      Reason: Specified a column with a duplicate column name.

      Remedy: Do not use the column name that has already been used.

00317 EXE DND Data is not a date

      Reason: Attempting to insert or update a column defined as DATE, TIME,
	      DATETIME, or TIMESTAMP and the data attempting to be inserted or
	      updated is not a date.

      Remedy: Check data to verify that the data being inserted or updated is
	      a date.

00318 EXE DNN Data is not numeric

      Reason: Attempting to insert or update a column defined as SMALLINT,
	      INTEGER, DECIMAL, FLOAT, or NUMBER and the data attempting to be
	      inserted or updated is nonnumeric.

      Remedy: Check data to verify that the data being inserted or updated is
	      numeric.

00319 EXE IAE Index <index name> already exists

      Reason: The CREATE INDEX statement sought to create an index when there
	      is already an index with the same name defined.

      Remedy: The CREATE INDEX statement cannot be executed.  No new index was
	      created, and the existing index was not altered or modified.
	      Either the existing index must be dropped or another name must
	      be chosen for the new index.

00320 EXE IDE Index <index name> does not exist

      Reason: Attempting a DROP INDEX, UPDATE STATISTICS ON INDEX or
	      CHECK INDEX and the specified index name does not exist.

      Remedy: Find correct index name and retry.  All current index names can
	      be determined by querying the SYSINDEXES tables.

00321 EXE VTL Insert/update value is too large

      Reason: The application is attempting to execute an UPDATE, INSERT, or
	      COMMENT ON and the update or insert value, or the comment is too
	      big for the column as it was defined at CREATE TABLE time.

      Remedy: Identify which column exceeds the defined length and correct the
	      application program.  When binding data, be sure the specified
	      bind variable lengths does not exceed the defined length in the
	      database.  If using a program data type of string (SQLPSTR), be
	      sure that you have provided the null terminating character so
	      that SQLBase can calculate the data length accurately.  Check
	      the length of the object column, and correct the program or SQL
	      statement so that the length of the UPDATE, INSERT, or COMMENT
	      ON string does not exceed the maximum.

00322 EXE IDV Invalid data for this view

      Reason: Attempting to insert or update through a view and the view
	      definition rejects the data because it does not conform to the
	      view definition.	View checking is provided if the optional WITH
	      CHECK OPTION clause if used when creating the view.

      Remedy: Examine the view definition to determine why the requested
	      INSERT or UPDATE was rejected.  Note that this may be a
	      data-dependent condititon.

00323 EXE IVN Invalid number

      Reason: Attempting to convert character data to numeric data and the
	      conversion fails.

      Remedy: Verify that numeric data is being provided for conversion.

00324 EXE IBV Invalid program bind variable

      Reason: The application is attempting to use a bind variable that was
	      not bound with a sqlbnn or sqlbnd function call.

      Remedy: Bind all bind variables with either a sqlbnn or sqlbnd function
	      call before attempting to execute the statement (sqlexe).

00325 EXE SSF INTERNAL USE ONLY - expected next row but did not find one

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00326 EXE NGA No grant authority

      Reason: Attempting to grant or revoke connect authority, or grant table
	      privileges and the user does not have the authority.  Only
	      SYSADM can grant or revoke connect authority.  Table privileges
	      can only be granted by users who have the authority to do so.  A
	      user with DBA authority may grant privileges on any tables or
	      views in the database.  A user with RESOURCE authority may grant
	      privileges only on tables created by him or on views based
	      completely on tables created by him.  A user with only CONNECT
	      authority may not grant privileges.  Nor does user possess
	      privileges to any tables or views unless the user is explicitly
	      granted such privileges via a GRANT statement.

      Remedy: None.  You can not grant or revoke connect authority, or grant
	      table privileges when the user does not have the authority.

00327 EXE RSP Result set not allowed with procedure

      Reason: Result set not allowed with procedure

      Remedy: Do not use result set with procedure.

00328 EXE NRE No resource authority

      Reason: Attempting to create a table and the user does not possess
	      resource authority to create tables.

      Remedy: None.  A user must possess resource authority to create tables,
	      to drop those tables, and to grant, modify or revoke privileges
	      to those tables for valid users of the database.

00329 EXE NRA No revoke authority

      Reason: Attempting to revoke RESOURCE authority, table privileges, or
	      DBA authority and the user does not have the authority.  Only
	      SYSADM can revoke DBA or RESOURCE authority.  Table privileges
	      can only be revoked by users who have the authority to do so.
	      A user with DBA authority may revoke privileges on any tables or
	      views in the database.  A user with RESOURCE authority may
	      revoke privileges only on tables created by him or on views that
	      are based completely on tables created by him.  A user with only
	      CONNECT authority may not revoke privileges.

      Remedy: None.  You can not revoke RESOURCE authority, table privileges,
	      or DBA authority when the user does not have the authority.

00330 EXE NCN Not a column

      Reason: Attempting to create a view and a named column does not exist
	      in the target table or view.

      Remedy: Modify the CREATE VIEW statement so that all named columns
	      correspond to columns in the base table or base view.

00331 EXE NEV Not enough non-null values

      Reason: Attempting to execute an INSERT statement and there exist
	      columns defined as NOT NULL which have not been provided values.

      Remedy: Modify the INSERT statement so that a value exists for each
	      column defined in the CREATE TABLE statement as NOT NULL.

00332 EXE PEU Privileges exist for user <name>

      Reason: Attempting to execute a REVOKE CONNECT FROM a specific user and
	      the named user has been granted table privileges.

      Remedy: Revoke the user's privileges before attempting to revoke the
	      user's connect authority.

00333 EXE SNI Size of CHAR not increased

      Reason: Attempting to execute a ALTER TABLE with a MODIFY clause and the
	      length of a character column is attempting to be decreased.

      Remedy: Modify the ALTER TABLE statement.  The length of a character
	      column may be increased but not decreased.

00334 EXE RUN Command not allowed in SQLBase RUNTIME database engine

      Reason: The specified command is not allowed with the RUNTIME system.

      Remedy: None.  The RUNTIME system does not allow certain commands.

00335 EXE SYT Table, view, or synonym, <name> does not exist

      Reason: Attempting a CHECK TABLE, CREATE SYNONYM or DROP SYNONYM
	      and the specified table name or view name does not exist.

      Remedy: Modify the CHECK TABLE, CREATE SYNONYM or DROP SYNONYM
	      statement by specifying an existing table name or view name.

00336 EXE NEP No execute privilege on <object> <creator>.<name> for user <username>.

      Reason: User does not have execute privilege.

      Remedy: Get execute privilege from DBA or owner and re-issue the
	      command.

00337 EXE TEU Table(s) exist for specified user <name>

      Reason: Attempting to execute a REVOKE CONNECT FROM a specific user and
	      the tables exist for the name user.

      Remedy: Drop the tables for the name user before attempting to revoke
	      the user's connect authority.

00338 EXE TVS Table, view, or synonym <name> already exists

      Reason: Attempting to execute a CREATE VIEW or ALTER TABLE with a RENAME
	      TABLE clause and the table name or view name already exists.

      Remedy: Modify the CREATE VIEW or ALTER TABLE statement to use a unique
	      name.

00339 EXE TMC Too many columns

      Reason: Attempting to execute a CREATE VIEW and the number of columns
	      exceeds the maximum number of columns allowed for any table or
	      view.

      Remedy: Modify the CREATE VIEW statement so it does not exceed the
	      maximum number of columns allowed.

00340 EXE UNE User <name> does not exist

      Reason: Attempting to execute a CREATE TABLE, CREATE VIEW, GRANT table
	      privilege, or REVOKE and the name user does not exist.

      Remedy: Modify the statement to use an existing user.

00341 EXE VIN INSERT/UPDATE value is NULL & target column cannot contain nulls

      Reason: The update or insert value was NULL, but the target column was
	      declared as NOT NULL in the table definition.  Consequently,
	      null values cannot be inserted into that column, and values in
	      that column cannot be set to NULL by an update.

      Remedy: The statement cannot be execute.	Examine the definition of the
	      target table to determine which columns of the table have the
	      NOT NULL attribute, and correct the SQL statement accordingly.
	      DB2 treats "empty" strings and NULL strings different whereas
	      SQLBase does not distinguish between an "empty" string and a
	      NULL string.  This problem may be occurring because a CHAR or
	      VARCHAR column has been defined as NOT NULL WITH DEFAULT and
	      SQLBase use a one character space for the DEFAULT.  For DB2
	      compatibility you may want to consider NOT using the NOT NULL
	      WITH DEFAULT characteristic for CHAR or VARCHAR columns.

00342 EXE WPS INTERNAL USE ONLY - Wait/post

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00343 EXE ICR Invalid ROWID

      Reason: Application has submitted an invalid rowid while using the
	      ROWID=[rowid] constraint in the where clause.  SQLBase has
	      determined this rowid cannot be matched with any row within the
	      database.  Valid rowid's are retrieved using SELECT ROWID.

      Remedy: Correct the rowid by retrieving the correct rowid using SELECT
	      ROWID.

00344 EXE CAS Out of memory at the database computer (EXE CAS)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00345 EXE IOP Invalid old password

      Reason: Attempting to execute an ALTER PASSWORD and the old password is
	      not valid.

      Remedy: Modify the ALTER PASSWORD statement to use a valid old password.

00346 EXE NVL NULL value encountered in column <name>

      Reason: Attempting to execute a ALTER TABLE with a MODIFY clause.  The
	      statement attempts to change a column which contains NULL values
	      to a column with a definition of NOT NULL.

      Remedy: Modify the ATLER TABLE statement or modify the data.  If a
	      column contains NULL values, you will not be able to redefine
	      the column as NOT NULL.

00347 EXE EFS External function <name> already exists as a stored command or stored procedure

      Reason: The specified external function name already exists as a stored
	      command name or as a stored procedure.

      Remedy: Use a different external function name.  External function names
	      cannot be the same as an existing stored command, stored
	      procedure, or external function.

00348 EXE CNA Current of cursor not allowed with this query

      Reason: The CURRENT OF cursorname clause is not allow with this query.

      Remedy: None.  CURRENT OF cursorname cannot be used with this SELECT
	      statement.  The CURRENT OF cursorname clause is not allowed
	      under certain conditions, including a query which contains a
	      join, GROUP BY, DISTINCT, aggregate functions, or a UNION.

00349 EXE CDD Current cursor is on a different database

      Reason: A CURRENT OF cursorname clause is referring to a cursor which is
	      currently referencing the same table name but in different
	      databases.  For example: With a first cursor named C1 connected
	      to the PAYROLL database, it is performing a select like:

		   SELECT * FROM EMP

	      and with a second cursor connected to the PERSONNEL database, it
	      is attempting to perform an update or delete similiar to:

		   UPDATE EMP SET BONUS = 100 WHERE CURRENT OF C1

      Remedy: Revise SQL statements so that both statements refer to a table
	      named in the same database.

00350 EXE DBA DBA authority required for this operation

      Reason: Attempting to execute a CREATE or DROP a
	      public table/external function SYNONYM synonym or
	      UPDATE STATISTICS on DATABASE and the user does not have
	      DBA authority.

      Remedy: None.  A user cannot CREATE or DROP a
	      public SYNONYM\external function synonym or
	      UPDATE STATISTICS on DATABASE without DBA authority.

00351 EXE CDA Cannot drop all columns

      Reason: Attempting to execute a ALTER TABLE with a DROP column clause
	      and the column is the lone remaining column in the table.

      Remedy: None.  You cannot drop the the last column of a table.  Each
	      table must have at least one column.  If necessary, drop the
	      entire table with a DROP TABLE statement.

00352 EXE KTL Index key size too large

      Reason: Attempting to execute a CREATE INDEX and the key size exceeds
	      the maximum key size allowed.

      Remedy: Modify the index attempting to be created.  The maximum size of
	      an index is limited occuring to a formula documented in the SQL
	      Language Reference manual under the CREATE INDEX statement.

00353 EXE NSY Object <name> specified in DROP SYNONYM is not a synonym

      Reason: Attempting to execute a DROP SYNONYM and the named synonym is
	      not a synonym but a table, view or external function name.

      Remedy: Modify the DROP SYNONYM statement to use a synonym name or if
	      you really want to drop a table or external function then use
	      a DROP TABLE or DROP EXTERNAL FUNCTION statement.

00354 EXE NVW Object <name> specified in DROP VIEW is not a view

      Reason: The name specified in the DROP VIEW statement identifies a
	      table, rather than a view.  The DROP VIEW statement can only
	      have a view as its target.  The DROP TABLE statement must be
	      used to drop a table.

      Remedy: Correct the DROP VIEW statement so the view name is correctly
	      specified (with the proper qualifier).  If the intent is to
	      drop a table, then the DROP TABLE statement must be used.

00355 EXE NTB The object <name> specified in DROP TABLE is a view name.

      Reason: The name specified in the DROP TABLE statement identifies a
	      view, rather than a table.  The DROP TABLE statement can only
	      have a table as its target.  The DROP VIEW statement must be
	      used to drop a view.

      Remedy: Correct the DROP TABLE statement so that the table name is
	      specified correctly (with the proper qualifier).	If the intent
	      is to drop the specified view, then the DROP VIEW statement must
	      be used.

00356 EXE MBC Function parameters must be constants for index <index name>

      Reason: Attempting to execute a CREATE INDEX statement the index is
	      using @Functions that are not constants.

      Remedy: Modify the CREATE INDEX statement so that all function
	      parameters are constants.

00357 EXE PTL Function parameter too large for column <name>

      Reason: Attempting to execute a CREATE INDEX statement the index is
	      using @Functions that are too large.

      Remedy: Modify the CREATE INDEX statement so that all function
	      parameters are not larger than the maximum data value length of
	      254 characters.

00358 EXE NIR Numeric date value not in range

      Reason: Attempting to convert either a character string or a number to a
	      data format and the converted date is not within an acceptable
	      date range.

      Remedy: Verify that the dates being put in the database are between
	      January 1, 0001 and December 31, 9999.

00359 EXE OCT Table referenced by other cursor

      Reason: One cursor is attempted to modify or drop a table when another
	      offending cursor is currently using that table.

      Remedy: Commit, disconnect or have the offending cursor compile a
	      statement using a different table.

00360 EXE RSD Cannot revoke DBA from SYSADM

      Reason: Attempting to execute a REVOKE DBA authority from a specific
	      user and the user happens to be SYSADM.

      Remedy: None.  You cannot revoke DBA authority from SYSADM.

00361 EXE ACI ADJUSTING CURSOR not allowed with embedded SELECT

      Reason: Attempting to execute an INSERT using ADJUSTING cursor name
	      when the INSERT statement has an embedded SELECT statement.

      Remedy: None.  You cannot use the ADJUSTING cursor clause with an
	      INSERT statement that uses an embedded SELECT statement.

00362 EXE DHR User <user name> does not have RESOURCE authority

      Reason: Attempting to execute a REVOKE RESOURCE authority statement
	      from a user that does not have resource authority.

      Remedy: None.  You cannot revoke an authority from a user when the user
	      does not have that authority.

00363 EXE TVC Too many view columns defined

      Reason: Attempting a CREATE VIEW and the number of columns defined in
	      the new target view exceed the number of column selected from
	      the source table or view.

      Remedy: Correct the SQL CREATE VIEW statement.  The number of columns
	      select to formed the view must match the number of columns
	      defined in the new view.

00364 EXE TSE Too many view select expressions

      Reason: Attempting a CREATE VIEW and the number columns selected from
	      the source table or view exceed the number of columns defined in
	      the new target view.

      Remedy: Correct the SQL CREATE VIEW statement.  The number of columns
	      select to formed the view must match the number of columns
	      defined in the new view.

00365 EXE PNO Privileges not owned for this user <name>

      Reason: Attempting to execute a REVOKE table privilege from a specific
	      user and the user does not have the name privileges.

      Remedy: None.  You cannot revoke a table privilege that does not exist.

00366 EXE IIF @function not supported as an index

      Reason: Trying to specify a @function in the creation of an index and
	      this particular @function is not supported by SQLBase as a
	      possible index.

      Remedy: None.  This @function is not supported as an index.

00367 EXE SNR Small integer value not in range

      Reason: A small integer value is not within the acceptable range of
	      SMALLINT values.

      Remedy: Correct small integer value so that it is within the range of an
	      acceptable SMALLINT values.  An SMALLINT value can have up to 5
	      digits of precision: -32,768 to +32,767

00368 EXE INR Integer value not in range

      Reason: An integer value is not within the acceptable range of INTEGER
	      values.

      Remedy: Correct integer value so that it is within the range of an
	      acceptable INTEGER value.  An INTEGER value can have up to 10
	      digits of precision: -2,147,483,648 to +2,147,483,647

00369 EXE CCD Current cursor is on a different table

      Reason: A CURRENT OF cursorname clause is referring to a cursor which is
	      currently referencing a different table.	For example: With one
	      cursor named C1 connected to the PAYROLL database, it is
	      performing a select like: SELECT * FROM SALARY and with a second
	      cursor connected to the PAYROLL database, it is attempting to
	      perform an update or delete similiar to:
		   UPDATE EMP SET BONUS = 100 WHERE CURRENT OF C1

      Remedy: Revise SQL statements so that both statements refer to the same
	      table named in the same database.

00370 EXE OOC Table can have only one clustered hashed index

      Reason: A table can only have one CLUSTERED HASHED index.

      Remedy: None.  Only one CLUSTERED HASHED index can be created for any
	      one table.

00371 EXE TNE Clustered index can only be created on an empty table

      Reason: A clustered hashed index can only be created on an empty table.

      Remedy: Unload the target table.	Recreate the table and create the
	      clustered hashed index before inserting any data back into the
	      table.

00372 EXE IPD A clustered index was previously defined on this table

      Reason: A table can only have one CLUSTERED HASHED index.

      Remedy: None.  Only one CLUSTERED HASHED index can be created for any
	      one table.

00373 EXE NIV INDEX privilege not allowed on views

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00374 EXE NNE NOT NULL column <name> must be added only to an empty table

      Reason: A NOT NULL column cannot be added to table that already has
	      existing rows because if it could then those columns of the
	      existing rows would have NULL values in columns defined as NOT
	      NULL which would violate the definition.

      Remedy: Add the column without defining the column as NOT NULL.  Update
	      the existing rows by putting data in the newly created columm
	      and then ALTER the column to NOT NULL.

00375 EXE EFE External function <name> already exists

      Reason: The specified external function name already exists as an
	      external function or external function synonym.

      Remedy: Use a different external function name.  External function names
	      cannot be the same as an existing stored command, stored
	      procedure, external function or external function synonym.

00376 EXE BEF External function <name> does not exist

      Reason: The specified external function name does not exist.

      Remedy: None, or use the correct name.  The external function name may
	      be misspelled or incorrect.

00377 EXE CUI Cannot update statistics of a CLUSTERED HASHED INDEX

      Reason: Cannot update the index statistics on a CLUSTERED HASHED INDEX.

      Remedy: None.  The statistics of a CLUSTERED HASHED INDEX cannot be
	      updated.

00378 EXE RCN ROWCOUNT not supported for read-only transactions

      Reason: The ROWCOUNT command is not support for read-only transactions.

      Remedy: None.  The ROWCOUNT operation is not supported for read-only
	      transactions.

00379 EXE BRL Invalid ROWID

      Reason: Application has submitted an invalid rowid while using the
	      ROWID=[rowid] constraint in the where clause.  SQLBase has
	      determined this rowid cannot be matched with any row within the
	      database.  Valid rowid's are retrieved using SELECT ROWID.

      Remedy: Correct the rowid by retrieving the correct rowid using SELECT
	      ROWID.

00380 EXE CEF CHECK EXISTS failure

      Reason: An UPDATE statement was succesful but no rows were updated.

      Remedy: None.  Informational only.  The CHECK EXIST clause on the SQL
	      UPDATE statement specifies to return this error if at least one
	      row is NOT updated.

00381 EXE CAN NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00382 EXE UFV Unmatched foreign key values

      Reason: Insert of a new row into a dependent table violates a
	      referential integrity constraint because there was no
	      parent row in the parent table.

      Remedy: None.  Informational only.  This insert violates an existing
	      referential integrity contraint, therefore to maintain the
	      integrity of the data this insert is not allowed.  For more
	      information on how to enhance or customize this SQLBase error
	      message, see the SQLBase Language Reference Manual, Chapter 11:
	      Referential Integrity, in the section entitled "Enhancing
	      SQLBase Error Messages".

00383 EXE CDR Cannot delete row until all the dependent rows are deleted

      Reason: Delete of a row from a parent table when there are dependent
	      rows in a dependent table.

      Remedy: None.  Informational only.  This delete violates an existing
	      referential integrity contraint, therefore to maintain the
	      integrity of the data this delete is not allowed.  For more
	      information on how to enhance or customize this SQLBase error
	      message, see the SQLBase Language Reference Manual, Chapter 11:
	      Referential Integrity, in the section entitled "Enhancing
	      SQLBase Error Messages".

00384 EXE AMO Self-referencing table only allows one row from INSERT... SELECT

      Reason: The target table of the INSERT has foreign keys defined and one
	      of them is self-referencing and the INSERT statement involves an
	      INSERT with a nested subSELECT which returns multiple rows, so
	      the INSERT operation is not permitted.

      Remedy: None.  Informational only.  The INSERT with a nested subSELECT
	      may violate an existing referential integrity contraint,
	      therefore to maintain the integrity of the data this INSERT is
	      not allowed.  For more information on how to enhance or
	      customize this SQLBase error message, see the SQLBase Language
	      Reference Manual, Chapter 11: Referential Integrity, in the
	      section entitled "Enhancing SQLBase Error Messages".

00385 EXE UPO UPDATE involving primary key cannot update more than one row

      Reason: The specified UPDATE statement involves the updating of the
	      primary key and the updating of multiple rows at one time.

      Remedy: Update of a primary key is must be done one row at a time.

00386 EXE CUR Cannot update row until all the dependent rows are deleted

      Reason: Attempting to update rows in a parent table when there are
	      dependent rows in a dependent table.

      Remedy: None.  Informational only.  You must delete all dependent rows
	      before you can update the target row otherwise you will be
	      violating an existing referential integrity contraint.  For more
	      information on how to enhance or customize this SQLBase error
	      message, see the SQLBase Language Reference Manual, Chapter 11:
	      Referential Integrity, in the section entitled "Enhancing
	      SQLBase Error Messages".

00387 EXE NUI A suitable unique index must exist before adding primary key

      Reason: Attempting to add a primary key and no suitable unique index has
	      been found to use after the system scanned all available
	      indexes.

      Remedy: Create an unique index on the column or columns to be included
	      in the primary key.  The column or columns making up the key
	      must be unique and defined as NOT NULL.

00388 EXE AFU Adding foreign key will cause unmatched foreign key values

      Reason: Attempting to add a foreign key and the addition of this foreign
	      key will cause unmatched foreign key values which would violate
	      the referential integrity constraints.

      Remedy: A foreign key references a primary key in the same table or
	      another table.  To add the foreign key, verify and correct the
	      values in the foreign key column or columns so that their values
	      match the values in the primay key column or columns.

00389 EXE IND NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00390 EXE CCL Cannot compare long data

      Reason: Attempting a comparison on a LONG VARCHAR data element or
	      attempting to use a LIKE clause with a LONG VARCHAR data type.

      Remedy: Correct SQL statement and retry.

00391 EXE FUP Select for update requires RR or CS isolation

      Reason: Trying to perform a SQL SELECT statement using the FOR UPDATE OF
	      clause and the transaction is not in the DB2 compatible locking
	      modes of Read Repeatibility (RR) or Cursor Stability (CS).

      Remedy: Use the lock isolation modes of Read Repeatibility (RR) or
	      Cursor Stability (CS) when using the FOR UPDATE OF clause in the
	      SQL SELECT statement.

00392 EXE NDR No DDL statement in readonly database

      Reason: SQL Data Definition Language statements are not allowed when
	      operating with a READONLY database.

      Remedy: None.  Informational only.  To perform DDL statements on this
	      database, you need to restart the database so READONLY database
	      is disabled.

00393 EXE UEE User error already exist for the specified error class

      Reason: Performing an ALTER TABLE and trying to ADD a new user error for
	      the specified error class and a user error already exists.

      Remedy: Perform an ALTER TABLE and MODIFY the existing user error for
	      the specified error class rather than attempting to create a new
	      user error when one already exists.

00394 EXE UEN User error not defined for the specified error class

      Reason: Performing an ALTER TABLE and trying to DROP or MODIFY an
	      existing user error for a specific error class and the user
	      error does not exist.

      Remedy: None.  Informational only.  You cannot drop or modify a user
	      error that does not exist.  Verify that you have specified the
	      correct user error number.

00395 EXE CDK Cannot drop primary or foreign key column <column name>

      Reason: Attempting an ALTER TABLE to drop a column having either a
	      primary or foreign key defined on the column.

      Remedy: None, other than removing the column as a primary or foreign
	      key before attempting to drop the column.

00396 EXE NUV UPDATE privilege not allowed on views

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00397 EXE CIR Cannot index ROWID

      Reason: Attempting to create an index on a table's ROWID.

      Remedy: None.  You cannot create an index on a table's ROWID.

00398 EXE ISH Invalid statistics column for a hashed index

      Reason: Attempting to force the statistics on columns that are
	      meaningful for pure index(B-Tree) organization only.

      Remedy: Correct the command and retry.

00399 EXE ISI Invalid statistics columns for a B-Tree index

      Reason: Attempting to force the statistics on columns that are
	      meaningful for hashed index organization only.

      Remedy: Correct the command and retry.

00400 EXE RNO Cannot revoke non-granted execute privilege from user <name>

      Reason: Attempting to execute a REVOKE execute privilege from a
	      user and the user does not have the specific named
	      privilege granted.

      Remedy: None. You cannot revoke an execute privilege from a user who
	      does not have the specific named privilege.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are errors that
generally occur during database access.
00401 DBA COD Cannot open database

      Reason: FOR SQLBASE: The specified database cannot be found.  SQLBase
	      cannot find the file named "x:\dbdir\dbname\dbname.DBS" where
	      x:\dbdir is either the default, c:\SQLBASE, or modified with
	      the DBDIR SQL.INI configuration keyword.	In a multiuser
	      network configuration, this error indicates that your network
	      is working correctly, but the database system was unable to
	      locate the specified database filename.

	      FOR NON-SQLBASE DATABASES: This problem can also occur with a
	      SQLGateway when leaving out the protocol type in the SERVERNAME
	      parameter that the client uses to communicate with the gateway
	      (like SQLNBIOS).	For example,

		   SERVERNAME=SERVER33,SQLQUEUE
		   DBNAME=DB2DBMS, SQLQUEUE, SQLNBIOS

	      won't allow a remote client process (using SQLNBIOS on the LAN
	      to communicate with the SQLGateway machine) to connect to the
	      SQLGateway machine.

	      For SPX connectivity from DOS or MS Windows to a Unixware
	      SQLBase Server check for the omission of the "serverpath=..."
	      parameter in the SQL.INI file under the client section.


      Remedy: Verify the database file exists.	The default drive letter and
	      dbdirname is c:\SQLBASE unless overridden with a DBDIR SQL.INI
	      configuration keyword parameter.	Verify the DBDIR keyword is
	      not missing or pointing to a wrong database directory.  Verify
	      the DBNAME keyword is specified for the named database.  Verify
	      the SERVER keyword is not missing or conflicting with other
	      network server names.  In your CONFIG.SYS file, verify at least
	      40 files set with the FILES=40 parameter.  If the server was
	      being initialized while the connection was tried, retry the
	      connection after the server has initialized.  If all of the
	      above fails, try using a different database name or try
	      connecting to the database in single user mode at the same
	      machine.	If you can connect with a local engine it probably
	      indicates a network configuration error exists.  If you can
	      connect with a new database name it probably indicates a
	      previously named database was never properly initialized.

00402 DBA WDB Wait for DBA structure

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00403 DBA OFF Database found; but the file can't be opened

      Reason: The database has been successfully located but, the system
	      could not open the file.

      Remedy: Determine why the database file could not be opened by the
	      database management system.  Check at least 40 files are set
	      with the FILES=40 parameter.

00404 DBA IPW Invalid password

      Reason: Attempting to connect to the database with a bad password.

      Remedy: Use a valid database name, user name, and password.

00405 DBA IUN Invalid user name

      Reason: Trying to connect to the database with an invalid user name.

      Remedy: Use a valid database name, user name, and password.

00406 DBA DNP Escape sequence connect not supported.

      Reason: Escape sequence connect not supported.

      Remedy: None.  Only standard connect to database/userid/password sequence
	      supported.

00407 DBA CAD Out of memory at the database computer (DBA CAD)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00408 DBA DON Database already opened with no recovery

      Reason: Attempting to connect to the database with recovery ON and the
	      database server has already been connected to with recovery OFF.

      Remedy: None.  It is recommended that recovery is always ON.

00409 DBA DOR Database already opened with recovery

      Reason: Attempting to connect to the database with recovery OFF and the
	      database server has already been connected to with recovery ON.

      Remedy: None.  It is recommended that recovery is always ON.

00410 DBA IDF Invalid database file

      Reason: The specified database cannot be opened.	The version number of
	      the specified database conflicts with the version of SQLBase
	      software being used.

      Remedy: Verify that the version of the database file (.DBS) corresponds
	      to the software version number.

00411 DBA IDB Invalid database name

      Reason: A specified database name has been determined to be invalid.

      Remedy: A valid database file name must consist of one to eight
	      characters.  The file name is not allowed to have any invalid
	      characters such as: . " / \ [ ] : | + = ; , and ASCII
	      characters less than 20 hexadecimal.  Additionally, the
	      character "space" is consider invalid.

00412 DBA DNA Unused - Error DBA COD is used for consistency

      Reason: This error occurs only for certain communication protocols
  (TCP/IP, specifically).  Other protocols return DBA COD for similar
  errors.

      Remedy: See DBAECOD.

00413 DBA NLS NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00414 DBA RIP Connects not allowed until restore is complete

      Reason: Online restore is in progress, other connection to the database
	      are not allowed until the restore operation is complete.

      Remedy: Wait until restore operation is complete.

00415 DBA REC Recovery operation in-progress

      Reason: Recovery operation is in progress, other connection to the
	      database are not allowed until the recovery operation is
	      complete.

      Remedy: Wait until the recovery operation is complete.

00416 DBA OUC Operation not allowed while other users are connected

      Reason: The operation attempting to be performed is not allowed while
	      other users are connected to the SQLBase Server.

      Remedy: Try again later or have everyone disconnect from the SQLBase
	      Server so that you can perform your operation.

00417 DBA CCD Cannot create database file

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

00418 DBA SDN Shutdown in progress

      Reason: The database is being shutdown, therefore no new users are
	      allowed to connect to the SQLBase Server.

      Remedy: Try again later, the SQLBase Server is coming down.

00419 DBA ICM Incompatible connect mode

      Reason: When connecting to a database, a check is made to see if the
	      requested connect mode is compatible with other users' connect
	      modes to the database.  This error occurs because the requested
	      connect mode conflicts with another user already connected to
	      the database.

      Remedy: Wait and connect later or verify how other users are connected
	      and attempt to connect in mode that is compatible with the
	      existing users connected to the database.  Possible conflicts
	      could be:
		   Current User Connect Modes	Requested connect mode
		   --------------------------	----------------------
		   No recovery connect		Server connect
		   Normal connect		Server connect
		   Read-only database connect	Server connect
		   Read-only database connect	Recovery connect

00420 DBA CRD Cannot convert Read-Only database to current version.

      Reason: The database to which connection is being attempted requires
      conversion to be compatible with the current server version.  The database
      is read-only.

      Remedy: Change the database to other than read-only, and back up the database
      with the prior version of the server.  Then connect again with the
      current server version.

00421 DBA ISC Invalid server connect

      Reason: The specified database server name is invalid.

      Remedy: Correct the database server name and retry again.

00422 DBA ISL Invalid servername length

      Reason: The specified servername name length is invalid.

      Remedy: Use a valid servername.

00423 DBA NRS Not remote server

      Reason: A server name has been specified for a local single user
	      database engine.

      Remedy: Correct the server name specification.  Server names are not
	      necessary to communicate with a local database.  If you are
	      using the API, specify a pointer to a null terminator to
	      indicate a null server name for a local database.

00424 DBA UCE Unexpected SQLBase condition

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00425 DBA ROE Read-Only mode already enabled

      Reason: Attempting to enable Read-Only mode and the database is already
	      in Read-Only mode.

      Remedy: None.  The database is already a Read-Only database.

00426 DBA ROD Read-only mode already disabled

      Reason: Attempting to disable Read-Only mode and the database is not a
	      Read-Only mode database.

      Remedy: None.  The database is not a Read-Only mode database.

00427 DBA CCH Could not create history file on database computer

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

00428 DBA IRS Invalid parameter setting for READONLY transaction value

      Reason: Settine whether read-only transactions are allowed and the
	      setting is something other than OFF (0), ON (1), or DEFAULT (2).

      Remedy: Use a proper read-only transaction option and resubmit.

00429 DBA DNB Database name is too big

      Reason: Specified database name exceeds 8 characters.

      Remedy: Correct specified database name.

00430 DBA NFS No free cursor slot while trying to close database

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00431 DBA CLF Clean up log files failed during restore from snapshot

      Reason: The SQLBase system is trying to read the log files to be deleted
	      from the log file directory and a failure has occurred.

      Remedy: Verify that the log file directory as specified by the SQL.INI
	      configuration parameter LOGDIR exists and try again.

00432 DBA ISI Sort information in database does not match COUNTRY.SQL file

      Reason: Information found in the file COUNTRY.SQL does not properly
	      correspond to infomration found in the database.	Most likely,
	      the database file was created with a different COUNTRY.SQL file
	      other than the one currently being used.

      Remedy: Verify the proper COUNTRY.SQL file is utilized.

00433 DBA RDE Read-only database already enabled

      Reason: Attempting to enable a Read-Only database and the database is
	      already a Read-Only database.

      Remedy: None.  The database is already a Read-Only database.

00434 DBA RDD Read-only database already disabled

      Reason: Attempting to disable a Read-Only database and the database is
	      not a Read-Only database.

      Remedy: None.  The database is not a Read-Only database.

00435 DBA TDM TEMPDIR must be specified to access read-only databases

      Reason: Attempting to start or enable a Read-Only database and no
	      TEMPDIR environment variable is set.

      Remedy: Enter the following line in the AUTOEXEC.BAT file:
		   TEMPDIR=C:\SQLBASE\databasename
	      All the temporary files associated with a Read-Only database
	      will then be stored in the TEMPDIR\databasename directory.

00436 DBA CTF Unable to create temporary file

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

00437 DBA ICP Code page in database does not match COUNTRY.SQL file

      Reason: Information found in the file COUNTRY.SQL does not properly
	      correspond to infomration found in the database.	Most likely,
	      the database file was created with a different COUNTRY.SQL file
	      other than the one currently being used.

      Remedy: Verify the proper COUNTRY.SQL file is utilized.

00438 DBA CCT Cannot create temporary file

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

00439 DBA ILW Lowercase table in database does not match COUNTRY.SQL file

      Reason: Information found in the file COUNTRY.SQL does not properly
	      correspond to infomration found in the database.	Most likely,
	      the database file was created with a different COUNTRY.SQL file
	      other than the one currently being used.

      Remedy: Verify the proper COUNTRY.SQL file is utilized.

00440 DBA IUP Uppercase table in database does not match COUNTRY.SQL file

      Reason: Information found in the file COUNTRY.SQL does not properly
	      correspond to infomration found in the database.	Most likely,
	      the database file was created with a different COUNTRY.SQL file
	      other than the one currently being used.

      Remedy: Verify the proper COUNTRY.SQL file is utilized.

00441 DBA NDB SQLBase internal database connect failed

      Reason: SQLBase is attempting an internal "under-the-covers" connect
	      to some database and a failure has occurred.  Most likely,
	      SQLBase was attempting to connect to the MAIN database for a
	      partitioned database operation.

      Remedy: Verify that the MAIN database exists.  If necessary create
	      the partitioned database.

00442 DBA COF Cannot open database; file handles exceeded

      Reason: The specified database cannot be opened because the number
	      of file handles needed to complete the open would exceed the
	      number of file handles available.  The file handles are
	      provided by the operating environment, ie., DOS, Windows, OS/2.

      Remedy: Investigate why so many databases were previously being
	      connected by your application(s).  Reduce these connections
	      to a minimum.  Deinstalling one or more databases will also
	      make more file handles available.

00443 DBA CAC Out of memory at the database computer (DBA CAC)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00444 DBA DUW Attempt to disconnect with uncommitted work (DBA DUW)

      Reason: The application is trying to disconnect from a database without
	      committing or rolling back the work done in the most recent
	      transaction. This is disallowed if the transaction was started
	      as a distributed transaction.
	      WARNING: If you ignore this error and exit your application,
	      the uncommitted work will be rolled back!

      Remedy: Commit the transaction and issue the disconnect again.

00445 DBA DTP Attempt to turn off recovery with pending distributed transactions.

      Reason: The user tried to connect to a database without recovery turned
	      on; but the database still has distributed transactions
	      pending recovery. If the no recovery connect is allowed,
	      it will not be possible to resolve such transactions.

      Remedy: Resolve the pending distributed transactions. Normally this
	      will happen automatically when you connect to the database
	      in the "normal" mode, if the commit-server(s) for the
	      transactions is still accessible and the information is not
	      lost. If this is not true or you don't care about how the
	      transactions are resolved, you can manually resolve the
	      transactions (see the manual), and then connect with recovery
	      turned  off.

00446 DBA SDS Server shutdown in progress

      Reason: The server is being shutdown, therefore no new users are
	      allowed to connect to the SQLBase Server.

      Remedy: Try again later, the SQLBase Server is coming down.

00447 DBA XDL Cannot open database; exclusively locked by another user.

      Reason: The specified database cannot be opened because another user
	      has locked the database for exclusive use with the
	      LOCK DATABASE command.

      Remedy: New connections to the database will be disallowed until
	      the user who locked the database either issues an UNLOCK
	      DATABASE command, or disconnects.  When either of these
	      actions occur, you should be able to access the database.

00448 DBA IVD DBS version (<version>), incompatible with software (<version>)

      Reason: The specified database cannot be opened.	The version number
	      of the specified database conflicts with the version of the
	      SQLBase software being used. For example, the database file
	      format is from a previous release version of SQLBase.

      Remedy: Verify that the version of the database file (.DBS) is
	      compatible current software version. If the file version is
	      incompatible, UNLOAD that database file with a compatible version
	      of SQLBase software, then use the current version of SQLBase to
	      LOAD that file into a compatible database format.

00449 DBA DBN Cannot connect to database; number limit exceeded

      Reason: User cannot connect to the database because the number of
	      current database connections has reached the maximum value.

      Remedy: Disconnect unused databases and connect to it again.

00450 DBA ANC Attributes not compatible

      Reason: The attribute of the database file is not compatible with the
	      attribute of database.  Possibly the database is read-write
	      but recorded on a read only media.

      Remedy: Change the database file to read-write if possible.  If the
	      media is inherently read only, such as CD ROM, re-record the
	      database after setting it read-only.

00451 DBA FRO Database file is readonly

      Reason: The attribute of the database file is marked readonly.
	      Possibly the database is on a read only media or the write
	      attribute of the file is turned off.

      Remedy: Change the database file to read-write if possible.  If the
	      media is inherently read only, such as CD ROM, re-record the
	      database after setting it read-only.

00452 DBA UPG Cannot convert this database - Database has been shut down

      Reason: The database to which connection is being attempted requires
      conversion to be compatible with the current server version.  An error
      occurred during the attempt to do the conversion.  Fail.sql contains
      the original error as part of the debugging information

      Remedy: Attempt to correct the problem documented in the Fail.sql file.
      When the error is corrected, start the database and attempt to connect
      again.  A possible alternative is to LOAD the unloaded version of the
      database.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are errors that
relate to database memory workspace.
00501 WSP ISP NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00502 WSP CNA Out of memory at the database computer (WSP CNA)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00503 WSP TMC NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00504 WSP CRP Cannot relocate pointer

      Reason: A pointer which is part of a view or stored command cannot be
	      relocated.  This relocation happens when a view is referenced in
	      a subsequent command or when a stored command is retrieved.  The
	      object being retrieved (either a view or a stored command) may
	      be bad.  A pointer stored in the view or stored command is no
	      longer valid and therefore cannot be relocated.  Also, the
	      pointer might be good but the data structure used to relocate
	      the pointer may be bad.

      Remedy: The problem can be resolved by dropping the view or restoring
	      the stored command.  Run a CHECK DATABASE to verify the
	      integrity of the database.

00505 WSP WLE Work space limit exceeded

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

1.0.0 SQLBase Errors Guide
The errors in this section of the Error Guide are errors that generally
relate to database dictionary operations.
00601 DIC ITN Table <table name> has not been created

      Reason: Specified table name does not exist.

      Remedy: Submit the SQL statement with a correct (existing) table name.

00602 DIC TAE NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00603 DIC ICN Invalid column number

      Reason: A column has been specified by column number and the column
	      number specified cannot be translated to an appropriate column
	      name.

      Remedy: Specify a valid column number.

00604 DIC IIN Invalid index number

      Reason: Trying to execute a SQL EXPLAIN statement and SQLBase cannot
	      find a particular index looking it up by index number.

      Remedy: If the EXPLAIN was bases on a STORED command, drop the stored
	      command, restore it, and try the EXPLAIN again.  If the EXPLAIN
	      was following a compile of a SQL statement, run a CHECK DATABASE
	      to verify the consistency of the database.

00605 DIC SYN Synonym <synonym name> does not exist

      Reason: Attempting to drop a synonym and the specified synonym name does
	      not exist.

      Remedy: Specify a correct (existing) synonym name.

00606 DIC IVN Event does not exist

      Reason: Specified event name does not exist.

      Remedy: Submit the SQL statement with a correct (existing) event name.

00607 DIC STN A system table definition in the dictionary could not be found.

      Reason: While creating the external dictionary, SQLBase was unable
	      to successfully retrieve a system table definition from
	      the internal dictionary.

      Remedy: The database may be corrupt, or an internal SQLBase error may
	      have occurred. Try to drop and recreate the database, or
	      contact SQLBase Technical Services.

00608 DIC STC Security initialization in the external dictionary has failed.

      Reason: While initializing security settings in the external
	      dictionary, SQLBase was unable to successfully retrieve
	      a system table definition from the internal dictionary.

      Remedy: The database may be corrupt, or an internal SQLBase error may
	      have occurred. Try to drop and recreate the database, or
	      contact SQLBase Technical Services.

00609 DIC NSO <creator>.<name> is not a synonym for <creator>.<name>

      Reason: The DROP SYNONYM has been used with the FOR clause. When this
	      clause is used a check is made that the synonym being dropped
	      is actually a synonym for the object named in the FOR clause.

      Remedy: Check the synonym and object names to make sure that the
	      synonym name is actually a synonym for the object name.

00610 DIC CVT Conversion of internal trigger dictionary failed - Entry not found

      Reason: The attempt to convert trigger entries from Version 6.0 format
	  to the current version failed.  The internal definiton of the trigger
	  was not found.

      Remedy: Restore the database with the backup under version 6.0.x.  execute
	  a check database command.  If the problem persists, unload the database
	  under Version 6.0, and reload under the current version, or contact
	  SQLBase Technical Services.

1.0.0 SQLBase Errors Guide
The errors in this section of the Error Guide are errors that generally
relate to database virtual input/output operations.
10/20/93 DBS bug fix: correct allocation page for longs
00701 VIO OCP Out of cache pages

      Reason: Database cache is page buffers which can hold the most recently
	      referenced database pages.  The number of cache pages is
	      specified by the CACHE configuration parameter in the SQL.INI
	      file.  Whenever a database page is accessed, SQLBase first
	      locates a cache page for it.  Sometimes the database page is
	      already in cache.  If the page is not already in the cache,
	      SQLBase locates a free cache page and reads the database page
	      into the cache page and then uses the cache page buffer to
	      perform the desired operation.  While SQLBase is performing
	      operations on the cache page it refers to them as "inuse".  Once
	      SQLBase is done with the cache page, it is marked as "free".

	      To locate free cache pages, SQLBase searches a LRU (least
	      recently used) chain.  If SQLBase goes thru the entire LRU chain
	      and all pages are inuse, it waits and then gives this error
	      message.	If some user frees up a page while SQLBase is waiting,
	      SQLBase uses that page.

      Remedy: Ther  are various alternatives to avoiding this problem.	One
	      quick solution is to increase the number of CACHE pages.
	      Another solution is to reduce the number of "inuse" cache pages
	      by reducing the span of the active transactions.	That is,
	      COMMIT the transaction more often in the application programs.
	      Also, try eliminating any unnecessary drivers at the database
	      computer such as DOS16M settings, HIMEM.SYS, etc.

00702 VIO PNO Fatal SQLBase System Failure (VIO PNO)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00703 VIO IPN Fatal SQLBase System Failure (VIO IPN)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00704 VIO DUN Crashed with recovery off, database unrecoverable

      Reason: The database has crashed with recovery turned OFF.

      Remedy: The database is unrecoverable.  Backup the database to the most
	      recent backup copy of the database.  All transactions since the
	      most recent backup will be losted.

00705 VIO NFT NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00706 VIO CPO Out of memory at the database computer (VIO CPO)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00707 VIO TBO Out of memory at the database computer (VIO TBO)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00708 VIO NUR No updates with read only isolation

      Reason: Attempting an INSERT, UPDATE, or DELETE while in Read Only (RO)
	      Locking Isolation Mode.

      Remedy: Change isolation mode setting to either Read Repeatibility (RR),
	      Cursor Stability (CS), or Release Lock (RL) locking isolation
	      mode before attempting to do an INSERT, UPDATE, or DELETE.

00709 VIO BVC Fatal SQLBase System Failure (VIO BVC)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00710 VIO ILP Fatal SQLBase System Failure (VIO ILP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00711 VIO MEM NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00712 VIO CAT Out of memory at the database computer (VIO CAT)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00713 VIO CAF Out of memory at the database computer (VIO CAF)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00714 VIO ILT Fatal SQLBase System Failure (VIO ILT)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00715 VIO RFI Rollforward interrupted - must restore database backup again

      Reason: A ROLLFORWARD operation was unexpectedly interrupted.

      Remedy: To restore the database, the RESTORE operation must be restarted
	      from the beginning, again.

00716 VIO MOR NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00717 VIO THR NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00718 VIO BKF Restored backup file requires media recovery: use ROLLFORWARD command

      Reason: A restore of a backup file has failed.

      Remedy: The failed restore should be treated as if a media failure has
	      occurred.  Use media recovery techniques.  Use the ROLLFORWARD
	      command.

00719 VIO RFS Cannot connect until rollforward completed, use ROLLFORWARD END command

      Reason: A ROLLFORWARD operation has not been completed and a user is
	      attempting to connect to the database.

      Remedy: Issue a ROLLFORWARD END command to complete the rollforward
	      operation.

00720 VIO UCO Fatal SQLBase System Failure (VIO UCO)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00721 VIO DMO Too many pages allocated for demonstration program

      Reason: The demonstation system you are using from Centura Software
	      Corporation has exceeded the maximum number of pages allowed
	      for demo purposes.

      Remedy: Reduce the size of the database or acquire a production version
	      of the latest Centura Software Corporation software.

00722 VIO MIP Fatal SQLBase System Failure (VIO MIP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00723 VIO NRD No updates against read only database

      Reason: Cannot perform INSERTs, UPDATEs, DELETEs, or any other
	      operations that change the database when operating with a Read
	      Only database.

      Remedy: None.  Informational Only.  Read Only databases do not allow
	      changes, query access is only allowed.

00724 VIO PMC Fatal SQLBase System Failure (VIO PMC)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00725 VIO ITP Fatal SQLBase System Failure (VIO ITP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00726 VIO DNL Cannot have distributed transaction with logging disabled.

      Reason: The user attempted to start a distributed transaction in a
	      database with logging disabled -- perhaps due to connecting
	      to the database with RECOVERY OFF.

      Remedy: Either connect to the database with RECOVERY ON, or turn
	      off distributed transactions.

00727 VIO CAL Out of memory at the database computer (VIO CAT)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

00728 VIO DTN Distributed transaction not supported

      Reason: The user attempted to start a distributed transaction in a
	      database server which does not support two-phase commit.
	      For example in version 6.0 Beta-1, the Netware platform
	      does not support distributed transactions. This support
	      will be available in Beta-2.

      Remedy: Turn off distributed transactions before connecting to this
	      database.

00729 VIO CPG A corrupted page is found (VIO CPG)

      Reason: A page is in a corrupted state after it is retrieved from
	      the database. The data on the page is not consitent with
	      the expected value and format.

      Remedy: Recover the database from a backup database and logs. A
	      page is corrupted and should be treated as a media failure
	      in the database.

00730 VIO BPN A bad page number is found (VIO BPN)

      Reason: A bad page number is found in the database. The page which
	      contains this page number is corrupted.

      Remedy: Recover the database from a backup database and logs. A
	      page is corrupted and should be treated as a media failure
	      in the database.

00731 VIO CNS Can not start any more transaction

      Reason: You have reached the maximum number of allowed transactions.


      Remedy: Reduce the number of active connections and retry the
	      application.


00732 VIO MZU Page being modified has a zero use count (VIO MZU)

      Reason: The use count is 1) maintained incorrectly or 2) corrupted.

      Remedy: None.  Please report incident to Centura Software Corporation
	      technical support.

00733 VIO RZU Page being released has a zero use count (VIO RZU)

      Reason: The use count is 1) maintained incorrectly or 2) corrupted.

      Remedy: None.  Please report incident to Centura Software Corporation
	      technical support.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
database internal row munipulation operations.
00801 ROW END INTERNAL USE ONLY - End of fetch

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00802 ROW ISA Insufficient data page space available to update column(s)

      Reason: Attempting to update a row where the size of the row has grown
	      to exceed the maximum space available for this row in the data
	      page and its extent pages.

      Remedy: Unload the table, drop the table, and recreate the table with a
	      larger PCTFREE value, and then reload the table.	A larger
	      PCTFREE will allow more space on each data page for the growth
	      of rows such as the one attempting to be updated.

00803 ROW UEP Fatal SQLBase System Failure (ROW UEP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00804 ROW KTL Key value is too large

      Reason: The row key value exceeds 255 characters.

      Remedy: Modify the index being used or modify the ORDER BY or GROUP BY
	      clause being used so the key does not exceed 255 characters.
	      See the formula for computing the size of an index in the CREATE
	      INDEX documentation of the SQL Language Reference Manual.

00805 ROW NUD Insert/update of unique constrained columns with duplicate data

      Reason: The target table of an INSERT or UPDATE operation is constrained
	      (by a CREATE UNIQUE INDEX statement) to have unique values in
	      certain columns.	Completion of the requested INSERT or UPDATE
	      would result in duplicate values occurring in the row.  If a
	      view is the object of the INSERT or UPDATE statement, the table
	      that defines the view is constrained.  The update might also be
	      caused by a DELETE operation of a parent row that cascades to a
	      dependent row with a delete rule of SET NULL.

      Remedy: Examine the definitions for any UNIQUE INDEX indexes to
	      determine the uniqueness constraints imposed.  For an UPDATE
	      statement, verify that the specified operation is consistent
	      with the uniqueness constraint.  If this does not indicate the
	      error, examine the target table to determine the cause of the
	      problem.	For an INSERT statement, examine the target table to
	      determine which values violate the uniqueness constraint.  If
	      the INSERT statement contains a subquery, match the contents of
	      the table addressed by the subquery and the contents of the
	      target table to determine the cause of the problem.  For a
	      DELETE statement, examine the index key columns in the table
	      that defines the index.  These columns contain a foreign key,
	      which when set NULL on a cascade delete from the target table,
	      causes the duplicate values.

00806 ROW IRI Invalid ROWID

      Reason: Application has submitted an invalid  rowid  while  using  the
	      ROWID=[rowid] constraint in the  where  clause.	SQLBase  has
	      determined that this rowid cannot  be  matched  with  any  row
	      within the database.  Valid rowid's are retrieved using SELECT
	      ROWID.

      Remedy: Correct the rowid by retrieving the correct rowid using SELECT
	      ROWID.

00807 ROW IIC Index is corrupt

      Reason: The current operation is attempting to use an index that has
	      been found to be corrupt.

      Remedy: Try to determine which index is corrupt.	The EXPLAIN command
	      may help diagnose which indexes were being used.	Running a
	      CHECK DATABASE may also flush out the corrupt index.  Once you
	      have identified the corrupt index, drop the index, and recreate
	      it.  Run CHECK DATABASE to verify the consistency of the
	      database.  And, finally, rerun the operation that was causing
	      the corrupt index problem to occur.

00808 ROW UFA Fatal SQLBase System Failure (ROW UFA)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00809 ROW BPT CHECK Failure (ROW BPT): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00810 ROW BSN CHECK Failure (ROW BSN): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00811 ROW FSB CHECK Failure (ROW FSB): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00812 ROW BSO CHECK Failure (ROW BSO): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00813 ROW BSL CHECK Failure (ROW BSL): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00814 ROW BRH CHECK Failure (ROW BRH): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00815 ROW MRH CHECK Failure (ROW MRH): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00816 ROW URH CHECK Failure (ROW URH): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00817 ROW BIT CHECK Failure (ROW BIT): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00818 ROW BIL CHECK Failure (ROW BIL): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00819 ROW BEM CHECK Failure (ROW BEM): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00820 ROW TMI CHECK Failure (ROW TMI): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00821 ROW TFI CHECK Failure (ROW TFI): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00822 ROW IOS CHECK Failure (ROW IOS): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00823 ROW SDT CHECK Failure (ROW SDT): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00824 ROW FDT CHECK Failure (ROW FDT): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00825 ROW BPL CHECK Failure (ROW BPL): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00826 ROW BEN CHECK Failure (ROW BEN): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00827 ROW BEB CHECK Failure (ROW BEB): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00828 ROW BRC CHECK Failure (ROW BRC): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00829 ROW BRN CHECK Failure (ROW BEM): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00830 ROW USL CHECK Failure (ROW USL): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00831 ROW BTP CHECK Failure (ROW BTP): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00832 ROW BRP CHECK Failure (ROW BRP): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00833 ROW RIF Fatal SQLBase System Failure (ROW RIF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00834 ROW CKU Cannot UPDATE the key of a CLUSTERED HASHED index

      Reason: Cannot UPDATE any columns used in a clustered hash index.

      Remedy: Delete the row and re-insert the row with the new clustered
	      hashed index values.

00835 ROW MHV CHECK Failure (ROW MHV): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00836 ROW TNN CLUSTERED HASHED index must be created on a freshly created table

      Reason: A CREATE INDEX statement that specifies a clustered hashed index
	      must be given after the CREATE TABLE statement and before any
	      data is inserted into the table.

      Remedy: Unload the table data. DROP and re-CREATE the table. Create the
	      CLUSTERED HASHED index. Reload the data.

00837 ROW IVF INTERNAL USE ONLY - Invalid function

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00838 ROW RTL Initial row size is too large

      Reason: Row attempting to be insert is too large for the system.	The
	      number of columns and width of each column exceeds the maximum
	      size available.  The row length for a table cannot exceed the
	      page size of the table space ih which that table resides (or is
	      to reside).

      Remedy: Reevaluate the structure of table and determine if its possible
	      to create multiple tables for the single table currently being
	      used.

00839 ROW CNL Fatal SQLBase System Failure (ROW CNL)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00840 ROW CND Fatal SQLBase System Failure (ROW CND)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00841 ROW CNU Fatal SQLBase System Failure (ROW CNU)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00842 ROW PPN Fatal SQLBase System Failure (ROW PPN)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

00843 ROW PEB CHECK Failure (ROW PEB): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00844 ROW BFP CHECK Failure (ROW BFP): <data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00845 ROW BLP CHECK Failure (ROW BLP): <long data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00846 ROW BLS CHECK Failure (ROW BLS): <long data page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

00847 ROW IRS Row size is too big for a temporary table

      Reason: (This error is now obsolete.)
	      The system has detected an excessively large row size exceeding
	      the useable space of a single row page violating the temporary-
	      table constraint that no extension pages are allowed, a known
	      problem requiring future enhancement to correct.

      Remedy: Modify the query to avoid causing the system to use temporary
	      table(s) or generating large (result) row size(s).

00848 ROW PRM Row being processed for a DELETE/UPDATE was modified by triggered actions.

      Reason: A DELETE/UPDATE operation was in progress and it was
	      detected that a row being deleted/updated was modified by
	      a triggered action such as a BEFORE DELETE or a BEFORE UPDATE
	      trigger that fires FOR EACH ROW.
	      Such a trigger MUST NOT attempt to issue DML (INSERT, UPDATE,
	      DELETE) either DIRECTLY or INDIRECTLY against the table on
	      which the trigger is defined. An indirect DML action may
	      occur for example if the trigger issues DML that causes
	      other triggers to fire or causes referential triggered actions
	      (such as DELETE CASCADE, DELETE SET NULL) to occur.

      Remedy: Modify the trigger so that it does not issue INSERT, UPDATE
	      or DELETE actions directly or indirectly against the table
	      on which the trigger is defined.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
parsing errors.  These errors generally occur during the compile of a SQL
statement and the statement violates the syntax for that SQL command.
00901 PRS CNE Command not properly ended

      Reason: The end of a SQL statement was unexpectedly determined.

      Remedy: Verify that the SQL statement syntax is correct and that the
	      statement was not somehow truncated.

00902 PRS MFC Missing FROM clause

      Reason: The FROM clause is missing from a SELECT statement.

      Remedy: Verify that the FROM clause exists and that it is correctly
	      entered after the select list, for example:

		   SELECT columnnames FROM tablename ...

00903 PRS ICC Invalid CREATE command

      Reason: Keyword immediately following the CREATE verb is not invalid.

      Remedy: Verify the keyword immediately following the CREATE verb
	      keyword is either TABLE, INDEX, UNIQUE (index), SYNONYM,
	      PUBLIC (synonym), VIEW, DBAREA, STOGROUP, DATABASE, or EXTERNAL.

00904 PRS MLP Missing left parenthesis

      Reason: A missing left parenthesis has been determined.

      Remedy: Check the syntax of the SQL statement to determine the missing
	      left parenthesis.

00905 PRS MRP Missing right parenthesis

      Reason: A missing right parenthesis has been determined.

      Remedy: Check the syntax of the SQL statement to determine the missing
	      right parenthesis.

00906 PRS ITN Invalid table name

      Reason: The table name is invalid.

      Remedy: Verify that the specified table name is valid.

00907 PRS ICN Invalid column name

      Reason: The column name is invalid.

      Remedy: Verify that the specified column names are valid.

00908 PRS ICS Invalid CHAR or VARCHAR size

      Reason: Attempting to create or modify a column and the specified size
	      exceeds 254 characters.

      Remedy: Modify statement so CHAR or VARCHAR size does not exceed 254
	      characters.

00909 PRS INC Invalid character

      Reason: The SQL parser has determined an invalid character while
	      searching for quoted strings, numbers, keywords, and
	      identifiers.

      Remedy: Verify that the SQL statement is correctly stated and that no
	      invalid characters are present.

00910 PRS ITL Identifier too long

      Reason: An identifier exceeds 18 characters.

      Remedy: Correct the identifier that exceeds 18 characters.

00911 PRS MIK Missing INTO keyword

      Reason: INTO keyword is missing from an INSERT statement.

      Remedy: Correct SQL statement.  All INSERT statements begin
	      "INSERT INTO tablename...".

00912 PRS MVK Missing VALUES keyword

      Reason: VALUES keyword is missing from an INSERT statement.

      Remedy: Correct SQL statement.

00913 PRS NEV Number of INSERT values not equal to number of target columns

      Reason: The number of columns specified in the INSERT statement does
	      not match the number of values specified in the VALUES clause.

      Remedy: Correct the SQL statement.  The number of columns exceeds the
	      number of values.  Specify one and only one value for each of
	      the specified object columns.

00914 PRS IBV Invalid bind variable

      Reason: A bind variable, identified because it follows a colon, has
	      been determined as invalid.

      Remedy: Check that each bind variable is either a number or valid
	      identifier.

00915 PRS IVC Invalid constant

      Reason: An invalid constant has been determined.

      Remedy: Correct SQL statement.

00916 PRS QNE Quoted string not ended properly

      Reason: A quoted string has not been properly terminated.

      Remedy: Correct SQL statement.

00917 PRS ISC Invalid SQL statement

      Reason: The SQL statement verb is invalid.

      Remedy: Verify that the first keyword is a valid SQL statement verb.

00918 PRS TMV Number of INSERT values exceeds number of target columns

      Reason: The number of columns specified in the INSERT statement does
	      not match the number of values specified in the VALUES clause.

      Remedy: Correct the SQL statement.  The number of values exceeds the
	      number of columns.  Specify one and only one value for each of
	      the specified object columns.

00919 PRS QTL Quoted string too long

      Reason: A quoted string is longer than 254 characters.

      Remedy: Correct SQL statement.

00920 PRS MES Missing equal sign

      Reason: An equal sign is missing in an UPDATE statement.

      Remedy: Correct UPDATE statement.  The SET clause within an UPDATE
	      statement has the general form of
		   SET column-name = expression

00921 PRS IVO Invalid operator

      Reason: An invalid operator has been determined.	The SQL parser was
	      attempting to parse a boolean factor when it discovered this
	      invalid operator.

      Remedy: Correct SQL statement.

00922 PRS MCP Missing comma or parenthesis

      Reason: A missing comma or parenthesis has been determined in an INSERT
	      statement.

      Remedy: Correct SQL statement.

00923 PRS MSE Missing SET keyword

      Reason: A SET keyword is missing in an UPDATE statement.

      Remedy: Correct UPDATE statement.  The SET clause within an UPDATE
	      statement has the general form of
		   SET column-name = expression

00924 PRS CST Column <name> specified more than once

      Reason: A SQL statement is attempting to create a table or view, perform
	      an insert or update, rename a column, or use the ORDER BY or
	      GROUP BY clause and the same column name is specified for two
	      (or more) columns.

      Remedy: Correct the SQL statement to specify unique names for each of
	      the columns.

00925 PRS MFK Missing FROM keyword

      Reason: A SQL statement is attempting to revoke user privileges FROM
	      a specific table, revoke connect, DBA, or resource authority
	      FROM users, or is deleting rows FROM a specified table and has
	      failed to properly specify the FROM keyword.

      Remedy: Correct SQL statement.

00926 PRS MNK Missing NULL keyword

      Reason: The keyword NULL has been determined to be missing.

      Remedy: Correct SQL statement.

00927 PRS MOK Missing ON keyword

      Reason: A SQL statement is attempting to grant user privileges ON a
	      table, create an index ON a table, or comment ON a table or
	      column and has failed to properly specify the ON keyword.

      Remedy: Correct SQL statement.

00928 PRS MBK Missing BY keyword

      Reason: A SQL statement is using the ORDER BY clause, GROUP BY clause,
	      or granting connect authority to users IDENTIFIED BY passwords
	      and the BY keyword was not properly specified.

      Remedy: Correct SQL statement.

00929 PRS IDC Invalid DROP command

      Reason: The next keyword immediately following a DROP verb is invalid.

      Remedy: Verify the keyword immediately following the DROP verb keyword
	      is either TABLE, SYNONYM, PUBLIC (synonym), VIEW, INDEX,
	      DATABASE, DBAREA, STOGROUP, TRIGGER, EVENT, or EXTERNAL
	      (function).

00930 PRS IIN Invalid index name

      Reason: The index name specified in a CREATE [UNIQUE] INDEX, DROP
	      INDEX, UPDATE STATISTICS, or CHECK INDEX is invalid.

      Remedy: Correct SQL statement.  An index name can be a qualified or
	      unqualified long identifier.  The qualified form is an
	      userid followed by a period and a long identifier.  An
	      unqualified index name in a SQL statement is implicitly
	      qualified by the userid of the user who issued the statement.

00931 PRS IVD Invalid date and/or time

      Reason: An invalid date was determined in the SQL statement.

      Remedy: Correct SQL statement.

00932 PRS TMC Too many columns defined

      Reason: Attempting to execute a CREATE TABLE, CREATE VIEW, or ALTER
	      TABLE to add columns and the number of columns exceeds the
	      maximum (253) number of columns allowed for any table or view.

      Remedy: Modify the SQL statement so it does not exceed the maximum (253)
	      number of columns allowed.

00933 PRS ICL Invalid CLIENT LIMIT value.

      Reason: An attempt was made to set the CLIENT LIMIT out of bounds of
	      the legal limits.  The CLIENT LIMIT may be set to a number
	      between 1 and 255.

      Remedy: Modify the Server statement so the CLIENT LIMIT is between 1
	      and 255.

00934 PRS IVN Invalid number

      Reason: The database is attempting to parse a number in a SQL statement
	      and is finding the number to be invalid.

      Remedy: Correct SQL statement.

00935 PRS CLX CLIENT LIMIT exceeds the number of clients allowed by this server

      Reason: This server is licensed to support a limited number of clients
	      and an attempt was made to set the CLIENT LIMIT above the
	      licensed limit.

      Remedy: Reduce the CLIENT LIMIT to be less than or equal to the number
	      of licensed clients for this server.

00936 PRS IAO Invalid ALTER option

      Reason: An unexpected or missing keyword found immediately after the
	      ALTER verb keyword.

      Remedy: Correct ALTER SQL statement.

00937 PRS SFN Set function not allowed here

      Reason: A set function was found that is not allowed in conjuction with
	      the current nesting level and various set function rules.

      Remedy: Correct SQL statement.

00938 PRS ICD Invalid CLIENT DBA option

      Reason: The option specified for DBA was not ON or OFF.  These are the
	      only allowable options for SET CLIENT DBA.

      Remedy: Correct the SET CLIENT DBA option to be either ON or OFF

00939 PRS IAS Invalid asterisk

      Reason: While parsing a SELECT statement the system has determined an
	      invalid asterisk.

      Remedy: Correct SQL statement.

00940 PRS ITA Invalid tablename.*

      Reason: An invalid tablename.* has been determined.

      Remedy: Correct SQL statement.

00941 PRS MAK Missing AND keyword

      Reason: The AND keyword is missing from a BETWEEN predicate clause.

      Remedy: Correct SQL statement.  The BETWEEN predicate clause has the
	      general syntax of:
		   expression [NOT] BETWEEN expression AND expression

00942 PRS AWC Asterisk allowed only with COUNT

      Reason: An asterisk has been found in a function and the function is
	      not the COUNT(*) function.

      Remedy: Correct SQL statement.

00943 PRS MTK Missing TO keyword

      Reason: Attempting to GRANT authority TO a user or attempting to ALTER
	      an old password TO a new password and the TO keyword is missing.

      Remedy: Correct SQL statement.

00944 PRS UST Duplicate user name <name> in list

      Reason: While parsing the list a users, the same user name has been
	      found to appear more than once.

      Remedy: Correct SQL statement.

00945 PRS IPW Invalid password

      Reason: Attempting to grant connect authority to a user or attempting
	      to change a password and the one of the specified passwords has
	      been found to be invalid.

      Remedy: Correct SQL statement.

00946 PRS IWI Invalid WITHOUT INDEXES clause

      Reason: Attempting a CHECK TABLE command with the WITHOUT INDEXES
	      clause but the keywords WITHOUT and/or INDEXES are either
	      missing or misspelled.

      Remedy: Correct SQL statement.

00947 PRS IUN Invalid user name

      Reason: Attempting to grant connect authority to any number of users and
	      one of the specified usernames has been found to be invalid.

      Remedy: Correct SQL statement.

00948 PRS IPR Invalid privilege specified

      Reason: Attempting to grant table privileges and one of the specified
	      privileges is invalid.

      Remedy: Correct SQL statement.  Valid privileges are ALL, SELECT,
	      INSERT, DELETE, INDEX, ALTER, or UPDATE columname.

00949 PRS MID Missing IDENTIFIED keyword

      Reason: Attempting to grant connect authority to a user or users and
	      the keyword IDENTIFIED is missing or misspelled.

      Remedy: Correct SQL statement.  The grant connect authority syntax is:
		   GRANT CONNECT TO authorization-id IDENTIFIED BY password

00950 PRS MIS Missing IS keyword

      Reason: Attempting a COMMENT ON statement and the keyword IS is missing
	      or misspelled.

      Remedy: Correct SQL statement.  The COMMENT ON syntax is:
		   COMMENT ON TABLE tablename IS string-constant
			or
		   COMMENT ON COLUMN columnname IS string-constant

00951 PRS COM Invalid COMMENT command

      Reason: Attempting a COMMENT ON statement and the COMMENT ON TABLE
	      keywords are not immediately followed by a table name or view
	      name, or the COMMENT ON COLUMN is not immediately followed by a
	      column name.

      Remedy: Correct SQL statement.

00952 PRS MDK Missing data type keyword

      Reason: Attempting a CREATE TABLE or ALTER TABLE to add or modify a
	      column and the data type specified is misspelled or missing.

      Remedy: Correct SQL statement.  Check valid data types in the SQL
	      Language Reference Guide.

00953 PRS MTN Missing table name

      Reason: Attempting a COMMENT ON COLUMN tablename.columnname or
	      viewname.columnname and the tablename or viewname is missing.

      Remedy: Correct SQL statement.

00954 PRS GBE GROUP BY under EXISTS

      Reason: Attempting a GROUP BY clause under an EXISTS predicate clause.

      Remedy: Correct SQL statement.  The EXISTS predicate tests for the
	      existence of certain rows in a table.  The testing of existence
	      cannot be grouped.

00955 PRS MSC SELECT clause of a subquery specifies multiple columns

      Reason: In the context in which it was used in the SQL statement, the
	      subquery can have only one column specified in its SELECT clause
	      because this is not an EXISTS subselect and because it uses
	      multiple columns.

      Remedy: Correct the syntax of the SQL statement.	Refer to the SQL
	      Language Reference Manual for information about restrictions on
	      the syntax for subqueries.

00956 PRS ISO Invalid SYSTEM ONLY clause

      Reason: Attempting a CHECK DATABASE command with the SYSTEM ONLY clause
	      but the keywords SYSTEM and/or ONLY are either missing or
	      misspelled.

      Remedy: Correct SQL statement.

00957 PRS IUI Invalid UNION

      Reason: Attempting a UNION of two SELECT statements and the second
	      SELECT statement is missing.

      Remedy: Correct SQL statement.

00958 PRS SSR Subselect required

      Reason: Attempting a subselect but the first keyword after the left
	      parenthesis is not a SELECT keyword.  It may be missing or just
	      misspelled.

      Remedy: Correct SQL statement.

00959 PRS IWC Invalid wait code

      Reason: Attempting a WAIT or POST command and the event number specified
	      is invalid or missing.

      Remedy: Correct SQL statement.  The WAIT or POST command has the general
	      form of WAIT n or POST n where n is some valid integer.

00960 PRS MFO Missing FOR keyword

      Reason: Attempting a CREATE SYNONYM statement or a ALTER TABLE statement
	      for user specified referential integrity errors and the FOR
	      keyword is either missing or misspelled.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for information on the syntax of the CREATE SYNONYM statement
	      and the ALTER TABLE statement for user specified referential
	      integrity errors.

00961 PRS ISN Invalid SYNONYM name

      Reason: Attempting to create or drop a synonym and the specified synonym
	      name is invalid.

      Remedy: Correct SQL statement.  A synonym name can be any long
	      identifier that designates a table or view.  A synonym name can
	      be used wherever a table name or view name could be used to
	      reference a table or view.

00962 PRS MSL Missing SELECT keyword

      Reason: Attempting a CREATE VIEW and the SELECT keyword is missing or
	      misspelled.

      Remedy: Correct SQL statement.  The create view has a general form of:
		   CREATE VIEW viewname (colnames) AS SELECT...

00963 PRS BNV Bind variable not allowed in view

      Reason: Attempting to create a view and the select statement has bind
	      variables.

      Remedy: Correct SQL statement.  Bind variables are not allowed in a
	      select statement when creating a view.

00964 PRS AUD AUDIT keyword missing or misspelled

      Reason: The keyword AUDIT is either missing or misspelled in the
	      specified START AUDIT or STOP AUDIT command.

      Remedy: Correct SQL statement.  The keyword AUDIT is required
	      immediately after the START or STOP keywords.

00965 PRS TMP Number of passwords exceed number of usernames

      Reason: The number of passwords exceed the number usernames.

      Remedy: Correct SQL statement.  The number of usernames and passwords
	      must be equal.

00966 PRS DIN Delimited identifier not ended

      Reason: A delimited string is not properly ended.

      Remedy: Correct SQL statement.

00967 PRS DIL Delimited identifier is too long

      Reason: A delimited string is too long.

      Remedy: Correct SQL statement.

00968 PRS TMO Too many operands

      Reason: Too many operands have been found in an expression.

      Remedy: Correct SQL statement.

00969 PRS NEO Not enough operands

      Reason: Not enough operands have been found in an expression.

      Remedy: Correct SQL statement.

00970 PRS CCN CURRENT OF cursor not allowed

      Reason: Attempting to use a CURRENT OF cursorname clause in a WHERE
	      clause and it is not allowed.

      Remedy: Correct SQL statement.  The CURRENT OF cursorname clause is
	      only allowed in a DELETE and an UPDATE statement.

00971 PRS MOF Missing OF keyword

      Reason: Attempting a CURRENT OF cursorname clause and the OF keyword
	      immediately following the CURRENT keyword is either missing or
	      misspelled.  Or, attempting an ALTER TABLE statement for
	      referential integrity user errors and the mandatory OF keyword
	      is either missing or misspelled.

      Remedy: Correct SQL statement.

00972 PRS ICU Invalid CURRENT OF cursor name

      Reason: Attempting an UPDATE or DELETE with a CURRENT OF cursorname
	      clause  and the cursor name is invalid.

      Remedy: Correct SQL statement.

00973 PRS OCU ORDER BY on column not allowed with union

      Reason: Attempting an ORDER BY clause in a UNION and the order by column
	      has been specified by column name rather than by integer.

      Remedy: Correct SQL statement.  An ORDER BY clause may be used to sort
	      the final result of rows from the UNION of two (or more) tables.
	      When an ORDER BY clause is used with a UNION, you must use an
	      integer specifying the sequence number of the column in the
	      select list.  Refer to the section on the SELECT statement in
	      the SQL Language Reference Guide for further information on the
	      ORDER BY clause.

00974 PRS MBR Missing bar

      Reason: A missing bar (|) has been determined while parsing an
	      expression.

      Remedy: Correct SQL statement.

00975 PRS IPE Invalid decimal precision

      Reason: The precision for the data type of DECIMAL or DEC is invalid.

      Remedy: Correct SQL statement.  Columns declared as DECIMAL or DEC are
	      always associated with a particular precision and scale.
	      Precision is the total number of digits and scale is the number
	      of fractional decimal digits.  If precision and scale are not
	      specified, SQLBase uses a default precision of 5 and a default
	      scale of 0.

00976 PRS ISA Invalid decimal scale

      Reason: The scale for the data type of DECIMAL or DEC is invalid.

      Remedy: Correct SQL statement.  Columns declared as DECIMAL or DEC are
	      always associated with a particular precision and scale.
	      Precision is the total number of digits and scale is the number
	      of fractional decimal digits.  If precision and scale are not
	      specified, SQLBase uses a default precision of 5 and a default
	      scale of 0.

00977 PRS MKK Missing CHECK keyword

      Reason: Attempting a CREATE VIEW viewname AS select WITH CHECK OPTION
	      and the keyword CHECK immediately following the keyword WITH is
	      either missing or misspelled.

      Remedy: Correct the SQL CREATE VIEW statement.

00978 PRS MSK Missing AS keyword

      Reason: Attempting either a CREATE VIEW or a CREATE DBAREA and the AS
	      keyword is missing or misspelled.

      Remedy: Correct SQL statement.

00979 PRS PSR Plus sign required for outer join

      Reason: Attempting to use the outer join syntax in a select statement
	      and a plus sign (+) should immediately follow a column name.

      Remedy: Correct SQL statement.

00980 PRS IOJ Illegal outer join specification

      Reason: Attempting an outer join in a select statement there are not
	      exactly two operands, or not both column operands, or there is
	      not a relational operator causing this to be an illegal outer
	      join specification.

      Remedy: Correct SQL statement.

00981 PRS ASC Invalid audit string constant

      Reason: The specified audit string constant is not correctly enclosed
	      in single quotes or exceeds 254 characters.

      Remedy: Correct SQL statement.

00982 PRS CUM User names for index and table must be the same

      Reason: Trying to create an index and the user name qualifying the index
	      name does not match the user name qualifying the table name.

      Remedy: Correct SQL statement.  Verify that the user names qualifying
	      both the index name and user name are the same and not
	      misspelled.  An unqualified user name defaults to the user name
	      attempting to create the index.

00983 PRS FNA Function not allowed in create index

      Reason: Attempting to create an index and the specified function is not
	      allowed.

      Remedy: Correct SQL statement.  Not all @functions may be used to create
	      an index.  For the complete list of @function allowed, see
	      CREATE INDEX in the SQL Language Reference Guide.

00984 PRS MBF Must be function on column

      Reason: Attempting to create an index and using a function that is not
	      being applied to a column.

      Remedy: Correct SQL statement.  An index can be created for a set of
	      column values resulting from applying an @function to the
	      column.  Functions in a create index cannot be nested.  The
	      @function used for the index may have only one argument that is
	      a database column.  Not all @functions may be used to create an
	      index.  For the complete list of @function allowed, see CREATE
	      INDEX in the SQL Language Reference Guide.

00985 PRS MPK Missing PRECISION keyword

      Reason: Attempting to create or modify a column with a data type of
	      DOUBLE PRECISION and the keyword PRECISION is missing or
	      misspelled.

      Remedy: Correct SQL statement.

00986 PRS IFN Invalid FLOAT number

      Reason: Trying to create or modify a column with a data type of FLOAT
	      and the format has been specified but with an invalid number.

      Remedy: Correct SQL statement.  The data type for float can have the
	      form of FLOAT or FLOAT(integer).	A FLOAT number can be an
	      integer between 1 and 21 inclusive if specifying a single
	      precision floating point number.	A number between 22 and 53
	      inclusive means that the format is of double precision floating
	      point.  If the integer is omitted, double precision is assumed.

00987 PRS IVW Invalid view name

      Reason: Attempting to create a view and the view name is not a valid
	      long identifier.

      Remedy: Correct SQL statement.  A qualified or unqualified name that
	      can designate a view.  The unqualified form of a view name is a
	      long identifier.	The qualified form is an authorization-id
	      followed by a period and a long identifier.  An unqualified
	      view name in a SQL statement is implicitly qualified by the
	      authorization-id of the user who issues the statement.

00988 PRS PMB PCTFREE must be an integer between 0 and 99

      Reason: Attempting a CREATE INDEX or CREATE TABLE and the specified
	      PCTFREE parameter is either not a valid integer or specifies an
	      integer less than zero or greater than 99 percent.

      Remedy: Correct SQL statement.

00989 PRS IAN Invalid audit identifier: <name>

      Reason: The specified audit name is not a valid short identifier.  The
	      length should not be more than 8 characters long and all the
	      characters should be valid identifier characters.

      Remedy: Correct SQL statement.  The specified audit name must be a short
	      short identifier which identifies the name of the audit for
	      later reference by either the STOP AUDIT command or by the AUDIT
	      command to direct a comment to a audit file.

00990 PRS ILC Invalid LABEL ON stateement

      Reason: Attempting a SQL LABEL ON statement has incorrect syntax.

      Remedy: Correct SQL statement.  Check the SQL Language Reference Manual
	      for information on the LABEL ON statement.  Possible problems
	      include an invalid keyword or identifier after the LABEL ON
	      keywords, or specifying conflicting usernames, conflicting
	      tablenames, or an asterisk instead of fully specifying the
	      column names, or the string-constant specified after the IS
	      keyword is invalid.

00991 PRS ILP Invalid LIKE predicate

      Reason: Odd number of backslash (\) escape characters at the end of the
	      LIKE predicate.

      Remedy: Correct SQL statement.

00992 PRS IRE INTERNAL USE ONLY - Invalid repair type

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

00993 PRS SIM Missing SAVEPOINT identifier

      Reason: A long identifier is required immediately after a SAVEPOINT
	      statement.

      Remedy: Correct the SQL statement.

00994 PRS ICQ Invalid qualifier(s) for object

      Reason: UNIQUE, CLUSTERED, and/or HASHED have been specified on a CREATE
	      statement that is NOT a CREATE INDEX statement.

      Remedy: Correct the SQL statement.  UNIQUE, CLUSTERED, and/or HASHED can
	      only be specified on a CREATE INDEX statement.

00995 PRS BSZ Bad SIZE specification

      Reason: Attempting a CREATE DBAREA, ALTER DBAREA, or CREATE INDEX and
	      the SIZE specification is either not a valid numeric integer or
	      less than zero.

      Remedy: Correct the SQL statement.

00996 PRS SZD SIZE allowed only for HASHED indexes

      Reason: The SIZE clause is only relevant for clustered hashed indexes in
	      the CREATE INDEX statement.

      Remedy: Correct the SQL statement.

00997 PRS SZN SIZE clause required for CLUSTERED HASHED indexes

      Reason: The SIZE clause is required for CLUSTERED HASHED indexes.

      Remedy: Correct the SQL statement.  The SIZE clause controls the
	      anticipated size of the index and is specified as a number of
	      rows.  If the size is too small, overflow pages are used and
	      performance degrades.  If the size is too large, but disk space
	      is wasted.  This clause is only relevant and required when the
	      CLUSTERED HASHED clause is specified.

00998 PRS ONA ASC/DESC not allowed in creation of HASHED CLUSTERED index

      Reason: The ASCending or DESCending options are not allowed when
	      creating a HASHED CLUSTERED index.  The ASC/DESC option is only
	      relevant for B-tree type indexes and not hashed indexes.

      Remedy: Correct the SQL CREATE INDEX statement.

00999 PRS NCH A HASHED index must be CLUSTERED

      Reason: A HASHED index must also be defined as CLUSTERED.

      Remedy: Correct the SQL CREATE INDEX statement.

01000 PRS MOP Missing OPTION keyword

      Reason: Attempting a CREATE VIEW viewname AS select WITH CHECK OPTION
	      and the keyword OPTION immediately following the keyword CHECK
	      is either missing or misspelled.

      Remedy: Correct the SQL CREATE VIEW statement.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors
relating to the edit of nested SQL functions.
01001 EDT NSG Nested set function with no GROUP BY

      Reason: The SQL statement contains a nested set function in the SELECT
	      clause, but no GROUP BY clause.

      Remedy: Correct the SQL statement.  Refer to the SQL Language Reference
	      Manual for information about the use of GROUP BY clauses in SQL
	      statements.

01002 EDT NGC Not a GROUP BY column

      Reason: A column in the SELECT column list that is not an aggregate set
	      function is not in the GROUP BY list.  Or, a column in the
	      SELECT column list that is an aggregate set function that yields
	      a single value is in the GROUP BY list and cannot be grouped.

      Remedy: Correct the SQL statement.  If the column by which a grouping
	      occurs is an expression (but not an aggregate function), you
	      must specify a number that indicates its relative position in
	      the SELECT column list.  Aggregate functions, since they yield
	      one value, cannot be GROUP BY columns.  If using a GROUP BY
	      clause, each column in the SELECT list must be listed in the
	      GROUP BY clause or each column in the SELECT list must be used
	      in an aggregate set function that yields a single value.

01003 EDT NSS Not a single value set function

      Reason: A SELECT statement with no GROUP BY clause contains a column
	      name and a function in the select list clause or a column name
	      is contained in the select list clause but not in the GROUP BY
	      clause.

      Remedy: Correct the SQL SELECT statement.

01004 EDT ICN Integer in ORDER BY/GROUP BY does not identify a valid column

      Reason: A GROUP BY or ORDER BY clause specifies the columns to GROUP BY
	      or ORDER BY by number.  The number specified does not correspond
	      to a column in the select list.  The ORDER BY or GROUP BY clause
	      in the SQL statement contains a column number that is either
	      less than one, or greater than the number of columns of the
	      result table (the number of items in the SELECT clause).

      Remedy: Correct the syntax of the ORDER BY or GROUP BY clause so each
	      column identifier properly denotes a column of the result table.

01005 EDT VCU Non-updatable view column <column name>

      Reason: Attempting to INSERT or UPDATE via a view and a column has been
	      determined to be non-updatable.

      Remedy: Correct the SQL INSERT or UPDATE statement.  See CREATE VIEW in
	      the SQL Language Reference Manual for a complete explanation of
	      what can make a column non-updatable.

01006 EDT MNE Operands of a UNION do not have the same number of columns

      Reason: The operands of a UNION or UNION ALL must have the same number
	      of columns.

      Remedy: Correct the SQL statement so that there are exactly the same
	      number of columns in each operand.

01007 EDT MTE Mismatch in types of SELECT expressions

      Reason: Attempting a SQL SELECT statement with a UNION and corresponding
	      columns of the two SELECTs have different data types, different
	      lengths (if not numeric), or the NOT NULL attributes of two
	      fields are not consistent.

      Remedy: Correct the SQL SELECT statement so that each column of the
	      SELECT statements have the same data type with the same lengths
	      and so that each column defined as NOT NULL in one SELECT
	      statement corresponds to another NOT NULL column in the other
	      SELECT statement.

01008 EDT LNA Long not allowed here

      Reason: Attempting to order or sort a LONG VARCHAR column.

      Remedy: Correct the SQL statement.  LONG VARCHAR columns cannot be
	      ordered or sorted.

01009 EDT DKL DISTINCT key is too long

      Reason: The resulting DISTINCT key is too long.  The DISTINCT key length
	      is computed by summing the maximum length plus one of each
	      column forming the key.

      Remedy: Modify the SQL statement so that the DISTINCT does not exceed
	      the maximum length of 255 characters.  Columns used in the
	      DISTINCT key length computation include not only columns in the
	      SELECT list but also columns mentioned in the ORDER BY clause
	      that are not present in the SELECT list.

01010 EDT MTF Object table/view <name> of INSERT/UPDATE/DELETE also in FROM clause

      Reason: A SQL INSERT, UPDATE, or DELETE statement is illegally
	      self-referencing.  The object table being modified is
	      also the source table in the FROM clause.

      Remedy: Correct the SQL statement.

01011 EDT TMS Too many items are being selected

      Reason: A SELECT statement is attempting to select too many items.
	      There is an upper limit of 255 on the number of items that
	      can be selected in a SELECT statement.

      Remedy: Reduce the number of items being selected in the SELECT
	      statement.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
security type errors.
01101 SEC UAE User already exists

      Reason: Attempting to grant connect authority to a new user and the
	      user name already exists.

      Remedy: Correct the SQL statement.  Verify the existence of established
	      users by looking at the SYSUSERAUTH table.

01102 SEC SVI Security violation attempting to access <object name>

      Reason: Attempting to access an object when authority has not been
	      granted to use the specified object.

      Remedy: Obtain proper authority before attempting to access the
	      specified object.

01103 SEC NGA No grant authority

      Reason: Attempting to grant DBA or resource authority when the user
	      does not have these authority to perform this grants.

      Remedy: None.  Only SYSADM cannot perform the granting of DBA or
	      resource authority.

01104 SEC UNE User <name> does not exist

      Reason: Attempting to alter a user's password or grant DBA or resource
	      authority to a user that does not exist.

      Remedy: Verify that the user exists and that the user name is not
	      misspelled.  Verify that the user exists by looking at the
	      SYSUSERAUTH table.

01105 SEC UAD User <name> already has DBA authority

      Reason: Attempting to grant DBA authority to a user and the user
	      already has DBA authority.

      Remedy: None.  No need to grant DBA authority to a user that already
	      has DBA authority.

01106 SEC UAR User <name> already has resource authority

      Reason: Attempting to grant resource authority to a user and the user
	      already has resource authority.

      Remedy: None.  No need to grant resource authority to a user that
	      already has resource authority.

01107 SEC DCU DBA authority required to create table/view for another user

      Reason: Attempting to create a table or view for another user and the
	      user attempting this operation does not have DBA authority.

      Remedy: None.  A user cannot create a table or view for another user
	      unless they have DBA authority to do so.

01108 SEC IOP Invalid old password

      Reason: Attempting an ALTER PASSWORD and the old password specified is
	      not the current old password.

      Remedy: Correct old password.  You must know the correct old password in
	      order to modify the password.

01109 SEC TGR Trigger security violation

      Reason: Attempting to create a trigger on a subject table without DBA
	      authority.

      Remedy: Obtain proper authority before attempting to create triggers on
	      the subject table.

01110 SEC VNT Event security violation

      Reason: Events can be created only by users with DBA authority.

      Remedy: Obtain DBA authority before attempting to create events.

01111 SEC MSO Stored object <creator>.<name> cannot be found

      Reason: The stored object is missing.

      Remedy: Check spelling of object name.

01112 SEC STO System command or procedure <creator>.<name> security violation

      Reason: EXECUTE privilege cannot be granted on system objects.

      Remedy: None.

01113 SEC XDL Lock Database security violation

      Reason: The LOCK DATABASE and UNLOCK DATABASE commands can only be
	      issued by users with DBA or SYSADM authority.

      Remedy: Obtain DBA or SYSADM authority before attempting to lock or
	      unlock a database.

01114 SEC EXF External Function security violation

      Reason: Only users with DBA or SYSADM authority are allowed to create or
	      drop external functions.

      Remedy: None.  A user cannot create or drop an external function unless
	      they have DBA or SYSADM authority to do so.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
Application Interface Programming errors.
01201 API ICS Invalid column <number> specified

      Reason: An invalid column number has specified in an sqlssb, sqldes,
	      sqlfqn, sqlgfi, sqllab, or sqlgls function call.	Compare the
	      column number specified with the SELECT statement.  Note that
	      column numbers are relative to the position of the columns in
	      the select list clause and are not in anyway related to the
	      position in the CREATE TABLE statement.  For example, if a table
	      is created with the following statement:
		   CREATE TABLE X (A CHAR(5), B CHAR(5), C CHAR(5))
	      and a select is compiled like:
		   SELECT C FROM X
	      then one set select buffer call would be needed to set up a
	      buffer using a column number of 1 for the column named C.

      Remedy: Modify function call.

01202 API MOO Fatal SQLBase System Failure (API MOO) - Message Output Overflow

      Reason: This is a Fatal Error.  But, it may have been caused because the
	      client workstation application is running under an environment
	      like OS/2 and it used multiple threads that submitted multiple
	      API requests when the API is a single threaded operation.  That
	      is, the API expects a message is sent and an answer received
	      before another message is sent.  This error may have occured
	      because the application sent a second message to the database
	      computer without receiving an answer from the first message.

      Remedy: Stop all database activity and run a CHECK DATABASE.  If a
	      FAIL.SQL file is found, save it.	If your application has
	      submitted multiple requests to the application without waiting
	      for replies from the database computer, correct this problem.
	      Otherwise, contact your local Centura Software Corporation
	      certified technical support center.

01203 API CSM Out of memory at the client (API CSM)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

01204 API CEX Bind variables not allowed with sqlcex API function call

      Reason: Bind variables are not permitted in a SQL statement that is
	      compiled and executed with the sqlcex API function call.

      Remedy: Separate the compile and execute (sqlcex) API function call
	      into two distinct API function calls.  First, compile the SQL
	      statement using the sqlcom() API function call, bind the
	      variables appropriately, and then finally, execute the SQL
	      statement using the sqlexe() API function call.

01205 API ITL Bind Variable Name <name> is too long

      Reason: One of the bind variable names is greater than 18 characters.

      Remedy: Correct the bind variable name.

01206 API IRW NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01207 API IID Invalid or missing identifier

      Reason: Attempting an INSERT with an ADJUSTING CURSOR cursor name
	      clause and the cursor name is too big or invalid.

      Remedy: Correct SQL statement.

01208 API CNT NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01209 API BDR Backup directory must be non-null rooted pathname

      Reason: A backup directory specified during a backup, recovery, or
	      restore has been specified incorrectly.  The backup directory
	      must include a fully-qualified path name.

      Remedy: Specify backup directory with a fully-qualified path name.
	      For example, if the backup directory is in C:\SQLBASE\BACKUP
	      then the specified directory must be either "C:\SQLBASE\BACKUP"
	      or "\SQLBASE\BACKUP".  The directory name of "SQLBASE\BACKUP"
	      or "BACKUP" would not be sufficient.

01210 API DBN Database name must be specified

      Reason: The database name has not been specified attempting to perform
	      an INSTALL DATABASE.

      Remedy: Specify a valid database name when doing a INSTALL DATABASE.

01211 API BIF INTERNAL USE ONLY - Bulk insert buffer full

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01212 API IDV Invalid database version

      Reason: The application is using mismatching versions of software or the
	      database version does not correspond to the software.

      Remedy: Verify that the software and database are from the same release
	      of SQLBase.

01213 API BAC Bulk execute mode and autocommit mode cannot be both ON

      Reason: Cannot enable Bulk execute mode and autocommit mode
	      simultaneously.

      Remedy: Disable autocommit mode before trying to enable bulk execute
	      mode OR disable bulk execute mode before trying to enable
	      autocommit mode.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
Message Front End error messages.
01301 MFE IMO Client input message buffer overflow (MFE IMO)

      Reason: The server has detected a condition where the minimum amount of
	      data to send to a client exceeds the buffer size for that data.
	      The server sends this error code back to the client, but does
	      not send any of the data that caused the overflow.  The router
	      at the client detects the condition and automatically attempts
	      to correct for it by allocating a larger input message buffer.
	      The router will automatically re-request the data be sent again
	      using the new buffer size.  The router and the server will
	      continue to negotiate the buffer size until one of the following
	      occurs:

	      1. The server is successfully able to transmit the data to the
		 client, or
	      2. The server or the client router run out of available memory
		 at their respective machines.

	      This error message should only appear at the server.  It should
	      not be seen at the client.  The server and the client router
	      perform the buffer size negotiation without the client's
	      knowledge or participation.  If the client app sees this error,
	      it should be treated as a fatal error.

      Remedy: None.  This message should only appear on the server.
	      It should not be seen by the client application.

01302 MFE IVC Invalid cursor number

      Reason: An invalid cursor number has been used in the current API
	      function call.

      Remedy: Verify that the cursor being used has already been connected to
	      successfully.  A frequent mistake is to call a common error
	      routine in the application program when a failure occurs on the
	      connect operation.  The common error routine then performs a
	      error lookup using the get return code (sqlrcd) function call
	      which uses a cursor number that has not yet been connected to.

01303 MFE NCO Not connected

      Reason: Attempting to use a cursor that has not been succesfully
	      connected to the database.

      Remedy: Use a cursor only after it has been successfully connected to
	      the database.

01304 MFE SCR Server connection required

      Reason: Attempting an operation that requires a server connection.

      Remedy: Use a server connection instead of a database connection.

01305 MFE DCR Database connection required

      Reason: Attempting an operation that requires a database connection.

      Remedy: Use a database connection instead of a server connection.

01306 MFE CAM Out of memory at the client (MFE CAM)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

01307 MFE IFC Invalid function code

      Reason: The function code received by the database system is not valid.

      Remedy: Verify Centura Software Corporation software does not consist
	      of mismatching version numbers.  Check that your application
	      is not clobbering the memory destroying the message sent to
	      the database system.

01308 MFE OLS Fatal SQLBase System Failure (MFE OLS)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01309 MFE CAO Out of memory at the client (MFE CAO)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

01310 MFE RWF INTERNAL USE ONLY - Row won't fit in message buffer

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01311 MFE CAN Transaction cancelled

      Reason: The transaction was cancelled asynchronously from a different
	      thread which performed a cancel operation.

      Remedy: Determine why the cancel operation was performed by the other
	      transaction.

01312 MFE TRM Transaction terminated

      Reason: The transaction was terminated because the database server
	      program was instructed to terminate.

      Remedy: Determine why the database server has been brought down.

01313 MFE OOM Out of memory at the client (MFE OOM)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

01314 MFE BLK Bulk insert error

      Reason: An insert error has occurred operating in Bulk Execute Mode.
	      One or more rows have not been inserted because of an error
	      attempting to insert the rows.

      Remedy: In bulk execute mode, inserts are done repeated until filling
	      the bulk execute buffer and then all of the inserts are sent to
	      the database simulatenously.  If this error occurs, the client
	      application needs to check each bulk execute return code with
	      the API function call sqlber to determine which rows were not
	      inserted.

01315 MFE DBD Database has been shut down (please disconnect)

      Reason: Attempting to connect to the database but the database server is
	      being or has been shutdown.

      Remedy: None.  Try connecting later when the database server is back up.

01316 MFE NET Network check error (back end)

      Reason: A network transmission problem has occurred while operating with
	      NETCHECK=1.  A network transmission error was detected at the
	      database server.	When the database server detects the network
	      transmission problem it will try to recover from the error.  An
	      informational message, "Back end sends NAK" is displayed.  For
	      an unrecoverable message, an error message "Back end detects
	      mismatched checksum" is displayed on the F2 screen and this
	      error is return to the client workstation if the message can be
	      sent to the client.

      Remedy: Try again to see if the error is reproducible.  If reproducible,
	      try the same scenario on another client workstation computer to
	      double check if the problem is reproducible regardless of client
	      workstations.  If the problem is reproducible on any client
	      workstation, then the network hardware problem may be at the
	      database server computer.  Switching database server machines
	      may also help to diagnose the problem.  Check for loose cabling.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
dictionary look up errors.
01401 DLU ICN Invalid column name <column name>

      Reason: An invalid column has been used in the select list.

      Remedy: Correct the SQL statement.

01402 DLU ACR Ambiguous column <column name> reference

      Reason: Column is already defined.

      Remedy: Correct the SQL statement.

01403 DLU ITN Invalid table name <table name>

      Reason: An invalid table name has been determined while attempting to
	      lookup the columns for the specified table.

      Remedy: Correct the SQL statement.

01404 DLU MNV Mismatch in number of values

      Reason: Attempting an INSERT with a nested subselect and the number of
	      columns in the select statement does not correspond to the
	      number of columns in the insert statement.

      Remedy: Correct the SQL statement.

01405 DLU RWV NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01406 DLU VNA View <view name> not allowed here

      Reason: A view is not allowed here.

      Remedy: Correct the SQL statement.

01407 DLU CUV Cannot update view <view name>

      Reason: Attempting to update through a view that is a read only view.

      Remedy: Correct the SQL statement.

01408 DLU RNA NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01409 DLU ARV Ambiguous use of ROWID with a view

      Reason: Attempting to use a ROWID with a view and a table.

      Remedy: Correct the SQL statement.

01410 DLU OOJ Only one outer join table allowed

      Reason: Only one outer join is allowed per SELECT.

      Remedy: Correct the SQL statement.

01411 DLU ICF Insert columns must contain all the foreign key columns

      Reason: Attempting an INSERT a row and columns participating in the
	      foreign key are not among the columns being inserted.

      Remedy: Correct the SQL statement.  All foreign key columns must be
	      inserted.

01412 DLU ICP Insert columns must contain all the primary key columns

      Reason: Attempting to INSERT a row and columns participating in the
	      primary key are not among the columns being inserted.

      Remedy: Correct the SQL statement.  All primary key columns must be
	      inserted.

01413 DLU PTI Parent table <username>.<tablename> in incomplete state

      Reason: Attempting to create a foreign key on an incomplete table.

      Remedy: Create the unique index on the primary key so that the table is
	      considered complete before trying to create any foreign keys.

01414 DLU DCS Invalid DELETE with WHERE CURRENT OF

      Reason: A DELETE operation with a WHERE CURRENT OF cursorname attempted
	      to delete from a self-referencing table.

      Remedy: Do not attempt to delete from a self-referencing table with
	      WHERE CURRENT OF cursorname in the DELETE statement.

01415 DLU DMR Dependent table in subquery must have RESTRICT delete rule

      Reason: A dependent table is in a subquery where the relationship
	      between parent table and the dependent table does not have the
	      RESTRICT delete rule.

      Remedy: None.  A dependent table in a subquery must have the RESTRICT
	      delete rule.

01416 DLU UCP Invalid UPDATE with WHERE CURRENT OF

      Reason: An UPDATE operation with WHERE CURRENT OF attempted to update a
	      primary key of the object table.

      Remedy: Do not attempt to update a primary key with WHERE CURRENT OF in
	      the UPDATE statement.

01417 DLU TIC Table <tablename> in incomplete state

      Reason: Attempting to INSERT, UPDATE, or DELETE on an incomplete table.

      Remedy: Create the unique index on the primary key so that the table is
	      considered complete before attempting to INSERT, UPDATE, or
	      DELETE any data in the incomplete table.

01418 DLU TAP Table <tablename> already has a primary key

      Reason: A primary key cannot be defined because the target table
	      already has a primary key.

      Remedy: None.  A table cannot have more than one primary key.

01419 DLU PCN Primary key column must be NOT NULL or NOT NULL WITH DEFAULT

      Reason: The primary key cannot be defined because one or more of the
	      columns forming this primary key are defined not as a NOT NULL
	      or NOT NULL WITH DEFAULT.

      Remedy: Correct definition of primary key or modify the columns forming
	      the primary key so each column is defined as either NOT NULL or
	      NOT NULL WITH DEFAULT.

01420 DLU TCK INTERNAL USE ONLY - Table in check pending state

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01421 DLU FND Foreign key not found in dictionary

      Reason: Attempting to drop a foreign key or attempting to add, drop, or
	      modify a referential integrity user error and the specified
	      foreign key does not exist.

      Remedy: Correct the SQL statement.  Verify that the foreign key exists
	      and check the spelling of the foreign key name.

01422 DLU PND Primary key not defined yet

      Reason: Attempting to drop a primary key and the specified primary key
	      does not exist.

      Remedy: Correct the SQL statement.  Verify that the primary key exists
	      and check the spelling of the primary key name.

01423 DLU CPS Cannot add primary key to system table <tablename>

      Reason: Cannot add a primary key to a system catalog table.

      Remedy: None.  A primary key cannot be added to a system catalog table.

01424 DLU CFS Cannot add foreign key to system table <tablename>

      Reason: Cannot add a foreign key to a system catalog table.

      Remedy: None.  A foreign key cannot be added to a system catalog table.

01425 DLU MSC Must be single column subselect

      Reason: Query not allowed because the results could be ambiguous, that
	      is, the subselect which is the target of the WHERE clause can
	      produce multiple values.

      Remedy: None.  A subselect cannot produce multiple values.  The
	      subselect must produce a single column.

01426 DLU NUS No user error for system table <tablename>

      Reason: Cannot add referential integrity user errors for system tables.

      Remedy: None.  Referential integrity user errors cannot be added to a
	      system catalog table.

01427 DLU RIV ROWID not allowed on this view <username>.<viewname>

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

01428 DLU DIC dependent table <tablename> in incomplete state

      Reason: Cannot delete or update rows in parent table when the dependent
	      table is in an incomplete state.

      Remedy: Lift dependent table from incomplete state by creating a primary
	      key for the dependent table.

01429 DLU NUC Update column does not exist in subject table

      Reason: Attempt to create a trigger on a non-existent column of subject
	      table.

      Remedy: Correct CREATE TRIGGER statement.

01430 DLU NPC Column specified as parameter does not exist in subject table

      Reason: Attemtp to create a trigger by specifying a non-existent column
	      of the subject table as procedure parameter.

      Remedy: Correct CREATE TRIGGER statement.

01431 DLU TMU Update column does not exist in subject table

      Reason: Attempt to create a trigger on a non-existent column of subject
	      table.

      Remedy: Correct CREATE TRIGGER statement.

01432 DLU DTC dependent table in incomplete state

      Reason: Cannot delete or update rows in parent table when the dependent
	      table is in incomplete state

      Remedy: Lift dependent table from incomplete state by creating a primary
	      index for it.

01433 DLU IDE Index does not exist

      Reason: Updating statistics for an index that does not exist.

      Remedy: Find correct index name and retry.  All current index names can
	      be determined by querying the SYSINDEXES tables.

01434 DLU CMM Stored-command does not exist.

      Reason: Attempt to alter a non-existent stored-command.

      Remedy: Correct misspelled or supply proper command name.

01435 DLU UNT Cannot unload non-existent table

      Reason: Attempt to unload a table that does not exist.

      Remedy: Correct the table name(s).

01436 DLU SEC Cannot unload inaccessible table

      Reason: Attempt to unload a table without proper privileges

      Remedy: Obtain the required privileges from the table owner(s).

01437 DLU NUP Column <view name>.<column name> is not updatable

      Reason: Cannot update a column created with aggregate function or
	      expression in a view

      Remedy: Remove the column from the FOR UPDATE OF clause.

01438 DLU FNF Function <name> has not been created.

      Reason: A reference has been made to an external function that is not
	      known to database.

      Remedy: Use an already defined function or add the definition of this
	      function into the database.

01439 DLU STN Cannot define trigger on system table.

      Reason: Triggers are not allowed on system tables.

      Remedy: Do not define triggers on system tables.

01440 DLU EFE External function or synonym <name> already exists

      Reason: The specified external function name already exists as an
	      external function or external function synonym.

      Remedy: Use a different external function name.  External function names
	      cannot be the same as an existing stored command, stored
	      procedure, external function or external function synonym.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
sort type errors that may occur when performing database operations that
require a sort like using the ORDER BY or GROUP BY clauses.
01501 SRT CCR Cannot create sort file

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

01502 SRT QST Fatal SQLBase System Failure (SRT QST)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01503 SRT WTS Out of memory at the database computer (SRT WTS)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

01504 SRT EOF Fatal SQLBase System Failure (SRT EOF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01505 SRT RWF Disk Write Failure (SRT RWF)

      Reason: Attempting to write to a file and a disk write failure has
	      occurred.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

01506 SRT CSS Out of memory at the database computer (SRT CSS)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
data type checking errors.
01601 TYP IDT Invalid data type

      Reason: An operand cannot be coerced into a valid data type.  Or, a LONG
	      VARCHAR data type was expected and was not provided, or a LONG
	      VARCHAR data type was specified when it is not expected.

      Remedy: Correct the SQL statement by providing valid data types.

01602 TYP MBB Long must be set to bind variable

      Reason: LONG VARCHAR data must be bound to a set variable.

      Remedy: Correct the SQL statement.

01603 TYP OLO Cannot order long data

      Reason: Attempting a GROUP BY or ORDER BY on a LONG VARCHAR column.

      Remedy: Correct the SQL statement.  SQL cannot GROUP BY or ORDER BY a
	      LONG VARCHAR column.

01604 TYP CUR Cannot update or insert a ROWID column

      Reason: Attempting to update or insert a ROWID column.

      Remedy: Correct the SQL statement.  ROWIDs are unique and assigned by
	      the SQLBase system.

01605 TYP CMS Cannot modify system data in system table <name>

      Reason: Attempting to insert or delete rows of data from a system table.
	      Or, attempting to insert or update data in a system table.

      Remedy: None. Systems tables are maintained by the database system.

01606 TYP IDA Invalid date arithmetic

      Reason: Attempting to perform an arithmetic operation on a date and
	      the operation is considered invalid.

      Remedy: Correct the SQL statement.

01607 TYP IET Invalid external data type

      Reason: An invalid external data type has been specified.

      Remedy: Correct the SQL statement.

01608 TYP IIS Date/time interval only expressions not allowed in select list

      Reason: A date/time interval with only a year, a month, a day, or a time
	      interval is not allowed in the select list.

      Remedy: Correct the SQL statement.

01609 TYP INC Date/time interval comparisons are not allowed

      Reason: A date/time interval with only a year, a month, a day, or a time
	      interval is not allowed in the comparison.

      Remedy: Correct the SQL statement.

01610 TYP CCL Cannot compare Long VARCHAR data

      Reason: LONG VARCHAR data cannot be specified in a comparison.

      Remedy: Correct the SQL statement.

01611 TYP MBC Must be a column to perform this function

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

01612 TYP DNC Must be character data type to perform this function

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

01613 TYP NVL @NULLVALUE column must be replaced by same data type value

      Reason: Attempting to use the @NULLVALUE function replacing a column
	      with a replacement value that is not of the same data type.

      Remedy: Correct the SQL statement.  A column in an @NULLVALUE function
	      can only be replaced by a value of the same data type.

01614 TYP TFP Too many procedure function parameters

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

01615 TYP PNN Number of parameters does not match

      Reason: The number of parameters in function call does not match
	      the number of parameters supposed to be.

      Remedy: Check the parameters and change the parameters used in the
	      function call.

01616 TYP MVC Must be a variable or a constant

      Reason: The parameter must be a variable or a constant to get data
	      from database

      Remedy: Check the parameters and change the parameters used in the
	      function call.

01617 TYP TPO Output parameter in procedure cannot be supported

      Reason: Trigger cannot process output from a procedure.

      Remedy: Correct the procedure or use an appropriate substitute.

01618 TYP TPT Invalid parameter type for procedure/external function

      Reason: Parameter type does not match corresponding procedure or
	      external function requirement.

      Remedy: Correct the parameter.

01619 TYP TPC Too few/many parameters for procedure

      Reason: Number of parameters must match procedure requirement.

      Remedy: Provide the correct number of procedure parameters.

01620 TYP MPR Specified procedure does not exist

      Reason: Procedure does not exist or its name is misspelled.

      Remedy: Correct the procedure name or create the intended procedure.

01621 TYP VSC Stored command not allowed

      Reason: Only stored or inline procedure is allowed.

      Remedy: Correct the CREATE TRIGGER or CREATE EVENT command to use a
	      procedure.

01622 TYP UFC Undefined procedure function call

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

01623 TYP BOO Invalid data type (boolean expected)

      Reason: A boolean value is expected.

      Remedy: Correct the construct.

01624 TYP NUM Invalid data type (number expected)

      Reason: A numeric value is expected.

      Remedy: Correct the construct.

01625 TYP STR Invalid data type (string expected)

      Reason: A string value is expected.

      Remedy: Correct the construct.

01626 TYP DTM Invalid data type (date/time expected)

      Reason: A date/time value is expected.

      Remedy: Correct the construct.

01627 TYP LON Invalid data type (long expected)

      Reason: A long value is expected.

      Remedy: Correct the construct.

01628 TYP BBO Invalid boolean type detected

      Reason: A boolean value occurs where it is not allowed.

      Remedy: Correct the construct.

01629 TYP BNU Invalid number type detected

      Reason: A numeric value occurs where it is not allowed.

      Remedy: Correct the construct.

01630 TYP BST Invalid string type detected

      Reason: A string value occurs where it is not allowed.

      Remedy: Correct the construct.

01631 TYP BDT Invalid date/time type detected

      Reason: A date/time value occurs where it is not allowed.

      Remedy: Correct the construct.

01632 TYP BLO Invalid long type detected

      Reason: A long value occurs where it is not allowed.

      Remedy: Correct the construct.

01633 TYP MBS Triggerred stored procedure <procedure name> must be static.

      Reason: A trigger can execute only static stored procedures..

      Remedy: Call a static procedure.

01634 TYP DNA Delete triggers can not use receive parameters.

      Reason: A delete trigger is not allowed to use receive parameters to
	      modify data passed into the triggerred stored procedure.

      Remedy: Use only non-receive parameters.

01635 TYP ATR AFTER triggers can not use receive parameters.

      Reason: An AFTER trigger is not allowed to use receive parameters to
	      modify data passed into the triggerred stored procedure.

      Remedy: Use only non-receive parameters.

01636 TYP MBV Only variables can be passed as receive parameters.

      Reason: Expressions or constants cannot be passed as receive
	      parameters to external functions.

      Remedy: Change the parameter to be a procedure variable.

01637 TYP FNS External function support not available in this SqlBase version.

      Reason: The ability to call out to external functions residing in
	      DLLs is not avaliable in this version of SqlBase.

      Remedy: None.

01638 TYP PMC Parameter must be a column type.

      Reason: Only columns can be passed as receive parameters to triggerred
	      stored procedures.

      Remedy: Use only columns for receive parameters.

01639 TYP ONA Old column values cannot be modified by a trigger.

      Reason: Only new column values can be modified by passing as a
	      receive parameters to triggerred stored procedures.

      Remedy: Use only new column values for receive parameters.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
application programming interface type errors.
01701 GPI INF Invalid function call

      Reason: The genernal programming interface has dispatched an invalid
	      function call.

      Remedy: If using the standard Microsoft C 5.1 compiler, the Micro Focus
	      COBOL interface, or the Realia COBOL interface then contact your
	      local Centura Software Corporation certified technical
	      support center for assistance.  If using the general
	      programming interface with another programming language or
	      compiler, then verify the general programming interface
	      program is passing a valid function call number.

01702 GPI DNI NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01703 GPI IPL Incorrect parameter length

      Reason: The general programming interface has dispatched a message and
	      the parameter length is incorrect.

      Remedy: If using the standard MicroSoft C 5.1 compiler, the Micro Focus
	      COBOL interface, or the Realia COBOL interface then contact your
	      local Centura Software Corporation certified technical support
	      center for assistance.  If using the general programming
	      interface with another programming language or compiler, then
	      verify the general programming interface program is passing a
	      valid message.

01704 GPI IDT Invalid dispatch table

      Reason: The dispatch table in the general programming interface has
	      been determined to be invalid.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

01705 GPI IPM Invalid parameter

      Reason: A windows applications has called SQLDON accidentally.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

01706 GPI OUD Out of memory at the client (GPI OUD)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

01707 GPI RMD Real mode database

      Reason: The database code is running in real mode and the application
	      program is running in protected mode, the database code cannot
	      access the application's data.  The database code cannot
	      convert a protected mode descriptor into a real mode address.

      Remedy: Run database and application program in same mode.

01708 GPI OOM Out of memory at the client (GPI OOM)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are general
database lock manager errors.
01801 LKM DLK Application deadlock

      Reason: The database system has determined a user deadlock situation.
	      A deadlock situation is an occurence such that two or more
	      transactions are in a simultenous wait state, each one waiting
	      for one of the other to release a lock before it can proceed.
	      SQLBase detects deadlocks immediately, that is, without waiting
	      the duration of the timeout period.  If SQLBase detects a
	      deadlock it will break the deadlock by rolling back the
	      transaction that detected the deadlock and return this error
	      message to the detector.	The other transaction will continue
	      not even knowing a deadlock situation was determined.

      Remedy: Determine what transactions are becoming deadlocked and attempt
	      to make changes so that the deadlock situation does not occur
	      frequently.  A COMMIT as often as possible often helps to avoid
	      deadlocks.

01802 LKM ILE Insufficient lock entries

      Reason: The database server has exceeded the number of possible locks.

      Remedy: Increase the number of database server locks by changing the
	      configuration parameter in the SQL.INI file associated with the
	      database server.	The parameter is LOCKS=nnn.  This parameter
	      sets the maximum number of lock entries that will be allocated.
	      Locks entries are dynamically allocated as they are needed in
	      groups of 100.  If the LOCKS= parameter is not used, locks will
	      be allocated as needed until there is not enough memory left.
	      The only time you need to specify this keyword is when you are
	      trying to protect against a run-away application that is
	      accessing too much data in one transaction.  If you are getting
	      this error, then chances are good that you have a run-away
	      application on your hands.

01803 LKM ITC Fatal SQLBase System Failure (LKM ITC)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01804 LKM ILC Fatal SQLBase System Failure (LKM ILC)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01805 LKM TMO Time out

      Reason: The transaction is waiting for a resource currently locked by
	      another transaction.  The transaction will wait by default 275
	      seconds unless specified otherwise.

      Remedy: Determine what transaction is locking the resouces and attempt
	      to make changes so that the wait situation does not occur
	      frequently.  A COMMIT as often as possible often helps to avoid
	      these time out condition.  To reduce the time wait period you
	      can use the set timeout function call (sqltio) or in SQLTalk you
	      can SET TIMEOUT n where n is the number of seconds.  The number
	      of seconds can range from 1 to 1800 seconds (30 minutes).

01806 LKM OLE Fatal SQLBase System Failure (LKM OLE)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01807 LKM TMP Fatal SQLBase System Failure (LKM TMP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01808 LKM CAL Out of memory at the database computer (LKM CAL)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

01809 LKM LPB Out of memory at the database computer (LKM LPB)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

01810 LKM WST NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01811 LKM FDU Fatal SQLBase System Failure (LKM FDU)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01812 LKM IWS Out of memory at the database computer (LKM IWS)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

01813 LKM UND Lock held by undecided transaction.

      Reason: The user tried to lock a database page that is owned by an
	      undecided distributed transaction. Such a  lock may be
	      held for an indefinite amount of time -- until the distributed
	      transaction is resolved. Until the transaction is resolved
	      the user will not be able to access the page in question.

      Remedy: Either make sure that the distributed transaction gets resolved
	      (see the manual) or if that is not possible, do not access
	      the page.

01814 LKM ROD NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01815 LKM NXL The database is not exclusively locked.

      Reason: Cannot perform an UNLOCK DATABASE command, since the database
	      is currently not exclusively locked.

      Remedy: If multiple LOCK DATABASE commands are issued, only the first
	      instance causes the database to be exclusively locked. If
	      multiple (matching) UNLOCK DATABASE commands are issued, the
	      first instance will release the exclusive database lock;
	      therefore additional UNLOCK DATABASE requests will find
	      the database already unlocked. Remove extraneous UNLOCK
	      DATABASE commands to eliminate this error.

01816 LKM IXL The database is already exclusively locked.

      Reason: Cannot perform a LOCK DATABASE command, since the database
	      is already exclusively locked.

      Remedy: If multiple LOCK DATABASE commands are issued, only the first
	      instance causes the database to be exclusively locked. If
	      multiple (matching) UNLOCK DATABASE commands are issued, the
	      first instance will release the exclusive database lock.
	      Remove extraneous LOCK DATABASE commands to eliminate this
	      error.

01817 LKM ISL Database could not be locked because other connections exist.

      Reason: The first connection by any transaction acquires a shared
	      database lock, which is released upon the last disconnect
	      for the transaction.  Your attempt to exclusively lock the
	      database, using the LOCK DATABASE command, failed because
	      you are waiting for a resource currently locked (in shared
	      mode) by another transaction. Your LOCK DATABASE request
	      will succeed when all shared database locks by other
	      transactions have been released.

      Remedy: Determine what other transactions are connected to the
	      same database.  Your Lock Database request will only succeed
	      after all other connected transactions have disconnected.

01818 LKM FDX Fatal SQLBase System Failure (LKM FDX)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
SQLBase system type errors.
01901 SYS ICV Fatal SQLBase System Failure (SYS ICV)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01902 SYS SNA Fatal SQLBase System Failure (SYS SNA)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01903 SYS EXC Fatal SQLBase System Failure (SYS EXC)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01904 SYS CGD Fatal SQLBase System Failure (SYS CGD)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01905 SYS CSD Fatal SQLBase System Failure (SYS CSD)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01906 SYS MBP Fatal SQLBase System Failure (SYS MBP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01907 SYS MLM Fatal SQLBase System Failure (SYS MBP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01908 SYS NMF No more files

      Reason: This error code indicates that the last file name has been read
	      indicating an end of the directory has been reached.

      Remedy: None.  Informational only.

01909 SYS PNF Path not found or name exceed maximum range

      Reason: Attempting to open a directory or read files from a directory
	      and the directory path has not been found or the directory name
	      exceeds the maximum range.

      Remedy: If the directory is not open, then open it.  If the directory
	      cannot be opened, verify that the specified directory exists.

01910 SYS OCN Unable to obtain local computer name from the registry

      Reason: An attempt to obtain the local computer name from the
	      operating system failed.

      Remedy: Verify that the local computer name exists in the operating
	      system registry.	If it is not present, have the system
	      administrator research and fix the problem.

01911 SYS SCN Unable to set local computer name into the registry

      Reason: An attempt by the server to set a special registry entry
	      to allow access by Windows 3.1 applications has failed.
	      Since the server is a local-user-only server, failing to
	      set the special registry entry is a fatal error.

      Remedy: This error should not occur.  If it does occur, have the
	      system administrator research and fix the problem.

01912 SYS ACC Access violation on opening file

      Reason: UNIX file access violation attempting to open a file.

      Remedy: Verify that the file name was correctly specified and that you
	      have access to the specified file.

01913 SYS BOM INTERNAL USE ONLY - System bombed!

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01914 SYS URF INTERNAL USE ONLY - Unused symbols reference check

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01915 SYS OOM Out of memory when encrypting/decrypting data

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

01916 SYS ICF 003 - Fatal SQLBase System Failure (SYS ICF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01917 SYS CAS 008 - Out of memory at the database computer (SYS CAS)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

01918 SYS FAE Failure already exists

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01919 SYS FNE Failure does not exist

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01920 SYS NDB No DB associated with this cursor

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01921 SYS OCO Only 1 crash-count failure can be setup.

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01922 SYS 000 (Unused, original SYSECAD moved to new home dmnerr.h)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

01923 SYS INP Internal error; Invalid parameters to the routine.

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

01924 SYS NWF Local computer name too large for internal buffer

      Reason: While attempting to retrieve the local computer name from
	      the operating system, the name was found to be too large
	      for the internal buffer used to hold the name.

      Remedy: This error should not occur.  If it does, contact Centura
	      Software Corporation Technical Support.  Before calling,
	      obtain the name of the local computer and have it ready.

01925 SYS AHS Fatal SQLBase System Failure (SYS AHS)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01926 SYS ALS Fatal SQLBase System Failure (SYS ALS)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

01927 SYS DNL Fatal SQLBase System Failure (SYS DNL)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
might occur during the loading of the database program.
02001 LOD IWS Out of memory at the database computer (LOD IWS)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02002 LOD NAI Asynchronous I/O is not available

      Reason: Attempting to enable ASYNCIO configuration parameter and the
	      asynchronous I/O feature is not available with under this
	      operating system.

      Remedy: Asynchronous I/O is only available under OS/2 and UNIX.

02003 LOD ATL Only single characters allowed in this section

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02004 LOD CFC Cannot find COUNTRY.SQL file

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02005 LOD IVC Cannot find specified country in COUNTRY.SQL file

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02006 LOD ICD Invalid directive found in COUNTRY.SQL

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02007 LOD IHX Invalid hexidecimal number in COUNTRY.SQL

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02008 LOD CTB String in COUNTRY.SQL is too large

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02009 LOD NTT Missing second translate string under TRANSLATE section of COUNTRY.SQL

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02010 LOD SMM Many to many translations not allowed in COUNTRY.SQL

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02011 LOD UL1 Strings in UPPER to LOWER section of COUNTRY.SQL must be one character

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02012 LOD UL2 Strings must be in pairs in the UPPER or LOWER section of COUNTRY.SQL

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
can occur when the database is performing file operations.
02101 FIL CLO Cannot close file

      Reason: The database system is attempting to close a file and is getting
	      an operating system error.  This is a Fatal Error.

      Remedy: Try to determine why the operating system cannot close the file.
	      Contact your local Centura Software Corporation certified
	      technical support center.

02102 FIL DEL Cannot delete file

      Reason: The database system is attempting to delete a file and is
	      gettting an operating system error.  This is a Fatal Error.

      Remedy: Try to determine why the operating system cannot delete the
	      file.  Contact your local Centura Software Corporation
	      certified technical support center.

02103 FIL LSK Cannot perform lseek

      Reason: The database system is attempting to seek into a file and is
	      gettting an operating system error.  This is a Fatal Error.

      Remedy: Try to determine why the operating system cannot seek into the
	      file.  Contact your local Centura Software Corporation
	      certified technical support center.

02104 FIL RWF Read or write failure

      Reason: The database system is attempting to read or write to a file and
	      is gettting an operating system error.  This is a Fatal Error.

      Remedy: Try to determine why the operating system cannot read or write
	      to a file.  Contact your local Centura Software Corporation
	      certified technical support center.

02105 FIL CWT Cannot set write-through

      Reason: Attempting to make sure that a file is set for write-through
	      mode.  This means that when data is written, it is actually
	      written to disk and not simply buffered.

      Remedy: Determine why the operating system will not allow the setting
	      for write-through mode.

02106 FIL OOM Out of memory at the database computer (FIL OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02107 FIL AID Asynchronous I/O did not start

      Reason: Attempting to initiate an asynchronous read or write from a
	      file and asynchronous I/O did not start.	This is a Fatal Error.

      Remedy: Determine why asynchronous I/O did not start.

02108 FIL AIF Asynchronous I/O failure

      Reason: An asynchronous read/write failure has occurred. This is a
	      Fatal Error.

      Remedy: Determine why the operating system could not perform the
	      asynchronous I/O operation.

02109 FIL APF Asynchronous I/O position failure

      Reason: An asynchronous positioning within a file failed. This is
	      a Fatal Error.

      Remedy: Determine why the operating system could not perform the
	      asynchronous I/O operation.

02110 FIL CSF Cannot get file descriptor status

      Reason: Attempting to get a file descriptor status and a failure has
	      occurred.

      Remedy: Determine why the operating system could not get the file
	      descriptor status.

02111 FIL PSE Partition size error

      Reason: Attempting to get the partition size and a failure has occurred.
	      This is a Fatal Error.

      Remedy: Determine why the operating system could not get the partition
	      file size.

02112 FIL OOS Out of disk space

      Reason: There is not enough disk space to perform this operation.

      Remedy: Terminate program and remove files to free up disk space.

02113 FIL SAR Asynchronous short read error

      Reason: The database system is attempting to read from a file. The
	      operating system asynchronous disk read request read fewer
	      bytes than requested. This is a Fatal Error.

      Remedy: Determine why the operating system did not return either an
	      error condition or exactly the number of bytes requested.

02114 FIL SAW Asynchronous short write error

      Reason: The database system is attempting to write to a file.  The
	      operating system asynchronous disk write request wrote fewer
	      bytes than requested.  This is a Fatal Error.

      Remedy: Determine why the operating system did not return either an
	      error condition or write exactly the number of bytes requested.

02115 FIL ARE Asynchronous read error

      Reason: The database system is attempting to read from a file. The
	      operating system asynchronous disk read request returned an
	      error. This is a Fatal Error.

      Remedy: Determine why the operating system returned an error.

02116 FIL AWE Asynchronous write error

      Reason: The database system is attempting to write to a file. The
	      operating system asynchronous disk write request returned an
	      error. This is a Fatal Error.

      Remedy: Determine why the operating system returned an error.

02117 FIL IFO FIFO file types are not allowed in this context

      Reason: A file was specified that has been found to be a FIFO.  These
	      are not allowed in this context.

      Remedy: Re-specify a suitable file type.

02118 FIL BLK Block special files are not allowed in this context

      Reason: A file was specified that has been found to be a block special
	      file. These are not allowed in this context.

      Remedy: Re-specify a suitable file type.

02119 FIL DIR Directories are not allowed in this context

      Reason: A file was specified that has been found to be a directory.
	      these are not allowed in this context.

      Remedy: Re-specify a suitable file type.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
can occur when the database is evaluating incoming values.
02201 EVA SRN NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02202 EVA SRM Subselect resulted in multiple rows

      Reason: Attempting a subselect that should identify only one row but
	      the subselect result set consists of more than one row.

      Remedy: Correct the SQL statement.

02203 EVA DAO Date arithmetic over/under-flow

      Reason: Date arithmetic has caused either an overflow or underflow
	      condition.

      Remedy: Correct the SQL statement.  A date cannot have a numeric value
	      for the year that is less than zero or greater than 9999.

02204 EVA IVH Invalid hour value

      Reason: Specified hour is less than zero or greater than 23.

      Remedy: Correct the specified hour.

02205 EVA IVM Invalid minute value

      Reason: Specified minutes are less than zero or greater than 59.

      Remedy: Correct the specified minutes.

02206 EVA IVS Invalid second value

      Reason: Specified seconds are less than zero or greater than 59.

      Remedy: Correct the specified seconds.

02207 EVA IVD Invalid day value

      Reason: Specified day is not valid.

      Remedy: Correct the specified day.

02208 EVA IVY Invalid year value

      Reason: Specified year is not valid.

      Remedy: Correct the specified year.

02209 EVA IVO Invalid month value

      Reason: Specified month is not valid.

      Remedy: Correct the specified month.

02210 EVA COR @CHAR value out of range

      Reason: Specified character is outside the range of valid characters.

      Remedy: Correct the specified character value.

02211 EVA IVL Invalid length

      Reason: Specified length exceeds allowable limit.

      Remedy: Correct the length of the specified value.

02212 EVA NOF Numeric overflow

      Reason: Attempting a mathematical related function and a numeric
	      overflow has occurred.

      Remedy: Correct the SQL statement.  This problem may often be caused by
	      inadvertently dividing by zero in your SQL statement.

02213 EVA ISN Invalid @CHOOSE selector number

      Reason: The specified @CHOOSE select number is invalid.  A negative
	      selector-number maps to the first value in the list (value 0).
	      If the selector number exceeds the number of values in the list,
	      the result is the last value in the list.

      Remedy: Correct the @CHOOSE selector number.

02214 EVA STL String too long

      Reason: Attempting to concatenate two strings and the resulting string
	      is greater than 254 characters.

      Remedy: Correct the SQL statement concatenation.

02215 EVA VNZ NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02216 EVA VNI Value is not an integer

      Reason: Specified value is not an integer.

      Remedy: Correct the invalid integer value.

02217 EVA NUF Numeric underflow

      Reason: Attempting a mathematical related function and a numeric
	      underflow has occurred.

      Remedy: Correct the SQL statement.

02218 EVA SNG Attempt to find square-root of negative number

      Reason: Attempting to find the square root of a negative number.

      Remedy: Correct the SQL statement.

02219 EVA VIN Value must not be negative

      Reason: Attempting a @HEX or @FACTORIAL and the specified argument
	      equates to a negative value.

      Remedy: Correct the SQL statement.

02220 EVA NZO Value is not zero or one

      Reason: Attempting a @FIND, @LEFT, @LENGTH, @RIGHT, @REPLACE,
	      @SUBSTRING, or @SCAN in double-byte character set mode and the
	      extra, last parameter must be one or zero.  One meaning you want
	      this function to operate in single-byte mode.  Zero meaning you
	      want to operate in the default, double-byte mode.

      Remedy: Correct last parameter in @function.  Can only be one or zero.

02221 EVA ENR Trying to evaluate a non-referenced column

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to result set mode operations.
02401 RST COR Cannot open result set

      Reason: Cannot open the stored result set by the specified name.

      Remedy: Verify that the stored result set name is correct and try again.

02402 RST COT NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02403 RST CCF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02404 RST FNX Filter file does not exist

      Reason: Cannot delete the stored result set by the specified name or
	      attempting to do an undo result set operation and there is no
	      existing result set to undo.

      Remedy: Verify that the store result set name is correct and try again
	      or if attempting to undo a result there is no remedy, you cannot
	      undo a result set if no result set exists.

02405 RST RSA Result set already active

      Reason: Attempting to start restriction mode processing or restart a
	      stored result set in restriction mode and the restriction mode
	      (or result set mode) is already active.

      Remedy: Stop the current restriction mode process before beginnning a
	      new restriction mode or restarting a stored result set.

02406 RST RSN Result set not active

      Reason: Attempting to stop restriction mode processing and restriction
	      (or result set) mode is not currently active OR attempting to
	      position within a result set and the result is empty.

      Remedy: None.  You cannot stop restriction mode if it is not active and
	      you cannot position within an empty result set.

02407 RST RSI Result set identifier too large

      Reason: Attempting to store, delete, or restart a result set and the
	      result set name identifier is too large.

      Remedy: Correct the result set name.  Result set names are restricted
	      to being short identifiers (8 characters).

02408 RST SRC NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02409 RST PER NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02410 RST PNA Previous filter not available

      Reason: Cannot perform the undo (sqlurs) operation because the previous
	      result set is not available.

      Remedy: None.  The previous result may not be available because this was
	      the first result set (no previous select in this restriction
	      mode session) or because the user is attempting to undo more
	      than one time without a subsequent select operation.  Undo
	      operations are not nestable, that is, you can go back to a
	      previous result set but not back before the previous.  The
	      system only maintains the most previously used result set.

02411 RST CRS Out of memory at the database computer (RST CRS)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02412 RST TMT Too many tables in result set

      Reason: Too many table form the result set.

      Remedy: Modify the SQL statement to use fewer tables.

02413 RST QNS Result set restriction mode is not supported for this query

      Reason: Virtual tables are not allowed in restriction mode.

      Remedy: None.  The query is not supported in restriction mode.

02414 RST OBY Can't use ORDER BY when using the result-set of previous query

      Reason: ORDER BY cannot be used when using the result set of a previous
	      query in restriction mode.

      Remedy: None.  ORDER BY cannot be used when using the result set of a
	      previous query in restriction mode.  Under restriction mode, the
	      rows come from the previous result set in the order of the
	      previous result set.

02415 RST IRS Result row size is too big for a temporary table

      Reason: (This error is now obsolete.)
	      The result row size from a SELECT statement cannot exceed
	      the useable space of a single row page since a temporary table
	      cannot have extents.  This restricts the size of a result row
	      to no more than one page, a known problem requiring future
	      enhancement to correct.

      Remedy: Modify the SELECT statement to reduce the result row size.

02416 RST PRO Restriction mode is not supported for procedures

      Reason: This feature is not supproted for procedures.

      Remedy: Turn restriction mode off.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to database server operation.
02501 SRV NPA No process available

      Reason: The USER configuration parameter specifies how many processses
	      are allocated by the database server when starting up and the
	      database server has run out of available processes.

      Remedy: Bring the database server down and restart it after increasing
	      the USER configuration parameter.  The USER keyword specifies
	      the maximum number of clients that can connect to the database
	      server simultaneously.  The default setting is 128 users.  The
	      maximum setting is 255 users.  This keyword is not relevant
	      under OS/2.

02502 SRV INE INTERNAL USE ONLY - Internal error (SRV INE)

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02503 SRV OOS Server is out of sessions

      Reason: The database server or gateway has run short of network
	      sessions.

      Remedy: Bring down the database server or gateway and verify that the
	      network has been configured with enough sessions and commands
	      to support the desired number of users.

02504 SRV MXD Maximum number of clients <max number> exceeded

      Reason: The maximum number of clients allowed by the Database
	      Administrator for this database server or gateway has been
	      exceeded.

      Remedy: Your Database Administrator has limited the number of client
	      connections for the server being connected to.  Please contact
	      your Database Administrator to determine when the server will
	      be next available.

02505 SRV NAN Installation of duplicate DBNAME

      Reason: The database server is attempting to install a new database
	      name in the database name table and the name already exists.

      Remedy: None.  Database names cannot be duplicated on the same network.
	      The same database name is allowed locally on a workstation and
	      again on the network using DBXCOMBO.

02506 SRV INN Invalid database attempting to be installed

      Reason: The database server is attempting to install a new database name
	      in the database name table and it has been determined that the
	      specified database name is invalid.

      Remedy: Correct database name.  Database names must not exceed eight
	      characters.  A database name must begin with an alphabetic
	      character and all subsequent characters must be alphanumeric.

02507 SRV CIS Cannot install server name

      Reason: The system cannot install the specified server name.

      Remedy: Verify that the server being installed does not already exist
	      on the network.

02508 SRV TMO INTERNAL USE ONLY - Timeout

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02509 SRV OOM Out of memory at the database computer (SRV OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02510 SRV ISN Invalid servername

      Reason: Specified servername is invalid.

      Remedy: Servernames must not exceed eight characters.  A servername must
	      begin with an alphabetic character and all subsequent characters
	      must be alphanumeric.

02511 SRV IPW NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02512 SRV ACD Access denied to remote server configured as local-only

      Reason: The user attempted to access a database or server that was
	      not local to the user.  The database or server was located
	      remotely in the network, but was configured for local access
	      only.  Servers that are configured for local access only can
	      support connections from applications running on the same
	      machine as the server, but cannot accept connections from
	      remote users.

      Remedy: Check to see if the database name (or server name, in the
	      case of a server connection) is spelled correctly.  Correct
	      any misspellings in the database or server name and try
	      the connection again.  If the name is spelled correctly, the
	      problem may be in database name duplication.  Try using
	      NETPREFIX in the SQL.INI file to provide better database
	      name isolation.  NETPREFIX may need to go into the SQL.INI
	      file for the server issuing this error message, as well as
	      into the SQL.INI file of the application receiving this
	      error message.

02513 SRV IDP Invalid database process number

      Reason: Attempting to cancel a database process and the specified
	      database process number is invalid.

      Remedy: Correct the database process number.

02514 SRV PDE Process does not exist

      Reason: Attempting to cancel a database process and the specified
	      database process does not exist.

      Remedy: Correct the database process number.

02515 SRV CCL Cannot create logfile, <filename>

      Reason: Attempting to open an existing file and a failure has occurred.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

02516 SRV UCA Server cancelled by operator with active connections

      Reason: The database server is being cancelled by an operator and active
	      connections exist.

      Remedy: None.  All active transactions will be rolled back and all
	      connected users will be disconnected.

02517 SRV DNB Database name is too big

      Reason: A specified database name exceeds 8 characters.

      Remedy: Correct the specified database name.

02518 SRV NLF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02519 SRV IDN Invalid database name

      Reason: A specified database name is invalid.

      Remedy: Correct the invalid database name.

02520 SRV MXU Maximum number of users <max number> exceeded

      Reason: The USER configuration parameter specifies how many users are
	      allowed by the database server when starting up and the database
	      server has run out of available users.

      Remedy: Bring the database server down and restart it after increasing
	      the USER configuration parameter.  The USER keyword specifies
	      the maximum number of clients that can connect to the database
	      server simultaneously.  The default setting is 128 users.  The
	      maximum setting is 255 users.  This keyword is not relevant
	      under OS/2.

02521 SRV NNO NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02522 SRV MXC Maximum number of clients <maximum number> exceeded

      Reason: The maximum number of clients allowed for this database server
	      or gateway have been exceeded.

      Remedy: None.  This version of the database server or gateway is
	      restricted in the number of clients allowed.

02523 SRV PLV Activity log print level must be between 0 and 4 inclusive

      Reason: Attempting to set the activity log print level and an invalid
	      print level has been specified.

      Remedy: Correct the activity log print level.  Valid print levels are 0,
	      1, 2, 3, or 4.

02524 SRV DBA This operation requires DBA authority

      Reason: The setting of this server parameter requires DBA authority.

      Remedy: None.  DBA authority is required to perform this operation.

02525 SRV ALG Activity Log File Name is Too Long

      Reason: Attempting to set an activity log file name and the specified
	      file name is too long.

      Remedy: Correct the activity log file name.  A fully-qualified activity
	      log file name cannot exceed 128 characters.

02526 SRV CID The database name may not be the same as server name.

      Reason: The server name as a database name is reserved for connecting
	      to the MAIN database.

      Remedy: Use a server name different from the database name of use a
	      database name different from the database name.

02527 SRV MDN MAIN database name found on network

      Reason: When attempting to install the server name as a database name
	      on the network it was found that the database name already
	      existing on another server on the network.

      Remedy: Use an alternate server name or deinstall the conflicting
	      database.

02528 SRV ISP Invalid self database process number

      Reason: Database process cannot cancel itself.

      Remedy: None.

02529 SRV SYS Protected system process number

      Reason: System process cannot be cancelled by user.

      Remedy: None.

02530 SRV CPT Server does not not Connect-Pass-Thru mode

      Reason: Server does not support the Connect-Pass-Thru mode.
	      This mode can only be used with certain routers.

      Remedy: Turn off SQLECPT using Set Parameter api or do not
	      use connect escape sequence '$$'.

02531 SRV PIA Database process is Aborting or doing Rollback

      Reason: The database process is either in the process of
	      aborting or is processing a Rollback.  The process cannot
	      be terminated at this point.

      Remedy: If the command is in the process of Rollback, attempt
	      to re-issue the Cancel command after the Rollback completes.

02550 SRV XER Backend returned an error; more information available

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02551 SRV X51 SQLBase returned an error; more information available

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02552 SRV X52 DB2 specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02553 SRV X53 IBM OS/2 Database Manager specific error reported; more
	      information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02554 SRV X54 Oracle specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02555 SRV X55 Informix specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02556 SRV X56 Netware SQL specific error reported; more information
	      available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02557 SRV X57 IBM AS/400 SQL/400 specific error reported; more information
	      available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02558 SRV X58 Sybase SQL Server specific error reported; more information
	      available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02559 SRV X59 HP Allbase Server specific error reported; more information
	      available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02560 SRV X60 Teradata specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02561 SRV X61 Rdb specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02562 SRV X62 Tandem specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02563 SRV X63 IBM SQL/DS specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02564 SRV X64 SNI SESAM specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02565 SRV X65 Ingres specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02566 SRV X66 ODBC specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02567 SRV X67 Dbase specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02568 SRV X68 SNI DDB4 specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02569 SRV X69 Fujitsu specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02570 SRV X70 Cincom SUPRA specific error reported; more information
	      available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02571 SRV X71 CCA Model 204 specific error reported; more information
	      available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02572 SRV X72 Apple DAL interface specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02573 SRV X73 Teradata ShareBase specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02574 SRV X74 Informix OnLine specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02575 SRV X75 EDA/SQL specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02576 SRV X76 SNI UDS specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02577 SRV X77 Mimer specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02579 SRV X79 Ingres OpenSQL specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02580 SRV X80 Ingres OpenSQL specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02581 SRV X81 Entire Access specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

02599 SRV X99 SQLHost App Services specific error reported; more information available

      Reason: Backend specific error. A SQLBase equivalent error code
	      could not be mapped.

      Remedy: Call extended error processing to retrieve more details.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to remote database server interface.
02601 RSI NAS no available sessions

      Reason: The database server has run short of network sessions.

      Remedy: Bring down the database server and verify that the network has
	      been configured with enough sessions and commands to support the
	      desired number of users.

02602 RSI CAM Out of memory at the database computer (RSI CAM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to database server scheduler.
02701 SCD IST NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02702 SCD NSA NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02703 SCD NES Out of memory at the database computer (SCD NES)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02704 SCD NEM NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02705 SCD NSD Fatal SQLBase System Failure (SCD NSD)

      Reason: This is a Fatal Error.

      Remedy: Resaon#3

02706 SCD SNI INTERNAL USE ONLY - Scheduler not initialized

      Reason: This is error is only used internally by the SQLBase system.
	      A scheduler function (other than scdInit) was made before the
	      scheduler was initialized via scdInit.

      Remedy: None.  This error code should never occur in an application
	      program. scdInit must be the first scheduler function called.
	      Call scdInit before making any other scheduler calls.  If you
	      get this error, contact your local Centura Software Corporation
	      certified technical support center.

02707 SCD AIN INTERNAL USE ONLY - Scheduler already initialized

      Reason: This is error is only used internally by the SQLBase system.
	      scdInit was called more than once

      Remedy: None.  This error code should never occur in an application
	      program. scdInit must be the first scheduler function call and
	      it must never be called more than once.  If you get this error,
	      contact your local Centura Software Corporation certified
	      technical support center.

02708 SCD OOM Out of memory at the database computer (SCD OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02709 SCD CFP INTERNAL USE ONLY - Cannot find process

      Reason: This is error is only used internally by the SQLBase system.
	      scdPost was called with an invalid process number.

      Remedy: None.  This error code should never occur in an application
	      program.	scdPost may only be called with a process number of a
	      currently valid process.	If you get this error, contact your
	      local Centura Software Corporation certified technical
	      support center.

02710 SCD PIU INTERNAL USE ONLY - Process number already in use

      Reason: This is error is only used internally by the SQLBase system.
	      scdCreate was called with a process number already in use.

      Remedy: None.  This error code should never occur in an application
	      program.	When specifying a process number to scdCreate, the
	      process number given must specify a process that is not
	      currently valid.	If you get this error, contact your local
	      Centura Software Corporation certified technical support center.

02711 SCD PIB INTERNAL USE ONLY - Process is blocked

      Reason: This is error is only used internally by the SQLBase system.
	      scdPost was called with the number of a process that is not
	      waiting on a scdSleep (such as a wait on a semaphore).

      Remedy: None.  This error code should never occur in an application
	      program.	scdPost can only be called on a process that is asleep
	      via a call to scdSleep.  If you get this error, contact your
	      local Centura Software Corporation certified technical
	      support center.

02712 SCD NCP INTERNAL USE ONLY - No current process

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02713 SCD CWQ NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02714 SCD CRQ NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02715 SCD CCQ NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02716 SCD CCT Out of memory at the database computer (SCD CCT)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02717 SCD CCS NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02718 SCD ISM NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02719 SCD CSS NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02720 SCD SWF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02721 SCD SRF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02722 SCD STC INTERNAL USE ONLY - Semaphore type conflict

      Reason: This inappropriate use of semaphore scheduler call is an
	      internal error of the SQLBase system.

      Remedy: None.  This error code should never occur in an application
	      program.	There are two type of semaphores and two sets of
	      functions dealing with them, they cannot be mixed.  If you get
	      this error, contact your local Centura Software Corporation
	      certified technical support center.

02723 SCD TMO INTERNAL USE ONLY - Timeout occurred

      Reason: This is error is only used internally by the SQLBase system.
	      A scdSemRequest with a timeout exceeded the timeout value
	      without the requested semaphore being cleared.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02724 SCD IDV NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02725 SCD CCM NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02726 SCD CCP Out of memory at the database computer (SCD CCP)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02727 SCD CST Cannot create Operating System thread

      Reason: This error code is when running out of operating system
	      resources.

      Remedy: Shut down the database server whenever possible.	Consult
	      System Administrator to increase the system resources and
	      re-start database server.  If you get this error again,
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02728 SCD TMD Cannot create thread because thread manager was diabled

      Reason: This error is caused by pressing ESC on the server while there
	      are still other users connected to the server.  The server is
	      going to be brought done abnormally.  This error is returned as
	      a result of thread manager being disabled to prepare the
	      abnormal shutdown.

      Remedy: Do not bring server down while other users still connected.

02729 SCD CAB Cannot allocate buffer for asynchronized I/O

      Reason: This is a fatal error.  Error will only occur when SQLBase
	      allow more than 256 users connected.

      Remedy: Use parameter in SQL.INI to increase the buffers.

02730 SCD CAS Cannot allocate semaphore for asynchronized I/O

      Reason: Cannot allocate semaphore for asynchronized I/O.

      Remedy: Operating system ran out of resources.

02731 SCD CSP Cannot spwan process for asynchronized I/O

      Reason: Cannot spwan child process for asynchronize I/O.

      Remedy: Operating system ran out of resources.

02732 SCD TMP Too many threads already

      Reason: The maximum allowable number of threads has been reached.
	      New threads will not be accepted until existing ones terminate.

      Remedy: Increase the upper bound for the number of concurrent process
	      by increasing MAXPROCESS.


02733 SCD CAN Out of memory at the database computer (SCD CAN)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.


02734 SCD CCN Cannot create native thread. OS Error = <OsError>

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.


02735 SCD CCH Cannot do 'CloseHandle'. OS Error = <OsError>

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.


02736 SCD CSE Cannot do 'SetEvent'.  OS Error = <OsError>

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.


02737 SCD CRE Cannot do 'ResetEvent'.  OS Error = <OsError>

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.


02738 SCD EWF 'WaitForSingleObject' failed.  OS Error = <OsError>

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.


02739 SCD NSP Operation not supported for this platform.

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.



1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the remote database server interface for Microsoft Windows.
02801 RSW SAC Session already created

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02802 RSW NEM Out of memory at the database computer (RSW NEM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

02803 RSW IEN Invalid entry

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02804 RSW TNI Task not initialized

      Reason: This problem may have occurred because the sqlini() function
	      call is not being called before a connect function call like
	      sqlcnc or sqlcnc may be called after calling sqldon without
	      another subsequent sqlini function call.

      Remedy: Correct the application program.	The sequence of events should
	      be calling sqlini() first followed by any and all other sql
	      functions and finally terminating with a sqldon function call.

02805 RSW TDE NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

02806 RSW TAI Task already initialized

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02807 RSW NAS No available slots

      Reason: Whenever a Windows program calls the SQLBase API for the first
	      time, it gets allocated a slot where a pointer to its data it
	      kept.  Before the Microsoft Windows application terminates, its
	      suppose to call sqldon() to free the slot.  The current
	      Microsoft Windows program is probably failing to call sqldon().

      Remedy: Call sqldon() before exiting the Microsoft Windows application
	      program.

02808 RSW SNE Session does not exist

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02809 RSW ICB Invalid cursor buffer pointer

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02810 RSW SCT Session closed/terminated

      Reason: This error is returned to the client computer when the cursor is
	      tied to a network session that no longer exists.	Once you get
	      this error on a cursor, subsequent tries will also yield the
	      same error.  Other cursors sharing the same network session will
	      get this error also.  If applications are exiting without
	      disconnecting all their cursors, the database server can confuse
	      a new instance of an application with an old one.  If the new
	      and old instance have the same MS Windows task id, the database
	      server might tell the new instance to use a network session
	      created by the old instance.

      Remedy: Check if some other error occurred before receiving this error.
	      Other errors that may have gone undetected may have caused this
	      error.  Also check that all cursors are disconnected before
	      terminating each run of an application.  This can be checked by
	      seeing if there are any session left on the database server
	      screen after running and exiting each application.  Check
	      whether the applications ever terminate in ways where sessions
	      are not disconnected.

02811 RSW CFS Cannot find session

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02812 RSW INE Fatal SQLBase System Failure (RSW INE)

      Reason: This is a Fatal Error.

      Remedy: Reason#3

02813 RSW OOS Out of sessions

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02814 RSW CAN Cannot access network

      Reason: A network adapter is not present in the computer.

      Remedy: Verify that this computer is connected to a network and
	      a network adapter card is properly installed.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the database server playback utility.
02901 PYB CNI Cannot initialize program

      Reason: Cannot initialize playback program server screen.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02902 PYB NEM Not enough memory

      Reason: The playback program is attempting to allocate memory but it
	      cannot find enough available memory.

      Remedy: Determine why the playback program is short of memory.  Try to
	      make more memory available.

02903 PYB COF Cannot open network message file

      Reason: Cannot open the playback file to replay the messages.

      Remedy: Correctly identify the playback filename.

02904 PYB IVF Invalid network message file

      Reason: The playback file that was opened is invalid and not a netlog
	      message file.

      Remedy: Correctly identify the playback filename.

02905 PYB MFC Network message file corrupted

      Reason: The playback program has read message from the netlog file and
	      determined that the message is corrupted.

      Remedy: None.  The playback netlog file is not usable.

02906 PYB EOF End of file

      Reason: The playback program has determined that the netlog message
	      file has been exhausted and no message remain to be read.

      Remedy: None. Informational only.

02907 PYB PEF Premature end of file

      Reason: The playback program has determined that the netlog message
	      file has prematurely ended.

      Remedy: Determine why the netlog message file was incomplete.

02908 PYB NNN No network message file in use

      Reason: Attempting a playback program operation and no network message
	      file has been opened.

      Remedy: Open a playback network message file before attempting a
	      playback operation.

02909 PYB CIS Cannot invoke command shell

      Reason: Attempting to escape from the playback program to a DOS command
	      shell but the DOS command shell cannot be invoked.

      Remedy: Determine why the DOS command shell cannot be invoked.  Try
	      again.

02910 PYB INE Internal error

      Reason: An unexpected internal error has been determined in the
	      playback program.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

02911 PYB NES Switch to non-existent session

      Reason: The playback program is attempting to switch to another session
	      but the target session does not exist.

      Remedy: None.  The netlog message file is not usable.

02912 PYB COL Cannot open log file

      Reason: The playback program is failing in its attempt to open the
	      specified netlog message file.

      Remedy: Verify that the netlog file name is correctly specified.

02913 PYB LNO Log file not open

      Reason: Attempting to close a netlog message file and the netlog
	      message file is not open.

      Remedy: None.  You cannot close a netlog message file that is not open.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to management of configuration parameters.
03001 CFM NLD NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03002 CFM NRD NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03003 CFM ICM NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03004 CFM OOM Out of memory at the database computer (CFM OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

03005 CFM RBS NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03006 CFM IDN Inconsistent database name

      Reason: The database system has determined that the database name being
	      installed was prefixed with a "L:" to install a local database
	      and the server number utilized by the system was not zero OR the
	      database name being installed was prefixed with a "R:" to
	      install a remote database and the server number utilized by the
	      system was zero.

      Remedy: Correct installation of database name.  The "R:" prefix should
	      be used to install on a remove database server with server
	      number greater than zero.  To install a local database use a
	      prefix of "L:" and use a server number of zero.

03007 CFM COS Cannot open startup database

      Reason: Attempting to install a new database and the database system
	      cannot locate the START.DBS file.

      Remedy: Verify that the START.DBS file is available.

03008 CFM CCD Cannot create database

      Reason: Attempting to install a new database and the database system
	      could not create the specified database name.

      Remedy: Determine why the system could not create the named database
	      file.

03009 CFM IRF Initialize read failure

      Reason: Attempting to install a new database and the database system
	      could not read from the START.DBS file.

      Remedy: Determine why the system could not read the START.DBS file.

03010 CFM IWF Initialize write failure

      Reason: Attempting to install a new database and the database system
	      could not write to the newly created database file.

      Remedy: Determine why the system could not write to the newly created
	      database file.

03011 CFM DBE Database already exists

      Reason: Attempting to install a new database and the name database
	      already exists.

      Remedy: None.  You cannot install a database that already exists.

03012 CFM DBN Database does not exist

      Reason: Attempting to install an existing database and the named
	      database does not exist.

      Remedy: None.  You cannot install an existing database if the existing
	      database does not exist.

03013 CFM CRD Cannot create directory list

      Reason: Attempting to create a directory of listing of all existing and
	      installed databases and the database system could not create
	      the directory listing.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center.

03014 CFM OOH Out of handles

      Reason: Attempting to open more than four remote files at the same time.

      Remedy: None.  Only four remote files can be opened simultaneously.

03015 CFM IVH Invalid handle

      Reason: The specified file handle is not valid.

      Remedy: Use a valid file handle returned by opening the file with the
	      sqlmop API function call.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for virtual
screen processing errors.
03101 VTS INV INTERNAL USE ONLY - Invalid screen id

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03102 VTS OOR INTERNAL USE ONLY - Out of range

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03103 VTS ICT INTERNAL USE ONLY - Invalid cursor type

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03104 VTS CIN INTERNAL USE ONLY - Cannot initialize

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03105 VTS CSR INTERNAL USE ONLY - Cannot save or restore screen

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the Online Backup Facilities of the SQLBase database.
03201 BKP BFE Backup file already exists

      Reason: Attempting to perform an online backup without the overwrite
	      option and the backup file already exists.

      Remedy: Modify the backup filename or invoke the overwrite option.

03202 BKP CRB File Creation Failure - Cannot create backup file

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

03203 BKP BIP Backup already in progress

      Reason: Attempting an online backup procedure and another backup is
	      already in progress.

      Remedy: Wait until the current online backup procedure has completed.

03204 BKP UAB Out of memory at the database computer (BKP UAB)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

03205 BKP SFA File seek failure

      Reason: The database server is attempting to seek to the beginning of
	      the backup file during a backup procedure and is encountering
	      a file seek error.

      Remedy: Determine why the operating system is generating a file seek
	      error.  Verify that the storage media is working correctly.

03206 BKP USG Unknown backup file segment

      Reason: The database system has read a chunk of backup data and the
	      system could not identify the backup file segment.

      Remedy: None.  The backup file is probably unusable.  Contact your
	      local Centura Software Corporation certified technical
	      support center.

03207 BKP CAC Out of memory at the database computer (BKP CAC)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

03208 BKP NCF Need control file to backup database > 2GB  (BKP NCF)

      Reason: Database to be backed-up is greater than 2 gigabytes, the
	      maximum file size supported by SQLBase

      Remedy: Create a control file for the backup of this database.  The
	      backup files will be created in segments as specified in
	      the control file.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the Restore Facility of the SQLBase database.
03301 RES CCN Cannot create new partitioned database file

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

03302 RES COB Cannot open backup file on database server computer

      Reason: Attempting a restore database or restore snapshot and the
	      system cannot open the backup file on the database server
	      computer.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file name was correctly specified
	      and exists on the database computer.  Verify that the number
	      of files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

03303 RES CAC Out of memory at the database computer (RES CAC)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

03304 RES SFA Backup File Seek Failure

      Reason: The SQLBase system is attempting to re-find the beginning of the
	      backup file and the seek for the beginning of the file has
	      failed.

      Remedy: Determine and correct the cause of file seek failure.

03305 RES UAB Out of memory at the database computer (RES UAB)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

03306 RES SIZ Restore over maximum file size (RES SIZ)

      Reason: Calculated backup size is greater than 2 GB and restore is to
      a non-partitioned database.

      Remedy: Do the restore to a partitioned database.
	  (See Database Administrator's Guide)

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the System Free List Manager of the SQLBase database.
03401 SFL BFE CHECK Failure (SFL BFE): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03402 SFL OVL CHECK Failure (SFL OVL): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03403 SFL ENM CHECK Failure (SFL ENM): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03404 SFL FPC CHECK Failure (SFL FPC): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03405 SFL BSI CHECK Failure (SFL BSI): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the Extent Map Manager of the SQLBase database.
03501 EMP ULP Database or object in the database is corrupt (EMP ULP)

      Reason: The database or an object in the database has been discovered
	      to be inconsistent or lacking integrity.

      Remedy: Run a CHECK DATABASE command.

03502 EMP BSI CHECK Failure (EMP BSI): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03503 EMP BME CHECK Failure (EMP BME): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03504 EMP BES CHECK Failure (EMP BES): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03505 EMP ENM CHECK Failure (EMP ENM): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03506 EMP PIM CHECK Failure (EMP PIM): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03507 EMP MOB NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03508 EMP IEM CHECK Failure (EMP IEM): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03509 EMP PNA CHECK Failure (EMP PNA): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

03510 EMP RNA CHECK Failure (EMP RNA): <extent page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the DBWindows version of the SQLBase database.
03601 DBW NIN DBWINDOWS is not installed

      Reason: Attempting to access the DBWindows and it is not installed.

      Remedy: Install DBWindows and then proceed.

03602 DBW CAM Out of memory at the database computer (DBW CAM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the Configuration File Manager of the SQLBase database.
03701 CFF NCF No configuration file

      Reason: The SQL.INI configuration file could not be found after
	      searching the current directory, the \SQLBASE directory, the
	      root directory, or the specified operating system search PATH.

      Remedy: Check for the existence of the SQL.INI file in the appropriate
	      directory.

03702 CFF COC Cannot open configuration file

      Reason: Attempting to open an existing file and a failure has occurred.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

03703 CFF MCE Missing configuration file entry

      Reason: Cannot find the configuration file entry [category] in the
	      SQL.INI configuration file.

      Remedy: Verify that the configuration file entry exists and that the
	      proper SQL.INI configuration file is being used.

03704 CFF FCL File closed

      Reason: The SQLBase system is attempting to read, write, or delete a
	      line from the SQL.INI configuration file and the SQL.INI
	      configuration file is not open.

      Remedy: This error should never occur unless there is a problem with the
	      SQL.INI configuration processing software in SQLBase.  Contact
	      your local Centura Software Corporation certified technical
	      support center.

03705 CFF LSK SQL.INI configuration disk file seek error

      Reason: The SQLBase system is attempting to seek to a point within the
	      SQL.INI configuration file and the seek operation has failed.

      Remedy: Determine and correct the cause of the disk seek failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

03706 CFF CRD Read failure of SQL.INI configuration file

      Reason: Attempting to read a file and a disk read failure has occurred.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

03707 CFF CWT Write failure to SQL.INI configuration file

      Reason: Attempting to write to a file and a disk write failure has
	      occurred.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

03708 CFF EOF INTERNAL USE ONLY - End of file

      Reason: This is not considered an error.	This is only an indication
	      that an end of file has been discovered in the SQL.INI file.

      Remedy: None.  Informational only.

03709 CFF NDL No delete line available in the SQL.INI configuration file

      Reason: The SQLBase system is attempting to delete a line within the
	      SQL.INI configuration file and there is no line to delete.

      Remedy: This error should never occur unless there is a problem with the
	      SQL.INI configuration processing software in SQLBase.  Contact
	      your local Centura Software Corporation certified technical
	      support center.

03710 CFF OOM Out of memory

      Reason: Either the database computer or the client workstation
	      computer is running short of available memory.

      Remedy: Check available memory and attempt to make more memory
	      available.  To make more memory available at the database
	      computer, you can reduce the size of the CACHE.

03711 CFF IAV Invalid APPEND value

      Reason: AUDIT keyword APPEND value is invalid.

      Remedy: Correct APPEND value.  An AUDIT configuration parameter APPEND
	      value is invalid.  Valid values range from zero to 999.  The
	      format of the AUDIT SQL.INI configuration parameter is

	      AUDIT=[type],auditname,[directory],[size-value],[append-value],
		[keep-value],[OVERWRITE],[category-values (comma separated)]

	      where the first argument can be a audit type, followed by the
	      auditname, followed optionally by the destination directory
	      name, followed optionally by the audit file size, followed
	      optionally by the append file number, followed optionally by the
	      KEEP value, followed optionally by the OVERWRITE keyword, and
	      finally followed by the category number, comma separated.  For
	      more information on these parameters, please see the START AUDIT
	      command documentation in the SQL Language Reference manual.

03712 CFF ICK Invalid SQL.INI configuration parameter

      Reason: An invalid SQL.INI configuration parameter has been read from
	      the SQL.INI configuration file.

      Remedy: Verify that the SQL.INI configuration parameters are correctly
	      specified.  Check that the system is reading the SQL.INI file
	      that you think it is reading.  See what other SQL.INI files
	      exist in the current directory, the \SQLBase directory, the root
	      directory, or on the operating system search PATH.

03713 CFF MPV Missing configuration parameter value

      Reason: A SQL.INI configuration parameter has been specified and
	      the expected form of the SQL.INI configuration parameter
	      is KEYWORD=VALUE and the value portion of the SQL.INI
	      configuration parameter is missing.

      Remedy: Verify that the SQL.INI configuration parameter values are
	      correctly specified.  Check that the system is reading the
	      SQL.INI file that you think it is reading.  See what other
	      SQL.INI files exist in the current directory, the \SQLBase
	      directory, the root directory, or on the OS search PATH.

03714 CFF CFE Error in configuration file.

      Reason: Error(s) found during the proceesing of configuration file

      Remedy: Correct the SQL.INI file and make sure that the parameters
	      provided there are correct and that they have the correct
	      values assigned.

03715 CFF ANM Missing AUDIT name configuration parameter

      Reason: Audit name is missing

      Remedy: A AUDIT configuration parameter requires the specification of a
	      audit name.  The format of the AUDIT SQL.INI configuration
	      parameter is

	      AUDIT=[type],auditname,[directory],[size-value],[append-value],
		[keep-value],[OVERWRITE],[category-values (comma separated)]

	      where the first argument can be a audit type, followed by the
	      auditname, followed optionally by the destination directory
	      name, followed optionally by the audit file size, followed
	      optionally by the append file number, followed optionally by the
	      KEEP value, followed optionally by the OVERWRITE keyword, and
	      finally followed by the category number, comma separated.  For
	      more information on these parameters, please see the START AUDIT
	      command documentation in the SQL Language Reference manual.

03716 CFF INI Invalid integer parameter

      Reason: A SQL.INI configuration parameter has been specified and the
	      expected form of the SQL.INI configuration parameter is
	      KEYWORD=integer-value and the integer-value portion of the
	      SQL.INI configuration parameter is not a valid integer.

      Remedy: Verify that the SQL.INI configuration parameter integer-values
	      are correctly specified.	Check that the system is reading the
	      SQL.INI file that you think it is reading.  See what other
	      SQL.INI files exist in the current directory, the \SQLBase
	      directory, the root directory, or on the OS search PATH.

03717 CFF INB Invalid boolean parameter

      Reason: A SQL.INI configuration parameter has been specified and the
	      expected form of the SQL.INI configuration parameter is
	      KEYWORD=boolean-value and the boolean-value portion of the
	      SQL.INI configuration parameter is not a valid integer.

      Remedy: Verify that the SQL.INI configuration parameter boolean-values
	      are correctly specified.	Check that the system is reading the
	      SQL.INI file that you think it is reading.  See what other
	      SQL.INI files exist in the current directory, the \SQLBase
	      directory, the root directory, or on the OS search PATH.

03718 CFF INK Invalid parameter keyword

      Reason: A SQL.INI configuration parameter has been specified and the
	      expected form of the SQL.INI configuration parameter is
	      PARAMETER=KEYWORD and the keyword portion of the SQL.INI
	      configuration parameter is not a valid keyword.

      Remedy: Verify that the SQL.INI configuration parameter keywords are
	      correctly specified.  Check that the system is reading the
	      SQL.INI file that you think it is reading.  See what other
	      SQL.INI files exist in the current directory, \SQLBase
	      directory, root directory, or on the OS search PATH.

03719 CFF MES Missing equal sign on parameter

      Reason: A SQL.INI configuration parameter has been specified and the
	      expected form of the SQL.INI configuration parameter is
	      KEYWORD=value and the equal sign (=) is missing.

      Remedy: Verify that the SQL.INI configuration parameter has a equal sign
	      correctly specified.  Check that the system is reading the
	      SQL.INI file that you think it is reading.  See what other
	      SQL.INI files exist in the current directory, \SQLBase
	      directory, root directory, or on the OS search PATH.

03720 CFF NOP MAIN db not open to public

      Reason: A DBNAME= SQL.INI configuration parameter specifies the main
	      database and the main database is not available to the public.

      Remedy: Remove or change the name of the database that you are
	      attempting to install that has the name of "MAIN".

03721 CFF IPL Inappropriate server prefix length

      Reason: A SERVERPREFIX= SQL.INI configuration parameter specified a
	      serverprefix that is something other than one character.

      Remedy: Correct the SERVERPREFIX parameter.  A server prefix can only be
	      one character.

03722 CFF ICN Invalid CLIENTNAME parameter

      Reason: A CLIENTNAME=  SQL.INI  configuration  parameter	specified  a
	      client name which is either too small or too  large.   Maximum
	      size is twelve characters

      Remedy: Correct the CLIENTNAME parameter to  be  from  one  to  twelve
	      characters.

03723 CFF EPD Invalid EPDATECHK parameter

      Reason: The only allowed values fo EPDATECHK are parameters  are	'ON'
	      or 'OFF'.  The default is OFF.

      Remedy: Correct the parameter to use 'ON' or 'OFF'.

03724 CFF IMA Invalid MACHINE parameter

      Reason: This parameter is used to cause SQLBase to  adapt  to  special
	      non-standard hardware.  This is  primarily  for  Japanese  NEC
	      machine  and  other  AX  standard  machines.   There  are  few
	      hardware difference between NEC  machine	and  IBM  compatible
	      machine.	Currently, the allowed parameters are 'NEC' or 'AX'.

      Remedy: Correct the parameter to 'NEC' or 'AX'.

03725 CFF DDB Invalid DEFAULTDATABASE

      Reason: The DEFAULTDATABASE name should be a short identifier.  The
	      length should not be more than 8 characters long and all the
	      characters should be valid identifier characters.

      Remedy: Correct the parameter value to a valid short identifier.

03726 CFF ITF Cannot open error translation file

      Reason: The error translation file specified could not be found.

      Remedy: Check the error translation file name spelling.  Make sure the
	      file is there.

03727 CFF OME Out of memory for error translation table

      Reason: Cannot allocate enough memory for error translation table.

      Remedy: Find a way to decrease other memory usage (e.g.  Memory
	      resident programs) or add more memory to your machine.

03728 CFF APC Invalid APPCDLC parameter

      Reason: The value should be 'SDLC' or 'ITRN'.  The length should be
	      exactly 4.

      Remedy: Check your spelling.  Correct the parameter.

03729 CFF PEX Cannot open SQL.INI configuration file for read or write

      Reason: The SQL.INI file could not be opened for read or write.
	      Either the file doesn't exist or it is lock by another program
	      which may be writing to the file or no read/write privilege.

      Remedy: Make sure you do have SQL.INI file.  Check the SQL.INI
	      configuration file attribute.

03730 CFF PSW Invalid DEFAULTPASSWORD

      Reason: The password is too long.

      Remedy: Correct the password so that it is one to eight characters.

03731 CFF PWD Invalid PASSWORD

      Reason: The password is too long.

      Remedy: Correct the password so that it is one to eight characters.

03732 CFF TMZ Invalid TIMEZONE

      Reason: A floating point number between -12 and +12 is expected.
	      The unit is hour.

      Remedy: Make sure the specified number is between -12  and +12.

03733 CFF USR Invalid DEFAULTUSER

      Reason: The length of the user is too long.

      Remedy: Make sure the user is from one to eight characters.

03734 CFF OOF Only accept 0 or 1 as parameter

      Reason: Only 0 for OFF and 1 for ON is accepted for this parameter.

      Remedy: Make sure the parameter value is either a 1 or a 0.

03735 CFF OCS Cannot open file for character sets

      Reason: The CHARACTERSET file could not be opened.  This means either
	      the file does not exist or the file is in use by another user.

      Remedy: Check the file name and make sure you do have that file.	Check
	      your spelling.  If the specified file name does not have a file
	      extension, .CHR is the default file extension.

03736 CFF CST Out of memory for character sets tables

      Reason: Not enough free memory was found for the character set table.

      Remedy: Find a way to decrease other memory usage (e.g. memory resident
	      programs) or add more memory to your machine.

03737 CFF IVC Invalid character in character sets

      Reason: The value is out out range 0x00 and 0xFF.

      Remedy: Check the values in the CHARACTERSET file and make sure they are
	      are within range.

03738 CFF IRO Invalid recorder option

      Reason: It is a invalid filename or cannot allocate recorder definition
	      structure. (out of memory)

      Remedy: Use a valid file name.

03739 CFF ROS Recorder option not contained in system

      Reason: This section does not have recorder option.

      Remedy: This line has to be deleted in this section.

03740 CFF LTL Line too long in SQL.INI

      Reason: A configuration entry in SQL.INI was too long.

      Remedy: Shorten the offending line in SQL.INI.  In many cases it is
	      possible to split up 1 configuration entry into several entries
	      using the same keyword.

03741 CFF INP Invalid NETPREFIX or NETPREFIX too long

      Reason: The value of the NETPREFIX is invalid.  The size of NETPREFIX
	      is limited to 3 alphanumeric characters.

      Remedy: Alter the value of NETPREFIX to be less than or equal to three
	      characters and contain only alphanumeric characters.

03742 CFF TTL Invalid audit name identifier

      Reason: The AUDIT name should be a short identifier.  The length should
	      not be more than 8 characters long and all the characters
	      should be valid identifier characters.

      Remedy: Correct the auditname parameter value to a valid short
	      identifier.  A AUDIT configuration parameter requires the
	      specification of a audit name.  The format of the AUDIT
	      SQL.INI configuration parameter is

	      AUDIT=[type],auditname,[directory],[size-value],[append-value],
		[keep-value],[OVERWRITE],[category-values (comma separated)]

	      where the first argument can be a audit type, followed by the
	      auditname, followed optionally by the destination directory
	      name, followed optionally by the audit file size, followed
	      optionally by the append file number, followed optionally by the
	      KEEP value, followed optionally by the OVERWRITE keyword, and
	      finally followed by the category number, comma separated.  For
	      more information on these parameters, please see the START AUDIT
	      command documentation in the SQL Language Reference manual.

03743 CFF AUT Invalid audit type specified

      Reason: The specified audit type is invalid.  Valid audit types are
	      GLOBAL and PERFM.  If not specified, the audit defaults to
	      GLOBAL.

      Remedy: Correct the audit type parameter.  A AUDIT configuration
	      parameter allows for a GLOBAL or PERFM type audit.  The format
	      of the AUDIT SQL.INI configuration parameter is

	      AUDIT=[type],auditname,[directory],[size-value],[append-value],
		[keep-value],[OVERWRITE],[category-values (comma separated)]

	      where the first argument can be a audit type, followed by the
	      auditname, followed optionally by the destination directory
	      name, followed optionally by the audit file size, followed
	      optionally by the append file number, followed optionally by the
	      KEEP value, followed optionally by the OVERWRITE keyword, and
	      finally followed by the category number, comma separated.  For
	      more information on these parameters, please see the START AUDIT
	      command documentation in the SQL Language Reference manual.

03744 CFF AWN SQL.INI AUDIT parameter without audit name identifier

      Reason: A SQL.INI configuration file AUDIT entry does not contain a
	      AUDIT name identifier.  The audit name identifier is required.

      Remedy: Correct the SQL.INI configuration file AUDIT parameter.  Every
	      AUDIT entry must specify a valid AUDIT name identifier.  The
	      format of the AUDIT SQL.INI configuration parameter is

	      AUDIT=[type],auditname,[directory],[size-value],[append-value],
		[keep-value],[OVERWRITE],[category-values (comma separated)]

	      where the first argument can be a audit type, followed by the
	      auditname, followed optionally by the destination directory
	      name, followed optionally by the audit file size, followed
	      optionally by the append file number, followed optionally by the
	      KEEP value, followed optionally by the OVERWRITE keyword, and
	      finally followed by the category number, comma separated.  For
	      more information on these parameters, please see the START AUDIT
	      command documentation in the SQL Language Reference manual.

03745 CFF ANF SQL.INI AUDIT parameter could not be found

      Reason: A SQL.INI configuration file AUDIT entry could not be found.

      Remedy: Determine why the AUDIT entry could not be found.

03746 CFF AAE Specified AUDIT already exists in SQL.INI file

      Reason: Attempting to start a new AUDIT and the existing AUDIT already
	      exists in the SQL.INI file.

      Remedy: Determine why the AUDIT entry already exists.

03747 CFF BSV Invalid SIZE value specified in AUDIT setting

      Reason: An AUDIT setting in the SQL.INI file contains an invalid SIZE
	      value setting.

      Remedy: Correct the SIZE value setting in the AUDIT setting.

03748 CFF IKV Invalid KEEP value

      Reason: AUDIT KEEP value is invalid.

      Remedy: Correct KEEP value.  An AUDIT configuration KEEP value is
	      invalid.	Valid values range from zero to 999.  The format of
	      the AUDIT SQL.INI configuration parameter is

	      AUDIT=[type],auditname,[directory],[size-value],[append-value],
		[keep-value],[OVERWRITE],[category-values (comma separated)]

	      where the first argument can be a audit type, followed by the
	      auditname, followed optionally by the destination directory
	      name, followed optionally by the audit file size, followed
	      optionally by the append file number, followed optionally by the
	      KEEP value, followed optionally by the OVERWRITE keyword, and
	      finally followed by the category number, comma separated.  For
	      more information on these parameters, please see the START AUDIT
	      command documentation in the SQL Language Reference manual.

03749 CFF OVR Invalid AUDIT OVERWRITE keyword

      Reason: The AUDIT entry in the SQL.INI configuration contains an
	      invalid entry for the OVERWRITE keyword.

      Remedy: Correct the OVERWRITE keyword.  Verify the spelling.  The
	      format of the AUDIT SQL.INI configuration parameter is

	      AUDIT=[type],auditname,[directory],[size-value],[append-value],
		[keep-value],[OVERWRITE],[category-values (comma separated)]

	      where the first argument can be a audit type, followed by the
	      auditname, followed optionally by the destination directory
	      name, followed optionally by the audit file size, followed
	      optionally by the append file number, followed optionally by the
	      KEEP value, followed optionally by the OVERWRITE keyword, and
	      finally followed by the category number, comma separated.  For
	      more information on these parameters, please see the START AUDIT
	      command documentation in the SQL Language Reference manual.

03750 CFF IAI Invalid ADAPTER_ID parameter

      Reason: A ADAPTER_ID=  SQL.INI  configuration  parameter	specified  a
	      adapter id which is either too small or too  large.   Maximum
	      size is 32 characters

      Remedy: Correct the ADAPTER_ID parameter to  be  from 1 to 32
	      characters.

03751 CFF IMI Invalid MAIL_ID parameter

      Reason: A MAIL_ID=  SQL.INI  configuration  parameter  specified	a
	      mail id which is either too small or too	large.	 Maximum
	      size is 32 characters

      Remedy: Correct the MAIL_ID parameter to	be  from 1 to 32
	      characters.

03752 CFF IUI Invalid APP_ID parameter

      Reason: A APP_ID=  SQL.INI  configuration  parameter  specified  a
	      application id which is either too small or too  large.	Maximum
	      size is 32 characters

      Remedy: Correct the APP_ID parameter to  be  from 1 to 32
	      characters.

03753 CFF INW Invalid NETWORK_ID parameter

      Reason: A NETWORK_ID=  SQL.INI  configuration  parameter	specified  a
	      application id which is either too small or too  large.	Maximum
	      size is 32 characters

      Remedy: Correct the NETWORK_ID parameter to  be  from 1 to 32
	      characters.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the Remote SQLBase database server interface to the OS/2 operating
system.
03801 RSO OOS Out of sessions

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

03802 RSO NEM Out of memory at the client

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

03803 RSO INE Fatal SQLBase System Failure (RSE INE)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

03804 RSO CFS Cannot find session

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

03805 RSO SNE Session does not exist

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

03806 RSO SCT Session closed/terminated

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the Transaction Log Manager of the SQLBase database.
03901 LOG CCL Cannot create log file

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

03902 LOG ILF Incompatible Log file Format

      Reason: The log files being processed is not compatible with the
	      current server version.

      Remedy: Check if the log file is the correct one and re-try again.

03903 LOG CAL Out of memory at the database computer (LOG CAL)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

03904 LOG CAB Out of memory at the database computer (LOG CAB)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

03905 LOG COL NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03906 LOG CRL NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03907 LOG LNE Fatal SQLBase System Failure (LOG LNE)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

03908 LOG LRO Fatal SQLBase System Failure (LOG LRO)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

03909 LOG BMP Fatal SQLBase System Failure (LOG BMP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

03910 LOG MIP Fatal SQLBase System Failure (LOG MIP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

03911 LOG PNP Fatal SQLBase System Failure (LOG PNP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

03912 LOG ETS Exceed transaction span limit

      Reason: The transaction has exceeded the transaction span limit and
	      therefore has been rolled back by the system.

      Remedy: Long running transactions can pin down disk log files that could
	      otherwise be deleted.  The transaction span limit prevents logs
	      from being pinned down by long running active transactions.  To
	      fix this problem, either modify the transactions so that they
	      are not long running, that is, COMMIT more frequently, or
	      increase or eliminate the transaction span limit.

03913 LOG OOM Out of memory at the database computer (LOG OOM)

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03914 LOG BOX INTERNAL USE ONLY - Boxcar event

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

03915 LOG CLF Fatal SQLBase System Failure (LOG CLF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

03916 LOG BLF Bad log file

      Reason: The database system has determined during recovery that the
	      specified log file serial number does not match the database
	      serial number.

      Remedy: Verify that the correct log files are being used.

03917 LOG IOP Cannot open the log file for consistency check.

      Reason: The log file consistency check mechanism cannot open the log
	      file for its operation.

      Remedy: None

03918 LOG INB Cannot read expected number of bytes from the log file.

      Reason: The log flush mechanism has detected a log file re-read failure.

      Remedy: None, it's possible that the log file has been corrupted at
	      the operating system level.

03919 LOG IOF The log file offset has become inconsistent.

      Reason: The log flush mechanism has detected a corrupted log file
	      offset.

      Remedy: None, this is possibly a fatal SQLBase error.

03920 LOG IFB The log file does not match the log buffer.

      Reason: The log flush mechanism has detected a mismatch between the
	      log file and the log buffer just flushed.

      Remedy: None, it's possible that the log file has been corrupted at
	      the operating system level.

03921 LOG IFS The log file does not match the buffer saved.

      Reason: The log flush mechanism has detected a mismatch between the
	      log file and the log buffer saved for the purpose of matching.

      Remedy: None, it's possible that the log file has been corrupted at
	      the operating system level.

03922 LOG IBS The saved log buffer does not match the original.

      Reason: The log flush mechanism has detected a mismatch between the
	      log buffer and a copy saved for the purpose of matching.

      Remedy: None, this is possibly a fatal SQLBase error.

03923 LOG RFL A bad zero-filled log file length has been detected.

      Reason: The length cannot be greater than a sector.

      Remedy: None, the log file has been corrupted.

03924 LOG RCS A bad log flush record checksum has been detected.

      Reason: The bad log flush record checksum indicates corruption.

      Remedy: None, the log file has been corrupted.

03925 LOG RNB The number of bytes checksumed is wrong.

      Reason: An incorrect number of flushed bytes indicates corruption.

      Remedy: None, the log file has been corrupted.

03926 LOG LSC Log disk space critically short

      Reason: Transaction rolled back due to LOW LOG DISK SPACE

      Remedy: CHECK LOG DISK SPACE IMMEDIATELY. Long running transactions
	      pin down disk log files that could otherwise be deleted.
	      SQLBase has determined that free log disk space is
	      critically low and has forced this transaction to roll
	      back since it is pinning log files that must be released
	      to preserve the integrity of the database.  SQLBase will
	      be forced to shutdown in the near future if this action
	      does not successfully recover log disk space.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the database Recovery Manager of the SQLBase database.
04001 REC CAR Out of memory at the database computer (REC CAR)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04002 REC BLC Bad log record chain

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04003 REC LRF Log read failed

      Reason: Attempting to read a file and a disk read failure has occurred.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

04004 REC MBT Missing begin transaction log record

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04005 REC COL Cannot open log file

      Reason: Attempting to open an existing file and a failure has occurred.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

04006 REC BLR Bad log record

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04007 REC PUF Physical undo of a deallocation chain failed

      Reason: Physical undo for a deallocation chain list head failed
	      to find the desired record at the head of the list.

      Remedy: Contact your local Centura Software Corporation technical
	      support organization for assistance.

04008 REC SNF Savepoint not found

      Reason: Attempting a ROLLBACK to a savepoint identifier and a
	      savepoint with this identifier has not been set.

      Remedy: Verify the savepoint identifier is correct and verify that the
	      savepoint with the correctly specified identifier has been set.

04009 REC CRL Out of memory at the database computer (REC CRL)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04010 REC FNB First log record not begin transaction

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04011 REC CP1 Missing first checkpoint log record

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04012 REC CP2 Missing second checkpoint log record

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04013 REC TLO Fatal SQLBase System Failure (REC TLO)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04014 REC CRC Out of memory at the database computer (REC CRC)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04015 REC DBT Duplicate begin transaction record

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04016 REC TMB Rollforward time must be after online backup end

      Reason: Attempting ROLLFORWARD database-name TO TIME and the specified
	      time is after the time when the backup was taken.

      Remedy: Correct the specified time.

04017 REC MOB Missing online backup begin log record

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04018 REC MOE Missing online backup end log record

      Reason: The transaction log file is corrupted.

      Remedy: Recovery is only available up to this corrupted log file.

04019 REC BTV Fatal SQLBase System Failure (REC BTV)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04020 REC RFN A Rollforward is not currently in progress

      Reason: User Error, rollforward has not been started before this OR the
	      previous rollforward has been completed before this command.

      Remedy: Make sure that a rollforward command is in progress before
	      issuing a "rollforward [database] end" command.

04021 REC RFA Rollforward already started

      Reason: User error, rollforward has already been started.

      Remedy: Finish the current rollforward process or reload from a backup.

04022 REC RFI Rollforward interrupted - must restore database backup again

      Reason: The rollforward operation has been interrupted.

      Remedy: Restore the database from a backup again.

04023 REC CRF Restore database first before rollforward

      Reason: Database is in a crash state.

      Remedy: Restore database to previous backup before beginning rollforward
	      procedure.

04024 REC RCO Cannot rollforward thru region where recovery was turned off

      Reason: User error, you cannot rollforward thru a region where recovery
	      is off.

      Remedy: None.  You cannot rollforward thru RECOVERY OFF region.

04025 REC ITI Fatal SQLBase System Failure (REC ITI)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04026 REC CLR Fatal SQLBase System Failure (REC CLR)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04027 REC LCM Fatal SQLBase System Failure (REC LCM)

      Reason: The checksum of log does not match the original checksum

      Remedy: None. The log has been corrupted.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for buffer
manager object error
04101 BMO OOM Out of menory at the database computer (BMO OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Renedy#8

04102 BMO EDA Compressed load file corrupt

      Reason: Compressed load file hit end before all data decompressed

      Remedy: Compressed load file corrupt

04103 BMO KIL Message has been killed

      Reason: Message has been killed, buffer manager error set.

      Remedy: The LOAD/UNLOAD has been abort by frontend during transfer
	      data.

04104 BMO OPE Cannot open the file

      Reason: Attempting to load or unload the database from a file but the
	      named file cannot be opened.

      Remedy: If the file name was specified, check that the file name is
	      correct.	If the file name is correct or if its not necessary to
	      specify a file name, determine why the file could not be opened.

04105 BMO FAE Unload file already exists.

      Reason: The user issued an UNLOAD command to unload to an
	      existing file.

      Remedy: An unload file of the specified name alresdy exists in the
	      path specified. If you want to overwrite this file, use
	      OVERWRITE option in the UNLOAD command.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for compress
module error
04201 CPR OOM Out of menory at the database computer (CPR OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Renedy#8

04202 CPR OVR INTERNAL USE ONLY - Internal error (CPR OVR)

      Reason: This error is only used internally by the SQLBase system.

      Remedy: Reason#18

04203 CPR INE INTERNAL USE ONLY - Internal error (CPR INE)

      Reason: This error is only used internally by the SQLBase system.

      Remedy: Reason#18

04204 CPR CRP Cannot recognize compressed data in file

      Reason: File data does not conform to the UNLOAD compression format.

      Remedy: Provide the original uncorrupted compressed UNLOAD file or
	      do not specify the "load compress" option to file which
	      was not compressed during unload.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for LoaD
Process error
04301 LDP CAL Out of menory at the database computer (LDP CAL)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Renedy#8

04302 LDP TMB Too much bind data

      Reason: The number of data items read exceeds the number of bind
	      variables specified.

      Remedy: Correct either the SQL statement or the bind data being read so
	      that the number of bind variables matches the number of data
	      elements.

04303 LDP IQS Invalid quoted data field

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

04304 LDP IDT Invalid data type

      Reason: The $DATATYPES line specified an invalid data type.

      Remedy: Correct the $DATATYPES line so that a data types are valid.

04305 LDP IDA Invalid data for specified data type

      Reason: Invalid data has been found for the specified data types.

      Remedy: Correct data so that it matches the specified data types.

04306 LDP UEF Unexpected end of file

      Reason: Load is reading input data or input from an input file and
	      LOad file has unexpectedly reached the end of the file being
	      processed.

      Remedy: Determine why the input data or input file has unexpectedly
	      reached an end of file condition.

04307 LDP NAP Data not specified for all columns in the last row

      Reason: The last row does not include all the columns

      Remedy: Determine why the last input row not include all columns

04308 LDP MCM Missing comma separator

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

04309 LDP INF Load long with file name not supported

      Reason: Using a file as long type column bind data is not supported.

      Remedy: Using actual data istead of file name.

04310 LDP ILL Input too long for load buffer

      Reason: Attempting a load and the input is too long for the current
	      load buffer.

      Remedy: modify the load file.

04311 LDP DTL Diff table name too long

      Reason: Attempting a LOAD DIF command and the table name is too large.

      Remedy: Correct LOAD DIF command by specifying a valid table name.

04312 LDP TNM Table name missing from load file

      Reason: Attempting to load in DIF format and the load table name is
	      missing from the DIF file.

      Remedy: Correct LOAD file to correctly specify the load table name when
	      loading in DIF format.

04313 LDP VCM Vector count missing on load file

      Reason: Attempting to load in DIF format and the vector count is
	      missing from the load file.

      Remedy: Correct LOAD file to correctly specify the vector count when
	      loading in DIF format.

04314 LDP ICO Invalid column number

      Reason: Attempting a LOAD DIF command and a column number in the DIF
	      file format is invalid.

      Remedy: Correct the DIF file attempting to be loaded.

04315 LDP IDI Invalid load data item found

      Reason: Attempting to load in DIF format and the load data type found
	      in the load file is invalid.

      Remedy: Correct LOAD file to correctly specify the load data type when
	      loading in DIF format.

04316 LDP SDI Special data item expected in load

      Reason: Attempting to load in DIF format and a special data item is
	      expected in the load file but is not found.

      Remedy: Correct LOAD file to correctly specify special data items when
	      loading in DIF format.

04317 LDP INV Invalid version string

      Reason: Attempting a SET LOADVERSION command and an invalid version
	      string has been found.

      Remedy: Correct the SET LOADVERSION by specifying a valid version
	      string.

04318 LDP INE Load file end before insert command bind data

      Reason: The load file end before insert command bind data.

      Remedy: Correct the LOAD file to correctly specify the bind data.

04319 LDP INB Load file insert command does not bind data

      Reason: The load file insert command does not bind data.

      Remedy: Correct the LOAD file to correctly specify the bind data.

04320 LDP SET Invalid set command in load file

      Reason: The set command specified does not support in load.

      Remedy: Correct the set command, only set command support is
	      LOADVERSION.

04321 LDP TNE Table does not exist

      Reason: Attempting to load a specific table in ASCII format or unload a
	      specific table in SQL format and the named table does not exist.

      Remedy: Modify command to correctly specify an existing table.

04322 LDP MEQ Missing end quote

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

04323 LDP GON Load Process already gone

      Reason: Load process already terminate because of error.

      Remedy: Check previous api call return code.

04324 LDP NSV Single user system try to execute a server load command

      Reason: Server load process been execute in single user system

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

04325 LDP NEX Load command could not compile and execute twice

      Reason: Try to execute the compiled load command twice

      Remedy: Execute compiled load command twice is not support

04326 LDP NVS Load command hit end befor the start line number

      Reason: Load command start line number exceed load file

      Remedy: Check the start line number

04327 LDP OOO Missing ON or OFF keyword

      Reason: Attempting to set a SQLTalk option ON or OFF and the keyword is
	      either missing or misspelled.

      Remedy: Correct command to specify ON or OFF correctly.

04328 LDP MQN Missing query name

      Reason: Attempting to ERASE, EXECUTE, RETRIEVE, or STORE a stored SQL
	      statement and the statement name has not been specified.

      Remedy: Correct command syntax so that the stored statement name is
	      specified.

04329 LDP CTL Creator name is too large

      Reason: Attempting a STORE command and the creator name exceeds 8
	      characters.

      Remedy: Correct the STORE command by specifying a valid creator name
	      that does not exceed 8 characters.

04330 LDP STL Stored command name is too large

      Reason: Attempting a STORE command and the command name exceeds 18
	      characters.

      Remedy: Correct the STORE command by specifying a valid command name
	      that does not exceed 18 characters.

04331 LDP TPC Tuple count missing in DIF load file

      Reason: Attempting to load in DIF format with missing/incorrect
	      tuple count in the load file.

      Remedy: Correct LOAD file to correctly specify the tuple count when
	      loading in DIF format.

04332 LDP ICR Invalid COMMIT or ROLLBACK command in the load file.

      Reason: A load file should not contain COMMIT or a ROLLBACK command.
	      SQLBase unload command will never generate thhese commands
	      in the unloaded SQL file.

      Remedy: Remove the COMMIT/ROLLBACK command from the load file.

04333 LDP CLF Cannot create Message Log file

      Reason: SQLBase Loader was not able to create a message log file of
	      given name.

      Remedy: Make sure that the given log file name is proper for the given
	      operating system. Note that the log file will be created on
	      the server machine in a multi user SQLBase. Make sure that the
	      the directory path specified (if any) for the log file is
	      corect for the server's operating system. Also make sure that
	      the log file name does not conflict with the load/unload file
	      name on the same machine.

04334 LDP ILC Invalid LOAD or UNLOAD command in the load file.

      Reason: A load file should not contain LOAD or a UNLOAD command.
	      SQLBase unload command will never generate these commands
	      in the unloaded SQL file.

      Remedy: Make sure that you have a valid unload file.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for UNLoad
command errors
04401 UNL PNR Non-printable character found

      Reason: Attempting an UNLOAD and a non-printable data has been found in
	      a column that prevents it from being unloaded.

      Remedy: This column cannot be unloaded.  Possibly create a view that
	      excludes either this row or column and unload from that view.

04402 UNL CLF Cannot open the log file

      Reason: Attempt to create the given log file failed.

      Remedy: Make sure that the given log file name is proper for the given
	      operating system. Note that the log file will be created on
	      the server machine in a multi user SQLBase. Make sure that the
	      the directory path specified (if any) for the log file is
	      corect for the server's operating system. Also make sure that
	      the log file name does not conflict with the load/unload file
	      name on the same machine.

04403 UNL TNE Fatal unload error

      Reason: This is a fatal error during Unload.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center.


04404 UNL TNP Specified Table does not exist in the database

      Reason: The table specified in the unload command does not exist

      Remedy: Make sure that the table name is spelled correctly and the
	      specified table exists.


04405 UNL IFV Fatal unload error

      Reason: This is a fatal error during Unload.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center.


04406 UNL CUL Can't unload long data

      Reason: Attempting to unload data in DIF or ASCII format and the data
	      contains LONG VARCHAR data.

      Remedy: Unload data in SQL format.  LONG VARCHAR data cannot be
	      unloaded in DIF or ASCII format.

04407 UNL CUB Out of memory at the server (UNL CUB)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

04408 UNL CSC Can not store the command if ON SERVER option is not specified

      Reason: Attempt is made to store an Unload/load command having the
	      "ON CLIENT" option (which is the default option). Unload/Load
	      commands can be stored if and only if the unload/load file
	      resides on the Server machine.

      Remedy: Specify "ON SERVER" option in the load/unload command.

04409 UNL CUS Unload of system table not allowed

      Reason: Attempting to UNLOAD a system table.

      Remedy: Correct UNLOAD command.  System tables cannot be unloaded.

04410 UNL CRM Cannot unload while in result set restriction mode

      Reason: Unload operation is not supported when result set restriction
	      mode is on.

      Remedy: Turn off the restriction mode and then re-execute the
	      unload operation.

04411 UNL NSA Must be SYSADM to unload database or schema

      Reason: Only SYSADM can perform the UNLOAD DATABASE/UNLOAD SCHEMA
	      command.

      Remedy: None.  You must have SYSADM database authority to UNLOAD an
	      entire database or database schema.

04501 CSV MNI 003 - Fatal SQLBase System Failure (CSV MNI)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04502 CSV MNE MAIN database not exist

      Reason: Could not find the MAIN database.

      Remedy:

04503 CSV PNF 003 - Fatal SQLBase System Failure (CSV PNF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04504 CSV ITI 003 - Fatal SQLBase System Failure (CSV ITI)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04505 CSV TIU 003 - Fatal SQLBase System Failure (CSV TIU)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04506 CSV BPT 003 - Fatal SQLBase System Failure (CSV BPT)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04507 CSV OOM 008 - Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04508 CSV IST 003 - Fatal SQLBase System Failure (CSV IST)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04509 CSV ICF 003 - Fatal SQLBase System Failure (CSV ICF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04510 CSV TMP 003 - Fatal SQLBase System Failure (CSV TMP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04511 CSV IPS 003 - Fatal SQLBase System Failure (CSV IPS)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04512 CSV ISS 003 - Fatal SQLBase System Failure (CSV ISS)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04513 CSV TCL Too many commit-server log records for transaction.

      Reason: An inconsistency was detected in the database logs
	      pertaining to the commit-server. It detected that a certain
	      transaction had too many log commit-server log records.

      Remedy: This error could be created if the incorrect log files
	      are used during crash-recovery or rollforward restore.
	      Please make sure that the log files are being correctly
	      restored.

04514 CSV CSN Commit-server feature not enabled.

      Reason: The user tried to execute a command requiring the
	      commit-server feature -- for example, the commit of
	      a distributed transaction. This is not enabled
	      on the current server.

      Remedy: Enable the commit-server feature by setting
	      COMMITSERVER=1 in SQL.INI or via the 'sqlset' API call
	      or via the SQLTalk command SET COMMITSERVER ON.

04515 CSV RDS Commit Server Recovery Daemon has already been Started (CSV RDS)

      Reason: The recovery daemon has already been started.

      Remedy: The recovery daemon should be stopped and the command
	      re-executed.

04516 CSV CCD Commit Server cannot connect to participant database (CSV CCD)

      Reason: The commit server cannot connect to one of the participants in
	      the distributed transaction.

      Remedy: Ensure that the commit server can connect to all participants
	      in the distributed transactions.	Please make sure that the
	      SQL.INI is properly configured so that the commit server can
	      access all the databases involved.

04517 CSV ISC Invalid command for single-user server.

      Reason: The commit server feature is not valid for a single-user
	      server.

      Remedy: Either this command is not necessary or an alternative
	      command is sufficient.   If this feature is necessary, start
	      a multi-user server.


04601 DTM IST 003 - Fatal SQLBase System Failure (DTM IST)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04602 DTM ICF 003 - Fatal SQLBase System Failure (DTM ICF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04603 DTM CAC Out of memory at the database computer (DTM CAC)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04604 DTM TLU Distributed transaction left unresolved.

      Reason: A distributed transaction was left unresolved -- i.e it
	      was neither COMMITted nor ROLLBACKed. This is not allowed
	      in the single user database.

      Remedy: A transaction is left in an unresolved state if somehow
	      the commit-server for the transaction (the MAIN database)
	      was not accessible for some reason. Once you make sure that
	      the MAIN DB is available, the next time you connect to this DB,
	      the transaction will be resolved automatically.

04605 DTM UTS Unresolved distributed transactions found.

      Reason: At the end of recovery, there were some unresolved distributed
	      transactions. This is not allowed in the single user
	      database.

      Remedy: If this database has only been accessed through a single user
	      system (eg. SQLDEMO), make sure that the commit-server for
	      the transactions (the MAIN database) is available. If this
	      database has also been accessed through a multi-user system
	      such as a server, then you can access it only via a server
	      until all the unresolved transactions have been resolved.

04606 DTM ITI 003 - Fatal SQLBase System Failure (DTM ITI)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04607 DTM CRT Cannot resolve distributed transaction (DTM CRT)

      Reason: Either a distributed transaction has not been started or
	      if it is, the transaction identifiers do not match.

      Remedy: If you are committing or rolling back a distributed,
	      transaction, use the FORCE option.

04608 DTM VNM Database not set up properly  (DTM VNM)

      Reason: The database has not been set up properly.  The number of
	      bind variables in a stored command do not match the number of
	      bind variables.

      Remedy: Recreate the database or store the commands necessary for
	      executing distributed transactions.

04609 DTM UST Unresolved single user distributed transaction found.

      Reason: At the end  of recovery, there were some unresolved
	      distributed transactions.  These transactions were started
	      in single user mode.  An attempt is being made to start this
	      database as a multi-user server.

      Remedy: This database should be accessed through a single user
	      system (eg. SQLDEMO) to resolve the undecided transactions.
	      Also make sure that the commit-server for the transactions
	      (the MAIN database) is available.



04701 CDN CAC 002 - Out of memory at the client

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

04702 CDN CCS 002 - Out of memory at the client

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

04703 CDN CAP 002 - Out of memory at the client

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

04704 CDN MNI 003 - Fatal SQLBase System Failure (CDN MNI)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04705 CDN NCS No commit-server available

      Reason: No commit-server is available to perform a two-phase commit
	      of the distributed transaction.

      Remedy: Ensure that atleast one of the SQLBase servers you have
	      connected to has COMMITSERVER=1 set in its SQL.INI.

04706 CDN RBV Rollback vote from participant.

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

04707 CDN I2P Invalid 2-phase commit protocol specified.

      Reason: SQLSET was called with parameter SQLP2PP and an invalid
	      value for the protocol.

      Remedy: The value passed to SQLSET must be one of:
		   SQL2STD -- for standard protocol
		   SQL2PRC -- for presumed-commit protcol
		   SQL2PRA -- for presumed-abort protocol

04708 CDN IFC Invalid function code.

      Reason: An attempt was made to execute an invalid function against
	      all participants.

      Remedy: #3


04801 SLK CAS 008 - Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04802 SLK TST 003 - Fatal SQLBase System Failure (SLK TST)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04803 SLK RDM 003 - Fatal SQLBase System Failure (SLK RDM)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04804 SLK TMO Semaphore-lock timeout

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

04805 SLK ILM 003 - Fatal SQLBase System Failure (SLK RDM)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04806 SLK TDO 003 - Fatal SQLBase System Failure (SLK TDO)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04807 SLK ICF 003 - Fatal SQLBase System Failure (SLK ICF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04808 SLK MNI 003 - Fatal SQLBase System Failure (SLK MNI)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04809 SLK LOV 003 - Fatal SQLBase System Failure (SLK LOV)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04810 SLK CAB 008 - Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.


04901 HST TTB 003 - Fatal SQLBase System Failure (HST TTB)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04902 HST CAT 008 - Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04903 HST NUK 003 - Fatal SQLBase System Failure (HST NUK)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04904 HST CAE 008 - Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

04905 HST EDE 003 - Fatal SQLBase System Failure (HST EDE)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04906 HST INS 003 - Fatal SQLBase System Failure (HST INS)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04907 HST ICF 003 - Fatal SQLBase System Failure (HST ICF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

04908 HST INK 003 - Fatal SQLBase System Failure (HST INK)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
relate to the SQLTalk for DOS program.
05001 TLK INR Invalid number of rows

      Reason: Attempting a FETCH command and the number of rows specified is
	      less than one or invalid.

      Remedy: Correct the SQLTalk command.  The FETCH command requires the
	      number of rows to fetch.	The syntax is FETCH n where n is the
	      number of rows to fetch.

05002 TLK QNS Result set restriction mode is not supported for this query

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

05003 TLK COL Can't open long data file -- skipped

      Reason: Attempting to bind long data to a long data file and the file
	      name specified cannot be opened.

      Remedy: Verify that the specified filename is correct.

05004 TLK COC Can't open the cursor file

      Reason: Attempting to open a cursor file and the open is failing.

      Remedy: Check that the cursor filename is correctly specified.  If the
	      cursor filename is correctly specified then determine why the
	      file could not be opened.

05005 TLK CNA Cursor is not active

      Reason: Attempting to DISCONNECT or USE a cursor by number that is not
	      active.

      Remedy: Correct DISCONNECT or USE command to only use a cursor number
	      that has previously been successfully connected to.

05006 TLK DNA Data not allowed with this command

      Reason: Attempting some SQL statement other than INSERT, DELETE,
	      UPDATE, or SELECT and data follows the command indicated by a
	      backslash (\) starting the next line.

      Remedy: Correct SQL statement.  Data can only follow a SQL statement
	      that is an INSERT, DELETE, UPDATE, or SELECT.

05007 TLK CTB Command too big -- ignored

      Reason: SQLTalk has found the input line to big to handle so it is
	      skipping the input line.

      Remedy: Modify the input line.

05008 TLK ICN Invalid cursor number

      Reason: Attempting to CONNECT or USE a cursor by number that is not
	      valid.

      Remedy: Correct CONNECT or USE command to only use a cursor number that
	      has previously been successfully connected to.

05009 TLK MFR Missing FROM keyword

      Reason: Missing FROM keyword.

      Remedy: Correct the SQLTalk command syntax.

05010 TLK TMC Too many columns

      Reason: Attempting a BREAK or COMPUTE command and the number of columns
	      operating on exceed the limit of 20 columns.

      Remedy: Correct BREAK or COMPUTE command.  The number of columns is
	      limited to 20.

05011 TLK CUL Can't unload long data

      Reason: Attempting to unload data in DIF or ASCII format and the data
	      contains LONG VARCHAR data.

      Remedy: Unload data in SQL format.  LONG VARCHAR data cannot be unloaded
	      in DIF or ASCII format.

05012 TLK TTW NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05013 TLK OPE Open file error

      Reason: Attempting to load or unload the database from a file but the
	      named file cannot be opened, or attempting a REORGANIZE command
	      but the temporary file used by the reorganize routine cannot be
	      opened for output on the unload step or opened for input on the
	      reload step, or attempting to SAVE a report or SQL statement in
	      a file for later use and the named file cannot be opened.

      Remedy: If the file name was specified, check that the file name is
	      correct.	If the file name is correct or if its not necessary to
	      specify a file name, determine why the file could not be opened.

05014 TLK CFE Close file error

      Reason: SQLTalk failed in its attempt to close a file after the RUN of a
	      script file or, after the EDIT of the previous SQL statement or,
	      during the REORGANIZE of a database or, at the end of an UNLOAD
	      operation.  This error can also occur when loading LONG VARCHAR
	      data and the "//" terminator is missing.

      Remedy: Determine why the operating system would not allow the closing
	      of the file.

05015 TLK ITL Identifier too long

      Reason: Attempting to define an ALIAS for a column number and the ALIAS
	      name is exceeds 18 characters or more generally, SQLTalk is
	      attempting to parse an indentifier and the has found the
	      identifier to exceed 18 characters.

      Remedy: Correct identifier.

05016 TLK IVA Invalid argument

      Reason: Attempting to set the isolation mode and the mode setting is not
	      RR (read repeatibility), CS (cursor stability), RL (release
	      lock), or RO (read only) or an argument specified on the SQLTalk
	      DOS command line is invalid.

      Remedy: Correct the isolation mode setting or the argument specified on
	      the DOS command line when invoking SQLTalk.

05017 TLK IVN NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05018 TLK MSL Missing slash (e.g.user/password)

      Reason: Attempting a connect command and the forward slash is missing or
	      incorrect.  A forward slash (/) is expected between the user
	      name and password.

      Remedy: Correct connect statement.  The syntax for the connect command
	      is: "CONNECT databasename N username/password" where N is the
	      number assigned to this connection for later reference and
	      username/password is optional.  If username/password is not
	      specified then SYSADM/SYSADM is assumed.	If username/password
	      is specified then both are required with a forward slash
	      separating the two identifiers.

05019 TLK ISC Invalid SET command

      Reason: Attempting a SET command and the keyword immediately following
	      the SET keyword is not recognized as a valid SET option.

      Remedy: Verify that the keyword following SET is a valid SET option.

05020 TLK CNE Command not properly ended

      Reason: SQLTalk has determined that the command being attempted is not
	      properly ended.

      Remedy: Verify that the command is properly ended.

05021 TLK ICS Invalid cursor size

      Reason: An invalid cursor size has been specified on a connect.

      Remedy: Correct cursor size on connect command.

05022 TLK IVP Invalid password

      Reason: An invalid password has been specified signing on to SQLTalk or
	      attempting a connect command within SQLTalk.

      Remedy: Correct password.

05023 TLK MRP Missing right parentheses

      Reason: Attempting connect command and a right parentheses is missing.

      Remedy: Correct connect command.

05024 TLK MIC Missing or invalid cursor number

      Reason: Attempting a DISCONNECT a cursor by number that is not valid.

      Remedy: Correct DISCONNECT command to only use a cursor number that
	      has previously been successfully connected to.

05025 TLK CPS Invalid cache page size

      Reason: An invalid number has been specified for the number of cache
	      pages.

      Remedy: Correct the specified cache page size number.

05026 TLK RFN Invalid run file name

      Reason: Attempting to SAVE a report or SQL statement or attempting to
	      run a script file and the file name is not valid.

      Remedy: Correct file name.

05027 TLK TMR NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05028 TLK COR Can't open the run file

      Reason: Attempting to PRINT or RUN a script file and the specified file
	      name cannot be opened.

      Remedy: Correct file name.

05029 TLK OOO Missing ON or OFF keyword

      Reason: Attempting to set a SQLTalk option ON or OFF and the keyword is
	      either missing or misspelled.

      Remedy: Correct command to specify ON or OFF correctly.

05030 TLK QNE Quoted string not ended properly

      Reason: A quoted string has not been properly ended.

      Remedy: Correct quoted string.

05031 TLK QTL Quoted string is too long

      Reason: A quoted string is larger than 254 characters.

      Remedy: Correct quoted string.

05032 TLK MQS Missing quoted string

      Reason: Attempting a COLUMN command and a quoted string is expected
	      after the keyword HEADING, PICTURE, or NULLS or attempting to
	      execute a DOS command using the syntax "$ 'dos command'" and the
	      quoted string following the dollar sign ($) is missing or
	      attempting to SET NULLS globally and the quoted string following
	      the NULLS keyword is missing.

      Remedy: Supply appropriate quoted string.

05033 TLK NTL Null string is too large

      Reason: Attempting substitute a string for NULLS either for a particular
	      column via the COLUMN command or globally via a SET NULLS
	      command and the substitute string is larger than ten characters.

      Remedy: Reduce the size of the NULLS substitute string.

05034 TLK ISH Invalid show command

      Reason: Attempting a SHOW command and the type of SHOW indicated by the
	      keyword immediately following the SHOW is invalid or misspelled.

      Remedy: Correct the SHOW command.

05035 TLK NSF No active spool file to close

      Reason: Attempting to SET SPOOL OFF and there is no active spool file to
	      turn off.

      Remedy: None.  You cannot turn of a spool file if one does not exist.

05036 TLK SFE Spool file is already active

      Reason: Attempting to set a spool file on and a spool file is already
	      active.

      Remedy: You must turn off the active spool file before starting a new
	      spool file.

05037 TLK COS Can't open the spool file

      Reason: Attempting to open a spool file and the open is failing.

      Remedy: If the spool file name was specified, check that the file name
	      is correct.  If the spool file name is correct or if the spool
	      file name was not specified then determine why the file could
	      not be opened.

05038 TLK IFN Invalid file name

      Reason: Attempting to BACKUP, RESTORE, PRINT TO, SET SCROLL, SET FILTER,
	      SET SPOOL, or UNLOAD and the specified file name is invalid.

      Remedy: Correct the file name.

05039 TLK MLP NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05040 TLK TMA Too many arguments

      Reason: Too many arguments have been specified on the command line.

      Remedy: Correct specified arguments.

05041 TLK NCF No command found to process

      Reason: SQLTalk is attempting to locate a command to process and it is
	      not successfully finding a command to process.

      Remedy: Check source of commands and determine why no commands are found
	      to process.

05042 TLK MBS Previous command must be a select

      Reason: Attempting a BACKWARDS command and the previous command was not
	      a SELECT statement.  A BACKWARDS must be preceded by the
	      execution of a successful SELECT statement.

      Remedy: Always fetch forward via a SELECT prior to attempting a
	      BACKWARDS command.

05043 TLK MQN Missing query name

      Reason: Attempting to ERASE, EXECUTE, RETRIEVE, or STORE a stored SQL
	      statement and the statement name has not been specified.

      Remedy: Correct command syntax so that the stored statement name is
	      specified.

05044 TLK CNS Command NOT stored

      Reason: Attempting to STORE a SQL statement and the store name already
	      exists in the database.  The user is prompted with:

		   Command already exists.  Overwrite it (Y/N)?

	      The user gets a "Command NOT stored" message when responsing "N"
	      to the above question.

      Remedy: Use another store command name.

05045 TLK IFT Invalid format type

      Reason: Attempting to LOAD in other than ASCII, DIF, SQL, or WKS format
	      or attempting to UNLOAD other than ALL or DATABASE or in a
	      format other than ASCII, DIF, or SQL.

      Remedy: Correct LOAD or UNLOAD command to load only in ASCII, DIF, or
	      SQL format and UNLOAD ALL or DATABASE or in formats of ASCII,
	      DIF, or SQL.

05046 TLK OSF Only SQL format allow multi-tables

      Reason: Attempting to UNLOAD other than ALL, DATABASE, or in SQL format
	      and mulit-table unloads are only allowed in an UNLOAD ALL,
	      UNLOAD DATABASE, or UNLOAD in SQL format.

      Remedy: Correct UNLOAD to specify a particular table or use UNLOAD ALL
	      or DATABASE or UNLOAD in SQL format.

05047 TLK ULA Unload aborted

      Reason: Attempting to UNLOAD or REORGANIZE and the unload file cannot
	      be opened.

      Remedy: Determine why the unload file could not be opened.

05048 TLK CUS Unload of system table not allowed

      Reason: Attempting to UNLOAD a system table.

      Remedy: Correct UNLOAD command.  System tables cannot be unloaded.

05049 TLK TNE Table does not exist

      Reason: Attempting to load a specific table in ASCII format or unload a
	      specific table in SQL format and the named table does not exist.

      Remedy: Modify command to correctly specify an existing table.

05050 TLK UEF Unexpected end of file

      Reason: SQLTalk is reading input data or input from an input file and
	      SQLTalk has unexpectedly reached the end of the file being
	      processed.

      Remedy: Determine why the input data or input file has unexpectedly
	      reached an end of file condition.  Try increasing the SQLTalk
	      LOADBUFFER size.

05051 TLK TNM Table name missing from load file

      Reason: Attempting to load in DIF format and the load table name is
	      missing from the DIF file.

      Remedy: Correct LOAD file to correctly specify the load table name when
	      loading in DIF format.

05052 TLK VCM Vector count missing on load file

      Reason: Attempting to load in DIF format and the vector count is
	      missing from the load file.

      Remedy: Correct LOAD file to correctly specify the vector count when
	      loading in DIF format.

05053 TLK UDT NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05054 TLK TTL NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05055 TLK IDI Invalid load data item found

      Reason: Attempting to load in DIF format and the load data type found
	      in the load file is invalid.

      Remedy: Correct LOAD file to correctly specify the load data type when
	      loading in DIF format.

05056 TLK SDI Special data item expected in load

      Reason: Attempting to load in DIF format and a special data item is
	      expected in the load file but is not found.

      Remedy: Correct LOAD file to correctly specify special data items when
	      loading in DIF format.

05057 TLK ISN Invalid source file name

      Reason: Attempting to load from a file but the specified file name is
	      not valid.

      Remedy: Correct LOAD file name.

05058 TLK ITP Invalid title parameter

      Reason: Setting a TTITLE (top title) or BTITLE (bottom title) on a
	      SQLTalk report and the keyword immediately following the SET
	      TTITLE or BTITLE keyword is invalid.

      Remedy: Correct TTITLE or BTITLE set command.  Immediately following
	      TTITLE or BTITLE should be a title string, or the keyword ON,
	      OFF, DATE, or PAGE.

05059 TLK NTS No tables specified

      Reason: Attempting an unload and no table names have been specified.

      Remedy: Identifiy some table names or specify ALL in the UNLOAD command.

05060 TLK TEM Title exceeds max number of lines

      Reason: Attempting a TTITLE or BTITLE command and the command has
	      specified more than three lines to the title.

      Remedy: Modify title so that the title is not more than three lines.

05061 TLK DTN Destination table not used with SQL format

      Reason: Attempting a LOAD SQL and specifying a source file name and
	      a destination table name.

      Remedy: Modify the LOAD SQL command.  Destination table names are not
	      allowed in SQL format.  The SQL statements in the LOAD file
	      identify the table names to be loaded.

05062 TLK MDT Missing destination table name

      Reason: Attempting a LOAD ASCII and specifying a source file name but
	      the destination table name is not specified.

      Remedy: Modify the LOAD ASCII command.  Destination table names are
	      required when loading in ASCII format.

05063 TLK ICI Invalid column identifier

      Reason: Attempting a BREAK, COMPUTE, COLUMN, or ALIAS name command and
	      the column identifier is invalid or exceeds a count of 20.

      Remedy: Modify command to correctly identify the column identifiers.

05064 TLK HTL Header too long

      Reason: Attempting to define a column heading within a COLUMN command
	      and the column heading exceeds 132 characters.

      Remedy: Correct COLUMN command.  Column headings must be 132 characters
	      or less.

05065 TLK HEM Header exceeds max lines allowed

      Reason: Attempting to define a column heading within a COLUMN command
	      and the number of lines defined in the column heading exceeds
	      three.

      Remedy: Correct COLUMN command.  Column headings are restricted to a
	      maximum of three lines.

05066 TLK ICW Invalid column width

      Reason: Attempting to define a column WIDTH within a COLUMN command and
	      the specified width is invalid, is less than one character, or
	      greate than the current output line size.

      Remedy: Correct COLUMN command.  The WIDTH parameter must be defined
	      from 1 to maximum output line size.

05067 TLK ICP Invalid column parameter

      Reason: Attempting a COLUMN command and a specified parameter is
	      invalid or misspelled.

      Remedy: Correct COLUMN command.  Identify and modify the invalid or
	      misspelled COLUMN command parameter.

05068 TLK TIL Title too large

      Reason: Setting a TTITLE (top title) or BTITLE (bottom title) on a
	      SQLTalk report and the title specified exceeds 132 characters.

      Remedy: Correct TTITLE or BTITLE set command.

05069 TLK FCE FATAL CONNECT ERROR - EXIT NOW

      Reason: Attempting to set a cache size or set recovery on or off and
	      SQLTalk performs a disconnect and a reconnect to accomplish
	      these operations.  Unfortunately, the reconnect operation has
	      unexpectedly failed leaving SQLTalk in an unpredictable state.

      Remedy: Exit SQLTalk immediately.  Try again.

05070 TLK CPT Cache page size too large

      Reason: Attempting to set a cache size too large.

      Remedy: Modify SET CACHE to less cache pages than the previous attempt.

05071 TLK UEV Invalid value

      Reason: Attempting SET command and an invalid value has been specified.

      Remedy: Correct SET command.

05072 TLK CRU Can't remove unload file

      Reason: Attempting an unload operation and the unload has failed and
	      the system cannot remove the partially completed unload file.

      Remedy: Erase unload and determine why unload failed.

05073 TLK DNE Database does not exist

      Reason: Attempting to connect to database via SQLTalk and the
	      specified database name is not found.

      Remedy: Correct the database name or detemine why the database name
	      has not been found.

05074 TLK MEK Missing ERRORS keyword

      Reason: Attempting a RUN command with DETECT ERRORS option and the
	      ERRORS keyword is missing or misspelled.

      Remedy: Correct SQLTalk command.	The basic syntax when using the
	      DETECT ERRORS syntax option is:
		   RUN procedure-filename DETECT ERRORS

05075 TLK IWS Out of memory at the client (TLK IWS)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

05076 TLK PTL Picture too long

      Reason: A picture string has exceeded 40 characters.

      Remedy: Correct picture string.  Picture strings are limited to a
	      maximum of 40 characters.

05077 TLK IPI NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05078 TLK IAP Invalid adjust parameter

      Reason: An ADJUST parameter has been specified in a COLUMN command
	      and the ADJUST type is invalid.

      Remedy: Correct ADJUST parameter type.  Valid keywords allowed after
	      the ADJUST keyword are LEFT, CENTER, RIGHT, or OFF.

05079 TLK SAV Invalid SAVE command parameter

      Reason: A SAVE command has been specified with an invalid SAVE type.

      Remedy: Correct the SAVE command.  Valid keywords allowed immediately
	      after the SAVE keyword are SQL, REPORT, or FILTER.

05080 TLK IBP Invalid BREAK command parameter

      Reason: Invalid keyword immediately after BREAK command keyword.

      Remedy: Correct the BREAK command.  Valid BREAKs are either BREAK OFF or
	      BREAK ON [REPORT] column-list.

05081 TLK NBS No breaks specified

      Reason: A BREAK command has been specified without specifying any
	      columns to break on.

      Remedy: Correct the BREAK command.  A list of break columns must be
	      listed or the keyword REPORT must be listed.

05082 TLK CMP Invalid COMPUTE command parameter

      Reason: A COMPUTE command has been specified with an invalid aggregate
	      keyword.

      Remedy: Correct the COMPUTE command.  A COMPUTE command must specify an
	      aggregate computation of either MAX, MIN, SUM, AVG, or COUNT.

05083 TLK MOF Missing OF keyword

      Reason: A COMPUTE command has been specified and the keyword OF is
	      missing after the aggregate computation keyword of MAX, MIN,
	      SUM, AVG, or COUNT.

      Remedy: Correct the COMPUTE command.  The OF keyword is immediately
	      followed by a list of columns to operate on.  See the SQLTalk
	      Command Reference Manual for a complete explanation of the
	      COMPUTE command.

05084 TLK MON NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05085 TLK NBC No break exists for this column

      Reason: A COMPUTE command has specified a break-list but the columns
	      specified in the break-list have not been set as break columns.

      Remedy: Perform BREAK command on any columns to break on.  The COMPUTE
	      command can only specify columns in the break-list that have
	      been established as a break column.

05086 TLK INC Invalid number of columns

      Reason: The RIGHT or LEFT command has been specified and an invalid
	      number has been specified for the number of columns to shift
	      right or left.

      Remedy: Correct the RIGHT or LEFT command.  A valid numeric value must
	      be specified after the RIGHT or LEFT keyword to shift the
	      displayed output of a SELECT command to the right or left of the
	      first column.

05087 TLK AAE Alias already exists

      Reason: The specified ALIAS name already exists.

      Remedy: Correct the COLUMN command to specify a new and unique ALIAS
	      name for the column indicated.

05088 TLK NPF No previous file found for $DATA

      Reason: A $DATA keyword has been found but no previous file exists.

      Remedy: The keyword $DATA is used to signal input from another source.
	      This source is always a previous file, which can be a text file
	      or the keyboard.	When this keyword is encounted, SQLTalk looks
	      for a backslash, followed by data lines, in the  previous  file.
	      Correct the scenario so that a previous file exists.

05089 TLK NDF No data found in previous file

      Reason: A $DATA keyword has been found but no data has been found in the
	      previous file.

      Remedy: The keyword $DATA is used to signal input from another source.
	      This source is always a previous file, which can be a text file
	      or the keyboard.	When this keyword is encounted, SQLTalk looks
	      for a backslash, followed by data lines, in the previous file.
	      Correct the previous file referenced back to so that a backslash
	      exists followed by the data lines.

05090 TLK COP Can not open printer for report

      Reason: Attempting a PRINT command and the printer cannot be opened for
	      the printing of the report.

      Remedy: Verify that the printer is on and enabled.  Retry.

05091 TLK STS Size smaller than column width

      Reason: Attempting to set the linesize smaller than a largest specified
	      column WIDTH.

      Remedy: Reduce size of largest column width to accomodate new linesize.
	      The column width is set with the COLUMN command.

05092 TLK CCD Cursor number conflicts with database name

      Reason: Attempting to disconnect a cursor from a database and the
	      database name specified does not correspond to the database the
	      cursor number is connected to.

      Remedy: Correct the DISCONNECT command.  Verify that the database name
	      is for the specified cursor number.

05093 TLK CIF Cannot open input file

      Reason: Attempting to open an existing file and a failure has occurred.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

05094 TLK MST Missing source or destination table name

      Reason: Attempting a COPY command and the specified source or
	      destination table does not exist.

      Remedy: Verify that the source table exists and is correctly specified.
	      If the source table is correct, verify that the destination
	      table exists and is correctly specified.	The destination table
	      must exist.  The COPY command does not create the destination
	      table, it must previously exist.

05095 TLK ISI NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05096 TLK MTO Missing TO keyword

      Reason: The TO keyword is missing in a COPY command.

      Remedy: Correct COPY command.  The general syntax is COPY source-table
	      TO destination-table.  See the SQLTalk Command Reference Manual
	      for more information on the COPY command.

05097 TLK NPC No previous command found

      Reason: The specified LIST command should display the most recently
	      entered SQL statement but no previous command can be found.

      Remedy: None.  No previous command exists to be listed.

05098 TLK LNF Line number not found

      Reason: The LIST command specified a non-existent line number.

      Remedy: Correct the LIST command.  Specify a valid line number.

05099 TLK CDC NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05100 TLK CEF Cannot open edit file

      Reason: Attempting to EDIT a file and the specified file cannot be
	      opened.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

05101 TLK EDI Editor not available

      Reason: Attempting to EDIT a file and an editor is not available.

      Remedy: An editor can be made available by setting the environment
	      variable EDITOR.	See the SQLTalk Command Reference Manual for
	      more information on the EDIT command.

05102 TLK DEE DOS execution error

      Reason: Attempting to execute a DOS command from within SQLTalk and
	      the operation has failed.

      Remedy: Correct the DOS operation.

05103 TLK MJK NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05104 TLK JFN NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05105 TLK FIL Scroll mode already active

      Reason: Attempting to set SCROLL mode on and its already on.

      Remedy: None.  Cannot turn on SCROLL mode if SCROLL mode is already
	      active.

05106 TLK SSS NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05107 TLK CSM Cannot set cache pages with multi-user database

      Reason: Attempting to set the cache size with a multi-user database.

      Remedy: None.  The database cache size cannot be set from a remote
	      client workstation.  The database cache size can only be set at
	      the database server.  The database cache size can only be set on
	      a single user version of the database.

05108 TLK SP1 Cannot set cache pages if connected more than once

      Reason: Attempting to set the database cache size and you are connected
	      to the database more than once.

      Remedy: Disconnect all cursors but your current cursor.  You can only
	      set the database cache while being connected once to a single
	      user database.

05109 TLK DCC Cannot disconnect current cursor

      Reason: Cannot disconnect your currently connected cursor.

      Remedy: USE a differenct cursor before attempting to disconnect the
	      specified cursor.  You cannot disconnect your last remaining
	      cursor.  To perform database operation without a connection,
	      exit SQLTalk and restart SQLTalk with the NOCONNECT option.

05110 TLK BND Bind variables with no bind data

      Reason: Attempting to execute a command that has bind variables but data
	      after the command has been found to be bound.

      Remedy: Verify that a backslash after the command exists.  The backslash
	      indicates the start of the data to be bound.

05111 TLK MBD NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05112 TLK CTS Command size too small

      Reason: Attempting to set the command size too small.

      Remedy: None.  The command size should not be modified.

05113 TLK CAC Out of memory at the client (TLK CAC)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

05114 TLK ILL Input too long for load buffer

      Reason: Attempting a load and the input is too long for the current
	      load buffer.

      Remedy: Increase the SQLTalk LOADBUFFER size or modify the load file.

05115 TLK CAL Out of memory at the client (TLK CAL)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

05116 TLK DTL Diff table name too long

      Reason: Attempting a LOAD DIF command and the table name is too large.

      Remedy: Correct LOAD DIF command by specifying a valid table name.

05117 TLK CUB Out of memory at the client (TLK CUB)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

05118 TLK MCK Missing CURSOR or FILE keyword

      Reason: The keyword CURSOR or FILE is missing in the SQLTalk syntax for
	      a GET or PUT command.

      Remedy: The SQLTalk keyword CURSOR or FILE is mandatory and must
	      immediately follow either the GET or PUT keyword.

05119 TLK IDN Invalid database name

      Reason: The specified database name is invalid.

      Remedy: Correct the command by specifying a valid database name.

05120 TLK ITN Invalid table name

      Reason: The specified table name is invalid.

      Remedy: Correct the command by specifying a valid table name.

05121 TLK NSC Out of memory at the client (TLK NSC)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

05122 TLK CPO Can not turn print off for subtitle

      Reason: Attempting to turn off PRINT for a column that has been
	      specified with SUBTITLE on.

      Remedy: None.  Columns defined with SUBTITLE on must be printed, that
	      is, they must defined with PRINT on.

05123 TLK TND Table not found in dictionary

      Reason: Attempting to unload a non-existent table.

      Remedy: Verify the correct spelling of the table and verify that the
	      table exists.

05124 TLK MDB Missing DATABASE keyword

      Reason: Attempting a CHECK DATABASE, INSTALL DATABASE, or DEINSTALL
	      DATABASE and the DATABASE keyword is missing or misspelled.

      Remedy: Correct the command by properly specifying the DATABASE keyword.

05125 TLK SRV Missing SERVER keyword

      Reason: Attempting a SHOW DATABASES ON SERVER server-id command and the
	      SERVER keyword is missing or misspelled.

      Remedy: Correct the command by properly specifying the SERVER keyword.

05126 TLK ISV NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05127 TLK MDS Missing DATABASES keyword

      Reason: Attempting a SHOW DATABASES command and the DATABASES keyword is
	      missing or misspelled.

      Remedy: Correct the command by properly specifying the DATABASES
	      keyword.

05128 TLK NSA Must be SYSADM to unload database

      Reason: Only SYSADM can perform the UNLOAD DATABASE command.

      Remedy: None.  You must have SYSADM database authority to UNLOAD an
	      entire database.

05129 TLK NCD NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05130 TLK 001 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05131 TLK SCN Select list element is not a simple column name

      Reason: Attempting a SHOW SELECTLISTNAME command and the select list
	      elements are not simple column names, but rather an expression
	      or constant, and therefore it cannot be displayed.

      Remedy: None.  Expressions and constants cannot be displayed with the
	      SHOW SELECTLISTNAME command.

05132 TLK MFC Missing FROM <directory> clause

      Reason: Attempting a RESTORE command and the FROM directory-name clause
	      is missing.

      Remedy: Correct RESTORE command by properly specifying the FROM
	      directory-name clause.

05133 TLK MTC Missing TO <database> clause

      Reason: Attempting a RESTORE command and the TO dataname-name clause is
	      missing.

      Remedy: Correct RESTORE command by properly specifying the TO
	      database-name clause.

05134 TLK SSC SET SERVER command must precede this operation

      Reason: Attempting to perform a database administrative function and a
	      database server connection has not been established.

      Remedy: Perform a SET SERVER command to establish connection to a remote
	      database server before attempting any database administrative
	      function.

05135 TLK 002 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05136 TLK 003 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05137 TLK BDT Bad datetime, expected: MM/DD/YY HH:MM:SS

      Reason: Attempting a ROLLFORWARD command to a specified date and time
	      that does not conform to the form of "mm/dd/yy hh:mm:ss".

      Remedy: Correct the ROLLFORWARD command by specifying a date and time
	      that conforms to the format of "mm/dd/yy hh:mm:ss".

05138 TLK BTE BACKUP, TIME, or END expected

      Reason: Attempting a ROLLFORWARD command and the keyword BACKUP, TIME,
	      or END is expected immediately after the TO keyword.

      Remedy: Correct the ROLLFORWARD command by specifying a valid keyword
	      after the TO keyword or eithr BACKUP, TIME, or END.

05139 TLK IVS Invalid server name

      Reason: Attempting a SET SERVER command and the speciified server name
	      is either invalid or larger than 8 characters.

      Remedy: Correct the SET SERVER command by specifying a valid server
	      name.

05140 TLK RLE RELEASE LOG expected

      Reason: Attempting a RELEASE LOG command and the mandatory LOG keyword
	      is either missing or misspelled.

      Remedy: Correct the RELEASE LOG command by properly specifying the
	      command as RELEASE LOG.

05141 TLK DOV NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05142 TLK OOS Only ON SERVER or ON CLIENT allowed

      Reason: Attempting a BACKUP or RESTORE command and the keyword after the
	      ON keyword can only be SERVER or CLIENT.

      Remedy: Correct the BACKUP or RESTORE command by properly specifying the
	      ON clause as either ON SERVER or ON CLIENT.

05143 TLK MPE NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05144 TLK RSM Result set mode must be in effect to set restriction

      Reason: Attempting to SET RESTRICTION mode while not in SCOLL mode.

      Remedy: Restriction mode can only be set after turning on scroll mode,
	      that is, SET SCROLL ON.

05145 TLK TMB Too much bind data

      Reason: The number of data items read exceeds the number of bind
	      variables specified.

      Remedy: Correct either the SQL statement or the bind data being read so
	      that the number of bind variables matches the number of data
	      elements.

05146 TLK IDT Invalid data type

      Reason: The $DATATYPES line specified an invalid data type.

      Remedy: Correct the $DATATYPES line so that a data types are valid.

05147 TLK IDA Invalid data for specified data type

      Reason: Invalid data has been found for the specified data types.

      Remedy: Correct data so that it matches the specified data types.

05148 TLK IUN Invalid user name

      Reason: A user name has been entered that exceeds 8 characters.

      Remedy: Correct the user name.

05149 TLK NOF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05150 TLK PWN NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05151 TLK IQS Invalid quoted data field

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

05152 TLK CNL Set cursor is no longer supported

      Reason: The SET CURSOR command is no longer supported.

      Remedy: None.  The SET CURSOR command is not supported.

05153 TLK ICO Invalid column number

      Reason: Attempting a LOAD DIF command and a column number in the DIF
	      file format is invalid.

      Remedy: Correct the DIF file attempting to be loaded.

05154 TLK STL Stored command name is too large

      Reason: Attempting a STORE command and the command name exceeds 18
	      characters.

      Remedy: Correct the STORE command by specifying a valid command name
	      that does not exceed 18 characters.

05155 TLK CTL Creator name is too large

      Reason: Attempting a STORE command and the creator name exceeds 8
	      characters.

      Remedy: Correct the STORE command by specifying a valid creator name
	      that does not exceed 8 characters.

05156 TLK JOR NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05157 TLK ENM Expecting a number

      Reason: Attempting a SET statement and the integer-constant that was
	      expected is invalid.

      Remedy: Correct the SET statement by specifying a valid
	      integer-constant.

05158 TLK INV Invalid version string

      Reason: Attempting a SET LOADVERSION command and an invalid version
	      string has been found.

      Remedy: Correct the SET LOADVERSION by specifying a valid version
	      string.

05159 TLK DLS DATABASE, LOGS, or SNAPSHOT expected

      Reason: Attempting a RESTORE command and the keyword DATABASE, LOGS, or
	      SNAPSHOT was not specified after the RESTORE keyword.

      Remedy: Correct the RESTORE command by specifying either a RESTORE of
	      DATABASE, LOGS, or SNAPSHOT.

05160 TLK NPR Non-printable character found

      Reason: Attempting an UNLOAD and a non-printable data has been found in
	      a column that prevents it from being unloaded.

      Remedy: This column cannot be unloaded.  Possibly create a view that
	      excludes either this row or column and unload from that view.

05161 TLK OOD Missing ON, OFF or DEFAULT keyword

      Reason: Attempting to SET READONLY to something other than ON, OFF, or
	      DEFAULT.

      Remedy: Correct the SET READONLY command by properly specifying either
	      ON, OFF, or DEFAULT.

05162 TLK MSN Missing server name

      Reason: Attempting a SHOW DATABASES command with the ON SERVER clause
	      and the server name has not been found.

      Remedy: Correct the SHOW DATABASES command by properly specifying a
	      valid server name such as "SHOW DATABASE ON SERVER myserver".

05163 TLK NCN No CONNECTs done yet: this command requires a database connection

      Reason: Attempting a SQLTalk command that requires a valid connection to
	      a specific database.

      Remedy: Perform a connect operation or enter SQLTalk by entering the
	      database name, user name, and password to establish a connection
	      to a database.  To get this error, you probably entered SQLTalk
	      with the SQLTalk NOCONNECT option and are now attempting a
	      command that requires a valid connection.

05164 TLK CAB Command aborted due to user's instruction

      Reason: Command has been terminated via user intervention.

      Remedy: None.  Informational only.  The command was stopped at the
	      user's request.

05165 TLK PEP Prepare expected before fetch

      Reason: Attempting to fetch data and no SQL statement has been compiled.

      Remedy: PREPARE a SQL statement before doing a PERFORM or FETCH
	      operation.

05166 TLK NOP NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05167 TLK UWF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

05168 TLK FWF File write failure

      Reason: Attempting to write to a file and a disk write failure has
	      occurred.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

05169 TLK ICH Invalid character

      Reason: An invalid character has been found in the input stream.

      Remedy: Correct invalid character.

05170 TLK NIW This feature is not supported in Windows

      Reason: Attempting a DOS ($) command or attempting to EDIT a file from
	      within SQLTalk and these features are not supported under the
	      Microsoft Windows environment.

      Remedy: None.  DOS commands and the EDIT command is not supported from
	      SQLTalk under Microsoft Windows.

05171 TLK UDS UNLOAD DATABASE only supported for SQLBase

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

05172 TLK MEQ Missing end quote

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

05173 TLK MCM Missing comma separator

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

05174 TLK IVC Code page is not same, check your SQL.INI file and country.sql

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

05175 TLK MSF Database session not exist, must have spool file name

      Reason: Invoked SQLTalk with the NOCONNECT option (i.e., the  database
	      connection does not exist) and the  spool  file  name  is  not
	      specified.

      Remedy: Specify spool file name or make a database  connection  before
	      issuing the command SET SPOOL ON.

05176 TLK RCV Database is active with RECOVERY ON

      Reason: RECOVERY can be disabled only before the database has been
	      changed.

      Remedy: SET RECOVERY must be the first command in an SQLTALK session.

05177 TLK ICL Invalid client name

      Reason: The specified client name is invalid.

      Remedy: Correct the command by specifying a valid client name.

05178 TLK IPN Invalid process number

      Reason: The specified process number is invalid.

      Remedy: Correct the command by specifying a valid process number.

05179 TLK ISE Invalid sqlset command

      Reason: Attempting a SQLSET command and the type of command indicated by the
		   keyword immediately following the SQLSET is invalid or misspelled.

      Remedy: Correct the SQLSET command.

05180 TLK IGE Invalid sqlget command

      Reason: Attempting a SQLGET command and the type of command indicated by the
	      keyword immediately following the SQLGET is invalid or misspelled.

      Remedy: Correct the SQLGET command.

05181 TLK IGS Invalid sqlgsi flag

      Reason: Attempting a SQLGSI command and the type of flag indicated by the
	      keyword immediately following the SQLGSI is invalid or misspelled.

      Remedy: Correct the SQLGSI command.

05182 TLK LIM Transaction outcome is unknown.

      Reason: The user attempted to COMMIT a distributed transaction. But
	      due to an error that occurred during a very narrow window
	      in the distributed commit protocol, the transaction state is
	      unknown -- it may have either committed or aborted.

      Remedy: None. The final arbitrator for the transaction state is the
	      commit-server. The individual databases involved in the
	      transaction will automatically contact the commit-server
	      and resolve the status of the transaction one way or the
	      other -- but they will be consistent with each other.

05183 TLK IPT Invalid participant name

      Reason: The user attempted to set FIRSTPARTICIPANT to a non-existant
	      participant.
	      due to an error that occurred during a very narrow window
	      in the distributed commit protocol, the transaction state is
	      unknown -- it may have either committed or aborted.

      Remedy: Ensure that the participant is part of a distributed
	      transaction.

05184 TLK DTS Distributed transaction not started.

      Reason: The user attempted to execute a command without starting a
	      distributed transaction.

      Remedy: Ensure that a distributed transaction is started.

05185 TLK MSC Stored command cannot be found.

      Reason: Command is missing from SYSCOMMANDS.

      Remedy: Check spelling of command name.

05186 TLK PER Perform must come after a prepare with planonly on

      Reason: Perform must be issued with planonly off

      Remedy: Set planonly off

1.0.0 SQLBase Errors Guide
These DB2 error messages and error message numbers were obtained from the
IBM DB2 Reference Manual (Order Number: SC26-4078), Appendix B., SQL Return
Codes.  Some lengthy messages have been condensed and/or paraphrased.  Some
messages refer to the DB2 reference manual, because the text could not
reasonably be represented in a single line message.

A few messages, for example, numbers 6001 - 6006, are not DB2 messages, but
are generated by the CICS transaction which communicates with DB2.  These
messages are emitted when the CICS transaction detects a user error.
06001 DB2 001 Invalid network message or incorrect message version

      Reason: There are two possible causes for this problem.  First, SQLHost
	      may not be recognizing the router and SQLGateway versions or the
	      router and SQLGateway products are incompatible.	Secondly, an
	      invalid operation is possibly being required from SQLHost.

      Remedy: If you are attempting to connect to a database and get this
	      error, then its probably because the software versions of the
	      router and SQLGateway do not match.  An invalid message may be
	      the result of a garbled message from CICS which caused SQLHost
	      to issue this error code.  If this problem occurs repeatedly, an
	      APPC trace may be informative.

06002 DB2 002 Too many DB2 cursors

      Reason: A single client application is restricted to no more than ten
	      DB2 cursors.  An attempt was made to connect to more.

      Remedy: Disconnect some of the cursors in use or connect with another
	      client application.

06003 DB2 003 This operation is invalid after a commit or rollback

      Reason: An attempt was made to issue an EXECUTE or FETCH or related
	      operation with no compiled statement or cursor.

      Remedy: Compile a SQL command.

06004 DB2 004 Cursor not found for disconnect

      Reason: An attempt was made by the client application to use a cursor
	      that was not connected.

      Remedy: Determine the proper cursor for the client application
	      operation.

06005 DB2 005 Unable to locate host variable for execute or read long

      Reason: The client application attempted to use a bind variable that was
	      not specified in the compiled statement.

      Remedy: Match the bind data name between the compile and the subsequent
	      commands.

06006 DB2 006 Cursor not open for fetch

      Reason: The DB2 thread is available but the cursor is not open when the
	      client application attempted a fetch operation.

      Remedy: Compile the appropriate SQL command before issuing a Fetch.

06007 DB2 007 Statement contains an illegal character

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06010 DB2 010 The string constant is not terminated

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06084 DB2 084 Unacceptable SQL statement

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06100 DB2 100 Row not found, or the result of a query is an empty table

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06101 DB2 101 The statement is too long or complex

      Reason: The SQL statement has caused an internal limitation of SQL to be
	      exceeded.  The amount of code required to process the SQL
	      statement is greater than will fit in the allocated storage
	      area.  This will occur if the statement is longer than 8192
	      characters.  Some of the other causes are if the command:

	      (1) contains a number of operations, especially operations
		  involving decimal or floating point numbers.

	      (2) involves a number of conversions between different data
		  types.

	      (3) involves inserting a number of constants.

	      (4) involves a number of built-in functions, especially those
		  involving arithmetic functions.

      Remedy: Either break the SQL statement into smaller statements or try to
	      remove unnecessary conditions which may exist in the statement.

06102 DB2 102 String constant length > 254 characters or 124 graphic characters

      Reason: The SQL statement contains a character literal or hexadecimal
	      literal that contains more than 254 characters or numbers, or it
	      contains a Double-Byte Character Set (DBCS) literal that
	      contains more than 127 characters.

      Remedy: Decrease the length of the literal and rerun.

06103 DB2 103 Invalid numeric literal

      Reason: A floating-point number did not end with a digit (exponent).
	      For example, 12E is not correct, but 12E0 is correct.

      Remedy: Correct the command.

06104 DB2 104 Statement contains an invalid character or token

      Reason: The statement contains an invalid character or token.  Some of
	      the possible causes are:

	      (1) incorrect character or character string found

	      (2) extra input found following normal completion of an SQL
		  statement

	      (3) name starts with underscore

	      (4) zero length name (inside double quotes)

	      (5) nonnumeric value found in an integer field

	      (6) missing keyword or value

      Remedy: Check the SQL statement for all errors.  Correct the statement
	      and resubmit it.

06105 DB2 105 Invalid string constants

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06107 DB2 107 Name used that is too long

      Reason: The length of a name for a column, table, index, DBSPACE,
	      cursor, host variable, statement, or WHENEVER GO TO label
	      exceeds the maximum of 18.  Only the first 18 characters are
	      displayed.

      Remedy: Correct the command.

06109 DB2 109 Attempt to use a clause that is not permitted

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06110 DB2 110 Invalid hexadecimal literal

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06111 DB2 111 A SQL function does not include a column name

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06112 DB2 112 Function operand is another function or expression after DISTINCT

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06113 DB2 113 Invalid character found in name

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06115 DB2 115 See Error SQLCODE number -115 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06117 DB2 117 Number of insert values not equal to number of object columns

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06118 DB2 118 Object table/view of INSERT,DELETE, or UPDATE also in FROM clause

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06119 DB2 119 A Column in HAVING clause is not included in the GROUP BY clause

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06120 DB2 120 WHERE or SET has function or refers to column in GROUP BY of view

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06121 DB2 121 Column identified more than once in INSERT or UPDATE statement

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06122 DB2 122 SELECT without GROUP BY has col & function or col not in GROUP BY

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06125 DB2 125 Integer in the ORDER BY does not identify a column of the result

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06126 DB2 126 The SELECT contains both an UPDATE clause and an ORDER BY clause

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06127 DB2 127 DISTINCT is specified more than once in a subselect

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06128 DB2 128 Invalid use of NULL in predicate

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06129 DB2 129 The statement contains too many table names

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06131 DB2 131 Statement with LIKE predicate has incompatible data types

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06132 DB2 132 Bad LIKE predicate: operand 1 not column or operand 2 not string

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06133 DB2 133 Bad function in HAVING:arithmetic operation applied to correlated reference

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06134 DB2 134 Improper use of long string col or host variable max length > 254

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06136 DB2 136 Sort cannot be executed because the sort key length > 4000 bytes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06150 DB2 150 INSERT, DELETE, or UPDATE on view where desired operation is not allowed

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06151 DB2 151 See Error SQLCODE number -151 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06153 DB2 153 The create view statement does not include a required column list

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06154 DB2 154 Create view failed because the view definition contains a view

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06155 DB2 155 Bad FROM clause: one of the tables is a view that has a GROUP BY

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06156 DB2 156 ALTER TABLE, DROP TABLE, LOCK TABLE, or CREATE INDEX uses a view

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06158 DB2 158 Number of columns in view not same as number of columns in SELECT

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06159 DB2 159 The name specified on DROP VIEW is a table name

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06160 DB2 160 The WITH CHECK OPTION cannot be used for the specified view

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06161 DB2 161 INSERT/UPDATE not allowed cause result row does not satisfy view

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06164 DB2 164 User does not have the privilege to create a view

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06170 DB2 170 The number of arguments specified for a function is invalid

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06171 DB2 171 The data type/length/value of an argument to a function is invalid

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06172 DB2 172 An invalid function name is specified

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06180 DB2 180 The string representation of a datetime value has invalid syntax

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06181 DB2 181 The string representation of a datetime value is not a valid value

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06182 DB2 182 An arithmetic expression with a datetime value is invalid

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06183 DB2 183 An arithmetic operation on a date/timestamp has an invalid result

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06184 DB2 184 Arithmetic expression with a datetime value contains a host variable

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06185 DB2 185 See Error SQLCODE number -185 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06186 DB2 186 See Error SQLCODE number -186 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06198 DB2 198 The operand of the PREPARE or EXECUTE IMMEDIATE is blank or empty

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06199 DB2 199 Illegal use of a keyword, a token was expected

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06203 DB2 203 A reference to a column is ambiguous

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06204 DB2 204 A name is an undefined name

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06205 DB2 205 Column used that is not a column of the table used

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06206 DB2 206 Column not in inserted table, updated table, or any table in FROM

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06207 DB2 207 Bad ORDER BY: includes column that applies to result of a UNION

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06208 DB2 208 Invalid ORDER BY: an ORDER BY column is not part of result table

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06219 DB2 219 The required explanation table does not exist

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06220 DB2 220 A column in explanation table is not defined properly

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06301 DB2 301 Host variable can't be used as specified because of its data type

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06302 DB2 302 The value of an input variable is too large for the target column

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06303 DB2 303 Value not assigned to host variable: data types not comparable

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06304 DB2 304 Value not assigned to host variable: value not in data type range

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06305 DB2 305 NULL Value not assigned to host variable: no indicator variable

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06309 DB2 309 Invalid predicate: referenced host variable has the NULL length

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06311 DB2 311 The indicated length of a host variable is negative

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06312 DB2 312 Undefined or unusable host variable

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06313 DB2 313 Number of host variables not equal to number of parameter markers

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06401 DB2 401 Operands of arithmetic or comparison operation are not comparable

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06402 DB2 402 An arithmetic function or operator is applied to character data

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06404 DB2 404 The UPDATE or INSERT specifies a string that is too long

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06405 DB2 405 Numeric literal can't be used as specified cause its out of range

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06406 DB2 406 A derived numeric value is not within range of its object column

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06407 DB2 407 Value is NULL, but object column can not contain NULL values

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06408 DB2 408 Value is not comparable with the data type of its object column

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06409 DB2 409 Invalid operand of a COUNT function

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06410 DB2 410 The floating point literal contains more than 30 characters

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06411 DB2 411 The keyword USER cannot be used as specified

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06412 DB2 412 The select clause of a subquery specifies multiple columns

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06413 DB2 413 Overflow occurred during data type conversion

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06414 DB2 414 The numeric column is specified in a LIKE predicate

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06415 DB2 415 Corresponding columns in UNION don't have identical descriptions

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06416 DB2 416 An operand of a UNION contains a long string column

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06417 DB2 417 STATEMENT includes parameter markers as operands of same operator

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06418 DB2 418 STATEMENT string to be prepared has parameter markers in a SELECT

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06419 DB2 419 The result of decimal division has produced a negative scale

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06421 DB2 421 The operands of a UNION do not have the same number of columns

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06501 DB2 501 Cursor identified in a FETCH or DISCONNECT statement is not open

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06502 DB2 502 The cursor identified in a CONNECT statement is already open

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06503 DB2 503 Column not updated: not identified in UPDATE clause of SELECT

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06504 DB2 504 The specified cursor name is not defined

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06507 DB2 507 The cursor identified in the UPDATE or DELETE is not open

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06508 DB2 508 Cursor identified in UPDATE or DELETE is not positioned on a row

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06509 DB2 509 Table in UPDATE or DELETE not the same table designated by cursor

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06510 DB2 510 Table designated by cursor of UPDATE or DELETE cannot be modified

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06511 DB2 511 FOR UPDATE not allowed:table designated by cursor can't be modified

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06514 DB2 514 The cursor is not in a prepared state

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06516 DB2 516 The DESCRIBE statement does not identify a prepared statement

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06517 DB2 517 Cursor not used: its name doesn't identify a prepared SELECT

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06518 DB2 518 EXECUTE statement does not identify a valid prepared statement

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06519 DB2 519 PREPARE statement identifies the SELECT of the opened cursor

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06551 DB2 551 User lacks privilege to perform operation on specified object

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06552 DB2 552 User does not have privilege to perform the specified operation

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06554 DB2 554 An authorization ID cannot grant a privilege to itself

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06555 DB2 555 An authorization ID cannot revoke a privilege from itself

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06556 DB2 556 A privilege cannot be revoked because it is not possessed by user

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06557 DB2 557 Inconsistent GRANT/REVOKE keyword

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06558 DB2 558 The WITH GRANT option is ignored because GRANT is to PUBLIC

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06559 DB2 559 All authorization functions have been disabled

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06560 DB2 560 The WITH GRANT option is ignored for UPDATE

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06601 DB2 601 Name of the object to be created is identical to an existing name

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06602 DB2 602 Too many columns specified in a create index

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06603 DB2 603 Can't create unique index:non-unique data exist for col specified

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06604 DB2 604 Column definition specifies invalid length, precision, or scale

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06607 DB2 607 Operation is not defined for system tables

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06612 DB2 612 Column name is a duplicate column name

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06614 DB2 614 Can't create index: sum of internal key lengths > allowable max

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06616 DB2 616 Specified object cannot be dropped because it is still referenced

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06618 DB2 618 Operation is not allowed on system data bases

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06619 DB2 619 Operation disallowed because work file data base is not stopped

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06620 DB2 620 Keyword in STATEMENT not allowed for table space in work file database

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06623 DB2 623 A clustering index already exists on the specified table

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06636 DB2 636 Partitioning keys not specified in ascending or descending order

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06637 DB2 637 Duplicate keywords

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06644 DB2 644 Invalid value specified for keyword in specified statement

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06646 DB2 646 Table not created:partition/default table space already contains table

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06647 DB2 647 Bufferpool cannot be specified because it has not been activated

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06652 DB2 652 Violation of installation defined edit or validation procedure

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06653 DB2 653 Table in partition table space not available: no partitioned index

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06660 DB2 660 Index not created on partitioned table space:key limit not specified

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06661 DB2 661 Index not created on partitioned table space: parts not = partitions

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06662 DB2 662 Partitioned index can't be created on non-partitioned tablespace

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06663 DB2 663 Number of key limit values is zero, or > columns in key of index

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06664 DB2 664 Internal length of limit-key flds for partitioned index too big

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06665 DB2 665 The PART clause of an ALTER statement is omitted or invalid

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06666 DB2 666 The statement cannot be executed because a utility is in progress

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06667 DB2 667 Cluster index for partition tablspace can't be explicitly dropped

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06668 DB2 668 Can't add column to table because the table has an edit procedure

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06669 DB2 669 A table in a partitioned tablespace cannot be explicitly dropped

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06670 DB2 670 The record length of the table exceeds the page size limit

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06671 DB2 671 Can't alter bufferpool attribute: it changes pagesize of table space

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06676 DB2 676 A 32K page bufferpool may not be used for an index

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06677 DB2 677 Insufficient virtual storage for bufferpool expansion

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06678 DB2 678 Literal for index limit key must conform to data type of column

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06679 DB2 679 Object specified can't be created cause DROP is pending on object

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06680 DB2 680 Too many columns specified for a table

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06681 DB2 681 A column is in violation of installation defined field procedure

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06682 DB2 682 Field procedure could not be loaded

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06683 DB2 683 Invalid column type for FIELDPROC option

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06684 DB2 684 Length of literal list is too long

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06685 DB2 685 Invalid field type

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06686 DB2 686 Column with w/fld proc cant compare w/column w/different fld proc

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06687 DB2 687 Field types incomparable

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06688 DB2 688 Incorrect data returned from field procedure

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06802 DB2 802 Arithmetic overflow or division by zero has occurred

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06803 DB2 803 Inserting/updating unique constrained columns with duplicate data

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06804 DB2 804 Error in application program input parameters for SQL statement

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06805 DB2 805 Specified program name not found in specified plan

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06811 DB2 811 See Error SQLCODE number -811 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06815 DB2 815 See Error SQLCODE number -815 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06817 DB2 817 See Error SQLCODE number -817 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06818 DB2 818 See Error SQLCODE number -818 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06819 DB2 819 Can't recreate View cause it refers to a uncreatable view

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06820 DB2 820 See Error SQLCODE number -820 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06822 DB2 822 SQLDA contains invalid data address or indicator variable address

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06840 DB2 840 Too many items returned in a SELECT or INSERT list

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06901 DB2 901 See Error SQLCODE number -901 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06902 DB2 902 See Error SQLCODE number -902 in IBM DB2 Messages and Codes

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06904 DB2 904 Unsuccessful execution caused by unavailable resource

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06906 DB2 906 SQL statement not executed: function disabled due to prior error

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06909 DB2 909 The object has been deleted

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06910 DB2 910 SQL statement can't access object on which drop/alter is pending

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06911 DB2 911 Current unit of work rolled back due to deadlock or timeout

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06913 DB2 913 Unsuccessful execution caused by deadlock or timeout

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06922 DB2 922 Connection authorization failure

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06923 DB2 923 Connection not established

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06924 DB2 924 DB2 connection internal error

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06925 DB2 925 COMMIT not valid in IMS/VS or CICS/OS/VS environment

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06926 DB2 926 ROLLBACK not valid in IMS/VS or CIC/OS/VS environment

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06927 DB2 927 Language Interface called: connecting environment not established

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06992 DB2 992 Unable to reconnect to DB2; try again later

      Reason: SQLHOST/DB2 was unable to reacquire the DB2 thread after a
	      COMMIT or ROLLBACK syncpoint.

      Remedy: The DB2 thread was released because RLSETHREAD = YES and a
	      DELAYTIME were specified in the VTAM configuration file for
	      GTIMON.  Set RLSETHREAD = NO to not release the DB2 thread at
	      COMMIT or ROLLBACK syncpoint, or increase the DELAYTIME
	      parameter to allow more time to reacquire the DB2 thread.

06993 DB2 993 Set autocommit is invalid with multiple cursors

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06994 DB2 994 Connecting with multiple cursors is invalid with autocommit

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06995 DB2 995 Row too long for fetch

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06996 DB2 996 Long seek past end of long data

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06997 DB2 997 "WHERE CURRENT OF" cursor name not found

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06998 DB2 998 Invalid long field number

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

06999 DB2 999 Current of Cursor processing cannot be used; fetch in-progress

      Reason: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for an Explanation of this error.

      Remedy: This is a DB2 database error message.  Refer to the IBM DB2
	      Reference Manual, Appendix B for the recommended System Action
	      or Programmer Response for this error.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are the result of
NETBios network errors or APPC/PC error message.  SQLBase is NOT generating
these errors.  These errors occur on the NETBios Network and SQLBase received
this error.  After SQLBase receives the NETBIOS Network error, SQLBase passes
this NETBios network error thru the SQLBase Application Interface back to the
application program.	When SQLBase receives a NETBios network error, SQLBase
converts the NETBios network hexidecimal error code to a decimal number and
adds 7000 to produce the following network errors.  Because the NETBIos error
messages vary from vendor to vendor, only the most popular or frequently
occurring NETBios network error messages are listed here.  If you receive
SQLBase a 7000 series network error that is not listed here, subtract 7000
from the SQLBase error number and convert the result from decimal to
hexidecimal and lookup the resulting hexidecimal number in your vendor's
NETBios network reference manual.
07001 NET 001 Illegal buffer length

      Reason: A SEND BROADCAST or SEND DATAGRAM cannot sent more than 512
	      bytes.  For ADAPTER and SESSION STATUS, the buffer length
	      specified was less than the minimum required.

      Remedy: This buffer length is controlled by SQLBase and this problem
	      should not occur.  Report this problem to your local Centura
	      Software Corporation certified technical support center.

07003 NET 003 Invalid command

      Reason: The command code used was incorrect.

      Remedy: Reissue the correct command code.

07005 NET TMO Command timed-out

      Reason: This error has the following meanings: (1) For a CALL or
	      for (2) ADAPTER STATUS, the system time-out period has elapsed.
	      (3) For a SEND or for (4) RECEIVE, the time-out period specified
	      for the CALL or LISTEN has elapsed. (5) For a HANG UP, the
	      time-out period has expired for an outstanding SEND to complete.

      Remedy: (1) For a CALL, try again later. (2) For an ADAPTER STATUS, make
	      sure you are using a correct name. (3) For a SEND, the session
	      has been terminated abnormally.  Establish another session and
	      reissue a SEND. (4) For a RECEIVE, reissue the command. (5) For
	      a HANG UP the session has been terminated abnormally.

07006 NET 006 Message incomplete

      Reason: You received part of a message because your specified buffer
	      length is not big enough to receive the full message.

      Remedy: You must reissue another RECEIVE or RECEIVE ANY command to get
	      the rest of the message before the remote computer times-out.
	      For ADAPTER STATUS, SESSION STATUS, RECEIVE DATAGRAM, and
	      RECEIVE BROADCAST DATAGRAM, the remaining data is lost.

07008 NET ISN Illegal local session number

      Reason: The session number (normally from the workstation) specified is
	      not one of the active sessions.

      Remedy: Specify an active session number when you issue a command.

07009 NET 009 No resource available

      Reason: Not enough space available in the adapter for the session.

      Remedy: Reboot the computer.  This error has probably occurred because
	      there are not enough sessions and commands specified for
	      NETBios.

07010 NET CLO Session closed

      Reason: The session has been closed from either the local or remote
	      computer.

      Remedy: None required.  Informational only.  This is notification for a
	      pending SEND or RECEIVE command that the session has been
	      closed.  For a HANG UP, the session was closed by the remote
	      computer.

07011 NET 011 Command canceled

      Reason: Notification received that the command was canceled.  If the
	      command that was canceled was a SEND or a CHAIN SEND, the
	      session is abnormally terminated.

      Remedy: No action is required.

07013 NET DPL Duplicate name in local name table

      Reason: Attempting to specify a name that is already in the local name
	      table.

      Remedy: Specify another name.

07014 NET 014 Name table is full

      Reason: Up to 16 names have already been added.

      Remedy: Wait until a delete name is issued so an entry will become
	      available.

07015 NET 015 Cmd completed, name has active sessions and is now de-registered

      Reason: The name to be deleted is active in a session now, but is
	      de-registered.  When the name is marked de-registered and has
	      active sessions, it still occupies a slot in the table.  Name is
	      unusable.

      Remedy: Close all sessions using this name for the DELETE command to
	      complete.

07017 NET STF Local session table full

      Reason: There are no available entries in the session table.  The number
	      of sessions is user-specified.

      Remedy: The number of commands must be greater than the number of
	      sessions.  Use NETRESET /SHOW to verify the number.  SQLBase
	      needs one NETBios session for each database it is listening on,
	      and one for each client workstation.  It also needs a free
	      session available when a user switches from one cursor to
	      another.

07018 NET SOR Session open rejected

      Reason: No LISTEN command is outstanding on the remote computer.	This
	      problem may stem from using the Novell NETBios and Microsoft
	      Windows.	You may be able to connect to SQLBase from Microsoft
	      Windows in standard mode but not when in enhanced mode.

      Remedy: Wait until a LISTEN is issued on the remote computer.  Many
	      variables may be involved including the network card (type and
	      brand), IRQ, client workstation computer speed, database server
	      computer speed and which verions of network drivers.  If you
	      slow down the database server computer, you can verify that this
	      is the problem.  Changing network cards and/or IRQ's might be to
	      solve the problem.  The best solution for Novell customers is to
	      get Novell's NETBios 3.01 rev F or later and the latest versions
	      of IPX and NET3 (at least rev d).  Moving to MS Windows 3.0A or
	      later may also help.

07019 NET 019 Illegal name number

      Reason: Invalid name number.

      Remedy: You must use the original name number that was assigned to the
	      name.

07020 NET CFN Cannot find name called or no answer

      Reason: The call name specified cannot be found or did not answer.  This
	      problem may stem from using the Novell NETBios and Microsoft
	      Windows.	You may be able to connect to SQLBase from Microsoft
	      Windows in standard mode but not when in enhanced mode.

      Remedy: Verify that the call name used is correct.  Retry with the
	      correct or a different call name or reissue if the remote
	      computer is busy.  Many variables may be involved including the
	      network card (type and brand), IRQ, client workstation computer
	      speed, database server computer speed and which verions of
	      network drivers.	If you slow down the database server computer,
	      you can verify that this is the problem.	Changing network cards
	      and/or IRQ's might be to solve the problem.  The best solution
	      for Novell customers is to get Novell's NETBios 3.01 rev F or
	      later and the latest versions of IPX and NET3 (at least rev d).
	      Moving to MS Windows 3.0A or later may also help.

07021 NET 021 Name not found, cannot specify *, or 00H

      Reason: The specified name was either not in the table or an asterisk in
	      column 1 of the name field or 00H.

      Remedy: An asterisk or 00H in column 1 is not allowed.  Retry with
	      another name and verify that it is the correct name.

07022 NET 022 Name in use on remote adapter

      Reason: Unique names can only be used once on the network.

      Remedy: Specify another name.

07023 NET 023 Name was deleted

      Reason: This occurs when a name is deleted and there are no outstanding
	      LISTEN, RECEIVE ANY, RECEIVE DATAGRAM, or RECEIVE BROADCAST
	      DATAGRAM commands for that name.

      Remedy: Not action required.

07024 NET SEA Session ended abnormally

      Reason: Either the remote computer is powered off, the cable link is
	      broken, the session SEND or CHAIN SEND has timed-out, or the
	      SEND or CHAIN SEND was canceled, or a HANG UP timed-out waiting
	      for a SEND to complete.

      Remedy: Check the remote end for status and check the cable.  For a SEND
	      or CHAIN SEND, or RECEIVE or RECEIVE ANY, reestablish the
	      session.

07025 NET 025 Name conflict detected

      Reason: Network protocol has detected two or more identical names on the
	      network.

      Remedy: Everyone on the network should delete that name immediately.

07026 NET 026 Incompatible remote device

      Reason: Unexpected protocol packet received.

      Remedy: Verify that all units on the network agree with the network
	      protocols.

07033 NET 033 Interface busy

      Reason: Attempting to call the BIOS out of an interrupt handler routine
	      in process.

      Remedy: Return from the interrupt handler and try again later.

07034 NET 034 Too many commands outstanding

      Reason: The maximum number of commands are outstanding.

      Remedy: If not at maximum number, refer to RESET.  If at maximum number,
	      retry at a later time.

07035 NET 035 Invalid adapter number

      Reason: Attempting to specify a number other than 00H or 01H.

      Remedy: Specify either 00H for the first adapter of 01H if you have and
	      want to use the second adapter.  Correct the number and try
	      again.

07036 NET CDC Command completed while cancel occurring

      Reason: Attempting to cancel a command that already completed, or never
	      existed.

      Remedy: No action required.

07037 NET 037 Reserved name specified

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07038 NET 038 Command not valid to cancel

      Reason: Attempting to cancel a command that is invalid to cancel.

      Remedy: See CANCEL command for the list of commands not valid to cancel.

07255 NET NPR In progress

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07257 NET NNF Network not functioning

      Reason: A network adapter has not been found.

      Remedy: Verify that the network adapter is available in this computer.
	      Check that the network adapter is properly installed.  Is this
	      computer connected to a network?	Try increasing the number of
	      NETBios sessions and commands.

07258 NET INP Invalid network pointer

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07500 NET 500 DBGATEWY local session table full. Call systems programmer.

      Reason: There are not enough NETBios sessions to keep all of the
	      database name listens outstanding.

      Remedy: Verify that enough sessions and commands have configured on the
	      gateway machine.

07501 NET 501 APPC/PC allocation failure, no retry possible

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07502 NET 502 APPC/PC allocation failure, try again later

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07503 NET 503 APPC/PC allocation failure, bad userid/password

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07505 NET 505 APPC/PC attach PU failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07506 NET 506 APPC/PC attach LU failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07507 NET 507 APPC/PC receive data failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07508 NET 508 APPC/PC send data failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07509 NET 509 APPC/PC attach DLC failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07510 NET 510 APPC/PC transaction program ending failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07511 NET 511 APPC/PC transaction program initiating failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07512 NET 512 APPC/PC change number of sessions failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07513 NET 513 APPC/PC detach LU failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07514 NET 514 APPC/PC detach PU failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07515 NET 515 APPC/PC deallocate failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07516 NET 516 APPC/PC unknown failure; turn on verbose tracing

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07517 NET 517 APPC/PC not dialed to a host

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07518 NET 518 APPC/PC no more host sessions available

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07519 NET 519 APPC/PC Unrecoverable error encountered with the host

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07600 NET CAA Cannot allocate adapter status structure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07601 NET CAN Cannot allocate network control block

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

07602 NET NBS Network buffer is too small

      Reason: Mostly likely caused by a lack of real memory at the client
	      workstation computer.

      Remedy: Provide more real memory at the client workstation computer.
	      This could be accomplished by physically adding more memory to
	      the client workstation computer or by removing other resources
	      that are using the real memory of the client workstation
	      computer.

07603 NET CRM Cannot allocate real memory

      Reason: Not enough real memory to hold network adapter information.

      Remedy: Check available real memory at the failing computer.  Attempt to
	      make more real memory available.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
SQLBase file input/output errors.
08001 FIO CCF Cannot commit file

      Reason: The database system is attempting to flush a file and update
	      its directory but a file error has been determined.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center.

08002 FIO CAD NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08003 FIO FME INTERNAL USE ONLY - Max file map entries exceeded

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08004 FIO OOM Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

08005 FIO CGD NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08006 FIO CFN Cannot find file

      Reason: Using DIRECTIO the database server cannot find a database file.

      Remedy: Determine why the database file cannot be found.

08007 FIO IFN Invalid file name

      Reason: Using DIRECTIO the database server has determined that the
	      database file name is invalid.

      Remedy: Correct database file.

08008 FIO CFD Cannot find directory

      Reason: Using DIRECTIO the database server cannot find the database
	      subdirectory.

      Remedy: Determine why the database subdirectory cannot be found.

08009 FIO COF Cannot open file

      Reason: Using DIRECTIO the database server cannot open the database
	      file.

      Remedy: Determine why the database file cannot be opened.

08010 FIO ICN Invalid cluster number

      Reason: Using DIRECTIO the database server determined an invalid
	      cluster number.

      Remedy: Determine why a bad cluster was read.  For more detailed
	      information, see the DOS technical reference about clusters and
	      cluster numbers.

08011 FIO NMS Not in map space

      Reason: Using DIRECTIO the database server is attempting to lookup the
	      logical sector requested in the file map to determine the
	      physical sector equivalent and run length in number of sectors
	      and the logical sector requested has not been found in the map
	      space.  Each map entry contains the relative and physical sector
	      number.

      Remedy: Determine why the logical sector is not in the map space.  For
	      more detailed information, see the DOS technical reference about
	      logical sectors and map space.

08012 FIO CRD Cannot retrieve disk buffer

      Reason: Using DIRECTIO the database server is attempting to retrieve the
	      next FAT (File Allocation Table) entry from the FAT table and it
	      cannot find the disk buffer.  DIRECTIO works with 12-bit and
	      16-big FATs.  Depending on whether a 12-bit or 16-bit FAT is in
	      the sector, it extracts the FAT entry.

      Remedy: Determine why the disk buffer cannot be retrieved.  For more
	      detailed information on FAT tables, see the DOS technical
	      reference on how to access the FAT.  Also, if you are
	      redirecting your files to a network drive, don't load the
	      redirectors and try again without using the network drive.

08013 FIO CGI Cannot get information

      Reason: Using DIRECTIO the database server is trying to get directory
	      information on an open file and the system cannot obtain the
	      necessary information.  The database is attempting to determine
	      the file size, attributes, and starting cluster number.

      Remedy: Determine why the required information could not be obtained.
	      For more detailed info, see the DOS technical reference on how
	      to obtain this information.  This error has frequently occurred
	      when upgrading from one operating system to another.  If you
	      have upgraded your operating system lately, DIRECTIO may not be
	      compatible with this version of your new operating system.

08014 FIO ITG Integrity error

      Reason: Using DIRECTIO the database server is attempting to read or
	      write and has determined an unexpected error.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center.

08015 FIO DME Disk mapping error

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

08016 FIO CID NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08017 FIO DIW Unable to use DIRECTIO

      Reason: The database system has determined DIRECTIO cannot be used on
	      the database server computer.  More generally, this means that
	      SQLBase has examined the specified disk drive, and SQLBase
	      cannot determine what the file structure looks like.  This could
	      potentially happen by having a non-standard disk extender
	      installed such as SPEEDSTORE.  Also, sometimes the file
	      structure may be corrupted and can be fixed by running CHKDSK.

      Remedy: Determine why the database server computer cannot use DIRECTIO.
	      Set the configuration DIRECTIO off, that is, DIRECTIO=0.

08018 FIO CTF Cannot create DIRECTIO test file

      Reason: The database system is testing DIRECTIO can be used on the
	      database server computer and a test file cannot be created.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

08019 FIO WTF Cannot write DIRECTIO test file

      Reason: The database system is testing DIRECTIO can be used on the
	      database server computer and a test file cannot be written.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

08020 FIO RTF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08021 FIO LTF Cannot close DIRECTIO test file

      Reason: The database system is testing DIRECTIO can be used on the
	      database server computer and a test file cannot be closed.

      Remedy: Determine and correct the cause of the CLOSE file error.	Run a
	      check disk utility (CHKDSK) for the database server computer
	      operating system to verify the status of the disk.

08022 FIO STF Cannot seek in DIRECTIO test file

      Reason: The database system is testing DIRECTIO can be used on the
	      database server computer and a seek within a test file has
	      failed.

      Remedy: Determine and correct the cause of the seek file error.  Run a
	      check disk utility (CHKDSK) for the database server computer
	      operating system to verify the status of the disk.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are errors that
relate to database memory workspace.
08101 MEM OUT Out of memory for allocation

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08102 MEM BIG Requested memory size too big for allocation

      Reason: Involved string would require too much memory for concatenation.

      Remedy: Reduce memory requirement to less than 64K bytes.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for pseudo code
generation of procedure
08201 PCG NPC No procedure command found

      Reason: The procedure does not have any command in it.

      Remedy: Add appropriate commands in the ACTIONS section.

08202 PCG CFF Cannot find function

      Reason: Cannot find internal function

      Remedy: This error should not occur.  Call Centura Software
	      Corporation Technical support for assistance.

08203 PCG DOC Duplicate ON clause

      Reason: Duplicate ON clause was seen

      Remedy: This error should not occur.  Call Centura Software
	      Corporation Technical support for assistance.

08204 PCG NLD No LOOP defined

      Reason: BREAK command is used without a prior defined LOOP

      Remedy: Check the program and make sure that the LOOP command is used
	      before BREAK command

08205 PCG NPW No password can be retrieved for connecting to database.

      Reason: Attempts to read the user's password failed.

      Remedy: Check the password to the database and retry later.

08206 PCG NCS Only constant-string commands are allowed in STATIC procedure

      Reason: Embedded commands cannot be composed dynamically.  They must
	      be constant strings.

      Remedy: Change offending command to constant string.

08207 PCG NDD No DDL statement allowed in the static stored procedure

      Reason: Putting DDL(Data Definition Language) statement in static
	      stored procedure is not allowed.

      Remedy: Remove the DDL statement from the static stored procedure.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide occur only at
Stored-Procedure execution time.
08301 SPE INT Internal error occurred in Stored-Procedure execution

      Reason: An internal error has been detected.

      Remedy: None.

08302 SPE CAL Cannot allocate cursor array

      Reason: The Stored-Procedure Executor failed to allocate space for
	      cursors.

      Remedy: None.

08303 SPE COR Cursor (number) out of range (connection probably never made)

      Reason: Large cursor number indicates no prior connection.

      Remedy: Check for proper connection.

08304 SPE CIS Cursor in invalid state

      Reason: The Stored-Procedure Executor detected an operation that's
	      incompatible with the cursor's current state.

      Remedy: Check proper use of cursors.

08305 SPE CNN Cursor has no name and cannot be closed

      Reason: A cursor not opened cannot be closed.

      Remedy: Check proper cursor usage.

08306 SPE CNU Cursor not in use

      Reason: A cursor that's not in use cannot be operated on.

      Remedy: Check proper cursor usage.

08307 SPE CNM Cursor name is missing

      Reason: Cursor name must be supplied for an open operation.

      Remedy: Check all SqlOpen statements.

08308 SPE CIL Invalid cursor name length is detected

      Reason: The length of a cursor name must be within bounds.

      Remedy: Check all cursor names.

08309 SPE COT Cursor opened twice

      Reason: A cursor cannot opened twice.

      Remedy: Check proper use of all SqlOpen statements.

08310 SPE CNE Cursor name already exists

      Reason: A cursor name must be unique.

      Remedy: Check for duplicate cursor names in all SqlOpen statements.

08311 SPE CIQ Cursor in invalid query state

      Reason: A cursor operation must satisfy the current query state.

      Remedy: Check proper use of cursor operations, e.g. SqlOpen must
	      be preceded by SqlPrepare or SqlRetrieve.

08331 SPE MNN Static embedded command has no name

      Reason: A static embedded command has its name missing, an internal
	      error condition..

      Remedy: None.

08341 SPE OIO Addition/subtraction involving datetime failed

      Reason: A datetime addition or subtraction failed.

      Remedy: Check all such additions or subtractions.

08342 SPE OIU Invalid operand update detected

      Reason: Attempt to update a non-variable.

      Remedy: Check for update of non-variables.

08343 SPE OIZ Insufficient operand size detected

      Reason: Attempt to update an operand of smaller size.

      Remedy: Probably an internal error.

08344 SPE OMD Missing operand detected

      Reason: Insufficient number of operands detected.

      Remedy: (This is an internal error.)

08345 SPE OZL Zero length operand/result buffer detected

      Reason: All operands must have a valid length.

      Remedy: (This is an internal error.)

08350 SPE DND Procedure data does not meet the DATE/TIME format

      Reason: Data that is either being passed into a procedure as a
	      parameter or is being returned from an external function
	      does not conform to the required DATE/TIME format.

      Remedy: Properly format such data for presenting to the procedure.

08351 SPE NIR DATE/TIME parameter data not in allowed range

      Reason: DATE/TIME data is either too small or too large.

      Remedy: Correct the value to fall between January 1, 0001 and December
	      31, 9999.

08361 SPE WBZ Invalid buffer size detected

      Reason: A buffer must be large enough for receiving data.

      Remedy: Check all buffer sizes used in stored procedure.

08362 SPE WDT Invalid database parameter type detected in SqlSetParameter
	      or SqlSetParameterAll.

      Reason: Only defined database parameters can be set.

      Remedy: Check for proper use of SqlSetParameter(All).

08363 SPE WDP Invalid database parameter

      Reason: Database parameters can only be set to predefined values.

      Remedy: Check if proper values are provided for SqlSetParameter(All).

08364 SPE WFN Number has a fractional part

      Reason: Attempt to use a fractional number instead of an integer.

      Remedy: Correct the offending number.

08365 SPE WIE Invalid SqlExecute detected

      Reason: Attempt to execute without a successfully compiled command.

      Remedy: Make sure the preceding command compiles correctly.

08366 SPE WII Invalid INTO (variables) in command

      Reason: INTO variables are not allowed in command.

      Remedy: Remove INTO and variables from command.

08367 SPE WIL Invalid string length detected

      Reason: The length of a string must be within bounds.

      Remedy: Check all strings used in stored procedure.

08368 SPE WIO Invalid operand detected

      Reason: Assignment must be done to a variable

      Remedy: Possibly an internal error failing to detect above problem.

08369 SPE WIP Invalid numeric precision detected

      Reason: A variable's numeric precision does not match that of the
	      corresponding SELECT column.

      Remedy: Check all INTO variables used in stored procedure.

08370 SPE WIQ Invalid command type detected

      Reason: SQLExists is not executing a SELECT query.

      Remedy: None since this is an internal error.

08371 SPE WIS Invalid numeric scale detected

      Reason: A variable's numeric scale does not match that of the
	      corresponding SELECT column.

      Remedy: Check all INTO variables used in stored procedure.

08372 SPE WIT Invalid data type detected

      Reason: Assignment requires compatible types.

      Remedy: Check for proper assignment.

08373 SPE WNG Number cannot be negative

      Reason: Attempt to use a negative number.

      Remedy: Correct the offending number.

08374 SPE WNH Operand is not a sql handle

      Reason: Attempt to use a non-handle parameter.

      Remedy: Correct the offending parameter.

08375 SPE WMI Missing item after ':'

      Reason: Variable name is expected to follow a ':'.

      Remedy: Check all bind or into lists in stored procedure.

08376 SPE WNI There is no immediate cursor

      Reason: An attempt to perform an SqlClearImmediate without a prior
	      SqlImmediate.

      Remedy: Make sure an SqlClearImmediate is preceded by an SqlImmediate.

08377 SPE WNN Cursor has no name

      Reason: A cursor that has no name cannot be closed.

      Remedy: Check all SqlClose statements for correctness.

08378 SPE WNP Cannot open a cursor without a prepared query

      Reason: Attempt to open a cursor without a prior prepared query.

      Remedy: Check all SqlOpen statements for correctness.

08379 SPE WNS Cannot open a cursor on a non-select query

      Reason: Attempt to open a cursor without a prior prepared SELECT query.

      Remedy: Check all SqlOpen statements for correctness.

08380 SPE WNV Named variable cannot be found

      Reason: The named variable has not been declared.

      Remedy: Declare the variable.

08381 SPE WPZ SQL function (number) parameter size is too big

      Reason: Attempt to use a (number) parameter whose size is too large.

      Remedy: Correct the offending number.

08382 SPE WTM Type mismatch

      Reason: Assignment requires matching types

      Remedy: Check for proper use of SqlSetParameter.

08383 SPE WMV INTO variables are expected for executing given stored procedure

      Reason: INTO variables are not supplied as expected.

      Remedy: Supply the INTO variables as required by the stored procedure.

08384 SPE WOB No or insufficient BIND variables

      Reason: BIND list does not supply enough vairables..

      Remedy: Correct BIND list to supply the required number of variables.

08385 SPE WTB Too many BIND variables

      Reason: Too many variables are found in BIND list.

      Remedy: Correct BIND list to match the required number of variables.

08386 SPE WOI No or insufficient INTO variables

      Reason: INTO list does not supply enough vairables..

      Remedy: Correct INTO list to supply the required number of variables.

08387 SPE WTI Too many INTO variables

      Reason: Too many INTO variables are found in SELECT list.

      Remedy: Correct INTO list to match the required number of variables.


08388 SPE XIV Invalid parameter value detected

      Reason: Parameter value must be within bounds.

      Remedy: Check parameter data for invalid value.

08389 SPE XNS No space available for allocation

      Reason: Space is exhausted for allocation.

      Remedy: None.

08390 SPE XID Invalid date/time value

      Reason: Parameter value cannot be recognized.

      Remedy: Check data for invalid value.

08391 SPE WDD DDL construct not allowed in STATIC procedure

      Reason: DDL effects can only happen in DYNAMIC procedure.

      Remedy: Remove the DDL construct or change to use DYNAMIC procedure.

08392 SPE WWB Boolean value does not match parameter usage
	      (SqlSetParameterAll)

      Reason: TRUE is expected for number and FALSE for string.

      Remedy: Correct the function's last (boolean) paramter.

08393 SPE EOT Procedure terminated by system or application rollback

      Reason: A system deadlock or application rollback terminated the
	      procedure.

      Remedy: Change the application or eliminate the deadlock problem.

08394 SPE SIL Cannot change isolation level from within stored procedure

      Reason: A change in isolation level requires that active cursors be
	      cleaned up including the cursor on which the stored procedure
	      is being executed. This will not allow the stored procedure
	      to continue executing.

      Remedy: Change isolation level before executing the stored procedure.

08395 SPE FPN NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08396 SPE STL String too large

      Reason: The string variable has exceeded 64K in size. Currently
	      SQLBase stored procedures support a maximum string size
	      of 64K.

      Remedy: Do not exceed 64K string size.

08397 SPE DNN Procedure parameter data is not numeric

      Reason: Data provided for a numeric parameter is expected to be
	      SMALLINT, INTEGER, DECIMAL, FLOAT, or NUMBER.

      Remedy: Make sure the data is numeric.

08398 SPE INR Procedure numeric parameter data not in range

      Reason: An integer value is not within the acceptable range of INTEGER
	      values.

      Remedy: Correct integer value so that it is within the range of an
	      acceptable INTEGER value.  An INTEGER value can have up to 10
	      digits of precision: -2,147,483,648 to +2,147,483,647

08399 SPE MPV Data not fully supplied for all procedure parameter(s)

      Reason: (Initial/default) data must be provided for all parameters.

      Remedy: Make sure all parameter data is presented at time of invocation.

08400 SPE CNA LOAD/UNLOAD on CLIENT not allowed.

      Reason: LOAD/UNLOAD on CLIENT is currently not supported for stored
	      procedures. Be aware that the default is 'on CLIENT'.

      Remedy: Use LOAD/UNLOAD on SERVER.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are errors that
generally occur during the creation and execution of triggers and events.
08401 EX2 TGX Trigger already exists

      Reason: Trying to execute a CREATE TRIGGER and the trigger name already		     exists.

      Remedy: Modify the CREATE TRIGGER statement by using a unique name.

08402 EX2 TGD Trigger does not exist

      Reason: Attempting to execute a DROP TRIGGER and the trigger name does
	      not exist.

      Remedy: Modify the DROP TRIGGER statement to use correct trigger name.

08403 EX2 VNX Event already exists

      Reason: Trying to execute a CREATE EVENT and the event name already
	      exists.

      Remedy: Modify the CREATE EVENT statement by using a unique name.

08404 EX2 VND Event does not exist

      Reason: Attempting to execute a DROP EVENT and the event name does not
	      exist.

      Remedy: Modify the DROP EVENT statement to use correct event name.

08405 EX2 MUT Too many triggers for event/time/frequency

      Reason: Trying to exceed the maximum allowed triggers on a table for the
	same event (Insert, Update, Delete) time (before, after) and
	frequency (Row, Statement).  The current limit is 16.

      Remedy: Drop one of the triggers defined on this table.

08406 EX2 TGA Identical trigger already exists

      Reason: A trigger already exists on this table for the same
	event (Insert, Update, Delete), time (before, after) and
	frequency (Row, Statement) and ORDER value.

      Remedy: Change the value of the ORDER clause.

08407 EX2 TGC Message deleted - Multiple trigger support

      Reason: Should never occur.

      Remedy: None.

08408 EX2 TGE Message deleted - Multiple trigger support

      Reason: Should never occur.

      Remedy: None.

08409 EX2 VN2 Event already exists

      Reason: Trying to execute a CREATE EVENT and the event name already
	      exists.

      Remedy: Modify the CREATE EVENT statement by using a unique name.

08410 EX2 VNM Event does not exist

      Reason: Attempting to execute a DROP EVENT and the event name does not
	      exist.

      Remedy: Modify the DROP EVENT statement to use correct event name.

08411 EX2 TGK Trigger defined on column

      Reason: Attempting to drop a column upon which one or more triggers are
	      defined.

      Remedy: Drop the dependent triggers before dropping the column.

08412 EX2 TGL Delete Cascade constraint already defined on table.

      Reason: Cannot create a Delete trigger on a table that has a Delete
	      Cascade constraint defined on it.

      Remedy:

08413 EX2 TGM Delete Null constraint already defined on table.

      Reason: Cannot create a Update trigger on a column that has a Delete
	      Null constraint defined on it.

      Remedy:

08414 EX2 TGN Delete trigger already defined on table.

      Reason: Cannot create a Delete Cascade constraint on a table that
	      has a Delete trigger defined on it.

      Remedy:

08415 EX2 TGO Update trigger already defined on table.

      Reason: Cannot create a Delete Null constraint on a column if an
	      Update trigger is already defined on it.

      Remedy:

08416 EX2 TGP Commit/Rollback/Savepoint not allowed from within triggerred
	      command.

      Reason: If an Insert/Delete/Update action in a transaction causes
	      a trigger to be activated, the trigger is not
	      allowed to do a commit/rollback/savepoint in that transaction.

      Remedy: Commit/Rollback/Savepoint after Insert/Delete/Update
	      completes.

08417 EX2 TGQ Maximum trigger level exceeded.

      Reason: The maximum number of nested triggers has been exceeded.
	      It is possible that a trigger is recursing on itself or
	      is in a cycle.

      Remedy: Check for cyclic or recursive triggers.

08418 EX2 VGZ The value being set should be greater than zero.

      Reason: This statistics column accepts a value that is greater
	      than zero.

      Remedy: Check the expression on the right handside of the statistics
	      column for possible errors in values of constants or bind
	      variables.  Correct it and retry.

08419 EX2 VPK The columns inside parenthesis do not form a valid prefix key.

      Reason: The columns inside the parenthesis following the key word
	      DISTCOUNT must form a valid ordered partial or full subset
	      of columns that constitue ordered list of the index key
	      columns.

      Remedy: Check the names of columns and the order of occurrence
	      inside the parenthesis against the index definition.
	      Correct it and retry.

08420 EX2 NSC This is a non modifiable statistics column.

      Reason: The columns inside the parenthesis following the key word
	      DISTCOUNT must form a valid ordered partial or full subset
	      of columns that constitue ordered list of the index key
	      columns.

      Remedy: Check the names of columns and the order of occurrence
	      inside the parenthesis against the index definition.
	      Correct it and retry.

08421 EX2 VEZ The value being set should be greater than or equal to zero.

      Reason: This statistics column accepts a value greater than or
	      equal to zero.

      Remedy: Check the expression on the right handside of statistics
	      column for possible errors in values of constants or bind
	      variables.  Correct it and retry.

08422 EX2 OHM Out of heap memory during execution of the command.

      Reason: The command is unable to acquire heap memory to process.

      Remedy: Re-submit when more memory is available

08423 EX2 ODB You are not an owner, or a creator, or a DBA.

      Reason: UPDATE STATISTICS on TABLE or INDEX requires you to be the
	      owner of the base table or have DBA privilages.

      Remedy: Request a DBA or the creator of the base table to execute
	      the command.

08424 EX2 TRT The table cannot be renamed since a trigger references it.

      Reason: A trigger is referencing this table and hence cannot be
	      renamed.

      Remedy: Drop all triggers and rename the table.  Recreate all the
	      triggers after renaming the table.

08425 EX2 TRC Column cannot be renamed since a trigger exists on the table.

      Reason: The column belongs to a table on which a trigger is defined.

      Remedy: Drop all triggers and rename the column.	Recreate all the
	      triggers after renaming the column.

08426 EX2 TMC Column cannot be modified since a trigger exists on the table.

      Reason: The column belongs to a table on which a trigger is defined.

      Remedy: Drop all triggers and modify the column.	Recreate all the
	      triggers after modifying the column.

08427 EX2 TDC Column cannot be dropped since a trigger exists on the table.

      Reason: The column belongs to a table on which a trigger is defined.

      Remedy: Drop all triggers and drop the column.  Recreate all the
	      triggers after dropping the column.

08428 EX2 TFF Trigger fetch failed.

      Reason: There was failure in fetching the output values from the
	      triggerred procedure.

      Remedy: Make sure the output values match the column datatype and
	      size correctly.

08429 EX2 DOP Cannot delete function, dependent object <name> present.

      Reason: An attempt has been made to delete an object with the
	      DELETE RESTRICT rule and there are dependent objects.
	      Hence the delete cannot succeed.

      Remedy: Either change the delete rule or drop the dependent object
	      first.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for event
manager.  These errors occurs during the run time.
08501 EVM UIN INTERNAL USE ONLY - Event manager not initialized

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08502 EVM AIN INTERNAL USE ONLY - Event manager already initialized

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08503 EVM UEV INTERNAL USE ONLY - Unknown event

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

08504 EVM NEV INTERNAL USE ONLY - Event not allowed

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are the result of
General Communication Interface errors.  SQLBase is NOT generating all these
errors.  These errors occur on the NETBios Network and SQLBase received this
error.  After SQLBase receives the NETBIOS Network error, SQLBase passes this
NETBios network error thru the SQLBase Application Interface back to the
application program.	When SQLBase receives a NETBios network error, SQLBase
converts the NETBios network hexidecimal error code to a decimal number and
adds 9000 to produce the following network errors.  Because the NETBIos error
messages vary from vendor to vendor, only the most popular or frequently
occurring NETBios network error messages are listed here.  If you receive
SQLBase a 9000 series network error that is not listed here, subtract 9000
from the SQLBase error number and convert the result from decimal to
hexidecimal and lookup the resulting hexidecimal number in your vendor's
NETBios network reference manual.
09001 GCI IBL Illegal buffer length

      Reason: A SEND BROADCAST or SEND DATAGRAM cannot send more than 512
	      bytes.  For ADAPTER and SESSION STATUS, the buffer length
	      specified was less than the minimum required.

      Remedy: Specify the correct size for the buffer and try again.

09003 GCI IVC Invalid command

      Reason: The command code used was incorrect.

      Remedy: Reissue the correct command code.

09005 GCI TMO Command timed-out

      Reason: This error has the following meanings: (1) For a CALL or
	      for (2) ADAPTER STATUS, the system time-out period has elapsed.
	      (3) For a SEND or for (4) RECEIVE, the time-out period specified
	      for the CALL or LISTEN has elapsed. (5) For a HANG UP, the
	      time-out period has expired for an outstanding SEND to complete.

      Remedy: (1) For a CALL, try again later. (2) For an ADAPTER STATUS, make
	      sure you are using a correct name. (3) For a SEND, the session
	      has been terminated abnormally.  Establish another session and
	      reissue a SEND. (4) For a RECEIVE, reissue the command. (5) For
	      a HANG UP the session has been terminated abnormally.

09006 GCI MIN Message incomplete

      Reason: You received part of a message because your specified buffer
	      length is not big enough to receive the full message.

      Remedy: You must reissue another RECEIVE or RECEIVE ANY command to get
	      the rest of the message before the remote computer times-out.
	      For ADAPTER STATUS, SESSION STATUS, RECEIVE DATAGRAM, and
	      RECEIVE BROADCAST DATAGRAM, the remaining data is lost.

09008 GCI ISN Illegal local session number

      Reason: The session number (normally from the workstation) specified is
	      not one of the active sessions.

      Remedy: Specify an active session number when you issue a command.

09009 GCI NRA No resource available

      Reason: This error is currently undocumented.

      Remedy: If you are using a 3Com LAN Manager, there is a file called
	      \3OPEN\OS2WRKSTA\LANMAN\LANMAN.INI (fully qualified) that has a
	      section in it like: [workstation]
				     maxcmds=nn
				     maxthreads=nn
	      Make maxcmds=64 and maxthreads=32 and it may solve your problem.
	      Another file that possibly is important is the file:
	      \3OPEN\OS2WRKSTA\LANMAN\DRIVERS\ADAPTER\LDR.CFG (fully
	      qualified) that has a line like: "program=
	      c:\3open\os2wrksta\lanman\drivers\adapter\nba.exe /s32 /n32"
	      where the /s is important because it tells the adapter card the
	      number of session and the /n tells the adapter card the number
	      of commands.

09010 GCI CLO Session closed

      Reason: The session has been closed from either the local or remote
	      computer.

      Remedy: None required.  Informational only.  This is notification for a
	      pending SEND or RECEIVE command that the session has been
	      closed.  For a HANG UP, the session was closed by the remote
	      computer.

09011 GCI CMC Command canceled

      Reason: Notification received that the command was canceled.  If the
	      command that was canceled was a SEND or a CHAIN SEND, the
	      session is abnormally terminated.

      Remedy: No action is required.

09013 GCI DPL Duplicate name in local name table

      Reason: Attempting to specify a name that is already in the local name
	      table.

      Remedy: Specify another name.

09014 GCI NTF Name table is full

      Reason: Up to 16 names have already been added.

      Remedy: Wait until a delete name is issued so an entry will become
	      available.

09015 GCI NDR Cmd completed, name has active sessions and is now de-registered

      Reason: The name to be deleted is active in a session now, but is
	      de-registered.  When the name is marked de-registered and has
	      active sessions, it still occupies a slot in the table.  Name is
	      unusable.

      Remedy: Close all sessions using this name for the DELETE command to
	      complete.

09017 GCI STF Local session table full

      Reason: There are no available entries in the session table.  The number
	      of sessions is user-specified.

      Remedy: The number of commands must be greater than the number of
	      sessions.  Use NETRESET /SHOW to verify the number.  SQLBase
	      needs one NETBios session for each database it is listening on,
	      and one for each client workstation.  It also needs a free
	      session available when a user switches from one cursor to
	      another.

09018 GCI SOR Session open rejected

      Reason: No LISTEN command is outstanding on the remote computer.	This
	      problem may stem from using the Novell NETBios and Microsoft
	      Windows.	You may be able to connect to SQLBase from Microsoft
	      Windows in standard mode but not when in enhanced mode.

      Remedy: Wait until a LISTEN is issued on the remote computer.  Many
	      variables may be involved including the network card (type and
	      brand), IRQ, client workstation computer speed, database server
	      computer speed and which verions of network drivers.  If you
	      slow down the database server computer, you can verify that this
	      is the problem.  Changing network cards and/or IRQ's might be to
	      solve the problem.  The best solution for Novell customers is to
	      get Novell's NETBios 3.01 rev F or later and the latest versions
	      of IPX and NET3 (at least rev d).  Moving to MS Windows 3.0A or
	      later may also help.

09019 GCI INN Illegal name number

      Reason: Invalid name number.

      Remedy: You must use the original name number that was assigned to the
	      name.

09020 GCI CFN Cannot find name called or no answer

      Reason: The call name specified cannot be found or did not answer.  This
	      problem may stem from using the Novell NETBios and Microsoft
	      Windows.	You may be able to connect to SQLBase from Microsoft
	      Windows in standard mode but not when in enhanced mode.

      Remedy: Verify that the call name used is correct.  Retry with the
	      correct or a different call name or reissue if the remote
	      computer is busy.  Many variables may be involved including the
	      network card (type and brand), IRQ, client workstation computer
	      speed, database server computer speed and which verions of
	      network drivers.	If you slow down the database server computer,
	      you can verify that this is the problem.	Changing network cards
	      and/or IRQ's might be to solve the problem.  The best solution
	      for Novell customers is to get Novell's NETBios 3.01 rev F or
	      later and the latest versions of IPX and NET3 (at least rev d).
	      Moving to MS Windows 3.0A or later may also help.

	      If you are using DBXNRTR, try increasing NUMDB in SQL.INI
	      and retry.

09021 GCI NMF Name not found, cannot specify *, or 00H

      Reason: The specified name was either not in the table or an asterisk in
	      column 1 of the name field or 00H.

      Remedy: An asterisk or 00H in column 1 is not allowed.  Retry with
	      another name and verify that it is the correct name.

09022 GCI NUR Name in use on remote adapter

      Reason: Unique names can only be used once on the network.

      Remedy: Specify another name.

09023 GCI NWD Name was deleted

      Reason: This occurs when a name is deleted and there are no outstanding
	      LISTEN, RECEIVE ANY, RECEIVE DATAGRAM, or RECEIVE BROADCAST
	      DATAGRAM commands for that name.

      Remedy: Not action required.

09024 GCI SEA Session ended abnormally

      Reason: Either the remote computer is powered off, the cable link is
	      broken, the session SEND or CHAIN SEND has timed-out, or the
	      SEND or CHAIN SEND was canceled, or a HANG UP timed-out waiting
	      for a SEND to complete.

      Remedy: Check the remote end for status and check the cable.  For a SEND
	      or CHAIN SEND, or RECEIVE or RECEIVE ANY, reestablish the
	      session.

09025 GCI NMC Name conflict detected

      Reason: Network protocol has detected two or more identical names on the
	      network.

      Remedy: Everyone on the network should delete that name immediately.

09026 GCI IRD Incompatible remote device

      Reason: Unexpected protocol packet received.

      Remedy: Verify that all units on the network agree with the network
	      protocols.

09028 GCI SEN session ended normally

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09033 GCI IFB Interface busy

      Reason: Attempting to call the BIOS out of an interrupt handler routine
	      in process.

      Remedy: Return from the interrupt handler and try again later.

09034 GCI TMC Too many commands outstanding

      Reason: The maximum number of commands are outstanding.

      Remedy: If not at maximum number, refer to RESET.  If at maximum number,
	      retry at a later time.

09035 GCI IAN Invalid adapter number

      Reason: Attempting to specify a number other than 00H or 01H.

      Remedy: Specify either 00H for the first adapter of 01H if you have and
	      want to use the second adapter.  Correct the number and try
	      again.

09036 GCI CDC Command completed during cancel

      Reason: Attempting to cancel a command that already completed, or never
	      existed.

      Remedy: No action required.

09037 GCI RNS Reserved name specified

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09038 GCI NVC Command not valid to cancel

      Reason: Attempting to cancel a command that is invalid to cancel.

      Remedy: See CANCEL command for the list of commands not valid to cancel.

09255 GCI PND Pending completion

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09256 GCI NNF Network not functioning

      Reason: A network adapter has not been found.

      Remedy: Verify that the network adapter is available in this computer.
	      Check that the network adapter is properly installed.  Is this
	      computer connected to a network?	Try increasing the number of
	      NETBios sessions and commands.

09257 GCI INP Invalid network pointer

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09258 GCI CGA Cannot get address

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09259 GCI CRH Cannot resolve hostname

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09260 GCI DNC Database name not configured

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09261 GCI INI Invalid network interface

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09262 GCI INR Network interface not running

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09263 GCI OOM Out of memory

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09264 GCI INH Invalid handle

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09265 GCI SSE Session error

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09266 GCI NCF No configuration file

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09267 GCI IDL Invalid COM DLL

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09268 GCI CCN Cannot connect

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09269 GCI TMA Too many arguments

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09270 GCI IAL Invalid argument list

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09271 GCI AIN Already initialized

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09272 GCI NTI Not initialized

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09273 GCI TIP Termination in progress

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09274 GCI MCE Missing configuration file entry

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09275 GCI NCD No COMDLL configuration parameter specified

      Reason: No COMDLL specification has been found in SQL.INI.  At least one
	      COMDLL entry is required for the OS/2, Windows, and Netware
	      enviornments.

      Remedy: Insert the appropriate configuration file configuration
	      parameters which identify at least one communication protocol.
	      For example, COMDLL=SQLNBIOS is used for OS/2 and
	      COMDLL=SQLNBIOW is used for Windows to identifiy NETBIOS as
	      the communication protocol to be used.  The location of these
	      configuration parameters is dependent on the environment and
	      platform.  Please see documentation for further details.

09276 GCI STO Semaphore timed out

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09277 GCI CNL Cancel command error

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09278 GCI OOS Out of sessions

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09279 GCI EOR Cannot find specified protocol entry

      Reason: The protocol name on the DBNAME or SERVERNAME entry in the
	      SQL.INI configuration file has a misspelling of a protocol name
	      when it is compared to the entry in the [xxxxx.DLL] section of
	      the SQL.INI file.  Or, the protocol name on the DBNAME or
	      SERVERNAME entry in the SQL.INI file was not specified at all
	      in the [xxxxx.DLL] section of the SQL.INI file.

      Remedy: Verify the spelling of the protocol name on the DBNAME or
	      SERVERNAME entry in the SQL.INI configuration file as compared
	      to the entry in the [xxxxx.DLL] section of the SQL.INI file.

09281 GCI COC Cannot open configuration file

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09282 GCI GEN General error

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09283 GCI IVL Incorrect version of library

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09284 GCI ICK Invalid GCI configuration keyword or parameter

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09285 GCI CGF Cannot get flags

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09286 GCI INU Network interface not up

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09287 GCI NAC Network address conflict

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09288 GCI CFP Cannot find protocol

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09289 GCI CCS Cannot create socket

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09290 GCI CBS Cannot bind socket

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09291 GCI CLS Cannot listen on socket

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09292 GCI CAC Cannot accept connection

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09293 GCI NDL Cannot load any communication DLLs, network may not be installed

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09294 GCI CAS Cannot allocate semaphore

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09295 GCI 295 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

09296 GCI CIN Cancel invalid for this COM DLL

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09297 GCI DAE DEALLOCATE verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09298 GCI TEE TPENDED verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09299 GCI RWE RECEIVE_AND_WAIT verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09300 GCI SDA SEND_DATA verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09301 GCI DNF Input dbname not found in APPC tables

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09302 GCI NLA No LUs available to start a session

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09303 GCI AEE ASCII-to-EBCDIC conversion error

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09304 GCI TSE TPSTARTED verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09305 GCI ALE ALLOCATE verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09306 GCI UAB Unable to allocate input/output buffers

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09307 GCI CMN Communication Manager not running

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09308 GCI FLE FLUSH verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09309 GCI SNV Userid/password security not valid

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09310 GCI LNN Listen name not previously registered

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09311 GCI LNR Listen name not ready to listen

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09312 GCI RAE RECEIVE_ALLOCATE verb failure

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09313 GCI RAC Listen cancelled

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09314 GCI TLM Tranid, local LU, or modename missing

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09315 GCI HNM Serverpath specified, but no hostname

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09316 GCI SNF Servername not found in server table

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09317 GCI NSP Function not fully supported

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09318 GCI TNA Host transaction program not available

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09319 GCI TNR Host transaction name not recognized

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09320 GCI DAP Host transaction abended

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09321 GCI CSA Communication Manager abended

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09322 GCI SUS Only one task connection allowed for DBWINDOW

      Reason: DBWINDOW is a single user database engine and more than one task
	      is attempting to connect the database.

      Remedy: None.  Multple tasks are not allowed to be connected to the
	      DBWINDOW database simultaneously.

09323 GCI TPU Transport provider unavailable

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09324 GCI TAU Transport address unavailable

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09325 GCI TLF Transport listen failed

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09326 GCI TAF Transport accept failed

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09327 GCI OSE Operating system error

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09328 GCI ALU ATTACH_LU verb failure

      Reason: The APPC protocol received an error while issuing the ATTACH_LU
	      verb.  An error code identifying the specific reason for the
	      failure was displayed in an accompanying message.  Please refer
	      to the NOVELL NetWare LU6.2 Technical Reference, Appendix C, for
	      a description of the error code received.

      Remedy: This error should not occur.  Contact your local Centura
	      Software Corporation certified technical support center.

09329 GCI ADC ACTIVATE_DLC verb failure

      Reason: The APPC protocol received an error while issuing the
	      ACTIVATE_DLC verb.  An error code identifying the specific
	      reason for the failure was displayed in an accompanying message.
	      Please refer to the NOVELL NetWare LU6.2 Technical Reference,
	      Appendix C, for a description of the error code received.

      Remedy: This error should not occur.  Contact your local Centura
	      Software Corporation certified technical support center.

09330 GCI CNS CNOS verb failure

      Reason: The APPC protocol received an error while issuing the CNOS verb.
	      An error code identifying the specific reason for the failure
	      was displayed in an accompanying message.  Please refer to the
	      NOVELL NetWare LU6.2 Technical Reference, Appendix B and
	      Appendix C, for a description of the error code received.

      Remedy: This error should not occur.  Contact your local Centura
	      Software Corporation certified technical support center.

09331 GCI SNI SPX Not Installed

      Reason: The SPX Interface has not been installed correctly.  The call to
	      SPXInitialize (NWIPXSPX) has failed.

      Remedy: Contact your local Novell certified technical support center.

09332 GCI COS Cannot open socket

      Reason: It could be that IPX/SPX Socket table is full

      Remedy: Check and correct IPX Sockets parameter in net.cfg file

09333 GCI ILP IPXListenForPacket Failed

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09334 GCI ISP IPXSendPacket Failed

      Reason: Causes are bad packet, or packet not deliverable, or hardware
	      failure.

      Remedy: Check and correct the accessibility of the destination node.

09335 GCI SEC SPXEstablishConnection Failed

      Reason: It could be that IPX/SPX Connection table is full

      Remedy: Check and correct IPX Connection parameter in net.cfg file

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
are generated by the SQLBase Group Page Manager.
09401 GRP BSI CHECK Failure (GRP BSI): <group page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09402 GRP BFL CHECK Failure (GRP BFL): <group page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09403 GRP BAP CHECK Failure (GRP BAP): <group page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09404 GRP BGP CHECK Failure (GRP BGP): <group page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09405 GRP BPP CHECK Failure (GRP BPP): <group page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09406 GRP PNA CHECK Failure (GRP PNA): <group page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09407 GRP BPT bad page type in allocation page

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09408 GRP CFP cycling free page list

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
are generated by the SQLBase System Free Space Manager.
09501 SFS BSI CHECK Failure (SFS BSI): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09502 SFS BNP CHECK Failure (SFS BNP): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09503 SFS BPT CHECK Failure (SFS BPT): <system free list corrupt>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
SQLBase index related errors.
09601 IDX BPT CHECK Failure (IDX BPT): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09602 IDX BFV CHECK Failure (IDX BFU): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09603 IDX BLV CHECK Failure (IDX BLV): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09604 IDX BMK CHECK Failure (IDX BMK): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09605 IDX BKL CHECK Failure (IDX BKL): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09606 IDX BEO CHECK Failure (IDX BEO): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09607 IDX DKU CHECK Failure (IDX DKU): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09608 IDX SDT CHECK Failure (IDX SDT): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09609 IDX KIF CHECK Failure (IDX KIF): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09610 IDX WNE CHECK Failure (IDX WNE): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09611 IDX LNS CHECK Failure (IDX LNS): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09612 IDX BOA CHECK Failure (IDX BOA): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09613 IDX NLC CHECK Failure (IDX NLC): <index page corrupted>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09614 IDX IRF Database or object in the database is corrupt (IDX IRF)

      Reason: The database or an object in the database has been discovered
	      to be inconsistent or lacking integrity.

      Remedy: Run a CHECK DATABASE command.

09615 IDX IDF Database or object in the database is corrupt (IDX IDF)

      Reason: The database or an object in the database has been discovered
	      to be inconsistent or lacking integrity.

      Remedy: Run a CHECK DATABASE command.

09616 IDX RTY Please retry

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

09617 IDX BKR CHECK Failure (IDX BKR): <index page corrupted>

      Reason: CHECK DATABASE has discovered a bad key range in a index page.
	      This error is reported when the child index page key range
	      violates the key range dictated by the parent index entry.


      Remedy: The index is damaged, and should be dropped and recreated.
	      Or, try unloading and reloading the database, or restoring a
	      backup copy of the database.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
are generated by the SQLBase CHECK command.
09701 CHK BAS CHECK Failure (CHK BAS): <page has bad allocation status>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

09702 CHK LOP CHECK Failure (CHK LOP): <page has been lost>

      Reason: CHECK DATABASE has discovered a problem in the database.

      Remedy: If the CHECK DATABASE displays a message saying that a database
	      object is damaged, drop that object.  Otherwise, try unloading
	      and reloading the database or restore from a backup copy of the
	      database.  You might also try unloading table by table to save
	      as much of the database as possible.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
parsing errors.  These errors generally occur during the compile of a SQL
statement and the statement violates the syntax for that SQL command.
09801 PRS TMT Too many tables to join

      Reason: The number of tables attempting to be joined exceeds the SQLBase
	      limit of 20 tables.

      Remedy: Modify SQL statement.

09802 PRS IST Invalid statistics type

      Reason: Attempting to UPDATE STATISTICS and a keyword of INDEX, TABLE,
	      or DATABASE is expecting immediately after UPDATE STATISTICS and
	      it is missing or misspelled.

      Remedy: Correct the UPDATE STATISTICS command by properly specifying the
	      keyword of INDEX, TABLE, or DATABASE immediately after UPDATE
	      STATISTICS.

09803 PRS ICO Invalid object to CHECK

      Reason: Attempting a CHECK command and the keyword immediately following
	      the keyword CHECK is either missing or misspelled and should be
	      either DATABASE, INDEX, or TABLE.

      Remedy: Correct the CHECK command by properly specifying the keyword
	      DATABASE, INDEX, or TABLE immediately after the keyword CHECK.

09804 PRS MEK Missing EXISTS keyword

      Reason: Attempting a SQL UPDATE statement and the CHECK EXISTS clause is
	      being used but the kewyord EXISTS is either missing or
	      misspelled.

      Remedy: Correct the UPDATE statement by properly specifying the keyword
	      EXISTS immediately after the keyword CHECK.

09805 PRS CNH Only CLUSTERED HASHED indexes supported

      Reason: Attempting a CREATE INDEX statement and the keyword CLUSTERED
	      has been found but the keyword HASHED is either missing or
	      misspelled.

      Remedy: Correct the CREATE INDEX statement by properly specifying the
	      keyword HASHED immediately after the keyword CLUSTERED.  SQLBase
	      currently only supports CLUSTERED HASHED indexes and does not
	      support CLUSTERED indexes or HASHED indexes.

09806 PRS MUK Missing DEFAULT keyword

      Reason: Trying a CREATE TABLE or ALTER TABLE statement and a column is
	      attempting to be defined with possibly the NOT NULL WITH DEFAULT
	      clause but the keyword DEFAULT is either missing or misspelled.

      Remedy: Correct the CREATE TABLE or ALTER TABLE statement by properly
	      specifying the keyword DEFAULT immediately after the keywords
	      NOT NULL WITH.

09807 PRS MDB Missing database name

      Reason: Attempting a CREATE TABLE statement and the IN DATABASE clause
	      is being used but the database name is missing.

      Remedy: Correct the CREATE TABLE statement by properly specifying a
	      valid database name immediately after the IN DATABASE keywords.

09808 PRS MTS Missing tablespace name

      Reason: Attempting a CREATE TABLE statement and the IN clause is being
	      used but the tablespace name is missing.

      Remedy: Correct the CREATE TABLE statement by properly specifying a
	      valid tablespace name immediately after the keyword IN.

09809 PRS FUU FOR UPDATE OF not allowed with UNION

      Reason: The SELECT statement contains a FOR UPDATE OF clause within a
	      UNION.  A UNION cannot be specified for a SELECT statement that
	      is to be used for update.

      Remedy: Correct the SQL statement.  A SELECT statement that is to be
	      used for update cannot be defined with a UNION.

09810 PRS FUO FOR UPDATE OF not allowed with ORDER BY

      Reason: The SELECT statement contains both a FOR UPDATE OF clause and an
	      ORDER BY clause.	An ORDER BY clause cannot be specified for a
	      SELECT statement that is to be used for update.

      Remedy: Correct the SQL SELECT statement.  The implied function is not
	      supported by DB2 or SQLBase.  A SELECT statement that is to be
	      used for update cannot be defined to fetch the rows of the
	      object table in a specific order.

09811 PRS FUP Invalid FOR UPDATE OF clause

      Reason: Attempting a SELECT statement with possibly the FOR UPDATE OF
	      clause but the keywords UPDATE or OF are either missing or
	      misspelled.

      Remedy: Correct the SELECT statement by properly specifying the FOR
	      UPDATE OF clause.

09812 PRS SFU SELECT FOR UPDATE must reference a single table

      Reason: The SELECT statement contains a FOR UPDATE OF clause and
	      references more than one table.  Multiple tables cannot be
	      specified for a SELECT statement that is to be used for update.

      Remedy: Correct the SQL SELECT statement.  A SELECT statement that is to
	      be used for update cannot be defined to fetch rows from multiple
	      tables.

09813 PRS UNA UNION ALL required for all SELECT statements

      Reason: UNION ALL indicates that all duplicate rows will not be
	      eliminated.  If UNION ALL is used on one SELECT statement it
	      must be repeated for every SELECT statement in the entire
	      statement.

      Remedy: Correct the SELECT statement by properly specifying UNION ALL
	      for all select statements.

09814 PRS RCT Result column name can only be specified with top select statement

      Reason: The result column name can only be specified with the top SELECT
	      statement.

      Remedy: Correct the SQL SELECT statement.

09815 PRS RCI Result column name must be identifier

      Reason: The result column name must be an identifier.

      Remedy: Correct the SQL SELECT statement.

09816 PRS ETC Expression is too big

      Reason: A specified expression is too large.

      Remedy: Modify the SQL statement.

09817 PRS MKY Missing KEY keyword

      Reason: Attempting to use either the PRIMARY KEY or FOREIGN KEY clauses
	      and the keyword KEY is either missing or misspelled.

      Remedy: Correct the PRIMARY KEY or FOREIGN KEY clauses by properly
	      specifying the keyword KEY.

09818 PRS IPC Invalid primary key column name

      Reason: The primary key column name is an invalid identifier.

      Remedy: Correct the SQL statement by properly specifying a valid primary
	      key column name identifier.

09819 PRS CPK Column already defined for primary key

      Reason: The specified column is already defined for a primary key.

      Remedy: Correct the SQL statement by properly specifying each column
	      of a primary key only once.

09820 PRS CNN Primary key column must be NOT NULL or NOT NULL WITH DEFAULT

      Reason: A primary key column has not been defined as NOT NULL or NOT
	      NULL WITH DEFAULT.  Each column in the primary key must be
	      defined as either NOT NULL or NOT NULL WITH DEFAULT.

      Remedy: Define all columns of the primary as either NOT NULL or NOT NULL
	      WITH DEFAULT.

09821 PRS PCN Primary key column not defined

      Reason: A primary key column is not defined or misspelled.

      Remedy: Correct the primary key column specification my properly stating
	      valid columns.

09822 PRS IFK Invalid foreign key name

      Reason: An invalid foreign key name has been specified.

      Remedy: Correct the SQL statement by properly specifying a valid foreign
	      key.

09823 PRS IFC Invalid foreign key column name

      Reason: An invalid foreign key column name has been specified.

      Remedy: Correct the SQL statement by properly specifying a valid foreign
	      key column name.

09824 PRS FKA Foreign key <name> already defined

      Reason: The specified foreign key name is already defined.

      Remedy: Correct the SQL statement by properly specifying a unique
	      foreign key name.

09825 PRS CFK Column already defined for foreign key

      Reason: The specified column is already defined for a foreign key.

      Remedy: Correct the SQL statement by properly specifying each column
	      of a foreign key only once.

09826 PRS FCN Foreign key column not defined

      Reason: A foreign key column is not defined or misspelled.

      Remedy: Correct the foreign key column by properly stating valid
	      columns.

09827 PRS MRK Missing REFERENCE keyword

      Reason: A foreign key clause has a missing or misspelled REFERENCE
	      keyword.

      Remedy: Correct the foreign key clause by properly specifying the
	      REFERENCE keyword.

09828 PRS IRN Invalid reference table name

      Reason: A foreign key clause has referenced an invalid table name.

      Remedy: Correct the foreign key clause by properly specifying a
	      reference to a valid table name.

09829 PRS MFR Missing FOREIGN keyword

      Reason: Attempting to ALTER a table and add a foreign key but the
	      keyword FOREIGN is missing or misspelled.

      Remedy: Correct the ALTER TABLE statement by properly specifying
	      the FOREIGN keyword.

09830 PRS ACN At least one column in the foreign key needs to allow NULL value

      Reason: A FOREIGN KEY definition with the SET NULL option has not
	      specified at least one column in the foreign key where NULL
	      values are allowed.

      Remedy: The ON DELETE SET NULL foreign key delete rule states that when
	      a parent row is deleted, the foreign key values in all of its
	      dependent rows should automatically be set to NULL.  Specify at
	      least one column in the foreign key that allows NULL values for
	      the ON DELETE SET NULL foreign key delete rule to be specified.
	      Or, change the foreign key delete rule.

09831 PRS SRC Self-reference foreign key must have CASCADE delete rule

      Reason: A self-referencing foreign key must be specified with the
	      CASCADE delete rule.

      Remedy: Change the foreign key delete rule in the FOREIGN KEY clause.

09832 PRS FDN Foreign key column data type not matching primary key column

      Reason: Each column definition of a foreign key does not match each
	      column definition of the corresponding column in the primary key
	      of the parent table.

      Remedy: Correct the definition of the foreign key or primary so that the
	      each colum definition of the foreign key matches each column
	      definition of the corresponding column in the primary key of the
	      parent table.

09833 PRS FNC Foreign key number of columns not matching primary key

      Reason: The number of columns of a foreign key does not match the number
	      of columns in the primary key of the parent table.

      Remedy: Correct the definition of the foreign key or primary so that the
	      number of columns in the foriegn key is equal to the number
	      columns in the primary key of the parent table and the data
	      types of each corresponding column match.

09834 PRS SDN Distinct paths must have same delete rules and cannot be SET NULL

      Reason: The delete rules cannot be different or cannot be SET NULL.
	      This error is used to report that the delete rules specified in
	      two FOREIGN KEY clauses of the CREATE TABLE statement are
	      invalid because the table would be delete-connected to the same
	      table through multiple paths involving relationships with
	      different delete rules or with delete rules of SET NULL.

      Remedy: Change the delete rule.

09835 PRS IDR Invalid delete rule

      Reason: An invalid, missing, or misspelled delete rule has been
	      specified in a foreign key clause.

      Remedy: Correct the foreign key clause by properly specifying a valid
	      delete rule of RESTRICT, CASCADE, or SET NULL.

09836 PRS TKF Too many concatenated key fields

      Reason: Attempting a CREATE INDEX, or definition of a PRIMARY or FOREIGN
	      key and the number of key fields exceeds or matches the maximum
	      allowed of 16 columns.

      Remedy: Modify key so that the number of columns to be less than 16.

09837 PRS MDL Missing DELETE keyword

      Reason: Attempting to define a foreign key with the ON DELETE clause but
	      the keyword DELETE is either missing or misspelled.

      Remedy: Correct the foreign key definition ON DELETE clause by properly
	      specifying the DELETE keyword.

09838 PRS PND Parent table not defined yet

      Reason: Defining a foreign key and the specified parent table does not
	      exist.

      Remedy: Create the parent table before defining the foreign key.

09839 PRS PTI Parent table in incomplete state

      Reason: Defining a foreign key and specified parent table is still in an
	      incomplete state.  A parent table is considered incomplete until
	      you generate its unique index.

      Remedy: Create the parent table's unique index and before attempting to
	      create any foreign keys.

09840 PRS PKA Primary key already specified

      Reason: Attempting to define a second primary key for a table.

      Remedy: None.  A table can only have one primary key.

09841 PRS PKN Primary key not defined in parent table

      Reason: Attempting to define a foreign key and the primary key of the
	      parent table is not defined.

      Remedy: Define the primary key for the parent table before attempting to
	      create a foreign key.

09842 PRS EMP Exceed maximum primary key length

      Reason: The specified primary key exceed the maximum length (254)
	      allowed for a primary key.

      Remedy: Modify the primary key so that it does not exceed the maximum
	      allowable length of 254.

09843 PRS ATS Use ALTER TABLE to create self-referencing foreign key

      Reason: A self-referencing foreign key can only be created with the
	      ALTER TABLE statement.

      Remedy: Use the ALTER TABLE statement to create a self-referencing
	      foreign key.

09844 PRS TDS Add foreign key causes table delete-connected to itself

      Reason: Any table that is involved in a delete operation is
	      delete-connected.  If a referential cycle involves more than one
	      table, any table in the cycle must not be delete-connected to
	      itself.  This restriction guarantees that the CASCADE rule will
	      not cause widespread deletion of data.

      Remedy: None.  A foreign key cannot be specified that causes a table to
	      delete-connected to itself.

09845 PRS SFD Same column list in different foreign keys cannot have same parent

      Reason: The foreign key is not a unique foreign key reference.  The
	      specified foreign key has the same columns as an existing
	      foreign key for the same table.

      Remedy: Modify the foreign key table.  If two foreign keys have the same
	      columns, they must reference different tables.

09846 PRS FRS Foreign key cannot reference system table

      Reason: Attempting to define a foreign key that references a system
	      catalog table.

      Remedy: None.  Foreign keys cannot reference a system catalog table.

09847 PRS ICR Invalid cursor name

      Reason: Attempting a SQL INSERT statement with the ADJUSTING clause
	      and the specified cursor name is invalid.

      Remedy: Correct the SQL INSERT statement by providing a valid cursor
	      name in the ADJUSTING clause of a cursor that has been properly
	      named or opened.

09848 PRS OOL Number of operands over system limitation

      Reason: Maximum number of operands in a function exceeds the SQLBase
	      system limit of 256.

      Remedy: Modify the SQL statement so that the SQLBase system limit of 256
	      operands is not exceeded.

09849 PRS ISV Invalid server command

      Reason: Most likely attempting an INSTALL DATABASE or DEINSTALL DATABASE
	      command and the keyword DATABASE is either missing or
	      misspelled.

      Remedy: Correct the INSTALL or DEINSTALL command by properly specifying
	      a valid DATABASE keyword immediately after the INSTALL or
	      DEINSTALL keyword.

09850 PRS IDN Invalid database name

      Reason: Attempting an ALTER DATABASE, CREATE DATABASE, INSTALL DATABASE,
	      or DEINSTALL DATABASE and the specified database name is
	      invalid.

      Remedy: Correct the SQL statement by specifying a valid database name.

09851 PRS IAR Invalid dbarea name <name>

      Reason: Attempting an ALTER DBAREA, ALTER STOGROUP, CREATE DBAREA,
	      CREATE STOGROUP, or DELETE DBAREA and the specified dbarea name
	      is invalid.

      Remedy: Correct the SQL statement by specifying a valid dbarea name.

09852 PRS IAF Invalid dbarea file name

      Reason: Attempting an ALTER STOGROUP, CREATE DBAREA, or CREATE STOGROUP
	      and the specified dbarea file name is not valid.

      Remedy: Correct the SQL statement by specifying a valid file name.

09853 PRS MZK Missing SIZE keyword

      Reason: Attempting an ALTER DBAREA or CREATE DBAREA and the expected
	      SIZE keyword is either missing or misspelled.

      Remedy: Correct the SQL statement by properly specifying the SIZE
	      keyword.

09854 PRS ISG Invalid stogroup name <name>

      Reason: Attempting an ATLER DATABASE, ALTER STOGROUP, CREATE DATABASE,
	      CREATE STOGROUP, DELETE STOGROUP, or SET DEFAULT STOGROUP and
	      the storage group name is invalid.

      Remedy: Correct the SQL statement by properly specifying a valid storage
	      group name.

09855 PRS USK Missing USING keyword

      Reason: Attempting a CREATE STOGROUP statement and the mandatory USING
	      keyword is either missing or misspelled.

      Remedy: Correct the CREATE STOGROUP statement by properly specifying the
	      USING keyword.  The correct syntax
	      is: CREATE STOGROUP stogroup-name USING dbarea1, dbarea2, ...

09856 PRS ISK Invalid SET type.

      Reason: Attempting a SET command with an incorrect set type.

      Remedy: Correct the SET command by properly specifying the SET type.

09857 PRS SGK Missing STOGROUP Keyword

      Reason: Attempting a SET DEFAULT STOGROUP statement and the mandatory
	      keyword STOGROUP is either missing or misspelled.

      Remedy: Correct the SET DEFAULT STOGROUP statement by properly
	      specifying the mandatory keyword STOGROUP.  The correct syntax
	      is: SET DEFAULT STOGROUP [stogroup-name]
	      where the stogroup-name is optional.

09858 PRS ASO Invalid ALTER STOGROUP option

      Reason: Attempting a ALTER STOGROUP statement and the keyword ADD
	      or DROP has not been found.

      Remedy: Correct the ALTER STOGROUP statement by properly specifying
	      either ADD dbarea or DROP dbarea.  The correct syntax
	      is: ALTER STOGROUP stogroup-name ADD dbarea
	      or: ALTER STOGROUP stogroup-name DROP dbarea

09859 PRS ADO Invalid ALTER DATABASE option

      Reason: Attempting a ALTER DATABASE statement and the keyword STOGROUP
	      or LOG has not been found.

      Remedy: Correct the ALTER DATABASE statement by properly specifying
	      either STOGROUP stogroup-name or LOG stogroup-name.  The correct
	      syntax is: ALTER DATABASE database-name STOGROUP stogroup-name
	      or:	 ALTER DATABASE database-name LOG stogroup-name

09860 PRS IDE Invalid DELETE command

      Reason: Attempting a DELETE and the delete object keyword is invalid.

      Remedy: Correct the DELETE statement by properly specifying a valid
	      delete object keyword to be deleted.

09861 PRS ABO System exit from abort command

      Reason: An ABORT command has forced a system exit.

      Remedy: None.  Informational only.

09862 PRS NDQ DBAREA filename should not be specified in double quotes

      Reason: The DBAREA file name must be specified in double quotes.

      Remedy: Correct the SQL statement by properly specifying the DBAREA
	      file name in double quotes.

09863 PRS ASL DBAREA size too large

      Reason: Attempting a CREATE DBAREA or ALTER DBAREA and the specified
	      size in megabytes that exceeds the maximum allowable size of
	      2048 megabytes.

      Remedy: Correct the CREATE DBAREA or ALTER DBAREA statement to properly
	      specify a valid size in megabytes not greater than 2048.

09864 PRS UMI User error number must be greater than 0 and less than 32767

      Reason: Attempting an ALTER TABLE statement to add or modify a user
	      defined error and the specified user error number is not a valid
	      positive integer value greater than 0 and less than 32,767.

      Remedy: Correct the ALTER TABLE statement by properly specifying a valid
	      positive integer value when adding or modifying a user defined
	      error greater than 0 and less than 32,767.

09865 PRS IUC Invalid user error class

      Reason: Attempting an ALTER TABLE statement to add, drop, or modify a
	      user defined error and the specified user error class is not a
	      valid quoted string indicating that the error class is either
	      'DELETE_PARENT', 'UPDATE_PARENT', 'INSERT_DEPENDENT', or
	      'UPDATE_DEPENDENT'.

      Remedy: Correct the ALTER TABLE statement by properly specifying a valid
	      quoted string indicating a user define error class of either
	      'DELETE_PARENT', 'UPDATE_PARENT', 'INSERT_DEPENDENT', or
	      'UPDATE_DEPENDENT'.

09866 PRS MFN Missing foreign key name

      Reason: Attempting an ALTER TABLE statement to add, drop, or modify a
	      user defined error and the foreign key name in the FOREIGN KEY
	      clause is missing or misspelled.

      Remedy: Correct the ALTER TABLE statement by properly specifying a valid
	      foreign key name in the FOREIGN KEY clause.

09867 PRS MPF Missing FOREIGN or PRIMARY keyword

      Reason: Attempting an ALTER TABLE statement to add, drop, or modify a
	      user defined error and the keyword PRIMARY or FOREIGN is missing
	      or misspelled in the PRIMARY KEY or FOREIGN KEY clause.

      Remedy: Correct the ALTER TABLE statement by properly specifying the
	      keyword PRIMARY or FOREIGN in either the PRIMARY KEY or FOREIGN
	      key clauses.

09868 PRS EFN Foreign key name cannot exceed 18 characters

      Reason: Attempting to use a foreign key with a name greater than 18
	      characters.

      Remedy: Correct the SQL statement by properly specifying a valid foreign
	      key name that does not exceed 18 characters.

09869 PRS COU No check option allowed with UNION

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09870 PRS VCR View column names required with UNION

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09871 PRS CNS Command no longer suppered

      Reason: The specified command is no longer supported.

      Remedy: Use other command.

09872 PRS TMB Too many booleans in query

      Reason: Not enough memory at the database engine to perform the
	      query parsing.

      Remedy: Reduce the number of boolean expressions in the query,
	      especially the size of any IN list.

09873 PRS MEX Missing Expression before [NOT] IN predicate

      Reason: An expression should precede the IN (NOT IN) predicate.

      Remedy: Correct the SQL statement. The In predicate has the general
	      syntax of :
		      expression [NOT] IN ....

09874 PRS ITI Invalid global transaction id

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09875 PRS MPT Missing PARTICIPANT keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09876 PRS MEN Missing END keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09877 PRS DBK Missing DATABASE keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09878 PRS MCO Missing COMMA keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09879 PRS PTS Missing PARTICIPANTS keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09880 PRS BPT Bad protocol name

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09881 PRS SLK Missing SLASH keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09882 PRS IPN Invalid number of participants

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09883 PRS TMU Too many participants specified

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09884 PRS NEU Not enough participants specified

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09885 PRS OOM Out of memory

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09886 PRS BOS Bad option specified

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09887 PRS FMB Failure ID must be a positive number non-zero number.

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09888 PRS EWT Expecting keyword WITH

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09889 PRS IET Invalid failure error type

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09890 PRS CDN Event code  must be a positive non-zero number

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09891 PRS MIN Missing IN keyword

      Reason: The IN keyword is missing or misspelled.

      Remedy: Correct the SQL statement.

09892 PRS BES Bad error scope specified.

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09893 PRS BEV Bad error event specified.

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09894 PRS MCT Missing COUNT keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09895 PRS ECP EVERY <n-times> must be a positive non-zero number

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09896 PRS MCS Missing CSV keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09897 PRS IDS Invalid DB specification

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09898 PRS MBA Missing ON, BEFORE or AFTER keyword.

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09899 PRS MAL Missing ALL keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09900 PRS MTR Missing TRANSACTIONS keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09901 PRS MFE Missing FORCE keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09902 PRS ISS Invalid SET command

      Reason: Invalid server SET command.

      Remedy: Correct the statement to the SET DEFAULT STOGROUP statement

09903 PRS MOT More than one source table specified in the unload/load command

      Reason: More than one source table is specified in the unload/load
	      command when the unload/load format is ASCII or DIF.

      Remedy: Only one source table can be unloaded at a time in ASCII or
	      DIF format. Remove the extra tables from the command. These
	      tables can be unloaded by calling unload command repeatedly,
	      with one table at a time.

09904 PRS NTB No table should be specified, if the load format is SQL

      Reason: If the load format is SQL, no table names should be specified.

      Remedy: Remove the table name from the command.

09905 PRS IFT Invalid load/unload format

      Reason: Load/Unload format should be one of SQL/ASCII/DIF format.

      Remedy: Specify the correct format.

09906 PRS NTU No table name(s) specified in unload

      Reason: If unload format is defined as one of SQL/ASCII/DIF format and
	      ALL tables are not being unloaded, specific table names should
	      be provided in the unload command

      Remedy: Give specific table name(s) to unload.

09907 PRS ICP Invalid compress option.

      Reason: If unload format is defined as one of ASCII/DIF format,
	      Compress option can not be specified. COMPRESS option is valid
	      only  when the unload format is SQL.

      Remedy: Remove the compress option.

09908 PRS MIA Missing AT keyword

      Reason: The AT keyword is missing from a LOAD command START clause

      Remedy: Correct SQL statement. LOAD command start clause is
	      " LOAD ... START AT lineno"


09909 PRS MLN Missing LINE number

      Reason: The line number is missing from a LOAD command START clause

      Remedy: Correct SQL statement. LOAD command start clause is
	      " LOAD ... START AT lineno"

09910 PRS MDT Missing destination table name

      Reason: Attempting a LOAD ASCII and specifying a source file name but
	      the destination table name is not specified.

      Remedy: Modify the LOAD ASCII command.  Destination table names are
	      required when loading in ASCII format.

09911 PRS DVN Duplicate variable name

      Reason: Duplicate variable name is found

      Remedy: Check and change duplicated variable name.

09912 PRS IVE INTO variable already exists

      Reason: Duplicate INTO variable name is found

      Remedy: Check and change duplicated INTO variable name.

09913 PRS MLD Missing line delimiter

      Reason: Missing line delimeter

      Remedy: Add a line delimeter after the line

09914 PRS DPS Duplicate PARAMETERS section

      Reason: Duplicate PARAMETERS section

      Remedy: Check and remove duplicated PARAMETERS section

09915 PRS NPS PARAMETERS section not allowed here

      Reason: PARAMETERS section not allowed here

      Remedy: Check and change the location of PARAMETERS section

09916 PRS DLS Duplicate LOCAL section

      Reason: Duplicate LOCAL section

      Remedy: Check and remove duplicated LOCAL section

09917 PRS NLS LOCAL section not allowed here

      Reason: LOCAL section not allowed here

      Remedy: Check and change the location of LOCAL section

09918 PRS IPI Invalid indentation in PARAMETERS section

      Reason: Invalid indentation in PARAMETERS section

      Remedy: Check and change the indent in PARAMETERS section

09919 PRS DAS Duplicate ACTIONS section

      Reason: Duplicate ACTIONS section

      Remedy: Check and remove duplicated ACTIONS section

09920 PRS ILI Invalid indentation in LOCAL section

      Reason: Invalid indentation in LOCAL section

      Remedy: Check and change the indent in LOCAL section

09921 PRS IAI Invalid indentation in ACTIONS section

      Reason: Invalid indentation in ACTIONS section

      Remedy: Check and change the indent in ACTIONS section

09922 PRS UPC Unknown procedure command

      Reason: Unknown procedure command

      Remedy: Check and change the command in the procedure

09923 PRS BMF BEGIN must be the first one

      Reason: BEGIN must be the first one in a command block

      Remedy: Check and move the BEGIN to the beginning of the command block

09924 PRS TMG Too many BEGINs

      Reason: Too many BEGINs in a command block

      Remedy: Check and remove the unnecessary BEGINs

09925 PRS TME Too many ENDs

      Reason: Too many ENDs in the command block

      Remedy: Check and remove the unnecessary ENDS

09926 PRS NAG No aggregate function

      Reason: Aggregate function is not allowed

      Remedy: Check and change the aggregate function.

09927 PRS ILN Invalid LOOP name

      Reason: Invalid LOOP name is found

      Remedy: Check and change the LOOP name.

09928 PRS BVN Bad variable name

      Reason: Invalid variable name is found

      Remedy: Check and change variable name.

09929 PRS MCL Must be a variable

      Reason: The INTO clause must have variables

      Remedy: Check and change to variable names.

09930 PRS MHP Must have PROCEDURE keyword

      Reason: Missing procedure keyword

      Remedy: Check and add procedure keyword after ON.

09931 PRS UPS Unknown procedure state

      Reason: An unknown procedure state is found

      Remedy: Check and change procedure state keyword after ON PROCEDURE.

09932 PRS CFF Cannot find function handler

      Reason: Cannot find function handler

      Remedy: This is an internal error

09933 PRS MVR Missing VARIABLES keyword

      Reason: Missing VARIABLES keyword

      Remedy: Check and add VARIABLE keyword

09934 PRS BPN Invalid procedure name

      Reason: Invalid procedure name

      Remedy: Check and change the procedure name

09935 PRS MNM Missing NAME keyword

      Reason: Missing NAME keyword

      Remedy: Check and add NAME keyword after PROCEDURE

09936 PRS UVN Undefined variable name

      Reason: The variable name being referenced is not defined

      Remedy: Check and add variable name to appropriate section

09937 PRS BMP BEGIN keyword must be used before END

      Reason: END is encountered before BEGIN

      Remedy: Check and add BEGIN keyword to the beginning of the block

09938 PRS IPS Procedure section (name) expected

      Reason: Expecting a new procedure section name here.

      Remedy: It is possible that the indent level has changed from that
	      of the last statement. Check that the indentation is correct.

09939 PRS MIF Missing IF keyword

      Reason: ELSE is used without an IF keyword

      Remedy: Check and add IF keyword to appropriate place

09940 PRS IOU Invalid ON usage

      Reason: ON keyword can be used on the first level in ACTIONS section

      Remedy: Check and move ON command to appropriate place of first level

09941 PRS DLN Duplicate loop name

      Reason: Loop name has been defined

      Remedy: Check and change the loop name

09942 PRS ULN Unknown loop name

      Reason: Loop name is not defined

      Remedy: Check and change to correct loop name

09943 PRS BBC Bad boolean constant

      Reason: The constant is not a boolean constant

      Remedy: Check and use correct boolean constant

09944 PRS ICI Invalid command indentation

      Reason: Invalid command indentation

      Remedy: Check and change the indentof the command

09945 PRS ECB Unused

      Reason:

      Remedy:

09946 PRS VTT STATIC procedure must be stored first

      Reason: A static procedure must be stored before execution.

      Remedy: Store the procedure or change it to DYNAMIC.

09947 PRS MSQ Missing SQLERROR keyword

      Reason: Missing SQLERROR keyword

      Remedy: Check the command and re-enter agian.

09948 PRS HIH Declare error handler indide an error handler

      Reason: Declare an error handler indide an error handler

      Remedy: Check the command and make sure that error handler is not
	      declared inside an error handler.

09949 PRS NRK No RECEIVE keyword here

      Reason: Illegal use of RECEIVE keyword out side of PARAMETERS section

      Remedy: Check the command and make sure that RECEIVE keyword is used
	      only in PARAMETERS section.

09950 PRS NSH No SQL HANDLE in PARAMETERS section

      Reason: Illegal use of SQL HANDLE in PARAMETERS section

      Remedy: Check the command and make sure that SQL HANDLE keyword is only
	      used in LOCAL VARIABLES section.

09951 PRS MDS Missing keyword DYNAMIC or STATIC after IS

      Reason: Keyword DYNAMIC or STATIC must be supplied after IS.

      Remedy: Supply DYNAMIC or STATIC or remove IS after procedure name.

09952 PRS DVC Duplicate values correlation name detected

      Reason: OLD and NEW values correlation names must be distinct.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09953 PRS IVT Event name expected

      Reason: The event name specified in a CREATE EVENT or DROP EVENT
	      statement is invalid.

      Remedy: Correct the SQL statement.  An event name can be a qualified
	      or unqualified long identifier.  The qualified form is a
	      user id followed by a period and a long identifier.  An
	      unqualified handler name in a SQL statement is implicitly
	      qualified by the id of the user who issues the statement.

09954 PRS ITG Trigger name expected

      Reason: The trigger name specified in CREATE TRIGGER or DROP TRIGGER
	      statement is invalid.

      Remedy: Correct the SQL statement.  An event name can be a qualified
	      or unqualified long identifier.  The qualified form is a
	      user id followed by a period and a long identifier.  An
	      unqualified handler name in a SQL statement is implicitly
	      qualified by the id of the user who issues the statement.

09955 PRS IVP Procedure name expected

      Reason: The procedure name specified in an EXECUTE clause is invalid.

      Remedy: Correct the EXECUTE clause.  A procedure name can be a
	      qualified or unqualified long identifier.  The qualified form
	      is a user id followed by a period and a long identifier.	An
	      unqualified handler name in a SQL statement is implicitly
	      qualified by the id of the user who issues the statement.

09956 PRS MXK Missing EXECUTE keyword

      Reason: EXECUTE clause must be supplied in statement.

      Remedy: Correct the SQL statement. See the SQL Language Reference Manual
	      for syntax information of CREATE TRIGGER or CREATE EVENT.

09957 PRS MIV Number of input values does not match number required by
	      procedure.

      Reason: The number of values specified in the EXECUTE procedure clause
	      does not match the number of parameters expected by the
	      procedure.

      Remedy: Correct the EXECUTE clause to provide the expected number of
	      values.

09958 PRS VPP Invalid identifier provided as procedure parameter or part of
	      such a parameter

      Reason: Procedure parameters must be composed of constants.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE EVENT.

09959 PRS MRA Missing RAISE keyword

      Reason: CREATE EVENT statement must supply the keyword RAISE.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE EVENT.

09960 PRS MVY Missing EVERY keyword

      Reason: CREATE EVENT statement must supply the keyword AT.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE EVENT.

09961 PRS NBA Need BEFORE or AFTER keyword

      Reason: CREATE TRIGGER statement must supply either keyword.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09962 PRS MVA Missing event action

      Reason: CREATE TRIGGER statement must specify DELETE, INSERT or UPDATE.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09963 PRS IVV Invalid values correlation name

      Reason: The name is invalid.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09964 PRS MNO Missing OLD or NEW keyword

      Reason: CREATE TRIGGER statement must supply either keyword.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09965 PRS RED Redundant OLD or NEW keyword

      Reason: Only one occurrence of either keyword is allowed in a CREATE
	      TRIGGER statement.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09966 PRS MEA Missing EACH keyword

      Reason: CREATE TRIGGER statement must supply EACH (ROW or STATEMENT)
	      after FOR.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09967 PRS MRS Missing ROW or STATEMENT keyword

      Reason: CREATE TRIGGER statement must supply either keyword.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09968 PRS IRF Invalid REFERENCING keyword

      Reason: REFERENCING is valid only if the trigger action is UPDATE.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09969 PRS BXN Prefixing table name does not match the subject table.

      Reason: The syntax allows only the subject table name.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09970 PRS BCN Table name does not match OLD or NEW values correlation name

      Reason: Table name prefixing a column name in a parameter list must
	      be a values correlation name.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09971 PRS IVI Invalid identifier

      Reason: Identifier is not recognized or allowed.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information of CREATE TRIGGER or CREATE EVENT.

09972 PRS IAG Invalid aggregate

      Reason: AGGREGATE is not allowed.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information of CREATE TRIGGER or CREATE EVENT.

09973 PRS IFU Invalid function

      Reason: Function is not allowed.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information of CREATE TRIGGER or CREATE EVENT.

09974 PRS MPB Missing PROCEDURE keyword

      Reason: Either the keyword is missing or the inline procedure is not
	      specified.

      Remedy: Correct SQL statement to supply inline procedure specification.
	      See the SQL Language Reference Manual for syntax information
	      on CREATE TRIGGER.

09975 PRS ICV Column value not allowed as procedure parameter

      Reason: Column values have no meaning for a STATEMENT trigger.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE TRIGGER.

09976 PRS NNE Not enough END keyword

      Reason: Keyword END must be used in pair with BEGIN and not enough
	      ENDs are seen

      Remedy: Supply the missing ENDs and retry again.

09977 PRS MTP Missing terminating right parenthesis after inline procedure

      Reason: An INLINE procedure must be terminated by a right parenthesis.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information.

09978 PRS VVN Invalid interval specification

      Reason: An interval must be no less than 1.0 minute to be meaningful.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE EVENT.

09979 PRS VPM Invalid identifier for procedure parameter

      Reason: User-defined identifier cannot be used as procedure parameter.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE EVENT.

09980 PRS VRI Invalid row id for procedure parameter

      Reason: Row id cannot be used as procedure parameter.

      Remedy: Correct SQL statement.  See the SQL Language Reference Manual
	      for syntax information on CREATE EVENT or TRIGGER.

09981 PRS MTX Missing TRANSACTION keyword

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

09982 PRS IEP Invalid grant execute privilege options

      Reason: User specifies invalid options when granting execute privilege

      Remedy: Correct the statement.  Make sure only creator or grantee is
	      specified and try again.

09983 PRS MPS Missing PRIVILEGES keyword

      Reason: PRIVILEGES keyword is expected and the keyword is missing.

      Remedy: Correct syntax and try again.

09984 PRS ITC Invalid audit category

      Reason: Trying to start an audit and the specified category type is not
	      valid for the specified audit type.

      Remedy: Correct the SQL statement.  Specify valid categories for the
	      specified audit type.

09985 PRS SSC Administrative server connection required

      Reason: Attempting to perform a database administrative function
	      and a database server connection has not been established.

      Remedy: Establish a connection to a remote database server before
	      attempting any database administrative function.	See the
	      SQLTalk command SET SERVER or the API function call sqlcsv().

09986 PRS SAS Invalid START AUDIT SIZE value

      Reason: Attempting to perform a START AUDIT operation and the specified
	      SIZE value is invalid.

      Remedy: Correct the SIZE value.  This numeric value should be specified
	      in kilobytes.

09987 PRS IAP Invalid APPEND file number

      Reason: Attempting to perform a START AUDIT operation and the specified
	      APPEND file number is invalid.

      Remedy: Correct the APPEND file number.  Valid file number can be from
	      zero to 999.

09988 PRS IKV Invalid KEEP value

      Reason: Attempting to perform a START AUDIT operation and the specified
	      KEEP file number value is invalid.

      Remedy: Correct the KEEP file number value.  You can keep anywhere from
	      zoro to 999 files beyond the current audit file.

09989 PRS DFN Invalid AUDIT directory name

      Reason: Attempting to perform a START AUDIT operation and the specified
	      directory name is invalid.

      Remedy: Correct the specified diretory name.

09990 PRS MAI Missing AUDIT name identifier

      Reason: Attempting to perform a START AUDIT operation and the audit name
	      identifier has not been specified.

      Remedy: Specify a valid audit name identifier.

09991 PRS MSG MESSAGE keyword missing or misspelled

      Reason: The MESSAGE keyword is missing or misspelled in the AUDIT
	      MESSAGE command.	The command syntax is:

		   AUDIT MESSAGE 'string-contant'


      Remedy: Correct the SQL statement.

09992 PRS DMM Datatype mismatch.

      Reason: The source and target types of an assignment are not the same.

      Remedy: Change the type of either source or target.

09993 PRS RNA REFERENCING clause not allowed in FOR EACH STATEMENT trigger.

      Reason: A REFERENCING clause is allowed only with a FOR EACH ROW
	      trigger.

      Remedy: Change the trigger type to FOR EACH ROW or remove the
	      REFERENCING clause.

09994 PRS ARC Keyword AUTORECOMPILE is expected

      Reason: AUTORECOMPILE cannot be omitted.

      Remedy: Correct ALTER COMMAND command.

09995 PRS OPT Keyword ON or OFF is expected

      Reason: ON or OFF must be supplied.

      Remedy: Correct ALTER COMMAND command.

09996 PRS MBS Keyword STATIC is expected

      Reason: Inline procedure must be static

      Remedy: Specify the inline procedure to be static after the procedure
	      name.

09997 PRS VOT Future time expected for a one-time event

      Reason: It is recommended that the action time be far in the future.

      Remedy: Advance the action time or default it.

09998 PRS VVE Time element cannot be an expression

      Reason: The current syntax does not allow expressions.

      Remedy: Replace the offending expressions with time constants.

09999 PRS VCN Invalid command name

      Reason: Command name cannot be recognized.

      Remedy: Provide a proper command name.

10000 PRS SET Keyword SET is expected

      Reason: SET cannot be omitted.

      Remedy: Correct ALTER COMMAND command.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general MATH
library errors while attempting a financial @function like @acos, @asin,
@atan, @atan2, @cos, @exp, @ln, @log, @mod, @pi, @sin, @sqrt, or @tan
OR attempting a mathematical @function like @cterm, @fv, @pmt, @pv, @rate,
@sln, @syd, or @term.
10001 MTH 001 MATH LIB: argument domain error (DOMAIN)

      Reason: Attempting a financial @function like @acos, @asin, @atan,
	      @atan2, @cos, @exp, @ln, @log, @mod, @pi, @sin, @sqrt, or @tan
	      OR attempting a mathematical @function like @cterm, @fv, @pmt,
	      @pv, @rate, @sln, @syd, or @term and the specified math error
	      has occurred.

      Remedy: Correct the value or values used with this @function.

10002 MTH 002 MATH LIB: argument singularity error (SING)

      Reason: Attempting a financial @function like @acos, @asin, @atan,
	      @atan2, @cos, @exp, @ln, @log, @mod, @pi, @sin, @sqrt, or @tan
	      OR attempting a mathematical @function like @cterm, @fv, @pmt,
	      @pv, @rate, @sln, @syd, or @term and the specified math error
	      has occurred.

      Remedy: Correct the value or values used with this @function.

10003 MTH 003 MATH LIB: overflow range error (OVERFLOW)

      Reason: Attempting a financial @function like @acos, @asin, @atan,
	      @atan2, @cos, @exp, @ln, @log, @mod, @pi, @sin, @sqrt, or @tan
	      OR attempting a mathematical @function like @cterm, @fv, @pmt,
	      @pv, @rate, @sln, @syd, or @term and the specified math error
	      has occurred.

      Remedy: Correct the value or values used with this @function.

10004 MTH 004 MATH LIB: underflow range error (UNDERFLOW)

      Reason: Attempting a financial @function like @acos, @asin, @atan,
	      @atan2, @cos, @exp, @ln, @log, @mod, @pi, @sin, @sqrt, or @tan
	      OR attempting a mathematical @function like @cterm, @fv, @pmt,
	      @pv, @rate, @sln, @syd, or @term and the specified math error
	      has occurred.

      Remedy: Correct the value or values used with this @function.

10005 MTH 005 MATH LIB: total loss of precision (TLOSS)

      Reason: Attempting a financial @function like @acos, @asin, @atan,
	      @atan2, @cos, @exp, @ln, @log, @mod, @pi, @sin, @sqrt, or @tan
	      OR attempting a mathematical @function like @cterm, @fv, @pmt,
	      @pv, @rate, @sln, @syd, or @term and the specified math error
	      has occurred.

      Remedy: Correct the value or values used with this @function.

10006 MTH 006 MATH LIB: partial loss of precision (PLOSS)

      Reason: Attempting a financial @function like @acos, @asin, @atan,
	      @atan2, @cos, @exp, @ln, @log, @mod, @pi, @sin, @sqrt, or @tan
	      OR attempting a mathematical @function like @cterm, @fv, @pmt,
	      @pv, @rate, @sln, @syd, or @term and the specified math error
	      has occurred.

      Remedy: Correct the value or values used with this @function.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for Display
Manager errors.
10101 DSM IMT INTERNAL USE ONLY - Invalid message type

      Reason: A GSA server application, such as SQLBase or a gateway, issued
	      the dsmLogSQLMLI function with an incorrect parameter value for
	      the type of SQL/API message.  This is error is only used
	      internally by the SQLBase system.

      Remedy: None.  This error should not occur.  If it does, it represents a
	      logic error in the GSA server code.  This error code should
	      never occur in an application program.  If you get this error,
	      contact your local Centura Software Corporation certified
	      technical support center.

10102 DSM MNF INTERNAL USE ONLY - Message text not found

      Reason: The Display Manager function dsmStatIndirect (or dsmDialog) was
	      unable to retrieve a message from the internal message table
	      (not error.sql).	The message could not be retrieved because it
	      could not be found.  This is error is only used internally by
	      the SQLBase system.

      Remedy: None.  This error should not occur.  If it does, it represents a
	      logic error in the GSA server code.  This error code should
	      never occur in an application program.  If you get this error,
	      contact your local Centura Software Corporation certified
	      technical support center.

10103 DSM OOM Out of memory at the database computer (DSM OOM)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for Keyboard
Manager errors.
10201 KBD KOR INTERNAL USE ONLY

      Reason: A GSA server application, such as SQLBase or a gateway, issued
	      the kdbSetKeyboardFunc function with an incorrect parameter
	      value for the keystroke number.  This is error is only used
	      internally by the SQLBase system.

      Remedy: None.  This error code should never occur in an application
	      program.	If it does, it represents a logic error in the GSA
	      server code.  It is not an error that a client application can
	      produce.	If you get this error, contact your local Centura
	      Software Corporation certified technical support center.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for the
database message conversion interface.
10301 MCI IES INTERNAL USE ONLY - invalid export size

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10302 MCI IIS INTERNAL USE ONLY - invalid import size

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10303 MCI IAT Invalid architecture type

      Reason: The database server does not recognize the hardware architecture
	      type of the client requesting a connection - this could happen
	      because Centura Software Corporation is supporting a new
	      architecture type and the client workstation with this new
	      architecture connects to a database server that has not been
	      updated.

      Remedy: Obtain and install an updated database server that supports the
	      new architecture type from Centura Software Corporation.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
type errors.
10401 SQL NLD No local databases

      Reason: Attempting to get a listing of available database on the local
	      client workstation and no local databases exist.

      Remedy: None.  Informational only.  No local databases exist.

10402 SQL INM Invalid cursor name

      Reason: Attempting to name a cursor and the specified name is missing or
	      invalid.

      Remedy: Correct the command by properly specifying a valid cursor name.

10403 SQL CAO Out of memory at the client (SQL CAO)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

10404 SQL MSE Describe must follow a successful Select Execute

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10405 SQL NDE No Describe information is available for this cursor

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10407 SQL BCS Cannot execute a chained cmd with SELECT in bulk execute mode

      Reason: Chained commands which are executed in bulk execute mode may not
	      include SELECT commands.

      Remedy: Remove the SELECT command from chained command or turn bulk
	      execute mode off.

10408 SQL FCH Fetch backwards not allowed with chained commands

      Reason: Fetch backward with a chained command is not allowed.

      Remedy: Turn fetch backward off or don't execute the chained command
	      while in bulk execute command.

10409 SQL IBF Invalid backup file

      Reason: Could not read data from a backup file.

      Remedy: Check to make sure that the files being restored are were
	      created by doing an online backup.

10410 SQL NEU Not a recently executed UPDATE

      Reason: An attempt was made to retrieve the ROWID with the SQLPRID
	      sqlget() parameter on a cursor which does not contain an
	      executed UPDATE command.

      Remedy: Successfully execute an UPDATE command.

10411 SQL NFQ No fully qualified name

      Reason: An attempt was made to retrieve the fully qualified name and the
	      fully qualified name is not available.

      Remedy: Check if backend engine provides the name.  If backend engine
	      does not provide fully qualified names, do not try to get the
	      name.

10412 SQL RSV NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10413 SQL LIP 003 - Fatal SQLBase System Failure (SQL LIP)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

10414 SQL CAQ Out of memory at the client (SQL CAQ)

      Reason: The application has run out of memory at the client workstation.

      Remedy: Check available memory at the client workstation.  Attempt to
	      make more memory available.

10415 SQL ANT API nested too deep.

      Reason: API calls were nested too deep.

      Remedy: Make sure your code does not make recursive API calls.

10416 SQL STO Maximum nesting limit exceeded - command rolled back.

      Reason: This error is usually caused by the user executing a
	      stored-procedure or trigger that recurses heavily on execution,
	      causing the stack in which it is executing to overflow.

      Remedy: If you are executing a stored-procedure, examine it and recode
	      if necessary to ensure that you are not recursing too deeply.
	      If you are executing a DML command that has a trigger examine
	      the code executed for the trigger.  If neither of the above
	      cases is true, report this bug to your Centura Software
	      Corporation Technical Support representative.

10417 SQL ACN Already connected in non-distributed transaction mode.

      Reason: Cannot connect to this database in distributed transaction mode.
	      You already have connected to this database in ordinary (i.e
	      non-distributed) transaction mode.

      Remedy: Disconnect from the database completely and then connect again
	      in distributed transaction mode.

10418 SQL ACD Already connected in distributed transaction mode.

      Reason: Cannot connect to this database in non-distributed transaction
	      mode.  You already have connected to this database in
	      distributed transaction mode.

      Remedy: Disconnect from the database completely and then connect again
	      in non-distributed transaction mode.

10419 SQL CRD Cannot explicitly turn off distributed transaction mode

      Reason: Tried to turn off distributed transaction mode using SQLSET.

      Remedy: Currently, you cannot turn off the distributed transaction mode
	      explicitly.  This means that once you begin connecting in
	      distributed transaction mode, it applies to all future
	      connections.

10420 SQL CSD Cannot start distributed transaction.

      Reason: Failed to start distributed transaction mode.

      Remedy: You cannot use distributed transactions.

10421 SQL COF Cannot open Load or Unload file

      Reason: The Load/Unload file could not be opened by the SQLBase.

      Remedy: Check the directory path, filename and write protections of the
	      file to make sure that they are legal.

10422 SQL FAE Load or unload file already already exists

      Reason: The Load/Unload file already exists.

      Remedy: A load/unload file of the specified name already exists in the
	      path specified.  If you want to overwrite this file, use
	      OVERWRITE option in the Load/Unload command.

10423 SQL NNB No name buffer specified

      Reason: Name buffer is not specified.

      Remedy: Specify a buffer large enough for the name.

10424 SQL IVN Invalid number of INTO variables

      Reason: Invalid number of INTO variables

      Remedy: The number of INTO variables must match the number of projected
	      items in a select statement.

10425 SQL CAX 008 - Out of memory at the database computer (SQL CAX)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10426 SQL FNP Feature not allowed on a procedure cursor

      Reason: Feature not allowed on a procedure cursor

      Remedy: Do not use this feature on a procedure cursor.

10427 SQL ITH Invalid task handle

      Reason: The task handle does not represent a valid SQL task.

      Remedy: Ensure that the task handle is valid.

10428 SQL SNE SQLTrace not enabled

      Reason: An attempt was made to access SQLTrace data when the sqltrace
	      parameter in the sql.ini is set to FALSE.

      Remedy: Enable the sqltrace setting in the sql.ini file.

10429 SQL CNL Invalid Client name

      Reason: A client name was specified which is either too small or too
	      large. Maximum size is twelve characters.

      Remedy: Specify a client name from one to twelve characters.

10430 SQL MID Invalid Mail Id

      Reason: A mail id was specified which is either too small or too
	      large.  Maximum size is 32 characters.

      Remedy: Specify a mail id from 1 to 32 characters.

10431 SQL NID Invalid Network Id

      Reason: A network id was specified which is either too small or too
	      large.  Maximum size is 32 characters.

      Remedy: Specify a network id from 1 to 32 characters.

10432 SQL AID Invalid Adapter Id

      Reason: A adapter id was specified which is either too small or too
	      large.  Maximum size is 32 characters.

      Remedy: Specify a adapter id from 1 to 32 characters.

10433 SQL UID Invalid Application Id

      Reason: A application id was specified which is either too small or too
	      large.  Maximum size is 32 characters.

      Remedy: Specify a application id from 1 to 32 characters.

10434 SQL IPN Invalid process number

      Reason: The application program is attempting to perform a function call
	      and is using an invalid process number.

      Remedy: Correct the application program.	Verify that the process number
	      is valid.

10435 SQL BEV (Incompatible) server does not support attempted function

      Reason: Client and server do not have compatible versions for launching
	      the attempted function/feature.

      Remedy: Use a configuration consisting of compatible client and server.

10436 SQL NPR No permission to access remote files

      Reason: The remote file server has been started with remote file access
	      disallowed.

      Remedy: Contact your system administrator to turn on the remote file
	      access.  File access can be turned on by adding "FILEACCESS=1"
	      in the server section of the remote server's sql.ini file.

10437 SQL TNS SQLTrace not supported on this platform

      Reason: An attempt was made to access a SQLTrace procedure on an
	      unsupported platform.

      Remedy: Refrain from using SQLTrace procedures on unsupported platforms.

10438 SQL NDT Distributed transactions are not supported by this back-end

      Reason: The user attempted to connect in distributed transaction mode
	      to a back-end server that does not support distributed
	      transactons (i.e a pre-6.0 SQLBase server)

      Remedy: Turn off distrubuted transaction mode and try to connect again.

10439 SQL SIZ Restore is over maximum file size (SQL SIZ)

      Reason: Calculated backup size is greater than 2 GB and restore is to
      a non-partitioned database.

      Remedy: Do the restore to a partitioned database.
	  (See Database Administrator's Guide)

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
numeric type errors.
10501 NUM BNP Pointer to number is bad

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10502 NUM NLS Length of the number is too small (less than or equal to zero)

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10503 NUM NLL Length of the number is too large (greater than 12)

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10504 NUM ETS Exponent of the number is too small

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10505 NUM ETL Exponent of the number is too large

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10506 NUM MNM Number is missing negative marker

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10507 NUM BNM Number has bad negative marker

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10508 NUM DTS Digit of the number is too small

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

10509 NUM DTL Digit of the number is too large

      Reason: Attempting to use the API function sqlxad, sqlxda, sqlxdp,
	      sqlxdv sqlxml, sqlxnp, or sqlxsb and a specified pointer to a
	      number or the specified length of the number is invalid.	This
	      is an application programming problem.

      Remedy: If you are using a extended math API function, correct the API
	      function call.  If you are using an application that has
	      generated this error, contact the supplier of the application
	      program.	If you have verified that you are not directly or
	      indirectly calling a extended math API function then contact
	      your local Centura Software Corporation certified technical
	      support center.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors
relating to distributed databases and in particular errors regarding the
MAIN central database.
10601 MDB NSC INTERNAL USE ONLY - No saved context for restore

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10602 MDB COI Cannot open MAIN.INI

      Reason: Cannot open the MAIN.INI file.

      Remedy: Copy MAIN.INI to user's working directory.

10603 MDB XXX Unused

      Reason: None

      Remedy: None

10604 MDB UME User cannot name databases MAIN, please rename this database

      Reason: Attempting to name a database by the name of MAIN.

      Remedy: Use a different database name other than MAIN.

10605 MDB MMV SQLBase and MAIN.INI have mismatching versions

      Reason: The MAIN.INI file attempting to be used is not the proper
	      version, that is, the software version number found on line
	      one of MAIN.INI does not match the SQLBase version number.

      Remedy: Use the correct version of the MAIN.INI file for this
	      particular version of SQLBase.

10606 MDB ICT 003 - Fatal SQLBase System Failure (MDB ICT)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

10607 MDB IDT 003 - Fatal SQLBase System Failure (MDB IDT)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are errors
generated by the partition file system for partitioned databases.
05/03/94 SA obug fix: correct allocation page for longs
10701 PFS NEF NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10702 PFS IFH INTERNAL USE ONLY - Invalid file handle

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10703 PFS IEN Invalid extent number in MAIN database

      Reason: The MAIN database has been determined to be inconsistent.

      Remedy: Stop all partitioned database operations and run a CHECK
	      DATABASE operation on the MAIN database in single user mode.  If
	      an error is reported, attempt to correct the problem by either
	      dropping and re-creating the offending object or restore the
	      MAIN database from the most recent backup.  If the CHECK
	      DATABASE operation does not report a problem, then contact
	      your local Centura Software Corporation certified technical
	      support center.

10704 PFS IAI NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10705 PFS IPE INTERNAL USE ONLY - I/O attempted past end-of-file

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10706 PFS COV Out of memory at the database computer (PFS COV)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10707 PFS COD Out of memory at the database computer (PFS COD)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10708 PFS CFV Out of memory at the database computer (PFS CFV)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10709 PFS CFD Out of memory at the database computer (PFS CFD)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10710 PFS CAV Out of memory at the database computer (PFS CAV)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10711 PFS CAD Out of memory at the database computer (PFS CAD)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10712 PFS COA Cannot open area file for MAIN database

      Reason: The MAIN database has been determined to be inconsistent.

      Remedy: Stop all partitioned database operations and run a CHECK
	      DATABASE operation on the MAIN database in single user mode.  If
	      an error is reported, attempt to correct the problem by either
	      dropping and re-creating the offending object or restore the
	      MAIN database from the most recent backup.  If the CHECK
	      DATABASE operation does not report a problem, then contact
	      your local Centura Software Corporation certified technical
	      support center.

10713 PFS CEM Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10714 PFS 002 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10715 PFS CEF Cannot extend partitioned file

      Reason: There is insufficient disk space in a storage group.

      Remedy: Check which storage group (database or log) is running out of
	      disk space.  Create a new DBAREA and add space the storage
	      group.

10716 PFS CEE Out of memory at the database computer (PFS CEE)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10717 PFS NPD INTERNAL USE ONLY - Not partitioned database

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10718 PFS 001 NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10719 PFS FDE File does not exist for MAIN database

      Reason: The MAIN database has been determined to be inconsistent.

      Remedy: Stop all partitioned database operations and run a CHECK
	      DATABASE operation on the MAIN database in single user mode.  If
	      an error is reported, attempt to correct the problem by either
	      dropping and re-creating the offending object or restore the
	      MAIN database from the most recent backup.  If the CHECK
	      DATABASE operation does not report a problem, then contact
	      your local Centura Software Corporation certified technical
	      support center.

10720 PFS CAI Cannot allocate initial extent

      Reason: There is insufficient disk space in a storage group.

      Remedy: Check which storage group (database or log) is running out of
	      disk space.  Create a new DBAREA and add space the storage
	      group.

10721 PFS CDO INTERNAL USE ONLY - Cannot delete open file

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10722 PFS CEV Out of memory at the database computer (PFS CEV)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10723 PFS COR Main database tables are corrupt

      Reason: The MAIN database has been determined to be inconsistent.

      Remedy: Stop all partitioned database operations and run a CHECK
	      DATABASE operation on the MAIN database in single user mode.  If
	      an error is reported, attempt to correct the problem by either
	      dropping and re-creating the offending object or restore the
	      MAIN database from the most recent backup.  If the CHECK
	      DATABASE operation does not report a problem, then contact
	      your local Centura Software Corporation certified technical
	      support center.

10724 PFS MDC Incorrect extent table entries in the main database.

      Reason: The partition entries for this partitioned database have
	      been entered incorrectly. This could lead to database
	      corruption.

      Remedy: There is known problem in SQLBase 5.1.4 that can cause
	      this error.  If the main database was created with that
	      version, a utility named 'pdbfix' is available to fix the
	      problem.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
occur when performing database server commands.
10801 SVC CAT Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

10802 SVC VNM Main db set up improperly (stored cmd variables not matched)

      Reason: The main database has not been set up properly.  The number of
	      bind variables in a stored command do not match the number of
	      bind variables.

      Remedy: Reinstall the main database or recover from a backup database.

10803 SVC SNM Main db set up improperly (select col not matched w/stored cmd)

      Reason: The main database has not been set up properly.  The number of
	      columns selected does not match the number columns in the
	      previously stored command.

      Remedy: Reinstall the main database or recovery from a backup database.

10804 SVC DAN DBAREA <name> already exists or DBAREA not found

      Reason: Either attempting to CREATE a DBAREA and the DBAREA already
	      exists or attempting to ALTER a DBAREA and the DBAREA was not
	      found to be altered.

      Remedy: For a CREATE DBAREA, verify that the DBAREA area does not
	      already exist and retry using a unique name.  For ALTER DBAREA,
	      verify that the DBAREA exists and because you can only alter an
	      existing DBAREA.

10805 SVC DSG Stogroup name <name> already exists

      Reason: Attempting a CREATE STOGROUP and the specified stogroup name
	      already exists.

      Remedy: Verify the stogroup name and retry with a unique stogroup name.

10806 SVC DSA DBAREA <name> already in stogroup

      Reason: Attempting a CREATE STOGROUP or ALTER STOGROUP and the specified
	      DBAREA is already part of a previously defined stogroup.

      Remedy: Retry using a different stogroup.

10807 SVC NPD Not partitioned database, command not allowed

      Reason: Attempting an ALTER DATABASE command and the specified database
	      is not a partitioned database.

      Remedy: None.  The ALTER DATABASE command can only be used for
	      partitioned databases.

10808 SVC SCD Specified DBAREA is associated with stogroup

      Reason: Attempting to drop a DBAREA and the specified DBAREA is
	      associated with an establish stogroup.

      Remedy: Drop the associated stogroup before attempting to drop the
	      DBAREA.

10809 SVC ECD Specified DBAREA is in use

      Reason: Attempting to drop a DBAREA and the specified DBAREA is
	      being used as an extent area.

      Remedy: None.  You cannot drop a DBAREA that is in use.

10810 SVC DCS Specified stogroup has been assigned to the database

      Reason: Attempting to drop a stogroup but the specified stogroup has
	      been assigned to the database.

      Remedy: None.  You cannot drop a stogroup that has been assigned to the
	      database.

10811 SVC FCS Specified stogroup is the default stogroup

      Reason: Attempting to drop a stogroup but the specified stogroup is the
	      default stogroup.

      Remedy: Modify the default stogroup before attempting to drop the
	      specified stogroup.

10812 SVC ANF DBAREA <name> not found

      Reason: Attempting an ALTER DBAREA, ALTER STOGROUP, CREATE STOGROUP, or
	      DROP DBAREA and a specified DBAREA was not found.

      Remedy: Correct the SQL statement by properly specifying a valid DBAREA
	      name.

10813 SVC DNF Database not found

      Reason: Attempting an ALTER DATABASE and the specified database was not
	      found.

      Remedy: Correct the ALTER DATABASE statement by properly specifying a
	      valid database name.

10814 SVC DAE Database <name> already exists

      Reason: Attempting a CREATE DATABASE and the specified database already
	      exists.

      Remedy: Correct the CREATE DATABASE statement by properly specifying a
	      valid, nonexistent database.

10815 SVC IRS Insufficient raw device space

      Reason: Attempting a CREATE DBAREA or ALTER DBAREA and the requested
	      database area is larger than the actual amount of free raw
	      device space available on the specified device.

      Remedy: Correct the CREATE DBAREA or ALTER DBAREA statement by properly
	      specifying a database area that is not larger than the actual
	      amount of free raw device space available on the specified
	      device.

10816 SVC IFS Insufficient file space

      Reason: Attempting a CREATE DBAREA or ALTER DBAREA and the requested
	      database area is larger than the actual amount of free disk
	      space available on the specified device.

      Remedy: Correct the CREATE DBAREA or ALTER DBAREA statement by properly
	      specifying a database area that is not larger than the actual
	      amount of free disk space available on the specified device.

10817 SVC FAE File already exists

      Reason: Attempting a CREATE DBAREA and the specified file name already
	      exists.

      Remedy: Correct the CREATE DBAREA statement by specifying a filename
	      that does not already exist.

10818 SVC FCE File <filename> Creation Failure

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

10819 SVC IOE Disk Write Failure

      Reason: Attempting to write to a file and a disk write failure has
	      occurred.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

10820 SVC CCD INTERNAL USE ONLY

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10821 SVC AAE Auditname <name> already exists

      Reason: Attempting a START AUDIT command and the specified auditname
	      already exists.

      Remedy: Start an audit with a different name.

10822 SVC FNF File associated with DBAREA not found

      Reason: Attempting an ALTER DBAREA to increase the size of the database
	      area and a file associated with the DBAREA cannot be found.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

10823 SVC MNE MAIN database does not exist

      Reason: Trying to use a server command and the command is related to a
	      partitioned database while the MAIN database has not been
	      created.	For example, attempting to create a database with
	      stogroup(s) specified in the command.

      Remedy: Correct SQL statement.

10824 SVC CCM Cannot create Main database

      Reason: Attempting to create a database file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

10825 SVC SGN Stogroup name <name> not found

      Reason: Attempting a CREATE DATABASE, DROP STOGROUP, or SET DEFAULT
	      STOGROUP and the specified stogroup name does not exist.

      Remedy: Correct the SQL statement by properly specifying an existing
	      stogroup name.

10826 SVC DSO Data stored outside specified area

      Reason: Attempting an ALTER DBAREA and the size of the database area is
	      being decreased by data is already stored outside of the
	      specified area.

      Remedy: None.  The database area cannot be decreased if data already is
	      stored outside of the specified area.

10827 SVC ANS DBAREA <name> is not in stogroup <name>

      Reason: Attempting an ALTER STOGROUP to drop a DBAREA but the specified
	      database area is not in the specified storage group.

      Remedy: None.  A DBAREA cannot be dropped from a storage group is the
	      database area is not associated with the storage group.

10828 SVC DFE Delete file error

      Reason: Attempting a DROP DBAREA or DROP DATBASE and the file cannot be
	      deleted.

      Remedy: Determine and correct the cause of the file delete failure.  Run
	      a check disk utility (CHKDSK) for the current operating system
	      to verify the status of the disk.

10829 SVC IRF Initialization reading failure

      Reason: Attempting to read a file and a disk read failure has occurred.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

10830 SVC IWF Initialization writing failure

      Reason: Attempting to write to a file and a disk write failure has
	      occurred.

      Remedy: Determine and correct the cause of the disk write failure.  Most
	      commonly, it may be because you have run out of available disk
	      space.  If sufficient disk space is available, then run a check
	      disk utility (CHKDSK) for the current operating system to verify
	      the status of the disk.

10831 SVC DNA Specified DBAREA is not allocable (internal error)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

10832 SVC MTF Cannot start another audit, maximum audit files exceeded

      Reason: Attempting to start a 33rd audit file.  The maximum number
	      of allowable audit files is 32.

      Remedy: None.  You cannot have more than 32 concurrent audit files.

10833 SVC MZK Must have SIZE keyword

      Reason: Attempting a CREATE DBAREA and the SIZE keyword is either
	      missing or misspelled.

      Remedy: Correct the CREATE DBAREA statement by properly specifying a
	      SIZE keyword.

10834 SVC NOP MAIN database not open to public

      Reason: Attempting a to create, delete, install, or deinstall the MAIN
	      database and the MAIN database cannot be modified by the general
	      public.

      Remedy: None.  The MAIN database is not open to the public.

10835 SVC TNF Audit does not exist

      Reason: Attempting a AUDIT command or STOP AUDIT command and a
	      specified audit does not exist.

      Remedy: Specify an existing auditname identifier.

10836 SVC USC Unknown server command

      Reason: Attempting an unknown database server command.

      Remedy: Correct the SQL statement by properly specifying a valid
	      database server command.

10837 SVC DNE Database <name> does not exist

      Reason: Attempting to delete or deinstall a non-existent database.

      Remedy: Correct the SQL statement by properly specifying a valid,
	      existing database name.

10838 SVC PDE Partitioned database is already enabled

      Reason: An attempt to enable partitioned databases was made when the
	      partitioned databases were already enabled.

      Remedy: No remedy needed.

10839 SVC PDD Partitioned database is already disabled

      Reason: An attempt to disable partitioned databases was made when the
	      partitioned databases were already disabled.

      Remedy: No remedy needed.

10840 SVC PIU Partitioned database in use

      Reason: An attempt to disable partitioned databases was made when a
	      partitioned database was in use.

      Remedy: Disconnect from all partitioned databases before trying to
	      disable partitioned databases.

10841 SVC IGP Illegal server get parameter

      Reason: An attempt to use an invalid get parameter on a server connect
	      was made.

      Remedy: Use a correct server get parameter as defined in SQL.H

10842 SVC CSA 001 - Undocumented

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10843 SVC CSD Commit service is already disabled

      Reason: The user attempted to disable the COMMIT SERVICE
	      when it was already disabled.

      Remedy: None needed -- the commit service is already disabled.

10844 SVC CSE Commit service is already enabled

      Reason: The user attempted to enable the COMMIT SERVICE
	      when it was already enabled.

      Remedy: None needed -- the commit service is already enabled.

10845 SVC ATE AUDIT file <filename> does not exist

      Reason: Attempting to APPEND to an audit file that cannot be found.

      Remedy: Verify the file to be appended to exists.  Determine why the
	      operating system could not locate the specified file.

10846 SVC COF Cannot open AUDIT file <filename>

      Reason: Attempting a START AUDIT with an APPEND clause and while
	      attempting to open the existing file a failure has occurred.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

10847 SVC AAA AUDIT <auditname> already active

      Reason: Attempting a START AUDIT and the named audit is already active.

      Remedy: None.  You cannot start an audit that is already active.
	      Choose another audit name.

10848 SVC AFE Audit file <filename> already exists

      Reason: Attempting to start an audit (without the APPEND clause) and
	      the specified file name already exists or the current audit
	      file has reached its maximum SIZE and when attempting to roll
	      over to the next audit file the next audit file was found to
	      already exist and the OVERWRITE clause was not specified.

      Remedy: Correct the problem by specifying an audit name that does not
	      already exist as a file.	Or append to an existing audit file
	      using the APPEND option.	Or restart the AUDIT with the
	      OVERWRITE clause.  Or delete the target file.

10849 SVC CCT Unable to create temporary file (failing MAIN database creation)

      Reason: This is typically due to the absence of the expected directory
	      for temporary files.

      Remedy: Make sure the expected directory exists.

10850 SVC UCM Unable to connect to the MAIN database

      Reason: This is possibly due to the absence of the expected directory
	      for temporary files.

      Remedy: Make sure the expected directory exists.

10851 SVC ISC Invalid SQL statement detected (failing MAIN database creation)

      Reason: This is possibly due to a corrupted MAIN.INI or misprocessing.

      Remedy: Make sure MAIN.INI is intact.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
database message errors.
10901 MES CLM Cannot locate message file

      Reason: The SQLBase system cannot find the file MESSAGE.SQL.

      Remedy: Determine why the SQLBase system could not find the MESSAGE.SQL
	      file and correct the problem.

10902 MES COM Cannot open message file

      Reason: The SQLBase system cannot open the MESSAGE.SQL file.

      Remedy: Determine and correct the cause of the open file failure.
	      Verify that the specified file exists.  Verify the number of
	      files allowed open for the operating system permits the
	      additional file, that is, check the FILES= configuration
	      parameter setting.

10903 MES IXC Bad message file: invalid X-coordinate

      Reason: An invalid X-coordinate has been specified in the MESSAGE.SQL
	      file.  The X-coordinate and Y-coordinate specify the screen
	      coordinates for certain messages.

      Remedy: Correct the invalid X-coordinate.

10904 MES IYC Bad message file: invalid Y-coordinate

      Reason: An invalid Y-coordinate has been specified in the MESSAGE.SQL
	      file.  The X-coordinate and Y-coordinate specify the screen
	      coordinates for certain messages.

      Remedy: Correct the invalid Y-coordinate.

10905 MES IMP Bad message file: invalid message parameter

      Reason: An invalid message parameter has been specified in the
	      MESSAGE.SQL file.  The message parameters explain how the
	      message is used.	Currently, the only valid message parameters
	      are S, T, X, and Y.

      Remedy: Correct the invalid message parameter.

10906 MES ISV INTERNAL USE ONLY - Bad message file: invalid state value

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

10907 MES IMI Bad message file: invalid message id

      Reason: An invalid message id has been specified in the MESSAGE.SQL
	      file.

      Remedy: Correct the invalid message id.

10908 MES MMC Bad message file: missing message comment

      Reason: A message comment is missing from the MESSAGE.SQL file.

      Remedy: Correct the MESSAGE.SQL file by adding the appropriate message
	      comment.

10909 MES CAM Cannot allocate message table

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10910 MES EOF Bad message file: unexpected EOF

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10911 MES MEQ Bad message file: missing end quote

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10912 MES EEC Bad message file: expected end of comment

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10913 MES IES Bad message file: invalid escape sequence

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10914 MES MMS Bad message file: missing message string

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

10915 MES MMV SQLBase and MESSAGE.SQL file have mismatching versions

      Reason: The MESSAGE.SQL file attempting to be used is not the proper
	      version, that is, the software version number found on line
	      one of MESSAGE.SQL does not match the SQLBase version number.

      Remedy: Use the correct version of the MESSAGE.SQL file for this
	      particular version of SQLBase.

10916 MES AIN Message table already initialised

      Reason: This error is currently undocumented.

      Remedy: Contact your local Centura Software Corporation certified
	      technical support center for assistance.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for HASH index
errors.
11001 HSH CSS Out of memory at the database computer.

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for Access Path
Analysis errors.
11101 APA CNA Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

11102 APA OOM Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      necessary query optimization.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce the size of the CACHE.  Or,
	      split the query to simpler queries and try again.

11103 APA TMB Too many booleans in query

      Reason: Not enough memory at the database engine to perform the
	      necessary query optimization.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce the size of the CACHE.  Or,
	      reduce the number of boolean expressions in the query,
	      especially the size of any IN list.

11104 APA CNC Cannot create PLAN_TABLE due to error code: <database sql error code>

      Reason: PLANONLY ON mode creates query plans in PLAN_TABLE. The
	      PLAN_TABLE could not be created due to certain errors such
	      as no security privileges, or database in READONLY mode, or
	      any other resource limitations.

      Remedy: Remove the offending cause and try again.

11105 APA CNU Cannot update PLAN_TABLE due to error code: <database sql error code>

      Reason: PLANONLY ON mode updates the PLAN_TABLE with query plans. The
	      PLAN_TABLE could not be updated due to certain errors such
	      as no security privileges, or database in READONLY mode, or
	      any other resource limitations.

      Remedy: Remove the offending cause and try again.

11201 GFS ICF Fatal SQLBase System Failure (GFS ICF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

11202 GFS IVF Fatal SQLBase System Failure (GFS IVF)

      Reason: This is a Fatal Error.

      Remedy: Stop all database operations and run a CHECK DATABASE operation.
	      If a FAIL.SQL file is available, then save it.  Attempt to
	      reproduce the problem via a SQL script, scenario, or using the
	      NETLOG utility (see the DBA Guide for how to produce a NETLOG).
	      Contact your local Centura Software Corporation certified
	      technical support center.

11203 GFS CAV Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

11204 GFS CAD Out of memory at the database computer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.


11205 GFS MAX Attempt to extend file beyond 2 gigabytes

      Reason: The file size is limited to 2 gigabytes.	For standard maximum,
	      the file cannot extend beyond this size.

      Remedy: If this is a database file, either unload or back up the database,
	      and load or recover into a partitioned database space.  Limit
	      extents to 2 gigabytes or less.

11206 GFS LCM Log Checksum Mismatch (GFS LCM)

      Reason: Log checksum mismatch before the write

      Remedy: None. The log file is corrupted.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for catalog
command parsing errors.  These errors generally occur during the compilation
of a catalog command and the statement violates the syntax for that catalog
command.
11301 CAC CNE Command not properly ended

      Reason: The end of a catalog command ended unexpectedly.

      Remedy: Verify that the catalog command syntax is correct and that the
	      statement was not somehow truncated.

11302 CAC ICC Invalid catalog command

      Reason: The next keyword immediately following a CATALOG verb is
	      invalid.

      Remedy: Verify that the keyword immediately following the CATALOG verb
	      keyword is either TABLE, COLUMN, INDEX, KEYS, RELS, TABAUTH,
	      or COLAUTH.

11303 CAC MTB Missing TBNAME keyword

      Reason: The TBNAME keyword is missing from a TABLE statement.

      Remedy: Verify that the TBNAME keyword exists and that it is correctly
	      entered after the TABLE keyword.

11304 CAC UIO Unknown input option

      Reason: An unknown input option was encountered.

      Remedy: Check the syntax of the statement to determine the correct
	      input options.

11305 CAC ATY AUTHORIRY keyword has been specified

      Reason: AUTHORITY keyword has been specified and cannot be specified
	      again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11306 CAC CTR CREATOR keyword has been specified

      Reason: CREATOR keyword has been specified and cannot be specified
	      again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11307 CAC GEE GRANTEE keyword has been specified

      Reason: GRANTEE keyword has been specified and cannot be specified
	      again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11308 CAC QNS QUALIFIER not supported

      Reason: Qualifier keyword not supported in SQLBase.

      Remedy: Check the statement, remove the option and reenter again.

11309 CAC TYP TYPE keyword has been specified

      Reason: TYPE keyword has been specified and cannot be specified again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11310 CAC UTT Unknown table type

      Reason: An unknown table type is encountered.

      Remedy: Check the syntax of the statement to determine the correct
	      table types.

11311 CAC UIT Unknown index type

      Reason: An unknown index type is encountered.

      Remedy: Check the syntax of the statement to determine the correct
	      index types.

11312 CAC UOO Unknown output option

      Reason: An unknown output option is encountered.

      Remedy: Check the syntax of the statement to determine the correct
	      output options.

11313 CAC OOM Out of memory at the database computer (CAC OOM)

      Reason: Not enough memory at the database engine to perform the
	      compilation.

      Remedy: Check available memory at database computer.  Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce the size of CACHE.

11314 CAC UAO Unknown authority option

      Reason: An unknown authority option is encountered.

      Remedy: Check the syntax of the statement to determine the correct
	      authority options.

11315 CAC UOC Unknown ORDER BY column

      Reason: An unknown ORDER BY column is encountered.

      Remedy: Check the syntax of the statement to determine the correct
	      ORDER BY column.

11316 CAC SEL Output option is specified more than once

      Reason: Output option is specified more than once.

      Remedy: Check the syntax of the statement to determine where the
	      duplicate is.

11317 CAC CNS Command not supported

      Reason: This command is currently not supported.

      Remedy: None.  Contact your local Centura Software Corporation
	      certified technical support center to find out when this
	      command will be supported.

11318 CAC MMI Missing mandatory input parameter

      Reason: mandatory input parameter(s) is not present.

      Remedy: Check the syntax of the statement to determine which parameter
	      is missing and reenter the command.

11319 CAC UCT Unknown column type

      Reason: An unknown column type is encountered.

      Remedy: Check the syntax of the statement to determine the correct
	      column types.

11320 CAC ITB Invalid character in TBNAME

      Reason: The TBNAME contains an invalid character.

      Remedy: Verify the characters used for TBNAME are correctly entered.

11321 CAC MCK Missing comma

      Reason: The comma is missing from an option list.

      Remedy: Verify that the comma exists and that it is correctly
	      entered in the option list.

11322 CAC MAO Missing authority option

      Reason: Authority option is expected while separator is encountered
	      in the option list.

      Remedy: Verify that the authority options are correctly entered in
	      the option list.

11323 CAC NSC No select column

      Reason: SELECT keyword is specified while no select column is found.

      Remedy: Verify that the select columns are correctly entered.

11324 CAC NOB No ORDER BY column

      Reason: ORDER BY clause is specified while no ORDER BY column is found.

      Remedy: Verify the ORDER BY columns are correctly entered.

11325 CAC WNA Wild card characters not allowed here

      Reason: Wild card characters not allowed here.

      Remedy: Verify that the wild card not used and reenter again.

11326 CAC TBN TBNAME keyword has been specified

      Reason: TBNAME keyword has been specified and cannot be specified
	      again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11327 CAC IXN IXNAME keyword has been specified

      Reason: IXNAME keyword has been specified and cannot be specified
	      again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11328 CAC SYN SYNNAME keyword has been specified

      Reason: SYNNAME keyword has been specified and cannot be specified
	      again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11329 CAC SCR SYNCREATOR keyword has been specified

      Reason: SYBCREATOR keyword has been specified and cannot be specified
	      again.

      Remedy: Check the statement to determine where the duplicate is and
	      reenter again.

11330 CAC OCS ORDER BY column not in select list

      Reason: An ORDER BY column is found not in select list.

      Remedy: Check the statement to determine which ORDER BY column is not
	      in select list; correct the statement and reenter again.

11331 CAC MEL Missing equality sign or LIKE keyword

      Reason: An equal(=) sign or LIKE keyword is missing.

      Remedy: Check the statement to determine which part of the statement
	      is missing.  Correct and reenter again.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors that
can occur when the database is performing direct file system access.
11401 DFS EOF Cannot find End of File for Direct File System file

      Reason: The database system failed to locate the end of a Direct File
	      System file.  This is a Fatal Error.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11402 DFS VMI Cannot get volume mapping info for Direct File System file

      Reason: The database system failed to get the volume mapping information
	      for a Direct File System file.  This is a Fatal Error.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11403 DFS VMF Volume is full for Direct File System file

      Reason: The database system failed to write data to a Direct File System
	      file because volume is full for the Direct File System file.
	      This is a Fatal Error.

      Remedy: Acquire additional storage space for the Direct File System
	      file. A PURGE operation on the fileserver volumes is
	      recommended.

11404 DFS EXP Cannot expand Direct File System file

      Reason: The database system encountered an unrecoverable failure in the
	      process of extending a Direct File System file.  This is a Fatal
	      Error.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11405 DFS OSP Out of space for Direct File System file

      Reason: The database system failed to write data to a Direct File System
	      file because there is no free space available.

      Remedy: Acquire additional storage space	for  the  Direct  File	System
	      file.

11406 DFS OOM Out of memory at the database computer

      Reason: Out of memory during Direct File System process.

      Remedy: Acquire additional memory for the database computer.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for errors
occurred in temporary file manipulation.
11501 TMP OOM Out of memory in temporary file manipulation

      Reason: Not enough memory for temporary file manipulation.

      Remedy: Check memory availability at database server workstation.

11502 TMP OVF Temporary-file use count overflow

      Reason: Use count overflow is an internal error condition.

      Remedy: None.  Please report incident to Centura Software Corporation
	      technical support.

11503 TMP UND Temporary-file use count underflow

      Reason: Use count underflow is an internal error condition.

      Remedy: None.  Please report incident to Centura Software Corporation
	      technical support.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general
database operation type errors.
11601 DBO CTL Exceeded command time limit.

      Reason: Attempting to perform a select, insert, update or
	      delete and it took longer than the time limit set
	      in sql.ini.

      Remedy: Increase the time limit.
	      eg. cmdtimeout=0	     disabled.
		  cmdtimeout=5	     5 seconds.
		  cmdtimeout=43,200  12 hours (maximum).

11602 DBO ICN Invalid client name

      Reason: Attempting to name a process and the specified name is invalid.

      Remedy: Correct the command by properly specifying a valid client name.

11603 DBO IAC Invalid admin command

      Reason: Attempting to perform command with an administrative cursor.

      Remedy: Use a database cursor or server handle to perform the command.

11604 DBO DRO Distributed read-only transaction not currently supported

      Reason: Currently SQLBase does not support a distributed transaction
	      in READONLY isolation.

      Remedy: Use a different isolation; if READONLY isolation is
	      needed, then turn off distributed transactions and run
	      local transactions against each database.

11605 DBO SCT Stored command text not available

      Reason: Attempting to retrieve stored command text using an internal
	      cursor and the text has not been retrieved from the external
	      dictionary.

      Remedy: Use a database cursor to the database where the stored
	      command text resides.

11606 DBO AWS Invalid OS Averaging window size.

      Reason: OS Averaging window size exceeded the maximum.

      Remedy: Valid window sizes.
	      eg. osavgwindow=0       no averaging.
		  osavgwindow=1,255   1 to 255 values.

11607 DBO CDR Selected cursor is not active.

      Reason: Selected cursor is not currently selected as the active
	      cursor for its process.

      Remedy: Select cursor that is active for its process.

11608 DBO IMI Invalid mail id parameter

      Reason: The mail id parameter specified is either too small
	      or too  large.   Maximum size is 32 characters.

      Remedy: Correct the mail id parameter to be from 1 to 32
	      characters.

11609 DBO INI Invalid network id parameter

      Reason: The network id parameter specified is either too small
	      or too  large.   Maximum size is 32 characters.

      Remedy: Correct the network id parameter to be from 1 to 32
	      characters.

11610 DBO IAI Invalid adapter id parameter

      Reason: The adapter id parameter specified is either too small
	      or too  large.   Maximum size is 32 characters.

      Remedy: Correct the adapter id parameter to be from 1 to 32
	      characters.

11611 DBO IUI Invalid application id parameter

      Reason: The application id parameter specified is either too small
	      or too  large.   Maximum size is 32 characters.

      Remedy: Correct the application id parameter to be from 1 to 32
	      characters.

11612 DBO OSR Invalid OS sample rate.

      Reason: OS sample rate exceeded the maximum size.

      Remedy: Valid sample rate times.
	      eg. ossamplerate=0       disabled.
		  ossamplerate=1->255	1 sec to 4 min and 15 secs.

11613 DBO USD Unable to shutdown database.

      Reason: The server is not listening on the specified database or the
	      name is invalid.

      Remedy: Correct the database name or connect to the database and then
	      shutdown the database.

11614 DBO TPD Too many processes on the 6.0 database server.

      Reason: There more than 255 processes active on 6.0 database server.
	      A new client session can not be created.

      Remedy: Shutdown the server and restart it.

11615 DBO CVS Command or operation is valid for multi-user servers only

      Reason: A command or operation was attempted that is valid only
	      multi-user servers (for eg. DBWServr) but not
	      valid for single-user engines (for eg. DBWindow).

      Remedy: Do not use this function or if function is needed, use
	      a multi-user server.

11616 DBO CNS NOT USED

      Reason: This error code is currently not used by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11617 DBO SPE Stored Procedure already exists

      Reason: Attempting to execute a STORE command or C/API sqlsto function
	      for a stored procedure and the procedure already exists.

      Remedy: Either modify the STORE command to use a different procedure
	      name, or first drop the existing stored procedure.

11618 DBO EFE External function <name> already exists.

      Reason: Attempting to execute a STORE command or C/API sqlsto function
	      for a stored procedure and an external function with the same
	      name exists.

      Remedy: Modify the STORE command to use a different procedure name.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
parsing errors.  These errors generally occur during the compile of a SQL
statement and the statement violates the syntax for that SQL command.
11701 PRS NKC This is not a known update statistics column.

      Reason: The column name is misspelled or index statistics columns
	      are mixed with table statistics columns.

      Remedy: Correct the column name or check to see the statistics being
	      updated belongs to index or table as the case may be.

11702 PRS QNA Qualified names are not permitted in update statistics.

      Reason: Statistics columns are using qualified names.

      Remedy: Remove the table qualification to column names and resubmit
	      the SQL statement.

11703 PRS IOV Invalid OVERWRITE option

      Reason: Invalid overwrite option with this file name

      Remedy: Correct the SQL statement. Overwrite option can be specified
	      only with the load/unload files/control files.

11704 PRS ICF Invalid CONTROL option

      Reason: Invalid CONTROL option with this file name

      Remedy: Correct the SQL statement. CONTROL option can be specified
	      only with the load/unload control files.

11704 PRS IUO Invalid UNLOAD option

      Reason: Invalid UNLOAD command option used.

      Remedy: Correct the SQL statement.

11705 PRS INT Invalid INTO clause

      Reason: The INTO clause has already been processed.

      Remedy: Remove the INTO clause.

11706 PRS XDL Invalid object to LOCK or UNLOCK

      Reason: Attempting a LOCK DATABASE or UNLOCK DATABASE command and
	      the keyword DATABASE is either missing or misspelled.

      Remedy: Correct the LOCK DATABASE or UNLOCK DATABASE command by
	      properly specifying the keyword DATABASE immediately
	      after the keyword LOCK or UNLOCK.

11707 PRS ISF Invalid SqlWindows function

      Reason: This is not a valid SqlWindows function.

      Remedy: Use a valid SqlWindows function.

11708 PRS NFN No load/unload filename has been specified.

      Reason: No valid filename has been specified for either the
	      load/unload file.

      Remedy: Check your syntax and specify a valid filename.

11709 PRS NOV No output variables for FETCH section

      Reason: A FETCH section must generate output to variables for that
	      purpose.

      Remedy: Supply appropriate output parameters.

11710 PRS RVM Return value missing

      Reason: Return must be followed by a valid return value.

      Remedy: Append a return value after the return statement.

11711 PRS SFL Unload/load file name and Message Log file name are same.

      Reason: File names specified for load/unload external/control file
	      and the message log file are the same. They need to have
	      different file names/paths.

      Remedy: Check your syntax and specify correct filenames.

11712 PRS NLF No Load/Unload Message Log filename has been specified.

      Reason: No valid filename has been specified for either the
	      load/unload message log file.

      Remedy: Check your syntax and specify a valid filename.

11713 PRS SND START AT clause is not supported for DIF format.

      Reason: START AT clause is not supported for the DIF format.

      Remedy: Partial load cannot be done with DIF format load files. Load
	      has to be restarted from the begining of the file without
	      the START AT clause.

11714 PRS MLR Missing the keyword REFERENCING or left parenthesis

      Reason: Syntax was expecting either the REFERENCING keyword or a left
	      parenthesis beginning a parameter list for the trigger.

      Remedy: Check your syntax and make corrections.

11715 PRS NSP Database Events are not supported in this version.

      Reason: Database Events are not currently supported in this version
	      of SQLBase. They may be supported in the future versions.

      Remedy: Check your script and remove the "create event" statement.
	      Check the release notes for more details.

11716 PRS NUL Empty message received by the parser.

      Reason: The parser received an empty message when expecting otherwise.

      Remedy: The most likely cause of this problem is network problem. Edit
	      the server side sql.ini and place 'netcheck=1' under the server
	      section (i.e., dbnservr). Retry the operations and if you get
	      1316 error, then check your network card and cabling.

11717 PRS IEV Event name expected

      Reason: The event name specified in CREATE EVENT or DROP EVENT statement
	      is invalid.

      Remedy: Correct the SQL statement.  An event name can be a qualified or
	      unqualified long identifier.  The qualified form is a user id
	      followed by a period and a long identifier.  An unqualified
	      handler name in a SQL statement is implicitly qualified by the
	      id of the user who issues the statement.

11718 PRS EFK Expected FUNCTION keyword

      Reason: Attempting a CREATE, DROP, or ALTER EXTERNAL FUNCTION and the
	      FUNCTION keyword is missing or misspelled.

      Remedy: Correct the SQL statement.

11719 PRS IRT Invalid return data type

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and a specified
	      data type in the RETURNS clause is either invalid, missing,
	      or misspelled.

      Remedy: Correct the SQL statement.

11720 PRS EDT Invalid or missing external data type

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and a specified
	      external data type in the PARAMETERS clause or the RETURNS
	      clause is either invalid, missing, or misspelled.

      Remedy: Correct the SQL statement.

11721 PRS UDT NOT USED

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the
	      specified data types in the PARAMETERS clause or the RETURNS
	      clause are mismatching.  That is, the internal data type
	      specified does not support the external data type specified.

      Remedy: Review the documentation for more information on the allowable
	      data type combinations.  Correct the SQL statement.

11722 PRS BFN Invalid or missing function name

      Reason: The function name is either missing or not a valid long
	      identifier.

      Remedy: Correct the SQL statement by providing a valid long identifier
	      for the function name.

11723 PRS MMC Missing expected colon (:)

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the
	      specified data types in the PARAMETERS clause or the RETURNS
	      clause should be separated with a colon (:).  The expected
	      colon is missing or misplaced.

      Remedy: Correct the SQL statement.

11724 PRS BLN Missing or invalid library name

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the
	      library name is either missing or invalid.

      Remedy: Correct the SQL statement.

11725 PRS MLC Missing library name clause

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and no library
	      name clause as been specified.

      Remedy: Correct the SQL statement by providing a library name clause.
	      The library name clause is required.

11726 PRS MMN Missing or misspelled NAME keyword

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the EXTERNAL
	      NAME clause is missing the mandatory keyword NAME immediately
	      after the EXTERNAL keyword.

      Remedy: Correct the EXTERNAL NAME clause in the CREATE EXTERNAL FUNCTION
	      SQL statement.

11727 PRS BFI Invalid function name

      Reason: The specified function name is not valid.

      Remedy: Correct the SQL statement.

11728 PRS MMO Missing or misspelled ORDINAL keyword

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the
	      EXPORT ORDINAL clause is missing the mandatory keyword
	      ORDINAL immediately after the EXPORT keyword.

      Remedy: Correct the EXPORT ORDINAL clause in the CREATE EXTERNAL
	      FUNCTION SQL statement.

11729 PRS ION Missing or invalid ordinal number

      Reason: Attempting a CREATE or ALTER EXTERNAL FUNCTION statement and the
	      EXPORT ORDINAL clause is missing an ordinal number or the EXPORT
	      ORDINAL clause has specified an invalid ordinal number.

      Remedy: Correct the ordinal number in the EXPORT ORDINAL clause of the
	      CREATE or ALTER EXTERNAL FUNCTION SQL statement.

11730 PRS MPW Missing or misspelled PROCESS keyword

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the EXECUTE
	      IN clause is missing the mandatory keyword PROCESS immediately
	      after the SEPARATE keyword.

      Remedy: Correct the EXECUTE IN SEPARATE PROCESS clause in the CREATE
	      EXTERNAL FUNCTION SQL statement.

11731 PRS MTW Missing or misspelled THREAD keyword

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the EXECUTE
	      IN clause is missing the mandatory keyword THREAD immediately
	      after the SAME keyword.

      Remedy: Correct the EXECUTE IN SAME THREAD clause in the CREATE EXTERNAL
	      FUNCTION SQL statement.

11732 PRS ESS Expected SEPARATE or SAME keyword

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and the EXECUTE
	      IN clause is missing or has a misspelled SEPARATE or THREAD
	      keyword.

      Remedy: Correct the EXECUTE IN clause in the CREATE EXTERNAL FUNCTION
	      SQL statement by specifying either EXECUTE IN SEPARATE PROCESS
	      or EXECUTE IN SAME THREAD.

11733 PRS EXF External functions are not supported in this environment

      Reason: External functions are not supported in this environment.

      Remedy: None.  External functions are only supported under Win16 and
	      Win32 environments.

11734 PRS IEF Disallowed name <name> used as external function name

      Reason: Certain names are not allowed as external function names.  An
	      external function name cannot begin with an 'at sign' (@) or
	      'SQL' and they cannot be the same as the existing SQLBase
	      functions like AVG, COUNT, MAX, MIN, and SUM.

      Remedy: Modify the external function name.

11735 PRS IQC Invalid Sequence Column format

      Reason: Invalid format for psuedo column of a sequence. Sequence can
	      be refered as <sequence-name>.<CURRVAL|NEXTVAL>.

      Remedy: Correct the sql command in question to the correct format.

11736 PRS NAS No Attributes Specified

      Reason: DBATTRIBUTE command does not have any atributes specified.

      Remedy: Correct the sql command to the correct format.

11737 PRS IDA Invalid Database Attribute specified.

      Reason: Attribute name specified in the DBATTRIBUTE command is not a
	      valid attribute name.

      Remedy: Correct the sql command to specify a valid attribute name.

11738 PRS IDV Invalid Database Attribute Value.

      Reason: Attribute value specified in the DBATTRIBUTE command is not a
	      valid attribute value.

      Remedy: Correct the sql command to specify a valid attribute value.

11739 PRS IAT Invalid Alter Trigger option

      Reason: Alter trigger option provided in the command is an invalid
	      option.

      Remedy: Correct the sql command to specify a valid alter trigger
	      option.


11740 PRS EFT Expecting the keywords EXTERNAL FUNCTION or TABLE.

      Reason: The "FOR" keyword in the DROP SYNONYM statement can be
	      followed only by "EXTERNAL FUNCTION" or "TABLE".

      Remedy: Check the syntax for DROP SYNONYM and correct statement.


11741 PRS ICT Invalid CALLSTYLE option.

      Reason: Only STDCALL/CDECL are allowed on 32 bit systems. Only
	      PASCAL/CDECL are allowed on 16 bit systems.

      Remedy: Check the syntax for CREATE/ALTER EXTERNAL FUNCTION and
	      correct statement.

11742 PRS NOA Nothing altered

      Reason: An ALTER EXTERNAL FUNCTION command was specified but no clauses
	      were specified to alter either the library name, external name,
	      export ordinal, or the execute mode.

      Remedy: Modify the alter external function command by specifying the
	      item to be alterd.


11743 PRS TOR Create Trigger ORDER value invalid

      Reason: The ORDER keyword must be followed by a numeric value in the
	      range 0-399 or in the range 600-999.

      Remedy: Correct the Create Trigger statement. Either eliminate the
	      optional ORDER Seq_Num clause, or specify a sequence number
	      in one of the valid ranges.

11744 PRS LTL Identifier too long

      Reason: An identifier exceeds 64 characters.

      Remedy: Correct the identifier that exceeds 64 characters.

11745 PRS SPN Separate process execution not allowed in the 16 bit servers.

      Reason: Separate process execution mode is not supported for external functions in
	      the 16 bit servers.

      Remedy: Use same thread execution model.

11746 PRS PCT Primary key column's datatype cannot be a LONG VARCHAR

      Reason: Column defined in primary key cannot be a LONG VARCHAR

      Remedy: Do not include a LONG VARCHAR column in the primary key.

11747 PRS MST Expecting STRING keyword.

      Reason: The keyword LONG should be followed by STRING.

      Remedy: Add the keyword STRING.

11748 PRS IDT Invalid or missing internal data type

      Reason: Attempting a CREATE EXTERNAL FUNCTION statement and a specified
	      internal data type in the PARAMETERS clause or the RETURNS
	      clause is either invalid, missing, or misspelled.

      Remedy: Correct the SQL statement.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for general SQL
sort type errors that may occur when performing database operations that
require a sort like using the ORDER BY or GROUP BY clauses.
11901 PST 001 Not enough available stack space for psort

      Reason: This error is only used internally by the SQLBase system.

      Remedy: Reason#18

11902 PST 002 Stack overflow in sort

      Reason: Keys agree on too many leading bytes

      Remedy: Reduce number of bytes in sorting keys

11903 PST 003 Segment length too large

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11904 PST 004 Attempt to send record to sort already terminated

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11905 PST 005 Insufficient memory available

      Reason: Sort operation was not able to acquire the minimum required
	      memory to proceed with the sort operation.

      Remedy: Check available memory at the database computer.
	      Attempt to make more memory available.  Also check
	      the value of the 'sortcache' parameter value in sql.ini.
	      Check the documentation to choose apropriate values for this
	      parameter.      Author: 05/20/93 RMR

11906 PST 006 Allocation of psort data stack failed

      Reason: Sort operation was not able to acquire the minimum required
	      memory to proceed with the sort operation.

      Remedy: Check available memory at the database computer.
	      Attempt to make more memory available.  Also check
	      the value of the 'sortcache' parameter value in sql.ini.
	      Check the documentation to choose apropriate values for this
	      parameter.

11907 PST 007 Allocation of sort work area failed

      Reason: Sort operation was not able to acquire the minimum required
	      memory to proceed with the sort operation.

      Remedy: Check available memory at the database computer.
	      Attempt to make more memory available.  Also check
	      the value of the 'sortcache' parameter value in sql.ini.
	      Check the documentation to choose apropriate values for this
	      parameter.

11908 PST 008 Space exhausted while writing work file

      Reason: Available space in temporary file directory is insufficient

      Remedy: Change location for temporary files

11910 PST 010 Error in file read

      Reason: Attempting to read a file and a disk read failure has occurred.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

11911 PST 011 Temporary file name too long

      Reason: Temporary directory environmental variable consists of
	      too many characters

      Remedy: Shorten name of temporary directory in environmental variable

11912 PST 012 Stack overflow in calling psort

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11915 PST 015 Programming error #2 in pstsio.c

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

11917 PST 017 Cannot allocate memory for sorting

      Reason: Sort operation was not able to acquire the minimum required
	      memory to proceed with the sort operation.

      Remedy: Check available memory at the database computer.
	      Attempt to make more memory available.  Also check
	      the value of the 'sortcache' parameter value in sql.ini.
	      Check the documentation to choose apropriate values for this
	      parameter.

11919 PST 019 Couldn't get memory for workfile input buffer

      Reason: Sort operation was not able to acquire the minimum required
	      memory to proceed with the sort operation.

      Remedy: Check available memory at the database computer.
	      Attempt to make more memory available.  Also check
	      the value of the 'sortcache' parameter value in sql.ini.
	      Check the documentation to choose apropriate values for this
	      parameter.

11920 PST 020 Couldn't get memory for workfile output buffer

      Reason: Sort operation was not able to acquire the minimum required
	      memory to proceed with the sort operation.

      Remedy: Check available memory at the database computer.
	      Attempt to make more memory available.  Also check
	      the value of the 'sortcache' parameter value in sql.ini.
	      Check the documentation to choose apropriate values for this
	      parameter.

11922 PST 022 Couldn't open working file for writing

      Reason: Attempting to create a file and a failure has occurred.

      Remedy: Determine and correct the cause of the create failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of disk.  Verify that sufficient disk space is
	      available and verify that the number of files allowed open for
	      the operating system permits the additional file, that is, check
	      the FILES= configuration parameter setting.

11923 PST 023 Couldn't open working file for reading

      Reason: Attempting to read a file and a disk read failure has occurred.

      Remedy: Determine and correct the cause of the disk read failure.  Run a
	      check disk utility (CHKDSK) for the current operating system to
	      verify the status of the disk.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for Control file
object command errors.
12001 CFO MSK Missing SIZE keyword

      Reason: While Reading the control file a system was looking for a
	      keyword named "SIZE", but could not find it.

      Remedy: Control file needs a SIZE keyword infront of the maximum
	      allowed file size for this unload segment. Look into the
	      manual for the syntax of control file

12002 CFO MSZ Missing/Inappropriate SIZE value

      Reason: While Reading the control file a system was looking for a
	      value for size after the "SIZE" keyword, but could not find it
	      OR found an inapropriate value such as a non integer value
	      or a value outside the range 1-2048 inclusive.

      Remedy: Control file needs a SIZE value for of the maximum
	      allowed file size for this unload segment. Look into the
	      manual for the syntax of control file and provide a correct
	      size.

12003 CFO MDK Missing DIR keyword

      Reason: While Reading the control file a system was looking for a
	      keyword named "DIR", but could not find it.

      Remedy: Control file needs a DIR keyword in front of the directory
	      path value for each unload or database backup segment. Look
	      into the manual for the syntax of control file

12004 CFO MDR Missing DIR value

      Reason: While Reading the control file a system was looking for a
	      value for directory after the "DIR" keyword, but could not
	      find it.

      Remedy: Control file needs a directory value after the DIR keyword
	      for specifying the path value for this unload or database backup
	      segment. Look into the manual for the syntax of control file.

12005 CFO FAE Segment File already exists.

      Reason: The Load/Unload or Backup/Restore segment file already exists.

      Remedy: A file of the specified name already exists in the
	      path specified. If you want to overwrite this file, use the
	      OVERWRITE option in the Unload command.

12006 CFO OPE Error Opening load/unload or backup/restore segment file.

      Reason: Attempting to load or unload the database from/to
	      or to backup or restore from/to a file but
	      the named segmented file cannot be opened.

      Remedy: If the file name was specified, check that the file name is
	      correct.	If the file name is correct or if its not necessary
	      to specify a file name, determine why the file could not be
	      opened. Also, in case of segemnted load or restore operation,
	      make sure that all the segment files mentioned in the
	      control file are present.

12007 CFO LTL Line Too Long

      Reason: Attempting to read a line from the control file, which is
	      too long.

      Remedy: Control file needs to be written using the exact syntax
	      mentioned in the manual. Here the line that was read from the
	      control file exceeded the maximum allowable line length.
	      Correct the control file and reexecute the command.

12008 CFO MPK Missing FILEPREFIX keyword

      Reason: While Reading the control file a system was looking for a
	      keyword named "FILEPREFIX", but could not find it.

      Remedy: Control file needs a FILEPREFIX keyword infront of the
	      fileprefix value to be used with all the unload or database
	      backup segments.
	      Look into the manual for the syntax of control file.

12009 CFO MPX Missing FILEPREFIX value

      Reason: While Reading the control file a system was looking for a
	      value for fileprefix after the "FILEPREFIX" keyword, but
	      could not find it.

      Remedy: Control file needs a fileprefix value after of the FILEPREFIX
	      keyword
	      for specifying the fileprefix value to be used with all the
	      unload segments. Look into the manual for the syntax of
	      control file.

12010 CFO NFS Not enough file segments

      Reason: Unload/Load command is looking for more file segments in the
	      control file but could not find one. It is possible that the
	      unload data is overflowing all the given file segments of
	      specified size and needs more disk space/file segments to
	      complete the unload operation.

      Remedy: Edit the unload control file to increase the number of segments
	      or the size of the file segments to accomodate all the unload
	      data. See the manual for segmented unload and control file
	      syntax.

12011 CFO CAM Cannot allocate memory

      Reason: Control file processor was not able to allocate memory for
	      some internal structures.

      Remedy: Check available memory resources available for SQLBase on
	      your machine.

12012 CFO DBS Cannot get database size for testing

      Reason: Backup could not obtain database size to determine whether there
	      were sufficient backup file segments to cover the backup.

      Remedy: This is an internal error which should not occur.  Call your service
	      representative.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide
are associated with buffered files.
12101 GBS 001 Couldn't get memory for file structure

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

12102 GBS 002 Couldn't get memory for file buffer

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

12103 GBS 003 Seek from end of file not supported

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

12201 TRC CCF Cannot create file, <filename>

      Reason: Unknown

      Remedy: Check filename


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are generated by
the Daemon module.
12301 DMN CAD 008 - Out of memory at the database computer (DMN CAD)

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

12302 DMN BIP Internal error: Invalid interval parameter passed in to Daemon
	      facility

      Reason: This error is only used internally by the SQLBase system.

      Remedy: None.  This error code should never occur.  If you get this
	      error, contact your local Centura Software Corporation
	      certified technical support center.

12401 TLE REG Could Not Provide Registration Handle

      Reason:

      Remedy:

12402 TLE LNK Register Could Not Allocate Link Structure

      Reason:

      Remedy: Try Registering Again ???

12403 TLE TSK Register Could Not Allocate Task Structure

      Reason:

      Remedy: Try Registering Again ???

12404 TLE TLK Register Could Not Allocate Talk Structure

      Reason:

      Remedy: Try Registering Again ???

12405 TLE CUV Register Could Not Allocate Cursor Vector

      Reason:

      Remedy: Try Registering Again ???

12406 TLE CMD Register Could Not Allocate Command Buffer

      Reason:

      Remedy: Try Registering Again ???

12407 TLE CIS Could Not Allocate Connect Info Sturcture

      Reason:

      Remedy:

12408 TLE SIS Could Not Allocate Session Info Structure

      Reason:

      Remedy:

12409 TLE WKB Register Could Not Allocate Work Buffer

      Reason:

      Remedy: Try Registering Again ???

12410 TLE 010																							      /*	MsgTxt:

      Reason:

      Remedy:

12411 TLE TNR Task Not Registered To The Engine

      Reason: A task attempted to execute an engine command without
	      previously registering themself.

      Remedy: The task must call tlereg(...) and register themself.

12412 TLE TIH Task Invalid Handle

      Reason: A task attempted to execute with an invalid handle

      Remedy: The task must use a valid handle given to it from tlereg.

12413 TLE TRE Task Reentrancy Error

      Reason: A task attempted to enter the engine an unallowable number
	      of times.

      Remedy: The task must wait until the engine returns from its last
	      invocation.

12414 TLE HRE Handle Reentrancy Error

      Reason: A handle attempted to enter the engine when it's task

      Remedy: The task must wait until the engine returns from its last
	      invocation.

12415 TLE SPE Spool File Exists, Instructed Not To Create

      Reason: The spool file instructed to turn on exists and api was
	      was instructed to error on exists

      Remedy: Change spool file name, instruct api to append/overwrite

12416 TLE ASE Allocated Space Error - Not Enough To Perform Operation

      Reason: A blob of memory passed was not large enough to
	      process the command.

      Remedy: Pass in a larger blob.

12417 TLE FTS Failed To Set

      Reason: An API call was made to set a value and it could not
	      and no other reason was given or could be given.

      Remedy: Try Again?

12418 TLE BNL Block Not Large Enough to Hold Data

      Reason:

      Remedy: Try Again With A block of the correct size.

12419 TLE BTL Block Too Large. Incorrect Size.

      Reason:

      Remedy: Try Again With A block of the correct size.

12420 TLE 020																							      /*	MsgTxt:

      Reason:

      Remedy:

12421 TLE CNA Connection Not Available

      Reason: Maximum Number of Connections (255) Have Already
	      Been Established.

      Remedy: Disconnect Any Connection.

12422 TLE OPF Error Openeing Output File

      Reason: Output File Could Not Be Opened For Writing

      Remedy: Rerun Batch/Regression After Making sure output file
	      can be written to.

12423 TLE AFB Error Allocation Fetch Buffer

      Reason: Fetch Buffer Could Not Be Allocated

      Remedy:


12424 TLE AWB Error Allocation Work Buffer

      Reason: Work Buffer Could Not Be Allocated

      Remedy:


12425 TLE UAB Unable To Allocate Buffer

      Reason: Buffer Could Not Be Allocated (TleBuf)

      Remedy:


12426 TLE BNA Buffer Not Available

      Reason: Too Many Buffers Already Allocated and Not
	      Released. (TleBuf)

      Remedy: Report error to Centura Software Corporation technical support.

12427 TLE CNR Callback not Registered

      Reason: Callback needed to complete the operation has not been
	      registered.

      Remedy: Report error to Centura Software Corporation technical support.

12428 TLE STS Size Too Small

      Reason: Size of Line is Too Small to work with.  Use a larger size.

      Remedy: Report error to Centura Software Corporation technical support.


1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide occur only at
Stored-Procedure execution time.
12501 SPE CLL Cannot load libarary <name>

      Reason: An attempt to load a dynamically linked library failed.

      Remedy: Check to make sure that library exists and is not corrupt.

12502 SPE GPA Cannot get address for external function <name>

      Reason: An attempt to get the address for an external function failed.

      Remedy: Check to make sure that the function exists and/or its ordinal
	      number is correct.

12503 SPE RTL Returned string too long.

      Reason: When a string is passed as a receive parameter to an external
	      function, the modified string returned to the stored
	      procedure cannot be longer than the original string..

      Remedy: Check your external function to make sure that the string
	      manipulation is correct.

12504 SPE EFE Error number <number> occurred in external function <name>.

      Reason: An error occurred during execution of an external function.

      Remedy: Check your external function code for correctness.

12505 SPE RSL Receive string too long.

      Reason: RECEIVE STRING parameters can not exceed 254 characters.

      Remedy: Use RECEIVE LONG STRING datatype. The parameter will then
	      be treated as a LONG VARCHAR column.

1.0.0 SQLBase Errors Guide
The errors documented in this section of the Error Guide are for Sequence
objects in SQLBase.

12601 SEQ USA Uninitialized Sequence Access.

      Reason: Within a transaction session a SEQUENCE.CURRVAL was used
	      before the sequence was initialized with a call to the
	      SEQUENCE.NEXTVAL.

      Remedy: Make sure that within a user transaction session, the sequence
	      is initialized first with atleast one call to SEQUENCE.NEXTVAL
	      before accessing the CURRVAL for the sequence.

12602 SEQ OOM Out Of Memory at the database computer.

      Reason: Not enough memory at the database engine to perform the
	      requested task.

      Remedy: Check available memory at the database computer.	Attempt to
	      make more memory available.  To make more memory available for
	      the database engine, you can reduce size of the CACHE.

