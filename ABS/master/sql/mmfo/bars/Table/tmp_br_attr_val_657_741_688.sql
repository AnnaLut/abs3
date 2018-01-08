

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BR_ATTR_VAL_657_741_688.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BR_ATTR_VAL_657_741_688 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BR_ATTR_VAL_657_741_688 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BR_ATTR_VAL_657_741_688 
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




PROMPT *** ALTER_POLICIES to TMP_BR_ATTR_VAL_657_741_688 ***
 exec bpa.alter_policies('TMP_BR_ATTR_VAL_657_741_688');


COMMENT ON TABLE BARS.TMP_BR_ATTR_VAL_657_741_688 IS '';
COMMENT ON COLUMN BARS.TMP_BR_ATTR_VAL_657_741_688.ATTRIBUTE_CODE IS '';
COMMENT ON COLUMN BARS.TMP_BR_ATTR_VAL_657_741_688.BRANCH_CODE IS '';
COMMENT ON COLUMN BARS.TMP_BR_ATTR_VAL_657_741_688.ATTRIBUTE_VALUE IS '';




PROMPT *** Create  constraint SYS_C00137392 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_ATTR_VAL_657_741_688 MODIFY (ATTRIBUTE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137393 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BR_ATTR_VAL_657_741_688 MODIFY (BRANCH_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BR_ATTR_VAL_657_741_688 ***
grant SELECT                                                                 on TMP_BR_ATTR_VAL_657_741_688 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BR_ATTR_VAL_657_741_688.sql ======
PROMPT ===================================================================================== 
