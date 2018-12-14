

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_EXTRNVAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_EXTRNVAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_EXTRNVAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''META_EXTRNVAL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_EXTRNVAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_EXTRNVAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_EXTRNVAL 
   (	TABID NUMBER(38,0), 
	COLID NUMBER(38,0), 
	SRCTABID NUMBER(38,0), 
	SRCCOLID NUMBER(38,0), 
	TAB_ALIAS VARCHAR2(5), 
	TAB_COND VARCHAR2(254), 
	SRC_COND VARCHAR2(254), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DYN_TABNAME VARCHAR2(30), 
	COL_DYN_TABNAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_EXTRNVAL ***
 exec bpa.alter_policies('META_EXTRNVAL');


COMMENT ON TABLE BARS.META_EXTRNVAL IS 'Метаописание. Описание связей таблиц';
COMMENT ON COLUMN BARS.META_EXTRNVAL.COL_DYN_TABNAME IS 'Динамически вычисляемое имя базовой таблицы значений';
COMMENT ON COLUMN BARS.META_EXTRNVAL.DYN_TABNAME IS '';
COMMENT ON COLUMN BARS.META_EXTRNVAL.TABID IS 'Идентификатор таблицы';
COMMENT ON COLUMN BARS.META_EXTRNVAL.COLID IS 'Идентификатор столбца';
COMMENT ON COLUMN BARS.META_EXTRNVAL.SRCTABID IS 'Идентификатор базовой таблицы';
COMMENT ON COLUMN BARS.META_EXTRNVAL.SRCCOLID IS 'Идентификатор базового столбца';
COMMENT ON COLUMN BARS.META_EXTRNVAL.TAB_ALIAS IS 'Синоним таблицы при формировании строки связи';
COMMENT ON COLUMN BARS.META_EXTRNVAL.TAB_COND IS 'Дополнительное условие для связки таблиц';
COMMENT ON COLUMN BARS.META_EXTRNVAL.SRC_COND IS 'SQL-условие на справочник';
COMMENT ON COLUMN BARS.META_EXTRNVAL.BRANCH IS 'Hierarchical Branch Code';




PROMPT *** Create  constraint PK_METAEXTRNVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_EXTRNVAL ADD CONSTRAINT PK_METAEXTRNVAL PRIMARY KEY (TABID, COLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAEXTRNVAL_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_EXTRNVAL MODIFY (TABID CONSTRAINT CC_METAEXTRNVAL_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAEXTRNVAL_COLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_EXTRNVAL MODIFY (COLID CONSTRAINT CC_METAEXTRNVAL_COLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAEXTRNVAL_SRCTABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_EXTRNVAL MODIFY (SRCTABID CONSTRAINT CC_METAEXTRNVAL_SRCTABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAEXTRNVAL_SRCCOLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_EXTRNVAL MODIFY (SRCCOLID CONSTRAINT CC_METAEXTRNVAL_SRCCOLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAEXTRNVAL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_EXTRNVAL MODIFY (BRANCH CONSTRAINT CC_METAEXTRNVAL_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAEXTRNVAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAEXTRNVAL ON BARS.META_EXTRNVAL (TABID, COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_EXTRNVAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_EXTRNVAL   to ABS_ADMIN;
grant SELECT                                                                 on META_EXTRNVAL   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_EXTRNVAL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_EXTRNVAL   to BARS_DM;
grant SELECT                                                                 on META_EXTRNVAL   to START1;
grant SELECT                                                                 on META_EXTRNVAL   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_EXTRNVAL   to WR_ALL_RIGHTS;
grant SELECT                                                                 on META_EXTRNVAL   to WR_FILTER;
grant SELECT                                                                 on META_EXTRNVAL   to WR_METATAB;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_EXTRNVAL.sql =========*** End ***
PROMPT ===================================================================================== 
