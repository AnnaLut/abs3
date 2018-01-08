

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOB_OLD.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOB_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOB_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDOB_OLD 
   (	ACC NUMBER(*,0), 
	FDAT DATE, 
	PDAT DATE, 
	OSTF NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	TRCN NUMBER(10,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSSALD 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P20090101  VALUES LESS THAN (TO_DATE('' 2009-01-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSSALD ) ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOB_OLD ***
 exec bpa.alter_policies('SALDOB_OLD');


COMMENT ON TABLE BARS.SALDOB_OLD IS 'Архив эквивалентов по счетам в инвалюте';
COMMENT ON COLUMN BARS.SALDOB_OLD.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.SALDOB_OLD.FDAT IS 'Дата остатка';
COMMENT ON COLUMN BARS.SALDOB_OLD.PDAT IS 'Дата пред. движения';
COMMENT ON COLUMN BARS.SALDOB_OLD.OSTF IS 'Входящий остаток';
COMMENT ON COLUMN BARS.SALDOB_OLD.DOS IS 'Обороты дебет';
COMMENT ON COLUMN BARS.SALDOB_OLD.KOS IS 'Обороты кредит';
COMMENT ON COLUMN BARS.SALDOB_OLD.TRCN IS 'Кол-во транзакций';
COMMENT ON COLUMN BARS.SALDOB_OLD.KF IS '';




PROMPT *** Create  constraint PK_SALDOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD ADD CONSTRAINT PK_SALDOB PRIMARY KEY (ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSALI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_FDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD ADD CONSTRAINT CC_SALDOB_FDAT CHECK (fdat = trunc(fdat)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD MODIFY (KF CONSTRAINT CC_SALDOB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD MODIFY (KOS CONSTRAINT CC_SALDOB_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD MODIFY (DOS CONSTRAINT CC_SALDOB_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_OSTF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD MODIFY (OSTF CONSTRAINT CC_SALDOB_OSTF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD MODIFY (FDAT CONSTRAINT CC_SALDOB_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_PDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD ADD CONSTRAINT CC_SALDOB_PDAT CHECK (pdat = trunc(pdat)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SALDOB_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD ADD CONSTRAINT FK_SALDOB_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SALDOB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD ADD CONSTRAINT FK_SALDOB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOB_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOB_OLD MODIFY (ACC CONSTRAINT CC_SALDOB_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SALDOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SALDOB ON BARS.SALDOB_OLD (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSALI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDOB_OLD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOB_OLD      to ABS_ADMIN;
grant SELECT                                                                 on SALDOB_OLD      to BARSDWH_ACCESS_USER;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOB_OLD      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDOB_OLD      to RPBN001;
grant SELECT                                                                 on SALDOB_OLD      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALDOB_OLD      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOB_OLD.sql =========*** End *** ==
PROMPT ===================================================================================== 
