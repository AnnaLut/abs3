

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_IMP_FILE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_IMP_FILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_IMP_FILE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_IMP_FILE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_IMP_FILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_IMP_FILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_IMP_FILE 
   (	ID NUMBER(22,0), 
	FILE_DATA CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_IMP_FILE ***
 exec bpa.alter_policies('FM_IMP_FILE');


COMMENT ON TABLE BARS.FM_IMP_FILE IS '';
COMMENT ON COLUMN BARS.FM_IMP_FILE.ID IS '';
COMMENT ON COLUMN BARS.FM_IMP_FILE.FILE_DATA IS '';




PROMPT *** Create  constraint PK_FMIMPFILE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_IMP_FILE ADD CONSTRAINT PK_FMIMPFILE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMIMPFILE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_IMP_FILE MODIFY (ID CONSTRAINT CC_FMIMPFILE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMIMPFILE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMIMPFILE_ID ON BARS.FM_IMP_FILE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_IMP_FILE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_IMP_FILE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_IMP_FILE     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_IMP_FILE.sql =========*** End *** =
PROMPT ===================================================================================== 
