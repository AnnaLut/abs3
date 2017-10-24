

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CRKR_REPORT_TVBV.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CRKR_REPORT_TVBV ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CRKR_REPORT_TVBV ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CRKR_REPORT_TVBV 
   (	MFO VARCHAR2(12), 
	TVBV VARCHAR2(3), 
	BRANCH VARCHAR2(30), 
	OB22 VARCHAR2(4), 
	SS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CRKR_REPORT_TVBV ***
 exec bpa.alter_policies('TMP_CRKR_REPORT_TVBV');


COMMENT ON TABLE BARS.TMP_CRKR_REPORT_TVBV IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT_TVBV.MFO IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT_TVBV.TVBV IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT_TVBV.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT_TVBV.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT_TVBV.SS IS '';



PROMPT *** Create  grants  TMP_CRKR_REPORT_TVBV ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CRKR_REPORT_TVBV to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CRKR_REPORT_TVBV.sql =========*** 
PROMPT ===================================================================================== 
