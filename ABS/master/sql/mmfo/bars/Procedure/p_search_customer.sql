

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SEARCH_CUSTOMER.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SEARCH_CUSTOMER ***

  CREATE OR REPLACE PROCEDURE BARS.P_SEARCH_CUSTOMER 
  (p_okpo    IN   customer.okpo%type,
   p_nmk     IN   customer.nmk%type,
   p_bday    IN   person.bday%type,
   p_ser     IN   person.ser%type,
   p_numdoc  IN   person.numdoc%type,
   p_cust    OUT  sys_refcursor)
IS
  l_title   varchar2(60)        := 'dpt_web.p_search_customer: ';
  l_enough  number(1);
  t_cust    sys_refcursor;
  l_branch  branch.branch%type  := sys_context('bars_context', 'user_branch');
  l_nmk     customer.nmk%type   := '%';
  g_nulldate                date := to_date('01.01.1000','DD.MM.YYYY');

BEGIN

  bars_audit.trace('%s ид.код = %s, ФИО = %s, ДР = %s, серия и № паспорта = %s %s', 
                   l_title, p_okpo, p_nmk, to_char(p_bday,'DD/MM/YYYY'), p_ser, p_numdoc);

  -- проверка достаточности входных параметров для поиска вкладчика 
  /*l_enough := enough_search_params (p_dptid     => null,
                                    p_dptnum    => null,
                                    p_custid    => null,
                                    p_accnum    => null,
                                    p_custname  => p_nmk,
                                    p_custcode  => p_okpo,
                                    p_birthdate => p_bday,
                                    p_docserial => p_ser,
                                    p_docnum    => p_numdoc);*/
  
  if (p_nmk Is Not Null)
  then
    l_nmk :=  UPPER(p_nmk) || l_nmk;
  end if;
  
  OPEN t_cust FOR
    SELECT /*+ FIRST_ROWS(10) */
           c.rnk, c.nmk, c.okpo, c.adr, s.name, p.ser, p.numdoc, c.branch
      FROM customer c, person p, passp s
     WHERE c.rnk   = p.rnk
       AND p.passp = s.passp
       AND c.date_off IS NULL
       AND NVL(TRIM(c.sed), '00')     != '91'
       AND UPPER(c.nmk) LIKE l_nmk
       AND NVL(c.okpo,   '0000000000') = NVL(p_okpo,   NVL(c.okpo,  '0000000000') )
       AND NVL(p.bday,   g_nulldate  ) = NVL(p_bday,   NVL(p.bday,  g_nulldate)   )
       AND NVL(p.ser,    ' '         ) = NVL(p_ser,    NVL(p.ser,    ' ')         )
       AND NVL(p.numdoc, ' '         ) = NVL(p_numdoc, NVL(p.numdoc, ' ')         )
     ORDER BY UPPER(c.nmk);
  
  p_cust := t_cust;
  bars_audit.trace('%s выход', l_title);

END p_search_customer;
/
show err;

PROMPT *** Create  grants  P_SEARCH_CUSTOMER ***
grant EXECUTE                                                                on P_SEARCH_CUSTOMER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SEARCH_CUSTOMER.sql =========***
PROMPT ===================================================================================== 
