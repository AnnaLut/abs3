PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_CREDIT_DATA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_CREDIT_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_CREDIT_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CREDIT_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CREDIT_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_CREDIT_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_CREDIT_DATA 
   (REQ_ID VARCHAR2(36), 
    RNK NUMBER, 
    ACC NUMBER(38,0), 
    ND NUMBER(22,0), 
    VIDD NUMBER(10,0), 
    KV NUMBER(3,0), 
    OPEN_IN VARCHAR2(100), 
    SDATE DATE, 
    BALANCE_DEBT NUMBER(10,0), 
    AMOUNT_PAY_PROC NUMBER(10,0), 
    AMOUNT_PAY_PRINCIPAL NUMBER(10,0), 
    SUM_TOTALY_CREDIT NUMBER(10,0), 
    KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),
	SUM_ZAGAL NUMBER(10),
	CREDIT_TYPE VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
execute immediate'alter table EDS_CREDIT_DATA add SUM_ZAGAL NUMBER(10)';
exception when others then 
if sqlcode = -01430 then null; else raise; end if;
end;
/

begin
execute immediate'alter table eds_credit_data add credit_type varchar2(30)';
exception when others then 
if sqlcode = -01430 then null; else raise; end if;
end;
/


PROMPT *** ALTER_POLICIES to EDS_CREDIT_DATA ***
 exec bpa.alter_policies('EDS_CREDIT_DATA');


COMMENT ON TABLE BARS.EDS_CREDIT_DATA IS 'Дані Є-дакларацій кредити';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.REQ_ID IS 'Ід запиту';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.RNK IS 'Ід клієнта';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.ACC IS 'Ід рахунку';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.ND IS 'Номер документу';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.VIDD IS 'Тип кредиту';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.OPEN_IN IS 'Відділення де відкрито рахунок';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.SDATE IS 'Дата оформлення кредиту';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.BALANCE_DEBT IS 'Залишок невиплаченого кредиту';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.AMOUNT_PAY_PROC IS 'Кількість виплачених процентів';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.AMOUNT_PAY_PRINCIPAL IS 'Сума оплаченого кредиту';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.SUM_TOTALY_CREDIT IS 'Сума кредиту';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.SUM_ZAGAL IS 'Сума договору';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.KF IS '';




PROMPT *** Create  index PK_EDS_CREDIT_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_CREDIT_DATA ON BARS.EDS_CREDIT_DATA (REQ_ID, ND, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_EDS_CREDIT_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_CREDIT_DATA ADD CONSTRAINT PK_EDS_CREDIT_DATA PRIMARY KEY (REQ_ID, ND, KF)
  USING INDEX PK_EDS_CREDIT_DATA ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EDS_CREDIT_DATA ***
grant SELECT                                                                 on EDS_CREDIT_DATA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_CREDIT_DATA.sql =========*** End *
PROMPT ===================================================================================== 

