

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_IICFILES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_IICFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_IICFILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_IICFILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_IICFILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_IICFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_IICFILES 
   (	FILE_NAME VARCHAR2(100), 
	FILE_DATE DATE, 
	FILE_N NUMBER(22,0), 
	FILE_S NUMBER(20,2), 
	TICK_NAME VARCHAR2(100), 
	TICK_DATE DATE, 
	TICK_STATUS VARCHAR2(23), 
	TICK_ACCEPT_REC NUMBER(*,0), 
	TICK_REJECT_REC NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_IICFILES ***
 exec bpa.alter_policies('OW_IICFILES');


COMMENT ON TABLE BARS.OW_IICFILES IS 'OpenWay. Файли зарахувань/списань по картках ЦРВ';
COMMENT ON COLUMN BARS.OW_IICFILES.FILE_NAME IS 'Імя файла';
COMMENT ON COLUMN BARS.OW_IICFILES.FILE_DATE IS 'Дата формування файла';
COMMENT ON COLUMN BARS.OW_IICFILES.FILE_N IS 'Кількість рядків у файлі';
COMMENT ON COLUMN BARS.OW_IICFILES.FILE_S IS 'Сума документів у файлі';
COMMENT ON COLUMN BARS.OW_IICFILES.TICK_NAME IS '';
COMMENT ON COLUMN BARS.OW_IICFILES.TICK_DATE IS '';
COMMENT ON COLUMN BARS.OW_IICFILES.TICK_STATUS IS '';
COMMENT ON COLUMN BARS.OW_IICFILES.TICK_ACCEPT_REC IS '';
COMMENT ON COLUMN BARS.OW_IICFILES.TICK_REJECT_REC IS '';
COMMENT ON COLUMN BARS.OW_IICFILES.KF IS '';




PROMPT *** Create  constraint PK_OWIICFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IICFILES ADD CONSTRAINT PK_OWIICFILES PRIMARY KEY (FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIICFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IICFILES MODIFY (KF CONSTRAINT CC_OWIICFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWIICFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IICFILES ADD CONSTRAINT FK_OWIICFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIICFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IICFILES MODIFY (FILE_NAME CONSTRAINT CC_OWIICFILES_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWIICFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_IICFILES MODIFY (FILE_DATE CONSTRAINT CC_OWIICFILES_FILEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWIICFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWIICFILES ON BARS.OW_IICFILES (FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_IICFILES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_IICFILES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_IICFILES     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_IICFILES     to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_IICFILES.sql =========*** End *** =
PROMPT ===================================================================================== 
