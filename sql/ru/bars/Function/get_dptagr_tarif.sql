
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_dptagr_tarif.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_DPTAGR_TARIF 
  (p_dptid    dpt_deposit.deposit_id%type,
   p_tarifid  tarif.kod%type)
   RETURN number
IS
  l_title  varchar2(60) := 'f_dpt_tarif: ';
  l_nls    accounts.nls%type;
  l_kv     accounts.kv%type;
  l_saldo  accounts.ostc%type;

  l_amount number(38);
BEGIN

  bars_audit.trace('%s договор № %s, тариф № %s ',l_title,
                   to_char(p_dptid), to_char(p_tarifid));


  BEGIN
    SELECT a.nls, a.kv, decode(a.ostc, 0, a.ostb, a.ostc)
      INTO l_nls, l_kv, l_saldo
      FROM dpt_deposit d, accounts a
     WHERE d.acc = a.acc AND d.deposit_id = p_dptid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_error('DPT', 'DPT_NOT_FOUND', to_char(p_dptid));
  END;

  bars_audit.trace(l_title||'текущий остаток на счете %s = %s',
                   l_nls ||'/'|| to_char(l_kv), to_char(l_saldo));


  BEGIN
    l_amount := f_tarif (p_tarifid, gl.baseval, l_nls, l_saldo);
  EXCEPTION
    WHEN OTHERS THEN
      bars_error.raise_error('DPT', 250, to_char(p_tarifid), l_nls, to_char(l_kv));
  END;
  bars_audit.trace(l_title||'сумма комиссии = %s', to_char(l_amount));

  RETURN l_amount;

END get_dptagr_tarif;
/
 show err;
 
PROMPT *** Create  grants  GET_DPTAGR_TARIF ***
grant EXECUTE                                                                on GET_DPTAGR_TARIF to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_DPTAGR_TARIF to START1;
grant EXECUTE                                                                on GET_DPTAGR_TARIF to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_dptagr_tarif.sql =========*** E
 PROMPT ===================================================================================== 
 