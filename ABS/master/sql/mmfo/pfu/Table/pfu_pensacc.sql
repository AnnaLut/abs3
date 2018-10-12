

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_PENSACC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_PENSACC ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_PENSACC 
   (	ID NUMBER(38,0), 
	KF VARCHAR2(6), 
	BRANCH VARCHAR2(30), 
	RNK NUMBER(38,0), 
	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	OB22 CHAR(2), 
	DAOS DATE, 
	DAPP DATE, 
	DAZS DATE, 
	STATE VARCHAR2(20), 
	SYS_TIME DATE, 
	LAST_RU_IDUPD NUMBER, 
	LAST_RU_CHGDATE DATE, 
	TRANSACC VARCHAR2(15), 
	TRANSKV NUMBER(3,0), 
	DATE_BLK DATE, 
	COMM VARCHAR2(4000), 
	ISPAYED NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate 'alter table PFU.PFU_PENSACC add nlsalt VARCHAR2(15)';
exception when others then       
  if sqlcode=-1430 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_PENSACC IS 'Рахунки пенсіонерів ЄБП';
COMMENT ON COLUMN PFU.PFU_PENSACC.DATE_BLK IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.COMM IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.ISPAYED IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.ID IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.KF IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.BRANCH IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.RNK IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.ACC IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.NLS IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.KV IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.OB22 IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.DAOS IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.DAPP IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.DAZS IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.STATE IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.SYS_TIME IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.LAST_RU_IDUPD IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.LAST_RU_CHGDATE IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.TRANSACC IS '';
COMMENT ON COLUMN PFU.PFU_PENSACC.TRANSKV IS '';
comment on column PFU.PFU_PENSACC.nlsalt is 'Альтернативний номер рахунку';




PROMPT *** Create  constraint SYS_C00111498 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSACC MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFUPENSACC ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSACC ADD CONSTRAINT PK_PFUPENSACC PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PFUPENSACC ***
begin   
 execute immediate '
  CREATE INDEX PFU.I1_PFUPENSACC ON PFU.PFU_PENSACC (KF, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index I1_PFUPENSACCALT ***
begin   
 execute immediate '
  CREATE INDEX PFU.I1_PFUPENSACCALT on PFU.PFU_PENSACC (kf, nlsalt) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index I2_PFUPENSACC_KF ***
begin   
 execute immediate '
  CREATE INDEX PFU.I2_PFUPENSACC_KF ON PFU.PFU_PENSACC (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFUPENSACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFUPENSACC ON PFU.PFU_PENSACC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_PENSACC ***
grant SELECT                                                                 on PFU_PENSACC     to BARS;
grant SELECT                                                                 on PFU_PENSACC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PFU_PENSACC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_PENSACC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_PENSACC.sql =========*** End *** ==
PROMPT ===================================================================================== 
