
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtype.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTYPE (p_branch branch.branch%type)
  RETURN NUMBER
IS
  -- ������� ���������� ��� �������������
  --  0 = ������� ����
  --  1 = ��������� �������� �����
  --  2 = ������
  --  3 = ��������� �������
  -- -1 = '/'
  -- ������������ ��� ���������� �������� � ������������� ����
  l_mfoG banks.mfo%type;
  l_mfo  banks.mfo%type;
  l_type NUMBER(1);
BEGIN
  l_mfog := f_ourmfo_g;
  l_mfo  := bars_context.extract_mfo(p_branch);

     IF l_mfo IS NULL  THEN
        l_type := -1;  -- '/'
  ELSIF l_mfog = l_mfo THEN
     IF p_branch = '/'||l_mfo||'/' THEN
	    l_type := 0; -- ������� ����
     ELSE
	    l_type := 1; -- ��������� �������� �����
    END IF;
  ELSE
    IF p_branch = '/'||l_mfo||'/' THEN
	    l_type := 2; -- ������
    ELSE
	    l_type := 3; -- ��������� �������
    END IF;
  END IF;
  RETURN l_type;
END;
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTYPE ***
grant EXECUTE                                                                on F_BRANCHTYPE    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtype.sql =========*** End *
 PROMPT ===================================================================================== 
 