PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kl_z140.sql ========= *** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_KL_Z140
AS
  select Z140, TXT
    from kl_Z140
   where d_close is null
  union all
  select '#' Z140, '����� �������' TXT  from dual
  order by Z140;

comment on table  v_kl_Z140 is '��� �������� �������� � ��������� ��������';
comment on column v_kl_Z140.Z140 is '��� �������� ��������';
comment on column v_kl_Z140.TXT  is '�����������';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kl_z140.sql ========= *** End *** ===
PROMPT ===================================================================================== 

