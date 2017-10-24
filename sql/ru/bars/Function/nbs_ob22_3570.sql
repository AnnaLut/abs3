
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_3570.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_3570 
(p_nbs2 accounts.nbs%type ,  -- Бал. искомого лицевого счета
 p_ob22 accounts.ob22%type,  -- OB22 искомого лицевого счета
 p_nls1 accounts.nls%type ,  -- Входящий лицевой счет
 p_kv   accounts.kv%type default  null  -- Bал.входящего лиц.счета(по умолч.980)
)
  return accounts.nls%type is

/*

   Поиск счета по  NBS + ОВ22 + RNK  (RNK определяется через входящий
   счет p_nls1/p_kv).


   В случае, если подходящих 3570/03 более 1-го, берется счет ACC1 из RKO_LST
   для этого входящего счета

*/

 l_kv   accounts.kv%type := nvl(p_kv, gl.baseval);
 l_rnk  accounts.rnk%type;
 l_nls2 accounts.nls%type;
 l_acc1 accounts.acc%type;
 l_kol  int := 0;

begin


 ------    Находим RNK и ACC входящего лицевого счета:
 Begin

    Select RNK, ACC   into  l_rnk,l_acc1
    From   Accounts
    where  nls=p_nls1 and kv=l_kv;

 Exception when NO_DATA_FOUND then
   raise_application_error(  -20203,
    '\9356 - Не найден счет: ' || p_nls1 || '/' || l_kv, TRUE );
 End;


 l_kol := 0;
 FOR k in ( Select nls from Accounts  where
                    RNK = l_rnk
               and  NBS = p_nbs2 and OB22 = p_OB22
               and  KV  = 980    --- ищем только ГРН-счета 3570/03
               and  DAZS is null
            order by DAOS
          )
 loop
    l_kol  := l_kol + 1;
    l_nls2 := k.nls ;   ---  В l_nls2 остается самый "молодой" счет  (***)
 end loop;

 ----------------------------------------------------------------


 If  l_kol = 1   then

    RETURN l_NLS2;    --- Если l_kol=1  - все, нашли - RETURN

 Elsif  l_kol = 0   then

    ---  Нет таких счетов вообще:
    raise_application_error(-20203,
     '\9356 - Не найден счет: Бал='|| p_NBS2||', OB22='||p_OB22||
     ' для счета ' || p_nls1 || '/' || l_kv,  TRUE );


 Elsif l_kol > 1  then

    ---  Нашлось более ОДНОГО счета 3570/03
    ---  Лезем в RKO_LST и находим для входящего счет RKO_LST.АСС1 (3570) :

    Begin

      if l_kv = 980 then     --- Входяший 2600 в ГРН

         Select a.nls into l_nls2
         from   RKO_LST r, Accounts a
         where  r.ACC  = l_acc1       ---   Входяший 2600
           and  nvl(r.ACC1,-333 ) = a.ACC
           -----  and  a.RNK  = l_rnk   ---<  НЕ требуем равенства RNK входящего 2600 и 3570 из RKO_LST
           and  a.KV   = 980
           and  a.DAZS is null;

      else                   --- Входящий - валютный  ->  в RKO_LST его нет.

         --- Ищем ACC счетa с таким же NLS, но по 980.
         --- По нему уже будем искать в RKO_LST.

         Select ACC   into  l_acc1
         From   Accounts
         where  nls = p_nls1 and kv = 980 and RNK = l_rnk ;

         Select a.nls into l_nls2
         from   RKO_LST r, Accounts a
         where  r.ACC  = l_acc1      ---   Входяший 2600
           and  nvl(r.ACC1,-333 ) = a.ACC
           -----  and  a.RNK  = l_rnk   ---<  НЕ требуем равенства RNK входящего 2600 и 3570 из RKO_LST
           and  a.KV   = 980
           and  a.DAZS is null;

      end if;


    Exception when NO_DATA_FOUND then

      ---  В RKO_LST.ACC1 - пусто, то берем самый "молодой" 3570/03

      RETURN l_NLS2;    ---  В l_nls2 самый "молодой" 3570/03

    End;


 End If;


 RETURN l_NLS2;

end nbs_ob22_3570;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_3570.sql =========*** End 
 PROMPT ===================================================================================== 
 