

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_MSGCODE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_MSGCODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_MSGCODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_MSGCODE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_MSGCODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_MSGCODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_MSGCODE 
   (	MSGCODE VARCHAR2(100), 
	DK NUMBER(1,0), 
	SYNTHCODE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_MSGCODE ***
 exec bpa.alter_policies('OW_MSGCODE');


COMMENT ON TABLE BARS.OW_MSGCODE IS 'OpenWay. Коды проводок для квитовки документов';
COMMENT ON COLUMN BARS.OW_MSGCODE.MSGCODE IS 'Код проводки';
COMMENT ON COLUMN BARS.OW_MSGCODE.DK IS 'Д/К';
COMMENT ON COLUMN BARS.OW_MSGCODE.SYNTHCODE IS 'Синтетический код проводки';




PROMPT *** Create  constraint CC_OWMSGCODE_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MSGCODE ADD CONSTRAINT CC_OWMSGCODE_DK_NN CHECK (dk is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWMSGCODE_SYNTHCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MSGCODE ADD CONSTRAINT CC_OWMSGCODE_SYNTHCODE_NN CHECK (synthcode is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_OWMSGCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MSGCODE ADD CONSTRAINT UK2_OWMSGCODE UNIQUE (SYNTHCODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWMSGCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MSGCODE ADD CONSTRAINT PK_OWMSGCODE PRIMARY KEY (MSGCODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OWMSGCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MSGCODE ADD CONSTRAINT UK_OWMSGCODE UNIQUE (MSGCODE, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWMSGCODE_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MSGCODE ADD CONSTRAINT CC_OWMSGCODE_DK CHECK (dk in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OWMSGCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OWMSGCODE ON BARS.OW_MSGCODE (MSGCODE, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_OWMSGCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_OWMSGCODE ON BARS.OW_MSGCODE (SYNTHCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWMSGCODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWMSGCODE ON BARS.OW_MSGCODE (MSGCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_MSGCODE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_MSGCODE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_MSGCODE      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_MSGCODE      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_MSGCODE.sql =========*** End *** ==
PROMPT ===================================================================================== 
