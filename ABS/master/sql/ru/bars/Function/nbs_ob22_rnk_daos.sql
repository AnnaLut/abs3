
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_rnk_daos.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_RNK_DAOS 
(p_nbs2 accounts.nbs%type,
 p_ob22 accounts.ob22%type,
 p_nls1 accounts.nls%type,
 p_kv   accounts.kv%type default  null
)
  return accounts.nls%type is

/*
    06/04/2011 Суфтин

    Поиск счета по  NBS + ОВ22 + RNK  (RNK определяется через счет nls/kv).
    В отличие от NBS_OB22() эта ф-я BRANCH-контекст НЕ учитывает !!!

    Эта функция = функции nbs_ob22_RNK, но она хватает не первый попавшийся
    счет, а самый "молодой" по DAOS.

*/

 l_nls2 accounts.nls%type;

begin
   begin
      select nls2
      into   l_nls2 from
      ( select a2.nls nls2
        from   accounts a1, accounts a2
        where a1.nls = p_nls1 and a1.kv  = nvl(p_kv, gl.baseval)
          and a2.nbs = p_nbs2 and a2.kv  = a1.kv   and a2.ob22 = p_OB22
          and a1.rnk = a2.rnk and a2.dazs is null order by a2.DAOS desc
       )
      where rownum=1;

      return l_NLS2;

   exception when NO_DATA_FOUND then
      raise_application_error(
             -20203,
            '\9356 - Не найден счет: Бал='|| p_NBS2||' OB22='||p_OB22||
            ' для счета ' || p_nls1,
            TRUE);
   end;

end nbs_ob22_RNK_DAOS;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_RNK_DAOS ***
grant EXECUTE                                                                on NBS_OB22_RNK_DAOS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_OB22_RNK_DAOS to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_rnk_daos.sql =========*** 
 PROMPT ===================================================================================== 
 