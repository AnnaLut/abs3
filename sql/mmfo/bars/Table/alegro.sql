

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ALEGRO.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ALEGRO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ALEGRO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ALEGRO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ALEGRO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ALEGRO ***
begin 
  execute immediate '
  CREATE TABLE BARS.ALEGRO 
   (	ZKPO VARCHAR2(10), 
	NAME VARCHAR2(70), 
	MFO VARCHAR2(12), 
	NUM VARCHAR2(30), 
	ACCOUNTMVPS VARCHAR2(20), 
	PARENTID NUMBER, 
	POSTALINDEX VARCHAR2(10), 
	ADDRESS VARCHAR2(100), 
	KOATUU NUMBER, 
	MANAGERPHONE VARCHAR2(10), 
	PHONE VARCHAR2(20), 
	BUHGALTERPHONE VARCHAR2(10), 
	EMAIL VARCHAR2(40), 
	FOSSMAIL VARCHAR2(60), 
	NBUMAIL VARCHAR2(10), 
	FAX VARCHAR2(20), 
	OPENDATE DATE, 
	CLOSEDATE DATE, 
	TERMINALNAME VARCHAR2(20), 
	ORDERPUNKTNUMBER VARCHAR2(10), 
	ACCOUNT1 VARCHAR2(10), 
	ACCOUNT2 VARCHAR2(70), 
	ACCOUNT3 VARCHAR2(20), 
	ACCOUNT4 VARCHAR2(30), 
	QUATERSAREA VARCHAR2(20), 
	EMPLOYNUMBER VARCHAR2(10), 
	PRIVACYFORM VARCHAR2(20), 
	CITYCODE VARCHAR2(10), 
	EMITSERVICE CHAR(10), 
	PAYMENTPOS CHAR(10), 
	PAYMENTIMP CHAR(10), 
	PAYMENTATM CHAR(10), 
	ACCOUNT24 VARCHAR2(20), 
	ACCOUNT09 VARCHAR2(20), 
	GEOGRAFICALCODE VARCHAR2(10), 
	RANGE NUMBER, 
	OPERWINDOWSACTIVE NUMBER, 
	CUREXCHANGEPOINTS NUMBER, 
	CUREXCHANGECONTRACTS NUMBER, 
	RESPONSIBLEPHONE VARCHAR2(10), 
	MANAGER VARCHAR2(40), 
	GLAVBUHGALTER VARCHAR2(40), 
	RESPONSIBLEPERSON VARCHAR2(40), 
	REGCODE VARCHAR2(30), 
	ACTUALITY VARCHAR2(10), 
	REPORTBRANCH NUMBER, 
	NAMEUKRR VARCHAR2(45), 
	NAMERUSR VARCHAR2(45), 
	NAMEENGR VARCHAR2(45), 
	NAMEUKRB VARCHAR2(70), 
	NAMERUSB VARCHAR2(70), 
	NAMEENGB VARCHAR2(70), 
	REGBICCODE VARCHAR2(11), 
	CITYNAME VARCHAR2(30), 
	CITYNAMERUS VARCHAR2(30), 
	CITYNAMEENG VARCHAR2(30), 
	ADDRESSRUS VARCHAR2(100), 
	ADDRESSENG VARCHAR2(100), 
	VAL NUMBER(*,0), 
	NLS_CHK VARCHAR2(15), 
	NLS_CHD VARCHAR2(15), 
	NLS6_GOU_CH VARCHAR2(15), 
	NLS_CHK0 VARCHAR2(15), 
	NLS_CHK1 VARCHAR2(15), 
	NLS_GTD VARCHAR2(15), 
	NLS6_GOU_GT VARCHAR2(15), 
	NLS7_GOU_KOB VARCHAR2(15), 
	NLS6_MFO_KOB VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ALEGRO ***
 exec bpa.alter_policies('ALEGRO');


COMMENT ON TABLE BARS.ALEGRO IS '';
COMMENT ON COLUMN BARS.ALEGRO.ZKPO IS '';
COMMENT ON COLUMN BARS.ALEGRO.NAME IS '';
COMMENT ON COLUMN BARS.ALEGRO.MFO IS '';
COMMENT ON COLUMN BARS.ALEGRO.NUM IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACCOUNTMVPS IS '';
COMMENT ON COLUMN BARS.ALEGRO.PARENTID IS '';
COMMENT ON COLUMN BARS.ALEGRO.POSTALINDEX IS '';
COMMENT ON COLUMN BARS.ALEGRO.ADDRESS IS '';
COMMENT ON COLUMN BARS.ALEGRO.KOATUU IS '';
COMMENT ON COLUMN BARS.ALEGRO.MANAGERPHONE IS '';
COMMENT ON COLUMN BARS.ALEGRO.PHONE IS '';
COMMENT ON COLUMN BARS.ALEGRO.BUHGALTERPHONE IS '';
COMMENT ON COLUMN BARS.ALEGRO.EMAIL IS '';
COMMENT ON COLUMN BARS.ALEGRO.FOSSMAIL IS '';
COMMENT ON COLUMN BARS.ALEGRO.NBUMAIL IS '';
COMMENT ON COLUMN BARS.ALEGRO.FAX IS '';
COMMENT ON COLUMN BARS.ALEGRO.OPENDATE IS '';
COMMENT ON COLUMN BARS.ALEGRO.CLOSEDATE IS '';
COMMENT ON COLUMN BARS.ALEGRO.TERMINALNAME IS '';
COMMENT ON COLUMN BARS.ALEGRO.ORDERPUNKTNUMBER IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACCOUNT1 IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACCOUNT2 IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACCOUNT3 IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACCOUNT4 IS '';
COMMENT ON COLUMN BARS.ALEGRO.QUATERSAREA IS '';
COMMENT ON COLUMN BARS.ALEGRO.EMPLOYNUMBER IS '';
COMMENT ON COLUMN BARS.ALEGRO.PRIVACYFORM IS '';
COMMENT ON COLUMN BARS.ALEGRO.CITYCODE IS '';
COMMENT ON COLUMN BARS.ALEGRO.EMITSERVICE IS '';
COMMENT ON COLUMN BARS.ALEGRO.PAYMENTPOS IS '';
COMMENT ON COLUMN BARS.ALEGRO.PAYMENTIMP IS '';
COMMENT ON COLUMN BARS.ALEGRO.PAYMENTATM IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACCOUNT24 IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACCOUNT09 IS '';
COMMENT ON COLUMN BARS.ALEGRO.GEOGRAFICALCODE IS '';
COMMENT ON COLUMN BARS.ALEGRO.RANGE IS '';
COMMENT ON COLUMN BARS.ALEGRO.OPERWINDOWSACTIVE IS '';
COMMENT ON COLUMN BARS.ALEGRO.CUREXCHANGEPOINTS IS '';
COMMENT ON COLUMN BARS.ALEGRO.CUREXCHANGECONTRACTS IS '';
COMMENT ON COLUMN BARS.ALEGRO.RESPONSIBLEPHONE IS '';
COMMENT ON COLUMN BARS.ALEGRO.MANAGER IS '';
COMMENT ON COLUMN BARS.ALEGRO.GLAVBUHGALTER IS '';
COMMENT ON COLUMN BARS.ALEGRO.RESPONSIBLEPERSON IS '';
COMMENT ON COLUMN BARS.ALEGRO.REGCODE IS '';
COMMENT ON COLUMN BARS.ALEGRO.ACTUALITY IS '';
COMMENT ON COLUMN BARS.ALEGRO.REPORTBRANCH IS '';
COMMENT ON COLUMN BARS.ALEGRO.NAMEUKRR IS '';
COMMENT ON COLUMN BARS.ALEGRO.NAMERUSR IS '';
COMMENT ON COLUMN BARS.ALEGRO.NAMEENGR IS '';
COMMENT ON COLUMN BARS.ALEGRO.NAMEUKRB IS '';
COMMENT ON COLUMN BARS.ALEGRO.NAMERUSB IS '';
COMMENT ON COLUMN BARS.ALEGRO.NAMEENGB IS '';
COMMENT ON COLUMN BARS.ALEGRO.REGBICCODE IS '';
COMMENT ON COLUMN BARS.ALEGRO.CITYNAME IS '';
COMMENT ON COLUMN BARS.ALEGRO.CITYNAMERUS IS '';
COMMENT ON COLUMN BARS.ALEGRO.CITYNAMEENG IS '';
COMMENT ON COLUMN BARS.ALEGRO.ADDRESSRUS IS '';
COMMENT ON COLUMN BARS.ALEGRO.ADDRESSENG IS '';
COMMENT ON COLUMN BARS.ALEGRO.VAL IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS_CHK IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS_CHD IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS6_GOU_CH IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS_CHK0 IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS_CHK1 IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS_GTD IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS6_GOU_GT IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS7_GOU_KOB IS '';
COMMENT ON COLUMN BARS.ALEGRO.NLS6_MFO_KOB IS '';




PROMPT *** Create  constraint XPK_ALEGRO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALEGRO ADD CONSTRAINT XPK_ALEGRO PRIMARY KEY (NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ALEGRO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ALEGRO ON BARS.ALEGRO (NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ALEGRO ***
grant SELECT                                                                 on ALEGRO          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ALEGRO          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ALEGRO          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ALEGRO          to RCH_1;
grant DELETE,INSERT,SELECT,UPDATE                                            on ALEGRO          to REF0000;
grant SELECT                                                                 on ALEGRO          to UPLD;



PROMPT *** Create SYNONYM  to ALEGRO ***

  CREATE OR REPLACE PUBLIC SYNONYM ALEGRO_CH1 FOR BARS.ALEGRO;


PROMPT *** Create SYNONYM  to ALEGRO ***

  CREATE OR REPLACE PUBLIC SYNONYM ALEGRO_G FOR BARS.ALEGRO;


PROMPT *** Create SYNONYM  to ALEGRO ***

  CREATE OR REPLACE PUBLIC SYNONYM ALEGRO_KOB FOR BARS.ALEGRO;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ALEGRO.sql =========*** End *** ======
PROMPT ===================================================================================== 
