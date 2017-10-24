

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OPER.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  table OPER ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OPER 
   (	ID VARCHAR2(15), 
	KL_ID VARCHAR2(15), 
	KL_DATE DATE DEFAULT NULL, 
	MOD_ID VARCHAR2(15), 
	MOD_DATE DATE, 
	OPR_NOM VARCHAR2(38), 
	POPR_NOM VARCHAR2(20), 
	OPR_DATE DATE, 
	POPR_DATE DATE, 
	DOC_IN_DATE DATE, 
	OPR_TIME VARCHAR2(4), 
	OPR_VAL NUMBER(3,0), 
	OPR_SUMV VARCHAR2(19), 
	OPR_SUMG VARCHAR2(19), 
	POPR_NAZN VARCHAR2(254), 
	OPR_NAZN VARCHAR2(254), 
	OPR_KOL NUMBER(2,0), 
	OPR_ACT VARCHAR2(1), 
	OPR_ZV_N VARCHAR2(15), 
	OPR_ZV_D DATE, 
	COMM_ZV VARCHAR2(4000), 
	OPR_OZN VARCHAR2(1), 
	OPR_VID1 VARCHAR2(15), 
	OPR_VID2 VARCHAR2(4) DEFAULT 0000, 
	COMM_VID2 VARCHAR2(254), 
	OPR_VID3 VARCHAR2(3), 
	COMM_VID3 VARCHAR2(254), 
	M_NM1 VARCHAR2(50), 
	M_NM2 VARCHAR2(30), 
	M_NM3 VARCHAR2(30), 
	W_NM1 VARCHAR2(50), 
	W_NM2 VARCHAR2(30), 
	W_NM3 VARCHAR2(30), 
	OPR_DOD VARCHAR2(254), 
	DFILE_ID VARCHAR2(15), 
	FILE_ID VARCHAR2(15), 
	OPR_NUM NUMBER(3,0), 
	ERR_CODE VARCHAR2(4), 
	TERRORISM NUMBER(1,0), 
	STATUS NUMBER(2,0), 
	DROPPED NUMBER(1,0) DEFAULT 0, 
	DROP_ID NUMBER(15,0), 
	DROP_DATE DATE, 
	ACC_ARREST NUMBER(1,0), 
	BRANCH_ID VARCHAR2(15), 
	KL_ID_BRANCH_ID VARCHAR2(15), 
	KL_DATE_BRANCH_ID DATE DEFAULT SYSDATE, 
	MOD_BRANCH_ID VARCHAR2(15), 
	OPR_ZV_BRANCH_ID VARCHAR2(15), 
	OPR_TERROR NUMBER(18,0), 
	OPR_OBL_KOD NUMBER(18,0), 
	COMMENT VARCHAR2(4000), 
	OPR_NBU NUMBER(18,0), 
	RI_NUMB VARCHAR2(15), 
	DAT_I DATE, 
	NEW_OPER_NOM VARCHAR2(38)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OPER IS 'Операции';
COMMENT ON COLUMN FINMON.OPER.ID IS 'Идентификатор записи';
COMMENT ON COLUMN FINMON.OPER.KL_ID IS 'Идентификатор в реестре';
COMMENT ON COLUMN FINMON.OPER.KL_DATE IS 'Дата занесения в реестр';
COMMENT ON COLUMN FINMON.OPER.MOD_ID IS 'Идентификатор рее. модифицируемой записи';
COMMENT ON COLUMN FINMON.OPER.MOD_DATE IS 'Дата рее. модифицируемой записи';
COMMENT ON COLUMN FINMON.OPER.OPR_NOM IS 'Референс операции в АБС';
COMMENT ON COLUMN FINMON.OPER.POPR_NOM IS 'Номер первичного документа';
COMMENT ON COLUMN FINMON.OPER.OPR_DATE IS 'Дата операции';
COMMENT ON COLUMN FINMON.OPER.POPR_DATE IS 'Дата первичного документа';
COMMENT ON COLUMN FINMON.OPER.DOC_IN_DATE IS 'Дата поступления документов-основания операции';
COMMENT ON COLUMN FINMON.OPER.OPR_TIME IS 'Время операции';
COMMENT ON COLUMN FINMON.OPER.OPR_VAL IS 'Код валюты';
COMMENT ON COLUMN FINMON.OPER.OPR_SUMV IS 'Сумма в номинале';
COMMENT ON COLUMN FINMON.OPER.OPR_SUMG IS 'Сумма в эквиваленте (грн)';
COMMENT ON COLUMN FINMON.OPER.POPR_NAZN IS 'Наименование первичного документа';
COMMENT ON COLUMN FINMON.OPER.OPR_NAZN IS 'Назначение платежа';
COMMENT ON COLUMN FINMON.OPER.OPR_KOL IS 'Количество учатников операции';
COMMENT ON COLUMN FINMON.OPER.OPR_ACT IS 'Признак свершенности';
COMMENT ON COLUMN FINMON.OPER.OPR_ZV_N IS 'Идент. рее. связанной операции';
COMMENT ON COLUMN FINMON.OPER.OPR_ZV_D IS 'Дата рее. связанной операции';
COMMENT ON COLUMN FINMON.OPER.COMM_ZV IS 'Комментарий к свяханой операции';
COMMENT ON COLUMN FINMON.OPER.OPR_OZN IS 'Код признака операции';
COMMENT ON COLUMN FINMON.OPER.OPR_VID1 IS 'Код вида операции';
COMMENT ON COLUMN FINMON.OPER.OPR_VID2 IS 'Код признака операции подпадающей под мониторинг';
COMMENT ON COLUMN FINMON.OPER.COMM_VID2 IS 'Комментарий';
COMMENT ON COLUMN FINMON.OPER.OPR_VID3 IS 'Код признака оперции по внутрн. мониторингу';
COMMENT ON COLUMN FINMON.OPER.COMM_VID3 IS 'Комментарий';
COMMENT ON COLUMN FINMON.OPER.M_NM1 IS 'Фамилия исполнителя';
COMMENT ON COLUMN FINMON.OPER.M_NM2 IS 'Имя исполнителя';
COMMENT ON COLUMN FINMON.OPER.M_NM3 IS 'Отчество исполнителя';
COMMENT ON COLUMN FINMON.OPER.W_NM1 IS 'Фамилия сообщивщего';
COMMENT ON COLUMN FINMON.OPER.W_NM2 IS 'Имя сообщившего';
COMMENT ON COLUMN FINMON.OPER.W_NM3 IS 'Отчество сообщившего';
COMMENT ON COLUMN FINMON.OPER.OPR_DOD IS 'Имя файла дополнения';
COMMENT ON COLUMN FINMON.OPER.DFILE_ID IS 'Идентификатор исходящего файла дополнения';
COMMENT ON COLUMN FINMON.OPER.FILE_ID IS 'Идентификатор исходящего файла';
COMMENT ON COLUMN FINMON.OPER.OPR_NUM IS 'Номер записи в исх. файле';
COMMENT ON COLUMN FINMON.OPER.ERR_CODE IS 'Код квитовки';
COMMENT ON COLUMN FINMON.OPER.TERRORISM IS 'Признак операции связю с терроризмом';
COMMENT ON COLUMN FINMON.OPER.STATUS IS 'Статус';
COMMENT ON COLUMN FINMON.OPER.DROPPED IS 'Признак аннулированости операции';
COMMENT ON COLUMN FINMON.OPER.DROP_ID IS 'KL_ID аннулирующей операции';
COMMENT ON COLUMN FINMON.OPER.DROP_DATE IS 'KL_DATE аннулирующей операции';
COMMENT ON COLUMN FINMON.OPER.ACC_ARREST IS 'Признак сообщение - сообщ. об аресте счета';
COMMENT ON COLUMN FINMON.OPER.BRANCH_ID IS 'Привязка к филиалу !';
COMMENT ON COLUMN FINMON.OPER.KL_ID_BRANCH_ID IS 'Идентификатор в реестре филиала';
COMMENT ON COLUMN FINMON.OPER.KL_DATE_BRANCH_ID IS 'Дата занесения в реестр филиала';
COMMENT ON COLUMN FINMON.OPER.MOD_BRANCH_ID IS 'Привязка модифицированной операции к филиалу !';
COMMENT ON COLUMN FINMON.OPER.OPR_ZV_BRANCH_ID IS 'Привязка связанной операции к филиалу !';
COMMENT ON COLUMN FINMON.OPER.OPR_TERROR IS 'Ознака того, що фінансова операція може мати відношення до фінансування терористичної діяльності';
COMMENT ON COLUMN FINMON.OPER.OPR_OBL_KOD IS 'Код області здійснення операції';
COMMENT ON COLUMN FINMON.OPER.COMMENT IS 'Коментар до фінансової операції';
COMMENT ON COLUMN FINMON.OPER.OPR_NBU IS 'Ознака виявлення фінансової операції інспекторами Національного банку';
COMMENT ON COLUMN FINMON.OPER.RI_NUMB IS 'Номер рішення в системі обліку Спеціально уповноваженого органу';
COMMENT ON COLUMN FINMON.OPER.DAT_I IS 'Дата поступления/получения сообщения об операции';
COMMENT ON COLUMN FINMON.OPER.NEW_OPER_NOM IS 'Новий референс операції в АБС';




PROMPT *** Create  constraint XAK_OPER_KL_IDDATE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT XAK_OPER_KL_IDDATE UNIQUE (KL_ID, KL_DATE, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_RI_NUMB ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT FK_OPER_RI_NUMB FOREIGN KEY (RI_NUMB)
	  REFERENCES FINMON.DECISION (RI_NUMB) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_K_DFM02 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_K_DFM02 FOREIGN KEY (OPR_VID2)
	  REFERENCES FINMON.K_DFM02 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_K_DFM03 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_K_DFM03 FOREIGN KEY (OPR_VID3)
	  REFERENCES FINMON.K_DFM03 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_K_DFM06 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_K_DFM06 FOREIGN KEY (OPR_ACT)
	  REFERENCES FINMON.K_DFM06 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_K_DFM10 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_K_DFM10 FOREIGN KEY (OPR_OZN)
	  REFERENCES FINMON.K_DFM10 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_K_DFM14 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_K_DFM14 FOREIGN KEY (ERR_CODE)
	  REFERENCES FINMON.K_DFM14 (CODE) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XAK_OPER_KL_IDDATE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT XAK_OPER_KL_IDDATE_BRANCH UNIQUE (BRANCH_ID, KL_ID_BRANCH_ID, KL_DATE_BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_OPER ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT XPK_OPER PRIMARY KEY (ID, BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_DFILE_OUT ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_DFILE_OUT FOREIGN KEY (DFILE_ID, BRANCH_ID)
	  REFERENCES FINMON.FILE_OUT (ID, BRANCH_ID) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_FILE_OUT ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_FILE_OUT FOREIGN KEY (FILE_ID, BRANCH_ID)
	  REFERENCES FINMON.FILE_OUT (ID, BRANCH_ID) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_DATE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_DATE CONSTRAINT NK_OPER_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_VAL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_VAL CONSTRAINT NK_OPER_VAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_SUMN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_SUMV CONSTRAINT NK_OPER_SUMN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_SUMEQV ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_SUMG CONSTRAINT NK_OPER_SUMEQV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_NAZN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_NAZN CONSTRAINT NK_OPER_NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_KOL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_KOL CONSTRAINT NK_OPER_KOL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_ACT ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_ACT CONSTRAINT NK_OPER_ACT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_OZN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_OZN CONSTRAINT NK_OPER_OZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_VID1 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_VID1 CONSTRAINT NK_OPER_VID1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_VID2 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_VID2 CONSTRAINT NK_OPER_VID2 NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_MNAME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (M_NM1 CONSTRAINT NK_OPER_MNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (BRANCH_ID CONSTRAINT NK_OPER_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_KLID_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (KL_ID_BRANCH_ID CONSTRAINT NK_OPER_KLID_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_OPER_KLDATE_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (KL_DATE_BRANCH_ID CONSTRAINT NK_OPER_KLDATE_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032101 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_TERROR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032102 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_OBL_KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032103 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER MODIFY (OPR_NBU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OPER_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPER ADD CONSTRAINT R_OPER_BANK FOREIGN KEY (BRANCH_ID)
	  REFERENCES FINMON.BANK (ID) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_OPER_KL_IDDATE_UNIQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XAK_OPER_KL_IDDATE_UNIQUE ON FINMON.OPER (KL_ID, TRUNC(KL_DATE,''fmyear''), BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_OPER_KL_IDDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XAK_OPER_KL_IDDATE ON FINMON.OPER (KL_ID, KL_DATE, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_OPER_KLDAT ***
begin   
 execute immediate '
  CREATE INDEX FINMON.XIE_OPER_KLDAT ON FINMON.OPER (KL_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_OPER_KLDAT_BRANCH ***
begin   
 execute immediate '
  CREATE INDEX FINMON.XIE_OPER_KLDAT_BRANCH ON FINMON.OPER (KL_DATE_BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OPER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_OPER ON FINMON.OPER (ID, BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_OPER_KL_IDDATE_BRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XAK_OPER_KL_IDDATE_BRANCH ON FINMON.OPER (BRANCH_ID, KL_ID_BRANCH_ID, KL_DATE_BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPER ***
grant SELECT                                                                 on OPER            to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OPER.sql =========*** End *** ======
PROMPT ===================================================================================== 
