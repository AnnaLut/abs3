

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DICT_EXCTXT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DICT_EXCTXT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DICT_EXCTXT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DICT_EXCTXT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DICT_EXCTXT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DICT_EXCTXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DICT_EXCTXT 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(500), 
	USE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DICT_EXCTXT ***
 exec bpa.alter_policies('DICT_EXCTXT');


COMMENT ON TABLE BARS.DICT_EXCTXT IS 'Довідник виключень при видачі готівкових коштів в іноземній валюті(пп.10 п.6 постанови №354)';
COMMENT ON COLUMN BARS.DICT_EXCTXT.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.DICT_EXCTXT.NAME IS 'Опис винятку';
COMMENT ON COLUMN BARS.DICT_EXCTXT.USE IS 'Использование в тегах 1-EXCTX, 2-EXCTN ';




PROMPT *** Create  constraint DICT_EXCTXT_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_EXCTXT ADD CONSTRAINT DICT_EXCTXT_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007602 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_EXCTXT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007603 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_EXCTXT MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DICT_EXCTXT_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DICT_EXCTXT_PK ON BARS.DICT_EXCTXT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DICT_EXCTXT ***
grant SELECT                                                                 on DICT_EXCTXT     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DICT_EXCTXT.sql =========*** End *** =
PROMPT ===================================================================================== 
