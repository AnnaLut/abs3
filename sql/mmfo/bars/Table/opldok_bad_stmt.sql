

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPLDOK_BAD_STMT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPLDOK_BAD_STMT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPLDOK_BAD_STMT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPLDOK_BAD_STMT 
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




PROMPT *** ALTER_POLICIES to OPLDOK_BAD_STMT ***
 exec bpa.alter_policies('OPLDOK_BAD_STMT');


COMMENT ON TABLE BARS.OPLDOK_BAD_STMT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.REF IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.TT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.DK IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.ACC IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.FDAT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.S IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.SQ IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.TXT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.STMT IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.SOS IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.KF IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.OTM IS '';
COMMENT ON COLUMN BARS.OPLDOK_BAD_STMT.ID IS '';



PROMPT *** Create  grants  OPLDOK_BAD_STMT ***
grant SELECT                                                                 on OPLDOK_BAD_STMT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPLDOK_BAD_STMT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPLDOK_BAD_STMT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPLDOK_BAD_STMT to START1;
grant SELECT                                                                 on OPLDOK_BAD_STMT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPLDOK_BAD_STMT.sql =========*** End *
PROMPT ===================================================================================== 
