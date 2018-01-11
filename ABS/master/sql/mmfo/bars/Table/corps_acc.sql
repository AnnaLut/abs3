

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CORPS_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CORPS_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CORPS_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CORPS_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CORPS_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CORPS_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CORPS_ACC 
   (	ID NUMBER(38,0), 
	RNK NUMBER(38,0), 
	MFO VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	COMMENTS VARCHAR2(100), 
	SW56_NAME VARCHAR2(100), 
	SW56_ADR VARCHAR2(50), 
	SW56_CODE VARCHAR2(11), 
	SW57_NAME VARCHAR2(100), 
	SW57_ADR VARCHAR2(50), 
	SW57_CODE VARCHAR2(11), 
	SW57_ACC VARCHAR2(20), 
	SW59_NAME VARCHAR2(100), 
	SW59_ADR VARCHAR2(50), 
	SW59_ACC VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CORPS_ACC ***
 exec bpa.alter_policies('CORPS_ACC');


COMMENT ON TABLE BARS.CORPS_ACC IS 'Текушие счета клиентов';
COMMENT ON COLUMN BARS.CORPS_ACC.ID IS 'Идентификатор текущего счета';
COMMENT ON COLUMN BARS.CORPS_ACC.RNK IS 'Идентификатор клиента, которому принадлежит счет';
COMMENT ON COLUMN BARS.CORPS_ACC.MFO IS 'Код банка, в котором открыт текущий счет';
COMMENT ON COLUMN BARS.CORPS_ACC.NLS IS 'Лицевой № текущего счета';
COMMENT ON COLUMN BARS.CORPS_ACC.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.CORPS_ACC.COMMENTS IS 'Описание счета (комментарий)';
COMMENT ON COLUMN BARS.CORPS_ACC.SW56_NAME IS 'Назва банку-посередника';
COMMENT ON COLUMN BARS.CORPS_ACC.SW56_ADR IS 'Адреса банку-посередника';
COMMENT ON COLUMN BARS.CORPS_ACC.SW56_CODE IS 'SWIFT-код банку-посередника';
COMMENT ON COLUMN BARS.CORPS_ACC.SW57_NAME IS 'Назва банку-бенефіціара';
COMMENT ON COLUMN BARS.CORPS_ACC.SW57_ADR IS 'Адреса банку-бенефіціара';
COMMENT ON COLUMN BARS.CORPS_ACC.SW57_CODE IS 'SWIFT-код банку-бенефіціара';
COMMENT ON COLUMN BARS.CORPS_ACC.SW57_ACC IS 'Рахунок банку-бенефіціара у банку-посереднику';
COMMENT ON COLUMN BARS.CORPS_ACC.SW59_NAME IS 'Найменування бенефіціара';
COMMENT ON COLUMN BARS.CORPS_ACC.SW59_ADR IS 'Адреса бенефіціара';
COMMENT ON COLUMN BARS.CORPS_ACC.SW59_ACC IS 'Рахунок бенефіціара';




PROMPT *** Create  constraint PK_CORPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC ADD CONSTRAINT PK_CORPSACC PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CORPSACC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC MODIFY (ID CONSTRAINT CC_CORPSACC_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CORPSACC_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC MODIFY (RNK CONSTRAINT CC_CORPSACC_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CORPSACC_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC MODIFY (MFO CONSTRAINT CC_CORPSACC_MFO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CORPSACC_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_ACC MODIFY (NLS CONSTRAINT CC_CORPSACC_NLS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CORPSACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CORPSACC ON BARS.CORPS_ACC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CORPS_ACC ***
grant SELECT                                                                 on CORPS_ACC       to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on CORPS_ACC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CORPS_ACC       to BARS_DM;
grant DELETE,SELECT,UPDATE                                                   on CORPS_ACC       to CUST001;
grant SELECT                                                                 on CORPS_ACC       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CORPS_ACC       to WR_ALL_RIGHTS;
grant SELECT                                                                 on CORPS_ACC       to WR_CUSTREG;
grant SELECT                                                                 on CORPS_ACC       to WR_DEPOSIT_U;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CORPS_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
