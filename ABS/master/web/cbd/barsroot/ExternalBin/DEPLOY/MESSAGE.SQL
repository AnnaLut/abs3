/* COPYRIGHT (C) GUPTA CORPORATION 1984-1996 */
/*
CONSTANTS
  mes - MESsage table
*/
/*
REVISION HISTORY
  02/13/90 GTI original
DESCRIPTION
  This file defines not only the message table constants to be used but
  also the actual text of the individual messages. The messages are defined
  in the comment field for each message define and should be enclosed in
  double quotes. Preceeding the message string is a message parameter
  area where the following parameters can appear:

    T - this is a SQLTalk message
    S - this is a SQLBASE server message
    X<n> - X-coordinate for this message (not valid for all messages)
    Y<n> - Y-coordinate for this message (not valid for all messages)

  Foreign language translators should only modify the actual text of the
  messages. The X- and Y-coordinates may need to be modified if the
  size of the translated text gets significantly larger, but this should be
  done with help from the Gupta Software Development Department.

  After the message parameters, we expect to find one or more double quoted
  strings which will be concatenated together to form the complete message.
  Long messages can be broken up over several lines as long as each line of
  the message is in double quotes.
*/

/* 6.1.2 */

#define TLSXXX1     1 /* T "UNUSED UNUSED UNUSED UNUSED UNUSED UNUSED "     */
#define TLSBLK1     2 /* T "\nBULK EXECUTE IS NOW ON\n"                     */
#define TLSBOO1     3 /* T "\nAUTOCOMMIT IS NOW ON\n"                       */
#define TLSBOO2     4 /* T "\nAUTOCOMMIT IS NOW OFF\n"                      */
#define TLSBOO3     5 /* T "\nDB2 COMPATIBILITY MODE IS NOW ON\n"           */
#define TLSBOO4     6 /* T "\nDB2 COMPATIBILITY MODE IS NOW OFF\n"          */
#define TLSBOO5     7 /* T "\nLOG BACKUP IS NOW ON\n"                       */
#define TLSBOO6     8 /* T "\nLOG BACKUP IS NOW OFF\n"                      */
#define TLSBOO7     9 /* T "\nPRESERVECONTEXT IS NOW ON\n"                  */
#define TLSBOO8    10 /* T "\nPRESERVECONTEXT IS NOW OFF\n"                 */
#define TLSCNM1    11 /* T "\nCURSOR NAME SET TO %s\n"                      */
#define TLSCSI1    12 /* T "\nCOMMAND SIZE set\n"                           */
#define TLSFRO1    13 /* T "\nFILTER ROW SET TO %d\n"                       */
#define TLSIMS1    14 /* T "\nINPUT MESSAGE SIZE SET\n"                     */
#define TLSISO1    15 /* T "\nISOLATION LEVEL HAS BEEN SET\n"               */
#define TLSOMS1    16 /* T "\nOUTPUT MESSAGE SIZE SET\n"                    */
#define TLSRCV1    17 /* T "\nRECOVERY IS ALREADY ENABLED\n"                */
#define TLSRCV2    18 /* T "\nRECOVERY IS ALREADY DISABLED\n"               */
#define TLSRCV3    19 /* T "\nRECOVERY IS NOW ENABLED\n"                    */
#define TLSRCV4    20 /* T "\nRECOVERY IS NOW DISABLED\n"                   */
#define TLSSCR1    21 /* T "\nSCROLL CURSOR ROW SET TO %d\n"                */
#define TLSSDB1    22 /* T "DATABASES ON SERVER: %s\n"                      */
#define TLSSDB2    23 /* T "LOCAL DATABASES:\n"                             */
#define TLSSPO1    24 /* T "SPOOLING STARTED\n"                             */
#define TLSXXX2    25 /* T "UNUSED UNUSED UNUSED UNUSED UNUSED UNUSED "     */
#define TLSTIO1    26 /* T "\nTIMEOUT SET TO %d SECOND\n"                   */
#define TLSTIO2    27 /* T "\nTIMEOUT SET TO %d SECONDS\n"                  */
#define TLPCRE1    28 /* T "DATABASE CREATED\n"                             */
#define TLPCRE2    29 /* T "\nDatabase already exists.  Overwrite it (Y/N)? " */
#define TLPCRE3    30 /* T "CREATE ABORTED\n"                               */
#define TLPDEC1    31 /* T "DATABASE DEINSTALLED\n"                         */
#define TLPDEL1    32 /* T "DATABASE DELETED\n"                             */
#define TLPDIS1    33 /* T "CURSOR %d DISCONNECTED"                         */
#define TLPINS1    34 /* T "DATABASE INSTALLED\n"                           */
#define TLPLDV1    35 /* ST "\nLOAD VERSION HAS BEEN SET\n"                 */
#define TLPMSG1    36 /* T
"\n The log file %ld.LOG could not be found. Use the RESTORE LOGS command"
"\n to restore this log and continue the rollforward process. If this log"
"\n is not available,use the ROLLFORWARD <database> END command to complete"
"\n the recovery process.\n" */
#define TLSBOO9    37 /* T "\nROLLBACK ON TIMEOUT IS NOW ON\n"              */
#define TLSBOO10   38 /* T "\nROLLBACK ON TIMEOUT IS NOW OFF\n"             */
#define TLPPAU1    39 /* T "\n< PRESS RETURN TO CONTINUE >\n"               */
#define TLPPER1    40 /* T "\nSTATEMENT PERFORMED"                          */
#define TLPPRE1    41 /* T "\nSTATEMENT PREPARED"                           */
#define TLPREL1    42 /* T "RELEASE LOG COMPLETED\n"                        */
#define TLPREM1    43 /* T "SQL> "                                          */
#define TLPREO1    44 /* TS "UNLOAD COMPLETED\n"                            */
#define TLPREO2    45 /* T "INITIALIZING DATABASE\n"                        */
#define TLPROF1    46 /* T "ROLLFORWARD CONTINUED\n"                        */
#define TLPROF2    47 /* T "ROLLFORWARD STARTED\n"                          */
#define TLPROF3    48 /* T "ROLLFORWARD COMPLETED\n"                        */
#define TLPSDP1    49 /* T "\nCHECKPOINT TIME INTERVAL HAS BEEN SET\n"      */
#define TLPSDP2    50 /* T "\nLOG FILE SIZE HAS BEEN SET\n"                 */
#define TLPSDP3    51 /* T "\nREADONLY MODE HAS BEEN DISABLED\n"            */
#define TLPSDP4    52 /* T "\nREADONLY MODE HAS BEEN ENABLED\n"             */
#define TLPSDP5    53 /* T "\nREADONLY MODE HAS BEEN SET TO DEFAULT\n"      */
#define TLPSDP6    54 /* T "\nHISTORY FILE SIZE HAS BEEN SET\n"             */
#define TLPSDP7    55 /* T "\nLOG FILE PREALLOCATION HAS BEEN ENABLED\n"    */
#define TLPSDP8    56 /* T "\nLOG FILE PREALLOCATION HAS BEEN DISABLED\n"   */
#define TLPSDP9    57 /* T "\nTRANSACTION SPAN LIMIT HAS BEEN SET\n"        */
#define TLPSDP10   58 /* T "\nSERVER PRINT LEVEL HAS BEEN SET\n"            */
#define TLPSDP11   59 /* T "\nSERVER ACTIVITY LOG HAS BEEN ENABLED\n"       */
#define TLPSDP12   60 /* T "\nSERVER ACTIVITY LOG HAS BEEN DISABLED\n"      */
#define TLPSDP13   61 /* T "\nSERVER TIMESTAMP HAS BEEN ENABLED\n"          */
#define TLPSDP14   62 /* T "\nSERVER TIMESTAMP HAS BEEN DISABLED\n"         */
#define TLPSHO1    63 /* T "\n***** "                                       */
#define TLPSHO2    64 /* T "AUTOCOMMIT is ON "                              */
#define TLPSHO3    65 /* T "AUTOCOMMIT is OFF "                             */
#define TLPSHO4    66 /* T "BELL is ON "                                    */
#define TLPSHO5    67 /* T "BELL is OFF "                                   */
#define TLPSHO6    68 /* T "BOTTOM MARGIN is %d "                           */
#define TLPSHO7    69 /* T "\n*****\n"                                      */
#define TLPSHO8    70 /* T "NUMBER OF CACHE PAGES is %s "                   */
#define TLPSHO9    71 /* T "CHECKPOINT (Time Interval) is %d MINUTE "       */
#define TLPSHO10   72 /* T "CHECKPOINT (Time Interval) is %d MINUTES "      */
#define TLPSHO11   73 /* T "COMMAND SIZE is %d "                            */
#define TLPSHO12   74 /* T "\nUsername: %s\nDatabase: %s\nCursor number:  %d\n" */
#define TLPSHO13   75 /* T "CURSOR SIZE is no longer available "            */
#define TLPSHO14   76 /* T "DATETIME PICTURE is '%s' "                      */
#define TLPSHO15   77 /* T "DATE PICTURE is '%s' "                          */
#define TLPSHO16   78 /* T "TIME PICTURE is '%s' "                          */
#define TLPSHO17   79 /* T "DB2 COMPATIBILITY MODE is ON "                  */
#define TLPSHO18   80 /* T "DB2 COMPATIBILITY MODE is OFF "                 */
#define TLPSHO19   81 /* T "ERRORLEVEL is %d "                              */
#define TLPSHO20   82 /* T "UNUSED "                                        */
#define TLPSHO21   83 /* T "DECHO is ON "                                   */
#define TLPSHO22   84 /* T "DECHO is OFF "                                  */
#define TLPSHO23   85 /* T "DEVICE LINE SIZE is %d "                        */
#define TLPSHO24   86 /* T "ECHO is ON "                                    */
#define TLPSHO25   87 /* T "ECHO is OFF "                                   */
#define TLPSHO26   88 /* T "ETIME is ON "                                   */
#define TLPSHO27   89 /* T "ETIME is OFF "                                  */
#define TLPSHO28   90 /* T "DEFAULT HEADINGS are ON "                       */
#define TLPSHO29   91 /* T "DEFAULT HEADINGS are OFF "                      */
#define TLPSHO30   92 /* T "LINEWRAP INDENTION is %d "                      */
#define TLPSHO31   93 /* T "NO LINEWRAP INDENTION "                         */
#define TLPSHO32   94 /* T "INPUT MESSAGE SIZE IS %u "                      */
#define TLPSHO33   95 /* T "ISOLATION LEVEL is %s "                         */
#define TLPSHO34   96 /* T "FILTERING is ON "                               */
#define TLPSHO35   97 /* T "FILTERING is OFF "                              */
#define TLPSHO36   98 /* T "LIMIT is %u "                                   */
#define TLPSHO37   99 /* T "NO LIMIT "                                      */
#define TLPSHO38  100 /* T "LOADBUFFER SIZE is %d "                         */
#define TLPSHO39  101 /* T "LOAD VERSION is %s "                            */
#define TLPSHO40  102 /* T "LONG DISPLAY OFFSET is %u "                     */
#define TLPSHO41  103 /* T "\nLOG PARAMETER SETTINGS:\n"                    */
#define TLPSHO42  104 /* T "\n  LOGFILESIZE is %s KBYTES "                  */
#define TLPSHO43  105 /* T "\n  CHECKPOINT (Time Interval) is %d MINUTE "   */
#define TLPSHO44  106 /* T "\n  CHECKPOINT (Time Interval) is %d MINUTES "  */
#define TLPSHO45  107 /* T "\n  LOGBACKUP (Log Backup Mode) is ON "         */
#define TLPSHO46  108 /* T "\n  LOGBACKUP (Log Backup Mode) is OFF "        */
#define TLPSHO47  109 /* T "\n  LOGFILEPREALLOC is ON "                     */
#define TLPSHO48  110 /* T "\n  LOGFILEPREALLOC is OFF "                    */
#define TLPSHO49  111 /* T "\n  SPANLIMIT (Transaction Span Limit) is %s LOG FILE " */
#define TLPSHO50  112 /* T "\n  SPANLIMIT (Transaction Span Limit) is %s LOG FILES " */
#define TLPSHO51  113 /* T "LOGBACKUP (Log Backup Mode) is ON "             */
#define TLPSHO52  114 /* T "LOGBACKUP (Log Backup Mode) is OFF "            */
#define TLPSHO53  115 /* T "LOGFILESIZE is %s KBYTES "                      */
#define TLPSHO54  116 /* T "LOGFILEPREALLOC is ON "                         */
#define TLPSHO55  117 /* T "LOGFILEPREALLOC is OFF "                        */
#define TLPSHO56  118 /* T "SPANLIMIT (Transaction Span Limit) is %s LOG FILE " */
#define TLPSHO57  119 /* T "SPANLIMIT (Transaction Span Limit) is %s LOG FILES " */
#define TLPSHO58  120 /* T "LONG DISPLAY LENGTH is %u "                     */
#define TLPSHO59  121 /* T "LINE SIZE is %d "                               */
#define TLPSHO60  122 /* T "LINESPACE is %d "                               */
#define TLPSHO61  123 /* T "LINEWRAP is ON "                                */
#define TLPSHO62  124 /* T "LINEWRAP is OFF "                               */
#define TLPSHO63  125 /* T "LEFT MARGIN is %d "                             */
#define TLPSHO64  126 /* T "NULLS replaced by %s "                          */
#define TLPSHO65  127 /* T "NULLS replaced by blanks "                      */
#define TLPSHO66  128 /* T "OUTPUT MESSAGE SIZE IS %u "                     */
#define TLPSHO67  129 /* T "PAGE SIZE is %d "                               */
#define TLPSHO68  130 /* T "PAUSE is ON "                                   */
#define TLPSHO69  131 /* T "PAUSE is OFF "                                  */
#define TLPSHO70  132 /* T "PLANONLY is ON "                                */
#define TLPSHO71  133 /* T "PLANONLY is OFF "                               */
#define TLPSHO72  134 /* T "RECOVERY is ON "                                */
#define TLPSHO73  135 /* T "RECOVERY is OFF "                               */
#define TLPSHO74  136 /* T "ROLLBACK (transaction on lock timeout) is ON "  */
#define TLPSHO75  137 /* T "ROLLBACK (transaction on lock timeout) is OFF " */
#define TLPSHO76  138 /* T "RESULT SET ROWCOUNT is %s "                     */
#define TLPSHO77  139 /* T "UNUSED "                                        */
#define TLPSHO78  140 /* T "SERVER ACTIVITY LOG IS %s "                     */
#define TLPSHO79  141 /* T "SERVER ACTIVITY LOG IS OFF "                    */
#define TLPSHO80  142 /* T "SERVER PRINT LEVEL IS %s "                      */
#define TLPSHO81  143 /* T "SERVER TIMESTAMP IS ON "                        */
#define TLPSHO82  144 /* T "SERVER TIMESTAMP IS OFF "                       */
#define TLPSHO83  145 /* T "\nheap size: %s\nconnected to %s\n"             */
#define TLPSHO84  146 /* T "RIGHT MARGIN is %d "                            */
#define TLPSHO85  147 /* T "SCREEN is ON "                                  */
#define TLPSHO86  148 /* T "SCREEN is OFF "                                 */
#define TLPSHO87  149 /* T "Fully qualified column name is %s "             */
#define TLPSHO88  150 /* T "SPACE between columns is %d "                   */
#define TLPSHO89  151 /* T "SPOOL file is %s "                              */
#define TLPSHO90  152 /* T "SPOOL file is OFF "                             */
#define TLPSHO91  153 /* T "TCOUNT is ON "                                  */
#define TLPSHO92  154 /* T "TCOUNT is OFF "                                 */
#define TLPSHO93  155 /* T "TIME is ON "                                    */
#define TLPSHO94  156 /* T "TIME is OFF "                                   */
#define TLPSHO95  157 /* T "wait TIMEOUT is -1 seconds (infinite) "         */
#define TLPSHO96  158 /* T "wait TIMEOUT is %d second "                     */
#define TLPSHO97  159 /* T "wait TIMEOUT is %d seconds "                    */
#define TLPSHO98  160 /* T "TOP MARGIN is %d "                              */
#define TLPSHO99  161 /* T "PRESERVECONTEXT is ON "                         */
#define TLPSHO100 162 /* T "PRESERVECONTEXT is OFF "                        */
#define TLPSHO101 163 /* T "READONLY mode is ENABLED "                      */
#define TLPSHO102 164 /* T "READONLY mode is DISABLED "                     */
#define TLPSHO103 165 /* T "READONLY mode is DEFAULT (i.e configuration file value) " */
#define TLPSHO104 166 /* T "HISFILESIZE (History File Size) is %s Kbytes "  */
#define TLPSHO105 167 /* T "BULK EXECUTION MODE is ON "                     */
#define TLPSHO106 168 /* T "BULK EXECUTION MODE is OFF "                    */
#define TLPSHO107 169 /* T "VERSION is %s "                                 */
#define TLPSHO108 170 /* T "*****\n"                                        */
#define TLPSRV1   171 /* T "SERVER IS OFF\n"                                */
#define TLPSRV2   172 /* T "SERVER IS SET\n"                                */
#define TLPUND1   173 /* T "\nUNDO COMPLETED\n"                             */
#define TLUULD1   174 /* T "STARTING TO UNLOAD\n"                           */
#define TLUULD2   175 /* T "UNLOAD COMPLETED"                               */
#define TLUUSQ1   176 /* T "SQLTALK: %s.%s DOES NOT EXIST\n"                */
#define TLUUSQ2   177 /* ST "\n UNLOADING %s ROWS FROM TABLE %s.%s\n"       */
#define TLUUSQ3   178 /* TS "   %s ROWS UNLOADED\r"                         */
#define TLKBAC1   179 /* T "\nROWS IN REVERSE ORDER\n"                      */
#define TLKBAS1   180 /* T "\07"                                            */
#define TLKBAS2   181 /* T "***** TEST %d\n"                                */
#define TLKBEX1   182 /* ST "\n PROCESSING DATA\n\n"                        */
#define TLKBIR1   183 /* T "Bulk Insert Error on row #%d\n"                 */
#define TLKBKP1   184 /* T "\nBackup file already exists.  Overwrite it (Y/N)? " */
#define TLKBKP2   185 /* T "BACKUP ABORTED\n"                               */
#define TLKBKP3   186 /* T "DATABASE BACKED UP\n"                           */
#define TLKBKP4   187 /* T "%s LOG BACKED UP\n"                             */
#define TLKBKP5   188 /* T "%s LOGS BACKED UP\n"                            */
#define TLKBKP6   189 /* T "SNAPSHOT BACKED UP\n"                           */
#define TLKCFC1   190 /* T "***** The total of %s for this %s is %g"        */
#define TLKCFC2   191 /* T "***** The minimum value in %s can NOT be found for this %s" */
#define TLKCFC3   192 /* T "***** The minimum value in %s for this %s is %g" */
#define TLKCFC4   193 /* T "***** The average of %s can NOT be found for this %s" */
#define TLKCFC5   194 /* T "***** The average of %s for this %s is %g"      */
#define TLKCFC6   195 /* T "***** The maximum value in %s can NOT be found for this %s" */
#define TLKCFC7   196 /* T "***** The maximum value in %s for this %s is %g" */
#define TLKCFC8   197 /* T "***** The number of items in %s for this %s is %g" */
#define TLKCLO1   198 /* T "SQL> "                                          */
#define TLKCPY1   199 /* T "\n%s ROW COPIED\n"                              */
#define TLKCPY2   200 /* T "\n%s ROWS COPIED\n"                             */
#define TLKCTC1   201 /* T "\nProgram terminated by user - All transactions being rolled back\n" */
#define TLKDRV1   202 /* T "\n< PRESS RETURN TO EXECUTE >\n"                */
#define TLKERA1   203 /* T "COMMAND ERASED\n"                               */
#define TLKESF1   204 /* T "FILTER SAVED\n"                                 */
#define TLKESF2   205 /* T "FILTER ERASED\n"                                */
#define TLKFET1   206 /* T "%s.%02ld SECONDS TO FETCH FIRST ROW\n\n"        */
#define TLKGCM1   207 /* T "Enter a SQL command\n\n"                        */
#define TLKGCM2   208 /* T "SQL> "                                          */
#define TLKGCN1   209 /* T "column %d"                                      */
#define TLKGCN2   210 /* T "the entire report"                              */
#define TLKIGN1   211 /* T "Data and/or command being skipped\n"            */
#define TLKLCV1   212 /* ST "LOADING TABLE %s.%s\n"                         */
#define TLKLDI1   213 /* T "LOADING TABLE %s.%s\n"                          */
#define TLKLOA1   214 /* T "WKS format type is still under construction!\n" */
#define TLKLOS1   215 /* T "STARTING TO LOAD\n"                             */
#define TLKLOS2   216 /* T "\nLOAD FAILURE - TRANSACTION ROLLED BACK\n"     */
#define TLKLOS3   217 /* T "LOAD COMPLETED"                                 */
#define TLKOAF1   218 /* T "FILE ALREADY EXISTS"                            */
#define TLKOAF2   219 /* T "Enter 'C' to Continue or 'P' to apPend or 'A' to Abort" */
#define TLKOAF3   220 /* T "CAP"                                            */
#define TLKOTF1   221 /* T "FILE ALREADY EXISTS"                            */
#define TLKPAT1   222 /* T "Page %d"                                        */
#define TLKPER1   223 /* T "\nSTATEMENT PERFORMED\n"                        */
#define TLKPEW1   224 /* T "Warning: %s (transaction rolled back)\n"        */
#define TLKPEW2   225 /* T "Warning: %s\n"                                  */
#define TLKPEW3   226 /* T "Error: %s (transaction rolled back)\n"          */
#define TLKPEW4   227 /* T "Error: %s\n"                                    */
#define TLKPLP1   228 /* T "LOADING TABLE %s.%s\n"                          */
#define TLKPLR1   229 /* ST "%s ROWS LOADED.\n"                             */
#define TLKPLR2   230 /* T "%s ROWS LOADED\r"                               */
#define TLKPLP2   231 /* T "CREATING INDEX %s.%s\n"                         */
#define TLKPMU1   232 /* T "CA"                                             */
#define TLKPMU2   233 /* T "ENTER 'C' TO CONTINUE OR 'A' TO ABORT"          */
#define TLKPRC1   234 /* T "UNUSED"                                         */
#define TLKPRC2   235 /* T "INITIALIZING DATABASE\n"                        */
#define TLKPRP1   236 /* T "\nSTATEMENT PREPARED\n"                         */
#define TLKPSB1   237 /* T "\nBREAK ON "                                    */
#define TLKPSB2   238 /* T "REPORT "                                        */
#define TLKPSB3   239 /* T "\nNo breaks are set"                            */
#define TLKPSI1   240 /* T "\nISOLATION LEVEL HAS BEEN SET\n"               */
#define TLKPSM1   241 /* T "\n%s ROW%s SELECTED"                            */
#define TLKPSM2   242 /* T "\n%s ROW%s INSERTED"                            */
#define TLKPSM3   243 /* T "\nTABLE CREATED"                                */
#define TLKPSM4   244 /* T "\n%s ROW%s UPDATED"                             */
#define TLKPSM5   245 /* T "\n%s ROW%s DELETED"                             */
#define TLKPSM6   246 /* T "\nINDEX CREATED WITH %s ROW%s"                  */
#define TLKPSM7   247 /* T "\nINDEX DROPPED"                                */
#define TLKPSM8   248 /* T "\nTABLE DROPPED"                                */
#define TLKPSM9   249 /* T "\nTRANSACTION COMMITTED"                        */
#define TLKPSM10  250 /* T "\nTRANSACTION ROLLED BACK"                      */
#define TLKPSM11  251 /* T "\nCOLUMN(S) ADDED"                              */
#define TLKPSM12  252 /* T "\nCOLUMN(S) DROPPED"                            */
#define TLKPSM13  253 /* T "\nTABLE RENAMED"                                */
#define TLKPSM14  254 /* T "\nCOLUMN(S) RENAMED"                            */
#define TLKPSM15  255 /* T "\nCOLUMN(S) MODIFIED"                           */
#define TLKPSM16  256 /* T "\nPRIVILEGE(S) GRANTED ON TABLE OR VIEW"        */
#define TLKPSM17  257 /* T "\nDBA AUTHORITY GRANTED"                        */
#define TLKPSM18  258 /* T "\nCONNECT AUTHORITY GRANTED"                    */
#define TLKPSM19  259 /* T "\nRESOURCE AUTHORITY GRANTED"                   */
#define TLKPSM20  260 /* T "\nPRIVILEGE(S) REVOKED ON TABLE"                */
#define TLKPSM21  261 /* T "\nDBA AUTHORITY REVOKED"                        */
#define TLKPSM22  262 /* T "\nCONNECT AUTHORITY REVOKED"                    */
#define TLKPSM23  263 /* T "\nRESOURCE AUTHORITY REVOKED"                   */
#define TLKPSM24  264 /* T "\nCOMMENT UPDATED"                              */
#define TLKPSM25  265 /* T "\nPOSTED"                                       */
#define TLKPSM26  266 /* T "\nPROCESSES POSTED"                             */
#define TLKPSM27  267 /* T "\nSYNONYM CREATED"                              */
#define TLKPSM28  268 /* T "\nSYNONYM DROPPED"                              */
#define TLKPSM29  269 /* T "\nVIEW CREATED"                                 */
#define TLKPSM30  270 /* T "\nVIEW DROPPED"                                 */
#define TLKPSM31  271 /* T "\n%s ROW%s IN TABLE"                            */
#define TLKPSM32  272 /* T "\nPASSWORD ALTERED"                             */
#define TLKPSM33  273 /* T "\nLABEL ADDED"                                  */
#define TLKPSM34  274 /* T "\n%s ROW%s PROCESSED"                           */
#define TLKPSM35  275 /* T "\nTABLE REPAIRED, %s REPAIR%s MADE"             */
#define TLKPSM36  276 /* T "\nSAVEPOINT CREATED"                            */
#define TLKPSM37  277 /* T "\nTRANSACTION ROLLED BACK TO SAVEPOINT"         */
#define TLKPSM38  278 /* T "\nSTATISTICS UPDATED ON %s ROW%s"               */
#define TLKPSM39  279 /* T "\nDATABASE CHECKED"                             */
#define TLKPSM40  280 /* T "\nUNKNOWN COMMAND PROCESSED (command type: %d)" */
#define TLKPSR1   281 /* T "\nDEVICE LINE SIZE:%3d     LINE SIZE:%3d  PAGE SIZE:%d\n" */
#define TLKPSR2   282 /* T "SPACE between columns:%d  LINE WRAP:%-3s  HEADINGS:%s\n" */
#define TLKPSR3   283 /* T "LINESPACE:%d\n"                                 */
#define TLKPSR4   284 /* T "MARGINS are TOP:%d  BOTTOM:%d  LEFT:%d  RIGHT:%d\n" */
#define TLKPSR5   285 /* T "LINEWRAP INDENTION is %d "                      */
#define TLKPSR6   286 /* T "NO LINEWRAP INDENTION "                         */
#define TLKPSR7   287 /* T " LIMIT is %d "                                  */
#define TLKPSR8   288 /* T " NO LIMIT "                                     */
#define TLKPSR9   289 /* T " NULLS replaced by %s "                         */
#define TLKPSR10  290 /* T " NULLS replaced by blanks "                     */
#define TLKPSR11  291 /* T "\nTTITLE is ON\n"                               */
#define TLKPSR12  292 /* T "\nTTITLE is OFF\n"                              */
#define TLKPSR13  293 /* T "\nColumn Width Print Dup Newpage Subtitle Wrap Adjust Picture" */
#define TLKPSR14  294 /* T "LEFT  "                                         */
#define TLKPSR15  295 /* T "CENTER"                                         */
#define TLKPSR16  296 /* T "RIGHT "                                         */
#define TLKPSR17  297 /* T "ON "                                            */
#define TLKPSR18  298 /* T "OFF"                                            */
#define TLKPSR19  299 /* T "%2d "                                           */
#define TLKPSR20  300 /* T "\n%4d    %-6s%-5s%-6s%-9s%-6s%-5s%-7s%-18s"     */
#define TLKPSR21  301 /* T "\n%s%s%s%s%s%s"                                 */
#define TLKPSR22  302 /* T "   Alias:"                                      */
#define TLKPSR23  303 /* T "   Heading:"                                    */
#define TLKPSR24  304 /* T "   Nulls:"                                      */
#define TLKPSR25  305 /* T "\nBTITLE is ON\n"                               */
#define TLKPSR26  306 /* T "\nBTITLE is OFF\n"                              */
#define TLKPSR27  307 /* T "\n*****\n"                                      */
#define TLKPST1   308 /* T " IN %s.%02ld SECONDS\n"                         */
#define TLKPST2   309 /* T "%s.%02ld ROWS PER SECOND / %s.%02ld SECONDS PER ROW\n" */
#define TLKPST3   310 /* T "VIRTUAL READS %u, VIRTUAL WRITES %u\n"          */
#define TLKPST4   311 /* T "PHYSICAL READS %u, PHYSICAL WRITES %u\n"        */
#define TLKREG1   312 /* T
"\nDatabase system not installed (start local database or database router).\n" */
#define TLKREG2   313 /* T "***** FAILURE\n"                                */
#define TLKREG3   314 /* T "CONNECT %s 1 %s/%s"                             */
#define TLKREG4   315 /* T "*****\n"                                        */
#define TLKRES1   316 /* T "\nLog file already exists. Overwrite it (Y/N)? " */
#define TLKRES2   317 /* T "\nDatabase already exists.  Overwrite it (Y/N)? " */
#define TLKRES3   318 /* T "RESTORE ABORTED\n"                              */
#define TLKRES4   319 /* T "DATABASE RESTORED\n\n"                          */
#define TLKRES5   320 /* T
"Use the ROLLFORWARD command to initiate recovery for this restored database\n" */
#define TLKRES6   321 /* T "%s LOG RESTORED\n"                              */
#define TLKRES7   322 /* T "%s LOGS RESTORED\n"                             */
#define TLKRES8   323 /* T "ROLLFORWARD COMPLETED\n"                        */
#define TLKRES9   324 /* T "SNAPSHOT RESTORED\n"                            */
#define TLKSAV1   325 /* T "SET INDENT %d;\n"                               */
#define TLKSAV2   326 /* T "SET LINEWRAP ON;\n"                             */
#define TLKSAV3   327 /* T "SET LINEWRAP OFF;\n"                            */
#define TLKSAV4   328 /* T "SET DEVICESIZE %d;\n"                           */
#define TLKSAV5   329 /* T "SET LINESIZE %d;\n"                             */
#define TLKSAV6   330 /* T "SET LINESPACE %d;\n"                            */
#define TLKSAV7   331 /* T "SET PAGESIZE %d;\n"                             */
#define TLKSAV8   332 /* T "SET SPACE %d;\n"                                */
#define TLKSAV9   333 /* T "SET NULLS '%s';\n"                              */
#define TLKSAV10  334 /* T "SET LM %d;\n"                                   */
#define TLKSAV11  335 /* T "SET RM %d;\n"                                   */
#define TLKSAV12  336 /* T "SET TM %d;\n"                                   */
#define TLKSAV13  337 /* T "SET BM %d;\n"                                   */
#define TLKSAV14  338 /* T "SET LIMIT %d;\n"                                */
#define TLKSAV15  339 /* T "SET LIMIT OFF;\n"                               */
#define TLKSAV16  340 /* T "TTITLE '%s' DATE %s PAGE %s;\n"                 */
#define TLKSAV17  341 /* T "ON "                                            */
#define TLKSAV18  342 /* T "OFF"                                            */
#define TLKSAV19  343 /* T "TTITLE OFF;\n"                                  */
#define TLKSAV20  344 /* T "BTITLE '%s' DATE %s PAGE %s;\n"                 */
#define TLKSAV21  345 /* T "BTITLE OFF;\n"                                  */
#define TLKSAV22  346 /* T "COLUMN %d PRINT %s DUP %s NEWPAGE %s SUBTITLE %s WRAP %s " */
#define TLKSAV23  347 /* T "ADJUST "                                        */
#define TLKSAV24  348 /* T "OFF\n"                                          */
#define TLKSAV25  349 /* T "LEFT\n"                                         */
#define TLKSAV26  350 /* T "CENTER\n"                                       */
#define TLKSAV27  351 /* T "RIGHT\n"                                        */
#define TLKSAV28  352 /* T " ALIAS %s"                                      */
#define TLKSAV29  353 /* T " WIDTH %d"                                      */
#define TLKSAV30  354 /* T " WIDTH OFF"                                     */
#define TLKSAV31  355 /* T " PICTURE '%s' NULLS '%s' HEADING '%s';\n"       */
#define TLKSAV32  356 /* T "BREAK ON"                                       */
#define TLKSAV33  357 /* T " %d"                                            */
#define TLKSAV34  358 /* T " REPORT"                                        */
#define TLKSAV35  359 /* T "SUM  "                                          */
#define TLKSAV36  360 /* T "MIN  "                                          */
#define TLKSAV37  361 /* T "AVG  "                                          */
#define TLKSAV38  362 /* T "MAX  "                                          */
#define TLKSAV39  363 /* T "COUNT"                                          */
#define TLKSAV40  364 /* T "COMPUTE %-5s OF %2d ON %6d LABEL %-3s;\n"       */
#define TLKSAV41  365 /* T "COMPUTE %-5s OF %2d ON REPORT LABEL %-3s;\n"    */
#define TLKSAV42  366 /* T "BREAK OFF;\n"                                   */
#define TLKSAV43  367 /* T "RIGHT %d;\n"                                    */
#define TLKSCM1   368 /* T "SUM  "                                          */
#define TLKSCM2   369 /* T "MIN  "                                          */
#define TLKSCM3   370 /* T "AVG  "                                          */
#define TLKSCM4   371 /* T "MAX  "                                          */
#define TLKSCM5   372 /* T "COUNT"                                          */
#define TLKSCM6   373 /* T "ON "                                            */
#define TLKSCM7   374 /* T "OFF"                                            */
#define TLKSCM8   375 /* T "\nCOMPUTE %-5s OF %2d ON %6d LABEL %-3s"        */
#define TLKSCM9   376 /* T "\nCOMPUTE %-5s OF %2d ON REPORT LABEL %-3s"     */
#define TLKSIG1   377 /* T "\nSQLTALK Interactive Data Manager (Version %d.%d." */
#define TLKSIG2   378 /* T "%s)\n"                                          */
#define TLKSIG3   379 /* T "%d)\n"                                          */
#define TLKSIG4   380 /* T "Copyright (c) Gupta Corporation 1985-94. All Rights Reserved.\n" */
#define TLKSIG6   381 /* T "\nDatabase[%-8s]: "                             */
#define TLKSIG7   382 /* T "\nUsername[%-8s]: "                             */
#define TLKSIG8   383 /* T "\nPassword[\376\376\376\376\376\376\376\376]: " */
#define TLKSIG9   384 /* T "\n\nConnecting to %s in Interactive Line Mode\n\n\n\n" */
#define TLKSIG10  385 /* T "CONNECT %s 1 %s/%s"                             */
#define TLKSTO1   386 /* T "\nCommand already exists.  Overwrite it (Y/N)? " */
#define TLKSTO2   387 /* T "\nCOMMAND STORED\n"                             */
#define TLKTOP1   388 /* T "SQLTALK: invalid number of cache pages\n"       */
#define TLKTOP2   389 /* T "SQLTALK: can't allocate work areas\n"           */
#define TLKXCT1   390 /* T "\nEXECUTION PLAN:\n\n"                          */
#define TLSBLK2   391 /* T "\nBULK EXECUTE IS NOW OFF\n"                    */
#define TLPSHO109 392 /* T "Internal error, unknown brand of database\n"    */
#define TLPSHO110 393 /* T "The brand of database is %s "                   */
#define TLPSHO111 394 /* T "SCROLL is ON "                                  */
#define TLPSHO112 395 /* T "SCROLL is OFF "                                 */
#define TLPSHO113 396 /* T "RESTRICTION is ON "                             */
#define TLPSHO114 397 /* T "RESTRICTION is OFF "                            */
#define TLKPSM41  398 /* T "\nPRIMARY KEY ADDED"                            */
#define TLKPSM42  399 /* T "\nFOREIGN KEY ADDED"                            */
#define TLKPSM43  400 /* T "\nPRIMARY KEY DROPPED"                          */
#define TLKPSM44  401 /* T "\nFOREIGN KEY DROPPED"                          */
#define TLKPSM45  402 /* T "\nFOREIGN DBMS COMMAND EXECUTED"                */
#define TLKPSM57  403 /* T "\nUSER ERROR ADDED"                             */
#define TLKPSM58  404 /* T "\nUSER ERROR DROPPED"                           */
#define TLKPSM59  405 /* T "\nUSER ERROR MODIFIED"                          */
#define TLSPROTO  406 /* T "\n2-PHASE COMMIT PROTOCOL SET\n"                */
#define TLKPSMUNLD 407 /* T "\nUNLOAD COMMAND EXECUTED"                     */
#define TLKPSMLD  408 /* T "\nLOAD COMMAND EXECUTED"                        */

