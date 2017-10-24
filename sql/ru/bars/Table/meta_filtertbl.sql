

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_FILTERTBL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_FILTERTBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_FILTERTBL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_FILTERTBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_FILTERTBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_FILTERTBL 
   (	TABID NUMBER(38,0), 
	COLID NUMBER(38,0), 
	FILTER_TABID NUMBER(38,0), 
	FILTER_CODE VARCHAR2(30), 
	FLAG_INS NUMBER(1,0) DEFAULT 0, 
	FLAG_DEL NUMBER(1,0) DEFAULT 0, 
	FLAG_UPD NUMBER(1,0) DEFAULT 0, 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_FILTERTBL ***
 exec bpa.alter_policies('META_FILTERTBL');


COMMENT ON TABLE BARS.META_FILTERTBL IS 'Метаопис...';
COMMENT ON COLUMN BARS.META_FILTERTBL.FLAG_INS IS '';
COMMENT ON COLUMN BARS.META_FILTERTBL.FLAG_DEL IS '';
COMMENT ON COLUMN BARS.META_FILTERTBL.FLAG_UPD IS '';
COMMENT ON COLUMN BARS.META_FILTERTBL.TABID IS 'Код таблицы';
COMMENT ON COLUMN BARS.META_FILTERTBL.COLID IS 'Код поля';
COMMENT ON COLUMN BARS.META_FILTERTBL.FILTER_TABID IS 'Код фильтруемой таблицы';
COMMENT ON COLUMN BARS.META_FILTERTBL.FILTER_CODE IS 'Код фильтра';
COMMENT ON COLUMN BARS.META_FILTERTBL.BRANCH IS '';




PROMPT *** Create  constraint FK_METAFILTERTBL_METAFLTCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT FK_METAFILTERTBL_METAFLTCODES FOREIGN KEY (FILTER_CODE)
	  REFERENCES BARS.META_FILTERCODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFILTERTBL_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT FK_METAFILTERTBL_METATABLES FOREIGN KEY (FILTER_TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFILTERTBL_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT FK_METAFILTERTBL_METACOLUMNS FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METAFILTERTBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT PK_METAFILTERTBL PRIMARY KEY (TABID, COLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLTCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL MODIFY (FILTER_CODE CONSTRAINT CC_METAFILTERTBL_FLTCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLTTABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL MODIFY (FILTER_TABID CONSTRAINT CC_METAFILTERTBL_FLTTABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_COLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL MODIFY (COLID CONSTRAINT CC_METAFILTERTBL_COLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL MODIFY (TABID CONSTRAINT CC_METAFILTERTBL_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLAGUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT CC_METAFILTERTBL_FLAGUPD CHECK (flag_upd in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLAGDEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT CC_METAFILTERTBL_FLAGDEL CHECK (flag_del in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLAGINS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT CC_METAFILTERTBL_FLAGINS CHECK (flag_ins in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLAGUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT CC_METAFILTERTBL_FLAGUPD_NN CHECK (flag_upd is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLAGDEL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT CC_METAFILTERTBL_FLAGDEL_NN CHECK (flag_del is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERTBL_FLAGINS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT CC_METAFILTERTBL_FLAGINS_NN CHECK (flag_ins is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAFILTERTBL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAFILTERTBL ON BARS.META_FILTERTBL (TABID, COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_FILTERTBL ***
grant SELECT                                                                 on META_FILTERTBL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_FILTERTBL  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_FILTERTBL  to WR_ALL_RIGHTS;
grant SELECT                                                                 on META_FILTERTBL  to WR_METATAB;



PROMPT *** Create SYNONYM  to META_FILTERTBL ***

  CREATE OR REPLACE PUBLIC SYNONYM META_FILTERTBL FOR BARS.META_FILTERTBL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_FILTERTBL.sql =========*** End **
PROMPT ===================================================================================== 
