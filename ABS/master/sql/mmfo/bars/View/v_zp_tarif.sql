create or replace view v_zp_tarif
as
   select z.kod,
          z.kv,
          a.name,
          a.tar,
          a.pr,
          a.tip,
          z.kf
     from v_tarif a, zp_tarif z
    where a.kod = z.kod;
/
grant select,
      delete,
      update,
      insert
   on bars.v_zp_tarif
   to bars_access_defrole;
/