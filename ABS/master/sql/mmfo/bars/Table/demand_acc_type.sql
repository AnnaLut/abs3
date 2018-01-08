

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEMAND_ACC_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEMAND_ACC_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEMAND_ACC_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEMAND_ACC_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEMAND_ACC_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEMAND_ACC_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEMAND_ACC_TYPE 
   (	TYPE VARCHAR2(1), 
	CARD_TYPE NUMBER(1,0), 
	ACC_TYPE VARCHAR2(2), 
	NAME VARCHAR2(100), 
	TIP CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEMAND_ACC_TYPE ***
 exec bpa.alter_policies('DEMAND_ACC_TYPE');


COMMENT ON TABLE BARS.DEMAND_ACC_TYPE IS 'БПК. Типи рахунків';
COMMENT ON COLUMN BARS.DEMAND_ACC_TYPE.TYPE IS 'Тип';
COMMENT ON COLUMN BARS.DEMAND_ACC_TYPE.CARD_TYPE IS 'Карткова система';
COMMENT ON COLUMN BARS.DEMAND_ACC_TYPE.ACC_TYPE IS 'Тип рахунку';
COMMENT ON COLUMN BARS.DEMAND_ACC_TYPE.NAME IS 'Назва';
COMMENT ON COLUMN BARS.DEMAND_ACC_TYPE.TIP IS 'Тип рахунку (BARS)';




PROMPT *** Create  constraint CC_DEMANDACCTYPE_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_ACC_TYPE MODIFY (TYPE CONSTRAINT CC_DEMANDACCTYPE_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDACCTYPE_CARDTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_ACC_TYPE MODIFY (CARD_TYPE CONSTRAINT CC_DEMANDACCTYPE_CARDTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDACCTYPE_ACCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_ACC_TYPE MODIFY (ACC_TYPE CONSTRAINT CC_DEMANDACCTYPE_ACCTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEMANDACCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_ACC_TYPE ADD CONSTRAINT PK_DEMANDACCTYPE PRIMARY KEY (TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DEMANDACCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_ACC_TYPE ADD CONSTRAINT UK_DEMANDACCTYPE UNIQUE (TYPE, CARD_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEMANDACCTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEMANDACCTYPE ON BARS.DEMAND_ACC_TYPE (TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DEMANDACCTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DEMANDACCTYPE ON BARS.DEMAND_ACC_TYPE (TYPE, CARD_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEMAND_ACC_TYPE ***
grant SELECT                                                                 on DEMAND_ACC_TYPE to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on DEMAND_ACC_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on DEMAND_ACC_TYPE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_ACC_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEMAND_ACC_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_ACC_TYPE to OBPC;
grant SELECT                                                                 on DEMAND_ACC_TYPE to RPBN001;
grant SELECT                                                                 on DEMAND_ACC_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEMAND_ACC_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
