

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LKL_RRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LKL_RRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LKL_RRP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LKL_RRP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LKL_RRP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LKL_RRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.LKL_RRP 
   (	MFO VARCHAR2(12), 
	DAT DATE, 
	OSTF NUMBER(24,0), 
	LIM NUMBER(24,0), 
	LNO NUMBER(24,0), 
	KN NUMBER(*,0) DEFAULT -1, 
	BN NUMBER(*,0) DEFAULT 0, 
	DAT_R DATE DEFAULT SYSDATE, 
	RN NUMBER(*,0), 
	IDR CHAR(8), 
	DR_DATE DATE, 
	PCN NUMBER DEFAULT 0, 
	PFN NUMBER DEFAULT 0, 
	PQN NUMBER DEFAULT 0, 
	PRN NUMBER DEFAULT 0, 
	SSP_DATE DATE DEFAULT SYSDATE, 
	SSP_SN NUMBER, 
	SSP_PN NUMBER, 
	TROUBLE CHAR(1), 
	KV NUMBER(*,0) DEFAULT 980, 
	BLK NUMBER(*,0) DEFAULT 0, 
	BN_SSP NUMBER(*,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	FILE_ENCODING VARCHAR2(3) DEFAULT ''WIN''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LKL_RRP ***
 exec bpa.alter_policies('LKL_RRP');


COMMENT ON TABLE BARS.LKL_RRP IS '';
COMMENT ON COLUMN BARS.LKL_RRP.KF IS '';
COMMENT ON COLUMN BARS.LKL_RRP.FILE_ENCODING IS '';
COMMENT ON COLUMN BARS.LKL_RRP.MFO IS '';
COMMENT ON COLUMN BARS.LKL_RRP.DAT IS '';
COMMENT ON COLUMN BARS.LKL_RRP.OSTF IS '';
COMMENT ON COLUMN BARS.LKL_RRP.LIM IS '';
COMMENT ON COLUMN BARS.LKL_RRP.LNO IS '';
COMMENT ON COLUMN BARS.LKL_RRP.KN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.BN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.DAT_R IS '';
COMMENT ON COLUMN BARS.LKL_RRP.RN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.IDR IS '';
COMMENT ON COLUMN BARS.LKL_RRP.DR_DATE IS '';
COMMENT ON COLUMN BARS.LKL_RRP.PCN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.PFN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.PQN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.PRN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.SSP_DATE IS '';
COMMENT ON COLUMN BARS.LKL_RRP.SSP_SN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.SSP_PN IS '';
COMMENT ON COLUMN BARS.LKL_RRP.TROUBLE IS 'Флаг аварийного состояния филиала';
COMMENT ON COLUMN BARS.LKL_RRP.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.LKL_RRP.BLK IS '';
COMMENT ON COLUMN BARS.LKL_RRP.BN_SSP IS 'Счетчик начальных пакетов ССП';




PROMPT *** Create  constraint CC_LKLRRP_FILEENCODING_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT CC_LKLRRP_FILEENCODING_CC CHECK (file_encoding in (''WIN'',''DOS'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_LKLRRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT PK_LKLRRP PRIMARY KEY (KF, MFO, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LKLRRP_FILEENCODING_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP MODIFY (FILE_ENCODING CONSTRAINT CC_LKLRRP_FILEENCODING_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LKLRRP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP MODIFY (KF CONSTRAINT CC_LKLRRP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LKL_RRP_BN_SSP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP MODIFY (BN_SSP CONSTRAINT CC_LKL_RRP_BN_SSP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LKL_RRP_BLK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP MODIFY (BLK CONSTRAINT CC_LKL_RRP_BLK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LKL_RRP_BLK_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT FK_LKL_RRP_BLK_CODES FOREIGN KEY (BLK)
	  REFERENCES BARS.BLK_CODES (BLK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LKL_RRP_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT FK_LKL_RRP_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LKL_RRP_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.LKL_RRP ADD CONSTRAINT FK_LKL_RRP_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LKLRRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LKLRRP ON BARS.LKL_RRP (KF, MFO, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LKL_RRP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on LKL_RRP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LKL_RRP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LKL_RRP         to LKL_RRP;
grant DELETE,INSERT,SELECT,UPDATE                                            on LKL_RRP         to SEP_ROLE;
grant SELECT,UPDATE                                                          on LKL_RRP         to SETLIM01;
grant SELECT,UPDATE                                                          on LKL_RRP         to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on LKL_RRP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on LKL_RRP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LKL_RRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
