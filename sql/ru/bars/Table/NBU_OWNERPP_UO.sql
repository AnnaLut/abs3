BEGIN 
    bpa.alter_policy_info('NBU_OWNERPP_UO', 'FILIAL', 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_OWNERPP_UO', 'WHOLE', null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table NBU_OWNERPP_UO
    (
        rnk        NUMBER(38),
        rnkb       NUMBER(38),
        lastname   VARCHAR2(100),
        firstname  VARCHAR2(100),
        middlename VARCHAR2(100),
        isrez      varchar(5),
        inn        VARCHAR2(25),
        countrycod VARCHAR2(3),
        percent    NUMBER(9,6),
        status     VARCHAR2(30),
	status_message VARCHAR2(4000),
        kf         VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_OWNERPP_UO_304665 values (304665),
       partition NBU_OWNERPP_UO_338545 values (338545),
       partition NBU_OWNERPP_UO_305482 values (305482),
       partition NBU_OWNERPP_UO_356334 values (356334),
       partition NBU_OWNERPP_UO_326461 values (326461),
       partition NBU_OWNERPP_UO_354507 values (354507),
       partition NBU_OWNERPP_UO_322669 values (322669),
       partition NBU_OWNERPP_UO_323475 values (323475),
       partition NBU_OWNERPP_UO_353553 values (353553),
       partition NBU_OWNERPP_UO_312356 values (312356),
       partition NBU_OWNERPP_UO_302076 values (302076),
       partition NBU_OWNERPP_UO_328845 values (328845),
       partition NBU_OWNERPP_UO_335106 values (335106),
       partition NBU_OWNERPP_UO_311647 values (311647),
       partition NBU_OWNERPP_UO_352457 values (352457),
       partition NBU_OWNERPP_UO_333368 values (333368),
       partition NBU_OWNERPP_UO_325796 values (325796),
       partition NBU_OWNERPP_UO_313957 values (313957),
       partition NBU_OWNERPP_UO_336503 values (336503),
       partition NBU_OWNERPP_UO_303398 values (303398),
       partition NBU_OWNERPP_UO_331467 values (331467),
       partition NBU_OWNERPP_UO_351823 values (351823),
       partition NBU_OWNERPP_UO_337568 values (337568),
       partition NBU_OWNERPP_UO_315784 values (315784),
       partition NBU_OWNERPP_UO_324805 values (324805),
       partition NBU_OWNERPP_UO_300465 values (300465)
   )';
exception
    when name_already_used then
         null;
end;
/

COMMENT ON TABLE BARS.NBU_OWNERPP_UO IS 'Власники істотної участі – юридичні особи.';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.rnkb IS 'Рег.номер связанного клиента';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.lastname IS 'Прізвище';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.firstname IS 'Ім’я';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.middlename IS 'По батькові';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.isrez IS 'Резидентність особи';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.inn IS 'Ідентифікацій-ний код';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.countrycod IS 'Код країни';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.percent IS 'Частка власника істотної участі';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_OWNERPP_UO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_OWNERPP_UO');
declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UIX_NBU_OWNERPP_UO on NBU_OWNERPP_UO (kf, RNK) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
end;
/

grant all on NBU_OWNERPP_UO to BARS_ACCESS_DEFROLE;