#define LDPPLR2   409 /* TS "%s ROWS LOADED.\n"                             */
#define UNLUSQ4   410 /* TS "\n UNLOADING DATA FROM THE VIEW %s.%s\n"       */

#define UNLUSQ3   411 /* TS "   %s ROWS UNLOADED\n"                         */
#define UNLUSQ6   412 /* TS "\n UNLOADING USER MODIFICATIONS IN %s ROWS OF SYSTEM TABLE %s.%s\n" */
#define UNLUSQ7   413 /* TS "   UNLOADING THE LONG VARCHAR COLUMNS IN TABLE %s.%s\n" */
#define LDPPLR3   414 /* TS "LOAD ERROR ON LINE %s.\n"                      */
#define LDPPLR4   415 /* TS "LOAD COMPLETED\n"                              */
#define UNLUSQ1   416 /* TS " %s.%s DOES NOT EXIST\n"                       */
#define UNLUSQ5   417 /* TS "\nUNLOADING ALL USER AUTHORIZATIONS\n"         */
#define UNLUSQ8   418 /* TS "\nUNLOADING ALL USER TABLES:\n"                */
#define UNLUSQ9   419 /* TS "\nUNLOADING ALL USER VIEWS\n"                  */
#define UNLUSQ10  420 /* TS "\nUNLOADING ALL STORED COMMANDS\n"             */
#define TLPREO3   421 /* T "RELOADING THE DATABASE\n"                       */
#define TLPREO4   422 /* T "REORGANIZING COMPLETED\n"                       */
#define CFFSRC1   430 /* S "Unable to locate configuration error message %d\n" */
#define SRVMAI1   431 /* S "%s: Server is already running\n"                */
#define SRVMAI2   432 /* S "%s: System error starting up server - %u\n"     */
#define SRVMAI3   433 /* S "%s: Cannot access OS/2 system information\n"    */
#define SRVMAI4   434 /* S "%s: Out of memory\n"                            */
#define SRVMAI5   435 /* S "%s: Cannot create thread of execution\n"        */
/*
  The following line defines the box drawing character set using the
  IBM PC standard graphics character set. MESBOC2 is an alternative
  set that utilizes the standard ASCII character set.
*/
#define MESBOC1   436 /* ST "\311\273\310\274\272\315\332\277\300\331\263\304" */
#define SVMSRC1   437 /* S "%s"                                             */
#define SVMSRC2   438 /* S x4 y33 " FUNCTION KEYS "                         */
#define SVMSRC3   439 /* S x5 y2  "F1 - Server Status"                      */
#define SVMSRC4   440 /* S x6 y2  "F3 - System Activity"                    */
#define SVMSRC5   441 /* S x5 y41 "F2  - Process Activity"                  */
#define SVMSRC6   442 /* S x6 y41 "Esc - Exit Server"                       */


