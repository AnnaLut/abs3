

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_REP_DOX.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_REP_DOX ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_REP_DOX ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CP_REP_DOX 
   (	DAT_UG DATE, 
	CP_ID VARCHAR2(20), 
	KV NUMBER(*,0), 
	NBS CHAR(4), 
	NMS VARCHAR2(50), 
	DATP DATE, 
	KOL NUMBER, 
	CENA_KUP NUMBER, 
	D01 DATE, 
	D31 DATE, 
	REF NUMBER, 
	ID NUMBER, 
	SR NUMBER, 
	SD NUMBER, 
	SRQ NUMBER, 
	SDQ NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_REP_DOX ***
 exec bpa.alter_policies('TMP_CP_REP_DOX');


COMMENT ON TABLE BARS.TMP_CP_REP_DOX IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.DAT_UG IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.CP_ID IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.KV IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.NBS IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.NMS IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.DATP IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.KOL IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.CENA_KUP IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.D01 IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.D31 IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.REF IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.ID IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.SR IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.SD IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.SRQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_REP_DOX.SDQ IS '';



PROMPT *** Create  grants  TMP_CP_REP_DOX ***
grant SELECT                                                                 on TMP_CP_REP_DOX  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CP_REP_DOX  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_REP_DOX.sql =========*** End **
PROMPT ===================================================================================== 
