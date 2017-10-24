

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR_TEXTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR_TEXTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ERR_TEXTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ERR_TEXTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ERR_TEXTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR_TEXTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR_TEXTS 
   (	ERRMOD_CODE VARCHAR2(3), 
	ERR_CODE NUMBER(5,0), 
	ERRLNG_CODE VARCHAR2(3), 
	ERR_MSG VARCHAR2(250), 
	ERR_HLP VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR_TEXTS ***
 exec bpa.alter_policies('ERR_TEXTS');


COMMENT ON TABLE BARS.ERR_TEXTS IS 'Текст ошибки';
COMMENT ON COLUMN BARS.ERR_TEXTS.ERRMOD_CODE IS 'Модуль ошибки';
COMMENT ON COLUMN BARS.ERR_TEXTS.ERR_CODE IS 'Код ошибки';
COMMENT ON COLUMN BARS.ERR_TEXTS.ERRLNG_CODE IS 'Язык отображения ошибки';
COMMENT ON COLUMN BARS.ERR_TEXTS.ERR_MSG IS 'Сообщение про ошибку';
COMMENT ON COLUMN BARS.ERR_TEXTS.ERR_HLP IS 'Доп. сообщение к кому обращаться';




PROMPT *** Create  constraint PK_ERRTEXTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS ADD CONSTRAINT PK_ERRTEXTS PRIMARY KEY (ERRMOD_CODE, ERR_CODE, ERRLNG_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ERRTEXTS_ERRLANGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS ADD CONSTRAINT FK_ERRTEXTS_ERRLANGS FOREIGN KEY (ERRLNG_CODE)
	  REFERENCES BARS.ERR_LANGS (ERRLNG_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ERRTEXTS_ERRCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS ADD CONSTRAINT FK_ERRTEXTS_ERRCODES FOREIGN KEY (ERRMOD_CODE, ERR_CODE)
	  REFERENCES BARS.ERR_CODES (ERRMOD_CODE, ERR_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRTEXTS_ERRMODCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS MODIFY (ERRMOD_CODE CONSTRAINT CC_ERRTEXTS_ERRMODCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRTEXTS_ERRCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS MODIFY (ERR_CODE CONSTRAINT CC_ERRTEXTS_ERRCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRTEXTS_ERRLNGCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS MODIFY (ERRLNG_CODE CONSTRAINT CC_ERRTEXTS_ERRLNGCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRTEXTS_ERRMSG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS MODIFY (ERR_MSG CONSTRAINT CC_ERRTEXTS_ERRMSG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ERRTEXTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ERRTEXTS ON BARS.ERR_TEXTS (ERRMOD_CODE, ERR_CODE, ERRLNG_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ERR_TEXTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR_TEXTS       to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ERR_TEXTS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR_TEXTS       to BARS_DM;
grant SELECT                                                                 on ERR_TEXTS       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ERR_TEXTS       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ERR_TEXTS       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR_TEXTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
