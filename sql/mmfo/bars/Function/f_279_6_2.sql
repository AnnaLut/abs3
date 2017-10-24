
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_279_6_2.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_279_6_2 
(p_6 int,               -- ������� ���������
 p_ND cc_deal.ND%type ) -- ��� ��
 RETURN specparam.s080%type IS

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
 l_m080 specparam.s080%type    ;  -- ��������� S080 �� ������ ��������� ���
 l_freq int_accn.freq%type     ;
 l_acc  TMP_REZ_RISK.acc%type  ;
 l_f080 specparam.s080%type    ;  -- ����������� s080
 l_kol  int := 0 ; -- ������� �������
 l_obs  int := 0 ; -- ����� = 1
--------------------------------
begin

  begin

    select decode ( nvl (d.fin,c.crisk),3, 2, 3 )
    into l_m080
    from cc_deal d , customer c
    where d.sos >=10 and d.sos<15                 -- ����������� ��
      and months_between(d.wdate,d.sdate ) > p_6  -- ����� 6 ���
      and d.fin in (3,4)  -- ��i��� � ������ ������������ "�" ��� "�"
      and d.obs = 1       --  �������������� ����� "�����"
      and d.rnk = c.rnk
      and d.nd = p_ND ;

    -- ������ �i�����i� - �� �i��� ������ ���� �� �_����
    -- (1=�����, 3=�������, 5=���i���� - � ����i��� ��� "���� Millennium".).
    select freq  into l_freq from nd_acc n, accounts a, int_accn i
    where n.nd  = p_ND       and n.acc = a.acc   and a.tip = 'LIM'
      and a.acc = i.acc      and i.id  = 0       and i.freq in (1,3,5);

    --  �������� ������� ����  (���� �� ���)
    select a.acc, nvl(s.s080,'0')
    into l_acc,l_f080 from nd_acc n,accounts a, specparam s
    where n.nd  = p_ND       and n.acc = a.acc   and a.tip = 'SS '
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

    If l_obs < p_6 OR  l_f080 = l_m080 then l_m080 := null; end if;

  exception when no_data_found then l_m080 := null;
  end;

  return l_m080;
end F_279_6_2 ;
/
 show err;
 
PROMPT *** Create  grants  F_279_6_2 ***
grant EXECUTE                                                                on F_279_6_2       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_279_6_2       to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_279_6_2.sql =========*** End *** 
 PROMPT ===================================================================================== 
 