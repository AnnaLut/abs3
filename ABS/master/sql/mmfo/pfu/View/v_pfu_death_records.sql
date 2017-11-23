

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_DEATH_RECORDS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_DEATH_RECORDS ***

  create or replace view v_pfu_death_records as
select "ID",
       "LIST_ID",
       "REC_NUM",
       "LAST_NAME",
       "FIRST_NAME",
       "FATHER_NAME",
       "OKPO",
       "DOC_NUM",
       "NUM_ACC",
       "BANK_MFO",
       "BANK_NUM",
       "DATE_DEAD",
       "DEATH_AKT",
       "DATE_AKT",
       "SUM_OVER",
       "PERIOD",
       "DATE_PAY",
       "SUM_PAY",
       "TYPE_BLOCK",
       "PFU_NUM",
       "STATE",
       (select a.ostc/100
             from bars.accounts a
            where a.nls = (select at2.acc_num
                             from pfu_acc_trans_2909 at2
                            where at2.kf = ltrim(dr.BANK_MFO,0))) "REST_2909",
       ar.rest/100 "REST",
       ar.restdate "RESDATE"
    from pfu_death_record dr
    left join pfu_acc_rest ar on ar.fileid = dr.id and ar.acc = num_acc;

grant select on v_pfu_death_records to bars_access_defrole;
                                                                       

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_DEATH_RECORDS.sql =========*** End
PROMPT ===================================================================================== 
