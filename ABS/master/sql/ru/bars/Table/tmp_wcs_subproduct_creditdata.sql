

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_CREDITDATA.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SUBPRODUCT_CREDITDATA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SUBPRODUCT_CREDITDATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SUBPRODUCT_CREDITDATA 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	CRDDATA_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	IS_VISIBLE NUMBER, 
	IS_CHECKABLE NUMBER, 
	CHECK_PROC VARCHAR2(4000), 
	IS_READONLY VARCHAR2(4000), 
	DNSHOW_IF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SUBPRODUCT_CREDITDATA ***
 exec bpa.alter_policies('TMP_WCS_SUBPRODUCT_CREDITDATA');


COMMENT ON TABLE BARS.TMP_WCS_SUBPRODUCT_CREDITDATA IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.CRDDATA_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.IS_VISIBLE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.IS_CHECKABLE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.CHECK_PROC IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.IS_READONLY IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_CREDITDATA.DNSHOW_IF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_CREDITDATA.sql ====
PROMPT ===================================================================================== 
