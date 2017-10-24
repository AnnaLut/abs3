

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_MC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_MC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_MC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAG_MC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_MC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_MC 
   (	FN VARCHAR2(12), 
	DAT DATE, 
	N NUMBER, 
	SIGN_KEY VARCHAR2(6), 
	SIGN RAW(128), 
	FN2 VARCHAR2(12), 
	DAT2 DATE, 
	OTM NUMBER, 
	DATK DATE, 
	SAB CHAR(4), 
	COUNTER NUMBER, 
	DAT_FM DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_MC ***
 exec bpa.alter_policies('ZAG_MC');


COMMENT ON TABLE BARS.ZAG_MC IS '��������� ������ ���������� ����������';
COMMENT ON COLUMN BARS.ZAG_MC.FN IS '��� �����';
COMMENT ON COLUMN BARS.ZAG_MC.DAT IS '���� �������� �����';
COMMENT ON COLUMN BARS.ZAG_MC.N IS '���-�� �������������� �����';
COMMENT ON COLUMN BARS.ZAG_MC.SIGN_KEY IS '������������� ����� �������';
COMMENT ON COLUMN BARS.ZAG_MC.SIGN IS '������� �� �����';
COMMENT ON COLUMN BARS.ZAG_MC.FN2 IS '��� ����� � ���';
COMMENT ON COLUMN BARS.ZAG_MC.DAT2 IS '���� �������� ����� � ���';
COMMENT ON COLUMN BARS.ZAG_MC.OTM IS '������� � ���������';
COMMENT ON COLUMN BARS.ZAG_MC.DATK IS '���� ��������';
COMMENT ON COLUMN BARS.ZAG_MC.SAB IS '';
COMMENT ON COLUMN BARS.ZAG_MC.COUNTER IS '';
COMMENT ON COLUMN BARS.ZAG_MC.DAT_FM IS '';
COMMENT ON COLUMN BARS.ZAG_MC.KF IS '';




PROMPT *** Create  constraint FK_ZAGMC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_MC ADD CONSTRAINT FK_ZAGMC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAGMC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_MC ADD CONSTRAINT PK_ZAGMC PRIMARY KEY (KF, FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGMC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_MC MODIFY (KF CONSTRAINT CC_ZAGMC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAGMC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAGMC ON BARS.ZAG_MC (KF, FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_MC ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ZAG_MC          to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ZAG_MC          to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAG_MC          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_MC.sql =========*** End *** ======
PROMPT ===================================================================================== 
