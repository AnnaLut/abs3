

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VIP_FLAGS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VIP_FLAGS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VIP_FLAGS ("MFO", "RNK", "NMK", "BRANCH", "VIP", "VIP_NAME", "KVIP", "DATBEG", "DATEND", "COMMENTS", "KVIP_NAME", "FIO_MANAGER", "PHONE_MANAGER", "MAIL_MANAGER") AS 
  SELECT v.mfo MFO,
          v.rnk RNK,
          c.nmk NMK,
          c.branch BRANCH,
          v.vip vip,
          REPLACE (
             REPLACE (
                REPLACE (
                   REPLACE (
                      REPLACE (v.vip, '.', ','),
                      '1',
                      'Наявність платіжної карти'),
                   '2',
                   'Видача кредиту'),
                '3',
                'Наявність депозиту'),
             '4',
             'Залишки на поточних рахунках')
             VIP_name,
          v.kvip KVIP,
          v.datbeg DATBEG,
          v.datend DATEND,
          v.comments COMMENTS,
          t.name kvip_name,
          v.fio_manager,
          v.phone_manager,
          v.mail_manager
     FROM vip_flags v, customer c, vip_calc_tp t
    WHERE TO_NUMBER (v.rnk) = c.rnk AND v.kvip = t.id;

PROMPT *** Create  grants  V_VIP_FLAGS ***
grant SELECT                                                                 on V_VIP_FLAGS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_VIP_FLAGS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VIP_FLAGS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VIP_FLAGS.sql =========*** End *** ==
PROMPT ===================================================================================== 
