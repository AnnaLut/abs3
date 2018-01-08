

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VERIFY_COMPEN_TVBV.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VERIFY_COMPEN_TVBV ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VERIFY_COMPEN_TVBV ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_VERIFY_COMPEN_TVBV 
   (	MFO VARCHAR2(12), 
	TVBV VARCHAR2(3), 
	BRANCH VARCHAR2(30), 
	OB22 VARCHAR2(2), 
	SUMCA NUMBER, 
	SUMCRKR NUMBER, 
	DIFF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_VERIFY_COMPEN_TVBV ***
 exec bpa.alter_policies('TMP_VERIFY_COMPEN_TVBV');


COMMENT ON TABLE BARS.TMP_VERIFY_COMPEN_TVBV IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN_TVBV.MFO IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN_TVBV.TVBV IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN_TVBV.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN_TVBV.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN_TVBV.SUMCA IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN_TVBV.SUMCRKR IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN_TVBV.DIFF IS '';



PROMPT *** Create  grants  TMP_VERIFY_COMPEN_TVBV ***
grant SELECT                                                                 on TMP_VERIFY_COMPEN_TVBV to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_VERIFY_COMPEN_TVBV to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_VERIFY_COMPEN_TVBV to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VERIFY_COMPEN_TVBV.sql =========**
PROMPT ===================================================================================== 
