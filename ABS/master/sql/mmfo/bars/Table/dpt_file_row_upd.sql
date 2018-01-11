

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_FILE_ROW_UPD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_FILE_ROW_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_FILE_ROW_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_FILE_ROW_UPD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_FILE_ROW_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_FILE_ROW_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_FILE_ROW_UPD 
   (	REC_ID NUMBER(38,0), 
	ROW_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	USER_ID NUMBER(38,0), 
	SYSDAT DATE, 
	BNKDAT DATE, 
	COLUMNAME VARCHAR2(30), 
	OLD_VALUE VARCHAR2(100), 
	NEW_VALUE VARCHAR2(100), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_FILE_ROW_UPD ***
 exec bpa.alter_policies('DPT_FILE_ROW_UPD');


COMMENT ON TABLE BARS.DPT_FILE_ROW_UPD IS 'Изменения данных файлов зачислений от ОСЗ';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.REC_ID IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.ROW_ID IS 'Идентификатор строки файла';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.SYSDAT IS 'Календарная дата изменения';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.BNKDAT IS 'Банковская дата изменения';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.COLUMNAME IS 'Название редактируемого реквизита';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.OLD_VALUE IS 'Старое значение реквизита';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.NEW_VALUE IS 'Новое значение реквизита';
COMMENT ON COLUMN BARS.DPT_FILE_ROW_UPD.KF IS 'Код фiлiалу (МФО)';




PROMPT *** Create  constraint CC_DPTFILEROWUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (KF CONSTRAINT CC_DPTFILEROWUPD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (REC_ID CONSTRAINT CC_DPTFILEROWUPD_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_ROWID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (ROW_ID CONSTRAINT CC_DPTFILEROWUPD_ROWID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (BRANCH CONSTRAINT CC_DPTFILEROWUPD_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (USER_ID CONSTRAINT CC_DPTFILEROWUPD_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_SYSDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (SYSDAT CONSTRAINT CC_DPTFILEROWUPD_SYSDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_BNKDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (BNKDAT CONSTRAINT CC_DPTFILEROWUPD_BNKDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_COLUMNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD MODIFY (COLUMNAME CONSTRAINT CC_DPTFILEROWUPD_COLUMNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTFILEROWUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD ADD CONSTRAINT PK_DPTFILEROWUPD PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROWUPD_VALUES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_UPD ADD CONSTRAINT CC_DPTFILEROWUPD_VALUES CHECK ( nvl(old_value, ''_'') <> nvl(new_value,''_'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTFILEROWUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTFILEROWUPD ON BARS.DPT_FILE_ROW_UPD (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTFILEROWUPD_KF_ROWID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTFILEROWUPD_KF_ROWID ON BARS.DPT_FILE_ROW_UPD (KF, ROW_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_FILE_ROW_UPD ***
grant SELECT                                                                 on DPT_FILE_ROW_UPD to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_FILE_ROW_UPD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_FILE_ROW_UPD to BARS_DM;
grant SELECT                                                                 on DPT_FILE_ROW_UPD to RPBN001;
grant SELECT                                                                 on DPT_FILE_ROW_UPD to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FILE_ROW_UPD to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPT_FILE_ROW_UPD to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_FILE_ROW_UPD.sql =========*** End 
PROMPT ===================================================================================== 
