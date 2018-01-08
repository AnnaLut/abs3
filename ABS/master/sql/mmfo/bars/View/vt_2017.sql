create or replace view VT_2017 as 
select r020_old, ob_old, (select txt      from sb_ob22  where r020 = t.r020_old and ob22 = t.ob_old )                  name_old_OB ,
       r020_new, ob_new, (select txt      from sb_ob22  where r020 = t.r020_new and ob22 = t.ob_new )                  name_new_OB ,
                         (select name     from ps       where nbs  = t.r020_new )                                      name_new_nbu, 
    t.col,  t.comm, t.DAT_BEG, t.DAT_END, t.id1, 
    (select 1 from accounts where nbs = t.r020_old and ob22=t.ob_old and dazs is null and rownum=1 ) YES_OLD
from TRANSFER_2017 t
order by  NVL( r020_old ,r020_new),  ob_old ;

GRANT SELECT ON BARS.VT_2017 TO BARS_ACCESS_DEFROLE;
--------------------------------------------------------------------------------------------
