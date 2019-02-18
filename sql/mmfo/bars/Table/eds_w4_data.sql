PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_W4_DATA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_W4_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_W4_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_W4_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_W4_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_W4_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_W4_DATA 
   (    REQ_ID VARCHAR2(36), 
    RNK NUMBER, 
    ACC NUMBER(38,0), 
    NLS VARCHAR2(30), 
    KV NUMBER(3,0), 
    OPEN_IN VARCHAR2(100), 
    ACC_TYPE VARCHAR2(50), 
    END_BAL NUMBER(10,0), 
    AMOUNT_PERIOD NUMBER(10,0), 
    OTHER_ACCRUALS NUMBER(10,0), 
    KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),
	END_BALQ NUMBER(10),
	AMOUNT_PERIODQ NUMBER(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
execute immediate'alter table EDS_w4_DATA modify nls varchar2(30)';
end;
/
begin
execute immediate'alter table eds_w4_data add end_balq number(10)';
exception when others then 
if sqlcode = -01430 then null; else raise; end if;
end;
/
begin
execute immediate'alter table eds_w4_data add amount_periodq number(10)';
exception when others then 
if sqlcode = -01430 then null; else raise; end if;
end;
/


PROMPT *** ALTER_POLICIES to EDS_W4_DATA ***
 exec bpa.alter_policies('EDS_W4_DATA');


COMMENT ON TABLE BARS.EDS_W4_DATA IS 'Дані Є-декларацій по рах. 2625, 2620';
COMMENT ON COLUMN BARS.EDS_W4_DATA.REQ_ID IS 'Ід запиту';
COMMENT ON COLUMN BARS.EDS_W4_DATA.RNK IS 'Ід клієнта';
COMMENT ON COLUMN BARS.EDS_W4_DATA.ACC IS 'Ід рахунку';
COMMENT ON COLUMN BARS.EDS_W4_DATA.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.EDS_W4_DATA.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.EDS_W4_DATA.OPEN_IN IS 'Відділення в якому відкрито рахунок';
COMMENT ON COLUMN BARS.EDS_W4_DATA.ACC_TYPE IS 'Тип рахунку';
COMMENT ON COLUMN BARS.EDS_W4_DATA.END_BAL IS 'Баланс';
COMMENT ON COLUMN BARS.EDS_W4_DATA.AMOUNT_PERIOD IS 'Сума надходжень на рахунок';
COMMENT ON COLUMN BARS.EDS_W4_DATA.OTHER_ACCRUALS IS 'Інші доходо';
COMMENT ON COLUMN BARS.EDS_W4_DATA.KF IS '';




PROMPT *** Create  index PK_EDS_W4_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_W4_DATA ON BARS.EDS_W4_DATA (REQ_ID, ACC, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_EDS_W4_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_W4_DATA ADD CONSTRAINT PK_EDS_W4_DATA PRIMARY KEY (REQ_ID, ACC, KF)
  USING INDEX PK_EDS_W4_DATA ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EDS_W4_DATA ***
grant SELECT                                                                 on EDS_W4_DATA     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_W4_DATA.sql =========*** End *** =
PROMPT ===================================================================================== 

