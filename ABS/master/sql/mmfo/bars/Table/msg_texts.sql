

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MSG_TEXTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MSG_TEXTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MSG_TEXTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MSG_TEXTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MSG_TEXTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MSG_TEXTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MSG_TEXTS 
   (	MSG_ID NUMBER(38,0), 
	LNG_CODE VARCHAR2(3), 
	MSG_TEXT VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MSG_TEXTS ***
 exec bpa.alter_policies('MSG_TEXTS');


COMMENT ON TABLE BARS.MSG_TEXTS IS 'Справочник текстов сообщений';
COMMENT ON COLUMN BARS.MSG_TEXTS.MSG_ID IS 'Идентификатор сообщения';
COMMENT ON COLUMN BARS.MSG_TEXTS.LNG_CODE IS 'Код языка';
COMMENT ON COLUMN BARS.MSG_TEXTS.MSG_TEXT IS 'Текст сообщения';




PROMPT *** Create  constraint PK_MSGTEXTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS ADD CONSTRAINT PK_MSGTEXTS PRIMARY KEY (MSG_ID, LNG_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MSGTEXTS_MSGCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS ADD CONSTRAINT FK_MSGTEXTS_MSGCODES FOREIGN KEY (MSG_ID)
	  REFERENCES BARS.MSG_CODES (MSG_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MSGTEXTS_ERRLANGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS ADD CONSTRAINT FK_MSGTEXTS_ERRLANGS FOREIGN KEY (LNG_CODE)
	  REFERENCES BARS.ERR_LANGS (ERRLNG_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGTEXTS_MSGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS MODIFY (MSG_ID CONSTRAINT CC_MSGTEXTS_MSGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGTEXTS_LNGCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS MODIFY (LNG_CODE CONSTRAINT CC_MSGTEXTS_LNGCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGTEXTS_MSGTEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS MODIFY (MSG_TEXT CONSTRAINT CC_MSGTEXTS_MSGTEXT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MSGTEXTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MSGTEXTS ON BARS.MSG_TEXTS (MSG_ID, LNG_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MSG_TEXTS ***
grant SELECT                                                                 on MSG_TEXTS       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MSG_TEXTS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MSG_TEXTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
