BEGIN
    bpa.alter_policy_info('NBU_GROUPUR_UO', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_GROUPUR_UO', 'WHOLE' , null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'CREATE TABLE BARS.NBU_GROUPUR_UO 
    (
        rnk          NUMBER(38),
        whois        NUMBER(1),
        isrezgr      VARCHAR2(5),
        codedrpougr  VARCHAR2(20),
        nameurgr     VARCHAR2(254),
        countrycodgr VARCHAR2(3),
        status       VARCHAR2(30),
	status_message VARCHAR(4000),
        kf           VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_GROUPUR_UO_304665 values (304665),
       partition NBU_GROUPUR_UO_338545 values (338545),
       partition NBU_GROUPUR_UO_305482 values (305482),
       partition NBU_GROUPUR_UO_356334 values (356334),
       partition NBU_GROUPUR_UO_326461 values (326461),
       partition NBU_GROUPUR_UO_354507 values (354507),
       partition NBU_GROUPUR_UO_322669 values (322669),
       partition NBU_GROUPUR_UO_323475 values (323475),
       partition NBU_GROUPUR_UO_353553 values (353553),
       partition NBU_GROUPUR_UO_312356 values (312356),
       partition NBU_GROUPUR_UO_302076 values (302076),
       partition NBU_GROUPUR_UO_328845 values (328845),
       partition NBU_GROUPUR_UO_335106 values (335106),
       partition NBU_GROUPUR_UO_311647 values (311647),
       partition NBU_GROUPUR_UO_352457 values (352457),
       partition NBU_GROUPUR_UO_333368 values (333368),
       partition NBU_GROUPUR_UO_325796 values (325796),
       partition NBU_GROUPUR_UO_313957 values (313957),
       partition NBU_GROUPUR_UO_336503 values (336503),
       partition NBU_GROUPUR_UO_303398 values (303398),
       partition NBU_GROUPUR_UO_331467 values (331467),
       partition NBU_GROUPUR_UO_351823 values (351823),
       partition NBU_GROUPUR_UO_337568 values (337568),
       partition NBU_GROUPUR_UO_315784 values (315784),
       partition NBU_GROUPUR_UO_324805 values (324805),
       partition NBU_GROUPUR_UO_300465 values (300465)
   )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_GROUPUR_UO IS 'Перелік юридичних осіб, що входять до групи юридичних осіб, що знаходяться під спільним контролем';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.whois IS 'Статус участі юридичної особи в групі';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.isrezgr IS 'Резидентність особи';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.codedrpougr IS 'Код ЄДРПОУ';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.nameurgr IS 'Найменування особи';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.countrycodgr IS 'Код країни місця реєстрації';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_GROUPUR_UO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_GROUPUR_UO');

grant all on NBU_GROUPUR_UO to BARS_ACCESS_DEFROLE;
