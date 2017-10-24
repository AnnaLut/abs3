

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_279_6_2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_279_6_2 ***

  CREATE OR REPLACE PROCEDURE BARS.P_279_6_2 
(p_Custytpe char,               -- ��� ��: 2=��, 3=��
 p_6 int,                       -- ������� ���������
 p_branch cc_deal.branch%type   -- ����� ��� ���
 )
 IS

/*
����i���i� ������ ������ 6.2 ��������� �279.
 "����������� �� ��i�� �������i� ������"  �� ����i:
  - ��������� �����i� �i� �� ����� �i� �i��� �i���i�
  - ��i��� � ������ ������������ "�" ��� "�"
  - �������������� ����� �������� 6 �_���_� "�����"
  - �� ������ �i�����i� - �� �i��� ������ ���� �� �_����
    (1=�����, 3=�������, 5=���i���� - � ����i��� ��� "���� Millennium".).
 ���� ���� ������������ = 3 (�), �� s080 = 2 (�i� ���������)
 ���� ���� ������������ = 4 (�), �� s080 = 3 (�������������)
*/
-------------------------------
 l_m080 specparam.s080%type    ;  -- ��������� S080 ��  ������ ��������� ���
 l_r080 specparam.s080%type    ;  -- ��������� S080 ��� ������ ��������� ���
 l_freq int_accn.freq%type     ;
 l_acc  TMP_REZ_RISK.acc%type  ;
 l_FIN  char(3)                ;
 l_f080 specparam.s080%type    ;  -- ����������� s080
 l_kol  int := 0 ; -- ������� �������
 l_obs  int := 0 ; -- ����� = 1
--------------------------------
begin

 execute immediate ' truncate table Bars.TMP_CCK_REP ';

 For k in (select nvl(d.fin,c.crisk) FIN, d.nd, d.sdate, d.wdate, c.nmk,d.branch, d.cc_id
           from cc_deal d , customer c
           where d.sos >=10 and d.sos<15                 -- ����������� ��
             and months_between(d.wdate,d.sdate ) > p_6  -- ����� 6 ���
             and d.fin in (3,4)  -- ��i��� � ������ ������������ "�" ��� "�"
             and d.obs = 1       --  �������������� ����� "�����"
             and d.rnk = c.rnk
             and d.branch like p_branch
             and (   p_Custytpe = '2' and d.vidd in ( 1, 2, 3)
                  OR p_Custytpe = '3' and d.vidd in (11,12,13)
                  )
             )
 loop
    begin
      -- ������ �i�����i� - �� �i��� ������ ���� �� �_����
      -- (1=�����, 3=�������, 5=���i���� - � ����i��� ��� "���� Millennium".).
      select freq  into l_freq from nd_acc n, accounts a, int_accn i
      where n.nd  = k.ND       and n.acc = a.acc   and a.tip = 'LIM'
        and a.acc = i.acc      and i.id  = 0       and i.freq in (1,3,5);

      --  �������� ������� ����  (���� �� ���)
      select a.acc, nvl(s.s080,'0')
      into l_acc,l_f080 from nd_acc n,accounts a, specparam s
      where n.nd  = k.ND       and n.acc = a.acc   and a.tip = 'SS '
        and a.dazs is null     and a.ostc < 0      and a.acc = s.acc (+)
        and rownum = 1;

      -- �������������� ����� �������� 6 �i���i� "�����"
      -- ���� � ������ �������� �� �������� �����

      l_kol := 0; l_obs := 0;
      for z in (select obs from TMP_REZ_RISK t where acc = l_acc   and exists
                  (select 1 from REZ_PROTOCOL where userid=t.id and dat = t.dat)
                order by t.dat desc   )
      loop
         if l_kol < p_6 and z.obs = 1 then   l_obs := l_obs + 1;    end if;
         l_kol := l_kol + 1 ;
      end loop;

      If k.FIN = 3 then l_m080 := '2'; l_fin := '3=�';
      else              l_m080 := '3'; l_fin := '4=�';
      end if;

      If l_obs < p_6 OR  l_f080 = l_m080 then  null;
      else

         SELECT s080 INTO l_r080  FROM fin_obs_s080 WHERE  FIN =k.fin and obs = 1;

         insert into TMP_CCK_REP
            (BRANCH, ND, CC_ID, SDATE,VDAT , NMK, tt, NAM_A, NLSA,  MFOA)  values
            (k.branch,k.nd, substr(k.cc_id,1,40),k.sdate,k.wdate,k.nmk, l_fin,
                 l_f080, l_r080, l_m080);
      end if;
    exception when no_data_found then null;
    end;

 end loop;

 return ;

end P_279_6_2 ;
/
show err;

PROMPT *** Create  grants  P_279_6_2 ***
grant EXECUTE                                                                on P_279_6_2       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_279_6_2       to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_279_6_2.sql =========*** End ***
PROMPT ===================================================================================== 
