

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SWI_OPER_LIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SWI_OPER_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SWI_OPER_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SWI_OPER_LIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SWI_OPER_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SWI_OPER_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SWI_OPER_LIST 
   (	OPER_ID NUMBER(2,0), 
	TT CHAR(3), 
	DESCRIPTION VARCHAR2(256), 
	NAZN_TEMPLATE VARCHAR2(160), 
	TT_980 CHAR(3), 
	TT_PA CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SWI_OPER_LIST ***
 exec bpa.alter_policies('SWI_OPER_LIST');


COMMENT ON TABLE BARS.SWI_OPER_LIST IS 'Список основних операцій по SWI';
COMMENT ON COLUMN BARS.SWI_OPER_LIST.OPER_ID IS 'Код';
COMMENT ON COLUMN BARS.SWI_OPER_LIST.TT IS 'Основна операція в АБС (tt)';
COMMENT ON COLUMN BARS.SWI_OPER_LIST.DESCRIPTION IS 'Опис операції';
COMMENT ON COLUMN BARS.SWI_OPER_LIST.NAZN_TEMPLATE IS 'Шаблон призначення платежу';
COMMENT ON COLUMN BARS.SWI_OPER_LIST.TT_980 IS 'Код операции для платежа в гривне';
COMMENT ON COLUMN BARS.SWI_OPER_LIST.TT_PA IS 'Код операции для платежа по выплате на счет';




PROMPT *** Create  constraint PK_SWIOPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_OPER_LIST ADD CONSTRAINT PK_SWIOPERLIST PRIMARY KEY (OPER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIOPERLIST_OPERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_OPER_LIST MODIFY (OPER_ID CONSTRAINT CC_SWIOPERLIST_OPERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIOPERLIST_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_OPER_LIST MODIFY (TT CONSTRAINT CC_SWIOPERLIST_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIOPERLIST_DESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_OPER_LIST MODIFY (DESCRIPTION CONSTRAINT CC_SWIOPERLIST_DESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIOPERLIST_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_OPER_LIST MODIFY (NAZN_TEMPLATE CONSTRAINT CC_SWIOPERLIST_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWIOPERLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWIOPERLIST ON BARS.SWI_OPER_LIST (OPER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SWI_OPER_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_OPER_LIST   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SWI_OPER_LIST   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_OPER_LIST   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SWI_OPER_LIST.sql =========*** End ***
PROMPT ===================================================================================== 
