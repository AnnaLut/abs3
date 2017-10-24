
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtonameraj.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTONAMERAJ (branch in varchar2) return varchar2 is
  -- ������� ������� ����� ������ ��� ��������� ������
  -- (������� ��� ��������� ���� � ����� ������)
  s varchar2(30);
begin
  s := substr(RPAD(branch,30),9,6);
  case
    when s='000136' then return '�������';
    when s='000145' then return '������������';
    when s='000151' then return '����';
    when s='000133' then return '���������';
    when s='000087' then return '�����';
    when s='000096' then return '��������';
    when s='000119' then return '������';
    when s='000106' then return '��������';
    when s='000156' then return '�����';
    when s='000122' then return '�����';
    when s='000164' then return '�������';
    when s='000113' then return '�����';
    when s='000129' then return '��������';
    when s='000000' then return 'г��� (�����)';
    when s='000080' then return '�����������';
    when s='000081' then return '������';
    when s='000084' then return '��������';
    else return 'г��� (�����)';
  end case;
  return 'г��� (�����)';
end f_BranchToNameRaj; 
 
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTONAMERAJ ***
grant EXECUTE                                                                on F_BRANCHTONAMERAJ to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtonameraj.sql =========*** 
 PROMPT ===================================================================================== 
 