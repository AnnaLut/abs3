

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MONEXR_0.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MONEXR_0 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MONEXR_0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_MONEXR_0 
   (	FDAT DATE, 
	OB22 CHAR(2), 
	BRANCH CHAR(22), 
	KV NUMBER(*,0), 
	S_2909 NUMBER(38,0), 
	K_2909 NUMBER(38,0), 
	S_2809 NUMBER(38,0), 
	K_2809 NUMBER(38,0), 
	S_0000 NUMBER(38,0), 
	K_0000 NUMBER(38,0), 
	FL NUMBER(*,0), 
	RS_2909 NUMBER(38,0), 
	RK_2909 NUMBER(38,0), 
	RS_2809 NUMBER(38,0), 
	RK_2809 NUMBER(38,0), 
	RS_0000 NUMBER(38,0), 
	RK_0000 NUMBER(38,0), 
	KOD_NBU VARCHAR2(5), 
	FM NUMBER(*,0), 
	KOMB1 NUMBER, 
	KOMB2 NUMBER, 
	KOMB3 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MONEXR_0 ***
 exec bpa.alter_policies('TMP_MONEXR_0');


COMMENT ON TABLE BARS.TMP_MONEXR_0 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.KV IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.S_2909 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.K_2909 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.S_2809 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.K_2809 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.S_0000 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.K_0000 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.FL IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.RS_2909 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.RK_2909 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.RS_2809 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.RK_2809 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.RS_0000 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.RK_0000 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.KOD_NBU IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.FM IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.KOMB1 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.KOMB2 IS '';
COMMENT ON COLUMN BARS.TMP_MONEXR_0.KOMB3 IS '';



PROMPT *** Create  grants  TMP_MONEXR_0 ***
grant SELECT                                                                 on TMP_MONEXR_0    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_MONEXR_0    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MONEXR_0.sql =========*** End *** 
PROMPT ===================================================================================== 
