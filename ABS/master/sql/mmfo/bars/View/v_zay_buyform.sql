

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_BUYFORM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_BUYFORM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_BUYFORM ("ID", "DK", "SOS", "SVIZA", "CUST_BRANCH", "RNK", "NMK", "ACC0", "NLS_ACC0", "OSTC0", "ACC1", "NLS", "S2", "DIG", "S2S", "MFO0", "NLS0", "FDAT", "ND", "KOM", "SKOM", "KURS_Z", "KURS_F", "VDATE", "META", "AIM_NAME", "CONTRACT", "DATC", "NUM_VMD", "VMD1", "VMD5", "COUNTRY", "CBCOUNTRY", "BASIS", "BENEFCOUNTRY", "CBBENEFCOUNTRY", "BANK_CODE", "BANK_NAME", "PRODUCT_GROUP", "PRODUCT_GROUP_NAME", "DATZ", "COMM", "CONTACT_FIO", "CONTACT_TEL", "COVERED", "KB", "KV", "DOC_DESC", "KV_CONV", "LCV_CONV", "DATT") AS 
  SELECT v.id,
            DECODE (v.dk, 1, 0, 1) dk, -- для фильтра в вебе, 0 - покупка, 1 - конверсия
            sos,
            DECODE (
               viza,
               -1, '-1-Відмовлено у візі',
               0, '0-Чекає на візу',
               2, '2-Підтверджено як пріоритетну',
               '1-Завізовано')
               sviza,
            cust_branch,
            rnk,
            nmk,
            acc0,
            nls_acc0,
            ostc0 / POWER (10, dig) ostc0,
            acc1,
            nls,
            s2,
            dig,
            s2s,
            mfo0,
            nls0,
            fdat,
            nd,
            kom,
            skom,
            kurs_z,
            kurs_f,
            vdate,
            meta,
            TO_CHAR (meta, '09') || ' ' || aim_name aim_name,
            contract,
            dat2_vmd datc,
            num_vmd,
            dat_vmd vmd1,
            dat5_vmd vmd5,
            v.country,
            c.name cbcountry,
            SUBSTR (basis, 1, 254) basis,
            benefcountry,
            cc.name cbbenefcountry,
            bank_code,
            bank_name,
            product_group,
            TO_CHAR (product_group, '09') || ' ' || product_group_name
               product_group_name,
            NVL (datz, vdate) datz,
            comm,
            contact_fio,
            contact_tel,
            bars_zay.get_request_cover (v.id) COVERED,
            DECODE (NVL (identkb, 0), 0, 0, 1) kb,
            kv2 kv,
            NVL (zc.doc_desc, NULL) doc_desc,
            NVL (kv_conv, 980) kv_conv,
            NVL (lcv_conv, 'UAH') lcv_conv,
            v.datt
       FROM v_zay_queue v,
            country c,
            country cc,
            zay_corpdocs zc
      WHERE     dk IN (1, 3)
            AND 2 > sos  AND sos >= 0
            AND fdat > bankdate - (SELECT to_number(val) FROM birja WHERE par='ZAY_DAY')
            AND branch LIKE SYS_CONTEXT ('bars_context', 'user_branch') || '%'
            AND v.country = c.country(+)
            AND v.benefcountry = cc.country(+)
            AND v.id = zc.id(+)
   ORDER BY id DESC;

PROMPT *** Create  grants  V_ZAY_BUYFORM ***
grant SELECT                                                                 on V_ZAY_BUYFORM   to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAY_BUYFORM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_BUYFORM   to UPLD;
grant SELECT                                                                 on V_ZAY_BUYFORM   to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_BUYFORM.sql =========*** End *** 
PROMPT ===================================================================================== 
