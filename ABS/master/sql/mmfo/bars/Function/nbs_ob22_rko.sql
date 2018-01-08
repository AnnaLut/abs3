
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_rko.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_RKO 
(p_nbs2 accounts.nbs%type ,  -- ���. �������� �������� �����
 p_ob22 accounts.ob22%type,  -- OB22 �������� �������� �����
 p_nls1 accounts.nls%type ,  -- �������� ������� ����
 p_kv   accounts.kv%type default  null  -- B��.��������� ���.�����(�� �����.980)
)
  return accounts.nls%type is

/*
   ����� ����� ��  NBS + ��22 + RNK  (RNK ������������ ����� ��������
   ���� p_nls1/p_kv).

           !!!  ����� ���� ������ ����� ���-������  !!!
           =============================================

   �-�  BRANCH-�������� �� ��������� !

   � ������, ���� ���������� ������ ����� 1-��, ������� ���� ACCD �� RKO_LST
   (ACCD - "���.��������" � ������ "����� �� ��" )

*/

 l_kv   accounts.kv%type := nvl(p_kv, gl.baseval);
 l_rnk  accounts.rnk%type;
 l_nls2 accounts.nls%type;
 l_acc1 accounts.acc%type;
 l_kol  int := 0;

begin


 ------    ������� RNK � ACC  ��������� �������� �����:
 Begin

    Select RNK, ACC   into  l_rnk,l_acc1
    From   Accounts
    where  nls=p_nls1 and kv=l_kv;

 Exception when NO_DATA_FOUND then
   raise_application_error(  -20203,
    '\9356 - �� ������ ����: ' || p_nls1 || '/' || l_kv, TRUE );
 End;


 l_kol := 0;
 FOR k in (Select nls from Accounts  where RNK = l_rnk
               and ( (NBS = p_nbs2  or  NBS = '2650') and OB22 = p_OB22
                        or
                      NBS='2560' and OB22='03'
                        or
                      NBS='2620' and OB22 in ('07','32')
                        or
                      NBS='2642'
                        or
                      NBS='2643'
                   )
               and KV  = 980         --- ���� ������ ���-�����
               and DAZS is null
           order by DAOS )
 loop
    l_kol  := l_kol + 1;
    l_nls2 := k.nls ;   ---  � l_nls2 �������� ����� "�������" ����  (***)
 end loop;

 ----------------------------------------------------------------

 If substr(p_nls1,1,4) in ('2642','2643') then

    RETURN p_nls1;

 Elsif  l_kol = 1   then

    RETURN l_NLS2;    --- ���� l_kol=1  - ���, ����� - RETURN

 Elsif  l_kol = 0   then
    ---  ��� ����� ������ ������:
    raise_application_error(-20203,
     '\9356 - �� ������ ����: ���='|| p_NBS2||', OB22='||p_OB22||
     ' ��� ����� ' || p_nls1 || '/' || l_kv,  TRUE );


 Elsif l_kol > 1 and l_kv=980 then

    ---  ������� ����� ������ ����� 2600/01 � �������� - ���.

    ---  ����� � RKO_LST � ������� ��� ��������� ����� "���.��������":
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
        ----  � RKO_LST ��������� ����� �� �������:
        if substr(p_nls1,1,4)=p_nbs2  then
           l_nls2:=p_nls1; -- E��� �������� � ������� ����� ��������� ��
        end if;            -- �����������, �� ���������� ��� �������� ����.
                           -- � ��������� ������ ��������� �������� ���� (***)
    End;


 Elsif l_kol > 1 and l_kv<>980 then

    ---  ������� ����� ������ ����� 2600/01 � �������� - ��������

    ---  ����� � RKO_LST � ������� "���.��������", �� �� ��� ���������
    ---  ����� (�� �������� !), � ��� l_nls2 - ���������� �� ���������,
    ---  �.�. ������ �������� 2600/01

    Begin
                              -- ������� ���� ���-���� � �������
      Select nls into l_nls2  -- (NLS), ��� � ��������� ���������
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

         RETURN l_NLS2;

      End;

    End;

 End If;


 RETURN l_NLS2;

end nbs_ob22_RKO;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_RKO ***
grant EXECUTE                                                                on NBS_OB22_RKO    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_OB22_RKO    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_rko.sql =========*** End *
 PROMPT ===================================================================================== 
 