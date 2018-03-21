BEGIN 
    bpa.alter_policy_info('NBU_ADDRESS_FO', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_ADDRESS_FO', 'WHOLE' , null, 'E', 'E', 'E');
END; 
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'create table NBU_ADDRESS_FO
    (
        rnk             NUMBER(38),
        codRegion       VARCHAR2(4000 byte),
        area            VARCHAR2(4000 byte),
        zip             VARCHAR2(4000 byte),
        city            VARCHAR2(4000 byte),
        streetAddress   VARCHAR2(4000 byte),
        houseNo         VARCHAR2(4000 byte),
        adrKorp         VARCHAR2(4000 byte),
        flatNo          VARCHAR2(4000 byte),
        status          VARCHAR2(30 char),
        status_message  VARCHAR2(4000 byte),
        kf    VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_ADDRESS_FO_304665 values (304665),
       partition NBU_ADDRESS_FO_338545 values (338545),
       partition NBU_ADDRESS_FO_305482 values (305482),
       partition NBU_ADDRESS_FO_356334 values (356334),
       partition NBU_ADDRESS_FO_326461 values (326461),
       partition NBU_ADDRESS_FO_354507 values (354507),
       partition NBU_ADDRESS_FO_322669 values (322669),
       partition NBU_ADDRESS_FO_323475 values (323475),
       partition NBU_ADDRESS_FO_353553 values (353553),
       partition NBU_ADDRESS_FO_312356 values (312356),
       partition NBU_ADDRESS_FO_302076 values (302076),
       partition NBU_ADDRESS_FO_328845 values (328845),
       partition NBU_ADDRESS_FO_335106 values (335106),
       partition NBU_ADDRESS_FO_311647 values (311647),
       partition NBU_ADDRESS_FO_352457 values (352457),
       partition NBU_ADDRESS_FO_333368 values (333368),
       partition NBU_ADDRESS_FO_325796 values (325796),
       partition NBU_ADDRESS_FO_313957 values (313957),
       partition NBU_ADDRESS_FO_336503 values (336503),
       partition NBU_ADDRESS_FO_303398 values (303398),
       partition NBU_ADDRESS_FO_331467 values (331467),
       partition NBU_ADDRESS_FO_351823 values (351823),
       partition NBU_ADDRESS_FO_337568 values (337568),
       partition NBU_ADDRESS_FO_315784 values (315784),
       partition NBU_ADDRESS_FO_324805 values (324805),
       partition NBU_ADDRESS_FO_300465 values (300465)
   )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_ADDRESS_FO IS 'Адреса реєстрації. Структура';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.rnk IS 'Регистрационный номер';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.codRegion IS 'Код регіону';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.area IS 'Район';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.zip IS 'Поштовий індекс';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.city IS 'Назва населеного пункту';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.streetAddress IS 'Вулиця';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.houseNo IS 'Будинок';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.adrKorp IS 'Корпус (споруда)';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.flatNo IS 'Квартира';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.status IS 'Статус';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.status_message IS 'Статус помилок';
COMMENT ON COLUMN BARS.NBU_ADDRESS_FO.kf IS 'Код филиала';

exec bpa.alter_policies('NBU_ADDRESS_FO');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UIX_NBU_ADDRESS on NBU_ADDRESS_FO (kf,rnk) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
 end;
/

grant all on NBU_ADDRESS_FO to BARS_ACCESS_DEFROLE;
