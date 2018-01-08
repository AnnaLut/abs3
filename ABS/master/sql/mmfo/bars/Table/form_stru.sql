

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FORM_STRU.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FORM_STRU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FORM_STRU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FORM_STRU'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FORM_STRU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FORM_STRU ***
begin 
  execute immediate '
  CREATE TABLE BARS.FORM_STRU 
   (	KODF CHAR(2), 
	NATR NUMBER, 
	NAME VARCHAR2(70), 
	VAL VARCHAR2(70), 
	ISCODE CHAR(1), 
	A017 CHAR(1), 
	CODE_SORT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FORM_STRU ***
 exec bpa.alter_policies('FORM_STRU');


COMMENT ON TABLE BARS.FORM_STRU IS 'Структура показателей отчетов для НБУ';
COMMENT ON COLUMN BARS.FORM_STRU.KODF IS 'Код формы отчета';
COMMENT ON COLUMN BARS.FORM_STRU.NATR IS 'Номер атрибута';
COMMENT ON COLUMN BARS.FORM_STRU.NAME IS 'Наименование атрибута';
COMMENT ON COLUMN BARS.FORM_STRU.VAL IS 'Формула/Значение';
COMMENT ON COLUMN BARS.FORM_STRU.ISCODE IS 'Признак Часть ключа';
COMMENT ON COLUMN BARS.FORM_STRU.A017 IS 'Код схемы предоставления';
COMMENT ON COLUMN BARS.FORM_STRU.CODE_SORT IS 'N п/п для сортировки';




PROMPT *** Create  constraint XPK_FORM_STRU ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU ADD CONSTRAINT XPK_FORM_STRU PRIMARY KEY (KODF, NATR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008037 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008038 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU MODIFY (NATR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_FORM_STRU_A017 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU MODIFY (A017 CONSTRAINT CHK_FORM_STRU_A017 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FORM_STRU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FORM_STRU ON BARS.FORM_STRU (KODF, NATR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FORM_STRU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU       to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FORM_STRU       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FORM_STRU       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU       to FORM_STRU;
grant SELECT                                                                 on FORM_STRU       to RPBN002;
grant SELECT                                                                 on FORM_STRU       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FORM_STRU       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FORM_STRU       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FORM_STRU.sql =========*** End *** ===
PROMPT ===================================================================================== 
