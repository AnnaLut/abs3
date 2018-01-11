

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DEMAND_ODB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DEMAND_ODB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_DEMAND_ODB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DEMAND_ODB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DEMAND_ODB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DEMAND_ODB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_DEMAND_ODB 
   (	ACC_TYPE VARCHAR2(1), 
	CURR VARCHAR2(3), 
	CLIENT_N VARCHAR2(40), 
	COND_SET NUMBER(3,0), 
	TYPE NUMBER(1,0), 
	LACCT NUMBER(16,0), 
	BRN VARCHAR2(5), 
	CRD NUMBER(12,2), 
	ID_A NUMBER(10,0), 
	KK VARCHAR2(1), 
	WORK VARCHAR2(30), 
	REG_NR VARCHAR2(10), 
	PHONE VARCHAR2(11), 
	CNTRY VARCHAR2(15), 
	PCODE NUMBER(6,0), 
	CITY VARCHAR2(15), 
	STREET VARCHAR2(30), 
	OFFICE VARCHAR2(25), 
	PHONE_W VARCHAR2(11), 
	CNTRY_W VARCHAR2(15), 
	PCODE_W NUMBER(6,0), 
	CITY_W VARCHAR2(15), 
	STREET_W VARCHAR2(30), 
	MIN_BAL NUMBER(12,2), 
	DEPOSIT NUMBER(12,2), 
	RESIDENT NUMBER(1,0), 
	NAME VARCHAR2(24), 
	ID_C VARCHAR2(14), 
	B_DATE DATE, 
	M_NAME VARCHAR2(20), 
	MT NUMBER(10,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DEMAND_ODB ***
 exec bpa.alter_policies('TMP_DEMAND_ODB');


COMMENT ON TABLE BARS.TMP_DEMAND_ODB IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.PHONE IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.CNTRY IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.PCODE IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.CITY IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.STREET IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.OFFICE IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.PHONE_W IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.CNTRY_W IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.PCODE_W IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.CITY_W IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.STREET_W IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.MIN_BAL IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.DEPOSIT IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.RESIDENT IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.NAME IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.ID_C IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.B_DATE IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.M_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.MT IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.ACC_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.CURR IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.CLIENT_N IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.COND_SET IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.TYPE IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.LACCT IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.BRN IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.CRD IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.KK IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.WORK IS '';
COMMENT ON COLUMN BARS.TMP_DEMAND_ODB.REG_NR IS '';



PROMPT *** Create  grants  TMP_DEMAND_ODB ***
grant SELECT                                                                 on TMP_DEMAND_ODB  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DEMAND_ODB  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DEMAND_ODB  to START1;
grant SELECT                                                                 on TMP_DEMAND_ODB  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DEMAND_ODB.sql =========*** End **
PROMPT ===================================================================================== 
