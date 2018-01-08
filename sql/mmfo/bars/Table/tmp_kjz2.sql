

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KJZ2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KJZ2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KJZ2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KJZ2 
   (	ACC NUMBER(*,0), 
	ID NUMBER(*,0), 
	DK NUMBER(*,0), 
	UD NUMBER(*,0), 
	KAS VARCHAR2(15), 
	ND VARCHAR2(10), 
	NLS VARCHAR2(15), 
	S NUMBER(*,0), 
	SK NUMBER(*,0), 
	FDAT DATE, 
	REF NUMBER(*,0), 
	TT CHAR(3), 
	PDAT DATE, 
	SOS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KJZ2 ***
 exec bpa.alter_policies('TMP_KJZ2');


COMMENT ON TABLE BARS.TMP_KJZ2 IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.ACC IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.ID IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.DK IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.UD IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.KAS IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.ND IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.NLS IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.S IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.SK IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.REF IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.TT IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.PDAT IS '';
COMMENT ON COLUMN BARS.TMP_KJZ2.SOS IS '';



PROMPT *** Create  grants  TMP_KJZ2 ***
grant SELECT                                                                 on TMP_KJZ2        to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_KJZ2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_KJZ2        to BARS_DM;
grant SELECT                                                                 on TMP_KJZ2        to RPBN001;
grant SELECT                                                                 on TMP_KJZ2        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_KJZ2        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KJZ2.sql =========*** End *** ====
PROMPT ===================================================================================== 
