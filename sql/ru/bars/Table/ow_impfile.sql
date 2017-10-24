

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_IMPFILE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_IMPFILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_IMPFILE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_IMPFILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_IMPFILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_IMPFILE 
   (	ID NUMBER(22,0), 
	FILE_DATA CLOB, 
	FILE_BLOB BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (FILE_BLOB) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_IMPFILE ***
 exec bpa.alter_policies('OW_IMPFILE');


COMMENT ON TABLE BARS.OW_IMPFILE IS '';
COMMENT ON COLUMN BARS.OW_IMPFILE.FILE_BLOB IS '';
COMMENT ON COLUMN BARS.OW_IMPFILE.ID IS '';
COMMENT ON COLUMN BARS.OW_IMPFILE.FILE_DATA IS '';




PROMPT *** Create  constraint PK_OWIMPFILE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IMPFILE ADD CONSTRAINT PK_OWIMPFILE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIMPFILE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IMPFILE MODIFY (ID CONSTRAINT CC_OWIMPFILE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWIMPFILE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWIMPFILE_ID ON BARS.OW_IMPFILE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_IMPFILE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_IMPFILE      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_IMPFILE      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_IMPFILE.sql =========*** End *** ==
PROMPT ===================================================================================== 
