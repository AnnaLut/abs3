

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_RAZ_KOMIS_TARIF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_RAZ_KOMIS_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_RAZ_KOMIS_TARIF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_RAZ_KOMIS_TARIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_RAZ_KOMIS_TARIF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_RAZ_KOMIS_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_RAZ_KOMIS_TARIF 
   (	KOD NUMBER(*,0), 
	KV NUMBER(3,0), 
	FDAT DATE, 
	NAME VARCHAR2(50), 
	TAR NUMBER(24,4), 
	PR NUMBER(20,4), 
	TIP NUMBER(1,0), 
	SMIN NUMBER(24,4), 
	SMAX NUMBER(24,4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_RAZ_KOMIS_TARIF ***
 exec bpa.alter_policies('CC_RAZ_KOMIS_TARIF');


COMMENT ON TABLE BARS.CC_RAZ_KOMIS_TARIF IS 'Тарифы и комиссии по КД';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.KOD IS 'Код тарифа/комиссии';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.KV IS 'Код базовой валюты тарифа';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.FDAT IS 'Код базовой валюты тарифа';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.NAME IS 'Наименование тарифа/комиссии';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.TAR IS 'Сумма за 1 документ';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.TIP IS 'Код вычисления суммы 0 - стандарт, 1 - средневзв.ост.за прошлый мес (+диапазон)';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.SMIN IS 'минимальная сумма тарифа';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.SMAX IS 'максимальная сумма тарифа';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TARIF.KF IS '';




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF MODIFY (KOD CONSTRAINT CC_RAZ_KOMIS_TARIF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF MODIFY (KV CONSTRAINT CC_RAZ_KOMIS_TARIF_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF MODIFY (FDAT CONSTRAINT CC_RAZ_KOMIS_TARIF_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_TAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF MODIFY (TAR CONSTRAINT CC_RAZ_KOMIS_TARIF_TAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_PR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF MODIFY (PR CONSTRAINT CC_RAZ_KOMIS_TARIF_PR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF MODIFY (TIP CONSTRAINT CC_RAZ_KOMIS_TARIF_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TARIF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TARIF MODIFY (KF CONSTRAINT CC_RAZ_KOMIS_TARIF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_RAZ_KOMIS_TARIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_RAZ_KOMIS_TARIF ON BARS.CC_RAZ_KOMIS_TARIF (KF, KOD, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_RAZ_KOMIS_TARIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RAZ_KOMIS_TARIF to ABS_ADMIN;
grant SELECT                                                                 on CC_RAZ_KOMIS_TARIF to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_RAZ_KOMIS_TARIF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_RAZ_KOMIS_TARIF to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RAZ_KOMIS_TARIF to RCC_DEAL;
grant SELECT                                                                 on CC_RAZ_KOMIS_TARIF to UPLD;
grant FLASHBACK,SELECT                                                       on CC_RAZ_KOMIS_TARIF to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_RAZ_KOMIS_TARIF.sql =========*** En
PROMPT ===================================================================================== 
