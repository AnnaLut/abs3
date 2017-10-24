

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAEK_HEADERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAEK_HEADERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAEK_HEADERS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NAEK_HEADERS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NAEK_HEADERS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAEK_HEADERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAEK_HEADERS 
   (	FILE_YEAR NUMBER(4,0), 
	FILE_NAME VARCHAR2(12), 
	MAKE_TIME DATE, 
	LINES_COUNT NUMBER, 
	STATE NUMBER(*,0) DEFAULT 0, 
	RCPT_TIME DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAEK_HEADERS ***
 exec bpa.alter_policies('NAEK_HEADERS');


COMMENT ON TABLE BARS.NAEK_HEADERS IS 'Заголовки файлов филиалов НАЕК Энергоатом';
COMMENT ON COLUMN BARS.NAEK_HEADERS.FILE_YEAR IS 'Год файла';
COMMENT ON COLUMN BARS.NAEK_HEADERS.FILE_NAME IS 'Имя файла(структуры ^PAbonМД.NNN)';
COMMENT ON COLUMN BARS.NAEK_HEADERS.MAKE_TIME IS 'Время создания файла';
COMMENT ON COLUMN BARS.NAEK_HEADERS.LINES_COUNT IS '';
COMMENT ON COLUMN BARS.NAEK_HEADERS.STATE IS '';
COMMENT ON COLUMN BARS.NAEK_HEADERS.RCPT_TIME IS 'Время приема квитанции на файл';
COMMENT ON COLUMN BARS.NAEK_HEADERS.KF IS '';




PROMPT *** Create  constraint PK_NAEKHEADERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS ADD CONSTRAINT PK_NAEKHEADERS PRIMARY KEY (KF, FILE_YEAR, FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKHEADERS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS ADD CONSTRAINT FK_NAEKHEADERS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKHEADERS_FILEYEAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS MODIFY (FILE_YEAR CONSTRAINT CC_NAEKHEADERS_FILEYEAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKHEADERS_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS MODIFY (FILE_NAME CONSTRAINT CC_NAEKHEADERS_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKHEADERS_MAKETIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS MODIFY (MAKE_TIME CONSTRAINT CC_NAEKHEADERS_MAKETIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKHEADERS_LINESCNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS MODIFY (LINES_COUNT CONSTRAINT CC_NAEKHEADERS_LINESCNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKHEADERS_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS MODIFY (STATE CONSTRAINT CC_NAEKHEADERS_STATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKHEADERS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_HEADERS MODIFY (KF CONSTRAINT CC_NAEKHEADERS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_NAEKHEADERS_STATE_0 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_NAEKHEADERS_STATE_0 ON BARS.NAEK_HEADERS (CASE STATE WHEN 0 THEN 0 ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_NAEKHEADERS_STATE_3 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_NAEKHEADERS_STATE_3 ON BARS.NAEK_HEADERS (CASE STATE WHEN 3 THEN 3 ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NAEKHEADERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NAEKHEADERS ON BARS.NAEK_HEADERS (KF, FILE_YEAR, FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAEK_HEADERS ***
grant SELECT                                                                 on NAEK_HEADERS    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAEK_HEADERS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAEK_HEADERS.sql =========*** End *** 
PROMPT ===================================================================================== 
