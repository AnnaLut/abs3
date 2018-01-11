

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_TAX_DOCUMENTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_TAX_DOCUMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_DPT_TAX_DOCUMENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DPT_TAX_DOCUMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DPT_TAX_DOCUMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_TAX_DOCUMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_TAX_DOCUMENTS 
   (	PROCEDURE_NAME VARCHAR2(300 CHAR), 
	MILITARY NUMBER(1,0), 
	REF NUMBER(38,0), 
	VDAT DATE, 
	TT VARCHAR2(3 CHAR), 
	KV NUMBER(3,0), 
	INTEREST_ACCOUNT VARCHAR2(30 CHAR), 
	TAX_AMOUNT NUMBER(38,0), 
	TAX_EQUIVALENT NUMBER(38,0), 
	BRANCH VARCHAR2(30 CHAR), 
	NEW_REF NUMBER(38,0), 
	TAX_ACCOUNT VARCHAR2(30), 
	DOCUMENT_PROCESSING_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_TAX_DOCUMENTS ***
 exec bpa.alter_policies('TMP_DPT_TAX_DOCUMENTS');


COMMENT ON TABLE BARS.TMP_DPT_TAX_DOCUMENTS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.DOCUMENT_PROCESSING_COMMENT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.PROCEDURE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.MILITARY IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.REF IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.TT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.KV IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.INTEREST_ACCOUNT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.TAX_AMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.TAX_EQUIVALENT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.NEW_REF IS '';
COMMENT ON COLUMN BARS.TMP_DPT_TAX_DOCUMENTS.TAX_ACCOUNT IS '';



PROMPT *** Create  grants  TMP_DPT_TAX_DOCUMENTS ***
grant DELETE,INSERT,SELECT                                                   on TMP_DPT_TAX_DOCUMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_DPT_TAX_DOCUMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_TAX_DOCUMENTS.sql =========***
PROMPT ===================================================================================== 
