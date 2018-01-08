

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_MERCH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_MERCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_MERCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_MERCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_MERCH'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_MERCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_MERCH 
   (	MERCH VARCHAR2(7), 
	KV NUMBER(22,0), 
	CARD_SYSTEM VARCHAR2(10), 
	TRANSIT_ACC NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_MERCH ***
 exec bpa.alter_policies('OBPC_MERCH');


COMMENT ON TABLE BARS.OBPC_MERCH IS 'БПК. Довідник банкоматів MERCHANT';
COMMENT ON COLUMN BARS.OBPC_MERCH.MERCH IS 'MERCH';
COMMENT ON COLUMN BARS.OBPC_MERCH.KV IS 'Валюта';
COMMENT ON COLUMN BARS.OBPC_MERCH.CARD_SYSTEM IS 'Платіжна система';
COMMENT ON COLUMN BARS.OBPC_MERCH.TRANSIT_ACC IS 'Транзитний рахунок';




PROMPT *** Create  constraint CC_OBPCMERCH_MERCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_MERCH MODIFY (MERCH CONSTRAINT CC_OBPCMERCH_MERCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCMERCH_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_MERCH MODIFY (KV CONSTRAINT CC_OBPCMERCH_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCMERCH_CARDSYSTEM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_MERCH MODIFY (CARD_SYSTEM CONSTRAINT CC_OBPCMERCH_CARDSYSTEM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBPCMERCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_MERCH ADD CONSTRAINT PK_OBPCMERCH PRIMARY KEY (MERCH, CARD_SYSTEM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCMERCH_CARDSYSTEM ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_MERCH ADD CONSTRAINT CC_OBPCMERCH_CARDSYSTEM CHECK (card_system in (''MC'',''VISA'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCMERCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCMERCH ON BARS.OBPC_MERCH (MERCH, CARD_SYSTEM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_MERCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_MERCH      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_MERCH      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_MERCH      to OBPC;



PROMPT *** Create SYNONYM  to OBPC_MERCH ***

  CREATE OR REPLACE PUBLIC SYNONYM OBPC_MERCH FOR BARS.OBPC_MERCH;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_MERCH.sql =========*** End *** ==
PROMPT ===================================================================================== 
