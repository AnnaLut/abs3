

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_DOC_REVISE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PRIOCOM_DOC_REVISE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_PRIOCOM_DOC_REVISE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_DOC_REVISE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_DOC_REVISE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PRIOCOM_DOC_REVISE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_PRIOCOM_DOC_REVISE 
   (	REF NUMBER, 
	STMT NUMBER, 
	ACCOUNT1 VARCHAR2(14), 
	ACCOUNT2 VARCHAR2(14), 
	DOCSUM NUMBER, 
	CURRENCY NUMBER(*,0), 
	MFO_A VARCHAR2(6), 
	MFO_B VARCHAR2(6), 
	DOC_ID NUMBER, 
	STATUS NUMBER(*,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PRIOCOM_DOC_REVISE ***
 exec bpa.alter_policies('TMP_PRIOCOM_DOC_REVISE');


COMMENT ON TABLE BARS.TMP_PRIOCOM_DOC_REVISE IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.CURRENCY IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.MFO_A IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.MFO_B IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.DOC_ID IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.STATUS IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.REF IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.STMT IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.ACCOUNT1 IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.ACCOUNT2 IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_REVISE.DOCSUM IS '';



PROMPT *** Create  grants  TMP_PRIOCOM_DOC_REVISE ***
grant SELECT                                                                 on TMP_PRIOCOM_DOC_REVISE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_DOC_REVISE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_DOC_REVISE to START1;
grant SELECT                                                                 on TMP_PRIOCOM_DOC_REVISE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_DOC_REVISE.sql =========**
PROMPT ===================================================================================== 
