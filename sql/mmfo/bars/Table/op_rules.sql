

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OP_RULES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OP_RULES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OP_RULES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OP_RULES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OP_RULES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OP_RULES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OP_RULES 
   (	TT CHAR(3), 
	TAG CHAR(5), 
	OPT CHAR(1), 
	USED4INPUT NUMBER(1,0), 
	ORD NUMBER(5,0), 
	VAL VARCHAR2(100), 
	NOMODIFY NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OP_RULES ***
 exec bpa.alter_policies('OP_RULES');


COMMENT ON TABLE BARS.OP_RULES IS 'Шаблоны операций';
COMMENT ON COLUMN BARS.OP_RULES.TT IS 'Тип транзакции';
COMMENT ON COLUMN BARS.OP_RULES.TAG IS 'Код поля';
COMMENT ON COLUMN BARS.OP_RULES.OPT IS 'Признак обязательности ( M - mandatory, O - optional )';
COMMENT ON COLUMN BARS.OP_RULES.USED4INPUT IS 'Флаг использования для ввода';
COMMENT ON COLUMN BARS.OP_RULES.ORD IS 'Порядок следования';
COMMENT ON COLUMN BARS.OP_RULES.VAL IS '';
COMMENT ON COLUMN BARS.OP_RULES.NOMODIFY IS '1 - Признак нередактируемости';




PROMPT *** Create  constraint PK_OPRULES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES ADD CONSTRAINT PK_OPRULES PRIMARY KEY (TT, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPRULES_OPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES ADD CONSTRAINT CC_OPRULES_OPT CHECK (OPT IN (''O'', ''M'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPRULES_USE4INP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES MODIFY (USED4INPUT CONSTRAINT CC_OPRULES_USE4INP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPRULES_OPT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES MODIFY (OPT CONSTRAINT CC_OPRULES_OPT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPRULES_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES MODIFY (TAG CONSTRAINT CC_OPRULES_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPRULES_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES MODIFY (TT CONSTRAINT CC_OPRULES_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPRULES_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES ADD CONSTRAINT FK_OPRULES_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPRULES_OPFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES ADD CONSTRAINT FK_OPRULES_OPFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPRULES_USE4INP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_RULES ADD CONSTRAINT CC_OPRULES_USE4INP CHECK (USED4INPUT IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPRULES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPRULES ON BARS.OP_RULES (TAG, TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OP_RULES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OP_RULES        to ABS_ADMIN;
grant SELECT                                                                 on OP_RULES        to BARSAQ with grant option;
grant SELECT                                                                 on OP_RULES        to BARSAQ_ADM with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP_RULES        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OP_RULES        to BARS_DM;
grant SELECT                                                                 on OP_RULES        to DPT_ADMIN;
grant SELECT                                                                 on OP_RULES        to DPT_ROLE;
grant SELECT                                                                 on OP_RULES        to KLBX;
grant DELETE,INSERT,SELECT,UPDATE                                            on OP_RULES        to OP_RULES;
grant SELECT                                                                 on OP_RULES        to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on OP_RULES        to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP_RULES        to WR_ALL_RIGHTS;
grant SELECT                                                                 on OP_RULES        to WR_DEPOSIT_U;
grant SELECT                                                                 on OP_RULES        to WR_DOC_INPUT;
grant SELECT                                                                 on OP_RULES        to WR_KP;
grant FLASHBACK,SELECT                                                       on OP_RULES        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OP_RULES.sql =========*** End *** ====
PROMPT ===================================================================================== 
