

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_ATTRIBUTE_VALUE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_ATTRIBUTE_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_ATTRIBUTE_VALUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_ATTRIBUTE_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_ATTRIBUTE_VALUE 
   (	ATTRIBUTE_CODE VARCHAR2(300 CHAR), 
	BRANCH_CODE VARCHAR2(30 CHAR), 
	ATTRIBUTE_VALUE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_ATTRIBUTE_VALUE ***
 exec bpa.alter_policies('BRANCH_ATTRIBUTE_VALUE');


COMMENT ON TABLE BARS.BRANCH_ATTRIBUTE_VALUE IS 'Значения аттрибутов бранча (значения параметров)';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE_VALUE.ATTRIBUTE_CODE IS 'Код аттрибута';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE_VALUE.BRANCH_CODE IS 'Код отделения';
COMMENT ON COLUMN BARS.BRANCH_ATTRIBUTE_VALUE.ATTRIBUTE_VALUE IS 'Значение аттрибута';




PROMPT *** Create  constraint SYS_C0030814 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_ATTRIBUTE_VALUE MODIFY (BRANCH_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030813 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_ATTRIBUTE_VALUE MODIFY (ATTRIBUTE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UIDX_BRANCH_ATTRIBUTE_VALUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UIDX_BRANCH_ATTRIBUTE_VALUE ON BARS.BRANCH_ATTRIBUTE_VALUE (BRANCH_CODE, ATTRIBUTE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_ATTRIBUTE_VALUE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_ATTRIBUTE_VALUE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_ATTRIBUTE_VALUE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_ATTRIBUTE_VALUE.sql =========**
PROMPT ===================================================================================== 
