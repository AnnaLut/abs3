begin 
 execute immediate 'drop table FINMON_PEP_RELS';
exception when others then if (sqlcode = -955) then null; else raise; end if;   
end; 
/
/*
Назва тегу    Назва елементу    Тип    Коментар
id          унікальний код    N(6)    
idcode      ІНН    N(10)    
name        прізвище, ім’я та по батькові ФО або назва ЮО    C(300)    
pep         Пов’язана з ЮО публічна особа    C(300)    
bdate       дата народження        у форматі dd.mm.yyyy
doct        тип документу    N(2)    1 – паспорт
docs        серія документу    С(10)    
docn        номер документу    N(10)    
category    категорія ПЕП    C(300)    
edate       дата втрати ознаки ПЕП    D(10)    фактична дата звільнення з посади, у форматі dd.mm.yyyy 
branch      код філії банка (МФО)    N(6)    
permit      Дозвіл на встановлення ділових відносин    N(1)    1 - так, 0 - ні
remdoc      зауваження до пакета документів    N(1)    1 - так, 0 - ні
comment     Примітки    C(300)    
ptype       тип особи    N(1)    1 - ФО, 2 - ЮО, 3 - ФОП
pres        резидентність    N(1)    1 - так, 0 - ні
mdate       Дата останніх змін в даних    D(10)    у форматі dd.mm.yyyy
*/

begin
  bpa.alter_policy_info('FINMON_PEP_RELS', 'WHOLE', null, null, null, null); 
  bpa.alter_policy_info('FINMON_PEP_RELS', 'FILIAL', null, null, null, null);
end;
/

begin 
execute immediate 'CREATE TABLE BARS.FINMON_PEP_RELS
                    ( ID        NUMBER(6),                     
                      IDCODE    varchar2(10),
                      NAME      VARCHAR2(300),
                      PEP       VARCHAR2(300),
                      BDATE     DATE,
                      DOCT      NUMBER(2),
                      DOCS      VARCHAR2(10),
                      DOCN      NUMBER(10),
                      CATEGORY  VARCHAR2(300),
                      EDATE     DATE,
                      BRANCH    VARCHAR2(6),
                      PERMIT    NUMBER(1), CONSTRAINT CK_PERMIT CHECK (PERMIT IN (0,1)),
                      REMDOC    NUMBER(1), CONSTRAINT CK_REMDOC CHECK (REMDOC IN (0,1)),
                      COMMENTS  VARCHAR2(300),
                      PTYPE     NUMBER(1), CONSTRAINT CK_PTYPE CHECK (PTYPE IN (1,2,3)),
                      PRES      NUMBER(1), CONSTRAINT CK_PRES CHECK (PRES IN (0,1)),
                      MDATE     DATE)
                    TABLESPACE BRSBIGD';
exception when others then if (sqlcode = -955) then null;else raise; end if; 
end;
/
begin
 execute immediate 'alter table FINMON_PEP_RELS add DOCALL varchar2(50)';
exception when others then if (sqlcode = -955) then null; end if;
end;
/
begin
 execute immediate 'ALTER TABLE FINMON_PEP_RELS ADD PRIMARY KEY (IDCODE) ';
exception when others then if (sqlcode = -955) then null; end if;
end;
/
begin
 execute immediate 'CREATE UNIQUE INDEX IDX_DOC_FPEPRELS ON FINMON_PEP_RELS (IDCODE) TABLESPACE BRSBIGI';
exception when others then if (sqlcode = -955) then null; end if;
end;
/


COMMENT ON TABLE FINMON_PEP_RELS IS 'Перелік ПЕП КЛІЄНТИ';
COMMENT ON COLUMN FINMON_PEP_RELS.ID         IS 'Унікальний код';
COMMENT ON COLUMN FINMON_PEP_RELS.IDCODE     IS 'ІНН';    
COMMENT ON COLUMN FINMON_PEP_RELS.NAME       IS 'Прізвище, ім’я та по батькові ФО або назва ЮО';    
COMMENT ON COLUMN FINMON_PEP_RELS.PEP        IS 'Пов’язана з ЮО публічна особа';
COMMENT ON COLUMN FINMON_PEP_RELS.BDATE      IS 'Дата народження';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCT       IS 'Тип документу';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCS       IS 'Серія документу';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCN       IS 'Номер документу';
COMMENT ON COLUMN FINMON_PEP_RELS.CATEGORY   IS 'Категорія ПЕП';
COMMENT ON COLUMN FINMON_PEP_RELS.EDATE      IS 'Дата втрати ознаки ПЕП';
COMMENT ON COLUMN FINMON_PEP_RELS.BRANCH     IS 'Код філії банка (МФО)';
COMMENT ON COLUMN FINMON_PEP_RELS.PERMIT     IS 'Дозвіл на встановлення ділових відносин';
COMMENT ON COLUMN FINMON_PEP_RELS.REMDOC     IS 'Зауваження до пакета документів';
COMMENT ON COLUMN FINMON_PEP_RELS.COMMENTS   IS 'Примітки';
COMMENT ON COLUMN FINMON_PEP_RELS.PTYPE      IS 'Тип особи (1-ФО,2-ЮО,3-ФОП)';
COMMENT ON COLUMN FINMON_PEP_RELS.PRES       IS 'Резидентність';
COMMENT ON COLUMN FINMON_PEP_RELS.MDATE      IS 'Дата останніх змін в даних';
COMMENT ON COLUMN FINMON_PEP_RELS.DOCALL     IS 'Служебное поля для ПК, индекса при поиске';
/
GRANT SELECT,INSERT,UPDATE,DELETE ON FINMON_PEP_RELS TO BARS_ACCESS_DEFROLE;
/  