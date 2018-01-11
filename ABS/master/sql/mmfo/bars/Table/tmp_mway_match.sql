

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MWAY_MATCH.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MWAY_MATCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MWAY_MATCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_MWAY_MATCH 
   (	ID NUMBER, 
	DATE_TR DATE, 
	SUM_TR NUMBER(*,0), 
	LCV_TR VARCHAR2(3), 
	NLS_TR VARCHAR2(15), 
	RRN_TR VARCHAR2(100), 
	DRN_TR VARCHAR2(100), 
	STATE NUMBER, 
	REF_TR NUMBER(38,0), 
	REF_FEE_TR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MWAY_MATCH ***
 exec bpa.alter_policies('TMP_MWAY_MATCH');


COMMENT ON TABLE BARS.TMP_MWAY_MATCH IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.ID IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.DATE_TR IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.SUM_TR IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.LCV_TR IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.NLS_TR IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.RRN_TR IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.DRN_TR IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.STATE IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.REF_TR IS '';
COMMENT ON COLUMN BARS.TMP_MWAY_MATCH.REF_FEE_TR IS '';



PROMPT *** Create  grants  TMP_MWAY_MATCH ***
grant SELECT                                                                 on TMP_MWAY_MATCH  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MWAY_MATCH.sql =========*** End **
PROMPT ===================================================================================== 
