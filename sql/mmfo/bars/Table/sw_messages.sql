

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MESSAGES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MESSAGES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MESSAGES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_MESSAGES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_MESSAGES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MESSAGES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MESSAGES 
   (	SWREF NUMBER(38,0), 
	BODY CLOB, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (BODY) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MESSAGES ***
 exec bpa.alter_policies('SW_MESSAGES');


COMMENT ON TABLE BARS.SW_MESSAGES IS 'SWT. Исходные сообщения';
COMMENT ON COLUMN BARS.SW_MESSAGES.SWREF IS 'Референс сообщения';
COMMENT ON COLUMN BARS.SW_MESSAGES.BODY IS 'Текст сообщения';
COMMENT ON COLUMN BARS.SW_MESSAGES.KF IS '';




PROMPT *** Create  constraint PK_SWMESSAGES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MESSAGES ADD CONSTRAINT PK_SWMESSAGES PRIMARY KEY (SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMESSAGES_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MESSAGES MODIFY (SWREF CONSTRAINT CC_SWMESSAGES_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMESSAGES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MESSAGES MODIFY (KF CONSTRAINT CC_SWMESSAGES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMESSAGES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMESSAGES ON BARS.SW_MESSAGES (SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MESSAGES ***
grant SELECT                                                                 on SW_MESSAGES     to BARS013;
grant SELECT                                                                 on SW_MESSAGES     to BARSREADER_ROLE;
grant SELECT                                                                 on SW_MESSAGES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_MESSAGES     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_MESSAGES     to SWTOSS;
grant SELECT                                                                 on SW_MESSAGES     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MESSAGES     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_MESSAGES ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_MESSAGES FOR BARS.SW_MESSAGES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MESSAGES.sql =========*** End *** =
PROMPT ===================================================================================== 
