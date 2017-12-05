

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_BROWSETBL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_BROWSETBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_BROWSETBL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_BROWSETBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_BROWSETBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_BROWSETBL 
   (	HOSTTABID NUMBER(38,0), 
	ADDTABID NUMBER(38,0), 
	ADDTABALIAS CHAR(2), 
	HOSTCOLKEYID NUMBER(38,0), 
	ADDCOLKEYID NUMBER(38,0), 
	VAR_COLID NUMBER(38,0), 
	COND_TAG VARCHAR2(60), 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_BROWSETBL ***
 exec bpa.alter_policies('META_BROWSETBL');


COMMENT ON TABLE BARS.META_BROWSETBL IS 'Метаописание. Описание полей условия для динамического запроса';
COMMENT ON COLUMN BARS.META_BROWSETBL.HOSTTABID IS 'Идентификатор базовой таблицы';
COMMENT ON COLUMN BARS.META_BROWSETBL.ADDTABID IS 'Идентификатор связанной таблицы';
COMMENT ON COLUMN BARS.META_BROWSETBL.ADDTABALIAS IS 'Синоним связанной таблицы';
COMMENT ON COLUMN BARS.META_BROWSETBL.HOSTCOLKEYID IS 'Идентификатор столбца ключа базовой таблицы';
COMMENT ON COLUMN BARS.META_BROWSETBL.ADDCOLKEYID IS 'Идентификатор столбца ключа связанной таблицы';
COMMENT ON COLUMN BARS.META_BROWSETBL.VAR_COLID IS 'Идентификатор столбца поля в базовой таблице';
COMMENT ON COLUMN BARS.META_BROWSETBL.COND_TAG IS 'Наименование поля';
COMMENT ON COLUMN BARS.META_BROWSETBL.BRANCH IS 'Hierarchical Branch Code';




PROMPT *** Create  constraint FK_METABROWSETBL_METACOLUMNS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT FK_METABROWSETBL_METACOLUMNS3 FOREIGN KEY (ADDTABID, VAR_COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METABROWSETBL_METACOLUMNS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT FK_METABROWSETBL_METACOLUMNS2 FOREIGN KEY (ADDTABID, ADDCOLKEYID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METABROWSETBL_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT FK_METABROWSETBL_METACOLUMNS FOREIGN KEY (HOSTTABID, HOSTCOLKEYID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METABROWSETBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT PK_METABROWSETBL PRIMARY KEY (HOSTTABID, HOSTCOLKEYID, ADDTABID, ADDCOLKEYID, VAR_COLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METABROWSETBL_CONDTAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL MODIFY (COND_TAG CONSTRAINT CC_METABROWSETBL_CONDTAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METABROWSETBL_VARCOLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL MODIFY (VAR_COLID CONSTRAINT CC_METABROWSETBL_VARCOLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METABROWSETBL_ADDCOLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL MODIFY (ADDCOLKEYID CONSTRAINT CC_METABROWSETBL_ADDCOLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METABROWSETBL_HOSTCOLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL MODIFY (HOSTCOLKEYID CONSTRAINT CC_METABROWSETBL_HOSTCOLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METABROWSETBL_ADDTABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL MODIFY (ADDTABID CONSTRAINT CC_METABROWSETBL_ADDTABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METABROWSETBL_HOSTTABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL MODIFY (HOSTTABID CONSTRAINT CC_METABROWSETBL_HOSTTABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METABROWSETBL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METABROWSETBL ON BARS.META_BROWSETBL (HOSTTABID, HOSTCOLKEYID, ADDTABID, ADDCOLKEYID, VAR_COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_BROWSETBL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_BROWSETBL  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_BROWSETBL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_BROWSETBL  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_BROWSETBL  to WR_ALL_RIGHTS;
grant SELECT                                                                 on META_BROWSETBL  to WR_FILTER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_BROWSETBL.sql =========*** End **
PROMPT ===================================================================================== 
