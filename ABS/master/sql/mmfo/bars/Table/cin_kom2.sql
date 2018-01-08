

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_KOM2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_KOM2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_KOM2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_KOM2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_KOM2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_KOM2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_KOM2 
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
	SB1_MIN NUMBER, 
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




PROMPT *** ALTER_POLICIES to CIN_KOM2 ***
 exec bpa.alter_policies('CIN_KOM2');


COMMENT ON TABLE BARS.CIN_KOM2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.RNK IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.NMK IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.NLS_2909 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.ID IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.NAME IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.MFO IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.NLS IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.REF IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.S IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.KA2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.KA1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.KB2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.KB1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.DAT1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.DAT2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.VDAT IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.KC0 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.A2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.B1 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.B2 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.C0 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.NLSR IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.REC IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.SR IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.SB1_MIN IS 'Á1~Min.ñóìà~çà ìiñÿöü';
COMMENT ON COLUMN BARS.CIN_KOM2.KB3 IS '';
COMMENT ON COLUMN BARS.CIN_KOM2.S3 IS '';



PROMPT *** Create  grants  CIN_KOM2 ***
grant SELECT                                                                 on CIN_KOM2        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_KOM2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_KOM2        to BARS_DM;
grant SELECT                                                                 on CIN_KOM2        to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_KOM2        to START1;
grant SELECT                                                                 on CIN_KOM2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_KOM2.sql =========*** End *** ====
PROMPT ===================================================================================== 