#define SVMSRC7   443 /* S "%2d:%02d"                                       */
#define SVMSRC8   444 /* S " "                                              */
#define SVMSRC9   445 /* S "*"                                              */
#define SVMSRC10  446 /* S " SYSTEM ACTIVITY "                              */
#define SVMSRC11  447 /* S "DATABASES"                                      */
#define SVMSRC12  448 /* S "%s"                                             */
#define SVMSRC13  449 /* S " PROCESS ACTIVITY "                             */
#define SVMSRC14  450 /* S " SERVER STATUS: %s "                            */
#define SVMSRC15  451 /* S " SERVER STATUS "                                */
#define SVMSRC16  452 /* S "CLIENT NODE   USER NAME    DATABASE"            */
#define SVMSRC17  453 /* S "   STATUS"                                      */
#define SVMSRC18  454 /* S "%02X"                                           */
#define SVMSRC19  455 /* S "ACTIVE"                                         */
#define SVMSRC20  456 /* S "IDLE"                                           */
#define SVMSRC21  457 /* S "(SERVER)"                                       */
#define SVMSRC22  458 /* S "%s"                                             */
#define TLSBOO11  459 /* T "\nFETCHTHROUGH IS NOW ON\n"                     */
#define TLSBOO12  460 /* T "\nFETCHTHROUGH IS NOW OFF\n"                    */
#define TLSBOO13  461 /* T "\nREFERENTIAL INTEGRITY CHECKING IS NOW ON\n"   */
#define TLSBOO14  462 /* T "\nREFERENTIAL INTEGRITY CHECKING IS NOW OFF\n"  */
#define TLPSHO115 463 /* T "FETCH THROUGH is ON "                           */
#define TLPSHO116 464 /* T "FETCH THROUGH is OFF "                          */
#define TLPSHO117 465 /* T "\n  NEXTLOG (The next log to backup) is %s "    */
#define TLPSHO118 466 /* T "NEXTLOG (The next log to backup) is %s "        */
#define TLKCTC2   467 /* T
"\n*********************************************************************"
"\n*                                                                   *"
"\n*  SQLTalk has been terminated by the user. The connected databases *"
"\n*  may be in a 'crashed' state. Automatic recovery will occur       *"
"\n*  on the next connect to those databases.                          *"
"\n*                                                                   *"
"\n*********************************************************************\n" */
#define TLKRDA1   468 /* T "SQL> "                                          */
#define TLKSIG5   469 /* T
"\nDatabase system not installed (start local database or database router).\n" */
#define TLPSHO119 470 /* T "EXTENSION (Database File Extension Size) is %s Kbytes " */
#define TLPSDP15  471 /* T "\nDATABASE FILE EXTENSION SIZE HAS BEEN SET\n"  */
#define TLPSHO120 472 /* T "NEWDB is %s "                                   */
#define TLKSAV44  473 /* T ";\n"                                            */
#define TLPSDP16  474 /* T "\nNEWDB HAS BEEN SET\n"                         */
#define TLPSDP17  475 /* T "\nREAD-ONLY DATABASE HAS BEEN ENABLED\n"        */
#define TLPSDP18  476 /* T "\nREAD-ONLY DATABASE HAS BEEN DISABLED\n"       */
#define TLSCAC1   477 /* T "Warning: Due to memory fragmentation, current number of cache pages is %d\n" */
#define TLSCAC2   478 /* T "Original number of cache pages is %d, please exit and restart\n" */
#define TLPSHO121 479 /* T "READONLYDATABASE is ON "                        */
#define TLPSHO122 480 /* T "READONLYDATABASE is OFF "                       */
#define TLSRCV5   481 /* T "\nRECOVERY CANNOT BE ENABLED FOR READ-ONLY DATABASE\n" */
#define TLPSHO123 482 /* T "NOPREBUILD is ON "                              */
#define TLPSHO124 483 /* T "NOPREBUILD is OFF "                             */
#define TLSBOO15  484 /* T "\nNOPREBUILD IS NOW ON\n"                       */
#define TLSBOO16  485 /* T "\nNOPREBUILD IS NOW OFF\n"                      */
#define TLKTCZ    486 /* T "\nColumn data will be truncated, continue (Y/N) ?" */
#define TLSOBLON  487 /* T "\nOPTIMIZEDBULK EXECUTE IS NOW ON\n"            */
#define TLSOBLOFF 488 /* T "\nOPTIMIZEDBULK EXECUTE IS NOW OFF\n"           */
#define TLPSHOOBLON  489 /* T "OPTIMIZEDBULK EXECUTION MODE is ON "         */
#define TLPSHOOBLOFF 490 /* T "OPTIMIZEDBULK EXECUTION MODE is OFF "        */
/*
  The following line defines the box drawing character set using the
  standard ASCII character set. MESBOC1 is an alternative set that
  utilizes the IBM PC standard graphics character set.
*/
#define MESBOC2   491 /* ST "++++|-++++|-"                                  */
#define TLPSHO126 492 /* T "DBDIR is not set "                              */
#define TLPDBD001 493 /* T "\nDBDIR HAS BEEN SET\n"                         */
#define TLPSHO127 494 /* T "PARTITIONS are ON "                             */
#define TLPSHO128 495 /* T "PARTITIONS are OFF "                            */
#define TLSBOO17  496 /* T "\nCOMPRESSION IS NOW ON\n"                      */
#define TLSBOO18  497 /* T "\nCOMPRESSION IS NOW OFF\n"                     */
#define TLSBOO19  498 /* T "\nLONGINFERS IS NOW ON\n"                       */
#define TLSBOO20  499 /* T "\nLONGINFERS IS NOW OFF\n"                      */
#define TLSDIS1   500 /* T "\nDESCRIBEINFO HAS BEEN SET\n"                  */
#define TLPSET1   501 /* T "FOREIGN DATABASE COMMAND EXECUTED\n"            */
#define TLPSHO125 502 /* T "DBDIR is %s "                                   */
#define TLPSHO129 503 /* T "OPTIMIZERLEVEL is %d "                          */
#define TLPSDP19  504 /* T "\nOPTIMIZERLEVEL HAS BEEN SET\n"                */
#define TLPSHO130 505 /* T "LOG FILE CURRENT OFFSET is %ld "                */
#define TLPSHO131 506 /* T "GROUP COMMIT COUNT is %s "                      */
#define TLPSHO132 507 /* T "GROUP COMMIT DELAY TICKS is %s "                */
#define TLSBOO21  508 /* T "\nMAPERROR IS NOW ON\n"                         */
#define TLSBOO22  509 /* T "\nMAPERROR IS NOW OFF\n"                        */

