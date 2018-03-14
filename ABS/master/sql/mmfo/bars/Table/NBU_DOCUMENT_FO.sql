begin
    bpa.alter_policy_info('NBU_DOCUMENT_FO', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_DOCUMENT_FO', 'WHOLE' , null, 'E', 'E', 'E');
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table NBU_DOCUMENT_FO
    (
        rnk    NUMBER(38),
        typed  NUMBER(1),
        seriya VARCHAR2(20),
        nomerd VARCHAR2(20),
        dtd    DATE,
        status VARCHAR2(30),
	status_message VARCHAR(4000),
        kf    VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_DOCUMENT_FO_304665 values (304665),
       partition NBU_DOCUMENT_FO_338545 values (338545),
       partition NBU_DOCUMENT_FO_305482 values (305482),
       partition NBU_DOCUMENT_FO_356334 values (356334),
       partition NBU_DOCUMENT_FO_326461 values (326461),
       partition NBU_DOCUMENT_FO_354507 values (354507),
       partition NBU_DOCUMENT_FO_322669 values (322669),
       partition NBU_DOCUMENT_FO_323475 values (323475),
       partition NBU_DOCUMENT_FO_353553 values (353553),
       partition NBU_DOCUMENT_FO_312356 values (312356),
       partition NBU_DOCUMENT_FO_302076 values (302076),
       partition NBU_DOCUMENT_FO_328845 values (328845),
       partition NBU_DOCUMENT_FO_335106 values (335106),
       partition NBU_DOCUMENT_FO_311647 values (311647),
       partition NBU_DOCUMENT_FO_352457 values (352457),
       partition NBU_DOCUMENT_FO_333368 values (333368),
       partition NBU_DOCUMENT_FO_325796 values (325796),
       partition NBU_DOCUMENT_FO_313957 values (313957),
       partition NBU_DOCUMENT_FO_336503 values (336503),
       partition NBU_DOCUMENT_FO_303398 values (303398),
       partition NBU_DOCUMENT_FO_331467 values (331467),
       partition NBU_DOCUMENT_FO_351823 values (351823),
       partition NBU_DOCUMENT_FO_337568 values (337568),
       partition NBU_DOCUMENT_FO_315784 values (315784),
       partition NBU_DOCUMENT_FO_324805 values (324805),
       partition NBU_DOCUMENT_FO_300465 values (300465)
   )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_DOCUMENT_FO IS 'Документ що посвідчує особу ФО';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.typed IS 'Тип документа';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.seriya IS 'Серія документа';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.nomerd IS 'Номер документа';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.dtd IS 'Дата видачі документа';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_DOCUMENT_FO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_DOCUMENT_FO');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UI_NBU_DOCUMENT_FO on NBU_DOCUMENT_FO (KF, rnk) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
end;
/

grant all on NBU_DOCUMENT_FO to BARS_ACCESS_DEFROLE;
