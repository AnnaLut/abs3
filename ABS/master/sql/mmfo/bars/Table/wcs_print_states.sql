

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PRINT_STATES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PRINT_STATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PRINT_STATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PRINT_STATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PRINT_STATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PRINT_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PRINT_STATES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_PRINT_STATES ***
 exec bpa.alter_policies('WCS_PRINT_STATES');


COMMENT ON TABLE BARS.WCS_PRINT_STATES IS 'Этапы печати документов';
COMMENT ON COLUMN BARS.WCS_PRINT_STATES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_PRINT_STATES.NAME IS 'Наименование';




PROMPT *** Create  constraint CC_PRINTSTATES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PRINT_STATES MODIFY (NAME CONSTRAINT CC_PRINTSTATES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PRINTSTATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PRINT_STATES ADD CONSTRAINT PK_PRINTSTATES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRINTSTATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRINTSTATES ON BARS.WCS_PRINT_STATES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PRINT_STATES ***
grant SELECT                                                                 on WCS_PRINT_STATES to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_PRINT_STATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PRINT_STATES to BARS_DM;
grant SELECT                                                                 on WCS_PRINT_STATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PRINT_STATES.sql =========*** End 
PROMPT ===================================================================================== 
