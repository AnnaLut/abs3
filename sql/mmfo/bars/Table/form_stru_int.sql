

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FORM_STRU_INT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FORM_STRU_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FORM_STRU_INT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FORM_STRU_INT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FORM_STRU_INT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FORM_STRU_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FORM_STRU_INT 
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




PROMPT *** ALTER_POLICIES to FORM_STRU_INT ***
 exec bpa.alter_policies('FORM_STRU_INT');


COMMENT ON TABLE BARS.FORM_STRU_INT IS 'Структура показателей внутренней отчетности СБ';
COMMENT ON COLUMN BARS.FORM_STRU_INT.KODF IS 'Код формы отчета';
COMMENT ON COLUMN BARS.FORM_STRU_INT.NATR IS 'Номер атрибута';
COMMENT ON COLUMN BARS.FORM_STRU_INT.NAME IS 'Наименование атрибута';
COMMENT ON COLUMN BARS.FORM_STRU_INT.VAL IS 'Формула/Значение';
COMMENT ON COLUMN BARS.FORM_STRU_INT.ISCODE IS 'Признак Часть ключа';
COMMENT ON COLUMN BARS.FORM_STRU_INT.A017 IS 'Код схемы предоставления';
COMMENT ON COLUMN BARS.FORM_STRU_INT.CODE_SORT IS 'N п/п для сортировки';




PROMPT *** Create  constraint XPK_FORM_STRU_INT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_INT ADD CONSTRAINT XPK_FORM_STRU_INT PRIMARY KEY (KODF, NATR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006587 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_INT MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006588 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_INT MODIFY (NATR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_FORM_STRU_INT_A017 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FORM_STRU_INT MODIFY (A017 CONSTRAINT CHK_FORM_STRU_INT_A017 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FORM_STRU_INT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FORM_STRU_INT ON BARS.FORM_STRU_INT (KODF, NATR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FORM_STRU_INT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU_INT   to ABS_ADMIN;
grant SELECT                                                                 on FORM_STRU_INT   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FORM_STRU_INT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FORM_STRU_INT   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU_INT   to FORM_STRU_INT;
grant SELECT                                                                 on FORM_STRU_INT   to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on FORM_STRU_INT   to SALGL;
grant SELECT                                                                 on FORM_STRU_INT   to START1;
grant SELECT                                                                 on FORM_STRU_INT   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FORM_STRU_INT   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FORM_STRU_INT   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FORM_STRU_INT.sql =========*** End ***
PROMPT ===================================================================================== 
