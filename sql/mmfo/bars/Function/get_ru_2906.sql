
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_ru_2906.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_RU_2906 (p_branch in varchar2, p_kv in integer) return varchar2 is
  l_mfo     banks.mfo%type;
  l_mfo_ru  banks.mfo%type;
  l_rnk     accounts.rnk%type;
  l_nls     accounts.nls%type;
begin
  l_mfo := substr(p_branch,2,6);
  begin
     select decode (mfop,gl.amfo, mfo, mfop ) into l_mfo_ru
     from banks where mfo=l_mfo;
  exception when no_data_found then
     raise_application_error (-20001, 'get_ru_2906: MFO_RU_NOT_FOUND for MFO='|| l_mfo);
  end;
  begin
     select a.rnk into l_rnk
     from accounts a, bank_acc b
     where a.tip='L00' and a.kv=980 and a.acc=b.acc and b.mfo=l_mfo_ru;
  exception when no_data_found then
     raise_application_error (-20001, 'get_ru_2906: RNK_NOT_FOUND for MFO_RU='|| l_mfo_ru);
  end;
  begin
     select a.nls into l_nls
     from accounts a
     where a.tip='TK ' and a.kv=p_kv and a.rnk=l_rnk;
  exception when no_data_found then
     raise_application_error (-20001, 'get_ru_2906: NLS_NOT_FOUND for MFO_RU='|| l_mfo_ru);
  end;
  return l_nls;
end get_ru_2906;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_ru_2906.sql =========*** End **
 PROMPT ===================================================================================== 
 