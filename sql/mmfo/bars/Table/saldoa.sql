

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOA.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDOA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SALDOA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOA ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDOA 
   (	ACC NUMBER(*,0), 
	FDAT DATE, 
	PDAT DATE, 
	OSTF NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	TRCN NUMBER(10,0), 
	OSTQ NUMBER(24,0) DEFAULT 0, 
	DOSQ NUMBER(24,0) DEFAULT 0, 
	KOSQ NUMBER(24,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSSALD 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P_20080716  VALUES LESS THAN (TO_DATE('' 2009-01-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSSALD ) ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOA ***
 exec bpa.alter_policies('SALDOA');


COMMENT ON TABLE BARS.SALDOA IS 'Архив остатков по ВСЕМ  счетам по датам';
COMMENT ON COLUMN BARS.SALDOA.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.SALDOA.FDAT IS 'Дата остатка';
COMMENT ON COLUMN BARS.SALDOA.PDAT IS 'Дата пред. движения';
COMMENT ON COLUMN BARS.SALDOA.OSTF IS 'Входящий остаток';
COMMENT ON COLUMN BARS.SALDOA.DOS IS 'Обороты дебет';
COMMENT ON COLUMN BARS.SALDOA.KOS IS 'Обороты кредит';
COMMENT ON COLUMN BARS.SALDOA.TRCN IS 'Кол-во транзакций';
COMMENT ON COLUMN BARS.SALDOA.OSTQ IS 'Эквивалент входящего остатка';
COMMENT ON COLUMN BARS.SALDOA.DOSQ IS 'Эквивалент оборотов дебет';
COMMENT ON COLUMN BARS.SALDOA.KOSQ IS 'Эквивалент оборотов кредит';
COMMENT ON COLUMN BARS.SALDOA.KF IS '';




PROMPT *** Create  constraint PK_SALDOA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA ADD CONSTRAINT PK_SALDOA PRIMARY KEY (ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSALI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_FDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA ADD CONSTRAINT CC_SALDOA_FDAT CHECK (fdat = trunc(fdat)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_PDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA ADD CONSTRAINT CC_SALDOA_PDAT CHECK (pdat = trunc(pdat)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT *** Create  constraint FK_SALDOA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA ADD CONSTRAINT FK_SALDOA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (ACC CONSTRAINT CC_SALDOA_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (KF CONSTRAINT CC_SALDOA_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_OSTF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (OSTF CONSTRAINT CC_SALDOA_OSTF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (DOS CONSTRAINT CC_SALDOA_DOS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (KOS CONSTRAINT CC_SALDOA_KOS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (OSTQ CONSTRAINT CC_SALDOA_OSTQ_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (DOSQ CONSTRAINT CC_SALDOA_DOSQ_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (KOSQ CONSTRAINT CC_SALDOA_KOSQ_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOA_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA MODIFY (FDAT CONSTRAINT CC_SALDOA_FDAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SALDOA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SALDOA ON BARS.SALDOA (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSALI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT *** Create  grants  SALDOA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOA          to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT,UPDATE                                     on SALDOA          to BARSAQ with grant option;
grant REFERENCES,UPDATE                                                      on SALDOA          to BARSAQ_ADM;
grant SELECT                                                                 on SALDOA          to BARSAQ_ADM with grant option;
grant SELECT                                                                 on SALDOA          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on SALDOA          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOA          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDOA          to BARS_DM;
grant SELECT                                                                 on SALDOA          to DM;
grant SELECT                                                                 on SALDOA          to DPT_ROLE;
grant SELECT                                                                 on SALDOA          to JBOSS_USR;
grant SELECT                                                                 on SALDOA          to RCC_DEAL;
grant SELECT                                                                 on SALDOA          to RPBN001;
grant SELECT                                                                 on SALDOA          to RPBN002;
grant SELECT                                                                 on SALDOA          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALDOA          to WR_ALL_RIGHTS;
grant SELECT                                                                 on SALDOA          to WR_CUSTLIST;
grant SELECT                                                                 on SALDOA          to WR_DEPOSIT_U;
grant SELECT                                                                 on SALDOA          to WR_ND_ACCOUNTS;
grant SELECT                                                                 on SALDOA          to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on SALDOA          to WR_USER_ACCOUNTS_LIST;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOA.sql =========*** End *** ======
PROMPT ===================================================================================== 
