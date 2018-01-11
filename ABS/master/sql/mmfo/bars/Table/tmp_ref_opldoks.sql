

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REF_OPLDOKS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REF_OPLDOKS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REF_OPLDOKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REF_OPLDOKS 
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




PROMPT *** ALTER_POLICIES to TMP_REF_OPLDOKS ***
 exec bpa.alter_policies('TMP_REF_OPLDOKS');


COMMENT ON TABLE BARS.TMP_REF_OPLDOKS IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.REF IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.TT IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.DK IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.S IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.SQ IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.TXT IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.STMT IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.SOS IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.KF IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.OTM IS '';
COMMENT ON COLUMN BARS.TMP_REF_OPLDOKS.ID IS '';



PROMPT *** Create  grants  TMP_REF_OPLDOKS ***
grant SELECT                                                                 on TMP_REF_OPLDOKS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REF_OPLDOKS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REF_OPLDOKS.sql =========*** End *
PROMPT ===================================================================================== 
