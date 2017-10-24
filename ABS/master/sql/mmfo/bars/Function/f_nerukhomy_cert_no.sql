
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nerukhomy_cert_no.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NERUKHOMY_CERT_NO return VARCHAR2 
/* =============================================================================
-- ������� ���������� ������ ������������� ������������ ��� ����������� �������� 
-- �� ����� ��������������� ��� (��������� �.�., ������� �.�.) � � 
-- ������ ������������ (�������� �.�., �������� �.�.)
--
-- 28.08.2015
-- =============================================================================*/
IS
  Result VARCHAR2(1000);
  CRLF   CONSTANT CHAR(2) := CHR(13)||CHR(10); -- Carriage Return+Line Feed
BEGIN
  Result:='';
  FOR i IN (SELECT key_id||' - '||region as msg
              FROM v_NERUKHOMY_cert_no
             ORDER BY key_id)
  LOOP
    Result:=Result || i.msg || CRLF;
  END LOOP;
  IF Length(Result) > 0 THEN
    Result := '³����� ����������� �� ���� �� ������� ����� ������������:' || CRLF || CRLF || Result;
  END IF; 
  RETURN Result;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nerukhomy_cert_no.sql =========**
 PROMPT ===================================================================================== 
 