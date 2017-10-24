
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtorajurl.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTORAJURL (branch in varchar2) return varchar2 is
  -- ������� ������� ����������������� ������ ������ ����� ��� ��� ��������� ������
  -- (������� ��� ��������� ���� � ����� ������)
  s varchar2(30);
begin
  s := substr(RPAD(branch,30),9,6);
  case
    when s='000136' then return 'DRLB'; -- �������
    when s='000145' then return 'DRLC'; -- ������������
    when s='000151' then return 'DRLD'; -- ����
    when s='000133' then return 'DRLF'; -- ���������
    when s='000087' then return 'DRLE'; -- �����
    when s='000096' then return 'DRLH'; -- ��������
    when s='000119' then return 'DRLI'; -- ������
    when s='000106' then return 'DRLJ'; -- ��������
    when s='000156' then return 'DRLK'; -- �����
    when s='000122' then return 'DRLL'; -- �����
    when s='000164' then return 'DRLN'; -- �������
    when s='000113' then return 'DRLO'; -- �����
    when s='000129' then return 'DRLP'; -- ��������
    when s='000000' then return 'URLA'; -- г��� (�����)
    when s='000080' then return 'DRLM'; -- �����������
    when s='000081' then return 'DRLG'; -- ������
    when s='000084' then return 'DRLT'; -- ��������
    else return '';
  end case;
  return '';
end f_BranchToRajUrl; 
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTORAJURL ***
grant EXECUTE                                                                on F_BRANCHTORAJURL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BRANCHTORAJURL to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtorajurl.sql =========*** E
 PROMPT ===================================================================================== 
 