/*
  The following lines define the server display function key definitions
  for systems that do not support special function keys (e.g. ascii Unix)
 */

#define SVMSRCA3  510 /* S x5 y2  "1 - Server Status"                       */
#define SVMSRCA4  511 /* S x6 y2  "3 - System Activity"                     */
#define SVMSRCA5  512 /* S x5 y41 "2 - Process Activity"                    */
#define SVMSRCA6  513 /* S x6 y41 "CNTL X - Exit Server"                    */

#define TLPSHO133 514 /* T "\nCURRENT ROWID IS %s\n"                        */
/*
  The following message is used in interactive unloading of a view.
  */
#define TLUUSQ4   515 /* T "UNLOADING DATA FROM THE VIEW %s.%s\n"           */

/*
  MISCELLANEOUS MESSAGES
*/

#define TLPM516   516 /* T "\nFILE %s FOUND\n"                              */
#define TLPM517   517 /* T "\nSHARED CURSOR %d RETRIEVED FOR %s DATABASE\n" */
#define TLPM518   518 /* T "\nSHARED CURSOR %d PUT TO FILE %s\n"            */
#define TLPM519   519 /* T "SQLTalk PUT/GET file\n"                         */
#define TLPM520   520 /* T "\nFILE %s CREATED\n"                            */

