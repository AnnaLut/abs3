

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CRVFILES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CRVFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CRVFILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CRVFILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CRVFILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CRVFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CRVFILES 
   (	ID NUMBER(22,0), 
	FILE_NAME VARCHAR2(100), 
	FILE_DATE DATE, 
	FILE_N NUMBER(22,0), 
	ERR_CODE NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CRVFILES ***
 exec bpa.alter_policies('OW_CRVFILES');


COMMENT ON TABLE BARS.OW_CRVFILES IS 'ЦРВ. Файлы на открытие карт';
COMMENT ON COLUMN BARS.OW_CRVFILES.KF IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES.ID IS 'Id';
COMMENT ON COLUMN BARS.OW_CRVFILES.FILE_NAME IS '_мя файла';
COMMENT ON COLUMN BARS.OW_CRVFILES.FILE_DATE IS 'Дата формування файла';
COMMENT ON COLUMN BARS.OW_CRVFILES.FILE_N IS 'К_льк_сть рядк_в у файл_';
COMMENT ON COLUMN BARS.OW_CRVFILES.ERR_CODE IS '';




PROMPT *** Create  constraint CC_OWCRVFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES MODIFY (KF CONSTRAINT CC_OWCRVFILES_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVFILES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES MODIFY (ID CONSTRAINT CC_OWCRVFILES_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES MODIFY (FILE_NAME CONSTRAINT CC_OWCRVFILES_FILENAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES MODIFY (FILE_DATE CONSTRAINT CC_OWCRVFILES_FILEDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWCRVFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES ADD CONSTRAINT PK_OWCRVFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCRVFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCRVFILES ON BARS.OW_CRVFILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CRVFILES ***
grant SELECT                                                                 on OW_CRVFILES     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVFILES     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVFILES     to OW;
grant SELECT                                                                 on OW_CRVFILES     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CRVFILES.sql =========*** End *** =
PROMPT ===================================================================================== 
