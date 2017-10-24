

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_DOC_STATES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_DOC_STATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_DOC_STATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_DOC_STATES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_DOC_STATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_DOC_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_DOC_STATES 
   (	STATE NUMBER(1,0), 
	NAME VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_DOC_STATES ***
 exec bpa.alter_policies('CC_DOC_STATES');


COMMENT ON TABLE BARS.CC_DOC_STATES IS 'Состояния договоров';
COMMENT ON COLUMN BARS.CC_DOC_STATES.STATE IS 'Ид. состояния';
COMMENT ON COLUMN BARS.CC_DOC_STATES.NAME IS 'Наименование состояния';




PROMPT *** Create  constraint PK_CCDOCSTATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOC_STATES ADD CONSTRAINT PK_CCDOCSTATES PRIMARY KEY (STATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDOCSTATES_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOC_STATES MODIFY (STATE CONSTRAINT CC_CCDOCSTATES_STATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDOCSTATES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOC_STATES MODIFY (NAME CONSTRAINT CC_CCDOCSTATES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCDOCSTATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCDOCSTATES ON BARS.CC_DOC_STATES (STATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_DOC_STATES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_DOC_STATES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_DOC_STATES   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_DOC_STATES   to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_DOC_STATES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_DOC_STATES.sql =========*** End ***
PROMPT ===================================================================================== 
