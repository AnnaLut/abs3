

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FREQ.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FREQ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FREQ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FREQ'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FREQ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FREQ ***
begin 
  execute immediate '
  CREATE TABLE BARS.FREQ 
   (	FREQ NUMBER(3,0), 
	NAME VARCHAR2(35), 
	NAME4DOC VARCHAR2(70), 
	ALLOW_TERM NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FREQ ***
 exec bpa.alter_policies('FREQ');


COMMENT ON TABLE BARS.FREQ IS '¬иды периодичности формировани€ выписок';
COMMENT ON COLUMN BARS.FREQ.FREQ IS 'ѕериодичность вс€ких событий (рассылка выписок, списани€ процентов и т.д.)';
COMMENT ON COLUMN BARS.FREQ.NAME IS 'Ќаименование';
COMMENT ON COLUMN BARS.FREQ.NAME4DOC IS 'Ќаименование период-ти дл€ печати в текстах договоров';
COMMENT ON COLUMN BARS.FREQ.ALLOW_TERM IS 'ћин.срок депозита, дл€ которого разрешена период-ть';




PROMPT *** Create  constraint PK_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.FREQ ADD CONSTRAINT PK_FREQ PRIMARY KEY (FREQ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FREQ_FREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FREQ MODIFY (FREQ CONSTRAINT CC_FREQ_FREQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FREQ_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FREQ MODIFY (NAME CONSTRAINT CC_FREQ_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FREQ_ALLOWTERM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FREQ MODIFY (ALLOW_TERM CONSTRAINT CC_FREQ_ALLOWTERM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FREQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FREQ ON BARS.FREQ (FREQ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FREQ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FREQ            to ABS_ADMIN;
grant SELECT                                                                 on FREQ            to BARS010;
grant SELECT                                                                 on FREQ            to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on FREQ            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FREQ            to BARS_DM;
grant SELECT                                                                 on FREQ            to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on FREQ            to FREQ;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on FREQ            to RCC_DEAL;
grant SELECT                                                                 on FREQ            to START1;
grant SELECT                                                                 on FREQ            to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FREQ            to WR_ALL_RIGHTS;
grant SELECT                                                                 on FREQ            to WR_CREDIT;
grant SELECT                                                                 on FREQ            to WR_DEPOSIT_U;
grant FLASHBACK,SELECT                                                       on FREQ            to WR_REFREAD;
grant SELECT                                                                 on FREQ            to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FREQ.sql =========*** End *** ========
PROMPT ===================================================================================== 
