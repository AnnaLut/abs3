

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MODEL_OPT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MODEL_OPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MODEL_OPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_MODEL_OPT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_MODEL_OPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MODEL_OPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MODEL_OPT 
   (	MT NUMBER(3,0), 
	NUM NUMBER(5,0), 
	OPT CHAR(1), 
	TRANS CHAR(1), 
	SUBNAME VARCHAR2(35), 
	 CONSTRAINT PK_SWMODELOPT PRIMARY KEY (MT, NUM, OPT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MODEL_OPT ***
 exec bpa.alter_policies('SW_MODEL_OPT');


COMMENT ON TABLE BARS.SW_MODEL_OPT IS 'Допустимые опции в шаблонах сообщений';
COMMENT ON COLUMN BARS.SW_MODEL_OPT.MT IS 'Тип сообщения';
COMMENT ON COLUMN BARS.SW_MODEL_OPT.NUM IS 'Порядковый номер поля';
COMMENT ON COLUMN BARS.SW_MODEL_OPT.OPT IS 'Опция (если опции нет, то присутствует сивол "-")';
COMMENT ON COLUMN BARS.SW_MODEL_OPT.TRANS IS 'Признак использования транслитерации для поля';
COMMENT ON COLUMN BARS.SW_MODEL_OPT.SUBNAME IS 'Наименование опции поля';




PROMPT *** Create  constraint CC_SWMODELOPT_MT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL_OPT MODIFY (MT CONSTRAINT CC_SWMODELOPT_MT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODELOPT_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL_OPT MODIFY (NUM CONSTRAINT CC_SWMODELOPT_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODELOPT_OPT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL_OPT MODIFY (OPT CONSTRAINT CC_SWMODELOPT_OPT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWMODELOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL_OPT ADD CONSTRAINT PK_SWMODELOPT PRIMARY KEY (MT, NUM, OPT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODELOPT_TRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL_OPT ADD CONSTRAINT CC_SWMODELOPT_TRANS CHECK (trans in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMODELOPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMODELOPT ON BARS.SW_MODEL_OPT (MT, NUM, OPT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MODEL_OPT ***
grant SELECT                                                                 on SW_MODEL_OPT    to BARS013;
grant SELECT                                                                 on SW_MODEL_OPT    to BARSREADER_ROLE;
grant SELECT                                                                 on SW_MODEL_OPT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_MODEL_OPT    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MODEL_OPT    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_MODEL_OPT ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_MODEL_OPT FOR BARS.SW_MODEL_OPT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MODEL_OPT.sql =========*** End *** 
PROMPT ===================================================================================== 
