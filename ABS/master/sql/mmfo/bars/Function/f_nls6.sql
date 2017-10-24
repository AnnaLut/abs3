
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nls6.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NLS6 
      (p_mode NUMERIC,  -- ����� ����������� ����� 6 ������
       p_nls  VARCHAR2, -- ���� �����������
       p_kv   NUMERIC,  -- ��� ������
       p_tag  VARCHAR2) -- �������� ���.���������
-- ������� ���������� ���� 6 ������ � ��������� :
--    K03, K01, K0B � ����������� �� ���
--    140 � ����������� �� �������� ���.��������� TIPPK
-- p_mode = 1 - ����������� ����� 6 ������ �� ��� �����������
--        = 2 - ����������� ����� 6 ������ �� ��������
RETURN VARCHAR2 IS
  l_nls6 varchar2(14);  -- �������������� ���� 6 ������
  l_rnk  varchar2(6);   -- ���
  ret_   varchar2(10);
BEGIN

  IF p_mode = 1 THEN
    SELECT ltrim(rtrim(rnk)) INTO l_rnk
      FROM accounts WHERE nls=p_nls AND kv=p_kv;
    l_nls6 := CASE
                WHEN l_rnk = 300598   -- ���������� ���� �������
                  THEN 61106010144074
                  ELSE 61101010143058
              END;
  END IF;

  IF p_mode = 2 THEN
    SELECT value INTO ret_ FROM operw WHERE ref=gl.aRef AND tag=p_tag;
    IF trim(ret_) = 'VISA' THEN
      l_nls6 := '61194020310037';
    ELSE
      IF trim(ret_) = 'EC/MC' THEN
        l_nls6 := '61193010105037';
      END IF;
    END IF;
  END IF;

  RETURN l_nls6;
END F_NLS6;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nls6.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 