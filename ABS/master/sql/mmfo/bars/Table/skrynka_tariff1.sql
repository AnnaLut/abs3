

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF1.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TARIFF1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TARIFF1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TARIFF1'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_TARIFF1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TARIFF1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TARIFF1 
   (	TARIFF NUMBER, 
	TARIFF_DATE DATE, 
	MONTHS NUMBER, 
	DAYS NUMBER, 
	PENY NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	MONTHS3 NUMBER, 
	MONTHS6 NUMBER, 
	MONTHS9 NUMBER, 
	MONTHS12 NUMBER, 
	MONTHS15 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TARIFF1 ***
 exec bpa.alter_policies('SKRYNKA_TARIFF1');


COMMENT ON TABLE BARS.SKRYNKA_TARIFF1 IS 'описание ставки тарифа по типу 1';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.TARIFF IS 'код тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.TARIFF_DATE IS 'дата ввода тарифа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.MONTHS IS 'сумма за мес€ц аренды c';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.DAYS IS 'сумма за день аренды';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.PENY IS 'ƒневна€ ставка штрафа';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.KF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.MONTHS3 IS '—ума за 3 м≥с€ц≥';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.MONTHS6 IS '—ума за 6 м≥с€ц≥в';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.MONTHS9 IS '—ума за 9 м≥с€ц≥в';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.MONTHS12 IS '—ума за 12 м≥с€ц≥в';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF1.MONTHS15 IS '—ума 12-15 м≥с€ц≥в';

begin 
  execute immediate 
    ' ALTER TABLE BARS.SKRYNKA_TARIFF1 DROP CONSTRAINT PK_SKRYNKATARIFF1';
exception when others then 
  if sqlcode=-2443 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' DROP INDEX BARS.PK_SKRYNKATARIFF1';
exception when others then 
  if sqlcode=-1418 then null; else raise; end if;
end;
/


PROMPT *** Create  constraint PK_SKRYNKATARIFF1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 ADD CONSTRAINT PK_SKRYNKATARIFF1 PRIMARY KEY (TARIFF, TARIFF_DATE,KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF1_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 ADD CONSTRAINT FK_SKRYNKATARIFF1_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFF1_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 MODIFY (KF CONSTRAINT CC_SKRYNKATARIFF1_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFF1_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 MODIFY (BRANCH CONSTRAINT CC_SKRYNKATARIFF1_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF1_TARIFFDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 MODIFY (TARIFF_DATE CONSTRAINT NN_SKRYNKA_TARIFF1_TARIFFDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF1_TARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 MODIFY (TARIFF CONSTRAINT NN_SKRYNKA_TARIFF1_TARIFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRTARIFF1_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 ADD CONSTRAINT FK_SKRTARIFF1_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF1_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF1 ADD CONSTRAINT FK_SKRYNKATARIFF1_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKATARIFF1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKATARIFF1 ON BARS.SKRYNKA_TARIFF1 (TARIFF, TARIFF_DATE,KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TARIFF1 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TARIFF1 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_TARIFF1 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_TARIFF1 to DEP_SKRN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_TARIFF1 to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TARIFF1 to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_TARIFF1 to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_TARIFF1 ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_TARIFF1 FOR BARS.SKRYNKA_TARIFF1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF1.sql =========*** End *
PROMPT ===================================================================================== 
