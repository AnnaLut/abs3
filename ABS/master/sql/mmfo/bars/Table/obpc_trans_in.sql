

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_IN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRANS_IN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRANS_IN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRANS_IN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TRANS_IN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRANS_IN ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRANS_IN 
   (	TRAN_TYPE CHAR(2), 
	TT CHAR(3), 
	PAY_FLG NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRANS_IN ***
 exec bpa.alter_policies('OBPC_TRANS_IN');


COMMENT ON TABLE BARS.OBPC_TRANS_IN IS 'Опис транзакцій ПЦ для оплати операцій ПЦ';
COMMENT ON COLUMN BARS.OBPC_TRANS_IN.TRAN_TYPE IS 'Код опер ПЦ';
COMMENT ON COLUMN BARS.OBPC_TRANS_IN.TT IS 'Код опер АБС';
COMMENT ON COLUMN BARS.OBPC_TRANS_IN.PAY_FLG IS 'Флаг оплаты: 1-ч/з 2920, 2-ч/з 6/7класс, 0-простой Д-К';




PROMPT *** Create  constraint PK_OBPCTRANSIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_IN ADD CONSTRAINT PK_OBPCTRANSIN PRIMARY KEY (TRAN_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSIN_PAYFLG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_IN ADD CONSTRAINT CC_OBPCTRANSIN_PAYFLG_NN CHECK (pay_flg is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSIN_TRANTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_IN MODIFY (TRAN_TYPE CONSTRAINT CC_OBPCTRANSIN_TRANTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRANSIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRANSIN ON BARS.OBPC_TRANS_IN (TRAN_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRANS_IN ***
grant SELECT                                                                 on OBPC_TRANS_IN   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRANS_IN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TRANS_IN   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS_IN   to OBPC;
grant SELECT                                                                 on OBPC_TRANS_IN   to UPLD;
grant FLASHBACK,SELECT                                                       on OBPC_TRANS_IN   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_IN.sql =========*** End ***
PROMPT ===================================================================================== 
