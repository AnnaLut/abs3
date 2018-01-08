

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDO_DSW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDO_DSW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDO_DSW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SALDO_DSW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDO_DSW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDO_DSW ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDO_DSW 
   (	FDAT DATE, 
	RNK NUMBER, 
	KV NUMBER(*,0), 
	SHORT_S1 NUMBER, 
	SHORT_I1 NUMBER, 
	LONG_S1 NUMBER, 
	LONG_I1 NUMBER, 
	SHORT_S2 NUMBER, 
	SHORT_I2 NUMBER, 
	LONG_S2 NUMBER, 
	LONG_I2 NUMBER, 
	SHORT_S1_UAH NUMBER, 
	LONG_S1_UAH NUMBER, 
	SHORT_S2_UAH NUMBER, 
	LONG_S2_UAH NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDO_DSW ***
 exec bpa.alter_policies('SALDO_DSW');


COMMENT ON TABLE BARS.SALDO_DSW IS 'Таблиця СТАРТ-даних по ДЕПО-СВОПАМ';
COMMENT ON COLUMN BARS.SALDO_DSW.FDAT IS 'Дата зрізу';
COMMENT ON COLUMN BARS.SALDO_DSW.RNK IS 'Код.кл(заг=0)';
COMMENT ON COLUMN BARS.SALDO_DSW.KV IS 'Код.вал.';
COMMENT ON COLUMN BARS.SALDO_DSW.SHORT_S1 IS 'Розміщ:Залишок TOD+TOМ (корот)';
COMMENT ON COLUMN BARS.SALDO_DSW.SHORT_I1 IS 'Розміщ:Ср % ст.TOD+TOМ (корот)';
COMMENT ON COLUMN BARS.SALDO_DSW.LONG_S1 IS 'Розміщ:Залишок Строков (довг.)';
COMMENT ON COLUMN BARS.SALDO_DSW.LONG_I1 IS 'Розміщ:Ср % ст.Строков (довг.)';
COMMENT ON COLUMN BARS.SALDO_DSW.SHORT_S2 IS 'Залуч.:Залишок TOD+TOМ (корот)';
COMMENT ON COLUMN BARS.SALDO_DSW.SHORT_I2 IS 'Залуч.:Ср % ст.TOD+TOМ (корот)';
COMMENT ON COLUMN BARS.SALDO_DSW.LONG_S2 IS 'Залуч.:Залишок Строков (довг.)';
COMMENT ON COLUMN BARS.SALDO_DSW.LONG_I2 IS 'Залуч.:Ср % ст.Строков (довг.)';
COMMENT ON COLUMN BARS.SALDO_DSW.SHORT_S1_UAH IS 'Розміщ ГРН:Залишок TOD+TOМ (корот)';
COMMENT ON COLUMN BARS.SALDO_DSW.LONG_S1_UAH IS 'Залуч. ГРН:Залишок TOD+TOМ (корот)';
COMMENT ON COLUMN BARS.SALDO_DSW.SHORT_S2_UAH IS 'Розміщ ГРН:Залишок Строков (довг.)';
COMMENT ON COLUMN BARS.SALDO_DSW.LONG_S2_UAH IS 'Залуч. ГРН:Залишок Строков (довг.)';




PROMPT *** Create  constraint PK_SALDODSW ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_DSW ADD CONSTRAINT PK_SALDODSW PRIMARY KEY (FDAT, RNK, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SALDODSW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SALDODSW ON BARS.SALDO_DSW (FDAT, RNK, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDO_DSW ***
grant DELETE,SELECT,UPDATE                                                   on SALDO_DSW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDO_DSW       to BARS_DM;
grant DELETE,SELECT,UPDATE                                                   on SALDO_DSW       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDO_DSW.sql =========*** End *** ===
PROMPT ===================================================================================== 
