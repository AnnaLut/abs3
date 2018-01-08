

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_OPERSTATUS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_OPERSTATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_OPERSTATUS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CM_OPERSTATUS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CM_OPERSTATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_OPERSTATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_OPERSTATUS 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_OPERSTATUS ***
 exec bpa.alter_policies('CM_OPERSTATUS');


COMMENT ON TABLE BARS.CM_OPERSTATUS IS 'OpenWay. Статусы операций';
COMMENT ON COLUMN BARS.CM_OPERSTATUS.ID IS 'Статус операции';
COMMENT ON COLUMN BARS.CM_OPERSTATUS.NAME IS 'Наименование статуса операции';




PROMPT *** Create  constraint CC_CMOPERSTATUS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_OPERSTATUS ADD CONSTRAINT CC_CMOPERSTATUS_NAME_NN CHECK (name is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CMOPERSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_OPERSTATUS ADD CONSTRAINT PK_CMOPERSTATUS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMOPERSTATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMOPERSTATUS ON BARS.CM_OPERSTATUS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_OPERSTATUS ***
grant SELECT                                                                 on CM_OPERSTATUS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_OPERSTATUS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_OPERSTATUS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_OPERSTATUS   to OW;
grant SELECT                                                                 on CM_OPERSTATUS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_OPERSTATUS.sql =========*** End ***
PROMPT ===================================================================================== 
