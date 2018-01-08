create or replace view v_accp_docs_grp
as             
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
          
grant select on v_accp_docs_grp to bars_access_defrole;          
 