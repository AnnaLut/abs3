

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_BRANCH_PARAMS_VALUES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_BRANCH_PARAMS_VALUES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_BRANCH_PARAMS_VALUES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_BRANCH_PARAMS_VALUES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_BRANCH_PARAMS_VALUES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_BRANCH_PARAMS_VALUES 
   (	BRANCH VARCHAR2(30), 
	TAG VARCHAR2(16), 
	VAL VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_BRANCH_PARAMS_VALUES ***
 exec bpa.alter_policies('CM_BRANCH_PARAMS_VALUES');


COMMENT ON TABLE BARS.CM_BRANCH_PARAMS_VALUES IS 'Параметри безбалансових відділень';
COMMENT ON COLUMN BARS.CM_BRANCH_PARAMS_VALUES.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.CM_BRANCH_PARAMS_VALUES.TAG IS 'Код параметру';
COMMENT ON COLUMN BARS.CM_BRANCH_PARAMS_VALUES.VAL IS 'Значення параметру';




PROMPT *** Create  constraint PK_CMBRANCHPARAMSVALUES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_BRANCH_PARAMS_VALUES ADD CONSTRAINT PK_CMBRANCHPARAMSVALUES PRIMARY KEY (BRANCH, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMBRANCHPARAMS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_BRANCH_PARAMS_VALUES MODIFY (TAG CONSTRAINT CC_CMBRANCHPARAMS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMBRANCHPARAMS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_BRANCH_PARAMS_VALUES MODIFY (BRANCH CONSTRAINT CC_CMBRANCHPARAMS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMBRANCHPARAMSVALUES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMBRANCHPARAMSVALUES ON BARS.CM_BRANCH_PARAMS_VALUES (BRANCH, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_BRANCH_PARAMS_VALUES ***
grant SELECT                                                                 on CM_BRANCH_PARAMS_VALUES to CM_ACCESS_ROLE;



PROMPT *** Create SYNONYM  to CM_BRANCH_PARAMS_VALUES ***

  CREATE OR REPLACE PUBLIC SYNONYM CM_BRANCH_PARAMS_VALUES FOR BARS.CM_BRANCH_PARAMS_VALUES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_BRANCH_PARAMS_VALUES.sql =========*
PROMPT ===================================================================================== 
