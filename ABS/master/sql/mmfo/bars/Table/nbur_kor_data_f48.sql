

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F48.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_DATA_F48 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_DATA_F48'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F48'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F48'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_DATA_F48 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_DATA_F48 
   (	ID NUMBER, 
	KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
	VAR_10 VARCHAR2(135), 
	VAR_15 VARCHAR2(10), 
	VAR_16 VARCHAR2(3), 
	VAR_17 VARCHAR2(5), 
	VAR_20 VARCHAR2(135), 
	VAR_30 VARCHAR2(135), 
	VAR_40 NUMBER(16,0), 
	VAR_51 NUMBER(16,0), 
	VAR_60 NUMBER(9,4), 
	VAR_70 NUMBER(9,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_KOR_DATA_F48 ***
 exec bpa.alter_policies('NBUR_KOR_DATA_F48');


COMMENT ON TABLE BARS.NBUR_KOR_DATA_F48 IS 'Довідник "Дані про афілійовані особи банку (для #95)"';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.ID IS 'Ідентифікатор учасника';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.KF IS 'Код філії';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_10 IS 'Повне найменування ЮО або ПІБ ФО';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_15 IS 'Ідентифікаційний код (номер) учасника в ЄДРПОУ чи в ДЕФО';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_16 IS 'Код країни учасника';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_17 IS 'Код виду економічної діяльності учасника банку';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_20 IS 'Адреса ЮО або адреса постійного місця проживання ФО';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_30 IS 'Платіжні реквізити ЮО, паспортні дані ФО';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_40 IS 'Кількість акцій (часток) у статутному капіталі учасника';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_51 IS 'Заявлена вартість акцій (часток) учасника';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_60 IS 'Відсоток у статутному капіталі (пряма участь) учасника';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F48.VAR_70 IS 'Відсоток у статутному капіталі (опосередкована участь) учасника';




PROMPT *** Create  constraint CC_KORDATAF48_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F48 MODIFY (ID CONSTRAINT CC_KORDATAF48_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KORDATAF48 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F48 ADD CONSTRAINT PK_KORDATAF48 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF48_V10_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F48 MODIFY (VAR_10 CONSTRAINT CC_KORDATAF48_V10_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF48_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F48 MODIFY (KF CONSTRAINT CC_KORDATAF48_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KORDATAF48 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KORDATAF48 ON BARS.NBUR_KOR_DATA_F48 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_KOR_DATA_F48 ***
grant SELECT                                                                 on NBUR_KOR_DATA_F48 to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBUR_KOR_DATA_F48 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_KOR_DATA_F48 to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F48.sql =========*** End
PROMPT ===================================================================================== 
