
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtocoderaj.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTOCODERAJ (branch in varchar2) return number is
  -- ������� ������� ��� ������ ��� ��������� ������
  -- (������� ��� ��������� ���� � ����� ������)
  s varchar2(30);
begin
  s := substr(RPAD(branch,30),9,6);
  case
    when s='000136' then return  1; -- �������
    when s='000145' then return  2; -- ������������
    when s='000151' then return  3; -- ����
    when s='000133' then return  4; -- ���������
    when s='000087' then return  5; -- �����
    when s='000096' then return  6; -- ��������
    when s='000119' then return  8; -- ������
    when s='000106' then return  9; -- ��������
    when s='000156' then return 10; -- �����
    when s='000122' then return 11; -- �����
    when s='000164' then return 12; -- �������
    when s='000113' then return 13; -- �����
    when s='000129' then return 14; -- ��������
    when s='000000' then return 16; -- г��� (�����)
    when s='000080' then return 80; -- �����������
    when s='000081' then return 81; -- ������
    when s='000084' then return 84; -- ��������
    else return 16;
  end case;
  return 16;
end f_BranchToCodeRaj; 
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTOCODERAJ ***
grant EXECUTE                                                                on F_BRANCHTOCODERAJ to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BRANCHTOCODERAJ to RPBN002;
grant EXECUTE                                                                on F_BRANCHTOCODERAJ to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtocoderaj.sql =========*** 
 PROMPT ===================================================================================== 
 