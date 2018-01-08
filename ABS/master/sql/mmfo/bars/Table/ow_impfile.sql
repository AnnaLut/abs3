

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_IMPFILE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_IMPFILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_IMPFILE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_IMPFILE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_IMPFILE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
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
	FILE_BLOB BLOB, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
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
COMMENT ON COLUMN BARS.OW_IMPFILE.KF IS '';
COMMENT ON COLUMN BARS.OW_IMPFILE.ID IS '';
COMMENT ON COLUMN BARS.OW_IMPFILE.FILE_DATA IS '';
COMMENT ON COLUMN BARS.OW_IMPFILE.FILE_BLOB IS '';




PROMPT *** Create  constraint PK_OWIMPFILE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IMPFILE ADD CONSTRAINT PK_OWIMPFILE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIMPFILE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IMPFILE MODIFY (KF CONSTRAINT CC_OWIMPFILE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWIMPFILE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IMPFILE ADD CONSTRAINT FK_OWIMPFILE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIMPFILE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IMPFILE MODIFY (ID CONSTRAINT CC_OWIMPFILE_ID_NN NOT NULL ENABLE NOVALIDATE)';
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
grant SELECT                                                                 on OW_IMPFILE      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_IMPFILE      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_IMPFILE.sql =========*** End *** ==
PROMPT ===================================================================================== 
