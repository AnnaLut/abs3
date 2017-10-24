CREATE OR REPLACE VIEW v_accp_act2
AS 
  select ao.name,
          ao.ndog,
          ao.ddog,
          ao.okpo,
          ao.scope_dog,
          ao.order_fee,
          ao.amount_fee,
          ao.fee_mfo,
          ao.fee_nls,
          ao.fee_okpo,
          nvl(branch,'������:') branch,  
          s as sum_pays,
          case 
           when ao.order_fee=2 then sf_2
           when ao.order_fee=3 then sf_3
           else sf_1
          end as sum_fee,          
          cnt_pays,
          period_start,
          period_end,
          afee,
          sf_1, 
          sf_2, 
          sf_3
    from    
     (-- �������� ���� �� �����
      select okpo,
            branch,
            sum(s) s,                      -- ���� �������
            sum(sf_1)  sf_1,          -- ���� ����� �� ������� �������
            sum(sf_2)  sf_2,          -- ���� ����� �� �������� �� ����
            sum(sf_3)  sf_3, -- ����� �� �����
            avg(afee)  afee, -- �����
            sum(cnt_pays) cnt_pays,  -- ������� �������
            max(period_start) period_start,
            max(period_end)   period_end
       from v_accp_docs_grp
      group by rollup (branch), okpo) op
     ,accp_orgs ao
    WHERE ao.okpo = op.okpo;
    
GRANT SELECT ON v_accp_act2 TO BARS_ACCESS_DEFROLE;     
    
  