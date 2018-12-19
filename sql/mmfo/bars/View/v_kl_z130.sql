PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kl_z130.sql ========= *** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_KL_Z130
AS
  select Z130, TXT
    from kl_z130
   where d_close is null
  union all
  select '#' Z130, '����� �������' TXT  from dual
  order by z130;

comment on table  v_kl_z130 is '��� ��������� 䳿';
comment on column v_kl_z130.Z130 is '��� ����';
comment on column v_kl_z130.TXT  is '�����������';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kl_z130.sql ========= *** End *** ===
PROMPT ===================================================================================== 

