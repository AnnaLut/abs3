

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_MATCH_TT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_MATCH_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_MATCH_TT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_MATCH_TT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_MATCH_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_MATCH_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_MATCH_TT 
   (	CODE VARCHAR2(30), 
	DK NUMBER(1,0), 
	TT CHAR(3), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_MATCH_TT ***
 exec bpa.alter_policies('OW_MATCH_TT');


COMMENT ON TABLE BARS.OW_MATCH_TT IS 'OW. Справоник кодов транзакций для квитовки операций 3-й системы';
COMMENT ON COLUMN BARS.OW_MATCH_TT.CODE IS 'Код транзакции';
COMMENT ON COLUMN BARS.OW_MATCH_TT.DK IS 'Д/К';
COMMENT ON COLUMN BARS.OW_MATCH_TT.TT IS 'Код операции АБС';
COMMENT ON COLUMN BARS.OW_MATCH_TT.NAME IS 'Наименование транзакции';




PROMPT *** Create  constraint PK_OWMATCHTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MATCH_TT ADD CONSTRAINT PK_OWMATCHTT PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OWMATCHTT_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MATCH_TT ADD CONSTRAINT UK_OWMATCHTT_TT UNIQUE (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWMATCHTT_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MATCH_TT MODIFY (CODE CONSTRAINT CC_OWMATCHTT_CODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWMATCHTT_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_MATCH_TT MODIFY (DK CONSTRAINT CC_OWMATCHTT_DK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWMATCHTT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWMATCHTT ON BARS.OW_MATCH_TT (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OWMATCHTT_TT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OWMATCHTT_TT ON BARS.OW_MATCH_TT (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_MATCH_TT ***
grant SELECT                                                                 on OW_MATCH_TT     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_MATCH_TT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_MATCH_TT     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_MATCH_TT     to OW;
grant SELECT                                                                 on OW_MATCH_TT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_MATCH_TT.sql =========*** End *** =
PROMPT ===================================================================================== 
