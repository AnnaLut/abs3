

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCP_DOCS_GRP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCP_DOCS_GRP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCP_DOCS_GRP ("OKPO", "BRANCH", "NLS", "S", "SF_1", "SF_2", "SF_3", "AFEE", "CNT_PAYS", "PERIOD_START", "PERIOD_END") AS 
  select okpo,  -- ���������� ������� �� ����, �������, ��������
    branch,
    nls,
    sum(sum_pays_d) s,                      -- ���� �������
    sum(sum_fee_p)           sf_1,          -- ���� ����� �� ������� �������
    sum(round(sum_fee_d,2))  sf_2,          -- ���� ����� �� �������� �� ����
    round(sum(sum_pays_d)*avg(afee)/100,2) sf_3, -- ����� �� �����
    avg(afee) afee, -- �����
    sum(cnt_pays) cnt_pays,  -- ������� �������
    max(period_start) period_start,
    max(period_end)   period_end
 from
     (select okpo_org okpo,  -- ���������� ������� �� ����, �������, �������� � ����
           fdat,
           branch,
           decode(typepl, 1, nlsb, 2, nlsa) nls,
           sum(s)/100     sum_pays_d, -- ���� ��������� �� ���� (���)
           sum(s_fee)/100 sum_fee_p,  -- ���� ����� �� ������� ������� �� ���� (��� ���� �� �����)
           avg(amount_fee) afee,      -- �����
           sum(s)/100*(avg(amount_fee)/100) sum_fee_d, -- ����� �� ����
           sum(decode (typepl, 2, -1, typepl)) cnt_pays,
           max(period_start) period_start,
           max(period_end)   period_end
      from tmp_accp_docs t
     where t.check_on = 1
     group by okpo_org, branch, decode(typepl, 1, nlsb, 2, nlsa), fdat)
 group by okpo, branch, nls;

PROMPT *** Create  grants  V_ACCP_DOCS_GRP ***
grant SELECT                                                                 on V_ACCP_DOCS_GRP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCP_DOCS_GRP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCP_DOCS_GRP.sql =========*** End **
PROMPT ===================================================================================== 
