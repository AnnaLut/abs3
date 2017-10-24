

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TOP_CONTRACTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TOP_CONTRACTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TOP_CONTRACTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TOP_CONTRACTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TOP_CONTRACTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TOP_CONTRACTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TOP_CONTRACTS 
   (	PID NUMBER, 
	IMPEXP NUMBER, 
	RNK NUMBER, 
	NAME VARCHAR2(50), 
	DATEOPEN DATE, 
	DATECLOSE DATE, 
	S NUMBER, 
	KV NUMBER, 
	BENEFCOUNTRY NUMBER, 
	BENEFNAME VARCHAR2(50), 
	BENEFBANK VARCHAR2(50), 
	BENEFACC VARCHAR2(50), 
	AIM VARCHAR2(100), 
	COND VARCHAR2(100), 
	ID_OPER NUMBER DEFAULT 1, 
	CONTINUED VARCHAR2(80), 
	DETAILS VARCHAR2(250), 
	DAT DATE, 
	CLOSED NUMBER DEFAULT 0, 
	OE CHAR(2), 
	BENEFADR VARCHAR2(50), 
	BENEFBIC CHAR(11), 
	CONTROL_DAYS NUMBER DEFAULT 180, 
	BANK_CODE VARCHAR2(10), 
	BANKCOUNTRY NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TOP_CONTRACTS ***
 exec bpa.alter_policies('TOP_CONTRACTS');


COMMENT ON TABLE BARS.TOP_CONTRACTS IS 'Экспортно-Импортные контракты';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.PID IS 'Реф.контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.IMPEXP IS '0 - Экспорт 1 - Импорт';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.RNK IS 'РНК клиента';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.NAME IS '№ контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.DATEOPEN IS 'Дата заключения';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.DATECLOSE IS 'Дата закрытия';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.S IS 'Сумма контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.KV IS 'Валюта контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BENEFCOUNTRY IS 'Код страны клиента-нерезид.';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BENEFNAME IS 'Наименование клиента-нерезид.';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BENEFBANK IS 'Банк клиента-нерезид.';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BENEFACC IS 'Счет клиента-нерезид.';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.AIM IS 'Предмет контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.COND IS 'Условия  контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.ID_OPER IS '1 - поставка товара 2 - Оказание услуг';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.CONTINUED IS 'Лицензия на продление контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.DETAILS IS 'Подробности';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.DAT IS 'Дата регистрации контракта';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.CLOSED IS 'Признак урегулир.';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.OE IS 'Вид эк.деятельности KL_K113';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BENEFADR IS 'Адрес нерезидента';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BENEFBIC IS 'BIC-код банка нерезидента';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.CONTROL_DAYS IS 'Кол-во дней контроля';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BANK_CODE IS 'Код банка нерезидента';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BANKCOUNTRY IS 'Код страны иностранного банка';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.KF IS '';
COMMENT ON COLUMN BARS.TOP_CONTRACTS.BRANCH IS '';




PROMPT *** Create  constraint FK_TOPCONTRACTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TOPCONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT PK_TOPCONTRACTS PRIMARY KEY (PID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_IMPEXP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT CC_TOPCONTRACTS_IMPEXP CHECK (impexp   IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_IDOPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT CC_TOPCONTRACTS_IDOPER CHECK (id_oper  IN (1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT CC_TOPCONTRACTS_DATES CHECK (dateopen <= dateclose OR dateclose IS NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_CLOSED ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT CC_TOPCONTRACTS_CLOSED CHECK (closed   IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (BRANCH CONSTRAINT CC_TOPCONTRACTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (KF CONSTRAINT CC_TOPCONTRACTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_CONTROLDAYS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (CONTROL_DAYS CONSTRAINT CC_TOPCONTRACTS_CONTROLDAYS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_CLOSED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (CLOSED CONSTRAINT CC_TOPCONTRACTS_CLOSED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_IDOPER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (ID_OPER CONSTRAINT CC_TOPCONTRACTS_IDOPER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_COUNTRY FOREIGN KEY (BENEFCOUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_COUNTRY2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_COUNTRY2 FOREIGN KEY (BANKCOUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (PID CONSTRAINT CC_TOPCONTRACTS_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_IMPEXP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (IMPEXP CONSTRAINT CC_TOPCONTRACTS_IMPEXP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (RNK CONSTRAINT CC_TOPCONTRACTS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (NAME CONSTRAINT CC_TOPCONTRACTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_DATEOPEN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (DATEOPEN CONSTRAINT CC_TOPCONTRACTS_DATEOPEN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOPCONTRACTS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS MODIFY (KV CONSTRAINT CC_TOPCONTRACTS_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_TOPCONTRACTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TOPCONTRACTS ON BARS.TOP_CONTRACTS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TOPCONTRACTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TOPCONTRACTS ON BARS.TOP_CONTRACTS (PID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TOP_CONTRACTS ***
grant REFERENCES,SELECT                                                      on TOP_CONTRACTS   to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on TOP_CONTRACTS   to BARSAQ_ADM with grant option;
grant SELECT                                                                 on TOP_CONTRACTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TOP_CONTRACTS   to BARS_DM;
grant SELECT                                                                 on TOP_CONTRACTS   to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TOP_CONTRACTS   to WR_ALL_RIGHTS;
grant SELECT                                                                 on TOP_CONTRACTS   to ZAY;



PROMPT *** Create SYNONYM  to TOP_CONTRACTS ***

  CREATE OR REPLACE PUBLIC SYNONYM TOP_CONTRACTS FOR BARS.TOP_CONTRACTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TOP_CONTRACTS.sql =========*** End ***
PROMPT ===================================================================================== 
