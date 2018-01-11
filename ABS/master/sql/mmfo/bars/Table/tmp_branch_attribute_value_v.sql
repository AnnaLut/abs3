

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BRANCH_ATTRIBUTE_VALUE_V.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BRANCH_ATTRIBUTE_VALUE_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BRANCH_ATTRIBUTE_VALUE_V ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BRANCH_ATTRIBUTE_VALUE_V 
   (	ATTRIBUTE_CODE VARCHAR2(300 CHAR), 
	BRANCH_CODE VARCHAR2(30 CHAR), 
	ATTRIBUTE_VALUE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BRANCH_ATTRIBUTE_VALUE_V ***
 exec bpa.alter_policies('TMP_BRANCH_ATTRIBUTE_VALUE_V');


COMMENT ON TABLE BARS.TMP_BRANCH_ATTRIBUTE_VALUE_V IS '';
COMMENT ON COLUMN BARS.TMP_BRANCH_ATTRIBUTE_VALUE_V.ATTRIBUTE_CODE IS '';
COMMENT ON COLUMN BARS.TMP_BRANCH_ATTRIBUTE_VALUE_V.BRANCH_CODE IS '';
COMMENT ON COLUMN BARS.TMP_BRANCH_ATTRIBUTE_VALUE_V.ATTRIBUTE_VALUE IS '';




PROMPT *** Create  constraint SYS_C00132713 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BRANCH_ATTRIBUTE_VALUE_V MODIFY (ATTRIBUTE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132714 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BRANCH_ATTRIBUTE_VALUE_V MODIFY (BRANCH_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BRANCH_ATTRIBUTE_VALUE_V ***
grant SELECT                                                                 on TMP_BRANCH_ATTRIBUTE_VALUE_V to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BRANCH_ATTRIBUTE_VALUE_V.sql =====
PROMPT ===================================================================================== 
