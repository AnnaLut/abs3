

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_METALS_ACTION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_METALS_ACTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_METALS_ACTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS_ACTION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_METALS_ACTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_METALS_ACTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_METALS_ACTION 
   (	ID NUMBER, 
	NAME VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_METALS_ACTION ***
 exec bpa.alter_policies('BANK_METALS_ACTION');


COMMENT ON TABLE BARS.BANK_METALS_ACTION IS 'Знячення кодів зміни довідника "Архів курсів(ціни) купівлі/продажу драг.металів"';
COMMENT ON COLUMN BARS.BANK_METALS_ACTION.ID IS 'Код зміни';
COMMENT ON COLUMN BARS.BANK_METALS_ACTION.NAME IS 'Назва коду зміни';




PROMPT *** Create  constraint PK_BANKMETALSLACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS_ACTION ADD CONSTRAINT PK_BANKMETALSLACTION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALSLACTION_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS_ACTION MODIFY (ID CONSTRAINT CC_BANKMETALSLACTION_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMETALSLACTION_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS_ACTION MODIFY (NAME CONSTRAINT CC_BANKMETALSLACTION_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKMETALSLACTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKMETALSLACTION ON BARS.BANK_METALS_ACTION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_METALS_ACTION ***
grant SELECT                                                                 on BANK_METALS_ACTION to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS_ACTION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_METALS_ACTION to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_METALS_ACTION to START1;
grant SELECT                                                                 on BANK_METALS_ACTION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_METALS_ACTION.sql =========*** En
PROMPT ===================================================================================== 
