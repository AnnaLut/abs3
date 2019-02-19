CREATE OR REPLACE VIEW V_ZAY42 AS
SELECT id
      ,mfo
      ,mfo_name
      ,req_id
      ,dk
      ,sos
      ,decode(sos, 0, 0, 1) SOS_DECODED
      ,kv2
      ,lcv
      ,dig
      ,kv_conv
      ,fdat
      ,kurs_z
      ,vdate
      ,kurs_f
      ,(nvl(s2, 0) / 100) s2
      ,viza
      ,datz
      ,rnk
      ,nmk
      ,cust_branch
      ,priority
      ,priorname
      ,aim_name
      ,comm
      ,kurs_kl
      , (case
          when priorverify = 0
               and viza >= 1 then
           1
          when priorverify = 1
               and viza >= 2 then
           1
          else
           0
        end) PRIORVERIFY_VIZA
      ,close_type
      ,close_type_name
      ,nvl(obz, 0) obz
      ,state
      ,start_time
      ,req_type
      ,sq S2_EQV
FROM   v_zay
WHERE
 s2 > 0
 AND trunc(nvl(fdat, bankdate)) <= bankdate
 AND fdat >= (sysdate - 30);
