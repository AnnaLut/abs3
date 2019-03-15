

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_sbon_autopay_docs.sql
PROMPT ===================================================================================== 


CREATE OR REPLACE FORCE VIEW BARS.v_sbon_autopay_docs as
select a.* 
  from oper a, operw b 
 where a.ref = b.ref 
   and b.tag ='ABS' 
   and a.pdat >= sysdate - 3
   and a.tt in ('I0S',  -- ��������
                'I0K',  -- �������            
                'I0V')  -- ����������
   and sos in ( 0,1);
  -- ����� ������� SOS=
  -- = 0 ��� ������� �������� 
  -- = 1 ��� ��������� 


comment on table v_sbon_autopay_docs is '��������������� ��������� ���� ��� ���������� ���������';

grant SELECT                                                                 on v_sbon_autopay_docs to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_sbon_autopay_docs.sql =========*** End *** ===
PROMPT ===================================================================================== 
