

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_QUEUE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_QUEUE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.INT_QUEUE 
   (	KF VARCHAR2(12), 
	BRANCH VARCHAR2(30), 
	INT_ID NUMBER(1,0), 
	ACC_ID NUMBER(38,0), 
	ACC_NUM VARCHAR2(15), 
	ACC_CUR NUMBER(3,0), 
	ACC_NBS CHAR(4), 
	ACC_NAME VARCHAR2(38), 
	ACC_ISO CHAR(3), 
	ACC_OPEN DATE, 
	ACC_AMOUNT NUMBER(38,0), 
	INT_DETAILS VARCHAR2(160), 
	INT_TT CHAR(3), 
	DEAL_ID NUMBER(38,0), 
	DEAL_NUM VARCHAR2(35), 
	DEAL_DAT DATE, 
	CUST_ID NUMBER(38,0), 
	MOD_CODE CHAR(3)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_QUEUE ***
 exec bpa.alter_policies('INT_QUEUE');


COMMENT ON TABLE BARS.INT_QUEUE IS 'Справочник автоматических операций';
COMMENT ON COLUMN BARS.INT_QUEUE.KF IS 'МФО';
COMMENT ON COLUMN BARS.INT_QUEUE.BRANCH IS 'Код подразделения счета';
COMMENT ON COLUMN BARS.INT_QUEUE.INT_ID IS 'Код процентной карточки';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_ID IS 'Внутр.номер счета';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_NUM IS 'Номер счета';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_CUR IS 'Код валюты счета';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_NBS IS 'Бал.счет';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_NAME IS 'Наименование счета';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_ISO IS 'Код валюты ISO';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_OPEN IS 'Дата открытия счета';
COMMENT ON COLUMN BARS.INT_QUEUE.ACC_AMOUNT IS 'Остаток для начисления';
COMMENT ON COLUMN BARS.INT_QUEUE.INT_DETAILS IS 'Назначение платежа';
COMMENT ON COLUMN BARS.INT_QUEUE.INT_TT IS 'Код операции';
COMMENT ON COLUMN BARS.INT_QUEUE.DEAL_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.INT_QUEUE.DEAL_NUM IS 'Номер договора';
COMMENT ON COLUMN BARS.INT_QUEUE.DEAL_DAT IS 'Дата договора';
COMMENT ON COLUMN BARS.INT_QUEUE.CUST_ID IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.INT_QUEUE.MOD_CODE IS 'Код модуля';




PROMPT *** Create  constraint PK_INTQUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE ADD CONSTRAINT PK_INTQUEUE PRIMARY KEY (ACC_ID, INT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (KF CONSTRAINT CC_INTQUEUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (BRANCH CONSTRAINT CC_INTQUEUE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_INTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (INT_ID CONSTRAINT CC_INTQUEUE_INTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_ACCOPEN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (ACC_OPEN CONSTRAINT CC_INTQUEUE_ACCOPEN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_ACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (ACC_NUM CONSTRAINT CC_INTQUEUE_ACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_ACCCUR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (ACC_CUR CONSTRAINT CC_INTQUEUE_ACCCUR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_ACCISO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (ACC_ISO CONSTRAINT CC_INTQUEUE_ACCISO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTQUEUE_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_QUEUE MODIFY (ACC_ID CONSTRAINT CC_INTQUEUE_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTQUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTQUEUE ON BARS.INT_QUEUE (ACC_ID, INT_ID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_QUEUE ***
grant INSERT,SELECT                                                          on INT_QUEUE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_QUEUE       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_QUEUE       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to INT_QUEUE ***

  CREATE OR REPLACE PUBLIC SYNONYM INT_QUEUE FOR BARS.INT_QUEUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_QUEUE.sql =========*** End *** ===
PROMPT ===================================================================================== 
