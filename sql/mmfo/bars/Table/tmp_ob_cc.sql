

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB_CC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB_CC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_OB_CC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB_CC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB_CC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB_CC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OB_CC 
   (	MFO NUMBER, 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(70), 
	CUSTTYPE NUMBER(*,0), 
	REZ NUMBER(*,0), 
	EVENT_TYPE NUMBER(1,0), 
	EVENT_DATE DATE, 
	ND NUMBER(*,0), 
	KV NUMBER(*,0), 
	CC_ID VARCHAR2(16), 
	SDATE DATE, 
	LIMIT NUMBER, 
	FIN CHAR(1), 
	WDATE DATE, 
	AIM VARCHAR2(70), 
	S NUMBER, 
	IR NUMBER(*,0), 
	S080 NUMBER(*,0), 
	VZ NUMBER(2,0), 
	CHARZ VARCHAR2(70), 
	S_ZAST NUMBER(16,0), 
	MOTIVE VARCHAR2(70), 
	NLS VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB_CC ***
 exec bpa.alter_policies('TMP_OB_CC');


COMMENT ON TABLE BARS.TMP_OB_CC IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.MFO IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.NMK IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.ADR IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.REZ IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.EVENT_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.EVENT_DATE IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.ND IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.KV IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.LIMIT IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.FIN IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.AIM IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.S IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.IR IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.S080 IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.VZ IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.CHARZ IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.S_ZAST IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.MOTIVE IS '';
COMMENT ON COLUMN BARS.TMP_OB_CC.NLS IS '';



PROMPT *** Create  grants  TMP_OB_CC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB_CC       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB_CC       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB_CC.sql =========*** End *** ===
PROMPT ===================================================================================== 
