

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_VALUABLES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_VALUABLES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_VALUABLES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_VALUABLES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_VALUABLES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_VALUABLES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_VALUABLES 
   (	DEAL_ID NUMBER(38,0), 
	NAME VARCHAR2(48), 
	DESCR VARCHAR2(96), 
	WEIGHT NUMBER(38,0), 
	PART_CNT NUMBER(12,0), 
	PART_DISC_WEIG NUMBER(38,0), 
	VALUE_WEIGHT NUMBER(38,0), 
	TARIFF_PRICE NUMBER(38,0), 
	EXPERT_PRICE NUMBER(38,0), 
	ESTIMATE_PRICE NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_VALUABLES ***
 exec bpa.alter_policies('GRT_VALUABLES');


COMMENT ON TABLE BARS.GRT_VALUABLES IS 'Информация  о залоговых ценностях';
COMMENT ON COLUMN BARS.GRT_VALUABLES.DEAL_ID IS 'Идентификатор договора залога';
COMMENT ON COLUMN BARS.GRT_VALUABLES.NAME IS 'Наименование залоговой ценности';
COMMENT ON COLUMN BARS.GRT_VALUABLES.DESCR IS 'Описание залоговой ценности';
COMMENT ON COLUMN BARS.GRT_VALUABLES.WEIGHT IS 'Общий вес залоговой ценности';
COMMENT ON COLUMN BARS.GRT_VALUABLES.PART_CNT IS 'Общее кол-во частей';
COMMENT ON COLUMN BARS.GRT_VALUABLES.PART_DISC_WEIG IS 'Скидка на вес вставок';
COMMENT ON COLUMN BARS.GRT_VALUABLES.VALUE_WEIGHT IS 'Вес драгоценного металла';
COMMENT ON COLUMN BARS.GRT_VALUABLES.TARIFF_PRICE IS 'Цена по прейскуранту';
COMMENT ON COLUMN BARS.GRT_VALUABLES.EXPERT_PRICE IS 'Сумма оценки экспертом';
COMMENT ON COLUMN BARS.GRT_VALUABLES.ESTIMATE_PRICE IS 'Ориентировочная рыночная стоимость';




PROMPT *** Create  constraint PK_GRTVALUABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VALUABLES ADD CONSTRAINT PK_GRTVALUABLES PRIMARY KEY (DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VALUABLES_DEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VALUABLES ADD CONSTRAINT FK_VALUABLES_DEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVALUABLES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VALUABLES MODIFY (NAME CONSTRAINT CC_GRTVALUABLES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVALUABLES_DESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VALUABLES MODIFY (DESCR CONSTRAINT CC_GRTVALUABLES_DESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVALUABLES_WEIGHT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VALUABLES MODIFY (WEIGHT CONSTRAINT CC_GRTVALUABLES_WEIGHT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVALUABLES_TARIFFPRICE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VALUABLES MODIFY (TARIFF_PRICE CONSTRAINT CC_GRTVALUABLES_TARIFFPRICE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVALUABLES_EXPERTPRICE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VALUABLES MODIFY (EXPERT_PRICE CONSTRAINT CC_GRTVALUABLES_EXPERTPRICE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTVALUABLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTVALUABLES ON BARS.GRT_VALUABLES (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_VALUABLES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_VALUABLES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_VALUABLES   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_VALUABLES   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_VALUABLES.sql =========*** End ***
PROMPT ===================================================================================== 
