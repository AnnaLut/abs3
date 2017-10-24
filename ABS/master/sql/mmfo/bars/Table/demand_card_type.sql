

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEMAND_CARD_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEMAND_CARD_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEMAND_CARD_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEMAND_CARD_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEMAND_CARD_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEMAND_CARD_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEMAND_CARD_TYPE 
   (	CARD_TYPE NUMBER(1,0), 
	NAME VARCHAR2(100), 
	CARD_SYSTEM VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEMAND_CARD_TYPE ***
 exec bpa.alter_policies('DEMAND_CARD_TYPE');


COMMENT ON TABLE BARS.DEMAND_CARD_TYPE IS 'БПК. Карткові системи';
COMMENT ON COLUMN BARS.DEMAND_CARD_TYPE.CARD_TYPE IS 'Карткова система';
COMMENT ON COLUMN BARS.DEMAND_CARD_TYPE.NAME IS 'Назва';
COMMENT ON COLUMN BARS.DEMAND_CARD_TYPE.CARD_SYSTEM IS 'Платіжна система';




PROMPT *** Create  constraint PK_DEMANDCARDTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_CARD_TYPE ADD CONSTRAINT PK_DEMANDCARDTYPE PRIMARY KEY (CARD_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDCARDTYPE_CARDSYSTEM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_CARD_TYPE ADD CONSTRAINT CC_DEMANDCARDTYPE_CARDSYSTEM CHECK (card_system in (''MC'',''VISA'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDCARDTYPE_CARDTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_CARD_TYPE MODIFY (CARD_TYPE CONSTRAINT CC_DEMANDCARDTYPE_CARDTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDCARDTYPE_CARDSYST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_CARD_TYPE MODIFY (CARD_SYSTEM CONSTRAINT CC_DEMANDCARDTYPE_CARDSYST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEMANDCARDTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEMANDCARDTYPE ON BARS.DEMAND_CARD_TYPE (CARD_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEMAND_CARD_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_CARD_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEMAND_CARD_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_CARD_TYPE to OBPC;
grant SELECT                                                                 on DEMAND_CARD_TYPE to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEMAND_CARD_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
