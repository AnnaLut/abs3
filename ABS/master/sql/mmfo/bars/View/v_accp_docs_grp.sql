create or replace view v_accp_docs_grp
as             
select okpo,  -- групуванн€ платеж≥в по окпо, бранчах, рахунках
    branch,
    nls,
    sum(sum_pays_d) s,                      -- сума платеж≥в
    sum(sum_fee_p)           sf_1,          -- сума ком≥с≥й по кожному платежу
    sum(round(sum_fee_d,2))  sf_2,          -- сума ком≥с≥й по платежах за день
    round(sum(sum_pays_d)*avg(afee)/100,2) sf_3, -- ком≥с≥€ за м≥с€ць
    avg(afee) afee, -- ком≥с≥€
    sum(cnt_pays) cnt_pays,  -- к≥льк≥сть платеж≥в
    max(period_start) period_start,
    max(period_end)   period_end
 from 
     (select okpo_org okpo,  -- групуванн€ платеж≥в по окпо, бранчах, рахунках ≥ дн€х
           fdat,
           branch,
           decode(typepl, 1, nlsb, 2, nlsa) nls,
           sum(s)/100     sum_pays_d, -- сума документ≥в за день (грн)
           sum(s_fee)/100 sum_fee_p,  -- сума ком≥с≥й по кожному платежу за день (дл€ суми за м≥с€ць)
           avg(amount_fee) afee,      -- ком≥с≥€
           sum(s)/100*(avg(amount_fee)/100) sum_fee_d, -- ком≥с≥€ за день
           sum(decode (typepl, 2, -1, typepl)) cnt_pays,
           max(period_start) period_start,
           max(period_end)   period_end
      from tmp_accp_docs t
     where t.check_on = 1
     group by okpo_org, branch, decode(typepl, 1, nlsb, 2, nlsa), fdat)
 group by okpo, branch, nls;
          
grant select on v_accp_docs_grp to bars_access_defrole;          
 