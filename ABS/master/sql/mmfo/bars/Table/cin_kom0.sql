

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_KOM0.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_KOM0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_KOM0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_KOM0'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_KOM0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_KOM0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_KOM0 
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




PROMPT *** ALTER_POLICIES to CIN_KOM0 ***
 exec bpa.alter_policies('CIN_KOM0');


COMMENT ON TABLE BARS.CIN_KOM0 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.RNK IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.NMK IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.NLS_2909 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.ID IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.NAME IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.MFO IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.NLS IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.REF IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.S IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.KA2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.KA1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.KB2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.KB1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.DAT1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.DAT2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.VDAT IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.KC0 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.A2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.B1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.B2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.C0 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.NLSR IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.REC IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.SR IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.BRANCH IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.SB1_MIN IS 'Á1~Min.ñóìà~çà ìiñÿöü';
COMMENT ON COLUMN BARS.CIN_KOM0.B3 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.KB3 IS '';
COMMENT ON COLUMN BARS.CIN_KOM0.S3 IS '';



PROMPT *** Create  grants  CIN_KOM0 ***
grant SELECT                                                                 on CIN_KOM0        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_KOM0        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_KOM0        to BARS_DM;
grant SELECT                                                                 on CIN_KOM0        to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_KOM0        to START1;
grant SELECT                                                                 on CIN_KOM0        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_KOM0.sql =========*** End *** ====
PROMPT ===================================================================================== 
