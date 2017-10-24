

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SH_TARIF_SCALE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SH_TARIF_SCALE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SH_TARIF_SCALE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SH_TARIF_SCALE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SH_TARIF_SCALE'', ''WHOLE'' , null, ''null'', ''null'', ''null'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SH_TARIF_SCALE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SH_TARIF_SCALE 
   (	IDS NUMBER, 
	KOD NUMBER(22,0), 
	SUM_LIMIT NUMBER(22,0), 
	SUM_TARIF NUMBER(22,0), 
	PR NUMBER(20,4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SMIN NUMBER(24,0), 
	SMAX NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SH_TARIF_SCALE ***
 exec bpa.alter_policies('SH_TARIF_SCALE');


COMMENT ON TABLE BARS.SH_TARIF_SCALE IS 'Тарифы клиентов';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.IDS IS 'Код схемы тарифов';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.KOD IS 'Код тарифа';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.SUM_LIMIT IS 'Верхняя граница диапазона суммы для расчета комиссии';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.SUM_TARIF IS 'Сумма за 1 документ';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.KF IS '';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.SMIN IS 'минимальная сумма тарифа';
COMMENT ON COLUMN BARS.SH_TARIF_SCALE.SMAX IS 'максимальная сумма тарифа';




PROMPT *** Create  constraint PK_SHTARIFSCALE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_SCALE ADD CONSTRAINT PK_SHTARIFSCALE PRIMARY KEY (KF, IDS, KOD, SUM_LIMIT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFSCALE_IDS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_SCALE MODIFY (IDS CONSTRAINT CC_SHTARIFSCALE_IDS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFSCALE_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_SCALE MODIFY (KOD CONSTRAINT CC_SHTARIFSCALE_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFSCALE_SUMLIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_SCALE MODIFY (SUM_LIMIT CONSTRAINT CC_SHTARIFSCALE_SUMLIMIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SHTARIFSCALE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SH_TARIF_SCALE MODIFY (KF CONSTRAINT CC_SHTARIFSCALE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SHTARIFSCALE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SHTARIFSCALE ON BARS.SH_TARIF_SCALE (KF, IDS, KOD, SUM_LIMIT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SH_TARIF_SCALE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SH_TARIF_SCALE  to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SH_TARIF_SCALE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SH_TARIF_SCALE  to BARS_DM;
grant SELECT                                                                 on SH_TARIF_SCALE  to START1;
grant FLASHBACK,SELECT                                                       on SH_TARIF_SCALE  to WR_REFREAD;



PROMPT *** Create SYNONYM  to SH_TARIF_SCALE ***

  CREATE OR REPLACE PUBLIC SYNONYM SH_TARIF_SCALE FOR BARS.SH_TARIF_SCALE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SH_TARIF_SCALE.sql =========*** End **
PROMPT ===================================================================================== 
