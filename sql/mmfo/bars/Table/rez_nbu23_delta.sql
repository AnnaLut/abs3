

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_NBU23_DELTA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_NBU23_DELTA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_NBU23_DELTA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_NBU23_DELTA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_NBU23_DELTA ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_NBU23_DELTA 
   (	FDAT DATE, 
	ID VARCHAR2(50), 
	RNK NUMBER, 
	NBS CHAR(4), 
	KV NUMBER, 
	ND NUMBER, 
	CC_ID VARCHAR2(50), 
	ACC NUMBER, 
	NLS VARCHAR2(20), 
	BRANCH VARCHAR2(30), 
	FIN NUMBER, 
	FIN_N NUMBER, 
	OBS NUMBER, 
	KAT NUMBER, 
	KAT_N NUMBER, 
	K NUMBER, 
	K_N NUMBER, 
	IRR NUMBER, 
	BV NUMBER, 
	BVQ NUMBER, 
	REZ23 NUMBER, 
	REZQ23 NUMBER, 
	PVZ NUMBER, 
	PVZQ NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	BV_N NUMBER, 
	BVQ_N NUMBER, 
	REZ23_N NUMBER, 
	REZQ23_N NUMBER, 
	PVZ_N NUMBER, 
	PVZQ_N NUMBER, 
	REZ_N NUMBER, 
	REZQ_N NUMBER, 
	DELTA NUMBER, 
	DELTAQ NUMBER, 
	DELTA_351 NUMBER, 
	DELTAQ_351 NUMBER, 
	NMK VARCHAR2(35), 
	OB22 CHAR(2), 
	DD CHAR(1), 
	DDD CHAR(3), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_NBU23_DELTA ***
 exec bpa.alter_policies('REZ_NBU23_DELTA');


COMMENT ON TABLE BARS.REZ_NBU23_DELTA IS 'Изменение резерва';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.KF IS '';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.FDAT IS 'Зв.дата';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.ID IS '';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.RNK IS 'Рег № кл';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.NBS IS 'Бал.рах';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.KV IS 'Код вал.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.ND IS 'Реф.договора';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.CC_ID IS 'Идент.договора';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.ACC IS 'АСС рах';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.NLS IS '№ рах';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.BRANCH IS '';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.FIN IS 'Фин.клас';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.FIN_N IS '';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.OBS IS 'Обслуг.боргу';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.KAT IS 'Кат.якості';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.KAT_N IS 'Кат.якості(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.K IS 'Пок.ризику';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.K_N IS 'Пок.ризику(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.IRR IS 'Эфф.% ст.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.BV IS 'Бал.варт.(ном.)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.BVQ IS 'Бал.варт.(екв.)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZ23 IS 'Рез(351)-ном.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZQ23 IS 'Рез(351)-екв.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.PVZ IS 'Враховане забезпечення(ном.)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.PVZQ IS 'Враховане забезпечення(екв.)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZ IS 'Рез(МСФЗ)-ном.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZQ IS 'Рез(МСФЗ)-екв.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.BV_N IS 'Бал.варт.(ном.)(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.BVQ_N IS 'Бал.варт.(екв.)(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZ23_N IS 'Рез(351)-ном.(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZQ23_N IS 'Рез(351)-екв.(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.PVZ_N IS 'Враховане забезпечення(ном.)(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.PVZQ_N IS 'Враховане забезпечення(екв.)(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZ_N IS 'Рез(МСФЗ)-ном.(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.REZQ_N IS 'Рез(МСФЗ)-екв.(минулий місяць)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.DELTA IS 'Різниця(МСФЗ)(ном.)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.DELTAQ IS 'Різниця(МСФЗ)(екв.)';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.DELTA_351 IS 'Різниця(351) -ном.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.DELTAQ_351 IS 'Різниця(351) -екв.';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.NMK IS '';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.OB22 IS '';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.DD IS '';
COMMENT ON COLUMN BARS.REZ_NBU23_DELTA.DDD IS '';




PROMPT *** Create  constraint PK_REZ_NBU23_DELTA ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_NBU23_DELTA ADD CONSTRAINT PK_REZ_NBU23_DELTA PRIMARY KEY (FDAT, ACC, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZNBU23DELTA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_NBU23_DELTA MODIFY (KF CONSTRAINT CC_REZNBU23DELTA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_NBU23_DELTA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_NBU23_DELTA ON BARS.REZ_NBU23_DELTA (FDAT, ACC, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_NBU23_DELTA ***
grant SELECT                                                                 on REZ_NBU23_DELTA to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_NBU23_DELTA to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_NBU23_DELTA to START1;
grant SELECT                                                                 on REZ_NBU23_DELTA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_NBU23_DELTA.sql =========*** End *
PROMPT ===================================================================================== 
