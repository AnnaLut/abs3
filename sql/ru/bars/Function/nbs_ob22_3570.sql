
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_3570.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_3570 
(p_nbs2 accounts.nbs%type ,  -- ���. �������� �������� �����
 p_ob22 accounts.ob22%type,  -- OB22 �������� �������� �����
 p_nls1 accounts.nls%type ,  -- �������� ������� ����
 p_kv   accounts.kv%type default  null  -- B��.��������� ���.�����(�� �����.980)
)
  return accounts.nls%type is

/*

   ����� ����� ��  NBS + ��22 + RNK  (RNK ������������ ����� ��������
   ���� p_nls1/p_kv).


   � ������, ���� ���������� 3570/03 ����� 1-��, ������� ���� ACC1 �� RKO_LST
   ��� ����� ��������� �����

*/

 l_kv   accounts.kv%type := nvl(p_kv, gl.baseval);
 l_rnk  accounts.rnk%type;
 l_nls2 accounts.nls%type;
 l_acc1 accounts.acc%type;
 l_kol  int := 0;

begin


 ------    ������� RNK � ACC ��������� �������� �����:
 Begin

    Select RNK, ACC   into  l_rnk,l_acc1
    From   Accounts
    where  nls=p_nls1 and kv=l_kv;

 Exception when NO_DATA_FOUND then
   raise_application_error(  -20203,
    '\9356 - �� ������ ����: ' || p_nls1 || '/' || l_kv, TRUE );
 End;


 l_kol := 0;
 FOR k in ( Select nls from Accounts  where
                    RNK = l_rnk
               and  NBS = p_nbs2 and OB22 = p_OB22
               and  KV  = 980    --- ���� ������ ���-����� 3570/03
               and  DAZS is null
            order by DAOS
          )
 loop
    l_kol  := l_kol + 1;
    l_nls2 := k.nls ;   ---  � l_nls2 �������� ����� "�������" ����  (***)
 end loop;

 ----------------------------------------------------------------


 If  l_kol = 1   then

    RETURN l_NLS2;    --- ���� l_kol=1  - ���, ����� - RETURN

 Elsif  l_kol = 0   then

    ---  ��� ����� ������ ������:
    raise_application_error(-20203,
     '\9356 - �� ������ ����: ���='|| p_NBS2||', OB22='||p_OB22||
     ' ��� ����� ' || p_nls1 || '/' || l_kv,  TRUE );


 Elsif l_kol > 1  then

    ---  ������� ����� ������ ����� 3570/03
    ---  ����� � RKO_LST � ������� ��� ��������� ���� RKO_LST.���1 (3570) :

    Begin

      if l_kv = 980 then     --- �������� 2600 � ���

         Select a.nls into l_nls2
         from   RKO_LST r, Accounts a
         where  r.ACC  = l_acc1       ---   �������� 2600
           and  nvl(r.ACC1,-333 ) = a.ACC
           -----  and  a.RNK  = l_rnk   ---<  �� ������� ��������� RNK ��������� 2600 � 3570 �� RKO_LST
           and  a.KV   = 980
           and  a.DAZS is null;

      else                   --- �������� - ��������  ->  � RKO_LST ��� ���.

         --- ���� ACC ����a � ����� �� NLS, �� �� 980.
         --- �� ���� ��� ����� ������ � RKO_LST.

         Select ACC   into  l_acc1
         From   Accounts
         where  nls = p_nls1 and kv = 980 and RNK = l_rnk ;

         Select a.nls into l_nls2
         from   RKO_LST r, Accounts a
         where  r.ACC  = l_acc1      ---   �������� 2600
           and  nvl(r.ACC1,-333 ) = a.ACC
           -----  and  a.RNK  = l_rnk   ---<  �� ������� ��������� RNK ��������� 2600 � 3570 �� RKO_LST
           and  a.KV   = 980
           and  a.DAZS is null;

      end if;


    Exception when NO_DATA_FOUND then

      ---  � RKO_LST.ACC1 - �����, �� ����� ����� "�������" 3570/03

      RETURN l_NLS2;    ---  � l_nls2 ����� "�������" 3570/03

    End;


 End If;


 RETURN l_NLS2;

end nbs_ob22_3570;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_3570.sql =========*** End 
 PROMPT ===================================================================================== 
 