

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SMS_ACC_SEND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SMS_ACC_SEND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SMS_ACC_SEND ("KF", "NMK", "NLS", "PHONE", "CNT", "ACC", "ACC_CLEARANCE", "NLS_CLEARANCE", "F_OST", "OKPO", "RNK", "KV", "NLS_PAY", "ACC_CLEARANCE_EXP", "F_OST_EXP", "NLS_CLEARANCE_EXP") AS 
  select
KF,
NMK,
NLS,
listagg (PHONE,',') within group(order by acc) PHONE,
sum(CNT) CNT,
ACC,
acc_clearance,
nls_clearance,
f_ost,
okpo,
rnk,
kv,
nls_pay,
acc_clearance_exp,
f_ost_exp,
nls_clearance_exp
 from
 (SELECT T4.KF,
          T3.NMK,
          T4.NLS,
          T5.PHONE,
          T5.CNT,
          T5.ACC,
          t6.acc_clearance,
          t7.nls AS nls_clearance,
          bars.fost (t6.acc_clearance, SYSDATE) / 100 f_ost,
          t3.okpo AS okpo,
          t3.rnk AS rnk,
          t4.kv AS kv,
          (SELECT VALUE
             FROM bars.accountsw
            WHERE acc = t4.acc AND tag = 'SMSCLRNC')
             AS nls_pay,
          NULL AS acc_clearance_exp,
          NULL AS f_ost_exp,
          NULL AS nls_clearance_exp
     FROM bars.CUSTOMER T3,
          bars.ACCOUNTS T4,
          (  SELECT COUNT (T1.MSG_ID) CNT, T1.PHONE, T2.ACC
               FROM bars.MSG_SUBMIT_DATA t1, bars.acc_msg t2
              WHERE T1.MSG_ID = T2.MSG_ID
                       AND T1.STATUS = 'SUBMITTED'
                       AND T1.PAYEDREF IS NULL
           GROUP BY T1.PHONE, T2.ACC
           ORDER BY 3) T5,
          bars.SMS_ACC_CLEARANCE t6,
          bars.ACCOUNTS t7
    WHERE     T4.RNK = T3.RNK
          AND T5.ACC = T4.ACC
          AND t6.acc = t4.acc
          AND t7.acc = t6.acc_clearance
          AND NOT EXISTS
                 (SELECT acc_clearance
                    FROM bars.SMS_ACC_CLEARANCE_EXP t8
                   WHERE t8.acc_clearance = t6.acc_clearance)
   --�� ���������� ���, �� ����� ������� ������������� � ������� ����������
   UNION
   SELECT T4.KF,T3.NMK,
          T4.NLS,
          T5.PHONE,
          T5.CNT,
          T5.ACC,
          t6.acc_clearance,
          t7.nls AS nls_clearance,
          bars.fost (t6.acc_clearance, SYSDATE) / 100 f_ost,
          t3.okpo AS okpo,
          t3.rnk AS rnk,
          t4.kv AS kv,
          (SELECT VALUE
             FROM bars.accountsw
            WHERE acc = t4.acc AND tag = 'SMSCLRNC')
             AS nls_pay,
          t8.acc_clearance_exp AS acc_clearance_exp,
          bars.fost (t8.acc_clearance_exp, SYSDATE) / 100 AS f_ost_exp,
          t9.nls AS nls_clearance_exp
     FROM bars.CUSTOMER T3,
          bars.ACCOUNTS T4,
          (  SELECT COUNT (T1.MSG_ID) CNT, T1.PHONE, T2.ACC
               FROM bars.MSG_SUBMIT_DATA t1, bars.acc_msg t2
              WHERE T1.MSG_ID = T2.MSG_ID
                    AND T1.STATUS = 'SUBMITTED'
                    AND T1.PAYEDREF IS NULL
           GROUP BY T1.PHONE, T2.ACC
           ORDER BY 3) T5,
          bars.SMS_ACC_CLEARANCE t6,
          bars.ACCOUNTS t7,
          bars.SMS_ACC_CLEARANCE_EXP t8,
          bars.accounts t9
    WHERE     T4.RNK = T3.RNK
          AND T5.ACC = T4.ACC
          AND t6.acc = t4.acc
          AND t7.acc = t6.acc_clearance
          AND t8.acc_clearance = t6.acc_clearance
          AND t9.acc = t8.acc_clearance_exp
   UNION
   --�� ���������� � �� �������� ���, ��� ���� �� �� ������� ������� ������
   SELECT T4.KF,T3.NMK,
          T4.NLS,
          T5.PHONE,
          T5.CNT,
          T5.ACC,
          NULL AS acc_clearance,
          NULL AS nls_clearance,
          NULL f_ost,
          t3.okpo AS okpo,
          t3.rnk AS rnk,
          t4.kv AS kv,
          (SELECT VALUE
             FROM bars.accountsw
            WHERE acc = t4.acc AND tag = 'SMSCLRNC')
             AS nls_pay,
          NULL AS acc_clearance_exp,
          NULL AS f_ost_exp,
          NULL AS nls_clearance_exp
     FROM bars.CUSTOMER T3,
          bars.ACCOUNTS T4,
          (  SELECT COUNT (T1.MSG_ID) CNT, T1.PHONE, T2.ACC
               FROM bars.MSG_SUBMIT_DATA t1, bars.acc_msg t2
              WHERE T1.MSG_ID = T2.MSG_ID
                    AND T1.STATUS = 'SUBMITTED'
                    AND T1.PAYEDREF IS NULL
           GROUP BY T1.PHONE, T2.ACC
           ORDER BY 3) T5,
          bars.acc_sms_phones t6
    WHERE     T4.RNK = T3.RNK
          AND T5.ACC = T4.ACC
          AND t6.acc = t4.acc
          AND t6.payforsms = 'Y'
          AND t5.acc NOT IN (SELECT acc
                               FROM bars.SMS_ACC_CLEARANCE t7
                              WHERE t7.acc = t5.acc)
   UNION
   --�� �������, �� ����� �������������� �� ���������� ���
   SELECT T4.KF,T3.NMK,
          T4.NLS,
          T1.PHONE,
          0 AS cnt,
          T4.ACC,
          t6.acc_clearance,
          t7.nls AS nls_clearance,
          bars.fost (t6.acc_clearance, SYSDATE) / 100 f_ost,
          t3.okpo AS okpo,
          t3.rnk AS rnk,
          t4.kv AS kv,
          (SELECT VALUE
             FROM bars.accountsw
            WHERE acc = t4.acc AND tag = 'SMSCLRNC')
             AS nls_pay,
          (select t8.acc_clearance_exp from bars.SMS_ACC_CLEARANCE_EXP t8 where t8.acc_clearance = t6.acc_clearance ) AS acc_clearance_exp,
          (select bars.fost (t8.acc_clearance_exp, SYSDATE) / 100 from bars.SMS_ACC_CLEARANCE_EXP t8 where t8.acc_clearance = t6.acc_clearance ) AS f_ost_exp,
          (select t9.nls from bars.SMS_ACC_CLEARANCE_EXP t8,bars.ACCOUNTS t9 where t8.acc_clearance = t6.acc_clearance and t9.ACC = t8.ACC_CLEARANCE_EXP ) AS nls_clearance_exp
     FROM bars.MSG_SUBMIT_DATA t1,
          bars.acc_msg t2,
          bars.CUSTOMER T3,
          bars.ACCOUNTS T4,
          bars.SMS_ACC_CLEARANCE t6,
          bars.ACCOUNTS t7
    WHERE     T4.RNK = T3.RNK
          AND T1.MSG_ID = T2.MSG_ID
          and t1.STATUS = 'SUBMITTED'
          AND T2.ACC = T4.ACC
          AND t6.acc = t4.acc
          AND t7.acc = t6.acc_clearance
          AND bars.fost (t6.acc_clearance, SYSDATE) <> 0
          AND T1.PAYEDREF IS NOT NULL
          AND t4.acc NOT IN (SELECT T12.ACC
                               FROM bars.MSG_SUBMIT_DATA t11, bars.acc_msg t12
                              WHERE     T11.MSG_ID = T12.MSG_ID
                                    AND T11.STATUS = 'SUBMITTED'
                                    AND T11.PAYEDREF IS NULL
                                    AND t12.acc = t4.acc))
		where (acc_clearance_exp not in(540108513) or  acc_clearance_exp is null)
group by
KF,
NMK,
NLS,
ACC,
acc_clearance,
nls_clearance,
f_ost,
okpo,
rnk,
kv,
nls_pay,
acc_clearance_exp,
f_ost_exp,
nls_clearance_exp ;

PROMPT *** Create  grants  V_SMS_ACC_SEND ***
grant SELECT                                                                 on V_SMS_ACC_SEND  to BARSREADER_ROLE;
grant SELECT                                                                 on V_SMS_ACC_SEND  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SMS_ACC_SEND  to DPT_ADMIN;
grant SELECT                                                                 on V_SMS_ACC_SEND  to DPT_ROLE;
grant SELECT                                                                 on V_SMS_ACC_SEND  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SMS_ACC_SEND.sql =========*** End ***
PROMPT ===================================================================================== 
