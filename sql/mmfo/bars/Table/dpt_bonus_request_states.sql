

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_REQUEST_STATES.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BONUS_REQUEST_STATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BONUS_REQUEST_STATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_BONUS_REQUEST_STATES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_BONUS_REQUEST_STATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BONUS_REQUEST_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BONUS_REQUEST_STATES 
   (	STATE_CODE VARCHAR2(5), 
	STATE_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BONUS_REQUEST_STATES ***
 exec bpa.alter_policies('DPT_BONUS_REQUEST_STATES');


COMMENT ON TABLE BARS.DPT_BONUS_REQUEST_STATES IS 'Статусы запросов на получение льгот по деп.договорам ФЛ';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUEST_STATES.STATE_CODE IS 'Код статуса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUEST_STATES.STATE_NAME IS 'Наименование статуса';




PROMPT *** Create  constraint PK_DPTBONUSREQSTATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUEST_STATES ADD CONSTRAINT PK_DPTBONUSREQSTATES PRIMARY KEY (STATE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQSTATES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUEST_STATES MODIFY (STATE_CODE CONSTRAINT CC_DPTBONUSREQSTATES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQSTATES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUEST_STATES MODIFY (STATE_NAME CONSTRAINT CC_DPTBONUSREQSTATES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTBONUSREQSTATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTBONUSREQSTATES ON BARS.DPT_BONUS_REQUEST_STATES (STATE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_BONUS_REQUEST_STATES ***
grant SELECT                                                                 on DPT_BONUS_REQUEST_STATES to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_BONUS_REQUEST_STATES to BARS_DM;
grant SELECT                                                                 on DPT_BONUS_REQUEST_STATES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_BONUS_REQUEST_STATES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_REQUEST_STATES.sql =========
PROMPT ===================================================================================== 
