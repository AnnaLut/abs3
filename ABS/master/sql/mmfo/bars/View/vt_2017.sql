

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VT_2017.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VT_2017 ***

  CREATE OR REPLACE FORCE VIEW BARS.VT_2017 ("R020_OLD", "OB_OLD", "NAME_OLD_OB", "R020_NEW", "OB_NEW", "NAME_NEW_OB", "NAME_NEW_NBU", "COL", "COMM", "DAT_BEG", "DAT_END", "ID1", "YES_OLD") AS 
  select r020_old, ob_old, (select txt      from sb_ob22  where r020 = t.r020_old and ob22 = t.ob_old )                  name_old_OB ,
       r020_new, ob_new, (select txt      from sb_ob22  where r020 = t.r020_new and ob22 = t.ob_new )                  name_new_OB ,
                         (select name     from ps       where nbs  = t.r020_new )                                      name_new_nbu,
    t.col,  t.comm, t.DAT_BEG, t.DAT_END, t.id1,
    (select 1 from accounts where nbs = t.r020_old and ob22=t.ob_old and dazs is null and rownum=1 ) YES_OLD
from TRANSFER_2017 t
order by  NVL( r020_old ,r020_new),  ob_old ;

PROMPT *** Create  grants  VT_2017 ***
grant SELECT                                                                 on VT_2017         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VT_2017.sql =========*** End *** ======
PROMPT ===================================================================================== 
