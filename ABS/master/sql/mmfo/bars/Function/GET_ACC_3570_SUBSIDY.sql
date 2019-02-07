create or replace function GET_ACC_3570_SUBSIDY -- ��������� ��� �������� � �������� ����� 3570 ��� ����������
(
 p_rnk accounts.rnk%type
)
---------------------------------------------------------------------------
---
---    �-� ������ 3570/03 ��� ���������� �������� �� ���.������� ��
---
---------------------------------------------------------------------------

 return accounts.nls%type is            --  ������� ���-����-���������� ��������

-- l_rnk   accounts.rnk%type;   --  ��� ��������� �����
 l_acc1  accounts.acc%type;   --  ACC ��������� �����
 l_kol   int := 0;
 
 l_nbs   accounts.nbs%type := '3570';  --  ��� 3570
 l_kv    accounts.kv%type  := 980;   -- ������ ����� 3570
 l_grp   groups_acc.id%type := 14;   --������ ����� 3570
 l_ob22  accounts.ob22%type := '62'; -- ob22 ����� 3570
 l_NLS1  accounts.nls%type;   --  ����� ����� �����
 l_NLS2  accounts.nls%type;   --  ������� ����
 l_nms   customer.nmk%type;   -- ������������ �������


 l_p4  int; -- ������������ ��������

begin

 ------    ������� RNK � ACC  ��������� �������� �����:
 Begin

    Select ACC
      into l_acc1
      From Accounts
     where rnk = p_rnk
       and nbs = l_nbs
       and ob22 = l_ob22
       and kv = l_kv
       and dazs is null;

   Exception when NO_DATA_FOUND then
      begin
         l_nls1 := Get_NLS(l_kv,l_nbs);
         op_reg_ex(mod_=> 99,
                   p1_ =>0,
                   p2_=>0,
                   p3_=> l_grp,
                   p4_=>l_p4,
                   rnk_=> p_rnk,
                   nls_ => l_nls1,
                   kv_ => l_kv,
                   nms_=> substr(l_nms, 1, 70),
                   tip_=> 'ODB' ,
                   isp_ => gl.Auid,
                   accR_=> l_acc1);

         Accreg.setAccountSParam(l_acc1, 'OB22', l_ob22) ;
         Accreg.setAccountSParam(l_acc1, 'R011', '1' );
         Accreg.setAccountSParam(l_acc1, 'S180', '1' );
         Accreg.setAccountSParam(l_acc1, 'R013', '2' );
         Accreg.setAccountSParam(l_acc1, 'S240', '�������������');
      End;
 End;


 ----------------------------------------------------------------

 l_kol := 0;
 FOR k in ( Select nls from Accounts
             where RNK = p_rnk and NBS = l_nbs and OB22=l_ob22
               and KV  = l_kv   and DAZS is null
            order by DAOS desc
          )
 loop
    l_kol  := l_kol + 1;
    l_NLS2 := k.nls ;   ---  � l_NLS2 - ����� "������" 3570
 end loop;

 ----------------------------------------------------------------

 RETURN l_NLS2;

end GET_ACC_3570_SUBSIDY;
/
