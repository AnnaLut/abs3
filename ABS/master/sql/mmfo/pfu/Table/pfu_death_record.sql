

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_RECORD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_DEATH_RECORD ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_DEATH_RECORD 
   (	ID NUMBER(38,0), 
	LIST_ID NUMBER(38,0), 
	REC_NUM NUMBER(10,0), 
	LAST_NAME VARCHAR2(70), 
	FIRST_NAME VARCHAR2(50), 
	FATHER_NAME VARCHAR2(50), 
	OKPO VARCHAR2(14), 
	DOC_NUM VARCHAR2(14), 
	NUM_ACC VARCHAR2(19), 
	BANK_MFO VARCHAR2(6), 
	BANK_NUM VARCHAR2(10), 
	DATE_DEAD DATE, 
	DEATH_AKT VARCHAR2(20), 
	DATE_AKT DATE, 
	SUM_OVER NUMBER(19,0), 
	PERIOD VARCHAR2(30), 
	DATE_PAY DATE, 
	SUM_PAY NUMBER(19,0), 
	TYPE_BLOCK NUMBER(1,0), 
	PFU_NUM VARCHAR2(20), 
	STATE VARCHAR2(30), 
	COMM VARCHAR2(3000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_DEATH_RECORD IS 'Информационная строка списка умерших';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.ID IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.LIST_ID IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.REC_NUM IS 'Порядковий номер запису';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.LAST_NAME IS 'Прізвище';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.FIRST_NAME IS 'Ім’я';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.FATHER_NAME IS 'По батькові';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.OKPO IS 'РНОКПП';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.DOC_NUM IS 'Серія та номер паспорту';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.NUM_ACC IS 'Номер рахунку клієнту-пенсіонера';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.BANK_MFO IS 'Код МФО банку';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.BANK_NUM IS 'Номер філії/відділення банку, через який здійснювалися пенсійні виплати';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.DATE_DEAD IS 'Дата смерті ';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.DEATH_AKT IS 'Номер актового запису про смерть';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.DATE_AKT IS 'Дата актового запису про смерть';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.SUM_OVER IS 'Сума переплати коштів пенсіонеру';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.PERIOD IS 'Періоди, за які виникла переплата';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.DATE_PAY IS 'Дата виплати коштів пенсіонеру за поточний місяць';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.SUM_PAY IS 'Сума виплати за поточний місяць';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.TYPE_BLOCK IS 'Ознака блокування/ зняття';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.PFU_NUM IS '';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.STATE IS 'Статус записи';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORD.COMM IS 'Комментарий';




PROMPT *** Create  constraint SYS_C00111462 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_RECORD MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PFU_DEATH_RECORD ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_RECORD ADD CONSTRAINT FK_PFU_DEATH_RECORD FOREIGN KEY (LIST_ID)
	  REFERENCES PFU.PFU_DEATH (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_DEATH_RECORD ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_RECORD ADD CONSTRAINT PK_PFU_DEATH_RECORD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111463 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_RECORD MODIFY (LIST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_DEATH_RECORD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_DEATH_RECORD ON PFU.PFU_DEATH_RECORD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** ADD field sum_payed ***
begin
    execute immediate 'alter table PFU.PFU_DEATH_RECORD add sum_payed NUMBER(38)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ADD field ref ***
begin
    execute immediate 'alter table PFU.PFU_DEATH_RECORD add ref NUMBER(38)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ADD field sign ***
begin
    execute immediate 'alter table PFU.PFU_DEATH_RECORD add sign VARCHAR2(1000)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ADD field typ ***
begin
    execute immediate 'alter table PFU.PFU_DEATH_RECORD add typ VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ADD field date_payback ***
begin
    execute immediate 'alter table PFU_DEATH_RECORD add date_payback date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ADD field num_paym ***
begin
    execute immediate 'alter table PFU_DEATH_RECORD add num_paym varchar2(1000)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


-- Add comments to the columns 
comment on column PFU.PFU_DEATH_RECORD.sum_payed is 'Сума фактичного списання ';
comment on column PFU.PFU_DEATH_RECORD.ref is 'Референс списання';
comment on column PFU.PFU_DEATH_RECORD.sign is 'Подпись';
comment on column PFU.PFU_DEATH_RECORD.typ is 'Тит оплаты';


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_RECORD.sql =========*** End *
PROMPT ===================================================================================== 
