

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_INSURANCES.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SUBPRODUCT_INSURANCES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SUBPRODUCT_INSURANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SUBPRODUCT_INSURANCES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	INSURANCE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER, 
	ORD NUMBER, 
	WS_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SUBPRODUCT_INSURANCES ***
 exec bpa.alter_policies('TMP_WCS_SUBPRODUCT_INSURANCES');


COMMENT ON TABLE BARS.TMP_WCS_SUBPRODUCT_INSURANCES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INSURANCES.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INSURANCES.INSURANCE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INSURANCES.IS_REQUIRED IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INSURANCES.ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_INSURANCES.WS_ID IS '';




PROMPT *** Create  constraint SYS_C003175586 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SUBPRODUCT_INSURANCES MODIFY (WS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_INSURANCES.sql ====
PROMPT ===================================================================================== 
