CREATE OR REPLACE function BARS.nbs_ob22_RKO
(p_nbs2 accounts.nbs%type ,  -- ���. �������� �������� �����
 p_ob22 accounts.ob22%type,  -- OB22 �������� �������� �����
 p_nls1 accounts.nls%type ,             -- �������� ���.����   #(NLSA)
 p_kv   accounts.kv%type default  null  -- B��.����.���.�����  #(KVA)
)
  return accounts.nls%type is

--------------------------------------------------------------------------------
--   ����� ����� ��  NBS + ��22 + RNK  (RNK ������������ ����� ��������
--   ���� p_nls1/p_kv).
--
--
--               ����� ���� ������ ����� ���-������  !!!
--
--
--   � ������, ���� ���������� ������ ����� 1-��, ������� ���� ACCD �� RKO_LST
--   (ACCD - "���.��������" � ������ "����� �� ��" )
--------------------------------------------------------------------------------


 l_kv   accounts.kv%type := nvl(p_kv, gl.baseval);
 l_rnk  accounts.rnk%type;
 l_nls2 accounts.nls%type;
 l_acc1 accounts.acc%type;
 l_kol  int := 0;

begin


 If substr(p_nls1,1,4) in ('2642','2643','2620') and p_kv = 980 then  -- ��� ����� ������ ������ 
    RETURN p_nls1;                                                    -- �������� "���� �� ����"
 End If;


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
 FOR k in ( Select nls from Accounts  where   RNK = l_rnk
               and ( NBS in ('2600',
                             '2650') and OB22 = '01'  and  p_nls1 like '26%'  -- ��� 2600,2603,2604,2650
                        or
                      NBS = '2560'   and OB22 = '03'  and  p_nls1 like '2560%'
                        or
                      NBS = '2520'                    and  p_nls1 like '2520%'
                        or
                      NBS = '2530'                    and  p_nls1 like '2530%'
                        or
                      NBS = '2545'                    and  p_nls1 like '2545%'
                    )
               and KV  = 980         --- ���� ������ ���-�����
               and DAZS is null
            order by DAOS 
          )
 loop
    l_kol  := l_kol + 1;
    l_nls2 := k.nls ;   ---  � l_nls2 �������� ����� "�������" ����  (***)
 end loop;

 ----------------------------------------------------------------


 If l_kol = 1   then

    RETURN l_NLS2;        --- ���� l_kol=1  - ����� ���� - RETURN


 Elsif  l_kol = 0   then

    ---  ��� ����� ������ ������:
     
    if    substr(p_nls1,1,4) = '2560' then

       raise_application_error(-20203,
       '\9356 - �� ������ ����: ���=2560, OB22=03'||
       ' ��� ����� ' || p_nls1 || ' / ' || l_kv,  TRUE );

    elsif substr(p_nls1,1,4) in ('2520','2530','2545') then

       raise_application_error(-20203,
       '\9356 - �� ������ ����: ���='|| substr(p_nls1,1,4)||', ���=980'||
       ' ��� ����� ' || p_nls1 || ' / ' || l_kv,  TRUE );

    else

       raise_application_error(-20203,
       '\9356 - �� ������ ����: ���=2600/2650, OB22=01, ���=980'||
       ' ��� ����� ' || p_nls1 || ' / ' || l_kv,  TRUE );

    end if;



 Elsif l_kol > 1 and l_kv=980 then

    ---  ������� ����� ������ ����� 2600/01 � �������� - ���:
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

