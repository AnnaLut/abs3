

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPECPARAM_INT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPECPARAM_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPECPARAM_INT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SPECPARAM_INT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPECPARAM_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPECPARAM_INT 
   (	ACC NUMBER(38,0), 
	P080 VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	MFO VARCHAR2(6), 
	R020_FA VARCHAR2(4), 
	KOR VARCHAR2(4), 
	DEB01 VARCHAR2(25), 
	DEB02 DATE, 
	DEB03 DATE, 
	DEB04 NUMBER(*,0), 
	DEB05 VARCHAR2(60), 
	DEB06 VARCHAR2(60), 
	DEB07 VARCHAR2(1), 
	F_11 VARCHAR2(1), 
	OB88 VARCHAR2(4), 
	DD VARCHAR2(2), 
	RR VARCHAR2(10), 
	PRIOCOM_IDCONTRACT NUMBER(*,0), 
	PRIOCOM_CR_SUPPLYCODE VARCHAR2(64), 
	PRIOCOM_KL_KPR NUMBER(*,0), 
	PRIOCOM_KOD_BIZN NUMBER(*,0), 
	PRIOCOM_NDOG_Z VARCHAR2(64), 
	PRIOCOM_CURRENCY_Z NUMBER(*,0), 
	PRIOCOM_S040_Z DATE, 
	PRIOCOM_S050_Z DATE, 
	PRIOCOM_LSUMM NUMBER, 
	TYPNLS VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DEMAND_BRN VARCHAR2(5), 
	DEMAND_COND_SET NUMBER(*,0), 
	DEMAND_KK VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPECPARAM_INT ***
 exec bpa.alter_policies('SPECPARAM_INT');


COMMENT ON TABLE BARS.SPECPARAM_INT IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEMAND_KK IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.ACC IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.P080 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.OB22 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.MFO IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.R020_FA IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.KOR IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEB01 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEB02 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEB03 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEB04 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEB05 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEB06 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEB07 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.F_11 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.OB88 IS '����.�������� OB88';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DD IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.RR IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_IDCONTRACT IS '������: ID ���������';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_CR_SUPPLYCODE IS '������: ������������� �������';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_KL_KPR IS '������: ������� ������������';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_KOD_BIZN IS '������: ��� ������';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_NDOG_Z IS '������: � ��� ������������';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_CURRENCY_Z IS '������: ������ �������� ������������ R030';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_S040_Z IS '������: ���� ������ �������� ������������ S040';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_S050_Z IS '������: ���� ���������� �������� ������������ S050';
COMMENT ON COLUMN BARS.SPECPARAM_INT.PRIOCOM_LSUMM IS '������: ��� ������';
COMMENT ON COLUMN BARS.SPECPARAM_INT.TYPNLS IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.KF IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEMAND_BRN IS '';
COMMENT ON COLUMN BARS.SPECPARAM_INT.DEMAND_COND_SET IS '';




PROMPT *** Create  constraint FK_SPECINT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT ADD CONSTRAINT FK_SPECINT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECPARAMINT_DEMANDFILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT ADD CONSTRAINT FK_SPECPARAMINT_DEMANDFILS FOREIGN KEY (DEMAND_BRN)
	  REFERENCES BARS.DEMAND_FILIALES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECINT_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT ADD CONSTRAINT FK_SPECINT_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPECPINT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT ADD CONSTRAINT PK_SPECPINT PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECINT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT MODIFY (KF CONSTRAINT CC_SPECINT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECINT_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT MODIFY (ACC CONSTRAINT CC_SPECINT_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPECPINT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPECPINT ON BARS.SPECPARAM_INT (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPECPARAM_INT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPECPARAM_INT   to ABS_ADMIN;
grant SELECT                                                                 on SPECPARAM_INT   to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on SPECPARAM_INT   to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SPECPARAM_INT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPECPARAM_INT   to BARS_SUP;
grant INSERT,SELECT,UPDATE                                                   on SPECPARAM_INT   to CUST001;
grant SELECT                                                                 on SPECPARAM_INT   to PYOD001;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SPECPARAM_INT   to RCC_DEAL;
grant SELECT                                                                 on SPECPARAM_INT   to RPBN001;
grant SELECT                                                                 on SPECPARAM_INT   to RPBN002;
grant SELECT                                                                 on SPECPARAM_INT   to SALGL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SPECPARAM_INT   to START1;
grant SELECT                                                                 on SPECPARAM_INT   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPECPARAM_INT   to WR_ALL_RIGHTS;
grant UPDATE                                                                 on SPECPARAM_INT   to WR_DEPOSIT_U;



PROMPT *** Create SYNONYM  to SPECPARAM_INT ***

  CREATE OR REPLACE SYNONYM BARSDWH_ACCESS_USER.SPECPARAM_INT FOR BARS.SPECPARAM_INT;


PROMPT *** Create SYNONYM  to SPECPARAM_INT ***

  CREATE OR REPLACE PUBLIC SYNONYM SPECPARAM_INT FOR BARS.SPECPARAM_INT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPECPARAM_INT.sql =========*** End ***
PROMPT ===================================================================================== 
