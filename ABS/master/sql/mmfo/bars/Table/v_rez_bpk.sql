

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/V_REZ_BPK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to V_REZ_BPK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_REZ_BPK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_REZ_BPK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''V_REZ_BPK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table V_REZ_BPK ***
begin 
  execute immediate '
  CREATE TABLE BARS.V_REZ_BPK 
   (	FDAT DATE, 
	TOBO VARCHAR2(30), 
	BPK CHAR(3), 
	RNK NUMBER, 
	ND NUMBER, 
	KV NUMBER, 
	NBS CHAR(4), 
	ACC NUMBER, 
	NLS VARCHAR2(20), 
	FIN NUMBER, 
	OBS NUMBER, 
	KAT NUMBER, 
	K NUMBER, 
	BV NUMBER, 
	BVQ NUMBER, 
	PV NUMBER, 
	PVQ NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	ZAL NUMBER, 
	ZALQ NUMBER, 
	DAT_S DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to V_REZ_BPK ***
 exec bpa.alter_policies('V_REZ_BPK');


COMMENT ON TABLE BARS.V_REZ_BPK IS 'Протокол розрах рез по БПК СБЕРБАНК';
COMMENT ON COLUMN BARS.V_REZ_BPK.KF IS '';
COMMENT ON COLUMN BARS.V_REZ_BPK.BRANCH IS 'Hierarchical Branch Code';
COMMENT ON COLUMN BARS.V_REZ_BPK.FDAT IS 'Зв.дата(01.MM.YYYY.';
COMMENT ON COLUMN BARS.V_REZ_BPK.TOBO IS '';
COMMENT ON COLUMN BARS.V_REZ_BPK.BPK IS '';
COMMENT ON COLUMN BARS.V_REZ_BPK.RNK IS 'Рег № кл';
COMMENT ON COLUMN BARS.V_REZ_BPK.ND IS 'Реф дог';
COMMENT ON COLUMN BARS.V_REZ_BPK.KV IS 'Вал дог';
COMMENT ON COLUMN BARS.V_REZ_BPK.NBS IS 'Бал.рах';
COMMENT ON COLUMN BARS.V_REZ_BPK.ACC IS 'АСС рах';
COMMENT ON COLUMN BARS.V_REZ_BPK.NLS IS '№ рах';
COMMENT ON COLUMN BARS.V_REZ_BPK.FIN IS 'Фин.клас';
COMMENT ON COLUMN BARS.V_REZ_BPK.OBS IS 'Обсуг.';
COMMENT ON COLUMN BARS.V_REZ_BPK.KAT IS 'Кат.якост';
COMMENT ON COLUMN BARS.V_REZ_BPK.K IS 'Пок.ризик';
COMMENT ON COLUMN BARS.V_REZ_BPK.BV IS 'Бал.варт';
COMMENT ON COLUMN BARS.V_REZ_BPK.BVQ IS '';
COMMENT ON COLUMN BARS.V_REZ_BPK.PV IS 'Справ.варт';
COMMENT ON COLUMN BARS.V_REZ_BPK.PVQ IS '';
COMMENT ON COLUMN BARS.V_REZ_BPK.REZ IS 'Рез-ном.';
COMMENT ON COLUMN BARS.V_REZ_BPK.REZQ IS 'Рез-екв.';
COMMENT ON COLUMN BARS.V_REZ_BPK.ZAL IS 'Залог-ном.';
COMMENT ON COLUMN BARS.V_REZ_BPK.ZALQ IS 'Залог-екв.';
COMMENT ON COLUMN BARS.V_REZ_BPK.DAT_S IS '';




PROMPT *** Create  constraint PK_V_REZ_BPK_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.V_REZ_BPK ADD CONSTRAINT PK_V_REZ_BPK_ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VREZBPK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.V_REZ_BPK MODIFY (KF CONSTRAINT CC_VREZBPK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VREZBPK_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.V_REZ_BPK MODIFY (BRANCH CONSTRAINT CC_VREZBPK_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_V_REZ_BPK_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_V_REZ_BPK_ACC ON BARS.V_REZ_BPK (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  V_REZ_BPK ***
grant SELECT                                                                 on V_REZ_BPK       to BARSREADER_ROLE;
grant SELECT                                                                 on V_REZ_BPK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_BPK       to START1;
grant SELECT                                                                 on V_REZ_BPK       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/V_REZ_BPK.sql =========*** End *** ===
PROMPT ===================================================================================== 
