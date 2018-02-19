

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F504.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F504 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F504'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F504'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F504 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F504 
   (	F504_ID NUMBER, 
	CONTR_ID NUMBER, 
	P_DATE_TO DATE DEFAULT sysdate, 
	DATE_REG DATE DEFAULT sysdate, 
	USER_REG VARCHAR2(30), 
	DATE_CH DATE, 
	USER_CH VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	P101 VARCHAR2(27), 
	Z VARCHAR2(10), 
	R_AGREE_NO VARCHAR2(5), 
	P103 DATE, 
	PVAL VARCHAR2(3), 
	T VARCHAR2(2) DEFAULT ''0'', 
	M NUMBER(2,0), 
	P107 VARCHAR2(54), 
	P108 NUMBER(2,0), 
	P184 NUMBER(2,0), 
	P140 NUMBER(2,0), 
	P142 NUMBER(2,0), 
	P141 NUMBER(2,0), 
	P020 VARCHAR2(4), 
	P143 NUMBER(2,0), 
	P050 VARCHAR2(16), 
	P060 DATE, 
	P090 NUMBER, 
	P960 NUMBER(2,0), 
	P310 DATE, 
	P999 VARCHAR2(108), 
	P212 CHAR(1) DEFAULT ''V'', 
	P213 CHAR(1) DEFAULT ''V'', 
	P201 CHAR(1) DEFAULT ''V'', 
	P222 CHAR(1) DEFAULT ''V'', 
	P223 CHAR(1) DEFAULT ''V'', 
	P292 CHAR(1) DEFAULT ''V'', 
	P293 CHAR(1) DEFAULT ''V''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F504 ***
 exec bpa.alter_policies('CIM_F504');


COMMENT ON TABLE BARS.CIM_F504 IS 'Дані для звіту f504';
COMMENT ON COLUMN BARS.CIM_F504.F504_ID IS '';
COMMENT ON COLUMN BARS.CIM_F504.CONTR_ID IS 'Внутрішній код контракту';
COMMENT ON COLUMN BARS.CIM_F504.P_DATE_TO IS 'Звіт сформований на дату';
COMMENT ON COLUMN BARS.CIM_F504.DATE_REG IS 'Додано у звіт';
COMMENT ON COLUMN BARS.CIM_F504.USER_REG IS 'Користувач додав у звіт';
COMMENT ON COLUMN BARS.CIM_F504.DATE_CH IS 'Останне редагування';
COMMENT ON COLUMN BARS.CIM_F504.USER_CH IS 'Користувач редагування';
COMMENT ON COLUMN BARS.CIM_F504.BRANCH IS 'Номер відділеня';
COMMENT ON COLUMN BARS.CIM_F504.KF IS 'МФО';
COMMENT ON COLUMN BARS.CIM_F504.P101 IS 'Найменування позичальника';
COMMENT ON COLUMN BARS.CIM_F504.Z IS 'Код позичальника';
COMMENT ON COLUMN BARS.CIM_F504.R_AGREE_NO IS 'Номер реєстрації договору(свідоцтва)';
COMMENT ON COLUMN BARS.CIM_F504.P103 IS 'Дата реєстраційного свідоцтва';
COMMENT ON COLUMN BARS.CIM_F504.PVAL IS 'Код валюти';
COMMENT ON COLUMN BARS.CIM_F504.T IS 'Номер траншу(може бути літерою)';
COMMENT ON COLUMN BARS.CIM_F504.M IS 'Ознака кредиту';
COMMENT ON COLUMN BARS.CIM_F504.P107 IS 'Назва кредитора або кредитної лінії';
COMMENT ON COLUMN BARS.CIM_F504.P108 IS 'Тип кредитора';
COMMENT ON COLUMN BARS.CIM_F504.P184 IS 'Строковість кредиту';
COMMENT ON COLUMN BARS.CIM_F504.P140 IS 'Тип кредиту';
COMMENT ON COLUMN BARS.CIM_F504.P142 IS 'Код періодичності здійснення платежів';
COMMENT ON COLUMN BARS.CIM_F504.P141 IS 'Дострокове погашення';
COMMENT ON COLUMN BARS.CIM_F504.P020 IS 'Номер балансового рахунку';
COMMENT ON COLUMN BARS.CIM_F504.P143 IS 'Підстава подання звіту';
COMMENT ON COLUMN BARS.CIM_F504.P050 IS 'Номер кредитної угоди';
COMMENT ON COLUMN BARS.CIM_F504.P060 IS 'Дата кредитної угоди';
COMMENT ON COLUMN BARS.CIM_F504.P090 IS 'Загальна сума кредиту';
COMMENT ON COLUMN BARS.CIM_F504.P960 IS 'Цілі використання кредиту';
COMMENT ON COLUMN BARS.CIM_F504.P310 IS 'Строк погашення кредиту';
COMMENT ON COLUMN BARS.CIM_F504.P999 IS 'Примітка';
COMMENT ON COLUMN BARS.CIM_F504.P212 IS 'сума строкових платежів зі сплати ОС боргу(без урахування майбутніх надходжень кредиту)';
COMMENT ON COLUMN BARS.CIM_F504.P213 IS 'сума строкових платежів зі сплати проц. платежів(без урахування майбутніх надходжень кредиту)';
COMMENT ON COLUMN BARS.CIM_F504.P201 IS 'сума майбутнього надходження кредиту';
COMMENT ON COLUMN BARS.CIM_F504.P222 IS 'сума строкових платежів зі сплати ОС боргу';
COMMENT ON COLUMN BARS.CIM_F504.P223 IS 'сума строкових платежів зі сплати проц. платежів';
COMMENT ON COLUMN BARS.CIM_F504.P292 IS 'сума прогнозних платежів з погашення простроченої заборгованості за основною сумою боргу';
COMMENT ON COLUMN BARS.CIM_F504.P293 IS 'сума прогнозних платежів з погашення простроченої заборгованості за процентними платежами';




PROMPT *** Create  constraint PK_F504_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504 ADD CONSTRAINT PK_F504_ID PRIMARY KEY (F504_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_F504_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_F504_ID ON BARS.CIM_F504 (F504_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.cim_f504 add (p010  number(1))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f504.p010 IS 'вид позичальника';

begin
    execute immediate 'alter table bars.cim_f504 add (p320  number(1))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f504.p320 IS 'Код типу реорганізації';

begin
    execute immediate 'alter table bars.cim_f504 modify p010  number(2)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table bars.cim_f504 add (p040  number(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f504.p040 IS 'Тип процентної ставки';

begin
    execute immediate 'alter table bars.cim_f504 add (p330  VARCHAR2(3))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f504.p330 IS 'Код валюти розрахунків';

begin
    execute immediate 'alter table bars.cim_f504 add (p080  VARCHAR2(15))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f504.p080 IS 'База для обчислення плаваючої ставки за кредитом';

begin
    execute immediate 'alter table bars.cim_f504 add (p070  NUMBER(9,4))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f504.p070 IS 'Розмір маржі процентної ставки за кредитом';


begin
    execute immediate 'alter table bars.cim_f504 add (P950 NUMBER(6,3))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN bars.cim_f504.p950 IS 'Величина процентної ставки за кредитом боргу';

begin
    execute immediate 'alter table bars.cim_f504 add (P030 VARCHAR2(3))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_F504.P030 IS 'Код країни кредитора';

PROMPT *** Create  grants  CIM_F504 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F503        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_F503        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F504.sql =========*** End *** ====
PROMPT ===================================================================================== 
