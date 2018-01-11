

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/W4_EPP_STATUSES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table W4_EPP_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE PFU.W4_EPP_STATUSES 
   (	ID NUMBER(38,0), 
	DATEIN DATE, 
	NLS VARCHAR2(14), 
	ID_EPP VARCHAR2(12), 
	OPER_TYPE VARCHAR2(2), 
	CH_PASS NUMBER(1,0), 
	COMMENTS VARCHAR2(100), 
	WORK_STATE NUMBER(1,0) DEFAULT 0, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.W4_EPP_STATUSES IS '';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.KF IS '';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.ID IS 'Унікальний ідентифікатор операції в Way4';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.DATEIN IS 'Дата операції';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.NLS IS 'Номер аналітичного рахунку';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.ID_EPP IS 'Ідентифікатор електронного пенсійного посвідчення ';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.OPER_TYPE IS 'Тип операції';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.CH_PASS IS 'Підтвердження зміни особою паролю для ЕЦП';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.COMMENTS IS 'Коментар';
COMMENT ON COLUMN PFU.W4_EPP_STATUSES.WORK_STATE IS '';




PROMPT *** Create  constraint SYS_C00111451 ***
begin   
 execute immediate '
  ALTER TABLE PFU.W4_EPP_STATUSES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111452 ***
begin   
 execute immediate '
  ALTER TABLE PFU.W4_EPP_STATUSES MODIFY (WORK_STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4_EPP_STATUSES ***
begin   
 execute immediate '
  ALTER TABLE PFU.W4_EPP_STATUSES ADD CONSTRAINT PK_W4_EPP_STATUSES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_W4_EPP_STATUSES_ID_EPP ***
begin   
 execute immediate '
  CREATE INDEX PFU.I_W4_EPP_STATUSES_ID_EPP ON PFU.W4_EPP_STATUSES (ID_EPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4_EPP_STATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_W4_EPP_STATUSES ON PFU.W4_EPP_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_EPP_STATUSES ***
grant SELECT                                                                 on W4_EPP_STATUSES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_EPP_STATUSES to CM_0001;
grant INSERT,SELECT,UPDATE                                                   on W4_EPP_STATUSES to CM_ACCESS_ROLE;
grant SELECT                                                                 on W4_EPP_STATUSES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/W4_EPP_STATUSES.sql =========*** End **
PROMPT ===================================================================================== 
