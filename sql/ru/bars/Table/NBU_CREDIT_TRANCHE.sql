begin
    bpa.alter_policy_info('NBU_CREDIT_TRANCHE', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_CREDIT_TRANCHE', 'WHOLE' , null, 'E', 'E', 'E');
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'CREATE TABLE BARS.NBU_CREDIT_TRANCHE
    (
        rnk          NUMBER(38),
        nd           NUMBER(30),
        numdogtr     VARCHAR2(50),
        dogdaytr     DATE,
        enddaytr     DATE,
        sumzagaltr   NUMBER(32),
        r030tr       VARCHAR2(3),
        proccredittr NUMBER(5,2),
        periodbasetr NUMBER(1),
        periodproctr NUMBER(1),
        sumarrearstr NUMBER(32),
        arrearbasetr NUMBER(32),
        arrearproctr NUMBER(32),
        daybasetr    NUMBER(5),
        dayproctr    NUMBER(5),
        factenddaytr DATE,
        klasstr      VARCHAR2(1),
        risktr       NUMBER(32),
        status     VARCHAR2(30),
	status_message VARCHAR(4000),
        kf         VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_CREDIT_TRANCHE_304665 values (304665),
       partition NBU_CREDIT_TRANCHE_338545 values (338545),
       partition NBU_CREDIT_TRANCHE_305482 values (305482),
       partition NBU_CREDIT_TRANCHE_356334 values (356334),
       partition NBU_CREDIT_TRANCHE_326461 values (326461),
       partition NBU_CREDIT_TRANCHE_354507 values (354507),
       partition NBU_CREDIT_TRANCHE_322669 values (322669),
       partition NBU_CREDIT_TRANCHE_323475 values (323475),
       partition NBU_CREDIT_TRANCHE_353553 values (353553),
       partition NBU_CREDIT_TRANCHE_312356 values (312356),
       partition NBU_CREDIT_TRANCHE_302076 values (302076),
       partition NBU_CREDIT_TRANCHE_328845 values (328845),
       partition NBU_CREDIT_TRANCHE_335106 values (335106),
       partition NBU_CREDIT_TRANCHE_311647 values (311647),
       partition NBU_CREDIT_TRANCHE_352457 values (352457),
       partition NBU_CREDIT_TRANCHE_333368 values (333368),
       partition NBU_CREDIT_TRANCHE_325796 values (325796),
       partition NBU_CREDIT_TRANCHE_313957 values (313957),
       partition NBU_CREDIT_TRANCHE_336503 values (336503),
       partition NBU_CREDIT_TRANCHE_303398 values (303398),
       partition NBU_CREDIT_TRANCHE_331467 values (331467),
       partition NBU_CREDIT_TRANCHE_351823 values (351823),
       partition NBU_CREDIT_TRANCHE_337568 values (337568),
       partition NBU_CREDIT_TRANCHE_315784 values (315784),
       partition NBU_CREDIT_TRANCHE_324805 values (324805),
       partition NBU_CREDIT_TRANCHE_300465 values (300465)
    )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_CREDIT_TRANCHE IS 'Транші за кредитним договором';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.nd IS 'Договір особи';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.numdogtr IS 'Номер договору траншу';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.dogdaytr IS 'Дата укладання договору траншу';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.enddaytr IS 'Кінцева дата погашення заборгованості траншу';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.sumzagaltr IS 'Сума наданого фінансового зобов’язання за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.r030tr IS 'Код валюти за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.proccredittr IS 'Процентна ставка за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.periodbasetr IS 'Періодичність сплати основного боргу за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.periodproctr IS 'Періодичність сплати процентів за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.sumarrearstr IS 'Залишок заборгованості за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.arrearbasetr IS 'Прострочена заборгованість за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.arrearproctr IS 'Прострочена заборгованість  за процентами траншу';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.daybasetr IS 'Кількість днів прострочення за траншем ';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.dayproctr IS 'Кількість днів прострочення за процентами траншу';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.factenddaytr IS 'Дата фактичного погашення траншу';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.klasstr IS 'Клас боржника за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.risktr IS 'Величина кредитного ризику за траншем';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_CREDIT_TRANCHE.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_CREDIT_TRANCHE');

grant all on NBU_CREDIT_TRANCHE to BARS_ACCESS_DEFROLE;
