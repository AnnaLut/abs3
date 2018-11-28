

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_CRT_LOG_STATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_CRT_LOG_STATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_CRT_LOG_STATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CRT_LOG_STATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CRT_LOG_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_CRT_LOG_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_CRT_LOG_STATE 
   (    ID NUMBER(2,0), 
    NAME VARCHAR2(256), 
    STATE VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_CRT_LOG_STATE ***
 exec bpa.alter_policies('EDS_CRT_LOG_STATE');


COMMENT ON TABLE BARS.EDS_CRT_LOG_STATE IS 'Статуси запитів на формування у-декларацій';
COMMENT ON COLUMN BARS.EDS_CRT_LOG_STATE.ID IS 'Ід статусу';
COMMENT ON COLUMN BARS.EDS_CRT_LOG_STATE.NAME IS 'Імя статусу';
COMMENT ON COLUMN BARS.EDS_CRT_LOG_STATE.STATE IS 'Статус';




PROMPT *** Create  constraint CC_EDS_CRT_LOG_STATE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_CRT_LOG_STATE MODIFY (ID CONSTRAINT CC_EDS_CRT_LOG_STATE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EDS_CRT_LOG_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_CRT_LOG_STATE ON BARS.EDS_CRT_LOG_STATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint PK_EDS_CRT_LOG_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_CRT_LOG_STATE ADD CONSTRAINT PK_EDS_CRT_LOG_STATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_CRT_LOG_STATE.sql =========*** End
PROMPT ===================================================================================== 