/*
  The following messages are utilized for the CHECK command
*/

#define CHKDBS01  521 /* TS "Corrupted system index for table "             */
#define CHKDBS02  522 /* TS "Corrupted index "                              */
#define CHKDBS03  523 /* TS "Corrupted system free list"                    */
#define CHKDBS04  524 /* TS "Corrupted system index"                        */
#define CHKDBS05  525 /* TS "Corrupted index for stored result set "        */
#define CHKDBS06  526 /* TS "Corrupted data structures for table "          */
#define CHKDBS07  527 /* TS "Database Control Block page has bad allocation status" */
#define CHKDBS08  528 /* TS "Rollforward page has bad allocation status"    */
#define CHKDBS09  529 /* TS "Corrupted row page for table "                 */
#define CHKDBS10  530 /* TS "Corrupted deferred deallocation list"          */
#define CHKDBS11  531 /* TS "Database has lost pages"                       */
#define TLKPSM61  532 /* T "\nTABLE CHECKED"                                */
#define TLKPSM62  533 /* T "\nINDEX CHECKED"                                */

/*
  The following messages are used in SQLGET, SQLSET and SQLGSI calls
*/

#define TLPGET1   534 /* T " SQLGET ERROR: %d \n"                           */
#define TLPGET2   535 /* T " CLIENTNAME is %s \n"                           */
#define TLPGET3   536 /* T "%s\n"                                           */
#define TLPGET4   537 /* T " COMMAND TIME LIMIT is %lu\n"                   */
#define TLPGET5   538 /* T "%s "                                            */
#define TLPGET6   539 /* T " DATABASE COMMAND TIME LIMIT is %lu\n"          */
#define TLPGET7   540 /* T " MAIL ID is %s \n "                             */
#define TLPGET8   541 /* T " ADAPTER ID is %s \n"                           */
#define TLPGET9   542 /* T " NETWORK ID is %s \n"                           */
#define TLPGET10  543 /* T " USER APP ID is %s \n"                          */
#define TLPGET11  544 /* T " CLIENT ID STRING is %s \n"                     */
#define TLPGET12  545 /* T " NO DEADLOCKS\n"                                */
#define TLPGET13  546 /* T "*****"                                          */
#define TLPGET14  547 /* T " TEMPDIR is %s \n"                              */
#define TLPGET15  548 /* T " SERVER PASSWORD is %s \n"                      */
#define TLPGET16  549 /* T " ORACLEOUTERJOIN is %d \n"                      */
#define TLPGET17  550 /* T " NETPREFIX is %s \n"                            */
#define TLPGET18  551 /* T " NETLOG is %s \n"                               */
#define TLPGET19  552 /* T " NETCHECKTYPE is %d \n"                         */
#define TLPGET20  553 /* T " NETCHECK is %d \n"                             */
#define TLPGET21  554 /* T " LOCKS is %d \n"                                */
#define TLPGET22  555 /* T " INTERRUPT is %d \n"                            */
#define TLPGET23  556 /* T " ERRORFILE is %s \n"                            */
#define TLPGET24  557 /* T " DIRECTIO is %d \n"                             */
#define TLPGET25  558 /* T " DEFAULTWRITE is %d \n"                         */
#define TLPGET26  559 /* T " COUNTRY is %s \n"                              */
#define TLPGET27  560 /* T " CLIENTCHECK is %d \n"                          */
#define TLPGET28  561 /* T " CHARACTERSET is %s \n"                         */
#define TLPGET29  562 /* T " CACHEGROUP is %d \n"                           */
#define TLPGET30  563 /* T " ASYNCIO is %d \n"                              */
#define TLPGET31  564 /* T " APPLYNETLOG is %d \n"                          */
#define TLPGET32  565 /* T " OS SAMPLE RATE is %d \n"                       */
#define TLPGET33  566 /* T " OS AVERAGING WINDOW SIZE is %d \n"             */
#define TLPGET34  567 /* T " WORKLIMIT is %d \n"                            */
#define TLPGET35  568 /* T " WORK SPACE ALLOC is %d \n"                     */
#define TLPGET36  569 /* T " NUMBER OF USERS is %d \n"                      */
#define TLPGET37  570 /* T " TIMEOUT is %d \n"                              */
#define TLPGET38  571 /* T " THREAD STACK SIZE is %d \n"                    */
#define TLPGET39  572 /* T " THREAD MODE is %d \n"                          */
#define TLPGET40  573 /* T " SORT CACHE SIZE is %d \n"                      */
#define TLPGET41  574 /* T " SILENT MODE is %d \n"                          */
#define TLPGET42  575 /* T " SERVER NAME is %s \n"                          */
#define TLPGET43  576 /* T " READONLY is %d \n"                             */
#define TLPGET44  577 /* T " TIMEZONE is %d \n"                             */
#define TLPGET45  578 /* T " TIMECOLONONLY is %d \n"                        */
#define TLPGET46  579 /* T " COST OF PLAN is %lu\n"                         */
#define TLPGET47  580 /* T " TOTAL NUMBER OF DEADLOCKS is %lu\n"            */
#define TLPGET48  581 /* T " PROCESS TIMINGS is %lu\n"                      */
#define TLPGET49  582 /* T " LOCAL RESULT DIRECTORY is %s\n"                */
#define TLPGET50  583 /* T " SERVER PREFIX is %s\n"                         */
#define TLPGET51  584 /* T " SERVER STATISTICS is %d\n"                     */
#define TLPGET52  585 /* T " SHOW MAIN DB is %d\n"                          */
#define TLPGET53  586 /* T " CATALOG VERSION COUNTER is %d\n"               */
#define TLPGET54  587 /* T " INPUT MESSAGE BUFFER SIZE is %d\n"             */
#define TLPGET55  588 /* T " OUTPUT MESSAGE BUFFER SIZE is %d\n"            */
#define TLPGET56  589 /* T " PRINT LEVEL is %d\n"                           */
#define TLPGET57  590 /* T " ACTIVITY LOG is %s\n"                          */
#define TLPGET58  591 /* T " TIME STAMP is %d\n"                            */
#define TLPGET59  592 /* T " PATH NAME SEPARATOR is %s\n"                   */

