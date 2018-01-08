

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_ALL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_ALL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_ALL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCOUNTS_ALL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTS_ALL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_ALL 
   (	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_ALL ***
 exec bpa.alter_policies('ACCOUNTS_ALL');


COMMENT ON TABLE BARS.ACCOUNTS_ALL IS 'Все счета системы (в т.ч. архив)';
COMMENT ON COLUMN BARS.ACCOUNTS_ALL.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.ACCOUNTS_ALL.KF IS 'МФО банка / филиала';
COMMENT ON COLUMN BARS.ACCOUNTS_ALL.NLS IS 'Номер счета';
COMMENT ON COLUMN BARS.ACCOUNTS_ALL.KV IS 'Код валюты счета';




PROMPT *** Create  constraint PK_ACCOUNTSALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL ADD CONSTRAINT PK_ACCOUNTSALL PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ACCOUNTSALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL ADD CONSTRAINT UK_ACCOUNTSALL UNIQUE (KF, NLS, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSALL_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL ADD CONSTRAINT FK_ACCOUNTSALL_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSALL_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL ADD CONSTRAINT FK_ACCOUNTSALL_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSALL_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL MODIFY (ACC CONSTRAINT CC_ACCOUNTSALL_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSALL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL MODIFY (KF CONSTRAINT CC_ACCOUNTSALL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSALL_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL MODIFY (KV CONSTRAINT CC_ACCOUNTSALL_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSALL_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_ALL MODIFY (NLS CONSTRAINT CC_ACCOUNTSALL_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTSALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTSALL ON BARS.ACCOUNTS_ALL (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ACCOUNTSALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ACCOUNTSALL ON BARS.ACCOUNTS_ALL (KF, NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS_ALL ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ACCOUNTS_ALL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_ALL    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTS_ALL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_ALL.sql =========*** End *** 
PROMPT ===================================================================================== 
