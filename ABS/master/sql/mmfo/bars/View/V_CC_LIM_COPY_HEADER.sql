CREATE OR REPLACE VIEW V_CC_LIM_COPY_HEADER AS
SELECT t.id, t.nd, t.oper_date, t1.fio, t.comments
  FROM cc_lim_copy_header t
  JOIN staff$base t1
    ON t.userid = t1.id;
comment on table V_CC_LIM_COPY_HEADER is 'Історія змін по ГПК за період (дані очищаються 10 числа кожного місяця)';
comment on column V_CC_LIM_COPY_HEADER.ID is 'ID зміни';
comment on column V_CC_LIM_COPY_HEADER.nd is 'Референс КД';
comment on column V_CC_LIM_COPY_HEADER.OPER_DATE is 'Дата зміни';
comment on column V_CC_LIM_COPY_HEADER.COMMENTS is 'З якої процедури/пакету БД,була ініційована зміна';
