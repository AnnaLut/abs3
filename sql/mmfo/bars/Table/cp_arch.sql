

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ARCH.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_ARCH'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_ARCH'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ARCH 
   (	REF NUMBER(*,0), 
	ID NUMBER(*,0), 
	DAT_UG DATE, 
	DAT_OPL DATE, 
	DAT_ROZ DATE, 
	ACC NUMBER(*,0), 
	SUMB NUMBER, 
	N NUMBER, 
	D NUMBER, 
	P NUMBER, 
	R NUMBER, 
	S NUMBER, 
	Z NUMBER, 
	STR_REF VARCHAR2(200), 
	OP NUMBER(*,0), 
	STIKET LONG RAW, 
	SN NUMBER, 
	REF_REPO NUMBER(*,0), 
	VD NUMBER, 
	VP NUMBER, 
	REF_MAIN NUMBER(*,0), 
	T NUMBER, 
	NOM NUMBER, 
	TQ NUMBER, 
	DAT_SN DATE, 
	SN_1 NUMBER, 
	DAT_SN_1 DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ARCH ***
 exec bpa.alter_policies('CP_ARCH');


COMMENT ON TABLE BARS.CP_ARCH IS '';
COMMENT ON COLUMN BARS.CP_ARCH.REF IS 'Реф.операцiї, зафiксованої в архiвi';
COMMENT ON COLUMN BARS.CP_ARCH.ID IS 'Код ЦП';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_UG IS 'Дата угоди';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_OPL IS 'Дата оплати';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_ROZ IS 'Дата розрахунку';
COMMENT ON COLUMN BARS.CP_ARCH.ACC IS 'acc - рах-ку ном?налу';
COMMENT ON COLUMN BARS.CP_ARCH.SUMB IS 'Сума угоди';
COMMENT ON COLUMN BARS.CP_ARCH.N IS 'Сума Номiналу угоди';
COMMENT ON COLUMN BARS.CP_ARCH.D IS 'Сума Дисконту угоди';
COMMENT ON COLUMN BARS.CP_ARCH.P IS 'Сума Премiї по угодi';
COMMENT ON COLUMN BARS.CP_ARCH.R IS 'Сума Купону угоди';
COMMENT ON COLUMN BARS.CP_ARCH.S IS 'Сума переоцiнки угоди';
COMMENT ON COLUMN BARS.CP_ARCH.Z IS 'Сума резерву';
COMMENT ON COLUMN BARS.CP_ARCH.STR_REF IS 'Список референсiв угоди';
COMMENT ON COLUMN BARS.CP_ARCH.OP IS 'Код операцiї';
COMMENT ON COLUMN BARS.CP_ARCH.STIKET IS 'Тiкет угоди';
COMMENT ON COLUMN BARS.CP_ARCH.SN IS 'Сума переоц?нки форвард-угоди';
COMMENT ON COLUMN BARS.CP_ARCH.REF_REPO IS 'Реф-с початкової угоди';
COMMENT ON COLUMN BARS.CP_ARCH.VD IS 'Сума вiртуального дисконту';
COMMENT ON COLUMN BARS.CP_ARCH.VP IS 'Сума вiртуальної премiї';
COMMENT ON COLUMN BARS.CP_ARCH.REF_MAIN IS 'Реф.первинної угоди ';
COMMENT ON COLUMN BARS.CP_ARCH.T IS 'Торговий результат угоди продажу';
COMMENT ON COLUMN BARS.CP_ARCH.NOM IS 'Дiючий номiнал 1 шт на час операцiї, зафiксованої в архiвi';
COMMENT ON COLUMN BARS.CP_ARCH.TQ IS 'Торговий результат угоди продажу (грн. екв)';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_SN IS 'Дата попер. переоцінки';
COMMENT ON COLUMN BARS.CP_ARCH.SN_1 IS 'Сума попер. переоцінки - 1';
COMMENT ON COLUMN BARS.CP_ARCH.DAT_SN_1 IS 'Дата попер. переоцінки - 1';
COMMENT ON COLUMN BARS.CP_ARCH.KF IS '';




PROMPT *** Create  constraint XPK_CP_ARCH_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ARCH ADD CONSTRAINT XPK_CP_ARCH_REF PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007851 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ARCH MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ARCH MODIFY (KF CONSTRAINT CC_CPARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ARCH_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ARCH_REF ON BARS.CP_ARCH (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ARCH ***
grant SELECT                                                                 on CP_ARCH         to BARSREADER_ROLE;
grant SELECT                                                                 on CP_ARCH         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ARCH         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ARCH         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ARCH         to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ARCH         to START1;
grant SELECT                                                                 on CP_ARCH         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ARCH.sql =========*** End *** =====
PROMPT ===================================================================================== 
