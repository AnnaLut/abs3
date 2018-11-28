CREATE OR REPLACE function BARS.nbs_ob22_RKO
(p_nbs2 accounts.nbs%type ,  -- Бал. искомого лицевого счета
 p_ob22 accounts.ob22%type,  -- OB22 искомого лицевого счета
 p_nls1 accounts.nls%type ,             -- Входящий лиц.счет   #(NLSA)
 p_kv   accounts.kv%type default  null  -- Bал.вход.лиц.счета  #(KVA)
)
  return accounts.nls%type is

--------------------------------------------------------------------------------
--   Поиск счета по  NBS + ОВ22 + RNK  (RNK определяется через входящий
--   счет p_nls1/p_kv).
--
--
--               Поиск идет только среди ГРН-счетов  !!!
--
--
--   В случае, если подходящих счетов более 1-го, берется счет ACCD из RKO_LST
--   (ACCD - "Рах.списання" в задаче "Плата за РО" )
--------------------------------------------------------------------------------


 l_kv      accounts.kv%type := nvl(p_kv, gl.baseval);  --- KV   вход.лиц.счета  
 l_rnk     accounts.rnk%type;                          --- RNK  вход.лиц.счета
 l_ob22_1  accounts.ob22%type;                         --- OB22 вход.лиц.счета
 l_acc1    accounts.acc%type;                          --- ACC  вход.лиц.счета

 l_nls2    accounts.nls%type;       ---  искомый счет
 l_kol  int := 0;

begin


 If substr(p_nls1,1,4) in ('2642','2643','2620') and p_kv = 980 then  -- Эти счета всегда платят 
    RETURN p_nls1;                                                    -- комиссию "сами за себя"
 End If;


 ------    Находим RNK и ACC  входящего лицевого счета:
 Begin

    Select RNK, ACC, OB22   into  l_rnk, l_acc1, l_ob22_1
    From   Accounts
    where  nls=p_nls1 and kv=l_kv;

 Exception when NO_DATA_FOUND then
   raise_application_error(  -20203,
    '\9356 - Не найден счет: ' || p_nls1 || '/' || l_kv, TRUE );
 End;



 ---------------------------   COBUMMFO-8671  -------------------------------------------------------
 ---  Если l_kv=980 то ищем вход.счет в RKO_LST и если для него проставлен какой-то иной "Рах.списання" 
 ---  (ACCD не NULL), то берем его  ( не глядя ни на ОВ22, ни на RNK)  

 If l_kv = 980  then

    Begin
      Select a.nls into l_nls2                                
      from   RKO_LST r, Accounts a                            
      where  r.ACC  = l_acc1                                  
        and  r.ACCD is not NULL  
        and  r.ACCD = a.ACC                          
    --- and  a.RNK  = l_rnk                                   
        and  a.KV   = 980                                     
    --- and  a.OB22 = p_OB22
        and  a.DAZS is null;
    
      RETURN l_nls2 ; 
    
    Exception when NO_DATA_FOUND then
      null ;
    End;

 End If;
 -----------------------------------------------------------------------------------------------------


 l_kol := 0;
 FOR k in ( Select nls from Accounts  where   RNK = l_rnk
               and ( NBS in ('2600',
                             '2650') and OB22 = '01'  and  p_nls1 like '26%'    -- для 2600,2603,2604,2650
                        or
                      NBS = '2560'   and OB22 = '03'  and  p_nls1 like '256%'   -- для 2560,2565
                        or
                      NBS = '2520'                    and  p_nls1 like '2520%'
                        or
                      NBS = '2530'                    and  p_nls1 like '2530%'
                        or
                      NBS = '2545'                    and  p_nls1 like '2545%'
                    )
               and KV  = 980         --- ищем только ГРН-счета
               and DAZS is null
            order by DAOS 
          )
 loop
    l_kol  := l_kol + 1;
    l_nls2 := k.nls ;   ---  В l_nls2 остается самый "молодой" счет    (***)
 end loop;

 ----------------------------------------------------------------


 If l_kol = 1   then

    RETURN l_nls2 ;        --- Если l_kol=1  - нашли один - RETURN
  
 Elsif  l_kol = 0   then

    ---  Нет таких счетов вообще:
     
    if    substr(p_nls1,1,3) = '256' then

       raise_application_error(-20203,
       '\9356 - Не найден счет: Бал=2560, OB22=03'||
       ' для счета ' || p_nls1 || ' / ' || l_kv,  TRUE );

    elsif substr(p_nls1,1,4) in ('2520','2530','2545') then

       raise_application_error(-20203,
       '\9356 - Не найден счет: Бал='|| substr(p_nls1,1,4)||', Вал=980'||
       ' для счета ' || p_nls1 || ' / ' || l_kv,  TRUE );

    else

       raise_application_error(-20203,
       '\9356 - Не найден счет: Бал=2600/2650, OB22=01, Вал=980'||
       ' для счета ' || p_nls1 || ' / ' || l_kv,  TRUE );

    end if;


 Elsif l_kol > 1 and l_kv=980 then

    ---  Нашлось более ОДНОГО "подходящего" счета и входящий - ГРН:
    ---  Лезем в RKO_LST и находим для входящего счета "Рах.списання":
    Begin

      Select a.nls into l_nls2
      from   RKO_LST r, Accounts a
      where  r.ACC  = l_acc1
        and  nvl(r.ACCD,r.ACC) = a.ACC
        and  a.RNK  = l_rnk
        and  a.KV   = 980
    --- and  a.OB22 = p_OB22
        and  a.DAZS is null;

    Exception when NO_DATA_FOUND then

       if substr(p_nls1,1,4)='2600' and l_ob22_1 = '01'   then
           l_nls2 := p_nls1;   -- Eсли входящий 2600/01, то возвращаем его.
       end if;                 -- В противном случае оставляем найденый в (***)

    End ;

 Elsif l_kol > 1 and l_kv<>980 then

    ---  Нашлось более ОДНОГО "подходящего" счета и входящий - ВАЛЮТНЫЙ !!!
    ---  Лезем в RKO_LST и находим "Рах.списання", но не для входящего
    ---  счета (он валютный !), а для l_nls2 - последнего из найденных,
    ---  т.е. самого молодого 2600/01

    Begin
                              -- Вначале ищем ГРН-счет с номером (NLS), как у входящего валютного
      Select nls into l_nls2   
      From   Accounts
      where  nls = p_nls1  and  kv=980
        and  RNK = l_rnk   and  DAZS is NULL ;

    Exception when NO_DATA_FOUND then

      Begin  

         Select b.nls into l_nls2
         from   RKO_LST r, Accounts a, Accounts b
         where  a.NLS  = l_nls2
           and  a.KV   = 980
           and  r.ACC  = a.ACC
           and  b.ACC  = nvl(r.ACCD,r.ACC);

      Exception when NO_DATA_FOUND then

         RETURN l_nls2;

      End;

    End;

 End If;


 RETURN l_nls2;

end nbs_ob22_RKO;
/
