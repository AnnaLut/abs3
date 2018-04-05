BEGIN 
    bpa.alter_policy_info('NBU_FINPERFORMANCE_UO', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_FINPERFORMANCE_UO', 'WHOLE' , null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'CREATE TABLE BARS.NBU_FINPERFORMANCE_UO
    (
        rnk          NUMBER(38),
        sales        NUMBER(32),
        ebit         NUMBER(32),
        ebitda       NUMBER(32),
        totaldebt    NUMBER(32),
        status       VARCHAR2(30),
	status_message VARCHAR(4000),
        kf           VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_FINPERFORMANCE_UO304665 values (304665),
       partition NBU_FINPERFORMANCE_UO338545 values (338545),
       partition NBU_FINPERFORMANCE_UO305482 values (305482),
       partition NBU_FINPERFORMANCE_UO356334 values (356334),
       partition NBU_FINPERFORMANCE_UO326461 values (326461),
       partition NBU_FINPERFORMANCE_UO354507 values (354507),
       partition NBU_FINPERFORMANCE_UO322669 values (322669),
       partition NBU_FINPERFORMANCE_UO323475 values (323475),
       partition NBU_FINPERFORMANCE_UO353553 values (353553),
       partition NBU_FINPERFORMANCE_UO312356 values (312356),
       partition NBU_FINPERFORMANCE_UO302076 values (302076),
       partition NBU_FINPERFORMANCE_UO328845 values (328845),
       partition NBU_FINPERFORMANCE_UO335106 values (335106),
       partition NBU_FINPERFORMANCE_UO311647 values (311647),
       partition NBU_FINPERFORMANCE_UO352457 values (352457),
       partition NBU_FINPERFORMANCE_UO333368 values (333368),
       partition NBU_FINPERFORMANCE_UO325796 values (325796),
       partition NBU_FINPERFORMANCE_UO313957 values (313957),
       partition NBU_FINPERFORMANCE_UO336503 values (336503),
       partition NBU_FINPERFORMANCE_UO303398 values (303398),
       partition NBU_FINPERFORMANCE_UO331467 values (331467),
       partition NBU_FINPERFORMANCE_UO351823 values (351823),
       partition NBU_FINPERFORMANCE_UO337568 values (337568),
       partition NBU_FINPERFORMANCE_UO315784 values (315784),
       partition NBU_FINPERFORMANCE_UO324805 values (324805),
       partition NBU_FINPERFORMANCE_UO300465 values (300465)
    )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_FINPERFORMANCE_UO IS 'Розмір фінансових показників діяльності Боржника';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.sales IS 'Показник сукупного обсягу реалізації  (SALES)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.ebit IS 'Показник фінансового результату від операційної діяльності  (EBIT)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.ebitda IS 'Показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.totaldebt IS 'Показник концентрації залучених коштів (TOTAL NET DEBT)';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_FINPERFORMANCE_UO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_FINPERFORMANCE_UO');

begin 
  execute immediate ' alter table NBU_FINPERFORMANCE_UO add status_message VARCHAR(4000) ';
exception when others then
  if  sqlcode=-1430 then null; else raise; end if;
 end;
/



declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UI_NBU_FINPERFORMANCE_UO on NBU_FINPERFORMANCE_UO (kf, rnk) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
 end;
/

grant all on NBU_FINPERFORMANCE_UO to BARS_ACCESS_DEFROLE;
