

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IMP_FILE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IMP_FILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IMP_FILE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IMP_FILE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IMP_FILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IMP_FILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.IMP_FILE 
   (	FILE_NAME VARCHAR2(100), 
	FILE_CLOB CLOB, 
	FILE_BLOB BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (FILE_CLOB) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (FILE_BLOB) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IMP_FILE ***
 exec bpa.alter_policies('IMP_FILE');


COMMENT ON TABLE BARS.IMP_FILE IS '';
COMMENT ON COLUMN BARS.IMP_FILE.FILE_NAME IS '';
COMMENT ON COLUMN BARS.IMP_FILE.FILE_CLOB IS '';
COMMENT ON COLUMN BARS.IMP_FILE.FILE_BLOB IS '';




PROMPT *** Create  constraint PK_IMPFILE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.IMP_FILE ADD CONSTRAINT PK_IMPFILE_ID PRIMARY KEY (FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IMPFILE_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IMP_FILE MODIFY (FILE_NAME CONSTRAINT CC_IMPFILE_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IMPFILE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_IMPFILE_ID ON BARS.IMP_FILE (FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IMP_FILE ***
grant SELECT                                                                 on IMP_FILE        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on IMP_FILE        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IMP_FILE        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on IMP_FILE        to START1;
grant SELECT                                                                 on IMP_FILE        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IMP_FILE.sql =========*** End *** ====
PROMPT ===================================================================================== 
