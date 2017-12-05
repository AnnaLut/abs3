

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_CREDIT_DEAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_CREDIT_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_CREDIT_DEAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_CREDIT_DEAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_CREDIT_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_CREDIT_DEAL 
   (	CARD_ND NUMBER(24,0), 
	DEAL_ND NUMBER(24,0), 
	DEAL_SUM NUMBER(24,0), 
	DEAL_KV NUMBER(3,0), 
	DEAL_RNK NUMBER(24,0), 
	OPEN_DT DATE, 
	MATUR_DT DATE, 
	CLOSE_DT DATE, 
	ACC_9129 NUMBER(24,0), 
	ACC_OVR NUMBER(24,0), 
	ACC_2208 NUMBER(24,0), 
	ACC_2207 NUMBER(24,0), 
	ACC_2209 NUMBER(24,0), 
	PC_TYPE VARCHAR2(3), 
	CREATE_DT DATE DEFAULT sysdate,
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL add ( KF varchar2(6) )';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (KF CONSTRAINT CC_BPKCREDITDEAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** ALTER_POLICIES to BPK_CREDIT_DEAL ***
 exec bpa.alter_policies('BPK_CREDIT_DEAL');


COMMENT ON TABLE BARS.BPK_CREDIT_DEAL IS 'Договора кредитних лімітів під БПК';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.CARD_ND IS 'Номер договору БПК';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.DEAL_ND IS 'Номер договору кредитного ліміту';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.DEAL_SUM IS 'Сума договору';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.DEAL_KV IS 'Валюта договору';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.DEAL_RNK IS 'РНК';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.OPEN_DT IS 'Дата відкриття договору';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.MATUR_DT IS 'Дата погашення (первинна)';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.CLOSE_DT IS 'Дата закриття договору';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.ACC_9129 IS 'Ід. рах. НЕвикористаного кредитного ліміту';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.ACC_OVR IS 'Ід. рах. використаного кредитного ліміту';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.ACC_2208 IS 'Ід. рах. нарахованих відсотків';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.ACC_2207 IS 'Ід. рах. простроченого боргу';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.ACC_2209 IS 'Ід. рах. прострочених відсотків';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.PC_TYPE IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL.CREATE_DT IS 'Дата створення запису';




PROMPT *** Create  constraint UK_BPKCREDITDEAL_CARDND ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL ADD CONSTRAINT UK_BPKCREDITDEAL_CARDND UNIQUE (CARD_ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPKCREDITDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL ADD CONSTRAINT PK_BPKCREDITDEAL PRIMARY KEY (DEAL_ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCREDITDEAL_CREATEDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (CREATE_DT CONSTRAINT CC_BPKCREDITDEAL_CREATEDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCREDITDEAL_OPENDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (OPEN_DT CONSTRAINT CC_BPKCREDITDEAL_OPENDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCREDITDEAL_DEALRNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (DEAL_RNK CONSTRAINT CC_BPKCREDITDEAL_DEALRNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCREDITDEAL_DEALKV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (DEAL_KV CONSTRAINT CC_BPKCREDITDEAL_DEALKV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCREDITDEAL_DEALSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (DEAL_SUM CONSTRAINT CC_BPKCREDITDEAL_DEALSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCREDITDEAL_DEALND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (DEAL_ND CONSTRAINT CC_BPKCREDITDEAL_DEALND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCREDITDEAL_CARDND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL MODIFY (CARD_ND CONSTRAINT CC_BPKCREDITDEAL_CARDND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKCREDITDEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKCREDITDEAL ON BARS.BPK_CREDIT_DEAL (DEAL_ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_BPKCREDITDEAL_CARDND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_BPKCREDITDEAL_CARDND ON BARS.BPK_CREDIT_DEAL (CARD_ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_CREDIT_DEAL ***
grant SELECT                                                                 on BPK_CREDIT_DEAL to BARSUPL;
grant SELECT                                                                 on BPK_CREDIT_DEAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_CREDIT_DEAL.sql =========*** End *
PROMPT ===================================================================================== 
