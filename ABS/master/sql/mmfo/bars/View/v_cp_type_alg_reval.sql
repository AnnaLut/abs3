
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/View/v_cp_type_alg_reval.sql =*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cp_type_alg_reval ***

  CREATE OR REPLACE FORCE VIEW BARS.v_cp_type_alg_reval ("ID", "NAME") AS 
  select 1, '�� ����� ��� ��' from dual
  union
  select 2, '�� ������ ���(� �������) ��' from dual
  union
  select 3, '�� �������' from dual;

PROMPT *** Create  grants  v_cp_type_alg_reval ***
grant SELECT                                                                 on v_cp_type_alg_reval         to BARSREADER_ROLE;
grant SELECT                                                                 on v_cp_type_alg_reval         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cp_type_alg_reval         to START1;
grant SELECT                                                                 on v_cp_type_alg_reval         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cp_type_alg_reval.sql =========*** End *** ======
PROMPT ===================================================================================== 
