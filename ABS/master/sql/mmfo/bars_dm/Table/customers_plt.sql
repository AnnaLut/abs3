

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CUSTOMERS_PLT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table CUSTOMERS_PLT ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CUSTOMERS_PLT 
   (	ID NUMBER(38,0), 
	PER_ID NUMBER, 
	KF VARCHAR2(12), 
	RU NUMBER(*,0), 
	RNK NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	LAST_NAME VARCHAR2(50), 
	FIRST_NAME VARCHAR2(50), 
	MIDDLE_NAME VARCHAR2(60), 
	SEX CHAR(1), 
	GR VARCHAR2(30), 
	BDAY DATE, 
	PASSP NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PDATE DATE, 
	ORGAN VARCHAR2(70), 
	PASSP_EXPIRE_TO DATE, 
	PASSP_TO_BANK DATE, 
	OKPO VARCHAR2(14), 
	CUST_STATUS VARCHAR2(20), 
	CUST_ACTIVE NUMBER(38,0), 
	TELM VARCHAR2(20), 
	TELW VARCHAR2(20), 
	TELD VARCHAR2(20), 
	TELADD VARCHAR2(20), 
	EMAIL VARCHAR2(100), 
	ADR_POST_COUNTRY VARCHAR2(55), 
	ADR_POST_DOMAIN VARCHAR2(30), 
	ADR_POST_REGION VARCHAR2(30), 
	ADR_POST_LOC VARCHAR2(30), 
	ADR_POST_ADR VARCHAR2(100), 
	ADR_POST_ZIP VARCHAR2(20), 
	ADR_FACT_COUNTRY VARCHAR2(55), 
	ADR_FACT_DOMAIN VARCHAR2(30), 
	ADR_FACT_REGION VARCHAR2(30), 
	ADR_FACT_LOC VARCHAR2(30), 
	ADR_FACT_ADR VARCHAR2(100), 
	ADR_FACT_ZIP VARCHAR2(20), 
	ADR_WORK_COUNTRY VARCHAR2(55), 
	ADR_WORK_DOMAIN VARCHAR2(30), 
	ADR_WORK_REGION VARCHAR2(30), 
	ADR_WORK_LOC VARCHAR2(30), 
	ADR_WORK_ADR VARCHAR2(55), 
	ADR_WORK_ZIP VARCHAR2(20), 
	NEGATIV_STATUS VARCHAR2(10), 
	REESTR_MOB_BANK VARCHAR2(10), 
	REESTR_INET_BANK VARCHAR2(10), 
	REESTR_SMS_BANK VARCHAR2(10), 
	MONTH_INCOME NUMBER(10,0), 
	SUBJECT_ROLE VARCHAR2(10), 
	REZIDENT VARCHAR2(10), 
	MERRIED VARCHAR2(10), 
	EMP_STATUS VARCHAR2(10), 
	SUBJECT_CLASS VARCHAR2(10), 
	INSIDER VARCHAR2(10), 
	VIPK NUMBER(1,0), 
	VIP_FIO_MANAGER VARCHAR2(250), 
	VIP_PHONE_MANAGER VARCHAR2(30), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	EDDR_ID VARCHAR2(20), 
	ACTUAL_DATE DATE, 
	BPLACE VARCHAR2(70), 
	SUBSD VARCHAR2(500), 
	SUBSN VARCHAR2(500), 
	ELT_N VARCHAR2(500), 
	ELT_D VARCHAR2(500), 
	GCIF VARCHAR2(30), 
	NOMPDV VARCHAR2(9), 
	NOM_DOG VARCHAR2(10), 
	SW_RN VARCHAR2(500), 
	Y_ELT VARCHAR2(500), 
	ADM VARCHAR2(70), 
	ADR_ALT VARCHAR2(70), 
	BUSSS VARCHAR2(500), 
	PC_MF VARCHAR2(500), 
	PC_Z4 VARCHAR2(500), 
	PC_Z3 VARCHAR2(500), 
	PC_Z5 VARCHAR2(500), 
	PC_Z2 VARCHAR2(500), 
	PC_Z1 VARCHAR2(500), 
	AGENT VARCHAR2(500), 
	PC_SS VARCHAR2(500), 
	STMT VARCHAR2(500), 
	VIDKL VARCHAR2(500), 
	VED CHAR(5), 
	TIPA VARCHAR2(500), 
	PHKLI VARCHAR2(500), 
	AF1_9 VARCHAR2(500), 
	IDDPD VARCHAR2(500), 
	DAIDI VARCHAR2(500), 
	DATVR VARCHAR2(500), 
	DATZ VARCHAR2(500), 
	IDDPL VARCHAR2(500), 
	DATE_PHOTO DATE, 
	IDDPR VARCHAR2(500), 
	ISE CHAR(5), 
	OBSLU VARCHAR2(500), 
	CRSRC VARCHAR2(500), 
	DJOTH VARCHAR2(500), 
	DJAVI VARCHAR2(500), 
	DJ_TC VARCHAR2(500), 
	DJOWF VARCHAR2(500), 
	DJCFI VARCHAR2(500), 
	DJ_LN VARCHAR2(500), 
	DJ_FH VARCHAR2(500), 
	DJ_CP VARCHAR2(500), 
	CHORN VARCHAR2(500), 
	CRISK_KL VARCHAR2(1), 
	BC NUMBER(1,0), 
	SPMRK VARCHAR2(500), 
	K013 VARCHAR2(500), 
	KODID VARCHAR2(500), 
	COUNTRY NUMBER(3,0), 
	MS_FS VARCHAR2(500), 
	MS_VD VARCHAR2(500), 
	MS_GR VARCHAR2(500), 
	LIM_KASS NUMBER(24,0), 
	LIM NUMBER(24,0), 
	LICO VARCHAR2(500), 
	UADR VARCHAR2(500), 
	MOB01 VARCHAR2(500), 
	MOB02 VARCHAR2(500), 
	MOB03 VARCHAR2(500), 
	SUBS VARCHAR2(500), 
	K050 CHAR(3), 
	DEATH VARCHAR2(500), 
	NO_PHONE NUMBER(1,0), 
	NSMCV VARCHAR2(500), 
	NSMCC VARCHAR2(500), 
	NSMCT VARCHAR2(500), 
	NOTES VARCHAR2(140), 
	SAMZ VARCHAR2(500), 
	OREP VARCHAR2(500), 
	OVIFS VARCHAR2(500), 
	AF6 VARCHAR2(500), 
	FSKRK VARCHAR2(500), 
	FSOMD VARCHAR2(500), 
	FSVED VARCHAR2(500), 
	FSZPD VARCHAR2(500), 
	FSPOR VARCHAR2(500), 
	FSRKZ VARCHAR2(500), 
	FSZOP VARCHAR2(500), 
	FSKPK VARCHAR2(500), 
	FSKPR VARCHAR2(500), 
	FSDIB VARCHAR2(500), 
	FSCP VARCHAR2(500), 
	FSVLZ VARCHAR2(500), 
	FSVLA VARCHAR2(500), 
	FSVLN VARCHAR2(500), 
	FSVLO VARCHAR2(500), 
	FSSST VARCHAR2(500), 
	FSSOD VARCHAR2(500), 
	FSVSN VARCHAR2(500), 
	DOV_P VARCHAR2(500), 
	DOV_A VARCHAR2(500), 
	DOV_F VARCHAR2(500), 
	NMKV VARCHAR2(70), 
	SN_GC VARCHAR2(500), 
	NMKK VARCHAR2(38), 
	PRINSIDER NUMBER(38,0), 
	MB CHAR(1), 
	PUBLP VARCHAR2(500), 
	WORKB VARCHAR2(500), 
	CIGPO VARCHAR2(500), 
	COUNTRY_NAME VARCHAR2(70), 
	TARIF VARCHAR2(500), 
	AINAB VARCHAR2(500), 
	TGR NUMBER(1,0), 
	SNSDR VARCHAR2(500), 
	IDPIB VARCHAR2(500), 
	FS CHAR(2), 
	DJER VARCHAR2(500), 
	SUTD VARCHAR2(500), 
	RVDBC VARCHAR2(500), 
	RVIBA VARCHAR2(500), 
	RVIDT VARCHAR2(500), 
	RV_XA VARCHAR2(500), 
	RVIBR VARCHAR2(500), 
	RVIBB VARCHAR2(500), 
	RVRNK VARCHAR2(500), 
	RVPH1 VARCHAR2(500), 
	RVPH2 VARCHAR2(500), 
	RVPH3 VARCHAR2(500), 
	SAB VARCHAR2(6), 
	J_COUNTRY NUMBER(3,0), 
	J_ZIP VARCHAR2(20), 
	J_DOMAIN VARCHAR2(30), 
	J_REGION VARCHAR2(30), 
	J_LOCALITY VARCHAR2(30), 
	J_ADDRESS VARCHAR2(100), 
	J_TERRITORY_ID NUMBER(22,0), 
	J_LOCALITY_TYPE NUMBER(22,0), 
	J_STREET_TYPE NUMBER(22,0), 
	J_STREET VARCHAR2(100 CHAR), 
	J_HOME_TYPE NUMBER(22,0), 
	J_HOME VARCHAR2(100 CHAR), 
	J_HOMEPART_TYPE NUMBER(22,0), 
	J_HOMEPART VARCHAR2(100 CHAR), 
	J_ROOM_TYPE NUMBER(22,0), 
	J_ROOM VARCHAR2(100 CHAR), 
	F_COUNTRY NUMBER(3,0), 
	F_ZIP VARCHAR2(20), 
	F_DOMAIN VARCHAR2(30), 
	F_REGION VARCHAR2(30), 
	F_LOCALITY VARCHAR2(30), 
	FADR VARCHAR2(500), 
	F_TERRITORY_ID NUMBER(22,0), 
	F_LOCALITY_TYPE NUMBER(22,0), 
	F_STREET_TYPE NUMBER(22,0), 
	F_STREET VARCHAR2(100 CHAR), 
	F_HOME_TYPE NUMBER(22,0), 
	F_HOME VARCHAR2(100 CHAR), 
	F_HOMEPART_TYPE NUMBER(22,0), 
	F_HOMEPART VARCHAR2(100 CHAR), 
	F_ROOM_TYPE NUMBER(22,0), 
	F_ROOM VARCHAR2(100 CHAR), 
	P_COUNTRY NUMBER(3,0), 
	P_ZIP VARCHAR2(20), 
	P_DOMAIN VARCHAR2(30), 
	P_REGION VARCHAR2(30), 
	P_LOCALITY VARCHAR2(30), 
	P_ADDRESS VARCHAR2(100), 
	P_TERRITORY_ID NUMBER(22,0), 
	P_LOCALITY_TYPE NUMBER(22,0), 
	P_STREET_TYPE NUMBER(22,0), 
	P_STREET VARCHAR2(100 CHAR), 
	P_HOME_TYPE NUMBER(22,0), 
	P_HOME VARCHAR2(100 CHAR), 
	P_HOMEPART_TYPE NUMBER(22,0), 
	P_HOMEPART VARCHAR2(100 CHAR), 
	P_ROOM_TYPE NUMBER(22,0), 
	P_ROOM VARCHAR2(100 CHAR), 
	F_ADDRESS VARCHAR2(100), 
	NOTESEC VARCHAR2(256), 
	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	RGADM VARCHAR2(30), 
	RGTAX VARCHAR2(30), 
	DATEA DATE, 
	DATET DATE, 
	RNKP NUMBER(38,0), 
	CUSTTYPE NUMBER(1,0), 
	RIZIK VARCHAR2(500), 
	SED CHAR(4), 
	CODCAGENT NUMBER(1,0), 
	J_KOATUU VARCHAR2(15), 
	J_REGION_ID NUMBER(10,0), 
	J_AREA_ID NUMBER(10,0), 
	J_SETTLEMENT_ID NUMBER(10,0), 
	J_STREET_ID NUMBER(10,0), 
	J_HOUSE_ID NUMBER(10,0), 
	F_KOATUU VARCHAR2(15), 
	F_REGION_ID NUMBER(10,0), 
	F_AREA_ID NUMBER(10,0), 
	F_SETTLEMENT_ID NUMBER(10,0), 
	F_STREET_ID NUMBER(10,0), 
	F_HOUSE_ID NUMBER(10,0), 
	P_KOATUU VARCHAR2(15), 
	P_REGION_ID NUMBER(10,0), 
	P_AREA_ID NUMBER(10,0), 
	P_SETTLEMENT_ID NUMBER(10,0), 
	P_STREET_ID NUMBER(10,0), 
	P_HOUSE_ID NUMBER(10,0), 
	VIP_ACCOUNT_MANAGER VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CUSTOMERS_PLT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJ_CP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CHORN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CRISK_KL IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.BC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SPMRK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.K013 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.KODID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MS_FS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MS_VD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MS_GR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.LIM_KASS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.LIM IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.LICO IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.UADR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MOB01 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MOB02 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MOB03 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SUBS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.K050 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DEATH IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NO_PHONE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NSMCV IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NSMCC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NSMCT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NOTES IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SAMZ IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.OREP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.OVIFS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.AF6 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSKRK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSOMD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSVED IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSZPD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSPOR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSRKZ IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSZOP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSKPK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSKPR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSDIB IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSCP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSVLZ IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSVLA IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSVLN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSVLO IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSSST IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSSOD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FSVSN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DOV_P IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DOV_A IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DOV_F IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NMKV IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SN_GC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NMKK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PRINSIDER IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MB IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PUBLP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.WORKB IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CIGPO IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.COUNTRY_NAME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.TARIF IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.AINAB IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.TGR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SNSDR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.IDPIB IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJER IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SUTD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVDBC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVIBA IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVIDT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RV_XA IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVIBR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVIBB IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVRNK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVPH1 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVPH2 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RVPH3 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SAB IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_LOCALITY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_ADDRESS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_TERRITORY_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_LOCALITY_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_STREET_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_STREET IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_HOME_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_HOME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_HOMEPART IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_ROOM_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_ROOM IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_LOCALITY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FADR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_TERRITORY_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_LOCALITY_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_STREET_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_STREET IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_HOME_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_HOME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_HOMEPART IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_ROOM_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_ROOM IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.VIP_ACCOUNT_MANAGER IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NUMDOC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PDATE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ORGAN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PASSP_EXPIRE_TO IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PASSP_TO_BANK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.OKPO IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CUST_STATUS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CUST_ACTIVE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.TELM IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.TELW IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.TELD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.TELADD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.EMAIL IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_POST_COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_POST_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_POST_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_POST_LOC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_POST_ADR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_POST_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_FACT_COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_FACT_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_FACT_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_FACT_LOC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_FACT_ADR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_FACT_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_WORK_COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_WORK_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_WORK_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_WORK_LOC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_WORK_ADR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_WORK_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NEGATIV_STATUS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.REESTR_MOB_BANK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.REESTR_INET_BANK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.REESTR_SMS_BANK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MONTH_INCOME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SUBJECT_ROLE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.REZIDENT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MERRIED IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.EMP_STATUS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SUBJECT_CLASS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.INSIDER IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.VIPK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.VIP_FIO_MANAGER IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.VIP_PHONE_MANAGER IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DATE_ON IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DATE_OFF IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.EDDR_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ACTUAL_DATE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.BPLACE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SUBSD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SUBSN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ELT_N IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ELT_D IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.GCIF IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NOMPDV IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NOM_DOG IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SW_RN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.Y_ELT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADM IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ADR_ALT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.BUSSS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PC_MF IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PC_Z4 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PC_Z3 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PC_Z5 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PC_Z2 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PC_Z1 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.AGENT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PC_SS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.STMT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.VIDKL IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.VED IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.TIPA IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PHKLI IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.AF1_9 IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.IDDPD IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DAIDI IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DATVR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DATZ IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.IDDPL IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DATE_PHOTO IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.IDDPR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ISE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.OBSLU IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CRSRC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJOTH IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJAVI IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJ_TC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJOWF IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJCFI IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJ_LN IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DJ_FH IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.KF IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RU IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RNK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.BRANCH IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.LAST_NAME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.FIRST_NAME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.MIDDLE_NAME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SEX IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.GR IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.BDAY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.PASSP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SER IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_LOCALITY IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_ADDRESS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_TERRITORY_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_LOCALITY_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_STREET_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_STREET IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_HOME_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_HOME IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_HOMEPART IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_ROOM_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_ROOM IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_ADDRESS IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.NOTESEC IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.C_REG IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.C_DST IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RGADM IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RGTAX IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DATEA IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.DATET IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RNKP IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CUSTTYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.RIZIK IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.SED IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.CODCAGENT IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_KOATUU IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_REGION_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_AREA_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_SETTLEMENT_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_STREET_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.J_HOUSE_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_KOATUU IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_REGION_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_AREA_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_SETTLEMENT_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_STREET_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.F_HOUSE_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_KOATUU IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_REGION_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_AREA_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_SETTLEMENT_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_STREET_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTOMERS_PLT.P_HOUSE_ID IS '';




PROMPT *** Create  constraint SYS_C00120070 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS_PLT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_PLT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS_PLT ADD CONSTRAINT CC_CUSTOMERS_PLT_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_PLT_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS_PLT ADD CONSTRAINT CC_CUSTOMERS_PLT_MFO_NN CHECK (KF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_PLT_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS_PLT ADD CONSTRAINT CC_CUSTOMERS_PLT_PERID_NN CHECK (PER_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_PLT_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS_PLT ADD CONSTRAINT CC_CUSTOMERS_PLT_RNK_NN CHECK (RNK IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERS_PLT ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS_PLT ADD CONSTRAINT PK_CUSTOMERS_PLT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERS_PLT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_CUSTOMERS_PLT ON BARS_DM.CUSTOMERS_PLT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CUSTOMERS_PLT_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CUSTOMERS_PLT_PERID ON BARS_DM.CUSTOMERS_PLT (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMERS_PLT ***
grant SELECT                                                                 on CUSTOMERS_PLT   to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMERS_PLT   to BARSUPL;
grant SELECT                                                                 on CUSTOMERS_PLT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CUSTOMERS_PLT.sql =========*** End 
PROMPT ===================================================================================== 
