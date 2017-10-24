

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_METALS$LOCAL_UPD.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_METALS$LOCAL_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_METALS$LOCAL_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS$LOCAL_UPD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS$LOCAL_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_METALS$LOCAL_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_METALS$LOCAL_UPD 
   (	BRANCH VARCHAR2(30), 
	KOD NUMBER, 
	CENA NUMBER, 
	CENA_K NUMBER, 
	ACC_3800 NUMBER, 
	ISP NUMBER, 
	BDATE DATE, 
	SDATE DATE, 
	IDUPD NUMBER, 
	ACTION_ID NUMBER, 
	 CONSTRAINT PK_BANKMETALSLUPD PRIMARY KEY (IDUPD) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSBIGI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_METALS$LOCAL_UPD ***
 exec bpa.alter_policies('BANK_METALS$LOCAL_UPD');


COMMENT ON TABLE BARS.BANK_METALS$LOCAL_UPD IS 'Архів курсів(ціни) купівлі/продажу драг.металів';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.KOD IS 'Код зливку';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.CENA IS 'Ціна продажу(коп)';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.CENA_K IS 'Ціна купівлі(коп)';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.ACC_3800 IS 'Acc рахунку валютної позиції';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.ISP IS 'Код користувача, що вніс зміни';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.BDATE IS 'Банківська дата';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.SDATE IS 'Дата/час внесення зміни';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.IDUPD IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS.BANK_METALS$LOCAL_UPD.ACTION_ID IS 'Код зміни (0-додано новий запис, 1- оновлено запис, 2- видалено запис )';




PROMPT *** Create  constraint CC_BANKMETALSLUPD_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD MODIFY (BRANCH CONSTRAINT CC_BANKMETALSLUPD_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALSLUPD_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD MODIFY (KOD CONSTRAINT CC_BANKMETALSLUPD_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALSLUPD_CENA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD MODIFY (CENA CONSTRAINT CC_BANKMETALSLUPD_CENA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALSLUPD_CENAK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD MODIFY (CENA_K CONSTRAINT CC_BANKMETALSLUPD_CENAK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BANKMETALSLUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD ADD CONSTRAINT PK_BANKMETALSLUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETALSLUPD_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD ADD CONSTRAINT FK_BANKMETALSLUPD_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETALSLUPD_BANKMETALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD ADD CONSTRAINT FK_BANKMETALSLUPD_BANKMETALS FOREIGN KEY (KOD)
	  REFERENCES BARS.BANK_METALS (KOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETALSLUPD_METALACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD ADD CONSTRAINT FK_BANKMETALSLUPD_METALACTION FOREIGN KEY (ACTION_ID)
	  REFERENCES BARS.BANK_METALS_ACTION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKMETALSLUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKMETALSLUPD ON BARS.BANK_METALS$LOCAL_UPD (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_METALS$LOCAL_UPD ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS$LOCAL_UPD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_METALS$LOCAL_UPD to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS$LOCAL_UPD to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_METALS$LOCAL_UPD.sql =========***
PROMPT ===================================================================================== 
