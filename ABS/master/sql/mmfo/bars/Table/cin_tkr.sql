

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_TKR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_TKR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_TKR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TKR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TKR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_TKR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_TKR 
   (	RNK NUMBER(*,0), 
	NMK VARCHAR2(35), 
	NLS_2909 VARCHAR2(14), 
	ID NUMBER(*,0), 
	NAME VARCHAR2(35), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(14), 
	REF NUMBER(*,0), 
	S NUMBER(19,2), 
	KA2 NUMBER(19,2), 
	KA1 NUMBER(19,2), 
	KB2 NUMBER(19,2), 
	KB1 NUMBER(19,2), 
	DAT1 DATE, 
	DAT2 DATE, 
	VDAT DATE, 
	KC0 NUMBER(19,2), 
	A2 NUMBER(19,2), 
	B1 NUMBER(19,2), 
	B2 NUMBER(19,2), 
	C0 NUMBER(19,2), 
	NLSR VARCHAR2(14), 
	REC NUMBER(*,0), 
	SR NUMBER, 
	BRANCH VARCHAR2(22), 
	REF_KOM NUMBER(*,0) DEFAULT null, 
	SB1_MIN NUMBER, 
	B3 NUMBER(19,2), 
	KB3 NUMBER(19,2), 
	S3 NUMBER(19,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_TKR ***
 exec bpa.alter_policies('CIN_TKR');


COMMENT ON TABLE BARS.CIN_TKR IS '';
COMMENT ON COLUMN BARS.CIN_TKR.RNK IS '';
COMMENT ON COLUMN BARS.CIN_TKR.NMK IS '';
COMMENT ON COLUMN BARS.CIN_TKR.NLS_2909 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.ID IS '';
COMMENT ON COLUMN BARS.CIN_TKR.NAME IS '';
COMMENT ON COLUMN BARS.CIN_TKR.MFO IS '';
COMMENT ON COLUMN BARS.CIN_TKR.NLS IS '';
COMMENT ON COLUMN BARS.CIN_TKR.REF IS '';
COMMENT ON COLUMN BARS.CIN_TKR.S IS '';
COMMENT ON COLUMN BARS.CIN_TKR.KA2 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.KA1 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.KB2 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.KB1 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.DAT1 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.DAT2 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.VDAT IS '';
COMMENT ON COLUMN BARS.CIN_TKR.KC0 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.A2 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.B1 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.B2 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.C0 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.NLSR IS '';
COMMENT ON COLUMN BARS.CIN_TKR.REC IS '';
COMMENT ON COLUMN BARS.CIN_TKR.SR IS '';
COMMENT ON COLUMN BARS.CIN_TKR.BRANCH IS '';
COMMENT ON COLUMN BARS.CIN_TKR.REF_KOM IS '';
COMMENT ON COLUMN BARS.CIN_TKR.SB1_MIN IS 'Á1~Min.ñóìà~çà ìiñÿöü';
COMMENT ON COLUMN BARS.CIN_TKR.B3 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.KB3 IS '';
COMMENT ON COLUMN BARS.CIN_TKR.S3 IS '';



PROMPT *** Create  grants  CIN_TKR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TKR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_TKR         to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_TKR         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_TKR.sql =========*** End *** =====
PROMPT ===================================================================================== 
