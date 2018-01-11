

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPLDOK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPLDOK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPLDOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPLDOK 
   (	REF NUMBER(38,0), 
	TT CHAR(3), 
	DK NUMBER(1,0), 
	ACC NUMBER(38,0), 
	FDAT DATE, 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	TXT VARCHAR2(70), 
	STMT NUMBER(38,0), 
	SOS NUMBER(1,0), 
	KF VARCHAR2(6), 
	OTM NUMBER(*,0), 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPLDOK ***
 exec bpa.alter_policies('TMP_OPLDOK');


COMMENT ON TABLE BARS.TMP_OPLDOK IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.REF IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.TT IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.DK IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.ACC IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.S IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.SQ IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.TXT IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.STMT IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.SOS IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.KF IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.OTM IS '';
COMMENT ON COLUMN BARS.TMP_OPLDOK.ID IS '';



PROMPT *** Create  grants  TMP_OPLDOK ***
grant SELECT                                                                 on TMP_OPLDOK      to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OPLDOK      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPLDOK.sql =========*** End *** ==
PROMPT ===================================================================================== 
