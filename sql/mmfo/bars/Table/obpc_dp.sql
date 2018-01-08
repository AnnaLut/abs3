

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_DP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_DP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_DP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_DP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_DP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_DP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_DP 
   (	ID NUMBER(38,0), 
	NUM_CONV NUMBER(38,0), 
	S_INT_D NUMBER(38,2), 
	S_INT_SS NUMBER(38,2), 
	S_INT_CR NUMBER(38,2), 
	SOS NUMBER(38,0) DEFAULT 0, 
	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_DP ***
 exec bpa.alter_policies('OBPC_DP');


COMMENT ON TABLE BARS.OBPC_DP IS 'ЛЗ: АКТИВНЫЙ справочник начисления депозитов (DP*.TXT)';
COMMENT ON COLUMN BARS.OBPC_DP.ID IS 'Код';
COMMENT ON COLUMN BARS.OBPC_DP.NUM_CONV IS '№ конверта';
COMMENT ON COLUMN BARS.OBPC_DP.S_INT_D IS 'Сумма % на депозит';
COMMENT ON COLUMN BARS.OBPC_DP.S_INT_SS IS 'Сумма % на ссуду';
COMMENT ON COLUMN BARS.OBPC_DP.S_INT_CR IS 'Сумма % на кредит';
COMMENT ON COLUMN BARS.OBPC_DP.SOS IS 'Состояние';
COMMENT ON COLUMN BARS.OBPC_DP.REF IS 'Референс';




PROMPT *** Create  constraint PK_OBPCDP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_DP ADD CONSTRAINT PK_OBPCDP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OBPCDP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_DP ADD CONSTRAINT UK_OBPCDP UNIQUE (NUM_CONV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCDP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_DP MODIFY (ID CONSTRAINT CC_OBPCDP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCDP_NUMCONV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_DP MODIFY (NUM_CONV CONSTRAINT CC_OBPCDP_NUMCONV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCDP_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_DP MODIFY (SOS CONSTRAINT CC_OBPCDP_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OBPCDP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OBPCDP ON BARS.OBPC_DP (NUM_CONV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCDP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCDP ON BARS.OBPC_DP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_DP ***
grant SELECT                                                                 on OBPC_DP         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_DP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_DP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_DP         to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_DP         to OBPC_DP;
grant SELECT                                                                 on OBPC_DP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_DP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_DP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_DP.sql =========*** End *** =====
PROMPT ===================================================================================== 
