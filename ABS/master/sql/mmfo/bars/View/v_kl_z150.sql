PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kl_z150.sql ========= *** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_KL_Z150
AS
  select Z150, TXT
    from kl_Z150
   where d_close is null
  union all
  select '#' Z150, 'Розріз відсутній' TXT  from dual
  order by Z150;

comment on table  v_kl_Z150 is 'Код місця здійснення операції з платіжною карткою';
comment on column v_kl_Z150.Z150 is 'Код місця здійснення операції';
comment on column v_kl_Z150.TXT  is 'Розшифровка';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kl_z150.sql ========= *** End *** ===
PROMPT ===================================================================================== 

