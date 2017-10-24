
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_rnk.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_RNK 
(p_nbs2 accounts.nbs%type,
 p_ob22 accounts.ob22%type,
 p_nls1 accounts.nls%type,
 p_kv   accounts.kv%type default  null
)
  return accounts.nls%type is

/*
   Поиск счета по:  NBS + ОВ22 + RNK + BRANCH

      !!!  Поиск идет только среди ГРН-счетов  !!!
      =============================================

      RNK определяется через входящий счет p_nls1 /p_kv

      При нескольких конкурирующих счетах функция выбирает самый
      "молодой" (по DAOS) из них

      Добавлено:
        - вначале поиск идет с учетом равенства BRANCH-ей
        - если не нашли - без учета равества BRANCH-ей

*/

 l_nls2 accounts.nls%type;

begin

 BEGIN

   Select a2.nls
   into   l_nls2
   from   accounts a1, accounts a2
   Where  a1.nls = p_nls1 and a1.kv = nvl(p_kv, gl.baseval)
      and a2.nbs = p_nbs2
      and a2.kv  = Case When p_nbs2='3570' Then 980 Else a1.kv End
      and nvl(a2.ob22,'00') like p_OB22
      and a1.RNK = a2.RNK and a2.dazs is null
      and substr(p_nls1,6) = substr(a2.nls,6);

   RETURN l_NLS2;

 EXCEPTION when NO_DATA_FOUND then

   Begin
                  --- Ищем счет с требованием равенства BRANCH-ей
      Select nls2
      into   l_nls2 from
      ( Select a2.nls nls2
        From   accounts a1, accounts a2
        Where a1.nls = p_nls1 and a1.kv  = nvl(p_kv, gl.baseval)
          and a2.nbs = p_nbs2
          and a2.kv  = Case When p_nbs2='3570' Then 980 Else a1.kv End
          and nvl(a2.ob22,'00') like p_OB22
          and a1.rnk = a2.rnk and a2.dazs is null
          and a1.branch=a2.branch
        Order by a2.DAOS desc
       )
      where rownum=1;

      RETURN l_NLS2;

   Exception when NO_DATA_FOUND then

      begin     --- Ищем БЕЗ требования равенства BRANCH-ей

         Select nls2
         into   l_nls2 from
         ( Select a2.nls nls2
           From   accounts a1, accounts a2
           Where a1.nls = p_nls1 and a1.kv  = nvl(p_kv, gl.baseval)
             and a2.nbs = p_nbs2
             and a2.kv  = Case When p_nbs2='3570' Then 980 Else a1.kv End
             and nvl(a2.ob22,'00') like p_OB22
             and a1.rnk = a2.rnk and a2.dazs is null
           Order by a2.DAOS desc
          )
         where rownum=1;

         RETURN l_NLS2;

      exception when NO_DATA_FOUND then

         raise_application_error(
                -20203,
               '\9356 - Не найден счет: Бал='|| p_NBS2||' OB22='||p_OB22||
               ' для счета ' || p_nls1, TRUE);
      end;

   End;

 END;
end nbs_ob22_RNK;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_RNK ***
grant EXECUTE                                                                on NBS_OB22_RNK    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_OB22_RNK    to PYOD001;
grant EXECUTE                                                                on NBS_OB22_RNK    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_rnk.sql =========*** End *
 PROMPT ===================================================================================== 
 