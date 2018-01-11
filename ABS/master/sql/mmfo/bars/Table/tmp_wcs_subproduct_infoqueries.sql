

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_INFOQUERIES.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SUBPRODUCT_INFOQUERIES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SUBPRODUCT_INFOQUERIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	IQUERY_ID VARCHAR2(100), 
	ACT_LEVEL NUMBER, 
	SERVICE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER, 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SUBPRODUCT_INFOQUERIES ***
 exec bpa.alter_policies('TMP_WCS_SUBPRODUCT_INFOQUERIES');


COMMENT ON TABLE BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES.IQUERY_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES.ACT_LEVEL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES.SERVICE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES.IS_REQUIRED IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INFOQUERIES.ORD IS '';



PROMPT *** Create  grants  TMP_WCS_SUBPRODUCT_INFOQUERIES ***
grant SELECT                                                                 on TMP_WCS_SUBPRODUCT_INFOQUERIES to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_WCS_SUBPRODUCT_INFOQUERIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_INFOQUERIES.sql ===
PROMPT ===================================================================================== 
