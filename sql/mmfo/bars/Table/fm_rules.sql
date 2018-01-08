

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_RULES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_RULES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_RULES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_RULES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FM_RULES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_RULES ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_RULES 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100), 
	V_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_RULES ***
 exec bpa.alter_policies('FM_RULES');


COMMENT ON TABLE BARS.FM_RULES IS 'ФМ. Правила';
COMMENT ON COLUMN BARS.FM_RULES.ID IS 'Код правила';
COMMENT ON COLUMN BARS.FM_RULES.NAME IS 'Название правила';
COMMENT ON COLUMN BARS.FM_RULES.V_NAME IS 'Представление';




PROMPT *** Create  constraint CC_FMRULES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_RULES ADD CONSTRAINT CC_FMRULES_NAME_NN CHECK (name is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FMRULES ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_RULES ADD CONSTRAINT PK_FMRULES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMRULES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMRULES ON BARS.FM_RULES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_RULES ***
grant SELECT                                                                 on FM_RULES        to BARSREADER_ROLE;
grant SELECT                                                                 on FM_RULES        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_RULES        to BARS_DM;
grant SELECT                                                                 on FM_RULES        to FINMON01;
grant SELECT                                                                 on FM_RULES        to START1;
grant SELECT                                                                 on FM_RULES        to UPLD;



PROMPT *** Create SYNONYM  to FM_RULES ***

  CREATE OR REPLACE PUBLIC SYNONYM FM_RULES FOR BARS.FM_RULES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_RULES.sql =========*** End *** ====
PROMPT ===================================================================================== 
