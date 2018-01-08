

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VIP_DEAL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VIP_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VIP_DEAL ("RNK", "NMK", "BRANCH", "CUSTOMER_SEGMENT_FINANCIAL", "CUSTOMER_SEGMENT_ACTIVITY", "CUSTOMER_SEGMENT_PRODUCTS_AMNT", "RLVIP", "FIO_MANAGER", "PHONE_MANAGER", "MAIL_MANAGER", "ACCOUNT_MANAGER") AS 
  SELECT c.RNK,
          c.NMK,
          c.BRANCH,
          cs.CUSTOMER_SEGMENT_FINANCIAL,
          cs.CUSTOMER_SEGMENT_ACTIVITY,
          cs.CUSTOMER_SEGMENT_PRODUCTS_AMNT,
          (SELECT VALUE
             FROM customerw
            WHERE rnk = c.rnk AND tag = 'RLVIP')
             RLVIP,
          VF.FIO_MANAGER,
          VF.PHONE_MANAGER,
          VF.MAIL_MANAGER,
          VF.ACCOUNT_MANAGER
     FROM customer c, V_CUSTOMER_SEGMENTS cs, vip_flags vf
    WHERE     c.rnk = cs.rnk
          AND c.rnk = vf.rnk
          AND (   cs.CUSTOMER_SEGMENT_FINANCIAL IN ('Прайвет',
                                                 'Преміум')
            OR c.rnk IN (SELECT rnk
                           FROM customerw
                          WHERE tag = 'RLVIP' AND VALUE = 'Так'));

PROMPT *** Create  grants  V_VIP_DEAL ***
grant SELECT                                                                 on V_VIP_DEAL      to BARSREADER_ROLE;
grant SELECT                                                                 on V_VIP_DEAL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VIP_DEAL      to START1;
grant SELECT                                                                 on V_VIP_DEAL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VIP_DEAL.sql =========*** End *** ===
PROMPT ===================================================================================== 
