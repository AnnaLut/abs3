

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_TBLCOLOR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_TBLCOLOR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_TBLCOLOR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_TBLCOLOR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_TBLCOLOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_TBLCOLOR 
   (	TABID NUMBER(38,0), 
	ORD NUMBER(10,0), 
	COLID NUMBER(38,0), 
	CONDITION VARCHAR2(254), 
	COLOR_INDEX NUMBER(1,0), 
	COLOR_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_TBLCOLOR ***
 exec bpa.alter_policies('META_TBLCOLOR');


COMMENT ON TABLE BARS.META_TBLCOLOR IS 'Метаопис...';
COMMENT ON COLUMN BARS.META_TBLCOLOR.TABID IS 'Код таблицы';
COMMENT ON COLUMN BARS.META_TBLCOLOR.ORD IS 'Порядок проверки';
COMMENT ON COLUMN BARS.META_TBLCOLOR.COLID IS 'Код колонки таблицы (пусто-красим всю строку)';
COMMENT ON COLUMN BARS.META_TBLCOLOR.CONDITION IS 'Условие';
COMMENT ON COLUMN BARS.META_TBLCOLOR.COLOR_INDEX IS '1-Text, 2-Back';
COMMENT ON COLUMN BARS.META_TBLCOLOR.COLOR_NAME IS 'Цвет (константа из Centura)';




PROMPT *** Create  constraint FK_METATBLCOLOR_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR ADD CONSTRAINT FK_METATBLCOLOR_METACOLUMNS FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METATBLCOLOR_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR ADD CONSTRAINT FK_METATBLCOLOR_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METATBLCOLOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR ADD CONSTRAINT PK_METATBLCOLOR PRIMARY KEY (TABID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATBLCOLOR_COLORINDEXS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR ADD CONSTRAINT CC_METATBLCOLOR_COLORINDEXS CHECK (color_index in (1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATBLCOLOR_COLOR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR MODIFY (COLOR_NAME CONSTRAINT CC_METATBLCOLOR_COLOR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATBLCOLOR_COLOR_INDEX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR MODIFY (COLOR_INDEX CONSTRAINT CC_METATBLCOLOR_COLOR_INDEX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATBLCOLOR_CONDITION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR MODIFY (CONDITION CONSTRAINT CC_METATBLCOLOR_CONDITION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATBLCOLOR_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR MODIFY (ORD CONSTRAINT CC_METATBLCOLOR_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATBLCOLOR_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TBLCOLOR MODIFY (TABID CONSTRAINT CC_METATBLCOLOR_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METATBLCOLOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METATBLCOLOR ON BARS.META_TBLCOLOR (TABID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_TBLCOLOR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_TBLCOLOR   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_TBLCOLOR   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_TBLCOLOR.sql =========*** End ***
PROMPT ===================================================================================== 
