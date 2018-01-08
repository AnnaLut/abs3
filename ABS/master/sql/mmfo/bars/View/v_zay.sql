

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY ("ID", "MFO", "MFO_NAME", "REQ_ID", "DK", "OBZ", "ND", "FDAT", "DATT", "RNK", "NMK", "CUSTTYPE", "ND_RNK", "KV_CONV", "LCV_CONV", "KV2", "LCV", "DIG", "S2", "S2S", "S3", "KOM", "SKOM", "KURS_Z", "KURS_F", "VDATE", "DATZ", "ACC0", "NLS_ACC0", "MFO0", "NLS0", "OKPO0", "OSTC0", "ACC1", "OSTC", "NLS", "SOS", "REF", "VIZA", "PRIORITY", "PRIORNAME", "PRIORVERIFY", "IDBACK", "FL_PF", "MFOP", "NLSP", "OKPOP", "RNK_PF", "PID", "CONTRACT", "DAT2_VMD", "META", "AIM_NAME", "BASIS", "PRODUCT_GROUP", "PRODUCT_GROUP_NAME", "NUM_VMD", "DAT_VMD", "DAT5_VMD", "COUNTRY", "BENEFCOUNTRY", "BANK_CODE", "BANK_NAME", "USERID", "BRANCH", "FL_KURSZ", "IDENTKB", "COMM", "CUST_BRANCH", "KURS_KL", "CONTACT_FIO", "CONTACT_TEL", "VERIFY_OPT", "CLOSE_TYPE", "CLOSE_TYPE_NAME", "AIMS_CODE", "S_PF", "REF_PF", "REF_SPS", "START_TIME", "STATE", "OPERID_NOKK", "REQ_TYPE", "VDATE_PLAN", "REASON_COMM", "KV_BASE", "SQ") AS 
  SELECT z.id,                                                  -- реф заявки
          --SUBSTR (f_ourmfo, 1, 6),                                       -- РУ
          z.kf,
          --SUBSTR (getglobaloption ('NAME'), 1, 38),         -- наименование РУ
          bb.nb,
          NULL,                                               -- реф заявки РУ
          z.dk,                                         -- 1-покупка/2-продажа
          z.obz,                                                         -- ??
          z.nd,                                     -- клиентский номер заявки
          z.fdat,                                               -- дата заявки
          z.datt,                                                        -- ??
          z.rnk,                                                        -- РНК
          c.nmk,                                                        -- НМК
          c.custtype,                                           -- тип клиента
          c.nd,                            -- домер док. из клиента - не нужно
          z.kv_conv,                       -- валюта заявки "за что"(числ.код)
          t1.lcv,                          -- валюта заявки "за что"(симв.код)
          z.kv2,                                   -- валюта заявки (числ.код)
          t.lcv,                                   -- валюта заявки (симв.код)
          t.dig,                                -- кол-во знаков после запятой
          z.s2,                                        -- сумма заявки (в коп)
          z.s2 / POWER (10, t.dig),           -- приведенная сумма (не в коп.)
          z.s3,                                                         -- ???
          z.kom,                                           -- процент комиссии
          z.skom,                                            -- сумма комиссии
          z.kurs_z,                                             -- курс заявки
          z.kurs_f,                             -- курс дилера по удовл.заявке
          z.vdate,                                   -- дата удовлетвор.заявки
          NVL (z.datz, z.vdate),                                -- дата заявки
          z.acc0,                                             -- асс грн счета
          b.nls nls_acc0,                                   -- номер грн счета
          NVL (z.mfo0, SUBSTR (f_ourmfo, 1, 12)), -- если межбанк, то асс0 пустое, и заполнены mfo0, nls0
          NVL (z.nls0, b.nls),
          c.okpo,                                              -- ОКПО клиента
          b.ostc,                                      -- остаток на грн счете
          z.acc1,                                             -- асс вал счета
          a.ostc,                                      -- остаток на вал счете
          a.nls,                                            -- номер вал счета
          z.sos, -- состояние заявки (0-введена, 1 - удовлетворена дилером, 2 - оплачена)
          z.REF,                          -- рефренс сформированного документа
          z.viza, -- виза (0 - введена, 0,5 - завизирована ZAY2, 1 - завизирована полностью, -1 - сторно)
          z.priority, -- приоритет (0 - обычная, 1 - желательная, 2 - обязательная, 9 - гарантированная)
          p.name,                                       -- название приоритета
          p.verify,                        -- требует ли приоритет визирования
          z.idback,                                        -- причина возврата
          z.fl_pf,                                                   -- не исп
          z.mfop,                                                    -- не исп
          z.nlsp,                                                    -- не исп
          z.okpop,                                                   -- не исп
          z.rnk_pf,                                                  -- не исп
          z.pid,                                                         -- ??
          NVL (tc.name, z.contract),                                    -- ЕИК
          NVL (tc.dateopen, z.dat2_vmd),                                -- ЕИК
          z.meta,                                               -- цель заявки
          za.name,                                 -- наименование цели заявки
          z.basis,                                    -- основание для покупки
          z.product_group,                                       -- отчетность
          k.txt,                                     -- название product_group
          z.num_vmd,                                                    -- ЕИК
          z.dat_vmd,                                                    -- ЕИК
          z.dat5_vmd,                                                   -- ЕИК
          NVL (z.country, tc.benefcountry),                             -- ЕИК
          z.benefcountry,                                               -- ЕИК
          z.bank_code,                                                  -- ЕИК
          z.bank_name,                                                  -- ЕИК
          z.isp,                                                 -- исп.заявки
          z.tobo,                                -- BRANCH, где введена заявка
          z.fl_kursz,                                                    -- ??
          z.identkb,                 -- идентификатор заявки, принятой по кл-б
          z.comm,                                               -- комментарий
          c.branch,                                          -- BRANCH клиента
          z.kurs_kl,
          z.contact_fio,
          z.contact_tel,
          z.verify_opt,
          z.close_type,
          zc.name,
          z.aims_code,
          z.s_pf / 100,
          z.ref_pf,
          z.ref_sps,
          zt.change_time,
          DECODE (
             z.sos,
             0, DECODE (
                   z.viza,
                   0, 'Створена НЕвізована',
                   1,    'Завізована ZAY2.Очікує '
                      || DECODE (z.priority, 1, ' ZAY3', 'ділера'),
                   2, 'Завізована ZAY3.Очікує ділера',
                   -1, 'Знята з візи',
                   ''),
             0.5, 'Задовол.ділером НЕвізована',
             1, 'Задовол.ділером візована',
             2, 'Сплачена',
             -1, 'Видалена',
             ''),
          z.operid_nokk,
          z.req_type,
          z.vdate_plan,
          z.reason_comm,
          (SELECT kv_base
             FROM zay_conv_kv
            WHERE    (kv1 = z.kv2 AND kv2 = z.kv_conv)
                  OR (kv2 = z.kv2 AND kv1 = z.kv_conv))
             kv_base,
          CASE
             WHEN (SELECT kv_base
                     FROM zay_conv_kv
                    WHERE    (kv1 = z.kv2 AND kv2 = z.kv_conv)
                          OR (kv2 = z.kv2 AND kv1 = z.kv_conv)) = z.kv_conv
             THEN
                ROUND (z.s2 / 100 / z.kurs_f, 2)
             ELSE
                ROUND (z.s2 / 100 * z.kurs_f, 2)
          END
             sq
     FROM zayavka z,
          customer c,
          tabval t,
          tabval t1,
          accounts a,
          accounts b,
          top_contracts tc,
          zay_priority p,
          zay_aims za,
          v_kod_70_4 k,
          zay_close_types zc,
          banks bb,
          (SELECT id, change_time
             FROM zay_track zzz
            WHERE change_time =
                     (SELECT MAX (change_time)
                        FROM zay_track
                       WHERE new_viza = 0 AND new_sos = 0 AND id = zzz.id)) zt
    WHERE     z.rnk = c.rnk
          AND z.kf = bb.mfo
          AND z.kv2 = t.kv
          AND z.kv_conv = t1.kv(+)
          AND z.priority = p.id
          AND z.acc1 = a.acc(+)
          AND z.acc0 = b.acc(+)
          AND z.pid = tc.pid(+)
          AND z.meta = za.aim(+)
          AND z.product_group = k.p70(+)
          AND z.close_type = zc.id(+)
          AND z.id = zt.id(+)
          AND z.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
   UNION ALL
   SELECT z.id,
          z.mfo,
          b.nb,
          z.req_id,
          z.dk,
          z.obz,
          z.nd,
          z.fdat,
          z.datt,
          z.rnk,
          z.nmk,
          z.custtype,
          z.nd_rnk,
          z.kv_conv,
          z.lcv_conv,
          z.kv2,
          z.lcv,
          z.dig,
          z.s2,
          z.s2s,
          z.s3,
          z.kom,
          z.skom,
          z.kurs_z,
          z.kurs_f,
          z.vdate,
          z.datz,
          z.acc0,
          z.nls_acc0,
          z.mfo0,
          z.nls0,
          z.okpo0,
          z.ostc0,
          z.acc1,
          z.ostc,
          z.nls,
          z.sos,
          z.REF,
          z.viza,
          z.priority,
          z.priorname,
          z.priorverify,
          z.idback,
          z.fl_pf,
          z.mfop,
          z.nlsp,
          z.okpop,
          z.rnk_pf,
          z.pid,
          z.contract,
          z.dat2_vmd,
          z.meta,
          z.aim_name,
          z.basis,
          z.product_group,
          z.product_group_name,
          z.num_vmd,
          z.dat_vmd,
          z.dat5_vmd,
          z.country,
          z.benefcountry,
          z.bank_code,
          z.bank_name,
          z.userid,
          z.branch,
          z.fl_kursz,
          z.identkb,
          z.comm,
          z.cust_branch,
          z.kurs_kl,
          z.contact_fio,
          z.contact_tel,
          z.verify_opt,
          z.close_type,
          z.close_type_name,
          z.aims_code,
          z.s_pf,
          z.ref_pf,
          z.ref_sps,
          z.start_time,
          DECODE (
             z.sos,
             0, DECODE (
                   z.viza,
                   0, 'Створена НЕвізована',
                   1,    'Завізована ZAY2.Очікує '
                      || DECODE (z.priority, 1, ' ZAY3', 'ділера'),
                   2, 'Завізована ZAY3.Очікує ділера',
                   -1, 'Знята з візи',
                   ''),
             0.5, 'Задовол.ділером НЕвізована',
             1, 'Задовол.ділером візована',
             2, 'Сплачена',
             -1, 'Видалена',
             '') state,--z.state,
          z.operid_nokk,
          z.req_type,
          z.vdate_plan,
          z.reason_comm,
          (SELECT kv_base
             FROM zay_conv_kv
            WHERE    (kv1 = z.kv2 AND kv2 = z.kv_conv)
                  OR (kv2 = z.kv2 AND kv1 = z.kv_conv))
             kv_base,
          CASE
             WHEN (SELECT kv_base
                     FROM zay_conv_kv
                    WHERE    (kv1 = z.kv2 AND kv2 = z.kv_conv)
                          OR (kv2 = z.kv2 AND kv1 = z.kv_conv)) = z.kv_conv
             THEN
                ROUND (z.s2 / 100 / z.kurs_f, 2)
             ELSE
                ROUND (z.s2 / 100 * z.kurs_f, 2)
          END
             sq
     FROM zayavka_ru z, banks$base b
    WHERE     z.mfo = b.mfo
          AND f_ourmfo_g = SYS_CONTEXT ('bars_context', 'user_mfo');

PROMPT *** Create  grants  V_ZAY ***
grant SELECT                                                                 on V_ZAY           to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAY           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ZAY           to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY           to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY.sql =========*** End *** ========
PROMPT ===================================================================================== 
