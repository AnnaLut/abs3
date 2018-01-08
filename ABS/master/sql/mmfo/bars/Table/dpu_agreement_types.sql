

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_AGREEMENT_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_AGREEMENT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_AGREEMENT_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_AGREEMENT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_AGREEMENT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_AGREEMENT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_AGREEMENT_TYPES 
   (	ID NUMBER(3,0), 
	NAME VARCHAR2(100), 
	TEMPLATE VARCHAR2(35), 
	ACTIVE NUMBER(1,0) DEFAULT 1, 
	CONFIRM NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_AGREEMENT_TYPES ***
 exec bpa.alter_policies('DPU_AGREEMENT_TYPES');


COMMENT ON TABLE BARS.DPU_AGREEMENT_TYPES IS 'Види додаткових угод (ДУ) до депозитних договорів ЮО';
COMMENT ON COLUMN BARS.DPU_AGREEMENT_TYPES.ID IS 'Ідентифікатор виду додаткової угоди';
COMMENT ON COLUMN BARS.DPU_AGREEMENT_TYPES.NAME IS 'Назва додаткової угоди';
COMMENT ON COLUMN BARS.DPU_AGREEMENT_TYPES.TEMPLATE IS 'Ідентифікатор шаблону для друку';
COMMENT ON COLUMN BARS.DPU_AGREEMENT_TYPES.ACTIVE IS 'Ознака активності ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENT_TYPES.CONFIRM IS 'Ознака необхідності погодження ДУ';




PROMPT *** Create  constraint PK_DPUAGRMNTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENT_TYPES ADD CONSTRAINT PK_DPUAGRMNTTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTTYPES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENT_TYPES MODIFY (ID CONSTRAINT CC_DPUAGRMNTTYPES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENT_TYPES MODIFY (NAME CONSTRAINT CC_DPUAGRMNTTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTTYPES_TEMPLATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENT_TYPES MODIFY (TEMPLATE CONSTRAINT CC_DPUAGRMNTTYPES_TEMPLATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTTYPES_ACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENT_TYPES MODIFY (ACTIVE CONSTRAINT CC_DPUAGRMNTTYPES_ACTIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTTYPES_CONFIRM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENT_TYPES MODIFY (CONFIRM CONSTRAINT CC_DPUAGRMNTTYPES_CONFIRM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUAGRMNTTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUAGRMNTTYPES ON BARS.DPU_AGREEMENT_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_AGREEMENT_TYPES ***
grant SELECT                                                                 on DPU_AGREEMENT_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on DPU_AGREEMENT_TYPES to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_AGREEMENT_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_AGREEMENT_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_AGREEMENT_TYPES to DPT_ADMIN;
grant SELECT                                                                 on DPU_AGREEMENT_TYPES to START1;
grant SELECT                                                                 on DPU_AGREEMENT_TYPES to UPLD;
grant FLASHBACK,SELECT                                                       on DPU_AGREEMENT_TYPES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_AGREEMENT_TYPES.sql =========*** E
PROMPT ===================================================================================== 