#define TLPSST1   593 /* T " SQLSET ERROR: %d \n"                           */
#define TLPSST2   594 /* T " SET CLIENTNAME is %s \n"                       */
#define TLPSST3   595 /* T " SET COMMAND TIME LIMIT is %d \n"               */
#define TLPSST4   596 /* T " SET DATATBASE COMMAND TIME LIMIT is %d \n"     */
#define TLPSST5   597 /* T " SET MAIL ID is %s \n "                         */
#define TLPSST6   598 /* T " SET ADAPTER ID is %s \n"                       */
#define TLPSST7   599 /* T " SET NETWORK ID is %s \n"                       */
#define TLPSST8   600 /* T " SET USER APP ID is %s \n"                      */
#define TLPSST9   601 /* T " SET TEMPDIR is %s \n"                          */
#define TLPSST10  602 /* T " SET SERVER PASSWORD is %s \n"                  */
#define TLPSST11  603 /* T " SET ORACLEOUTERJOIN is %d \n"                  */
#define TLPSST12  604 /* T " SET NETPREFIX is %s \n"                        */
#define TLPSST13  605 /* T " SET NETLOG is %s \n"                           */
#define TLPSST14  606 /* T " SET NETCHECKTYPE is %d \n"                     */
#define TLPSST15  607 /* T " SET NETCHECK is %d \n"                         */
#define TLPSST16  608 /* T " SET LOCKS is %d \n"                            */
#define TLPSST17  609 /* T " SET INTERRUPT is %d \n"                        */
#define TLPSST18  610 /* T " SET ERRORFILE is %s \n"                        */
#define TLPSST19  611 /* T " SET DIRECTIO is %d \n"                         */
#define TLPSST20  612 /* T " SET DEFAULTWRITE is %d \n"                     */
#define TLPSST21  613 /* T " SET COUNTRY is %s \n"                          */
#define TLPSST22  614 /* T " SET CLIENTCHECK is %d \n"                      */
#define TLPSST23  615 /* T " SET CHARACTERSET is %s \n"                     */
#define TLPSST24  616 /* T " SET CACHEGROUP is %d \n"                       */
#define TLPSST25  617 /* T " SET ASYNCIO is %d \n"                          */
#define TLPSST26  618 /* T " SET APPLYNETLOG is %d \n"                      */
#define TLPSST27  619 /* T " SET OS SAMPLE RATE is %d \n"                   */
#define TLPSST28  620 /* T " SET OS AVERAGING WINDOW SIZE is %d \n"         */
#define TLPSST29  621 /* T " SET WORKLIMIT is %d \n"                        */
#define TLPSST30  622 /* T " SET WORK SPACE ALLOC is %d \n"                 */
#define TLPSST31  623 /* T " SET NUMBER OF USERS is %d \n"                  */
#define TLPSST32  624 /* T " SET TIMEOUT is %d \n"                          */
#define TLPSST33  625 /* T " SET THREAD STACK SIZE is %d \n"                */
#define TLPSST34  626 /* T " SET THREAD MODE is %d \n"                      */
#define TLPSST35  627 /* T " SET SORT CACHE SIZE is %d \n"                  */
#define TLPSST36  628 /* T " SET SILENT MODE is %d \n"                      */
#define TLPSST38  629 /* T " SET SERVER NAME is %s \n"                      */
#define TLPSST39  630 /* T " SET READONLY is %d \n"                         */
#define TLPSST41  631 /* T " SET TIMEZONE is %d \n"                         */
#define TLPSST42  632 /* T " SET TIMECOLONONLY is %d \n"                    */
#define TLPSST43  633 /* T " SET LOCAL RESULT DIRECTORY is %s \n"           */
#define TLPSST44  634 /* T " SET SERVER STATISTICS is %d\n"                 */
#define TLPSST45  635 /* T " SET INPUT MESSAGE BUFFER SIZE is %d\n"         */
#define TLPSST46  636 /* T " SET OUTPUT MESSAGE BUFFER SIZE is %d\n"        */
#define TLPSST47  637 /* T " SET PRINT LEVEL is %d\n"                       */
#define TLPSST48  638 /* T " SET ACTIVITY LOG is %s\n"                      */
#define TLPSST49  639 /* T " SET TIME STAMP is %d\n"                        */
#define TLPSST50  640 /* T " SET PATH NAME SEPARATOR is %s\n"               */
#define TLPSST51  641 /* T " SET SERVER PREFIX is %s\n"                     */
#define TLPSST52  642 /* T " SET SHOW MAIN DB is %d\n"                      */

#define TLPGSI01  643 /* T "\n***** Cursor # %d *****\n"                    */
#define TLPGSI02  644 /* T " Number      Command   Input    Output\n"       */
#define TLPGSI03  645 /* T "  Rows        Type     Buffer   Buffer\n"       */
#define TLPGSI04  646 /* T "%4lu    %6d    %6d    %6d     \n "              */
#define TLPGSI05  647 /* T "\n Process   Isolation  Database   User\n"      */
#define TLPGSI06  648 /* T " Number         Level      Name     Name\n"     */
#define TLPGSI07  649 /* T "%4d     %3s       %9s   %19s  \n"               */
#define TLPGSI08  650 /* T "\n Cursor    Cursor   Cost    Client\n"         */
#define TLPGSI09  651 /* T " Number       Status   Plan     Name \n"        */
#define TLPGSI10  652 /* T "%4d    %6d   %6ld     %13s    \n"               */

