

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_INCOME.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_INCOME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_INCOME'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_INCOME'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_INCOME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_INCOME ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_INCOME 
   (	ATTR_INCOME NUMBER(3,0), 
	NAME_INCOME VARCHAR2(800), 
	SHORT_NAME VARCHAR2(165), 
	DATE_BEGIN DATE, 
	DATE_END DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_INCOME ***
 exec bpa.alter_policies('ATTRIBUTE_INCOME');


COMMENT ON TABLE BARS.ATTRIBUTE_INCOME IS 'Довідник ознак доходів 2011';
COMMENT ON COLUMN BARS.ATTRIBUTE_INCOME.ATTR_INCOME IS 'Ознака доходу';
COMMENT ON COLUMN BARS.ATTRIBUTE_INCOME.NAME_INCOME IS 'Найменування';
COMMENT ON COLUMN BARS.ATTRIBUTE_INCOME.SHORT_NAME IS 'Коротке найменування';
COMMENT ON COLUMN BARS.ATTRIBUTE_INCOME.DATE_BEGIN IS 'Строк дії з';
COMMENT ON COLUMN BARS.ATTRIBUTE_INCOME.DATE_END IS 'Строк дії по';




PROMPT *** Create  constraint PK_ATTRIBUTEINCOME ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_INCOME ADD CONSTRAINT PK_ATTRIBUTEINCOME PRIMARY KEY (ATTR_INCOME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTEINCOME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTEINCOME ON BARS.ATTRIBUTE_INCOME (ATTR_INCOME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_INCOME ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ATTRIBUTE_INCOME to ABS_ADMIN;
grant SELECT                                                                 on ATTRIBUTE_INCOME to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ATTRIBUTE_INCOME to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ATTRIBUTE_INCOME to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ATTRIBUTE_INCOME to DPT_ADMIN;
grant SELECT                                                                 on ATTRIBUTE_INCOME to START1;
grant SELECT                                                                 on ATTRIBUTE_INCOME to UPLD;
grant FLASHBACK,SELECT                                                       on ATTRIBUTE_INCOME to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_INCOME.sql =========*** End 
PROMPT ===================================================================================== 
