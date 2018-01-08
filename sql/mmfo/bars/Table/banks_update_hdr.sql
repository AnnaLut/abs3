

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANKS_UPDATE_HDR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANKS_UPDATE_HDR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANKS_UPDATE_HDR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BANKS_UPDATE_HDR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BANKS_UPDATE_HDR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANKS_UPDATE_HDR ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANKS_UPDATE_HDR 
   (	ID NUMBER(38,0) DEFAULT 0, 
	FN CHAR(12), 
	DAT DATE, 
	N NUMBER(10,0), 
	REC_START NUMBER(10,0), 
	REC_FINISH NUMBER(10,0), 
	ACC1 NUMBER(10,0), 
	ACC2 NUMBER(10,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANKS_UPDATE_HDR ***
 exec bpa.alter_policies('BANKS_UPDATE_HDR');


COMMENT ON TABLE BARS.BANKS_UPDATE_HDR IS 'Заголовки файла обновления списка участников СЭП';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.ID IS 'Идентификатор файла';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.FN IS 'Имя файла';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.DAT IS 'Дата/время файла';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.N IS 'Количество инф. строк в файле';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.REC_START IS 'Начальное количество участников  
(Таблица и строки используются при работе в СЭП НБУ)';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.REC_FINISH IS 'Конечное кол-во участников';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.ACC1 IS 'Начальное колв-во инвалютных корсчетов 
(Таблица и строки используются при работе в СЭП НБУ)';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.ACC2 IS 'Конечное кол-во инвалютных корсчетов';
COMMENT ON COLUMN BARS.BANKS_UPDATE_HDR.KF IS '';




PROMPT *** Create  constraint PK_BANKSUPDHDR ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE_HDR ADD CONSTRAINT PK_BANKSUPDHDR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_BANKSUPDHDR ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE_HDR ADD CONSTRAINT UK_BANKSUPDHDR UNIQUE (KF, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008078 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE_HDR MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSUPDHDR_FN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE_HDR MODIFY (FN CONSTRAINT CC_BANKSUPDHDR_FN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSUPDHDR_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE_HDR MODIFY (DAT CONSTRAINT CC_BANKSUPDHDR_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSUPDHDR_N_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE_HDR MODIFY (N CONSTRAINT CC_BANKSUPDHDR_N_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSUPDHDR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_UPDATE_HDR MODIFY (KF CONSTRAINT CC_BANKSUPDHDR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKSUPDHDR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKSUPDHDR ON BARS.BANKS_UPDATE_HDR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_BANKSUPDHDR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_BANKSUPDHDR ON BARS.BANKS_UPDATE_HDR (KF, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKS_UPDATE_HDR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_UPDATE_HDR to ABS_ADMIN;
grant SELECT                                                                 on BANKS_UPDATE_HDR to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_UPDATE_HDR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANKS_UPDATE_HDR to BARS_DM;
grant SELECT                                                                 on BANKS_UPDATE_HDR to START1;
grant INSERT                                                                 on BANKS_UPDATE_HDR to TECH020;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_UPDATE_HDR to TOSS;
grant SELECT                                                                 on BANKS_UPDATE_HDR to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANKS_UPDATE_HDR to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANKS_UPDATE_HDR.sql =========*** End 
PROMPT ===================================================================================== 
