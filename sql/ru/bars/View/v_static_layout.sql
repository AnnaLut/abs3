create or replace force view bars.v_static_layout
as
   select id,
            nvl (dk, 1) dk,
            name,
            nls,
            bs1 bs,
            ob1 ob,
            nazn1 nazn,
            datp,
            alg,
            grp
       from ope_lot
      where ob22 != '~~' and (id < 0 or grp > 0)
   order by id desc;
/
   comment on table bars.v_static_layout is 'статичні макети макети';
/
comment on column bars.v_static_layout.id is 'ідентифікатор';
/
comment on column bars.v_static_layout.name is 'найменування макету';
/
comment on column bars.v_static_layout.nls is 'рахунок а';
/
comment on column bars.v_static_layout.bs is 'балансовий рахунок';
/
comment on column bars.v_static_layout.ob is 'об22';
/
comment on column bars.v_static_layout.nazn is 'попередне призначення платежу';
/
comment on column bars.v_static_layout.datp is 'дата попереднього виконання';
/
comment on column bars.v_static_layout.alg is '№ алг';
/
grant select on bars.v_static_layout to bars_access_defrole;
/
