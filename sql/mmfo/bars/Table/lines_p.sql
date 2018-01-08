

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_P.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_P ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_P'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_P'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_P'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_P ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_P 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(9), 
	BANK_OKPO VARCHAR2(8), 
	NB VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	RTYPE NUMBER(1,0), 
	OTYPE NUMBER(1,0), 
	ODATE DATE, 
	NLS VARCHAR2(40), 
	RESID NUMBER(1,0), 
	NMKK VARCHAR2(38), 
	C_REG NUMBER(2,0), 
	NTAX NUMBER(2,0), 
	ADR VARCHAR2(80), 
	ERR VARCHAR2(4), 
	DAT_IN_DPA DATE, 
	DAT_ACC_DPA DATE, 
	ID_PR NUMBER(1,0), 
	ID_DPA NUMBER(2,0), 
	ID_DPS NUMBER(2,0), 
	ID_REC VARCHAR2(24), 
	FN_R VARCHAR2(30), 
	DATE_R DATE, 
	N_R NUMBER(6,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ID NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_P ***
 exec bpa.alter_policies('LINES_P');


COMMENT ON TABLE BARS.LINES_P IS '';
COMMENT ON COLUMN BARS.LINES_P.FN IS '';
COMMENT ON COLUMN BARS.LINES_P.DAT IS '';
COMMENT ON COLUMN BARS.LINES_P.N IS '';
COMMENT ON COLUMN BARS.LINES_P.MFO IS '';
COMMENT ON COLUMN BARS.LINES_P.BANK_OKPO IS '';
COMMENT ON COLUMN BARS.LINES_P.NB IS '';
COMMENT ON COLUMN BARS.LINES_P.OKPO IS '';
COMMENT ON COLUMN BARS.LINES_P.RTYPE IS '';
COMMENT ON COLUMN BARS.LINES_P.OTYPE IS '';
COMMENT ON COLUMN BARS.LINES_P.ODATE IS '';
COMMENT ON COLUMN BARS.LINES_P.NLS IS '';
COMMENT ON COLUMN BARS.LINES_P.RESID IS '';
COMMENT ON COLUMN BARS.LINES_P.NMKK IS '';
COMMENT ON COLUMN BARS.LINES_P.C_REG IS '';
COMMENT ON COLUMN BARS.LINES_P.NTAX IS '';
COMMENT ON COLUMN BARS.LINES_P.ADR IS '';
COMMENT ON COLUMN BARS.LINES_P.ERR IS '';
COMMENT ON COLUMN BARS.LINES_P.DAT_IN_DPA IS '';
COMMENT ON COLUMN BARS.LINES_P.DAT_ACC_DPA IS '';
COMMENT ON COLUMN BARS.LINES_P.ID_PR IS '';
COMMENT ON COLUMN BARS.LINES_P.ID_DPA IS '';
COMMENT ON COLUMN BARS.LINES_P.ID_DPS IS '';
COMMENT ON COLUMN BARS.LINES_P.ID_REC IS '';
COMMENT ON COLUMN BARS.LINES_P.FN_R IS '';
COMMENT ON COLUMN BARS.LINES_P.DATE_R IS '';
COMMENT ON COLUMN BARS.LINES_P.N_R IS '';
COMMENT ON COLUMN BARS.LINES_P.KF IS '';
COMMENT ON COLUMN BARS.LINES_P.ID IS '';




PROMPT *** Create  constraint FK_LINESP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_P ADD CONSTRAINT FK_LINESP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LINESP_ZAGF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_P ADD CONSTRAINT FK_LINESP_ZAGF FOREIGN KEY (KF, FN, DAT)
	  REFERENCES BARS.ZAG_F (KF, FN, DAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LINESP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_P MODIFY (KF CONSTRAINT CC_LINESP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LINESP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_P MODIFY (ID CONSTRAINT CC_LINESP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_LINESP ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_P ADD CONSTRAINT PK_LINESP PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LINESP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LINESP ON BARS.LINES_P (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_P ***
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_P         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_P         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_P         to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_P         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to LINES_P ***

  CREATE OR REPLACE PUBLIC SYNONYM LINES_P FOR BARS.LINES_P;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_P.sql =========*** End *** =====
PROMPT ===================================================================================== 
