
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bezn_not_6110.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BEZN_NOT_6110 
(
 p_nls1   VARCHAR2    -- входящий счет (счет-Дт)
)
 return VARCHAR2  is

-----------------------------------------------------------------
---   Функция выбора 6110 для комиссии за БЕЗналичн.перечисления
---   на счета аккред. нотариусов
-----------------------------------------------------------------

 l_nls2  accounts.nls%type;    ----  искомый 6110
 l_rnk   accounts.RNK%type;
 bussl_  varchar2(20)     ;

begin

    IF substr(p_nls1,1,4)='2620' then

       l_nls2:=NBS_OB22('6110','F3');   --- ФО

    ELSE

       l_nls2:=NBS_OB22('6110','F2');   --- ЮО:  ММСБ и КБ

        -- Begin
        --
        --    Select RNK  into  l_rnk
        --    from   Accounts
        --    where  NLS=p_nls1 and KV=980 and DAZS is NULL;
        --
        --    Select VALUE  into  bussl_
        --    from   CustomerW
        --    where  RNK=l_rnk and TAG='BUSSL';
        --                             -------
        --
        --    If bussl_='ММСБ' then
        --       l_nls2:=NBS_OB22('6110','??');   --- ММСБ
        --    Else
        --       l_nls2:=NBS_OB22('6110','??');   --- КБ
        --    End If;
        --
        -- EXCEPTION WHEN OTHERS THEN
        --
        --    l_nls2:=NBS_OB22('6110','??');      --- ММСБ
        --
        -- End;

    END IF;

    RETURN l_nls2;

End Bezn_Not_6110;
/
 show err;
 
PROMPT *** Create  grants  BEZN_NOT_6110 ***
grant EXECUTE                                                                on BEZN_NOT_6110   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bezn_not_6110.sql =========*** End 
 PROMPT ===================================================================================== 
 