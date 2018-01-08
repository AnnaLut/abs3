

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TT_IN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TT_IN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TT_IN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TT_IN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TT_IN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TT_IN ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TT_IN 
   (	TT CHAR(3), 
	TT_V CHAR(3), 
	ORD NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TT_IN ***
 exec bpa.alter_policies('OBPC_TT_IN');


COMMENT ON TABLE BARS.OBPC_TT_IN IS 'ПЦ. Мультивалютные операции для оплаты операций ПЦ';
COMMENT ON COLUMN BARS.OBPC_TT_IN.TT IS 'Код операции';
COMMENT ON COLUMN BARS.OBPC_TT_IN.TT_V IS 'Код мультивалютной операции';
COMMENT ON COLUMN BARS.OBPC_TT_IN.ORD IS 'Порядок оплаты операций';




PROMPT *** Create  constraint PK_OBPCTTIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TT_IN ADD CONSTRAINT PK_OBPCTTIN PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTTIN_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TT_IN ADD CONSTRAINT FK_OBPCTTIN_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTTIN_TTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TT_IN ADD CONSTRAINT FK_OBPCTTIN_TTS2 FOREIGN KEY (TT_V)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTTIN_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TT_IN MODIFY (TT CONSTRAINT CC_OBPCTTIN_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTTIN_TTV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TT_IN MODIFY (TT_V CONSTRAINT CC_OBPCTTIN_TTV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTTIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTTIN ON BARS.OBPC_TT_IN (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TT_IN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TT_IN      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TT_IN      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TT_IN      to OBPC;



PROMPT *** Create SYNONYM  to OBPC_TT_IN ***

  CREATE OR REPLACE PUBLIC SYNONYM OBPC_TT_IN FOR BARS.OBPC_TT_IN;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TT_IN.sql =========*** End *** ==
PROMPT ===================================================================================== 
