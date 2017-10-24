

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_CURRENCY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_TYPES_CURRENCY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_TYPES_CURRENCY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES_CURRENCY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES_CURRENCY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_TYPES_CURRENCY ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_TYPES_CURRENCY 
   (	TYPE_ID NUMBER(38,0), 
	CURR_ID NUMBER(3,0), 
	 CONSTRAINT PK_DPUTYPESCURRENCY PRIMARY KEY (TYPE_ID, CURR_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_TYPES_CURRENCY ***
 exec bpa.alter_policies('DPU_TYPES_CURRENCY');


COMMENT ON TABLE BARS.DPU_TYPES_CURRENCY IS 'Валюти доступні депозитному продукту ЮО';
COMMENT ON COLUMN BARS.DPU_TYPES_CURRENCY.TYPE_ID IS 'Код продукту';
COMMENT ON COLUMN BARS.DPU_TYPES_CURRENCY.CURR_ID IS 'Код валюти';




PROMPT *** Create  constraint CC_DPUTYPESCURRENCY_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_CURRENCY MODIFY (TYPE_ID CONSTRAINT CC_DPUTYPESCURRENCY_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESCURRENCY_CURRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_CURRENCY MODIFY (CURR_ID CONSTRAINT CC_DPUTYPESCURRENCY_CURRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUTYPESCURRENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_CURRENCY ADD CONSTRAINT PK_DPUTYPESCURRENCY PRIMARY KEY (TYPE_ID, CURR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUTYPESCURRENCY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUTYPESCURRENCY ON BARS.DPU_TYPES_CURRENCY (TYPE_ID, CURR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_TYPES_CURRENCY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_CURRENCY to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_CURRENCY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_TYPES_CURRENCY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_TYPES_CURRENCY to DPT_ADMIN;
grant SELECT                                                                 on DPU_TYPES_CURRENCY to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_CURRENCY.sql =========*** En
PROMPT ===================================================================================== 
