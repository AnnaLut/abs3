

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PHASES_TIMELIMITS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PHASES_TIMELIMITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PHASES_TIMELIMITS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PHASES_TIMELIMITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PHASES_TIMELIMITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PHASES_TIMELIMITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PHASES_TIMELIMITS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TIMELIMIT NUMBER, 
	PHASE_ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_PHASES_TIMELIMITS ***
 exec bpa.alter_policies('WCS_PHASES_TIMELIMITS');


COMMENT ON TABLE BARS.WCS_PHASES_TIMELIMITS IS 'Нормативи часу розгляду заявки службами по етапах';
COMMENT ON COLUMN BARS.WCS_PHASES_TIMELIMITS.ID IS 'Ідентифікатор этапу';
COMMENT ON COLUMN BARS.WCS_PHASES_TIMELIMITS.NAME IS 'Наименування этапу';
COMMENT ON COLUMN BARS.WCS_PHASES_TIMELIMITS.TIMELIMIT IS 'Нормативний час розгляду заявки (у днях)';
COMMENT ON COLUMN BARS.WCS_PHASES_TIMELIMITS.PHASE_ORD IS 'Послыдовний порядок этапу';




PROMPT *** Create  constraint CC_WCSPHASESTLIMS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PHASES_TIMELIMITS MODIFY (NAME CONSTRAINT CC_WCSPHASESTLIMS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSPHASESTLIMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PHASES_TIMELIMITS ADD CONSTRAINT PK_WCSPHASESTLIMS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSPHASESTLIMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSPHASESTLIMS ON BARS.WCS_PHASES_TIMELIMITS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PHASES_TIMELIMITS ***
grant SELECT                                                                 on WCS_PHASES_TIMELIMITS to BARSREADER_ROLE;
grant FLASHBACK,SELECT,UPDATE                                                on WCS_PHASES_TIMELIMITS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PHASES_TIMELIMITS to BARS_DM;
grant SELECT                                                                 on WCS_PHASES_TIMELIMITS to UPLD;
grant FLASHBACK,SELECT                                                       on WCS_PHASES_TIMELIMITS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PHASES_TIMELIMITS.sql =========***
PROMPT ===================================================================================== 
