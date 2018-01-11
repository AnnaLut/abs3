

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ARC_AN_KL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ARC_AN_KL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ARC_AN_KL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ARC_AN_KL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ARC_AN_KL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ARC_AN_KL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ARC_AN_KL 
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
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ARC_AN_KL ***
 exec bpa.alter_policies('ARC_AN_KL');


COMMENT ON TABLE BARS.ARC_AN_KL IS 'Aрхив анализа клиентов';
COMMENT ON COLUMN BARS.ARC_AN_KL.ID IS '';
COMMENT ON COLUMN BARS.ARC_AN_KL.RNK IS 'Рег № кл';
COMMENT ON COLUMN BARS.ARC_AN_KL.NMK IS 'РiкМiс(YYYYMM)';
COMMENT ON COLUMN BARS.ARC_AN_KL.NLS IS 'Особ.рах';
COMMENT ON COLUMN BARS.ARC_AN_KL.KOL IS '';
COMMENT ON COLUMN BARS.ARC_AN_KL.S_980 IS 'S_980 Срд.зал';
COMMENT ON COLUMN BARS.ARC_AN_KL.S_840 IS 'S_840 Срд.зал';
COMMENT ON COLUMN BARS.ARC_AN_KL.S_978 IS 'S_978 Срд.зал';
COMMENT ON COLUMN BARS.ARC_AN_KL.S_810 IS 'S_810 Срд.зал';
COMMENT ON COLUMN BARS.ARC_AN_KL.S_EQV IS '';
COMMENT ON COLUMN BARS.ARC_AN_KL.K_980 IS 'K_980 Кр.об';
COMMENT ON COLUMN BARS.ARC_AN_KL.K_840 IS 'K_840 Кр.об';
COMMENT ON COLUMN BARS.ARC_AN_KL.K_978 IS 'K_978 Кр.об';
COMMENT ON COLUMN BARS.ARC_AN_KL.K_810 IS 'K_810 Кр.об';
COMMENT ON COLUMN BARS.ARC_AN_KL.NNK IS 'NNK Почат.не ел';
COMMENT ON COLUMN BARS.ARC_AN_KL.NYK IS 'NYK Почат.ел';
COMMENT ON COLUMN BARS.ARC_AN_KL.NMB IS 'NMB Почат.СЕП';
COMMENT ON COLUMN BARS.ARC_AN_KL.OMB IS 'OMB Вiдп.СЕП';
COMMENT ON COLUMN BARS.ARC_AN_KL.D1 IS 'D01';
COMMENT ON COLUMN BARS.ARC_AN_KL.D2 IS 'D02';
COMMENT ON COLUMN BARS.ARC_AN_KL.D3 IS 'D03';
COMMENT ON COLUMN BARS.ARC_AN_KL.D4 IS 'D04';
COMMENT ON COLUMN BARS.ARC_AN_KL.D5 IS 'D05';
COMMENT ON COLUMN BARS.ARC_AN_KL.D6 IS 'D06';
COMMENT ON COLUMN BARS.ARC_AN_KL.D7 IS 'D07';
COMMENT ON COLUMN BARS.ARC_AN_KL.D8 IS 'D08';
COMMENT ON COLUMN BARS.ARC_AN_KL.D9 IS 'D09';
COMMENT ON COLUMN BARS.ARC_AN_KL.D10 IS 'D10';
COMMENT ON COLUMN BARS.ARC_AN_KL.D11 IS 'D11';
COMMENT ON COLUMN BARS.ARC_AN_KL.D12 IS 'D12';
COMMENT ON COLUMN BARS.ARC_AN_KL.R1 IS 'R01';
COMMENT ON COLUMN BARS.ARC_AN_KL.ISP IS 'Вик по рах.';
COMMENT ON COLUMN BARS.ARC_AN_KL.Q_840 IS 'Q_840 Срд.зал.екв';
COMMENT ON COLUMN BARS.ARC_AN_KL.Q_978 IS 'Q_978 Срд.зал.екв';
COMMENT ON COLUMN BARS.ARC_AN_KL.Q_810 IS 'Q_810 Срд.зал.екв';
COMMENT ON COLUMN BARS.ARC_AN_KL.D13 IS 'D13';
COMMENT ON COLUMN BARS.ARC_AN_KL.D14 IS 'D14';
COMMENT ON COLUMN BARS.ARC_AN_KL.D15 IS 'D15';
COMMENT ON COLUMN BARS.ARC_AN_KL.D16 IS 'D16';
COMMENT ON COLUMN BARS.ARC_AN_KL.D17 IS 'D17';
COMMENT ON COLUMN BARS.ARC_AN_KL.D18 IS 'D18';
COMMENT ON COLUMN BARS.ARC_AN_KL.D19 IS 'D19';
COMMENT ON COLUMN BARS.ARC_AN_KL.D20 IS 'D20';
COMMENT ON COLUMN BARS.ARC_AN_KL.D21 IS 'D21';
COMMENT ON COLUMN BARS.ARC_AN_KL.D22 IS 'D22';
COMMENT ON COLUMN BARS.ARC_AN_KL.D23 IS 'D23';
COMMENT ON COLUMN BARS.ARC_AN_KL.D24 IS 'D24';
COMMENT ON COLUMN BARS.ARC_AN_KL.R2 IS 'R02';
COMMENT ON COLUMN BARS.ARC_AN_KL.R3 IS 'R03';
COMMENT ON COLUMN BARS.ARC_AN_KL.R4 IS 'R04';
COMMENT ON COLUMN BARS.ARC_AN_KL.C_EQV IS 'C_EQV Чистi кр.об.екв';
COMMENT ON COLUMN BARS.ARC_AN_KL.KF IS '';




PROMPT *** Create  constraint XPK_ARC_AN_KL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_AN_KL ADD CONSTRAINT XPK_ARC_AN_KL PRIMARY KEY (KF, RNK, NMK, NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009332 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_AN_KL MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009333 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_AN_KL MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ARCANKL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_AN_KL MODIFY (KF CONSTRAINT CC_ARCANKL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ARC_AN_KL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ARC_AN_KL ON BARS.ARC_AN_KL (KF, RNK, NMK, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ARC_AN_KL ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ARC_AN_KL       to AN_KL;
grant SELECT                                                                 on ARC_AN_KL       to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ARC_AN_KL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ARC_AN_KL       to BARS_DM;
grant SELECT                                                                 on ARC_AN_KL       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ARC_AN_KL       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ARC_AN_KL ***

  CREATE OR REPLACE PUBLIC SYNONYM ARC_AN_KL FOR BARS.ARC_AN_KL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ARC_AN_KL.sql =========*** End *** ===
PROMPT ===================================================================================== 
