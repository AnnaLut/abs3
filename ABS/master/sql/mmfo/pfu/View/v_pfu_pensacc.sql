

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_PENSACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_PENSACC ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_PENSACC ("ID", "KF", "PENS_BRANCH", "RNK", "NMK", "OKPO", "ADR", "DATE_ON", "DATE_OFF", "PASSP", "SER", "NUMDOC", "PDATE", "ORGAN", "BDAY", "BPLACE", "CELLPHONE", "PENS_STATE", "PENS_COMM", "ACC_BRANCH", "ACC", "NLS", "KV", "OB22", "DAOS", "DAPP", "DAZS", "ACC_STATE") AS 
  SELECT p.id,
          p.kf,
          p.branch pens_branch,
          p.rnk,
          p.nmk,
          p.okpo,
          p.adr,
          p.date_on,
          p.date_off,
          p.passp,
          p.ser,
          p.numdoc,
          p.pdate,
          p.organ,
          p.bday,
          p.bplace,
          p.cellphone,
          p.state AS pens_state,
          p.comm AS pens_comm,
          pa.branch AS acc_branch,
          pa.acc,
          pa.nls,
          pa.kv,
          pa.ob22,
          pa.daos,
          pa.dapp,
          pa.dazs,
          pa.state AS acc_state
     FROM    pfu_pensioner p
          LEFT JOIN
             pfu_pensacc pa
          ON (p.kf = pa.kf AND p.rnk = pa.rnk);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_PENSACC.sql =========*** End *** =
PROMPT ===================================================================================== 
