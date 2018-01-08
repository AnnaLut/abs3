

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_OUT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRANS_OUT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRANS_OUT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRANS_OUT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TRANS_OUT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRANS_OUT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRANS_OUT 
   (	TRAN_TYPE CHAR(2), 
	TT CHAR(3), 
	DK NUMBER(1,0), 
	W4_MSGCODE VARCHAR2(100), 
	PAY_FLAG NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRANS_OUT ***
 exec bpa.alter_policies('OBPC_TRANS_OUT');


COMMENT ON TABLE BARS.OBPC_TRANS_OUT IS 'Опис транзакцій ПЦ для квитовки операцій Банку';
COMMENT ON COLUMN BARS.OBPC_TRANS_OUT.TRAN_TYPE IS 'Код опер ПЦ';
COMMENT ON COLUMN BARS.OBPC_TRANS_OUT.TT IS 'Код опер АБС';
COMMENT ON COLUMN BARS.OBPC_TRANS_OUT.DK IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_OUT.W4_MSGCODE IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_OUT.PAY_FLAG IS 'Флаг оплаты документов: 1=оплата/сторнирование по файлу-квитанции, 2-сторнирование по файлу-квитанции';




PROMPT *** Create  constraint PK_OBPCTRANSOUT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT PK_OBPCTRANSOUT PRIMARY KEY (TT, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OBPCTRANSOUT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT UK_OBPCTRANSOUT UNIQUE (TRAN_TYPE, TT, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSOUT_W4MSGCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT MODIFY (W4_MSGCODE CONSTRAINT CC_OBPCTRANSOUT_W4MSGCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSOUT_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT MODIFY (DK CONSTRAINT CC_OBPCTRANSOUT_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSOUT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT MODIFY (TT CONSTRAINT CC_OBPCTRANSOUT_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSOUT_TRANTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT MODIFY (TRAN_TYPE CONSTRAINT CC_OBPCTRANSOUT_TRANTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSOUT_OWMSGCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_OWMSGCODE FOREIGN KEY (W4_MSGCODE, DK)
	  REFERENCES BARS.OW_MSGCODE (MSGCODE, DK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSOUT_OBPCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_OBPCTRANS FOREIGN KEY (TRAN_TYPE, DK)
	  REFERENCES BARS.OBPC_TRANS (TRAN_TYPE, DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSOUT_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSOUT_PAYFLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT CC_OBPCTRANSOUT_PAYFLAG CHECK (pay_flag in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSOUT_PAYFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT CC_OBPCTRANSOUT_PAYFLAG_NN CHECK (pay_flag is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSOUT_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_OUT ADD CONSTRAINT FK_OBPCTRANSOUT_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRANSOUT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRANSOUT ON BARS.OBPC_TRANS_OUT (TT, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OBPCTRANSOUT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OBPCTRANSOUT ON BARS.OBPC_TRANS_OUT (TRAN_TYPE, TT, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRANS_OUT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRANS_OUT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TRANS_OUT  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS_OUT  to OBPC;
grant FLASHBACK,SELECT                                                       on OBPC_TRANS_OUT  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_OUT.sql =========*** End **
PROMPT ===================================================================================== 
