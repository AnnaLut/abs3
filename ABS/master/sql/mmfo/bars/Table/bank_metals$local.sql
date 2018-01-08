

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_METALS$LOCAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_METALS$LOCAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_METALS$LOCAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS$LOCAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BANK_METALS$LOCAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_METALS$LOCAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_METALS$LOCAL 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KOD NUMBER, 
	CENA NUMBER DEFAULT 0, 
	CENA_K NUMBER DEFAULT 0, 
	ACC_3800 NUMBER, 
	BRANCH_OLD VARCHAR2(30), 
	CENA_NOMI NUMBER, 
	FDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_METALS$LOCAL ***
 exec bpa.alter_policies('BANK_METALS$LOCAL');


COMMENT ON TABLE BARS.BANK_METALS$LOCAL IS 'Курси(ціни) купівлі/продажу драг.металів';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.KF IS 'Код банку';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.KOD IS 'Код зливку';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.CENA IS 'Ціна продажу(коп)';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.CENA_K IS 'Ціна купівлі(коп)';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.ACC_3800 IS 'Acc рахунку валютної позиції';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.BRANCH_OLD IS '';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.CENA_NOMI IS '';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL.FDAT IS '';




PROMPT *** Create  constraint PK_BANKMETLOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL ADD CONSTRAINT PK_BANKMETLOC PRIMARY KEY (BRANCH, FDAT, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETLOC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL ADD CONSTRAINT FK_BANKMETLOC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETLOC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL ADD CONSTRAINT FK_BANKMETLOC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETLOC_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL ADD CONSTRAINT FK_BANKMETLOC_KOD FOREIGN KEY (KOD)
	  REFERENCES BARS.BANK_METALS (KOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETLOC_CENAK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL MODIFY (CENA_K CONSTRAINT CC_BANKMETLOC_CENAK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETLOC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL MODIFY (BRANCH CONSTRAINT CC_BANKMETLOC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETLOC_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL MODIFY (KOD CONSTRAINT CC_BANKMETLOC_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETLOC_CENA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL MODIFY (CENA CONSTRAINT CC_BANKMETLOC_CENA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETLOC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL MODIFY (KF CONSTRAINT CC_BANKMETLOC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKMETLOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKMETLOC ON BARS.BANK_METALS$LOCAL (BRANCH, FDAT, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_BANKMETALLOCAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_BANKMETALLOCAL ON BARS.BANK_METALS$LOCAL (KF, KOD, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_METALS$LOCAL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS$LOCAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_METALS$LOCAL to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_METALS$LOCAL to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS$LOCAL to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BANK_METALS$LOCAL to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_METALS$LOCAL.sql =========*** End
PROMPT ===================================================================================== 
