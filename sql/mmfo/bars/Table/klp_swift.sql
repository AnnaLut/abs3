

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_SWIFT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_SWIFT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_SWIFT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_SWIFT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_SWIFT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_SWIFT ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_SWIFT 
   (	ID NUMBER, 
	FL NUMBER, 
	NAMEF VARCHAR2(12), 
	FIO1 VARCHAR2(96), 
	FIO2 VARCHAR2(96), 
	PS_NUMBER VARCHAR2(96), 
	DATETIMEPICKER1 VARCHAR2(16), 
	NAMEBANKPL VARCHAR2(254), 
	ADRESBANKPL VARCHAR2(254), 
	NAMEPL VARCHAR2(254), 
	ADRESPL VARCHAR2(254), 
	RAHPL VARCHAR2(96), 
	I_VA VARCHAR2(16), 
	SUMMA VARCHAR2(96), 
	SUMPROP VARCHAR2(254), 
	NAMEBEN VARCHAR2(254), 
	ADRESBEN VARCHAR2(254), 
	RAHBEN VARCHAR2(96), 
	NAMEBANKBEN VARCHAR2(254), 
	ADRESBANKBEN VARCHAR2(254), 
	NAZNPLAT VARCHAR2(1024), 
	NDS VARCHAR2(96), 
	OKPOPL VARCHAR2(32), 
	KODOP VARCHAR2(32), 
	KODSTRBEN VARCHAR2(96), 
	KODBANKPL VARCHAR2(32), 
	BANKPOSR VARCHAR2(140), 
	KODBANKBEN VARCHAR2(96), 
	IBANBEN VARCHAR2(254), 
	CHECKBOX1 VARCHAR2(16), 
	CHECKBOX2 VARCHAR2(16), 
	CHECKBOX3 VARCHAR2(16), 
	CHECKBOX4 VARCHAR2(16), 
	CHECKBOX5 VARCHAR2(16), 
	CHECKBOX6 VARCHAR2(16), 
	BIK VARCHAR2(32), 
	NKORR VARCHAR2(96), 
	NAMEBANKKOR VARCHAR2(254), 
	NAMEVIDBANK VARCHAR2(254), 
	INNBANK VARCHAR2(32), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NUMKORRAHBANKBEN VARCHAR2(96), 
	NAMEVIDBANKBEN VARCHAR2(254), 
	BIKKODBANKBEN VARCHAR2(96), 
	NAMEBANKKORBANKBEN VARCHAR2(254), 
	INNBANKBEN VARCHAR2(96), 
	SWIFTKODBANKBEN VARCHAR2(96)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_SWIFT ***
 exec bpa.alter_policies('KLP_SWIFT');


COMMENT ON TABLE BARS.KLP_SWIFT IS 'Документообіг - SWІFT';
COMMENT ON COLUMN BARS.KLP_SWIFT.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.KLP_SWIFT.FL IS 'Флаг обработки';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEF IS '';
COMMENT ON COLUMN BARS.KLP_SWIFT.FIO1 IS '';
COMMENT ON COLUMN BARS.KLP_SWIFT.FIO2 IS '';
COMMENT ON COLUMN BARS.KLP_SWIFT.PS_NUMBER IS 'ПЛАТІЖНЕ ДОРУЧЕННЯ в іноземній валюті або банківських металах N%';
COMMENT ON COLUMN BARS.KLP_SWIFT.DATETIMEPICKER1 IS 'від';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEBANKPL IS '52: Банк платника, найменування';
COMMENT ON COLUMN BARS.KLP_SWIFT.ADRESBANKPL IS '52: Банк платника, місцезнаходження';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEPL IS '50: Платник, назва';
COMMENT ON COLUMN BARS.KLP_SWIFT.ADRESPL IS '50: Платник, місцезнаходження/адреса';
COMMENT ON COLUMN BARS.KLP_SWIFT.RAHPL IS '50: Платник, N% рахунку';
COMMENT ON COLUMN BARS.KLP_SWIFT.I_VA IS '32: Код валюти, сума або маса, цифровий код іноземної валюти або банківського металу';
COMMENT ON COLUMN BARS.KLP_SWIFT.SUMMA IS '32: Код валюти, сума або маса, сума або маса цифрами';
COMMENT ON COLUMN BARS.KLP_SWIFT.SUMPROP IS '32: Код валюти, сума або маса, сума або маса банківських металів та назва іноземної валюти або виду банківського металу словами';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEBEN IS '59: Бенефіціар, найменування';
COMMENT ON COLUMN BARS.KLP_SWIFT.ADRESBEN IS '59: Бенефіціар, місцезнаходження';
COMMENT ON COLUMN BARS.KLP_SWIFT.RAHBEN IS '59: Бенефіціар, N% рахунку';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEBANKBEN IS '57: Банк бенефіціара, найменування';
COMMENT ON COLUMN BARS.KLP_SWIFT.ADRESBANKBEN IS '57: Банк бенефіціара, місцезнаходження';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAZNPLAT IS '70: Призначення платежу';
COMMENT ON COLUMN BARS.KLP_SWIFT.NDS IS '70: Призначення платежу, ПДВ';
COMMENT ON COLUMN BARS.KLP_SWIFT.OKPOPL IS '71: Комісійні за рахунок, Ідентифікаційний код/номер платника';
COMMENT ON COLUMN BARS.KLP_SWIFT.KODOP IS '71: Комісійні за рахунок, Код операції';
COMMENT ON COLUMN BARS.KLP_SWIFT.KODSTRBEN IS '71: Комісійні за рахунок, Код країни бенефіціара';
COMMENT ON COLUMN BARS.KLP_SWIFT.KODBANKPL IS 'Допоміжні реквізити, Код банку платника';
COMMENT ON COLUMN BARS.KLP_SWIFT.BANKPOSR IS '57: Банк бенефіціара, SWIFT код банку';
COMMENT ON COLUMN BARS.KLP_SWIFT.KODBANKBEN IS 'Допоміжні реквізити, IBAN бенефіціара';
COMMENT ON COLUMN BARS.KLP_SWIFT.IBANBEN IS 'Допоміжні реквізити, Найменування та інші реквізити банку-посередника';
COMMENT ON COLUMN BARS.KLP_SWIFT.CHECKBOX1 IS '71: Комісійні за рахунок, OUR';
COMMENT ON COLUMN BARS.KLP_SWIFT.CHECKBOX2 IS '71: Комісійні за рахунок, BEN';
COMMENT ON COLUMN BARS.KLP_SWIFT.CHECKBOX3 IS '71: Комісійні за рахунок, SHA';
COMMENT ON COLUMN BARS.KLP_SWIFT.CHECKBOX4 IS '70: Призначення платежу, без ПДВ';
COMMENT ON COLUMN BARS.KLP_SWIFT.CHECKBOX5 IS '70: Призначення платежу, оплата';
COMMENT ON COLUMN BARS.KLP_SWIFT.CHECKBOX6 IS '70: Призначення платежу, попередня оплата';
COMMENT ON COLUMN BARS.KLP_SWIFT.BIK IS '57: Банк бенефіціара, БІК код банку';
COMMENT ON COLUMN BARS.KLP_SWIFT.NKORR IS '57: Банк бенефіціара, номер коррахунку';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEBANKKOR IS '57: Банк бенефіціара, найменування банку, в якому знаходиться коррахунок';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEVIDBANK IS '57: Банк бенефіціара, найменування відділення банку';
COMMENT ON COLUMN BARS.KLP_SWIFT.INNBANK IS '57: Банк бенефіціара, ІНН банку';
COMMENT ON COLUMN BARS.KLP_SWIFT.KF IS '';
COMMENT ON COLUMN BARS.KLP_SWIFT.NUMKORRAHBANKBEN IS '57: Банк бенефіціара - номер коррахунку';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEVIDBANKBEN IS '57: Банк бенефіціара - найменування відділення банку';
COMMENT ON COLUMN BARS.KLP_SWIFT.BIKKODBANKBEN IS '57: Банк бенефіціара - БІК код банку';
COMMENT ON COLUMN BARS.KLP_SWIFT.NAMEBANKKORBANKBEN IS '57: Банк бенефіціара - найменування банку, в якому знаходиться коррахунок';
COMMENT ON COLUMN BARS.KLP_SWIFT.INNBANKBEN IS '57: Банк бенефіціара - ІНН банку';
COMMENT ON COLUMN BARS.KLP_SWIFT.SWIFTKODBANKBEN IS '57: Банк бенефіціара - SWIFT код банку';




PROMPT *** Create  constraint KLP_SWIFT_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_SWIFT ADD CONSTRAINT KLP_SWIFT_PK PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPSWIFT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_SWIFT ADD CONSTRAINT FK_KLPSWIFT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPSWIFT_FL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_SWIFT ADD CONSTRAINT FK_KLPSWIFT_FL FOREIGN KEY (FL)
	  REFERENCES BARS.KLP_FL (FL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPSWIFT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_SWIFT MODIFY (KF CONSTRAINT CC_KLPSWIFT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_SWIFT_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_SWIFT_PK ON BARS.KLP_SWIFT (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_SWIFT ***
grant SELECT                                                                 on KLP_SWIFT       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_SWIFT       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KLP_SWIFT       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_SWIFT       to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_SWIFT.sql =========*** End *** ===
PROMPT ===================================================================================== 
