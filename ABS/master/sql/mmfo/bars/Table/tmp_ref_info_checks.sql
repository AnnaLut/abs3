

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REF_INFO_CHECKS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REF_INFO_CHECKS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REF_INFO_CHECKS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REF_INFO_CHECKS 
   (	REF NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	DAT DATE, 
	KV VARCHAR2(3), 
	S NUMBER(24,2), 
	SKOM NUMBER(24,2), 
	PRKOM NUMBER(3,2), 
	SOS NUMBER(2,0), 
	BACKTIME VARCHAR2(10), 
	BANE VARCHAR2(100), 
	NOMC VARCHAR2(4), 
	NUMC VARCHAR2(200), 
	CNT NUMBER, 
	USID NUMBER, 
	R_TYPE NUMBER(1,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REF_INFO_CHECKS ***
 exec bpa.alter_policies('TMP_REF_INFO_CHECKS');


COMMENT ON TABLE BARS.TMP_REF_INFO_CHECKS IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.REF IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.DAT IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.KV IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.S IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.SKOM IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.PRKOM IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.SOS IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.BACKTIME IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.BANE IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.NOMC IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.NUMC IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.CNT IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.USID IS '';
COMMENT ON COLUMN BARS.TMP_REF_INFO_CHECKS.R_TYPE IS '';



PROMPT *** Create  grants  TMP_REF_INFO_CHECKS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REF_INFO_CHECKS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REF_INFO_CHECKS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REF_INFO_CHECKS.sql =========*** E
PROMPT ===================================================================================== 
