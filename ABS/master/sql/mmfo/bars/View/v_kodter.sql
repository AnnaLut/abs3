PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kodter.sql ========== *** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_KODTER
AS
  select trim(to_char(KO,'099')) KO, KNB
    from kodobl
   where data_c is null
     and KO not in (11,27,29,34,40,43,44,99)
  union all
  select '011' KO, 'ВЕЗ Крим' KNB  from dual
  union all
  select '043' KO, 'Університет БС НБУ м.Київ' KNB  from dual
  union all
  select '044' KO, 'СІБС УБС НБУ' KNB  from dual
  union all
  select '#' KO, 'В цілому' KNB  from dual
  order by KO;

comment on table  V_KODTER is 'Код адміністративно-територіальної одиниці України';
comment on column V_KODTER.KO is 'Код адміністративно-територіальної одиниці України';
comment on column V_KODTER.KNB  is 'Розшифровка коду';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kodter.sql ========== *** End *** ===
PROMPT ===================================================================================== 

