
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bezn_not_6110.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BEZN_NOT_6110 
(
 p_nls1   VARCHAR2    -- �������� ���� (����-��)
)
 return VARCHAR2  is

-----------------------------------------------------------------
---   ������� ������ 6110 ��� �������� �� ���������.������������
---   �� ����� ������. ����������
-----------------------------------------------------------------

 l_nls2  accounts.nls%type;    ----  ������� 6110
 l_rnk   accounts.RNK%type;
 bussl_  varchar2(20)     ;

begin

    IF substr(p_nls1,1,4)='2620' then

       l_nls2:=NBS_OB22('6110','F3');   --- ��

    ELSE

       l_nls2:=NBS_OB22('6110','F2');   --- ��:  ���� � ��

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
        --    If bussl_='����' then
        --       l_nls2:=NBS_OB22('6110','??');   --- ����
        --    Else
        --       l_nls2:=NBS_OB22('6110','??');   --- ��
        --    End If;
        --
        -- EXCEPTION WHEN OTHERS THEN
        --
        --    l_nls2:=NBS_OB22('6110','??');      --- ����
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
 