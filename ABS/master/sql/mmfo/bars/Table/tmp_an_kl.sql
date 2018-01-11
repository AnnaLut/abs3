

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AN_KL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AN_KL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AN_KL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AN_KL 
   (	ID NUMBER(38,0), 
	RNK NUMBER(38,0), 
	NMK VARCHAR2(35), 
	NLS VARCHAR2(15), 
	KOL NUMBER(38,0), 
	S_980 NUMBER, 
	S_840 NUMBER, 
	S_978 NUMBER, 
	S_810 NUMBER, 
	S_EQV NUMBER, 
	K_980 NUMBER, 
	K_840 NUMBER, 
	K_978 NUMBER, 
	K_810 NUMBER, 
	NNK NUMBER, 
	NYK NUMBER, 
	NMB NUMBER, 
	OMB NUMBER, 
	D1 NUMBER, 
	D2 NUMBER, 
	D3 NUMBER, 
	D4 NUMBER, 
	D5 NUMBER, 
	D6 NUMBER, 
	D7 NUMBER, 
	D8 NUMBER, 
	D9 NUMBER, 
	D10 NUMBER, 
	D11 NUMBER, 
	D12 NUMBER, 
	R1 NUMBER, 
	ISP NUMBER(38,0), 
	Q_840 NUMBER, 
	Q_978 NUMBER, 
	Q_810 NUMBER, 
	D13 NUMBER, 
	D14 NUMBER, 
	D15 NUMBER, 
	D16 NUMBER, 
	D17 NUMBER, 
	D18 NUMBER, 
	D19 NUMBER, 
	D20 NUMBER, 
	D21 NUMBER, 
	D22 NUMBER, 
	D23 NUMBER, 
	D24 NUMBER, 
	R2 NUMBER, 
	R3 NUMBER, 
	R4 NUMBER, 
	C_EQV NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AN_KL ***
 exec bpa.alter_policies('TMP_AN_KL');


COMMENT ON TABLE BARS.TMP_AN_KL IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.ID IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.RNK IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.NMK IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.NLS IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.KOL IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.S_980 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.S_840 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.S_978 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.S_810 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.S_EQV IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.K_980 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.K_840 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.K_978 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.K_810 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.NNK IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.NYK IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.NMB IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.OMB IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D1 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D2 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D3 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D4 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D5 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D6 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D7 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D8 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D9 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D10 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D11 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D12 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.R1 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.ISP IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.Q_840 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.Q_978 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.Q_810 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D13 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D14 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D15 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D16 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D17 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D18 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D19 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D20 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D21 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D22 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D23 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.D24 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.R2 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.R3 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.R4 IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.C_EQV IS '';
COMMENT ON COLUMN BARS.TMP_AN_KL.KF IS '';




PROMPT *** Create  constraint SYS_C0048956 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_AN_KL MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_AN_KL MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_TMP_AN_KL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_AN_KL ADD CONSTRAINT XPK_TMP_AN_KL PRIMARY KEY (KF, RNK, NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMP_AN_KL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMP_AN_KL ON BARS.TMP_AN_KL (KF, RNK, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_AN_KL ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_AN_KL       to AN_KL;
grant SELECT                                                                 on TMP_AN_KL       to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_AN_KL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_AN_KL       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_AN_KL       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_AN_KL ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_AN_KL FOR BARS.TMP_AN_KL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AN_KL.sql =========*** End *** ===
PROMPT ===================================================================================== 
