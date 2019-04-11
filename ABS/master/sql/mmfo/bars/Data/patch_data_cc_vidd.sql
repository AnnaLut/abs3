PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_CC_VIDD.sql =========*** Run
PROMPT ===================================================================================== 

begin
  update cc_vidd 
    set blocked = 1 
    where vidd in (4,7,8,10,14);
  commit;
end;
/

delete from cc_vidd 
  where vidd in (9,19,29,39,21,37) and name != 'Регіональна інкасація';

COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_CC_VIDD.sql =========*** End
PROMPT ===================================================================================== 
