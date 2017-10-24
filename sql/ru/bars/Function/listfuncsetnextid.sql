
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/listfuncsetnextid.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.LISTFUNCSETNEXTID (p_setid number) RETURN  NUMBER
--=================
-- ������� ����������� ���������� id ��� ������� � ������ ���������� ��� ��������/�������� ���
-- p_setid - ��� ������:
--           1	������ �������� ���	�������, �� ����������� ��� ������� ���
--           0	������ �������� ���	�������, �� ����������� ��� ������� ���
--=================
IS
BEGIN
  FOR c IN
   ( SELECT rec_id + 1 as newid FROM list_funcset o1
     WHERE set_id = p_setid AND
           NOT EXISTS ( SELECT rec_id
                          FROM list_funcset
                         WHERE rec_id=o1.rec_id + 1
                           AND set_id = p_setid))
  LOOP
     RETURN c.newid;
     EXIT;
  END LOOP;
END;
/
 show err;
 
PROMPT *** Create  grants  LISTFUNCSETNEXTID ***
grant EXECUTE                                                                on LISTFUNCSETNEXTID to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LISTFUNCSETNEXTID to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/listfuncsetnextid.sql =========*** 
 PROMPT ===================================================================================== 
 