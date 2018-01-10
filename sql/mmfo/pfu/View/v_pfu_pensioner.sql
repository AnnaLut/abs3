

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_PENSIONER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_PENSIONER ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_PENSIONER ("ID", "KF", "BRANCH", "RNK", "NMK", "OKPO", "ADR", "DATE_ON", "DATE_OFF", "PASSP", "SER", "NUMDOC", "PDATE", "ORGAN", "BDAY", "BPLACE", "CELLPHONE", "STATE", "COMM", "NLS", "DAOS", "BLOCK_DATE", "BLOCK_TYPE", "TYPE_PENSIONER") AS 
  select p.id,
          p.kf,
          p.branch,
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
          p.state,
          p.comm,
          pa.nls,
          pa.daos,
          p.block_date,
          p.block_type,
          nvl(p.type_pensioner, 1) type_pensioner,
          nvl(p.is_okpo_well, 0) is_okpo_well
     from pfu_pensioner p left join pfu_pensacc pa
       on (p.kf = pa.kf and p.rnk = pa.rnk);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_PENSIONER.sql =========*** End ***
PROMPT ===================================================================================== 
