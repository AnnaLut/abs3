

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_F.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_F ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_F'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_F'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_F'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_F 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(9), 
	OKPO VARCHAR2(14), 
	RTYPE NUMBER(1,0), 
	OTYPE NUMBER(1,0), 
	ODATE DATE, 
	NLS VARCHAR2(14), 
	NLSM NUMBER(1,0), 
	KV NUMBER(3,0), 
	RESID NUMBER(1,0), 
	NMKK VARCHAR2(38), 
	C_REG NUMBER(2,0), 
	NTAX NUMBER(2,0), 
	ID_O VARCHAR2(6), 
	SIGN RAW(64), 
	ERR VARCHAR2(4), 
	DAT_IN_DPA DATE, 
	DAT_ACC_DPA DATE, 
	ID_PR NUMBER(2,0), 
	ID_DPA NUMBER(2,0), 
	ID_DPS NUMBER(2,0), 
	ID_REC VARCHAR2(24), 
	FN_R VARCHAR2(30), 
	DATE_R DATE, 
	N_R NUMBER(6,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ADR VARCHAR2(80)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_F ***
 exec bpa.alter_policies('LINES_F');


COMMENT ON TABLE BARS.LINES_F IS '';
COMMENT ON COLUMN BARS.LINES_F.KF IS '';
COMMENT ON COLUMN BARS.LINES_F.ADR IS '';
COMMENT ON COLUMN BARS.LINES_F.FN IS '';
COMMENT ON COLUMN BARS.LINES_F.DAT IS '';
COMMENT ON COLUMN BARS.LINES_F.N IS '';
COMMENT ON COLUMN BARS.LINES_F.MFO IS '';
COMMENT ON COLUMN BARS.LINES_F.OKPO IS '';
COMMENT ON COLUMN BARS.LINES_F.RTYPE IS '';
COMMENT ON COLUMN BARS.LINES_F.OTYPE IS '';
COMMENT ON COLUMN BARS.LINES_F.ODATE IS '';
COMMENT ON COLUMN BARS.LINES_F.NLS IS '';
COMMENT ON COLUMN BARS.LINES_F.NLSM IS '';
COMMENT ON COLUMN BARS.LINES_F.KV IS '';
COMMENT ON COLUMN BARS.LINES_F.RESID IS '';
COMMENT ON COLUMN BARS.LINES_F.NMKK IS '';
COMMENT ON COLUMN BARS.LINES_F.C_REG IS '';
COMMENT ON COLUMN BARS.LINES_F.NTAX IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_O IS '';
COMMENT ON COLUMN BARS.LINES_F.SIGN IS '';
COMMENT ON COLUMN BARS.LINES_F.ERR IS '';
COMMENT ON COLUMN BARS.LINES_F.DAT_IN_DPA IS '';
COMMENT ON COLUMN BARS.LINES_F.DAT_ACC_DPA IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_PR IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_DPA IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_DPS IS '';
COMMENT ON COLUMN BARS.LINES_F.ID_REC IS '';
COMMENT ON COLUMN BARS.LINES_F.FN_R IS '';
COMMENT ON COLUMN BARS.LINES_F.DATE_R IS '';
COMMENT ON COLUMN BARS.LINES_F.N_R IS '';




PROMPT *** Create  constraint PK_LINESF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F ADD CONSTRAINT PK_LINESF PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LINESF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F ADD CONSTRAINT FK_LINESF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_LINES_ZAG_F ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F ADD CONSTRAINT R_LINES_ZAG_F FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_F (FN, DAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LINESF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_F MODIFY (KF CONSTRAINT CC_LINESF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LINESF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LINESF ON BARS.LINES_F (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_F ***
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_F         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_F         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_F         to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on LINES_F         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to LINES_F ***

  CREATE OR REPLACE PUBLIC SYNONYM LINES_F FOR BARS.LINES_F;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_F.sql =========*** End *** =====
PROMPT ===================================================================================== 
