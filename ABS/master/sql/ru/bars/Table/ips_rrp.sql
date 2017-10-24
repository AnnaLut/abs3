

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IPS_RRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IPS_RRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IPS_RRP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''IPS_RRP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IPS_RRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.IPS_RRP 
   (	DAT_SEP DATE, 
	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(14), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(14), 
	DK NUMBER(*,0), 
	S NUMBER(24,0), 
	KV NUMBER(*,0), 
	FN_QA VARCHAR2(12), 
	REC_QA NUMBER(*,0), 
	DAT_QA DATE, 
	ERRK CHAR(4), 
	FN_A VARCHAR2(12), 
	REC_A NUMBER(*,0), 
	DAT_A DATE, 
	DAT_PA DATE, 
	FN_QB VARCHAR2(12), 
	REC_QB NUMBER(*,0), 
	DAT_QB DATE, 
	FN_B VARCHAR2(12), 
	REC_B NUMBER(*,0), 
	DAT_B DATE, 
	DAT_PB DATE, 
	BIS NUMBER(*,0), 
	DAT_L DATE, 
	F_RQ CHAR(1), 
	T_RQ CHAR(3), 
	REF_Q RAW(128), 
	REF_A VARCHAR2(10), 
	OTM NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IPS_RRP ***
 exec bpa.alter_policies('IPS_RRP');


COMMENT ON TABLE BARS.IPS_RRP IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_SEP IS '';
COMMENT ON COLUMN BARS.IPS_RRP.MFOA IS '';
COMMENT ON COLUMN BARS.IPS_RRP.NLSA IS '';
COMMENT ON COLUMN BARS.IPS_RRP.MFOB IS '';
COMMENT ON COLUMN BARS.IPS_RRP.NLSB IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DK IS '';
COMMENT ON COLUMN BARS.IPS_RRP.S IS '';
COMMENT ON COLUMN BARS.IPS_RRP.KV IS '';
COMMENT ON COLUMN BARS.IPS_RRP.FN_QA IS '';
COMMENT ON COLUMN BARS.IPS_RRP.REC_QA IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_QA IS '';
COMMENT ON COLUMN BARS.IPS_RRP.ERRK IS '';
COMMENT ON COLUMN BARS.IPS_RRP.FN_A IS '';
COMMENT ON COLUMN BARS.IPS_RRP.REC_A IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_A IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_PA IS '';
COMMENT ON COLUMN BARS.IPS_RRP.FN_QB IS '';
COMMENT ON COLUMN BARS.IPS_RRP.REC_QB IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_QB IS '';
COMMENT ON COLUMN BARS.IPS_RRP.FN_B IS '';
COMMENT ON COLUMN BARS.IPS_RRP.REC_B IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_B IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_PB IS '';
COMMENT ON COLUMN BARS.IPS_RRP.BIS IS '';
COMMENT ON COLUMN BARS.IPS_RRP.DAT_L IS '';
COMMENT ON COLUMN BARS.IPS_RRP.F_RQ IS '';
COMMENT ON COLUMN BARS.IPS_RRP.T_RQ IS '';
COMMENT ON COLUMN BARS.IPS_RRP.REF_Q IS '';
COMMENT ON COLUMN BARS.IPS_RRP.REF_A IS '';
COMMENT ON COLUMN BARS.IPS_RRP.OTM IS '';
COMMENT ON COLUMN BARS.IPS_RRP.KF IS '';




PROMPT *** Create  constraint FK_IPSRRP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP ADD CONSTRAINT FK_IPSRRP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010353 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (MFOA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010352 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (DAT_SEP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IPSRRP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (KF CONSTRAINT CC_IPSRRP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010361 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (REC_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010360 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (FN_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010359 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010358 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (S NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010357 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010356 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010355 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010354 ***
begin   
 execute immediate '
  ALTER TABLE BARS.IPS_RRP MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_OTM_IPS_RRP ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_OTM_IPS_RRP ON BARS.IPS_RRP (OTM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_FN_QA_IPS_RRP ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_FN_QA_IPS_RRP ON BARS.IPS_RRP (FN_QA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IPS_RRP ***
grant INSERT,SELECT,UPDATE                                                   on IPS_RRP         to BARS_ACCESS_DEFROLE;
grant INSERT                                                                 on IPS_RRP         to TECH002;
grant INSERT                                                                 on IPS_RRP         to TECH004;
grant INSERT,SELECT,UPDATE                                                   on IPS_RRP         to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on IPS_RRP         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IPS_RRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
