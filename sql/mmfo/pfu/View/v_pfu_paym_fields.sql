

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_PAYM_FIELDS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_PAYM_FIELDS ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_PAYM_FIELDS ("ACC_2909", "OKPO_2909", "MFO_2909", "NAME_2909", "ACC_2560", "OKPO_2560", "MFO_2560", "NAME_2560", "DEBET_TTS", "SUM", "NAZN", "ID") AS 
  select (select acc.acc_num
          from pfu_acc_trans_2909 acc
         where acc.kf = ltrim(per.receiver_mfo,'0')
           and acc.file_type = pf.file_type) acc_2909,
       nvl((select nvl(cu.okpo,'123456789')
          from bars.accounts ac,
               bars.customer cu
         where ac.rnk = cu.rnk
           and ac.kf = '300465'
           and ac.kv = '980'
           and ac.nls = (select acc.acc_num
                           from pfu_acc_trans_2909 acc
                          where acc.kf = ltrim(per.receiver_mfo,'0')
                            and acc.file_type = pf.file_type)),'123456789') okpo_2909,
       '300465' mfo_2909,
       nvl((select nvl(ac.nms,'Транзитний рахунок 2909')
          from bars.accounts ac
         where ac.kf = '300465'
           and ac.kv = '980'
           and ac.nls = (select acc.acc_num
                           from pfu_acc_trans_2909 acc
                          where acc.kf = ltrim(per.receiver_mfo,'0')
                            and acc.file_type = pf.file_type)),'Транзитний рахунок 2909') name_2909,
       (select acc.acc_num
          from pfu_acc_trans_2560 acc
         where acc.kf = ltrim(per.receiver_mfo,'0')) acc_2560,
       (select acc.edrpu
          from pfu_acc_trans_2560 acc
         where acc.kf = ltrim(per.receiver_mfo,'0')) okpo_2560,
       ltrim(per.receiver_mfo,'0') mfo_2560,
       'Транзитний рахунок 2560' name_2560,
       case ltrim(per.receiver_mfo,'0') when '300465' then 'PFX'
                                         else(select pp.value
                                                from pfu_parameter pp
                                               where pp.key = 'PFU_DEBET_TTS') end debet_tts,
       (select sum(pfr.sum_pay)
          from pfu_file_records pfr
         where pfr.file_id = pf.id
           and pfr.state = 0) sum,
         'Перерахування загальної суми по реєстру №{0}' nazn,
           pf.id
          from pfu_file pf, pfu_envelope_request per
         where per.id = pf.envelope_request_id
      order by pf.envelope_request_id desc;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_PAYM_FIELDS.sql =========*** End *
PROMPT ===================================================================================== 
