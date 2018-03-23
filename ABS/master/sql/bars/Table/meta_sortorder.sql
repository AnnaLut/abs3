

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_SORTORDER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_SORTORDER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_SORTORDER'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_SORTORDER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_SORTORDER ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_SORTORDER 
   (	TABID NUMBER, 
	COLID NUMBER, 
	SORTORDER NUMBER, 
	SORTWAY CHAR(4), 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_SORTORDER ***
 exec bpa.alter_policies('META_SORTORDER');


COMMENT ON TABLE BARS.META_SORTORDER IS 'Метаописание. Сортировки';
COMMENT ON COLUMN BARS.META_SORTORDER.BRANCH IS '';
COMMENT ON COLUMN BARS.META_SORTORDER.TABID IS 'Идентификатор таблицы';
COMMENT ON COLUMN BARS.META_SORTORDER.COLID IS 'Идентификатор столбца';
COMMENT ON COLUMN BARS.META_SORTORDER.SORTORDER IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.META_SORTORDER.SORTWAY IS 'Направление сортировки';




PROMPT *** Create  constraint FK_METASORTORDER_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER ADD CONSTRAINT FK_METASORTORDER_METACOLUMNS FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASORTORDER_SORTWAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER ADD CONSTRAINT CC_METASORTORDER_SORTWAY CHECK (sortway in (''ASC'', ''DESC'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METASORTORDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER ADD CONSTRAINT PK_METASORTORDER PRIMARY KEY (TABID, COLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASORTORDER_SORTORDER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER MODIFY (SORTORDER CONSTRAINT CC_METASORTORDER_SORTORDER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASORTORDER_COLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER MODIFY (COLID CONSTRAINT CC_METASORTORDER_COLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASORTORDER_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER MODIFY (TABID CONSTRAINT CC_METASORTORDER_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METASORTORDER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METASORTORDER ON BARS.META_SORTORDER (TABID, COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_SORTORDER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_SORTORDER  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_SORTORDER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_SORTORDER  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_SORTORDER  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_SORTORDER.sql =========*** End **
PROMPT ===================================================================================== 
