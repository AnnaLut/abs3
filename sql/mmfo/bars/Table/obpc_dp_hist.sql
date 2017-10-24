

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_DP_HIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_DP_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_DP_HIST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_DP_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_DP_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_DP_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_DP_HIST 
   (	ID NUMBER(38,0), 
	NUM_CONV NUMBER(38,0), 
	S_INT_D NUMBER(38,2), 
	S_INT_SS NUMBER(38,2), 
	S_INT_CR NUMBER(38,2), 
	SOS NUMBER(38,0), 
	INS_DATE DATE DEFAULT sysdate, 
	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_DP_HIST ***
 exec bpa.alter_policies('OBPC_DP_HIST');


COMMENT ON TABLE BARS.OBPC_DP_HIST IS 'Архив справочника начисления депозитов (DP*.TXT)';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.ID IS 'Код';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.NUM_CONV IS '№ конверта';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.S_INT_D IS 'Сумма % на депозит';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.S_INT_SS IS 'Сумма % на ссуду';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.S_INT_CR IS 'Сумма % на кредит';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.SOS IS 'Состояние';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.INS_DATE IS 'Дата архивации';
COMMENT ON COLUMN BARS.OBPC_DP_HIST.REF IS 'Референс';




PROMPT *** Create  constraint PK_OBPCDPHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_DP_HIST ADD CONSTRAINT PK_OBPCDPHIST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCDPHIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_DP_HIST MODIFY (ID CONSTRAINT CC_OBPCDPHIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCDPHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCDPHIST ON BARS.OBPC_DP_HIST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_DP_HIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_DP_HIST    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_DP_HIST    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_DP_HIST    to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_DP_HIST    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_DP_HIST.sql =========*** End *** 
PROMPT ===================================================================================== 
