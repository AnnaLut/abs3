

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DDL_UTILS_STORE_BARSDB.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DDL_UTILS_STORE_BARSDB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DDL_UTILS_STORE_BARSDB ***
begin 
  execute immediate '
  CREATE TABLE BARS.DDL_UTILS_STORE_BARSDB 
   (	TABLE_NAME VARCHAR2(35), 
	OBJECT_NAME VARCHAR2(35), 
	OBJECT_TYPE VARCHAR2(35), 
	SQL_TEXT CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (SQL_TEXT) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DDL_UTILS_STORE_BARSDB ***
 exec bpa.alter_policies('DDL_UTILS_STORE_BARSDB');


COMMENT ON TABLE BARS.DDL_UTILS_STORE_BARSDB IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE_BARSDB.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE_BARSDB.OBJECT_NAME IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE_BARSDB.OBJECT_TYPE IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE_BARSDB.SQL_TEXT IS '';



PROMPT *** Create  grants  DDL_UTILS_STORE_BARSDB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DDL_UTILS_STORE_BARSDB to ABS_ADMIN;
grant SELECT                                                                 on DDL_UTILS_STORE_BARSDB to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DDL_UTILS_STORE_BARSDB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DDL_UTILS_STORE_BARSDB to BARS_DM;
grant SELECT                                                                 on DDL_UTILS_STORE_BARSDB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DDL_UTILS_STORE_BARSDB.sql =========**
PROMPT ===================================================================================== 
