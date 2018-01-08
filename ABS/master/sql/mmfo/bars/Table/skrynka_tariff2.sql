

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TARIFF2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TARIFF2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TARIFF2'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_TARIFF2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TARIFF2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TARIFF2 
   (	TARIFF NUMBER, 
	TARIFF_DATE DATE, 
	DAYSFROM NUMBER, 
	DAYSTO NUMBER, 
	S NUMBER, 
	FLAG1 NUMBER, 
	PROC NUMBER, 
	PENY NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TARIFF2 ***
 exec bpa.alter_policies('SKRYNKA_TARIFF2');


COMMENT ON TABLE BARS.SKRYNKA_TARIFF2 IS 'описание ставки тарифа по типу 2';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.TARIFF IS 'код тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.TARIFF_DATE IS 'дата ввода тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.DAYSFROM IS 'начало периода в днях';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.DAYSTO IS 'конец периода в днях';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.S IS 'сумма тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.FLAG1 IS '1 - сумма тарифа за 1 календарній день 2 - сумма тарифа за 30 календарных дней';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.PROC IS 'процент скидки';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.PENY IS 'Дневная ставка штрафа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF2.KF IS '';


  
begin 
  execute immediate 
    ' ALTER TABLE BARS.SKRYNKA_TARIFF2 DROP CONSTRAINT PK_SKRYNKATARIFF2';
exception when others then 
  if sqlcode=-2443 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' DROP INDEX BARS.PK_SKRYNKATARIFF2';
exception when others then 
  if sqlcode=-1418 then null; else raise; end if;
end;
/
 

PROMPT *** Create  constraint PK_SKRYNKATARIFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 ADD CONSTRAINT PK_SKRYNKATARIFF2 PRIMARY KEY (TARIFF, TARIFF_DATE, DAYSFROM, DAYSTO, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF2_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 ADD CONSTRAINT FK_SKRYNKATARIFF2_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRTARIFF2_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 ADD CONSTRAINT FK_SKRTARIFF2_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF2_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 ADD CONSTRAINT FK_SKRYNKATARIFF2_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFF2_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 MODIFY (KF CONSTRAINT CC_SKRYNKATARIFF2_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF2_TARIFF_DATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 MODIFY (TARIFF_DATE CONSTRAINT NN_SKRYNKA_TARIFF2_TARIFF_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF2_DAYSFROM ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 MODIFY (DAYSFROM CONSTRAINT NN_SKRYNKA_TARIFF2_DAYSFROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF2_DAYSTO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 MODIFY (DAYSTO CONSTRAINT NN_SKRYNKA_TARIFF2_DAYSTO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFF2_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 MODIFY (BRANCH CONSTRAINT CC_SKRYNKATARIFF2_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF2_TARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF2 MODIFY (TARIFF CONSTRAINT NN_SKRYNKA_TARIFF2_TARIFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKATARIFF2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKATARIFF2 ON BARS.SKRYNKA_TARIFF2 (TARIFF, TARIFF_DATE, DAYSFROM, DAYSTO, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TARIFF2 ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TARIFF2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_TARIFF2 to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TARIFF2 to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_TARIFF2 to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TARIFF2 to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_TARIFF2 to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_TARIFF2 ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_TARIFF2 FOR BARS.SKRYNKA_TARIFF2;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF2.sql =========*** End *
PROMPT ===================================================================================== 
