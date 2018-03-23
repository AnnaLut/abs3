

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_QUEUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_QUEUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_QUEUE ("ID", "MFO", "REQ_ID", "DK", "OBZ", "ND", 
"FDAT", "DATT", "RNK", "NMK", "ND_RNK", "KV_CONV", "LCV_CONV", "KV2", "LCV", "DIG", "S2", 
"S2S", "S3", "KOM", "SKOM", "KURS_Z", "KURS_F", "VDATE", "DATZ", "ACC0", "NLS_ACC0", "MFO0",
 "NLS0", "OKPO0", "OSTC0", "ACC1", "OSTC", "NLS", "SOS", "REF", "VIZA", "PRIORITY", "PRIORNAME",
 "PRIORVERIFY", "IDBACK", "FL_PF", "MFOP", "NLSP", "OKPOP", "RNK_PF", "PID", "CONTRACT", 
"DAT2_VMD", "META", "AIM_NAME", "FULL_META", "BASIS", "PRODUCT_GROUP", "PRODUCT_GROUP_NAME",
 "FULL_PRODUCT_GROUP", "NUM_VMD", "DAT_VMD", "DAT5_VMD", "COUNTRY", "BENEFCOUNTRY", "BANK_CODE",
 "BANK_NAME", "USERID", "BRANCH", "FL_KURSZ", "IDENTKB", "COMM", "CUST_BRANCH", "KURS_KL",
 "CONTACT_FIO", "CONTACT_TEL", "VERIFY_OPT", "CLOSE_TYPE_NAME", "AIMS_CODE", "S_PF", "REF_PF",
 "REF_SPS", "START_TIME", "STATE", "OPERID_NOKK", "REQ_TYPE", "VDATE_PLAN", "REASON_COMM",
 "CODE_2C", "P12_2C","ATTACHMENTS_COUNT","F092") AS 
  select z.id,                                                  -- реф заявки
       substr(f_ourmfo_g,1,6),                                        -- РУ
       null,                                               -- реф заявки РУ
       z.dk,                                         -- 1-покупка/2-продажа
       z.obz,                                                         -- ??
       z.nd,                                     -- клиентский номер заявки
       z.fdat,                                               -- дата заявки
       z.datt,                                                        -- ??
       z.rnk,                                                        -- РНК
       c.nmk,                                                        -- НМК
       c.nd,                            -- домер док. из клиента - не нужно
       z.kv_conv,                       -- валюта заявки "за что"(числ.код)
       t1.lcv,                          -- валюта заявки "за что"(симв.код)
       z.kv2,                              -- валюта заявки "что"(числ.код)
       t.lcv,                              -- валюта заявки "что"(симв.код)
       t.dig,                                -- кол-во знаков после запятой
       z.s2,                                        -- сумма заявки (в коп)
       z.s2 / power (10, t.dig),           -- приведенная сумма (не в коп.)
       z.s3,                                                         -- ???
       z.kom,                                           -- процент комиссии
       z.skom,                                            -- сумма комиссии
       z.kurs_z,                                             -- курс заявки
       z.kurs_f,                             -- курс дилера по удовл.заявке
       z.vdate,                                   -- дата удовлетвор.заявки
       nvl (z.datz, z.vdate),                                -- дата заявки
       z.acc0,                                             -- асс грн счета
       nvl(b.nls, z.nls0) nls_acc0,                      -- номер грн счета
       nvl (z.mfo0, substr (f_ourmfo, 1, 12)), -- если межбанк, то асс0 пустое, и заполнены mfo0, nls0
       nvl (z.nls0, b.nls),
       c.okpo,                                              -- ОКПО клиента
       b.ostc,                                      -- остаток на грн счете
       z.acc1,                                             -- асс вал счета
       a.ostc,                                      -- остаток на вал счете
       a.nls,                                            -- номер вал счета
       z.sos, -- состояние заявки (0-введена, 1 - удовлетворена дилером, 2 - оплачена)
       z.ref,                          -- рефренс сформированного документа
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
       nvl (tc.name, z.contract),                                    -- ЕИК
       nvl (tc.dateopen, z.dat2_vmd),                                -- ЕИК
       z.meta,                                               -- цель заявки
       za.name,                                 -- наименование цели заявки
       to_char(z.meta,'FM09')||' '||za.name full_meta,
       z.basis,                                    -- основание для покупки
       z.product_group,                                       -- отчетность
       k.txt,                                     -- название product_group
       to_char(z.product_group,'FM09')||' '||k.txt full_product_group,
       z.num_vmd,                                                    -- ЕИК
       z.dat_vmd,                                                    -- ЕИК
       z.dat5_vmd,                                                   -- ЕИК
       nvl (z.country, tc.benefcountry),                             -- ЕИК
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
       zc.name,
       z.aims_code,
       z.s_pf / 100,
       z.ref_pf,
       z.ref_sps,
       zt.change_time,
       decode (
             z.sos,
             0, decode (
                   z.viza,
                   0, 'Введена НЕвизирована',
                   1,    'Завизирована ZAY2. Ожидает '
                      || decode (z.priority,
                                 1, 'визу ZAY3',
                                 'дилера'),
                   2, 'Завизирована ZAY3. Ожидает дилера',
                   -1, 'Снята с визы',
                   ''),
             0.5, 'Удовл.дилером НЕзавизирована',
             1, 'Удовл.дилером завизирована',
             2, 'Оплачена',
             -1, 'Удалена',
             ''),
       z.operid_nokk,
       z.req_type, z.vdate_plan, z.reason_comm, z.code_2c, z.p12_2c,
       z.ATTACHMENTS_COUNT,
       z.f092
  from zayavka z, zay_queue q, customer c,
       tabval t, tabval t1, accounts a, accounts b,
       top_contracts tc, zay_priority p, zay_aims za,
       v_kod_70_4 k, zay_close_types zc,
       (select id, change_time
          from zay_track
         where new_viza = 0 and new_sos = 0) zt
 where z.rnk = c.rnk
   and z.id  = q.id
   and z.kv2 = t.kv
   and z.kv_conv  = t1.kv(+)
   and z.priority = p.id
   and z.acc1 = a.acc(+)
   and z.acc0 = b.acc(+)
   and z.pid  = tc.pid(+)
   and z.meta = za.aim(+)
   and k.p70(+) = z.product_group
   and z.id = zt.id(+)
   and z.close_type = zc.id(+)
   and z.branch like sys_context ('bars_context', 'user_branch_mask')
 union all
