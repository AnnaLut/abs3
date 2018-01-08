

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY_TRANSACTION.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY_TRANSACTION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY_TRANSACTION ("ID", "ACCREDITATION_ID", "TYPE_TRAN", "TRANSACTION_DETAILS", "TRANSACTION_DATE", "INCOME_AMOUNT", "BRANCH_ID") AS 
  SELECT ID               , -- ������������� ���������
         ACCR_ID          , -- ������������� ������������
         '40*'            , -- ���������
         TO_CHAR(ref_oper), -- �������� �������� � �������
         DAT_OPER         , -- ���� ��������
         profit/100       , -- ����� �������� � ���.
         BRANCH             -- �����
  FROM   NOTARY_PROFIT;

PROMPT *** Create  grants  V_NOTARY_TRANSACTION ***
grant SELECT                                                                 on V_NOTARY_TRANSACTION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY_TRANSACTION.sql =========*** E
PROMPT ===================================================================================== 