#define TLPGSI11  653 /* T "\n***** Configuration *****\n"                  */
#define TLPGSI12  654 /* T " Work        Work      Number     Number    Connect    Server\n" */
#define TLPGSI13  655 /* T " Size        Limit     Locks      Pages      Count      Name \n" */
#define TLPGSI14  656 /* T "%5lu  %6lu    %6d     %6d     %6d     %s \n"    */
#define TLPGSI15  657 /* T "\n***** Process # %d *****\n"                   */
#define TLPGSI16  658 /* T "Process      Active   Output    Output    Output    Input    Input \n" */
#define TLPGSI17  659 /* T "Number       Flag     Msg Len   Buf Len    Len     Buf Len   Length\n" */
#define TLPGSI18  660 /* T "%4d  %6d     %6d    %6d       %6d    %6d    %4d\n" */
#define TLPGSI19  661 /* T "\n***** Database *****\n"                       */
#define TLPGSI20  662 /* T "Db    Active   Total    Db \n"                  */

#define TLPGSI21  663 /* T "Use   Trans    Trans   Name\n"                  */
#define TLPGSI22  664 /* T "%2d    %3d      %3d     %6s\n"                  */
#define TLPGSI23  665 /* T "\nNumber    Number    Number    Number \n"      */
#define TLPGSI24  666 /* T "Selects      Inserts   Updates   Deletes\n"     */
#define TLPGSI25  667 /* T "%3ld        %6ld    %6ld    %6ld\n"             */
#define TLPGSI26  668 /* T "\n Total        Total         Number   Exclusive\n" */
#define TLPGSI27  669 /* T "Connects   Disconnects      Trans      Locks\n" */
#define TLPGSI28  670 /* T "%3ld           %6ld     %6ld     %6ld\n"        */

#define TLPGSI29  671 /* T "\nShared    Update    Dead     Sorts\n"         */
#define TLPGSI30  672 /* T "Locks        Locks     Locks\n"                 */
#define TLPGSI31  673 /* T "%3ld    %6ld    %6ld   %6ld\n"                  */

#define TLPGSI32  674 /* T "\nHashed    Platform           Version\n"       */
#define TLPGSI33  675 /* T "Joins\n"                                        */
#define TLPGSI34  676 /* T "%3ld         %12s     %s \n"                    */
#define TLPGSI35  677 /* T "\n Number   Deadlocks   Exclusive   Shared\n"   */
#define TLPGSI36  678 /* T " Trans                     Locks     Locks\n"   */
#define TLPGSI37  679 /* T "%4ld          %4ld       %4ld      %4ld\n"      */

#define TLPGSI38  680 /* T "\n Update   Status   Status         Client\n"   */
#define TLPGSI39  681 /* T " Locks        Flag    String               Name\n" */
#define TLPGSI40  682 /* T "%4ld    %4d    %21s     %6s\n"                  */
#define TLPGSI41  683 /* T "\n***** Locks *****\n"                          */
#define TLPGSI42  684 /* T " Database   Process   Low   High   Lock       Lock    Use\n" */
#define TLPGSI43  685 /* T "   Name        Number    Page  Page   Group   Mode   Count\n" */
#define TLPGSI44  686 /* T " %10s        %5d    %5d  %5d   %5ld  %5d  %5d\n" */
#define TLPGSI46  687 /* T " Database Protocols \n"                         */
#define TLPGSI47  688 /* T " %s\n"                                          */

#define TLPABT1   689 /* T "PROCESS #%d ABORTED"                            */
#define TLPGSI45  690 /* T "SQLGSI ERROR: %d\n"                             */

/*
  OPTIMIZERCOSTLEVEL Messages
*/

#define TLPSHOCOSTLVL   691 /* T "\nOPTIMIZERCOSTLEVEL IS %d\n"             */
#define TLPSDPCOSTLVL   692 /* T "\nOPTIMIZERCOSTLEVEL IS SET\n"            */
#define TLPSHOCOMPON    693 /* T "\nCOMPRESSION IS ON\n"                    */
#define TLPSHOCOMPOFF   694 /* T "\nCOMPRESSION IS OFF\n"                   */

#define TLSBOO25  695 /* T "\nSTORED PROCEDURE TRACE IS NOW ON\n"           */
#define TLSBOO26  696 /* T "\nSTORED PROCEDURE TRACE IS NOW OFF\n"          */
#define TLSTRF1   697 /* T "\nSTORED PROCEDURE TRACEFILE IS SET\n"          */
#define TLSTRF2   698 /* T "\nSTORED PROCEDURE TRACEFILE IS OFF\n"          */
#define TLPSHO134 699 /* T "\nSTORED PROCEDURE TRACE IS ON\n"               */
#define TLPSHO135 700 /* T "\nSTORED PROCEDURE TRACE IS OFF\n"              */
#define TLPSHO136 701 /* T "\nSTORED PROCEDURE TRACEFILE IS %s\n"           */
#define TLPSHO137 702 /* T "\nSTORED PROCEDURE TRACEFILE IS OFF\n"          */
#define TLKPSM84  703 /* T "\n%s ROW%s RETRIEVED FROM PROCEDURE"            */
#define TLKPSM85  704 /* T "\nEXECUTE PRIVILEGE GRANTED\n"                  */
#define TLKPSM86  705 /* T "\nEXECUTE PRIVILEGE REVOKED\n"                  */
#define TLKPSM87  706 /* T "\nTRIGGER CREATED\n"                            */
#define TLKPSM88  707 /* T "\nTRIGGER DROPPED\n"                            */
#define TLKPSM89  708 /* T "\nEVENT CREATED\n"                              */
#define TLKPSM90  709 /* T "\nEVENT DROPPED\n"                              */
#define UNLUSQ11  710 /* TS "\nUNLOADING ALL TRIGGERS\n"                    */
#define UNLUSQ12  711 /* TS "\nUNLOADING ALL EVENTS\n"                      */

#define TLSCSVON           712 /* T "\nCOMMIT SERVICE HAS BEEN ENABLED\n"   */
#define TLSCSVOFF          713 /* T "\nCOMMIT SERVICE HAS BEEN DISABLED\n"  */
#define TLSBOODTRON        714 /* T "\nDISTRIBUTED TRANSACTION MODE IS NOW ON\n" */
#define TLSBOODTROFF    715 /* T "\nDISTRIBUTED TRANSACTION MODE IS NOW OFF\n" */
#define TLPSHODTRON        716 /* T "\nDISTRIBUTED TRANSACTION MODE IS ON\n" */
#define TLPSHODTROFF    717 /* T "\nDISTRIBUTED TRANSACTION MODE IS OFF\n"  */
#define TLPSHO_PRT_STANDARD                718 /* T "\n2-PHASE-COMMIT PROTOCOL IS STANDARD\n" */
#define TLPSHO_PRT_PRESUMEDABORT           719 /* T "\n2-PHASE-COMMIT PROTOCOL IS PRESUMEDABORT\n" */
#define TLPSHO_PRT_PRESUMEDCOMMIT          720 /* T "\n2-PHASE-COMMIT PROTOCOL IS PRESUMEDCOMMIT\n" */
#define TLPSHO_PRT_DEFAULT                 721 /* T "\n2-PHASE-COMMIT PROTOCOL IS DEFAULT\n" */
#define TLKPSM_CREATE_FAILURE      722 /* T "\nFAILURE CREATED "            */
#define TLKPSM_DELETE_FAILURE      723 /* T "\nFAILURE DELETED "            */
#define TLPSHOCSVE                         724 /* T "\nCOMMITSERVER is enabled\n" */
#define TLPSHOCSVD                         725 /* T "\nCOMMITSERVER is disabled\n" */
#define TLSSHOFPT                          726 /* T "\nFIRST PARTICIPANT IS %s\n" */
#define TLPSHOTTPON                        727 /* T "\nTRACETWOPC IS ON\n"  */
#define TLPSHOTTPOFF               728 /* T "\nTRACETWOPC IS OFF\n"         */
#define TLSBOO23  729 /* T "\nPARTITIONS ARE NOW ON\n"                      */
#define TLSBOO24  730 /* T "\nPARTITIONS ARE NOW OFF\n"                     */
#define TLPSETNUMPARM   731     /* T "NUMERIC PARAMETER HAS BEEN SET\n"     */
#define TLPSHONUMPARM   732     /* T "NUMERIC PARAMETER value is %ld "      */
#define TLUUSQ5   733 /* T "UNLOADING ROWS FROM TABLE %s.%s\n"              */

/*
  PARTITIONED DATABASE Messages
*/

#define TLPSRV01  734 /* T "DBAREA CREATED\n"                               */
#define TLPSRV02  735 /* T "DBAREA ALTERED\n"                               */
#define TLPSRV03  736 /* T "DBAREA DROPPED\n"                               */
#define TLPSRV04  737 /* T "STOGROUP CREATED\n"                             */
#define TLPSRV05  738 /* T "STOGROUP ALTERED\n"                             */
#define TLPSRV06  739 /* T "STOGROUP DROPPED\n"                             */
#define TLPSRV07  740 /* T "DATABASE CREATED\n"                             */
#define TLPSRV08  741 /* T "DATABASE ALTERED\n"                             */
#define TLPSRV09  742 /* T "DATABASE DROPPED\n"                             */
#define TLPSRV10  743 /* T "DEFAULT STOGROUP CHANGED\n"                     */
#define TLPSRV11  744 /* T "DATABASE INSTALLED\n"                           */
#define TLPSRV12  745 /* T "DATABASE DEINSTALLED\n"                         */

/*
  AUDIT Messages
*/

#define TLPSRV13  746 /* T "AUDIT STARTED\n"                                */
#define TLPSRV14  747 /* T "AUDIT MESSAGE RECORDED\n"                       */
#define TLPSRV15  748 /* T "AUDIT STOPPED\n"                                */

/*
  MORE MISCELLANEOUS Messages
*/

#define TLPCURCN  749 /* T "CURSOR %d CONNECTED TO %s"                      */
#define TLPNXLOG  750 /* T "\nNEXT LOG TO BACKUP HAS BEEN SET\n"            */
#define TLPSRV16  751 /* TS ",,,AUDIT STOPPED: FILE EXISTS (OVERWRITE NOT SPECIFIED)" */
#define TLKPSM91  752 /* T "\nCOMMAND ALTERED\n"                            */
#define TLSBOO29  753 /* T "\nSERVER IS NOW OFF-LINE\n"                     */
#define TLSBOO30  754 /* T "\nSERVER IS NOW ON-LINE\n"                      */

