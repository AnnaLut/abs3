prompt refill table bars_intgr.imp_object_mfo

delete from bars_intgr.imp_object_mfo;

insert into bars_intgr.imp_object_mfo(kf, object_name, changenumber)
select kf, 'CLIENTFO2', 0 from bars.mv_kf;

commit;

