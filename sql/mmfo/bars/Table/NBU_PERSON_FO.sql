BEGIN
    bpa.alter_policy_info('NBU_PERSON_FO', 'FILIAL', 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_PERSON_FO', 'WHOLE', null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table NBU_PERSON_FO
    (
        rnk             NUMBER(38),
        lastname        VARCHAR2(100),
        firstname       VARCHAR2(100),
        middlename      VARCHAR2(100),
        isrez           VARCHAR2(5),
        inn             VARCHAR2(20),
        birthday        DATE,
        countryCodNerez VARCHAR2(3),
        k060            VARCHAR2(2),
        status          VARCHAR2(30),
		status_message  VARCHAR2(4000), 
        kf              VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_PERSON_FO_304665 values (304665),
       partition NBU_PERSON_FO_338545 values (338545),
       partition NBU_PERSON_FO_305482 values (305482),
       partition NBU_PERSON_FO_356334 values (356334),
       partition NBU_PERSON_FO_326461 values (326461),
       partition NBU_PERSON_FO_354507 values (354507),
       partition NBU_PERSON_FO_322669 values (322669),
       partition NBU_PERSON_FO_323475 values (323475),
       partition NBU_PERSON_FO_353553 values (353553),
       partition NBU_PERSON_FO_312356 values (312356),
       partition NBU_PERSON_FO_302076 values (302076),
       partition NBU_PERSON_FO_328845 values (328845),
       partition NBU_PERSON_FO_335106 values (335106),
       partition NBU_PERSON_FO_311647 values (311647),
       partition NBU_PERSON_FO_352457 values (352457),
       partition NBU_PERSON_FO_333368 values (333368),
       partition NBU_PERSON_FO_325796 values (325796),
       partition NBU_PERSON_FO_313957 values (313957),
       partition NBU_PERSON_FO_336503 values (336503),
       partition NBU_PERSON_FO_303398 values (303398),
       partition NBU_PERSON_FO_331467 values (331467),
       partition NBU_PERSON_FO_351823 values (351823),
       partition NBU_PERSON_FO_337568 values (337568),
       partition NBU_PERSON_FO_315784 values (315784),
       partition NBU_PERSON_FO_324805 values (324805),
       partition NBU_PERSON_FO_300465 values (300465)
    )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_PERSON_FO IS 'Боржник ФО';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.lastname IS 'Прізвище';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.firstname IS 'Ім’я';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.middlename IS 'По батькові';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.isrez IS 'Ознака особи';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.inn IS 'Ідентифікаційний код';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.birthday IS 'Дата народження';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_PERSON_FO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_PERSON_FO');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UIX_NBU_PERSON_FO on NBU_PERSON_FO (kf, RNK) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
end;
/

begin
	execute immediate'alter table NBU_PERSON_FO add k020 VARCHAR2(20)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table NBU_PERSON_FO add codDocum number(2)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table NBU_PERSON_FO add education number(1)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table NBU_PERSON_FO add typew number(1)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table NBU_PERSON_FO add codedrpou varchar(20)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table NBU_PERSON_FO add namew varchar(254)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/


grant all on NBU_PERSON_FO to BARS_ACCESS_DEFROLE;
