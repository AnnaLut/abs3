

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CRKR_REPORT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CRKR_REPORT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CRKR_REPORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CRKR_REPORT 
   (	MFO VARCHAR2(12), 
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




PROMPT *** ALTER_POLICIES to TMP_CRKR_REPORT ***
 exec bpa.alter_policies('TMP_CRKR_REPORT');


COMMENT ON TABLE BARS.TMP_CRKR_REPORT IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT.MFO IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_CRKR_REPORT.SS IS '';



PROMPT *** Create  grants  TMP_CRKR_REPORT ***
grant SELECT                                                                 on TMP_CRKR_REPORT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CRKR_REPORT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CRKR_REPORT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CRKR_REPORT.sql =========*** End *
PROMPT ===================================================================================== 
