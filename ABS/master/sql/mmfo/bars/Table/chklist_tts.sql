

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHKLIST_TTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHKLIST_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CHKLIST_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CHKLIST_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CHKLIST_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHKLIST_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHKLIST_TTS 
   (	TT CHAR(3), 
	IDCHK NUMBER(38,0), 
	PRIORITY NUMBER(5,0), 
	F_BIG_AMOUNT NUMBER(1,0), 
	SQLVAL VARCHAR2(2048), 
	F_IN_CHARGE NUMBER(38,0), 
	FLAGS NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CHKLIST_TTS ***
 exec bpa.alter_policies('CHKLIST_TTS');


COMMENT ON TABLE BARS.CHKLIST_TTS IS 'Связи операций и групп визирования';
COMMENT ON COLUMN BARS.CHKLIST_TTS.TT IS 'код оп';
COMMENT ON COLUMN BARS.CHKLIST_TTS.IDCHK IS 'код группы виз';
COMMENT ON COLUMN BARS.CHKLIST_TTS.PRIORITY IS 'приоритет';
COMMENT ON COLUMN BARS.CHKLIST_TTS.F_BIG_AMOUNT IS 'признак БОЛ сум';
COMMENT ON COLUMN BARS.CHKLIST_TTS.SQLVAL IS 'условие обязательности визы, NULL - обязательность визы';
COMMENT ON COLUMN BARS.CHKLIST_TTS.F_IN_CHARGE IS 'Вид ЭЦП на визе: 0-Отсут, 1-Внутр, 2-СЭП, 3-Внутр+СЭП';
COMMENT ON COLUMN BARS.CHKLIST_TTS.FLAGS IS 'флаги';




PROMPT *** Create  constraint PK_CHKLISTTTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT PK_CHKLISTTTS PRIMARY KEY (TT, IDCHK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKLISTTTS_FBIGAMOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT CC_CHKLISTTTS_FBIGAMOUNT CHECK (f_big_amount in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKLISTTTS_PRIORITY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS MODIFY (PRIORITY CONSTRAINT CC_CHKLISTTTS_PRIORITY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKLISTTTS_IDCHK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS MODIFY (IDCHK CONSTRAINT CC_CHKLISTTTS_IDCHK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKLISTTTS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS MODIFY (TT CONSTRAINT CC_CHKLISTTTS_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CHKLISTTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT FK_CHKLISTTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CHKLISTTTS_INCHARGELIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT FK_CHKLISTTTS_INCHARGELIST FOREIGN KEY (F_IN_CHARGE)
	  REFERENCES BARS.IN_CHARGE_LIST (IN_CHARGE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CHKLISTTTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT UK_CHKLISTTTS UNIQUE (TT, PRIORITY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CHKLISTTTS_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT FK_CHKLISTTTS_CHKLIST FOREIGN KEY (IDCHK)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CHKLISTTTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CHKLISTTTS ON BARS.CHKLIST_TTS (TT, IDCHK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CHKLISTTTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CHKLISTTTS ON BARS.CHKLIST_TTS (TT, PRIORITY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHKLIST_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CHKLIST_TTS     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CHKLIST_TTS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHKLIST_TTS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CHKLIST_TTS     to CHKLIST_TTS;
grant SELECT                                                                 on CHKLIST_TTS     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on CHKLIST_TTS     to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CHKLIST_TTS     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CHKLIST_TTS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHKLIST_TTS.sql =========*** End *** =
PROMPT ===================================================================================== 
