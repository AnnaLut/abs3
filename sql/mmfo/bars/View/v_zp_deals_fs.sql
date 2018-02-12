create or replace force view bars.v_zp_deals_fs
(
   id,
   name,
   ob22,
   date_close
)
as
   select "ID",
          "NAME",
          "OB22",
          "DATE_CLOSE"
     from zp_deals_fs
    where date_close is null;
/
grant select,delete,update,insert on bars.v_zp_deals_fs to bars_access_defrole;
/