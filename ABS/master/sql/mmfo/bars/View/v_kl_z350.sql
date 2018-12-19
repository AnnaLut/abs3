PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kl_z350.sql ========= *** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_KL_Z350
AS
  select Z350, TXT
    from kl_Z350
   where d_close is null
  union all
  select '#' Z350, '����� �������' TXT  from dual
  order by Z350;

comment on table  v_kl_Z350 is '������ ������������ ��������� ������';
comment on column v_kl_Z350.Z350 is '��� ������� ������� ������';
comment on column v_kl_Z350.TXT  is '����� �������';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kl_z350.sql ========= *** End *** ===
PROMPT ===================================================================================== 

