

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SMS_CLIENT_SEND.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SMS_CLIENT_SEND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SMS_CLIENT_SEND ("KF", "NMK", "PHONE", "CNT") AS 
  SELECT t4.kf, t4.nmk, t5.phone, t5.cnt
  FROM CUSTOMERW T3,
       CUSTOMER T4,
       (  SELECT COUNT (T1.MSG_ID) cnt, T1.PHONE
            FROM MSG_SUBMIT_DATA t1
                 LEFT OUTER JOIN acc_msg t2 ON T1.MSG_ID = T2.MSG_ID
           WHERE T2.MSG_ID IS NULL AND T1.PAYEDREF IS NULL
        GROUP BY T1.PHONE) t5
 WHERE     T3.RNK = T4.RNK
       AND T4.DATE_OFF IS NULL
       AND T3.TAG = 'MPNO '
       AND T3.VALUE = t5.phone;

PROMPT *** Create  grants  V_SMS_CLIENT_SEND ***
grant SELECT                                                                 on V_SMS_CLIENT_SEND to BARSREADER_ROLE;
grant SELECT                                                                 on V_SMS_CLIENT_SEND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SMS_CLIENT_SEND to DPT_ADMIN;
grant SELECT                                                                 on V_SMS_CLIENT_SEND to DPT_ROLE;
grant SELECT                                                                 on V_SMS_CLIENT_SEND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SMS_CLIENT_SEND.sql =========*** End 
PROMPT ===================================================================================== 
