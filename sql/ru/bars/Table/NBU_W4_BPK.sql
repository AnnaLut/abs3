BEGIN
    bpa.alter_policy_info('NBU_W4_BPK', 'FILIAL', 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_W4_BPK', 'WHOLE', null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'create table NBU_W4_BPK
    (
        nd        INTEGER,
        acc_pk    INTEGER,
        rnk       INTEGER,
        acc       INTEGER,
        nbs       CHAR(4),
        ob22      CHAR(2),
        nls       VARCHAR2(15),
        kv        NUMBER(3),
        tip       CHAR(3),
        tip_kart  INTEGER,
        sdate     DATE,
        wdate     DATE,
        fin23     INTEGER,
        s250      INTEGER,
        grp       INTEGER,
        vkr       VARCHAR2(3),
        restr     INTEGER,
        kf        VARCHAR2(6),
        sum_zagal NUMBER(32),
        dat_close DATE
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_W4_BPK_304665 values (304665),
       partition NBU_W4_BPK_338545 values (338545),
       partition NBU_W4_BPK_305482 values (305482),
       partition NBU_W4_BPK_356334 values (356334),
       partition NBU_W4_BPK_326461 values (326461),
       partition NBU_W4_BPK_354507 values (354507),
       partition NBU_W4_BPK_322669 values (322669),
       partition NBU_W4_BPK_323475 values (323475),
       partition NBU_W4_BPK_353553 values (353553),
       partition NBU_W4_BPK_312356 values (312356),
       partition NBU_W4_BPK_302076 values (302076),
       partition NBU_W4_BPK_328845 values (328845),
       partition NBU_W4_BPK_335106 values (335106),
       partition NBU_W4_BPK_311647 values (311647),
       partition NBU_W4_BPK_352457 values (352457),
       partition NBU_W4_BPK_333368 values (333368),
       partition NBU_W4_BPK_325796 values (325796),
       partition NBU_W4_BPK_313957 values (313957),
       partition NBU_W4_BPK_336503 values (336503),
       partition NBU_W4_BPK_303398 values (303398),
       partition NBU_W4_BPK_331467 values (331467),
       partition NBU_W4_BPK_351823 values (351823),
       partition NBU_W4_BPK_337568 values (337568),
       partition NBU_W4_BPK_315784 values (315784),
       partition NBU_W4_BPK_324805 values (324805),
       partition NBU_W4_BPK_300465 values (300465)
   )';
exception
    when name_already_used then
         null;
end;
/

exec bpa.alter_policies('NBU_W4_BPK');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UI_NBU_W4_BPK on NBU_W4_BPK (kf, acc) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
 end;
/
