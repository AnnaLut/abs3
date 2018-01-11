

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FINMON_CHECK_PUBLIC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FINMON_CHECK_PUBLIC ***

  CREATE OR REPLACE PROCEDURE BARS.FINMON_CHECK_PUBLIC (p_n int)
 /*
 version 4.0.2 (2017-07-21)
 -- ������������ ��� ����

 RNK,
 ϲ�/����� �볺���,
 � ����� � ������� �������� ���,
 ����� ������,
 ������ ������, � ������� ������� ������ ���������� ���������� ���� ������������ ������� ������ � ������ (Id) 2, 3, 62-65.
 (+) RNK ���'����� �����,
 (+) ϲ�/����� ���'����� �����,
 (+) � ���'��. ����� � ������� �������� ���,
 (+) ��������
 ���� �����;

 � ��� ����������� ���� ���� �볺���
   1) ��� �볺��� � �������� �������� ��� - ���� "RNK ���'����� �����", "ϲ�/����� ���'����� �����", "� ���'��. ����� � ������� �������� ���" ����, ��������="�볺��"
   2) ��� ���'����� ����� (�볺��� �����) �� ���� �����, ������������ � ������ �볺��� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������, ���� "� ����� � ������� �������� ���" �����, ���� ���'����� ����� - ������� ��� �� ���� ������� ���, ��������="���'����� ����� (�볺�� �����)"
   3) ��� ���'����� ����� (�� �볺�� �����) �� ���� ����� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������, ���� "� ����� � ������� �������� ���" �����, ���� ���'����� ����� - ������� ��� �� ���� ������� ���, ��������="���'����� ����� (�� �볺�� �����)"
 */
is
begin
 bars_audit.info('finmon_check_public - started');
 begin
  delete from FINMON_PUBLIC_CUSTOMERS;
  bars_audit.trace('delete from FINMON_PUBLIC_CUSTOMERS - OK');
 exception when others then bars_audit.trace('delete from FINMON_PUBLIC_CUSTOMERS - FAIL');
 end;
 begin
    INSERT INTO FINMON_PUBLIC_CUSTOMERS (ID, RNK, NMK, CRISK, CUST_RISK, CHECK_DATE, RNK_REEL, NMK_REEL, NUM_REEL, COMMENTS)
    /* 1) ��� �볺��� � �������� �������� ���
            ����    "RNK ���'����� �����",
                    "ϲ�/����� ���'����� �����",
                    "� ���'��. ����� � ������� �������� ���" ����,
                    ��������="�볺��"
    */
     SELECT  FINMON_IS_PUBLIC (C.NMK, C.RNK, 1),
             C.RNK,
             C.NMK,
             NVL (CW.VALUE, '�������'),
             CONCATSTR (CR.RISK_ID),
             TRUNC (SYSDATE),
             null,
             '',
             null,
             '�볺��'
        FROM CUSTOMER C,
             (SELECT RNK, RISK_ID
                FROM CUSTOMER_RISK
               WHERE TRUNC (SYSDATE) BETWEEN DAT_BEGIN AND NVL(DAT_END, trunc(sysdate))
                 AND RISK_ID IN (2,3,62,63,64,65) order by RISK_ID) CR,
             (SELECT RNK, VALUE
                FROM CUSTOMERW
               WHERE TAG = 'RIZIK') CW
       WHERE     FINMON_IS_PUBLIC (NMK, C.RNK, 0) = 1
             AND DATE_OFF IS NULL
             AND CR.RNK(+) = C.RNK
             AND CW.RNK(+) = C.RNK
    GROUP BY C.RNK, C.NMK, CW.VALUE
      /* 2) ��� ���'����� ����� (�볺��� �����) �� ���� �����,
            ������������ � ������ �볺��� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������,
            ����    "� ����� � ������� �������� ���" �����,
                    ���� ���'����� ����� - ������� ��� �� ���� ������� ���,
                    ��������="���'����� ����� (�볺�� �����)"
         3) ��� ���'����� ����� (�� �볺�� �����) �� ���� ����� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������,
            ����    "� ����� � ������� �������� ���" �����,
                    ���� ���'����� ����� - ������� ��� �� ���� ������� ���,
                    ��������="���'����� ����� (�� �볺�� �����)"
      */
 UNION ALL
     SELECT  NULL,
             C.RNK,
             C.NMK,
             NVL (CW.VALUE, '�������'),
             CONCATSTR (CR.RISK_ID),
             TRUNC (SYSDATE),
             CREL.REL_RNK,
             COALESCE(C2.NMK,CE.NAME),
             FINMON_IS_PUBLIC (COALESCE(C2.NMK,CE.NAME), CREL.REL_RNK, 1),
             CASE   WHEN REL_INTEXT = 1 THEN '���''����� ����� (�볺�� �����)'
                    WHEN REL_INTEXT = 0 THEN '���''����� ����� (�� �볺�� �����)'
             END
        FROM CUSTOMER C,
             CUSTOMER_REL CREL,
             CUSTOMER_EXTERN CE,
             (SELECT RNK, RISK_ID
                FROM CUSTOMER_RISK
               WHERE TRUNC (SYSDATE) BETWEEN DAT_BEGIN AND NVL(DAT_END, trunc(sysdate))
                 AND RISK_ID IN (2,3,62,63,64,65) order by RISK_ID) CR,
             (SELECT RNK, VALUE
                FROM CUSTOMERW
               WHERE TAG = 'RIZIK') CW,
             CUSTOMER C2
       WHERE     FINMON_IS_PUBLIC (COALESCE(C2.NMK,CE.NAME), CREL.REL_RNK, 0) = 1
             AND CREL.REL_RNK = CE.ID(+)
             AND C.RNK = CREL.RNK
             AND C.DATE_OFF IS NULL
             AND CR.RNK(+) = CREL.RNK
             AND CW.RNK(+) = CREL.RNK
             AND C2.RNK(+) = CREL.REL_RNK
    GROUP BY C.RNK, C.NMK, CW.VALUE, CREL.REL_RNK,CREL.REL_INTEXT,CE.NAME,C2.NMK;

 exception when others then bars_audit.error('INSERT FINMON_PUBLIC_CUSTOMERS - FAILED');
 end;
bars_audit.info('finmon_check_public - finished');
end finmon_check_public;
/
show err;

PROMPT *** Create  grants  FINMON_CHECK_PUBLIC ***
grant EXECUTE                                                                on FINMON_CHECK_PUBLIC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FINMON_CHECK_PUBLIC.sql =========*
PROMPT ===================================================================================== 
