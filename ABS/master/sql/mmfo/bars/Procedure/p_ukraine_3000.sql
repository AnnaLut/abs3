

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_UKRAINE_3000.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_UKRAINE_3000 ***

  CREATE OR REPLACE PROCEDURE BARS.P_UKRAINE_3000 
/* =============================================================================
-- ���������� ��� (������� ��������� �����������) � ���������� ������ ������ �� 
-- ���������� � ����� �������� �������� � ������ ����������������� ����� � �������������.
--
-- ��������� �� ������� ������������� �������:
-- ������� � 26005020043340 ��� ������� 3000� (̳��������� ���������� ���� ������� 3000�), 
-- �������� � �� ������������, ��� ����� 322313, ��� � ������ 26167513.
--
-- 07.11.2014
-- =============================================================================*/
IS
  FileHandle    UTL_FILE.FILE_TYPE;
  cPath_        VARCHAR2(100) := 'UPLD';
  cOpenMode_    VARCHAR2(1) := 'W';
  cFileName_    VARCHAR2(16) := 'UKRAINE_3000.csv';
  CRLF          CONSTANT CHAR(2) := CHR(13)||CHR(10); -- Carriage Return+Line Feed
BEGIN

  FileHandle := UTL_FILE.FOPEN (location  => cPath_,
                                filename  => cFileName_,
                                open_mode => cOpenMode_);

  UTL_FILE.PUT(FileHandle, '����������: ��� "������ 3000" '||CRLF);
  UTL_FILE.PUT(FileHandle, '(������� � 01/11/2014)'||CRLF);
  UTL_FILE.PUT(FileHandle, '����'||';'||'����������'||';'||'����� (���.)'||CRLF);
  FOR i IN (SELECT to_char(trunc(sysdate),'dd/mm/yyyy') || ';' || count(*) || ';' || sum(s) as InfoLine
              FROM arc_rrp
             WHERE dat_a >= to_date('01/11/2014','dd/mm/yyyy')
               AND mfob='322313'
               AND nlsb='26005020043340'
               AND id_b='26167513'
            )
  LOOP
     UTL_FILE.PUT(FileHandle, i.InfoLine||CRLF);
  END LOOP;
  UTL_FILE.FCLOSE(FileHandle);

END P_UKRAINE_3000;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_UKRAINE_3000.sql =========*** En
PROMPT ===================================================================================== 
