

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_BRANCHES.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SUBPRODUCT_BRANCHES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SUBPRODUCT_BRANCHES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SUBPRODUCT_BRANCHES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	BRANCH VARCHAR2(30), 
	START_DATE DATE, 
	END_DATE DATE, 
	APPLY_HIERARCHY NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SUBPRODUCT_BRANCHES ***
 exec bpa.alter_policies('TMP_WCS_SUBPRODUCT_BRANCHES');


COMMENT ON TABLE BARS.TMP_WCS_SUBPRODUCT_BRANCHES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_BRANCHES.SUBPRODUCT_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_BRANCHES.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_BRANCHES.START_DATE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_BRANCHES.END_DATE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SUBPRODUCT_BRANCHES.APPLY_HIERARCHY IS '';




PROMPT *** Create  constraint SYS_C003175585 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SUBPRODUCT_BRANCHES MODIFY (START_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SUBPRODUCT_BRANCHES.sql ======
PROMPT ===================================================================================== 
