

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_FILES 
   (	FILE_ID NUMBER, 
	SQL_ID NUMBER, 
	FILE_CODE VARCHAR2(50), 
	FILENAME_PRFX VARCHAR2(50), 
	EQVSPACE NUMBER(1,0) DEFAULT 0, 
	DELIMM VARCHAR2(20), 
	DEC_DELIMM CHAR(1), 
	ENDLINE VARCHAR2(20), 
	HEAD_LINE NUMBER(1,0) DEFAULT 0, 
	DESCRIPT VARCHAR2(250), 
	ORDER_ID NUMBER(5,0), 
	NULLVAL VARCHAR2(10), 
	DATA_TYPE VARCHAR2(5), 
	DOMAIN_CODE VARCHAR2(6), 
	ISACTIVE NUMBER(1,0) DEFAULT 0, 
	SEQ_CASHE NUMBER, 
	GK_INDICATOR NUMBER(1,0) DEFAULT 1, 
	MASTER_CKGK VARCHAR2(50), 
	CRITICAL_FLG NUMBER(1,0) DEFAULT 0, 
	PARTITIONED NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_FILES IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.FILE_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.SQL_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.FILE_CODE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.FILENAME_PRFX IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.EQVSPACE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.DELIMM IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.DEC_DELIMM IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.ENDLINE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.HEAD_LINE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.DESCRIPT IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.ORDER_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.NULLVAL IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.DATA_TYPE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.DOMAIN_CODE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.ISACTIVE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.SEQ_CASHE IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.GK_INDICATOR IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.MASTER_CKGK IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.CRITICAL_FLG IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILES.PARTITIONED IS '';




PROMPT *** Create  constraint CC_UPLFILES_GKINDICATOR ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES ADD CONSTRAINT CC_UPLFILES_GKINDICATOR CHECK ( GK_INDICATOR in ( 0, 1 ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLFILES ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES ADD CONSTRAINT PK_UPLFILES PRIMARY KEY (FILE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_UPLFILES_FILECODE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES ADD CONSTRAINT UK_UPLFILES_FILECODE UNIQUE (FILE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLFILES_PARTITIONED ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES ADD CONSTRAINT CC_UPLFILES_PARTITIONED CHECK ( PARTITIONED in ( 0, 1 ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLFILES_FILECODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES MODIFY (FILE_CODE CONSTRAINT CC_UPLFILES_FILECODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLFILES_FILENAMEPRFX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES MODIFY (FILENAME_PRFX CONSTRAINT CC_UPLFILES_FILENAMEPRFX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLFILES_CRITICALFLG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES MODIFY (CRITICAL_FLG CONSTRAINT CC_UPLFILES_CRITICALFLG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLFILES_CRITICALFLG ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILES ADD CONSTRAINT CC_UPLFILES_CRITICALFLG CHECK ( CRITICAL_FLG in ( 0, 1, 2 ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLFILES ON BARSUPL.UPL_FILES (FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_UPLFILES_FILECODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UK_UPLFILES_FILECODE ON BARSUPL.UPL_FILES (FILE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_FILES ***
grant SELECT                                                                 on UPL_FILES       to BARS;
grant SELECT                                                                 on UPL_FILES       to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_FILES       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILES.sql =========*** End *** 
PROMPT ===================================================================================== 
