BEGIN
    bpa.alter_policy_info('NBU_PERSON_UO', 'FILIAL', 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_PERSON_UO', 'WHOLE', null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'CREATE TABLE BARS.NBU_PERSON_UO
    (
        rnk             NUMBER(38),
        nameur          VARCHAR2(254),
        isrez           VARCHAR2(5),
        codedrpou       VARCHAR2(20),
        registryday     DATE,
        numberregistry  VARCHAR2(32),
        k110            VARCHAR2(5),
        ec_year         DATE,
        countrycodnerez VARCHAR2(3),
        ismember        VARCHAR2(5),
        iscontroller    VARCHAR2(5),
        ispartner       VARCHAR2(5),
        isaudit         VARCHAR2(5),
        k060            VARCHAR2(2),
        status          VARCHAR2(30),
	status_message VARCHAR2(4000),
        kf              VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_PERSON_UO_304665 values (304665),
       partition NBU_PERSON_UO_338545 values (338545),
       partition NBU_PERSON_UO_305482 values (305482),
       partition NBU_PERSON_UO_356334 values (356334),
       partition NBU_PERSON_UO_326461 values (326461),
       partition NBU_PERSON_UO_354507 values (354507),
       partition NBU_PERSON_UO_322669 values (322669),
       partition NBU_PERSON_UO_323475 values (323475),
       partition NBU_PERSON_UO_353553 values (353553),
       partition NBU_PERSON_UO_312356 values (312356),
       partition NBU_PERSON_UO_302076 values (302076),
       partition NBU_PERSON_UO_328845 values (328845),
       partition NBU_PERSON_UO_335106 values (335106),
       partition NBU_PERSON_UO_311647 values (311647),
       partition NBU_PERSON_UO_352457 values (352457),
       partition NBU_PERSON_UO_333368 values (333368),
       partition NBU_PERSON_UO_325796 values (325796),
       partition NBU_PERSON_UO_313957 values (313957),
       partition NBU_PERSON_UO_336503 values (336503),
       partition NBU_PERSON_UO_303398 values (303398),
       partition NBU_PERSON_UO_331467 values (331467),
       partition NBU_PERSON_UO_351823 values (351823),
       partition NBU_PERSON_UO_337568 values (337568),
       partition NBU_PERSON_UO_315784 values (315784),
       partition NBU_PERSON_UO_324805 values (324805),
       partition NBU_PERSON_UO_300465 values (300465)
    )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_PERSON_UO IS 'Боржник ЮО';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.nameur IS 'Найменування Боржника';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.isrez IS 'Резидентність особи';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.codedrpou IS 'Код ЄДРПОУ Боржника';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.registryday IS 'Дата державної реєстрації';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.numberregistry IS 'Номер державної реєстрації';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.k110 IS 'Вид економічної діяльності';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.ec_year IS 'Період';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.countrycodnerez IS 'Країна реєстрації Боржника – нерезидента';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.ismember IS 'Приналежність Боржника до групи юридичних осіб';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.iscontroller IS 'Статус участі Боржника в групі';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.ispartner IS 'Факт приналежності Боржника до групи пов’язаних контрагентів';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.isaudit  IS 'Факт проходження аудиту фінансової звітності';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.k060 IS 'Тип пов’язаної з банком особи';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_PERSON_UO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_PERSON_UO');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UI_NBU_PERSON_UO on NBU_PERSON_UO (kf, rnk) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
end;
/

grant all on NBU_PERSON_UO to BARS_ACCESS_DEFROLE;