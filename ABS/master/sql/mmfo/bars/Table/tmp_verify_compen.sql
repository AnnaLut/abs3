

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VERIFY_COMPEN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VERIFY_COMPEN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VERIFY_COMPEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_VERIFY_COMPEN 
   (	BRANCH VARCHAR2(30), 
	OB22 VARCHAR2(2), 
	SUMCA NUMBER, 
	SUMCRKR NUMBER, 
	DIFF NUMBER, 
	ZALCA NUMBER, 
	DIFFCA NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_VERIFY_COMPEN ***
 exec bpa.alter_policies('TMP_VERIFY_COMPEN');


COMMENT ON TABLE BARS.TMP_VERIFY_COMPEN IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN.SUMCA IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN.SUMCRKR IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN.DIFF IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN.ZALCA IS '';
COMMENT ON COLUMN BARS.TMP_VERIFY_COMPEN.DIFFCA IS '';



PROMPT *** Create  grants  TMP_VERIFY_COMPEN ***
grant SELECT                                                                 on TMP_VERIFY_COMPEN to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_VERIFY_COMPEN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_VERIFY_COMPEN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VERIFY_COMPEN.sql =========*** End
PROMPT ===================================================================================== 
