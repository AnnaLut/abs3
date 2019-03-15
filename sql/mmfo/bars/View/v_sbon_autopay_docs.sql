

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_sbon_autopay_docs.sql
PROMPT ===================================================================================== 


CREATE OR REPLACE FORCE VIEW BARS.v_sbon_autopay_docs as
select a.* 
  from oper a, operw b 
 where a.ref = b.ref 
   and b.tag ='ABS' 
   and a.pdat >= sysdate - 3
   and a.tt in ('I0S',  -- кассовые
                'I0K',  -- внешние            
                'I0V')  -- внутренние
   and sos in ( 0,1);
  -- после импорта SOS=
  -- = 0 Для внешних платежей 
  -- = 1 Для внутрених 


comment on table v_sbon_autopay_docs is 'Импортированные документы СБОН для автооплаты вертушкой';

grant SELECT                                                                 on v_sbon_autopay_docs to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_sbon_autopay_docs.sql =========*** End *** ===
PROMPT ===================================================================================== 
