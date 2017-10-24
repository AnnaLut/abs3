

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BACK_CCK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BACK_CCK ***

  CREATE OR REPLACE PROCEDURE BARS.P_BACK_CCK ( ref_ INT, lev_ SMALLINT) IS
/*

 ������������ � p_back_dok ��� ������������ �� #ifdef CCK
 ��� �������������� ������-������ � ��������������� ������ ��� ������� ���������� ��� ��������

21.04.2016 ������. COBUSUPABS-4381 ��� ���������� �������� � ������ (��)  � ������� ������� CC_TRANS ��������� ����� �� �����������.
20.05.2009 ������. ���������� �������� �� OSTX �� ����� 8999*LIM �� ����� ���������� ���-�������� �� ��������� �������.

*/

BEGIN

   delete from CC_TRANS  where ref = REF_;

   FOR k IN (SELECT a.accc  FROM opldok o, accounts a
             WHERE o.dk = 1  AND o.REF = ref_  AND o.acc = a.acc
               AND a.accc IS NOT NULL  AND EXISTS ( SELECT 1  FROM accounts   WHERE acc = a.accc AND tip = 'LIM'))
   LOOP UPDATE accounts  SET pap = 3 WHERE acc = k.accc;
        gl.bck (ref_, lev_);
        UPDATE accounts  SET pap = 1 WHERE acc = k.accc;
        RETURN;
   END LOOP;

END p_back_cck;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BACK_CCK.sql =========*** End **
PROMPT ===================================================================================== 
