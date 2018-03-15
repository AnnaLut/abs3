BEGIN
    bpa.alter_policy_info('NBU_CREDIT_PLEDGE', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_CREDIT_PLEDGE', 'WHOLE' , null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'CREATE TABLE BARS.NBU_CREDIT_PLEDGE
    (
        rnk         NUMBER(38),
        nd          NUMBER(30),
	acc_ple     INT,
        sumPledge   NUMBER(32),
        pricePledge NUMBER(32),
        status      VARCHAR2(30),
	status_message VARCHAR2(4000),
        kf          VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_CREDIT_PLEDGE_304665 values (304665),
       partition NBU_CREDIT_PLEDGE_338545 values (338545),
       partition NBU_CREDIT_PLEDGE_305482 values (305482),
       partition NBU_CREDIT_PLEDGE_356334 values (356334),
       partition NBU_CREDIT_PLEDGE_326461 values (326461),
       partition NBU_CREDIT_PLEDGE_354507 values (354507),
       partition NBU_CREDIT_PLEDGE_322669 values (322669),
       partition NBU_CREDIT_PLEDGE_323475 values (323475),
       partition NBU_CREDIT_PLEDGE_353553 values (353553),
       partition NBU_CREDIT_PLEDGE_312356 values (312356),
       partition NBU_CREDIT_PLEDGE_302076 values (302076),
       partition NBU_CREDIT_PLEDGE_328845 values (328845),
       partition NBU_CREDIT_PLEDGE_335106 values (335106),
       partition NBU_CREDIT_PLEDGE_311647 values (311647),
       partition NBU_CREDIT_PLEDGE_352457 values (352457),
       partition NBU_CREDIT_PLEDGE_333368 values (333368),
       partition NBU_CREDIT_PLEDGE_325796 values (325796),
       partition NBU_CREDIT_PLEDGE_313957 values (313957),
       partition NBU_CREDIT_PLEDGE_336503 values (336503),
       partition NBU_CREDIT_PLEDGE_303398 values (303398),
       partition NBU_CREDIT_PLEDGE_331467 values (331467),
       partition NBU_CREDIT_PLEDGE_351823 values (351823),
       partition NBU_CREDIT_PLEDGE_337568 values (337568),
       partition NBU_CREDIT_PLEDGE_315784 values (315784),
       partition NBU_CREDIT_PLEDGE_324805 values (324805),
       partition NBU_CREDIT_PLEDGE_300465 values (300465)
   )';
exception
    when name_already_used then
         null;
end;
/

COMMENT ON TABLE BARS.NBU_CREDIT_PLEDGE IS 'Забезпечення за кредитним договором';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.nd IS 'Договір особи';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.acc_ple IS 'Счет залога';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.sumPledge IS 'Сума забезпечення згідно з договором';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.pricePledge IS 'Вартість забезпечення згідно з висновком суб’єкта оціночної діяльності';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_CREDIT_PLEDGE.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_CREDIT_PLEDGE');

grant all on NBU_CREDIT_PLEDGE to BARS_ACCESS_DEFROLE;
