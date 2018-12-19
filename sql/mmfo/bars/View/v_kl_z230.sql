PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kl_z230.sql ========= *** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_KL_Z230
AS
  select Z230, TXT
    from kl_z230
   where d_close is null
  union all
  select '#' Z230, 'Розріз відсутній' TXT  from dual
  order by z230;

comment on table  v_kl_z230 is 'Код платіжної системи';
comment on column v_kl_z230.Z230 is 'Код платіжної системи';
comment on column v_kl_z230.TXT  is 'Назва платіжної системи';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kl_z230.sql ========= *** End *** ===
PROMPT ===================================================================================== 

