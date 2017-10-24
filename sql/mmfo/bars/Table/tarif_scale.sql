

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF_SCALE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF_SCALE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF_SCALE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TARIF_SCALE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TARIF_SCALE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF_SCALE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF_SCALE 
   (	KOD NUMBER(38,0), 
	SUM_LIMIT NUMBER(24,0), 
	SUM_TARIF NUMBER(24,0), 
	PR NUMBER(20,4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SMIN NUMBER(24,0), 
	SMAX NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF_SCALE ***
 exec bpa.alter_policies('TARIF_SCALE');


COMMENT ON TABLE BARS.TARIF_SCALE IS 'Шкала тарифов и комиссий';
COMMENT ON COLUMN BARS.TARIF_SCALE.KOD IS 'Код тарифа (из справочника TARIF)';
COMMENT ON COLUMN BARS.TARIF_SCALE.SUM_LIMIT IS 'Верхняя граница диапазона суммы для расчета комиссии';
COMMENT ON COLUMN BARS.TARIF_SCALE.SUM_TARIF IS 'Сумма за 1 документ';
COMMENT ON COLUMN BARS.TARIF_SCALE.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.TARIF_SCALE.KF IS '';
COMMENT ON COLUMN BARS.TARIF_SCALE.SMIN IS 'минимальная сумма тарифа';
COMMENT ON COLUMN BARS.TARIF_SCALE.SMAX IS 'максимальная сумма тарифа';




PROMPT *** Create  constraint CC_TARIFSCALE_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE MODIFY (KOD CONSTRAINT CC_TARIFSCALE_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCALE_SUMLIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE MODIFY (SUM_LIMIT CONSTRAINT CC_TARIFSCALE_SUMLIMIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCALE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCALE MODIFY (KF CONSTRAINT CC_TARIFSCALE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIFSCALE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIFSCALE ON BARS.TARIF_SCALE (KF, KOD, SUM_LIMIT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF_SCALE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_SCALE     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TARIF_SCALE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TARIF_SCALE     to BARS_DM;
grant SELECT                                                                 on TARIF_SCALE     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_SCALE     to TARIF;
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_SCALE     to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TARIF_SCALE     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on TARIF_SCALE     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF_SCALE.sql =========*** End *** =
PROMPT ===================================================================================== 
