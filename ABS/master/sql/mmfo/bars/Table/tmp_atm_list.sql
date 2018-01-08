

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ATM_LIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ATM_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ATM_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ATM_LIST 
   (	RU VARCHAR2(80), 
	MFO VARCHAR2(6), 
	TOBO VARCHAR2(80), 
	ADDRES VARCHAR2(80), 
	DATE_R VARCHAR2(80), 
	PRODUCT VARCHAR2(80), 
	MERCHANT_ID VARCHAR2(80), 
	TERMINAL_ID VARCHAR2(80), 
	PORT VARCHAR2(80), 
	IP_KIOSK_ATM VARCHAR2(80), 
	SERIAL_NUMBER VARCHAR2(80), 
	NLS_2920 VARCHAR2(80), 
	NLS_1004 VARCHAR2(80), 
	OLD_2924_7 VARCHAR2(15), 
	DAZS_OLD_2924_7 DATE, 
	NEW_2924_7 VARCHAR2(15), 
	OLD_2924_33 VARCHAR2(15), 
	DAZS_OLD_2924_33 DATE, 
	NEW_2924_33 VARCHAR2(15), 
	OLD_2924_8 VARCHAR2(15), 
	DAZS_OLD_2924_8 DATE, 
	NEW_2924_8 VARCHAR2(15), 
	BRANCH VARCHAR2(30), 
	E7 NUMBER(*,0), 
	E8 NUMBER(*,0), 
	E33 NUMBER(*,0), 
	NMS VARCHAR2(70), 
	GRP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ATM_LIST ***
 exec bpa.alter_policies('TMP_ATM_LIST');


COMMENT ON TABLE BARS.TMP_ATM_LIST IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.RU IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.MFO IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.ADDRES IS 'Адреса відділення ';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.DATE_R IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.PRODUCT IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.MERCHANT_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.TERMINAL_ID IS 'ID терміналу';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.PORT IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.IP_KIOSK_ATM IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.SERIAL_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.NLS_2920 IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.NLS_1004 IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.OLD_2924_7 IS 'Рахунок 2924/07';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.DAZS_OLD_2924_7 IS 'Дата закриття рахунку 2924/07';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.NEW_2924_7 IS 'Рахунок 2924/08 плановий (по масці)';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.OLD_2924_33 IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.DAZS_OLD_2924_33 IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.NEW_2924_33 IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.OLD_2924_8 IS 'Рахунок 2924/08';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.DAZS_OLD_2924_8 IS 'Дата закриття рахунку 2924/08';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.NEW_2924_8 IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.BRANCH IS 'Бранч рахунку 1004';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.E7 IS 'Наявність відкритого планового рахунку 2924/07';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.E8 IS 'Наявність відкритого планового рахунку 2924/08';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.E33 IS '';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.NMS IS 'Назва рахунку';
COMMENT ON COLUMN BARS.TMP_ATM_LIST.GRP IS 'Група рахунку';



PROMPT *** Create  grants  TMP_ATM_LIST ***
grant SELECT                                                                 on TMP_ATM_LIST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ATM_LIST.sql =========*** End *** 
PROMPT ===================================================================================== 
