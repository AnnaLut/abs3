

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_ACTIONTBL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_ACTIONTBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_ACTIONTBL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_ACTIONTBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_ACTIONTBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_ACTIONTBL 
   (	TABID NUMBER(38,0), 
	ACTION_CODE VARCHAR2(30), 
	ACTION_PROC VARCHAR2(254), 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_ACTIONTBL ***
 exec bpa.alter_policies('META_ACTIONTBL');


COMMENT ON TABLE BARS.META_ACTIONTBL IS 'Метаопис...';
COMMENT ON COLUMN BARS.META_ACTIONTBL.TABID IS 'Код таблицы';
COMMENT ON COLUMN BARS.META_ACTIONTBL.ACTION_CODE IS 'Код действия';
COMMENT ON COLUMN BARS.META_ACTIONTBL.ACTION_PROC IS 'Выполняемая процедура';
COMMENT ON COLUMN BARS.META_ACTIONTBL.BRANCH IS 'Hierarchical Branch Code';





PROMPT *** Create  constraint FK_METAACTIONTBL_METAACTCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL ADD CONSTRAINT FK_METAACTIONTBL_METAACTCODES FOREIGN KEY (ACTION_CODE)
	  REFERENCES BARS.META_ACTIONCODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAACTIONTBL_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL ADD CONSTRAINT FK_METAACTIONTBL_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METAACTIONTBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL ADD CONSTRAINT PK_METAACTIONTBL PRIMARY KEY (TABID, ACTION_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAACTIONTBL_ACTIONCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL MODIFY (ACTION_CODE CONSTRAINT CC_METAACTIONTBL_ACTIONCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAACTIONTBL_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL MODIFY (TABID CONSTRAINT CC_METAACTIONTBL_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAACTIONTBL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAACTIONTBL ON BARS.META_ACTIONTBL (TABID, ACTION_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_ACTIONTBL ***
grant SELECT                                                                 on META_ACTIONTBL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_ACTIONTBL  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_ACTIONTBL  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to META_ACTIONTBL ***

  CREATE OR REPLACE PUBLIC SYNONYM META_ACTIONTBL FOR BARS.META_ACTIONTBL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_ACTIONTBL.sql =========*** End **
PROMPT ===================================================================================== 
