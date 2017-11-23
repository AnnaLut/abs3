

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_PENSIONER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_PENSIONER ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_PENSIONER 
   (	ID NUMBER(38,0), 
	KF VARCHAR2(6), 
	BRANCH VARCHAR2(30), 
	RNK NUMBER(38,0), 
	NMK VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	ADR VARCHAR2(70), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	PASSP NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PDATE DATE, 
	ORGAN VARCHAR2(70), 
	BDAY DATE, 
	BPLACE VARCHAR2(70), 
	CELLPHONE VARCHAR2(20), 
	STATE VARCHAR2(20), 
	SYS_TIME DATE, 
	COMM VARCHAR2(200), 
	LAST_RU_IDUPD NUMBER, 
	LAST_RU_CHGDATE DATE, 
	BLOCK_DATE DATE, 
	BLOCK_TYPE NUMBER(1,0), 
	TYPE_PENSIONER NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_PENSIONER IS 'ЄБП - пенсіонери';
COMMENT ON COLUMN PFU.PFU_PENSIONER.ID IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.KF IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.BRANCH IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.RNK IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.NMK IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.OKPO IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.ADR IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.DATE_ON IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.DATE_OFF IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.PASSP IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.SER IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.NUMDOC IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.PDATE IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.ORGAN IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.BDAY IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.BPLACE IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.CELLPHONE IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.STATE IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.SYS_TIME IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.COMM IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.LAST_RU_IDUPD IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.LAST_RU_CHGDATE IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.BLOCK_DATE IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.BLOCK_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_PENSIONER.TYPE_PENSIONER IS '';




PROMPT *** Create  constraint FK_PFUPENSIONER_BLKT ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT FK_PFUPENSIONER_BLKT FOREIGN KEY (BLOCK_TYPE)
	  REFERENCES PFU.PFU_PENS_BLOCK_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111489 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFUPENSIONER ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT PK_PFUPENSIONER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUPENSIONER_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT CC_PFUPENSIONER_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUPENSIONER_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT CC_PFUPENSIONER_RNK_NN CHECK (RNK IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUPENSIONER_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT CC_PFUPENSIONER_KF_NN CHECK (KF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUPENSIONER_NMK_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT CC_PFUPENSIONER_NMK_NN CHECK (NMK IS NOT NULL) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUPENSIONER_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT CC_PFUPENSIONER_OKPO_NN CHECK (OKPO IS NOT NULL) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUPENSIONER_PASSP_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT CC_PFUPENSIONER_PASSP_NN CHECK (PASSP IS NOT NULL) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUPENSIONER_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENSIONER ADD CONSTRAINT CC_PFUPENSIONER_DATEON_NN CHECK (DATE_ON IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_PFUPENSIONER_KF ***
begin   
 execute immediate '
  CREATE INDEX PFU.I2_PFUPENSIONER_KF ON PFU.PFU_PENSIONER (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PFUPENSIONER ***
begin   
 execute immediate '
  CREATE INDEX PFU.I1_PFUPENSIONER ON PFU.PFU_PENSIONER (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PFU_PENSIONER_OKPO ***
begin   
 execute immediate '
  CREATE INDEX PFU.I_PFU_PENSIONER_OKPO ON PFU.PFU_PENSIONER (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFUPENSIONER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFUPENSIONER ON PFU.PFU_PENSIONER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** ADD field is_okpo_well ***
begin
    execute immediate 'alter table PFU.PFU_PENSIONER add is_okpo_well NUMBER(1)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column PFU.PFU_PENSIONER.is_okpo_well is 'Результат проверки ОКПО по дате рожения (0 - ОКПО не совпадает с датой рождения, 1- ОКПО совпадает с датой рождения )';

PROMPT *** Create  grants  PFU_PENSIONER ***
grant SELECT                                                                 on PFU_PENSIONER   to BARS;
grant DELETE,INSERT,SELECT,UPDATE                                            on PFU_PENSIONER   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_PENSIONER.sql =========*** End *** 
PROMPT ===================================================================================== 
