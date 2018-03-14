BEGIN 
    bpa.alter_policy_info('NBU_FINPERFORMANCEPR_UO', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_FINPERFORMANCEPR_UO', 'WHOLE' , null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'CREATE TABLE BARS.NBU_FINPERFORMANCEPR_UO
    (
        rnk       NUMBER(38),
        sales     NUMBER(32),
        ebit      NUMBER(32),
        ebitda    NUMBER(32),
        totaldebt NUMBER(32),
        status    VARCHAR2(30),
	status_message VARCHAR(4000),
        kf        VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_FINPERFORMANCEPR_UO_304665 values (304665),
       partition NBU_FINPERFORMANCEPR_UO_338545 values (338545),
       partition NBU_FINPERFORMANCEPR_UO_305482 values (305482),
       partition NBU_FINPERFORMANCEPR_UO_356334 values (356334),
       partition NBU_FINPERFORMANCEPR_UO_326461 values (326461),
       partition NBU_FINPERFORMANCEPR_UO_354507 values (354507),
       partition NBU_FINPERFORMANCEPR_UO_322669 values (322669),
       partition NBU_FINPERFORMANCEPR_UO_323475 values (323475),
       partition NBU_FINPERFORMANCEPR_UO_353553 values (353553),
       partition NBU_FINPERFORMANCEPR_UO_312356 values (312356),
       partition NBU_FINPERFORMANCEPR_UO_302076 values (302076),
       partition NBU_FINPERFORMANCEPR_UO_328845 values (328845),
       partition NBU_FINPERFORMANCEPR_UO_335106 values (335106),
       partition NBU_FINPERFORMANCEPR_UO_311647 values (311647),
       partition NBU_FINPERFORMANCEPR_UO_352457 values (352457),
       partition NBU_FINPERFORMANCEPR_UO_333368 values (333368),
       partition NBU_FINPERFORMANCEPR_UO_325796 values (325796),
       partition NBU_FINPERFORMANCEPR_UO_313957 values (313957),
       partition NBU_FINPERFORMANCEPR_UO_336503 values (336503),
       partition NBU_FINPERFORMANCEPR_UO_303398 values (303398),
       partition NBU_FINPERFORMANCEPR_UO_331467 values (331467),
       partition NBU_FINPERFORMANCEPR_UO_351823 values (351823),
       partition NBU_FINPERFORMANCEPR_UO_337568 values (337568),
       partition NBU_FINPERFORMANCEPR_UO_315784 values (315784),
       partition NBU_FINPERFORMANCEPR_UO_324805 values (324805),
       partition NBU_FINPERFORMANCEPR_UO_300465 values (300465)
    )';
exception
    when name_already_used then
         null;
end;
/

COMMENT ON TABLE BARS.NBU_FINPERFORMANCEPR_UO IS 'Розмір фінансових показників діяльності групи пов’язаних контрагентів';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.sales IS 'Показник сукупного обсягу реалізації  (SALES)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.ebit IS 'Показник фінансового результату від операційної діяльності  (EBIT)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.ebitda IS 'Показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.totaldebt IS 'Показник концентрації залучених коштів (TOTAL NET DEBT)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCEPR_UO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_FINPERFORMANCEPR_UO');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_NBU_FINPERFORMANCEPR_UO on NBU_FINPERFORMANCEPR_UO (kf, RNK) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
 end;
/

grant all on NBU_FINPERFORMANCEPR_UO to BARS_ACCESS_DEFROLE;
