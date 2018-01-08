

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_INCOME_TAX_RATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_INCOME_TAX_RATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_INCOME_TAX_RATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INCOME_TAX_RATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INCOME_TAX_RATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_INCOME_TAX_RATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_INCOME_TAX_RATE 
   (	ATTR_INCOME NUMBER(3,0), 
	TAX_RATE NUMBER(4,2), 
	RESIDENT NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_INCOME_TAX_RATE ***
 exec bpa.alter_policies('DPT_INCOME_TAX_RATE');


COMMENT ON TABLE BARS.DPT_INCOME_TAX_RATE IS 'Довідник ознак доходів 2011';
COMMENT ON COLUMN BARS.DPT_INCOME_TAX_RATE.ATTR_INCOME IS 'Ознака доходу';
COMMENT ON COLUMN BARS.DPT_INCOME_TAX_RATE.TAX_RATE IS 'Ставка податку на прибуток';
COMMENT ON COLUMN BARS.DPT_INCOME_TAX_RATE.RESIDENT IS 'Резидентність спадкодавця';




PROMPT *** Create  constraint FK_DPTINCOMETAXRATE_ATTRINCOME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INCOME_TAX_RATE ADD CONSTRAINT FK_DPTINCOMETAXRATE_ATTRINCOME FOREIGN KEY (ATTR_INCOME)
	  REFERENCES BARS.ATTRIBUTE_INCOME (ATTR_INCOME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTINCOMETAXRATE_ATTRINCOME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INCOME_TAX_RATE MODIFY (ATTR_INCOME CONSTRAINT DPTINCOMETAXRATE_ATTRINCOME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTINCOMETAXRATE_TAXRATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INCOME_TAX_RATE MODIFY (TAX_RATE CONSTRAINT DPTINCOMETAXRATE_TAXRATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTINCOMETAXRATE_RESIDENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INCOME_TAX_RATE MODIFY (RESIDENT CONSTRAINT DPTINCOMETAXRATE_RESIDENT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_INCOME_TAX_RATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INCOME_TAX_RATE to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_INCOME_TAX_RATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_INCOME_TAX_RATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_INCOME_TAX_RATE to DPT_ADMIN;
grant SELECT                                                                 on DPT_INCOME_TAX_RATE to START1;
grant FLASHBACK,SELECT                                                       on DPT_INCOME_TAX_RATE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_INCOME_TAX_RATE.sql =========*** E
PROMPT ===================================================================================== 
