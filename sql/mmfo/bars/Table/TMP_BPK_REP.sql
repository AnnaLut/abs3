

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_REP.sql =========*** Run *** ===
PROMPT ===================================================================================== 

PROMPT *** Create  table TMP_BPK_REP ***
begin execute immediate 'CREATE TABLE BARS.TMP_BPK_REP 
   (	ACC NUMBER(38,0), 
	NMK VARCHAR2(70), 
	RNK NUMBER(38,0), 
	OPEN_DATE DATE, 
	NLS VARCHAR2(15), 
	KF VARCHAR2(6), 
	LIM_BEGIN NUMBER, 
	LIM NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_BPK_REP       to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_REP.sql =========*** End *** ===
PROMPT ===================================================================================== 