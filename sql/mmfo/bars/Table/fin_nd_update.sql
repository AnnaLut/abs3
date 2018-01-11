

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_ND_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_ND_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_ND_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_ND_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FIN_ND_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_ND_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_ND_UPDATE 
   (	FDAT DATE, 
	IDF NUMBER(38,0), 
	KOD VARCHAR2(4), 
	S NUMBER(24,3), 
	ND NUMBER, 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	RNK NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_ND_UPDATE ***
 exec bpa.alter_policies('FIN_ND_UPDATE');


COMMENT ON TABLE BARS.FIN_ND_UPDATE IS 'Фiн.звiти клiєнтiв історія змін';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.FDAT IS 'Дата звiту';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.IDF IS 'Форма';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.KOD IS 'Код рядка';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.S IS 'Показник поточний';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.ND IS 'Реф КД';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.CHGDATE IS 'Дата изменения';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.DONEBY IS 'Кто изменил';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.IDUPD IS 'Id';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.FIN_ND_UPDATE.KF IS '';




PROMPT *** Create  constraint XPK_FINND_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ND_UPDATE ADD CONSTRAINT XPK_FINND_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINNDUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ND_UPDATE MODIFY (KF CONSTRAINT CC_FINNDUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINND_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINND_UPDATE ON BARS.FIN_ND_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_FIN_ND_UPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_FIN_ND_UPDATE ON BARS.FIN_ND_UPDATE (ND, RNK, KOD, IDF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_ND_UPDATE ***
grant SELECT                                                                 on FIN_ND_UPDATE   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_ND_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_ND_UPDATE   to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_ND_UPDATE   to START1;
grant SELECT                                                                 on FIN_ND_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_ND_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
