

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_PUBLIC_RELS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_PUBLIC_RELS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_PUBLIC_RELS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_PUBLIC_RELS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_PUBLIC_RELS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_PUBLIC_RELS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_PUBLIC_RELS 
   (	ID NUMBER(6,0), 
	NAME VARCHAR2(256), 
	TERMIN DATE, 
	PRIZV VARCHAR2(128), 
	FNAME VARCHAR2(128), 
	BIRTH DATE DEFAULT NULL, 
	BIO CLOB, 
	TERMINMOD DATE, 
	FULLNAME VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (BIO) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_PUBLIC_RELS ***
 exec bpa.alter_policies('FINMON_PUBLIC_RELS');


COMMENT ON TABLE BARS.FINMON_PUBLIC_RELS IS 'Перелік публічних діячів';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.ID IS 'Унікальний код';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.NAME IS 'Прізвище, ім’я та по батькові повністю';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.TERMIN IS 'Дата втрати ознаки публічності (ПЕП)АБО фактична дата звільнення з посади  у форматі dd.mm.yyyy, значення 11.11.2222, якщо особа перебуває на посаді';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.PRIZV IS 'Прізвище (утворене з поля name)';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.FNAME IS 'Ім’я та по батькові (утворене з поля name)';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.BIRTH IS 'Дата народження (у форматі dd.mm.yyyy (може бути порожнім))';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.BIO IS 'Біографія (інформація про місце роботи та посаду, можливі відомості про членів родини, місце навчання та кар’єру – для аналізу пов’язаних осіб)';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.TERMINMOD IS 'Дата редагування поля(у форматі dd.mm.yyyy)';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_RELS.FULLNAME IS 'Служебное поля для ПК, индекса при поиске';




PROMPT *** Create  index I_FMN_PUBLIC_RELS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_FMN_PUBLIC_RELS ON BARS.FINMON_PUBLIC_RELS (FULLNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_PUBLIC_RELS ***
grant SELECT                                                                 on FINMON_PUBLIC_RELS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_PUBLIC_RELS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_PUBLIC_RELS to BARS_DM;
grant SELECT                                                                 on FINMON_PUBLIC_RELS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_PUBLIC_RELS.sql =========*** En
PROMPT ===================================================================================== 
