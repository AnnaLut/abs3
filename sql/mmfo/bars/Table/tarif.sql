

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF'', ''FILIAL'' , ''M'', ''E'', ''M'', ''E'');
               bpa.alter_policy_info(''TARIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF 
   (	KOD NUMBER(38,0), 
	KV NUMBER(3,0), 
	NAME VARCHAR2(75), 
	TAR NUMBER(24,0), 
	PR NUMBER(20,4), 
	SMIN NUMBER(24,0), 
	SMAX NUMBER(24,0), 
	TIP NUMBER(1,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	PDV NUMBER, 
	RAZOVA NUMBER, 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	KV_SMIN NUMBER(3,0), 
	KV_SMAX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF ***
 exec bpa.alter_policies('TARIF');


COMMENT ON TABLE BARS.TARIF IS 'Тарифы и комиссии';
COMMENT ON COLUMN BARS.TARIF.KOD IS 'Код тарифа/комиссии';
COMMENT ON COLUMN BARS.TARIF.KV IS 'Код базовой валюты тарифа';
COMMENT ON COLUMN BARS.TARIF.NAME IS 'Наименование тарифа/комиссии';
COMMENT ON COLUMN BARS.TARIF.TAR IS 'Сумма за 1 документ';
COMMENT ON COLUMN BARS.TARIF.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.TARIF.SMIN IS 'минимальная сумма тарифа';
COMMENT ON COLUMN BARS.TARIF.SMAX IS 'максимальная сумма тарифа';
COMMENT ON COLUMN BARS.TARIF.TIP IS 'Код вычисления суммы 0 - стандарт, 1 - средневзв.ост.за прошлый мес (+диапазон)';
COMMENT ON COLUMN BARS.TARIF.NBS IS 'Допустимый БС для сч дох по комиссии этого тарифа';
COMMENT ON COLUMN BARS.TARIF.OB22 IS 'Допустимый ob22 для сч дох по комиссии этого тарифа';
COMMENT ON COLUMN BARS.TARIF.KF IS '';
COMMENT ON COLUMN BARS.TARIF.PDV IS 'Признак ПДВ (1-з ПДВ)';
COMMENT ON COLUMN BARS.TARIF.RAZOVA IS 'Признак разової комiсiї (1-разова)';
COMMENT ON COLUMN BARS.TARIF.DAT_BEGIN IS 'Дата начала действия тарифа';
COMMENT ON COLUMN BARS.TARIF.DAT_END IS 'Дата окончания действия тарифа';
COMMENT ON COLUMN BARS.TARIF.KV_SMIN IS 'Валюта минимальной граничной суммы';
COMMENT ON COLUMN BARS.TARIF.KV_SMAX IS 'Валюта максиимальной граничной суммы';




PROMPT *** Create  constraint PK_TARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF ADD CONSTRAINT PK_TARIF PRIMARY KEY (KF, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF ADD CONSTRAINT CC_TARIF_TIP CHECK (tip in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF MODIFY (KOD CONSTRAINT CC_TARIF_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF MODIFY (KV CONSTRAINT CC_TARIF_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF MODIFY (KF CONSTRAINT CC_TARIF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_TAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF MODIFY (TAR CONSTRAINT CC_TARIF_TAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_PR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF MODIFY (PR CONSTRAINT CC_TARIF_PR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF MODIFY (TIP CONSTRAINT CC_TARIF_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIF_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF MODIFY (NAME CONSTRAINT CC_TARIF_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIF ON BARS.TARIF (KF, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF ***
grant SELECT                                                                 on TARIF           to BARSAQ;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TARIF           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TARIF           to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TARIF           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF           to TARIF;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF.sql =========*** End *** =======
PROMPT ===================================================================================== 
