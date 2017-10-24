

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_GARANTEES.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SUBPRODUCT_GARANTEES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SUBPRODUCT_GARANTEES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SUBPRODUCT_GARANTEES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	GARANTEE_ID VARCHAR2(100), 
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




PROMPT *** ALTER_POLICIES to TMP_WCS_SUBPRODUCT_GARANTEES ***
 exec bpa.alter_policies('TMP_WCS_SUBPRODUCT_GARANTEES');


COMMENT ON TABLE BARS.TMP_WCS_SUBPRODUCT_GARANTEES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_GARANTEES.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_GARANTEES.GARANTEE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_GARANTEES.IS_REQUIRED IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_GARANTEES.ORD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_GARANTEES.sql =====
PROMPT ===================================================================================== 
