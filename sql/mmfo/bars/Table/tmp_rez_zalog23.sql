

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_ZALOG23.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_ZALOG23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_ZALOG23'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_ZALOG23'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMP_REZ_ZALOG23'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_ZALOG23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_ZALOG23 
   (	DAT DATE, 
	USERID NUMBER, 
	ACCS NUMBER, 
	ACCZ NUMBER, 
	PAWN NUMBER, 
	S NUMBER, 
	PROC NUMBER, 
	SALL NUMBER, 
	ND NUMBER, 
	DAY_IMP NUMBER(*,0), 
	KV NUMBER(3,0), 
	GRP NUMBER, 
	ZPR NUMBER, 
	ZPRQ NUMBER, 
	S031 VARCHAR2(2), 
	PVZ NUMBER, 
	PVZQ NUMBER, 
	SQ NUMBER, 
	SALLQ NUMBER, 
	DAT_P DATE, 
	IRR0 NUMBER, 
	S_L NUMBER, 
	SQ_L NUMBER, 
	SUM_IMP NUMBER, 
	SUMQ_IMP NUMBER, 
	PV NUMBER, 
	K NUMBER, 
	PR_IMP NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RPB NUMBER, 
	KPZ NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_ZALOG23 ***
 exec bpa.alter_policies('TMP_REZ_ZALOG23');


COMMENT ON TABLE BARS.TMP_REZ_ZALOG23 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.KF IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.RPB IS 'Рівень покриття боргу';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.KPZ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.DAT IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.USERID IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.ACCS IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.ACCZ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.PAWN IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.S IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.PROC IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.SALL IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.ND IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.DAY_IMP IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.KV IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.GRP IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.ZPR IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.ZPRQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.S031 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.PVZ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.PVZQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.SQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.SALLQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.DAT_P IS 'Дата потока';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.IRR0 IS 'Эф. ставка';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.S_L IS 'Сума потока (ном.)';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.SQ_L IS 'Сума Залога ликвидная (экв.)';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.SUM_IMP IS 'Сума реализации залога (ном.)';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.SUMQ_IMP IS 'Сума реализации залога (экв.)';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.PV IS '';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.K IS 'Коэф. риска';
COMMENT ON COLUMN BARS.TMP_REZ_ZALOG23.PR_IMP IS '% затрат на реализацию';




PROMPT *** Create  constraint CC_TMPREZZALOG23_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_ZALOG23 MODIFY (KF CONSTRAINT CC_TMPREZZALOG23_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_TMP_REZ_ZALOG23 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TMP_REZ_ZALOG23 ON BARS.TMP_REZ_ZALOG23 (DAT, ACCS, PAWN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_TMP_REZ_ZALOG23 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_TMP_REZ_ZALOG23 ON BARS.TMP_REZ_ZALOG23 (DAT, ND, PAWN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_ZALOG23 ***
grant SELECT                                                                 on TMP_REZ_ZALOG23 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REZ_ZALOG23 to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_ZALOG23 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_ZALOG23 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_ZALOG23 to START1;
grant SELECT                                                                 on TMP_REZ_ZALOG23 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_ZALOG23.sql =========*** End *
PROMPT ===================================================================================== 
