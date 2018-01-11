
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fost.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOST (p_acc integer, p_date date)
return number
    --
    -- ���������� ������� �� ����� �� ����
    --
    -- ���� ����� ���� �����, ���������� ���� �����������
    --
is
    l_ostc   number;
    l_dapp   date;
    l_turns  number;
begin
    -- ������� ������� ������� � ���� ���������� ��������
    select ostc, dapp
      into l_ostc, l_dapp
      from accounts
     where acc = p_acc;
    -- ���� ���� ���������� �������� ������ ��������, ���������� �������
    if p_date >= l_dapp
    then
        return l_ostc;
    end if;
    -- ������� ����� �������� ������ �������� ����
    select sum(kos-dos)
      into l_turns
      from saldoa
     where acc = p_acc
       and fdat > p_date;
   --
   return l_ostc - nvl(l_turns,0);
   --
end fost;
/
 show err;
 
PROMPT *** Create  grants  FOST ***
grant EXECUTE                                                                on FOST            to ABS_ADMIN;
grant EXECUTE                                                                on FOST            to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on FOST            to BARSR;
grant EXECUTE                                                                on FOST            to BARSUPL;
grant EXECUTE                                                                on FOST            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOST            to BARS_DM;
grant EXECUTE                                                                on FOST            to DPT;
grant EXECUTE                                                                on FOST            to RCC_DEAL;
grant EXECUTE                                                                on FOST            to RPBN001;
grant EXECUTE                                                                on FOST            to RPBN002;
grant EXECUTE                                                                on FOST            to START1;
grant EXECUTE                                                                on FOST            to UPLD;
grant EXECUTE                                                                on FOST            to WR_ALL_RIGHTS;
grant EXECUTE                                                                on FOST            to WR_DEPOSIT_U;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fost.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 