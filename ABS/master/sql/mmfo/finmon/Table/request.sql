

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/REQUEST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table REQUEST ***
begin 
  execute immediate '
  CREATE TABLE FINMON.REQUEST 
   (	ID VARCHAR2(15), 
	KL_ID VARCHAR2(15), 
	KL_DATE DATE, 
	IN_DATE DATE, 
	IN_N NUMBER(3,0), 
	FILE_I_ID VARCHAR2(15), 
	TEXT VARCHAR2(4000 CHAR), 
	ANSW VARCHAR2(4000 CHAR), 
	FILE_O_ID VARCHAR2(15), 
	OUT_N NUMBER(3,0), 
	RESP_DOD VARCHAR2(254), 
	DFILE_ID VARCHAR2(15), 
	STATUS NUMBER(1,0), 
	ERR_CODE VARCHAR2(4), 
	ZAP_NMB VARCHAR2(15), 
	ZAP_TYPE NUMBER(2,0), 
	ZAP_DATE DATE, 
	TYPE_DOD VARCHAR2(5), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.REQUEST IS 'Запросы на уточнение информации по операции';
COMMENT ON COLUMN FINMON.REQUEST.ID IS 'Идентификатор записи';
COMMENT ON COLUMN FINMON.REQUEST.KL_ID IS 'Идентификатор операции в реестре';
COMMENT ON COLUMN FINMON.REQUEST.KL_DATE IS 'Дата занесения операции в реестр';
COMMENT ON COLUMN FINMON.REQUEST.IN_DATE IS 'Дата запроса';
COMMENT ON COLUMN FINMON.REQUEST.IN_N IS 'Номер порядковой записи в файле';
COMMENT ON COLUMN FINMON.REQUEST.FILE_I_ID IS 'Идентификатор файла запроса';
COMMENT ON COLUMN FINMON.REQUEST.TEXT IS 'Текст запроса';
COMMENT ON COLUMN FINMON.REQUEST.ANSW IS 'Ответ';
COMMENT ON COLUMN FINMON.REQUEST.FILE_O_ID IS 'Идентификатор файла ответа';
COMMENT ON COLUMN FINMON.REQUEST.OUT_N IS 'Номер порядковой записи в файле ответа';
COMMENT ON COLUMN FINMON.REQUEST.RESP_DOD IS 'Имя файла дополнения с путем';
COMMENT ON COLUMN FINMON.REQUEST.DFILE_ID IS 'Ид файла Е - дополнения';
COMMENT ON COLUMN FINMON.REQUEST.STATUS IS 'Статус запроса';
COMMENT ON COLUMN FINMON.REQUEST.ERR_CODE IS '';
COMMENT ON COLUMN FINMON.REQUEST.ZAP_NMB IS 'Номер запиту в системі обліку Спеціально уповноваженого органу';
COMMENT ON COLUMN FINMON.REQUEST.ZAP_TYPE IS 'Вид запиту';
COMMENT ON COLUMN FINMON.REQUEST.ZAP_DATE IS 'Дата запиту';
COMMENT ON COLUMN FINMON.REQUEST.TYPE_DOD IS 'Формат даних у файлі-додатку';
COMMENT ON COLUMN FINMON.REQUEST.BRANCH_ID IS '';




PROMPT *** Create  constraint R_REQUEST_DFILE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST ADD CONSTRAINT R_REQUEST_DFILE FOREIGN KEY (DFILE_ID, BRANCH_ID)
	  REFERENCES FINMON.FILE_OUT (ID, BRANCH_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_REQUEST_FILEIN ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST ADD CONSTRAINT R_REQUEST_FILEIN FOREIGN KEY (FILE_I_ID, BRANCH_ID)
	  REFERENCES FINMON.FILE_IN (ID, BRANCH_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_REQUEST_FILEOUT ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST ADD CONSTRAINT R_REQUEST_FILEOUT FOREIGN KEY (FILE_O_ID, BRANCH_ID)
	  REFERENCES FINMON.FILE_OUT (ID, BRANCH_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST ADD CONSTRAINT XPK_REQUEST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032118 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST MODIFY (ZAP_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_REQ_IN_N ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST MODIFY (IN_N CONSTRAINT NK_REQ_IN_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032116 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST MODIFY (ZAP_NMB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032117 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST MODIFY (ZAP_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_REQ_IN_DATE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.REQUEST MODIFY (IN_DATE CONSTRAINT NK_REQ_IN_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_REQUEST ON FINMON.REQUEST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REQUEST ***
grant SELECT                                                                 on REQUEST         to BARS;



PROMPT *** Create SYNONYM  to REQUEST ***

  CREATE OR REPLACE PUBLIC SYNONYM REQUEST FOR FINMON.REQUEST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/REQUEST.sql =========*** End *** ===
PROMPT ===================================================================================== 
