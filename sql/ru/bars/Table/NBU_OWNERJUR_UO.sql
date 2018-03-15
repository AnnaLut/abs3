BEGIN
    bpa.alter_policy_info('NBU_OWNERJUR_UO', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_OWNERJUR_UO', 'WHOLE' , null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table NBU_OWNERJUR_UO
    (
        rnk              NUMBER(38),
        rnkb             NUMBER(38),
        nameoj           VARCHAR2(254),
        isrezoj          VARCHAR2(5),
        codedrpouoj      VARCHAR2(20),
        registrydayoj    DATE,
        numberregistryoj VARCHAR2(32),
        countrycodoj     VARCHAR2(3),
        percentoj        NUMBER(9,6),
        status           VARCHAR2(30),
	status_message   VARCHAR(4000),
        kf               VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_OWNERJUR_UO_304665 values (304665),
       partition NBU_OWNERJUR_UO_338545 values (338545),
       partition NBU_OWNERJUR_UO_305482 values (305482),
       partition NBU_OWNERJUR_UO_356334 values (356334),
       partition NBU_OWNERJUR_UO_326461 values (326461),
       partition NBU_OWNERJUR_UO_354507 values (354507),
       partition NBU_OWNERJUR_UO_322669 values (322669),
       partition NBU_OWNERJUR_UO_323475 values (323475),
       partition NBU_OWNERJUR_UO_353553 values (353553),
       partition NBU_OWNERJUR_UO_312356 values (312356),
       partition NBU_OWNERJUR_UO_302076 values (302076),
       partition NBU_OWNERJUR_UO_328845 values (328845),
       partition NBU_OWNERJUR_UO_335106 values (335106),
       partition NBU_OWNERJUR_UO_311647 values (311647),
       partition NBU_OWNERJUR_UO_352457 values (352457),
       partition NBU_OWNERJUR_UO_333368 values (333368),
       partition NBU_OWNERJUR_UO_325796 values (325796),
       partition NBU_OWNERJUR_UO_313957 values (313957),
       partition NBU_OWNERJUR_UO_336503 values (336503),
       partition NBU_OWNERJUR_UO_303398 values (303398),
       partition NBU_OWNERJUR_UO_331467 values (331467),
       partition NBU_OWNERJUR_UO_351823 values (351823),
       partition NBU_OWNERJUR_UO_337568 values (337568),
       partition NBU_OWNERJUR_UO_315784 values (315784),
       partition NBU_OWNERJUR_UO_324805 values (324805),
       partition NBU_OWNERJUR_UO_300465 values (300465)
   )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_OWNERJUR_UO IS 'Власники істотної участі – юридичні особи.';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.rnkb IS 'Рег.номер связанного клиента';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.nameoj IS 'Найменування особи';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.isrezoj IS 'Резидентність особи';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.codedrpouoj IS 'Код ЄДРПОУ';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.registrydayoj IS 'Дата державної реєстрації';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.numberregistryoj IS 'Номер державної реєстрації';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.countrycodoj IS 'Код країни';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.percentoj IS 'Частка власника істотної участі';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_OWNERJUR_UO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_OWNERJUR_UO');

grant all on NBU_OWNERJUR_UO to BARS_ACCESS_DEFROLE;
