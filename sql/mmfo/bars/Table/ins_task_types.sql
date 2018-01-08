

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_TASK_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_TASK_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_TASK_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_TASK_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_TASK_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_TASK_TYPES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	PRIORITY NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_TASK_TYPES ***
 exec bpa.alter_policies('INS_TASK_TYPES');


COMMENT ON TABLE BARS.INS_TASK_TYPES IS 'Типи завдань по платіжним графікам по договорам страхування';
COMMENT ON COLUMN BARS.INS_TASK_TYPES.PRIORITY IS 'Приоритет';
COMMENT ON COLUMN BARS.INS_TASK_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_TASK_TYPES.NAME IS 'Найменування';




PROMPT *** Create  constraint CC_INSTASKTYPES_PRT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TASK_TYPES MODIFY (PRIORITY CONSTRAINT CC_INSTASKTYPES_PRT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSTASKTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TASK_TYPES ADD CONSTRAINT PK_INSTASKTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSTASKTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSTASKTYPES ON BARS.INS_TASK_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_TASK_TYPES ***
grant SELECT                                                                 on INS_TASK_TYPES  to BARSREADER_ROLE;
grant SELECT                                                                 on INS_TASK_TYPES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_TASK_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
