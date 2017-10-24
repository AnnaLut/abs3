

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_STOPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SUBPRODUCT_STOPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SUBPRODUCT_STOPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SUBPRODUCT_STOPS 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	STOP_ID VARCHAR2(100), 
	ACT_LEVEL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SUBPRODUCT_STOPS ***
 exec bpa.alter_policies('TMP_WCS_SUBPRODUCT_STOPS');


COMMENT ON TABLE BARS.TMP_WCS_SUBPRODUCT_STOPS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_STOPS.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_STOPS.STOP_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_STOPS.ACT_LEVEL IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_STOPS.sql =========
PROMPT ===================================================================================== 
