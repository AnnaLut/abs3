

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_COST_OF_LIVING.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_COST_OF_LIVING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_COST_OF_LIVING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_COST_OF_LIVING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_COST_OF_LIVING ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_COST_OF_LIVING 
   (	DATE_S VARCHAR2(100), 
	VALUE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_COST_OF_LIVING ***
 exec bpa.alter_policies('WCS_COST_OF_LIVING');


COMMENT ON TABLE BARS.WCS_COST_OF_LIVING IS '';
COMMENT ON COLUMN BARS.WCS_COST_OF_LIVING.DATE_S IS '';
COMMENT ON COLUMN BARS.WCS_COST_OF_LIVING.VALUE IS '';




PROMPT *** Create  constraint CC_COL_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_COST_OF_LIVING ADD CONSTRAINT CC_COL_VALUE_NN CHECK (VALUE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_COLDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_COST_OF_LIVING ADD CONSTRAINT PK_COLDATE PRIMARY KEY (DATE_S)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177044 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_COST_OF_LIVING MODIFY (DATE_S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_COLDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_COLDATE ON BARS.WCS_COST_OF_LIVING (DATE_S) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_COST_OF_LIVING.sql =========*** En
PROMPT ===================================================================================== 
