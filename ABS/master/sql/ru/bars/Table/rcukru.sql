

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RCUKRU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RCUKRU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RCUKRU'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RCUKRU ***
begin 
  execute immediate '
  CREATE TABLE BARS.RCUKRU 
   (	REESTR CHAR(1), 
	GR CHAR(1), 
	GR1 CHAR(1), 
	XX NUMBER(*,0), 
	BU CHAR(1), 
	NF NUMBER(*,0), 
	PR CHAR(1), 
	GLB NUMBER(*,0), 
	PRKB NUMBER(*,0), 
	RC NUMBER(*,0), 
	PRB CHAR(1), 
	KB NUMBER(*,0), 
	NB VARCHAR2(38), 
	MFO NUMBER(*,0), 
	KNB VARCHAR2(27), 
	NKS NUMBER(14,0), 
	GLMFO NUMBER(*,0), 
	PI CHAR(6), 
	NCKS CHAR(4), 
	N_ISEP CHAR(3), 
	ISEP CHAR(4), 
	HCKS CHAR(4), 
	FAX VARCHAR2(15), 
	TNP CHAR(4), 
	NP VARCHAR2(28), 
	NAI_R VARCHAR2(30), 
	KOD_R NUMBER(*,0), 
	ADRESS VARCHAR2(50), 
	FIOPB VARCHAR2(40), 
	TELPB VARCHAR2(20), 
	FIOGB VARCHAR2(40), 
	TELGB VARCHAR2(20), 
	DATAR DATE, 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	DIR NUMBER(*,0), 
	K040 CHAR(3), 
	KR NUMBER(*,0), 
	NLF VARCHAR2(27), 
	REGN VARCHAR2(12), 
	TELEFON VARCHAR2(20), 
	KU NUMBER(*,0), 
	KO NUMBER(*,0), 
	OBLUPR VARCHAR2(30), 
	TB CHAR(5), 
	NB1 VARCHAR2(40), 
	KODT CHAR(6), 
	PR_EP CHAR(1), 
	VID CHAR(3), 
	N_GLB NUMBER(*,0), 
	N_PRKB NUMBER(*,0), 
	IKOD CHAR(8), 
	PR_F CHAR(1), 
	FULLNAME VARCHAR2(240), 
	SHORTNAME VARCHAR2(80), 
	LICDATE DATE, 
	LICNUM VARCHAR2(30), 
	SID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RCUKRU ***
 exec bpa.alter_policies('RCUKRU');


COMMENT ON TABLE BARS.RCUKRU IS '';
COMMENT ON COLUMN BARS.RCUKRU.REESTR IS '';
COMMENT ON COLUMN BARS.RCUKRU.GR IS '';
COMMENT ON COLUMN BARS.RCUKRU.GR1 IS '';
COMMENT ON COLUMN BARS.RCUKRU.XX IS '';
COMMENT ON COLUMN BARS.RCUKRU.BU IS '';
COMMENT ON COLUMN BARS.RCUKRU.NF IS '';
COMMENT ON COLUMN BARS.RCUKRU.PR IS '';
COMMENT ON COLUMN BARS.RCUKRU.GLB IS '';
COMMENT ON COLUMN BARS.RCUKRU.PRKB IS '';
COMMENT ON COLUMN BARS.RCUKRU.RC IS '';
COMMENT ON COLUMN BARS.RCUKRU.PRB IS '';
COMMENT ON COLUMN BARS.RCUKRU.KB IS '';
COMMENT ON COLUMN BARS.RCUKRU.NB IS '';
COMMENT ON COLUMN BARS.RCUKRU.MFO IS '';
COMMENT ON COLUMN BARS.RCUKRU.KNB IS '';
COMMENT ON COLUMN BARS.RCUKRU.NKS IS '';
COMMENT ON COLUMN BARS.RCUKRU.GLMFO IS '';
COMMENT ON COLUMN BARS.RCUKRU.PI IS '';
COMMENT ON COLUMN BARS.RCUKRU.NCKS IS '';
COMMENT ON COLUMN BARS.RCUKRU.N_ISEP IS '';
COMMENT ON COLUMN BARS.RCUKRU.ISEP IS '';
COMMENT ON COLUMN BARS.RCUKRU.HCKS IS '';
COMMENT ON COLUMN BARS.RCUKRU.FAX IS '';
COMMENT ON COLUMN BARS.RCUKRU.TNP IS '';
COMMENT ON COLUMN BARS.RCUKRU.NP IS '';
COMMENT ON COLUMN BARS.RCUKRU.NAI_R IS '';
COMMENT ON COLUMN BARS.RCUKRU.KOD_R IS '';
COMMENT ON COLUMN BARS.RCUKRU.ADRESS IS '';
COMMENT ON COLUMN BARS.RCUKRU.FIOPB IS '';
COMMENT ON COLUMN BARS.RCUKRU.TELPB IS '';
COMMENT ON COLUMN BARS.RCUKRU.FIOGB IS '';
COMMENT ON COLUMN BARS.RCUKRU.TELGB IS '';
COMMENT ON COLUMN BARS.RCUKRU.DATAR IS '';
COMMENT ON COLUMN BARS.RCUKRU.D_OPEN IS '';
COMMENT ON COLUMN BARS.RCUKRU.D_CLOSE IS '';
COMMENT ON COLUMN BARS.RCUKRU.DIR IS '';
COMMENT ON COLUMN BARS.RCUKRU.K040 IS '';
COMMENT ON COLUMN BARS.RCUKRU.KR IS '';
COMMENT ON COLUMN BARS.RCUKRU.NLF IS '';
COMMENT ON COLUMN BARS.RCUKRU.REGN IS '';
COMMENT ON COLUMN BARS.RCUKRU.TELEFON IS '';
COMMENT ON COLUMN BARS.RCUKRU.KU IS '';
COMMENT ON COLUMN BARS.RCUKRU.KO IS '';
COMMENT ON COLUMN BARS.RCUKRU.OBLUPR IS '';
COMMENT ON COLUMN BARS.RCUKRU.TB IS '';
COMMENT ON COLUMN BARS.RCUKRU.NB1 IS '';
COMMENT ON COLUMN BARS.RCUKRU.KODT IS '';
COMMENT ON COLUMN BARS.RCUKRU.PR_EP IS '';
COMMENT ON COLUMN BARS.RCUKRU.VID IS '';
COMMENT ON COLUMN BARS.RCUKRU.N_GLB IS '';
COMMENT ON COLUMN BARS.RCUKRU.N_PRKB IS '';
COMMENT ON COLUMN BARS.RCUKRU.IKOD IS '';
COMMENT ON COLUMN BARS.RCUKRU.PR_F IS '';
COMMENT ON COLUMN BARS.RCUKRU.FULLNAME IS '';
COMMENT ON COLUMN BARS.RCUKRU.SHORTNAME IS '';
COMMENT ON COLUMN BARS.RCUKRU.LICDATE IS '';
COMMENT ON COLUMN BARS.RCUKRU.LICNUM IS '';
COMMENT ON COLUMN BARS.RCUKRU.SID IS '';



PROMPT *** Create  grants  RCUKRU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RCUKRU          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RCUKRU          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RCUKRU          to RCUKRU;
grant SELECT                                                                 on RCUKRU          to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on RCUKRU          to SEP_ROLE;
grant SELECT                                                                 on RCUKRU          to START1;
grant SELECT                                                                 on RCUKRU          to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RCUKRU          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RCUKRU          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RCUKRU.sql =========*** End *** ======
PROMPT ===================================================================================== 
