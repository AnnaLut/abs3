

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_MORTGAGE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_MORTGAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_MORTGAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_MORTGAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_MORTGAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_MORTGAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_MORTGAGE 
   (	DEAL_ID NUMBER(38,0), 
	ROOMS_CNT NUMBER(4,0), 
	APP_NUM NUMBER(10,0), 
	TOTAL_SPACE NUMBER(38,0), 
	LIVING_SPACE NUMBER(38,0), 
	FLOOR NUMBER(3,0), 
	ADDR VARCHAR2(128), 
	BUIDING_TYPE VARCHAR2(32), 
	BUILDING_NUM NUMBER(38,0), 
	BUILDING_LIT VARCHAR2(3), 
	CITY VARCHAR2(32), 
	CITY_DISTR VARCHAR2(32), 
	LIVING_DISTR VARCHAR2(32), 
	MICRO_DISTR VARCHAR2(32), 
	AREA_NUM VARCHAR2(12), 
	BUILD_SECT_COUNT VARCHAR2(3), 
	ADD_GRT_ADDR VARCHAR2(64), 
	MORT_DOC_NUM VARCHAR2(12), 
	MORT_DOC_DATE VARCHAR2(12), 
	OWNSHIP_REG_NUM VARCHAR2(24), 
	OWNSHIP_REG_CHECKSUM VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_MORTGAGE ***
 exec bpa.alter_policies('GRT_MORTGAGE');


COMMENT ON TABLE BARS.GRT_MORTGAGE IS 'Ипотека';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.DEAL_ID IS 'Идентификатор договора залога';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.ROOMS_CNT IS 'Кол-во комнат';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.APP_NUM IS 'Номер квартиры';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.TOTAL_SPACE IS 'Общая площадь';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.LIVING_SPACE IS 'Жилая площадь';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.FLOOR IS 'Этаж';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.ADDR IS 'Адрес';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.BUIDING_TYPE IS 'Тип жилого дома (вручную)';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.BUILDING_NUM IS 'Номер дома';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.BUILDING_LIT IS 'Литера на плане';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.CITY IS 'Город';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.CITY_DISTR IS 'Район';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.LIVING_DISTR IS 'Массив';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.MICRO_DISTR IS 'Микрорайон';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.AREA_NUM IS 'Номер участка';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.BUILD_SECT_COUNT IS 'Кол-во секций';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.ADD_GRT_ADDR IS 'Адрес обеспечения';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.MORT_DOC_NUM IS 'Номер договора участия в фонде финансирования строительства';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.MORT_DOC_DATE IS 'Дата договора участия в фонде финансирования строительства';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.OWNSHIP_REG_NUM IS 'Регистрационный номер в гос. реестре прав собственности';
COMMENT ON COLUMN BARS.GRT_MORTGAGE.OWNSHIP_REG_CHECKSUM IS 'Контрольная сумма в гос. реестре прав собственности';




PROMPT *** Create  constraint PK_GRTMORTGAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE ADD CONSTRAINT PK_GRTMORTGAGE PRIMARY KEY (DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MORTGAGE_DEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE ADD CONSTRAINT FK_MORTGAGE_DEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_BUILDNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (BUILDING_NUM CONSTRAINT CC_GRTMORTGAGE_BUILDNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_BUILDTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (BUIDING_TYPE CONSTRAINT CC_GRTMORTGAGE_BUILDTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_ADDR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (ADDR CONSTRAINT CC_GRTMORTGAGE_ADDR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_FLOOR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (FLOOR CONSTRAINT CC_GRTMORTGAGE_FLOOR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_LIVINGSPACE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (LIVING_SPACE CONSTRAINT CC_GRTMORTGAGE_LIVINGSPACE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_TOTASPACE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (TOTAL_SPACE CONSTRAINT CC_GRTMORTGAGE_TOTASPACE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_APPNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (APP_NUM CONSTRAINT CC_GRTMORTGAGE_APPNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTGAGE_ROOMSCNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE MODIFY (ROOMS_CNT CONSTRAINT CC_GRTMORTGAGE_ROOMSCNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTMORTGAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTMORTGAGE ON BARS.GRT_MORTGAGE (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_MORTGAGE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_MORTGAGE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_MORTGAGE    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_MORTGAGE    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_MORTGAGE.sql =========*** End *** 
PROMPT ===================================================================================== 
