

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DDL_UTILS_STORE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DDL_UTILS_STORE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DDL_UTILS_STORE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DDL_UTILS_STORE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DDL_UTILS_STORE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DDL_UTILS_STORE 
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




PROMPT *** ALTER_POLICIES to DDL_UTILS_STORE ***
 exec bpa.alter_policies('DDL_UTILS_STORE');


COMMENT ON TABLE BARS.DDL_UTILS_STORE IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE.OBJECT_NAME IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE.OBJECT_TYPE IS '';
COMMENT ON COLUMN BARS.DDL_UTILS_STORE.SQL_TEXT IS '';




PROMPT *** Create  constraint UK_DDLUTILSSTORE_TN_ON_OT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DDL_UTILS_STORE ADD CONSTRAINT UK_DDLUTILSSTORE_TN_ON_OT UNIQUE (TABLE_NAME, OBJECT_NAME, OBJECT_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DDLUTILSSTORE_TN_ON_OT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DDLUTILSSTORE_TN_ON_OT ON BARS.DDL_UTILS_STORE (TABLE_NAME, OBJECT_NAME, OBJECT_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DDL_UTILS_STORE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DDL_UTILS_STORE to ABS_ADMIN;
grant SELECT                                                                 on DDL_UTILS_STORE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DDL_UTILS_STORE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DDL_UTILS_STORE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DDL_UTILS_STORE.sql =========*** End *
PROMPT ===================================================================================== 
