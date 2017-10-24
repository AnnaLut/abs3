

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_FORMS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_FORMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_FORMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_FORMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_FORMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_FORMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_FORMS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	HTML CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (HTML) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_FORMS ***
 exec bpa.alter_policies('WCS_FORMS');


COMMENT ON TABLE BARS.WCS_FORMS IS 'Статические HTML формы';
COMMENT ON COLUMN BARS.WCS_FORMS.ID IS 'Идентификатор формы';
COMMENT ON COLUMN BARS.WCS_FORMS.NAME IS 'Наименование формы';
COMMENT ON COLUMN BARS.WCS_FORMS.HTML IS 'HTML текст формы';




PROMPT *** Create  constraint PK_WCSFORMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_FORMS ADD CONSTRAINT PK_WCSFORMS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSFORMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSFORMS ON BARS.WCS_FORMS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_FORMS ***
grant SELECT                                                                 on WCS_FORMS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_FORMS       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_FORMS.sql =========*** End *** ===
PROMPT ===================================================================================== 