#define TLSBOO27  755 /* T "\nDATABASE %s IS NOW OFF-LINE\n"                */
#define TLSBOO28  756 /* T "\nDATABASE %s IS NOW ON-LINE\n"                 */

#define UNLUSQ13  757 /* TS "\n UNLOADING DATA IN ASCII FORMAT FOR TABLE %s.%s.\n" */
#define UNLUSQ14  758 /* TS "\nUNLOADING ALL SYSTEM TABLES. \n"             */
#define UNLUSQ15  759 /* TS "\n UNLOADED %d USER TABLES. \n"                */

#define TLKPSM92  760 /* T "\nDATABASE LOCKED\n"                            */
#define TLKPSM93  761 /* T "\nDATABASE UNLOCKED\n"                          */
#define CHKDBS12  762 /* TS "System reserved pages have bad allocation status" */

#define TLPGET60  763 /* T " CACHE SIZE is %d\n"                            */
#define TLPSST53  764 /* T " SET CACHE SIZE is %d\n"                        */

#define TLPGET61  765 /* T " Benchmark Steady State is  %d\n"               */
#define TLPSST54  766 /* T " Benchmark Steady State set to %d\n"            */
#define TLPSHO138  767 /* T "TOTALSONLY is ON \n"                           */
#define TLPSHO139  768 /* T "TOTALSONLY is OFF \n"                          */
#define TLPGSI48   769 /* T "%d CONFIG RECORDS\n"                           */
#define TLPGSI49   770 /* T "%d STATISTIC RECORDS\n"                        */
#define TLPGSI50   771 /* T "%d CURSOR RECORDS\n"                           */
#define TLPGSI51   772 /* T "%d DATABASE RECORDS\n"                         */
#define TLPGSI52   773 /* T "%d PROCESS RECORDS\n"                          */
#define TLPGSI53   774 /* T "%d LOCK RECORDS\n"                             */
#define TLPSHO140  775 /* T "TIMEOUT COUNTER is %ld \n"                     */

#define TLEDIN01   776 /* T "ALL CURSORS FOR DATABASE %s DISCONNECTED\n"    */
#define TLEDIN02   777 /* T "No cursors for database %s are currently active\n" */
#define TLEDIA01   778 /* T "ALL CURSORS DISCONNECTED\n"                    */

#define TLKCON01   779 /* T "Connection Made Without All Expected Settings." */

#define ULUMSG01  780 /* S "Unloaded %d user authorizations\n\n"            */
#define ULUMSG02  781 /* S "   %s.%s (%s rows)\n"                           */
#define ULUMSG03  782 /* S "Tables, indexes, and synonyms unloaded:\n"      */
#define ULUMSG04  783 /* S "   Unloaded %d tables\n\n"                      */
#define ULUMSG05  784 /* S "   Unloaded %d views\n\n"                       */
#define ULUMSG06  785 /* S "Stored commands unloaded:\n"                    */
#define ULUMSG07  786 /* S "Triggers unloaded:\n"                           */
#define ULUMSG08  787 /* S "Events unloaded:\n"                             */
#define ULUMSG09  788 /* S "   Unloaded primary key for table %s.%s\n"      */
#define ULUMSG10  789 /* S "Unload completed\n"                             */
#define ULUMSG11  790 /* S "Unloaded %s rows in ASCII format for table %s.%s\n" */
#define ULUMSG12  791 /* S "   %s.%s view unloaded\n"                       */
#define ULUMSG13  792 /* S "UNLOAD ERROR: %s.%s does not exist\n"           */
#define ULUMSG14  793 /* S "Unloaded modifications in %s rows of system table %s.%s\n\n" */
#define ULUMSG15  794 /* S "   %s.%s LONG VARCHAR data unloaded\n"          */
#define ULUMSG16  795 /* S "Load version (%s) has been set\n\n"             */
#define ULUMSG17  796 /* S "Load completed\n"                               */
#define ULUMSG18  797 /* S "   %s.%s\n"                                     */
#define ULUMSG19  798 /* S "Views unloaded:\n"                              */
#define ULUMSG20  799 /* S "   Table %s.%s\n"                               */
#define ULUMSG21  800 /* S "   Unloaded %d stored commands\n\n"             */
#define ULUMSG22  801 /* S "Unloaded %d execute authorizations\n\n"         */
#define ULUMSG23  802 /* S "   Unloaded %d triggers\n\n"                    */
#define ULUMSG24  803 /* S "   Unloaded %d events\n\n"                      */
#define ULUMSG25  804 /* S "      Synonym %s.%s\n"                          */
#define ULUMSG26  805 /* S "      Public synonym %s\n"                      */
#define ULUMSG27  806 /* S "      Index %s.%s\n"                            */
#define ULUMSG28  807 /* S "Stored procedures unloaded:\n"                  */
#define ULUMSG29  808 /* S "   Unloaded %d stored procedures\n\n"           */
#define ULUMSG30  809 /* S "Unloaded SQLBase version %s\n\n"                */
#define ULUMSG31  810 /* S "   UNLOAD SUMMARY\n"                            */
#define ULUMSG32  811 /* S "   LOAD SUMMARY\n"                              */
#define ULUMSG33  812 /* S "      User Tables............%5d\n"             */
#define ULUMSG34  813 /* S "      User Views.............%5d\n"             */
#define ULUMSG35  814 /* S "      User Authorizations....%5d\n"             */
#define ULUMSG36  815 /* S "      Indexes................%5d\n"             */
#define ULUMSG37  816 /* S "      Synonyms...............%5d\n"             */
#define ULUMSG38  817 /* S "      Stored Commands........%5d\n"             */
#define ULUMSG39  818 /* S "      Stored Procedures......%5d\n"             */
#define ULUMSG40  819 /* S "      Triggers...............%5d\n"             */
#define ULUMSG41  820 /* S "      Events.................%5d\n"             */
#define ULUMSG42  821 /* S "Granted %d user authorizations\n\n"             */
#define ULUMSG43  822 /* S "Tables, indexes, and synonyms created:\n"       */
#define ULUMSG44  823 /* S "   Created primary key for table %s.%s\n"       */
#define ULUMSG45  824 /* S "   Created foreign key %s for table %s.%s\n"    */
#define ULUMSG46  825 /* S "      Inserted %s rows into %s.%s\n"            */
#define ULUMSG47  826 /* S "   Created %d tables\n\n"                       */
#define ULUMSG48  827 /* S "Views created:\n"                               */
#define ULUMSG49  828 /* S "   Created %d views\n\n"                        */
#define ULUMSG50  829 /* S "Commands stored:\n"                             */
#define ULUMSG51  830 /* S "   %s\n"                                        */
#define ULUMSG52  831 /* S "   Stored %d commands\n\n"                      */
#define ULUMSG53  832 /* S "Procedures stored:\n"                           */
#define ULUMSG54  833 /* S "   Stored %d procedures\n\n"                    */
#define ULUMSG55  834 /* S "      Execute Authorizations.%5d\n"             */
#define ULUMSG56  835 /* S "Granted %d execute authorizations\n\n"          */
#define ULUMSG57  836 /* S "Triggers created:\n"                            */
#define ULUMSG58  837 /* S "   Created %d triggers\n\n"                     */
#define ULUMSG59  838 /* S "Events created:\n"                              */
#define ULUMSG60  839 /* S "   Created %d events\n\n"                       */
#define ULUMSG61  840 /* S "   Unloaded foreign key %s for table %s.%s\n"   */
#define ULUMSG62  841 /* S "      Primary keys...........%5d\n"             */
#define ULUMSG63  842 /* S "      Foreign keys...........%5d\n"             */
#define TLKPSM94  843 /* T "\nEXTERNAL FUNCTION CREATED"                    */
#define TLKPSM95  844 /* T "\nEXTERNAL FUNCTION DROPPED"                    */
#define TLPGET62  845 /* T " Commit-order logging is %d\n"                  */
#define TLPSST55  846 /* T " Commit-order logging set to %d\n"              */
#define TLKPSM96  847 /* T " DBATTRIBUTE command executed \n"               */
#define TLKPSM97  848 /* T " ALTER TRIGGER executed successfully. \n"       */
#define TLKPSM98  849 /* T "\nEXTERNAL FUNCTION ALTERED"                    */
#define TLPSDPOFF 850 /* T "\nOPTIMIZEFIRSTFETCH HAS BEEN SET\n"            */
#define TLPSHOOFF 851 /* T "OPTIMIZEFIRSTFETCH is %d "                      */
#define UNLUSQ16  852 /* TS "\nUNLOADING ALL EXTERNAL FUNCTIONS\n"          */
#define ULUMSG64  853 /* S "External Functions unloaded:\n"                 */
#define ULUMSG65  854 /* S "   Unloaded %d external functions\n\n"          */
#define ULUMSG66  855 /* S "      External Functions.....%5d\n"             */
#define ULUMSG67  856 /* S "External Functions created:\n"                  */
#define ULUMSG68  857 /* S "   Created %d external functions\n\n"           */
#define SRVOPM1   858 /* S
  "A request to shutdown SQLBase is being processed.  "
  "Please wait while SQLBase writes database information "
  "to disk and completes all shutdown tasks.  "
  "This message will stay present until SQLBase completes "
  "its termination."  */
#define SRVOPM2   859 /* S "SQLBase Fatal Error"                            */
#define SRVOPM3   860 /* S
  "SQLBase must not be started using the REALTIME priority class. "
  "Doing so may cause preemption of the threads of all other "
  "processes, including operating system processes performing "
  "important tasks." */
#define SRVOPM4   861 /* S
  "Specified log file already exists.\n"
  "Press OK to overwrite, or Cancel to cancel opening log file."            */
#define SRVOPM5   862 /* S "SQLBase Open Log Warning"                       */
#define SRVOPM6   863 /* S
  "Active users are connected to the server.\n"
  "Press OK to disconnect users and close the server, or\n"
  "Cancel to leave the server running." */
#define SRVOPM7   864 /* S "SQLBase Shutdown Warning"                       */
