

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PB_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PB_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PB_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PB_1 
   (	LN CHAR(1), 
	DEN NUMBER(*,0), 
	MEC NUMBER(*,0), 
	GOD NUMBER(*,0), 
	BAKOD CHAR(4), 
	COUNKOD CHAR(3), 
	PARTN VARCHAR2(47), 
	VALKOD CHAR(3), 
	NLS VARCHAR2(14), 
	KOR CHAR(4), 
	KRE NUMBER(14,3), 
	DEB NUMBER(14,3), 
	COUN CHAR(3), 
	KOD CHAR(4), 
	PODK CHAR(1), 
	OPER VARCHAR2(110), 
	NAL CHAR(2), 
	BANK CHAR(4), 
	TT CHAR(3), 
	REFC NUMBER(*,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PB_1 ***
 exec bpa.alter_policies('TMP_PB_1');


COMMENT ON TABLE BARS.TMP_PB_1 IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.LN IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.DEN IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.MEC IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.GOD IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.BAKOD IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.COUNKOD IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.PARTN IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.VALKOD IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.NLS IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.KOR IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.KRE IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.DEB IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.COUN IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.KOD IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.PODK IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.OPER IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.NAL IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.BANK IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.TT IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.REFC IS '';
COMMENT ON COLUMN BARS.TMP_PB_1.KF IS '';



PROMPT *** Create  grants  TMP_PB_1 ***
grant SELECT                                                                 on TMP_PB_1        to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_PB_1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PB_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
