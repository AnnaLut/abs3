PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_kl_k045.sql ========= *** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_KL_K045
AS
  select K045, TXT
    from kl_K045
   where d_close is null
  union all
  select '#' K045, '����� �������' TXT  from dual
  order by K045;

comment on table  v_kl_K045 is '��� ������� ��������� ��������';
comment on column v_kl_K045.K045 is '��� �������';
comment on column v_kl_K045.TXT  is '����������� ����';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_kl_k045.sql ========= *** End *** ===
PROMPT ===================================================================================== 

