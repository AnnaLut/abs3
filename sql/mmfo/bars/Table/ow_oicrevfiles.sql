

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OICREVFILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OICREVFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OICREVFILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_OICREVFILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_OICREVFILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OICREVFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OICREVFILES 
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
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_OICREVFILES ***
 exec bpa.alter_policies('OW_OICREVFILES');


COMMENT ON TABLE BARS.OW_OICREVFILES IS 'OpenWay. Файли зарахувань/списань по картках ЦРВ';
COMMENT ON COLUMN BARS.OW_OICREVFILES.FILE_NAME IS 'Імя файла';
COMMENT ON COLUMN BARS.OW_OICREVFILES.FILE_DATE IS 'Дата формування файла';
COMMENT ON COLUMN BARS.OW_OICREVFILES.FILE_N IS 'Кількість рядків у файлі';
COMMENT ON COLUMN BARS.OW_OICREVFILES.FILE_S IS 'Сума документів у файлі';
COMMENT ON COLUMN BARS.OW_OICREVFILES.TICK_NAME IS 'Ім'я файлу квитанції';
COMMENT ON COLUMN BARS.OW_OICREVFILES.TICK_DATE IS 'Дата прийому файла квитанції';
COMMENT ON COLUMN BARS.OW_OICREVFILES.TICK_STATUS IS 'Статус прийому файла квитанції';
COMMENT ON COLUMN BARS.OW_OICREVFILES.TICK_ACCEPT_REC IS '';
COMMENT ON COLUMN BARS.OW_OICREVFILES.TICK_REJECT_REC IS '';
COMMENT ON COLUMN BARS.OW_OICREVFILES.KF IS '';




PROMPT *** Create  constraint PK_OWOICREVFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OICREVFILES ADD CONSTRAINT PK_OWOICREVFILES PRIMARY KEY (FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICREVFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OICREVFILES ADD CONSTRAINT CC_OWOICREVFILES_FILEDATE_NN CHECK (FILE_DATE IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWOICREVFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OICREVFILES ADD CONSTRAINT FK_OWOICREVFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICREVFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OICREVFILES MODIFY (KF CONSTRAINT CC_OWOICREVFILES_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICREVFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OICREVFILES ADD CONSTRAINT CC_OWOICREVFILES_FILENAME_NN CHECK (FILE_NAME IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICREVFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICREVFILES ON BARS.OW_OICREVFILES (FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_OICREVFILES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_OICREVFILES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OICREVFILES  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_OICREVFILES  to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OICREVFILES.sql =========*** End **
PROMPT ===================================================================================== 
