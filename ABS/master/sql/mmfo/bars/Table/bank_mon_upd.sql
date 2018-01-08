

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_MON_UPD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_MON_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_MON_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_MON_UPD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_MON_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_MON_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_MON_UPD 
   (	NAME_MON VARCHAR2(100), 
	NOM_MON NUMBER, 
	CENA_NBU NUMBER, 
	KOD NUMBER, 
	TYPE NUMBER, 
	CASE NUMBER, 
	CENA_NBU_OTP NUMBER, 
	RAZR NUMBER, 
	BRANCH VARCHAR2(30), 
	ISP NUMBER, 
	BDATE DATE, 
	SDATE DATE, 
	IDUPD NUMBER, 
	ACTION_ID NUMBER, 
	 CONSTRAINT PK_BANKMONUPD PRIMARY KEY (IDUPD) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSBIGI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_MON_UPD ***
 exec bpa.alter_policies('BANK_MON_UPD');


COMMENT ON TABLE BARS.BANK_MON_UPD IS 'Довідник змін реквізитів ювілейних монет';
COMMENT ON COLUMN BARS.BANK_MON_UPD.NAME_MON IS 'Назва монети';
COMMENT ON COLUMN BARS.BANK_MON_UPD.NOM_MON IS 'Номінал';
COMMENT ON COLUMN BARS.BANK_MON_UPD.CENA_NBU IS 'Вартість придбання в НБУ';
COMMENT ON COLUMN BARS.BANK_MON_UPD.KOD IS 'Код монети';
COMMENT ON COLUMN BARS.BANK_MON_UPD.TYPE IS 'Тип монети(0-монета, 1-упаковка)';
COMMENT ON COLUMN BARS.BANK_MON_UPD.CASE IS 'Футляр(код футляра)';
COMMENT ON COLUMN BARS.BANK_MON_UPD.CENA_NBU_OTP IS 'Відпускна ціна';
COMMENT ON COLUMN BARS.BANK_MON_UPD.RAZR IS 'Використовується для продажу';
COMMENT ON COLUMN BARS.BANK_MON_UPD.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.BANK_MON_UPD.ISP IS 'Код користувача, що вніс зміни';
COMMENT ON COLUMN BARS.BANK_MON_UPD.BDATE IS 'Банківська дата';
COMMENT ON COLUMN BARS.BANK_MON_UPD.SDATE IS 'Дата/час внесення зміни';
COMMENT ON COLUMN BARS.BANK_MON_UPD.IDUPD IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS.BANK_MON_UPD.ACTION_ID IS 'Код зміни (0-додано новий запис, 1- оновлено запис, 2- видалено запис )';




PROMPT *** Create  constraint FK_BANKMONUPD_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD ADD CONSTRAINT FK_BANKMONUPD_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMONUPD_METALACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD ADD CONSTRAINT FK_BANKMONUPD_METALACTION FOREIGN KEY (ACTION_ID)
	  REFERENCES BARS.BANK_METALS_ACTION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BANKMONUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD ADD CONSTRAINT PK_BANKMONUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMONUPD_CENAOTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD MODIFY (CENA_NBU_OTP CONSTRAINT CC_BANKMONUPD_CENAOTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMONUPD_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD MODIFY (TYPE CONSTRAINT CC_BANKMONUPD_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMONUPD_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD MODIFY (KOD CONSTRAINT CC_BANKMONUPD_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMONUPD_CENANBU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD MODIFY (CENA_NBU CONSTRAINT CC_BANKMONUPD_CENANBU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMONUPD_NOMMON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD MODIFY (NOM_MON CONSTRAINT CC_BANKMONUPD_NOMMON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMONUPD_NAMEMON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON_UPD MODIFY (NAME_MON CONSTRAINT CC_BANKMONUPD_NAMEMON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKMONUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKMONUPD ON BARS.BANK_MON_UPD (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_MON_UPD ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_MON_UPD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_MON_UPD    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_MON_UPD    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_MON_UPD.sql =========*** End *** 
PROMPT ===================================================================================== 
