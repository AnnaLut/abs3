

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF_SKIDKA.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TARIFF_SKIDKA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TARIFF_SKIDKA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TARIFF_SKIDKA'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_TARIFF_SKIDKA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TARIFF_SKIDKA ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TARIFF_SKIDKA 
   (	TARIFF NUMBER, 
	TARIFF_DATE DATE, 
	PROC NUMBER, 
	MONTHS NUMBER, 
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




PROMPT *** ALTER_POLICIES to SKRYNKA_TARIFF_SKIDKA ***
 exec bpa.alter_policies('SKRYNKA_TARIFF_SKIDKA');


COMMENT ON TABLE BARS.SKRYNKA_TARIFF_SKIDKA IS 'скидка по типу тарифа 1';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_SKIDKA.TARIFF IS 'код тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_SKIDKA.TARIFF_DATE IS 'дата ввода тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_SKIDKA.PROC IS 'процент скидки';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_SKIDKA.MONTHS IS 'кол-во месяцев';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_SKIDKA.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF_SKIDKA.KF IS '';


begin 
  execute immediate 
    ' ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA DROP CONSTRAINT PK_SKRYNKATARIFFSKIDKA';
exception when others then 
  if sqlcode=-2443 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' DROP INDEX BARS.PK_SKRYNKATARIFFSKIDKA';
exception when others then 
  if sqlcode=-1418 then null; else raise; end if;
end;
/
 

PROMPT *** Create  constraint PK_SKRYNKATARIFFSKIDKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA ADD CONSTRAINT PK_SKRYNKATARIFFSKIDKA PRIMARY KEY (TARIFF, TARIFF_DATE, MONTHS, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFFSKIDKA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA ADD CONSTRAINT FK_SKRYNKATARIFFSKIDKA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRTRFSK_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA ADD CONSTRAINT FK_SKRTRFSK_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFFSKIDKA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA ADD CONSTRAINT FK_SKRYNKATARIFFSKIDKA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFFSKIDKA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA MODIFY (KF CONSTRAINT CC_SKRYNKATARIFFSKIDKA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF_SK_TRD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA MODIFY (TARIFF_DATE CONSTRAINT NN_SKRYNKA_TARIFF_SK_TRD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF_SK_MON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA MODIFY (MONTHS CONSTRAINT NN_SKRYNKA_TARIFF_SK_MON NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRTARIFSKIDKA_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA MODIFY (BRANCH CONSTRAINT CC_SKRTARIFSKIDKA_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF_SK_TRF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA MODIFY (TARIFF CONSTRAINT NN_SKRYNKA_TARIFF_SK_TRF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKATARIFFSKIDKA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKATARIFFSKIDKA ON BARS.SKRYNKA_TARIFF_SKIDKA (TARIFF, TARIFF_DATE, MONTHS, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TARIFF_SKIDKA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_TARIFF_SKIDKA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_TARIFF_SKIDKA to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_TARIFF_SKIDKA to DEP_SKRN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TARIFF_SKIDKA to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_TARIFF_SKIDKA ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_TARIFF_SKIDKA FOR BARS.SKRYNKA_TARIFF_SKIDKA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF_SKIDKA.sql =========***
PROMPT ===================================================================================== 