select id, mfo, req_id, dk, obz, nd, fdat, datt, rnk, nmk, nd_rnk,
       kv_conv, lcv_conv, kv2, lcv, dig,
       s2, s2s, s3, kom, skom, kurs_z, kurs_f,
       vdate, datz, acc0, nls_acc0, mfo0, nls0,
       okpo0, ostc0, acc1, ostc, nls,
       sos, ref, viza, priority, priorname, priorverify,
       idback, fl_pf, mfop, nlsp, okpop, rnk_pf,
       pid, contract, dat2_vmd, meta, aim_name, to_char(meta,'FM09')||' '||aim_name full_meta, basis,
       product_group, product_group_name, to_char(product_group,'FM09')||' '||product_group_name full_product_group,
       num_vmd, dat_vmd, dat5_vmd,
       country, benefcountry, bank_code, bank_name,
       userid, branch, fl_kursz, identkb, comm,
       cust_branch, kurs_kl, contact_fio, contact_tel,
       verify_opt, close_type_name, aims_code,
       s_pf, ref_pf, ref_sps, start_time, state, operid_nokk, req_type, vdate_plan, reason_comm,
       null, null,null,null
  from zayavka_ru;

PROMPT *** Create  grants  V_ZAY_QUEUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ZAY_QUEUE     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ZAY_QUEUE     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ZAY_QUEUE     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY_QUEUE     to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_QUEUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
