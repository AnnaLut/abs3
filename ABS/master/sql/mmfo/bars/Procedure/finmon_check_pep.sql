

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FINMON_CHECK_PEP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FINMON_CHECK_PEP ***

  CREATE OR REPLACE PROCEDURE BARS.FINMON_CHECK_PEP (p_n int)
 /*
 version 1 (2016-04-01)

 */
is
begin
 bars_audit.info('finmon_check_public - started');
 begin
  delete from FINMON_PEP_CUSTOMERS;
  bars_audit.info('delete from FINMON_PEP_CUSTOMERS - OK');
 exception when others then bars_audit.trace('delete from FINMON_PEP_CUSTOMERS - FAIL');
 end;
 begin
    INSERT INTO FINMON_PEP_CUSTOMERS (ID, RNK, NMK, CRISK, CUST_RISK, CHECK_DATE, RNK_REEL, NMK_REEL, NUM_REEL, COMMENTS)
    /* 1) ��� �볺��� � �������� �������� ���
            ����    "RNK ���'����� �����",
                    "ϲ�/����� ���'����� �����",
                    "� ���'��. ����� � ������� �������� ���" ����,
                    ��������="�볺��"
    */
     SELECT   fp.id,
             C.RNK,
             C.NMK,
             (SELECT NVL (CW.VALUE, '�������')
                FROM CUSTOMERW CW
               WHERE CW.TAG = 'RIZIK' AND CW.RNK(+) = C.RNK),
             (SELECT concatstr(RISK_ID)
                FROM CUSTOMER_RISK CR
               WHERE TRUNC (SYSDATE) BETWEEN DAT_BEGIN AND NVL(DAT_END, trunc(sysdate))
                 AND RISK_ID IN (2,3,62,63,64,65)  AND CR.RNK(+) = C.RNK),
             TRUNC (SYSDATE),
             null,
             '',
             null,
             '�볺��'
        FROM CUSTOMER C, person p, FINMON_PEP_RELS fp
       WHERE c.DATE_OFF IS NULL
         and p.rnk(+) = c.rnk
         and ((c.okpo = fp.idcode and fp.idcode != '0000000000') or p.ser||p.numdoc = fp.docall)
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
  UNION ALL         SELECT  NULL,
             C.RNK,
             C.NMK,
             (SELECT NVL (CW.VALUE, '�������')
                FROM CUSTOMERW CW
               WHERE TAG = 'RIZIK'
                 AND CW.RNK(+) = CREL.RNK) v,
              (SELECT CONCATSTR (CR.RISK_ID)
                FROM CUSTOMER_RISK CR
               WHERE TRUNC (SYSDATE) BETWEEN DAT_BEGIN AND NVL(DAT_END, trunc(sysdate))
                 AND RISK_ID IN (2,3,62,63,64,65)
                 AND CR.RNK(+) = CREL.RNK) risk,
             TRUNC (SYSDATE),
             CREL.REL_RNK,
             COALESCE(C2.NMK,CE.NAME),
             fp.id,
             CASE   WHEN REL_INTEXT = 1 THEN '���''����� ����� (�볺�� �����)'
                    WHEN REL_INTEXT = 0 THEN '���''����� ����� (�� �볺�� �����)'
             END
        FROM CUSTOMER C, person p,  FINMON_PEP_RELS fp,
             CUSTOMER_REL CREL,
             CUSTOMER_EXTERN CE,
             CUSTOMER C2
       WHERE  CREL.REL_RNK = CE.ID(+)
             AND C.RNK = CREL.RNK
             AND C.DATE_OFF IS NULL
             AND C2.RNK(+) = CREL.REL_RNK
             and p.rnk(+) = c.rnk
             and ((c2.okpo = fp.idcode and fp.idcode != '0000000000') or (c.okpo = fp.idcode and fp.idcode != '0000000000') or p.ser||p.numdoc = fp.docall);

 exception when others then bars_audit.trace('INSERT FINMON_PEP_CUSTOMERS - FAILED');
 end;
bars_audit.info('finmon_check_pep - finished');
end finmon_check_pep;
/
show err;

PROMPT *** Create  grants  FINMON_CHECK_PEP ***
grant EXECUTE                                                                on FINMON_CHECK_PEP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FINMON_CHECK_PEP.sql =========*** 
PROMPT ===================================================================================== 
