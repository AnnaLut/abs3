

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MSG_CODES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MSG_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MSG_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MSG_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MSG_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MSG_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.MSG_CODES 
   (	MSG_ID NUMBER(38,0), 
	MOD_CODE VARCHAR2(3), 
	MSG_CODE VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MSG_CODES ***
 exec bpa.alter_policies('MSG_CODES');


COMMENT ON TABLE BARS.MSG_CODES IS 'Справочник кодов сообщений';
COMMENT ON COLUMN BARS.MSG_CODES.MSG_ID IS 'Идентификатор сообщения';
COMMENT ON COLUMN BARS.MSG_CODES.MOD_CODE IS 'Код модуля';
COMMENT ON COLUMN BARS.MSG_CODES.MSG_CODE IS 'Код сообщения';




PROMPT *** Create  constraint PK_MSGCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_CODES ADD CONSTRAINT PK_MSGCODES PRIMARY KEY (MSG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_MSGCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_CODES ADD CONSTRAINT UK_MSGCODES UNIQUE (MOD_CODE, MSG_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MSGCODES_ERRMODULES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_CODES ADD CONSTRAINT FK_MSGCODES_ERRMODULES FOREIGN KEY (MOD_CODE)
	  REFERENCES BARS.ERR_MODULES (ERRMOD_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGCODES_MSGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_CODES MODIFY (MSG_ID CONSTRAINT CC_MSGCODES_MSGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGCODES_MODCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_CODES MODIFY (MOD_CODE CONSTRAINT CC_MSGCODES_MODCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGCODES_MSGCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_CODES MODIFY (MSG_CODE CONSTRAINT CC_MSGCODES_MSGCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_MSGCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_MSGCODES ON BARS.MSG_CODES (MOD_CODE, MSG_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MSGCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MSGCODES ON BARS.MSG_CODES (MSG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MSG_CODES ***
grant SELECT                                                                 on MSG_CODES       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MSG_CODES       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MSG_CODES.sql =========*** End *** ===
PROMPT ===================================================================================== 
