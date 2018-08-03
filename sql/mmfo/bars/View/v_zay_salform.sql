

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_SALFORM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_SALFORM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_SALFORM ("ID", "DK", "SOS", "SVIZA", 
"CUST_BRANCH", "RNK", "NMK", "ACC0", "ACC1", "NLS", "OSTC", "S2", "DIG", "S2S",
"MFO0", "NLS0", "KV_CONV", "LCV_CONV", "NLS_ACC0", "FDAT", "ND", "KOM", "SKOM",
 "KURS_Z", "KURS_F", "VDATE", "META", "AIM_NAME", "CONTRACT", "DATC", "NUM_VMD", "VMD1",
 "BASIS", "DATZ", "COMM", "CONTACT_FIO", "CONTACT_TEL", "COVERED", "FNAMEKB", "KB", "KV", "DOC_DESC", 
"DATT", "OBZ","F092") AS 
  SELECT v.id,
            DECODE (v.dk, 2, 0, 1) dk, -- ��� ������� � ����, 0 - �������, 1 - ���������
            v.sos,
            DECODE (
               v.viza,
               -1, '-1-³�������� � ��',
               0, '0-���� �� ���',
               2, '2-ϳ���������� �� ����������',
               '1-���������')
               sviza,
            v.cust_branch,
            v.rnk,
            v.nmk,
            v.acc0,
            v.acc1,
            v.nls,
            v.ostc / POWER (10, v.dig) ostc,
            v.s2,
            v.dig,
            v.s2s,
            v.mfo0,
            v.nls0,
            v.kv_conv,
            v.lcv_conv,
            v.nls_acc0,
            v.fdat,
            v.nd,
            v.kom,
            v.skom,
            v.kurs_z,
            v.kurs_f,
            v.vdate,
            v.meta,
            TO_CHAR (v.meta, '09') || ' ' || v.aim_name aim_name,
            v.contract,
            v.dat2_vmd datc,
            v.num_vmd,
            v.dat_vmd vmd1,
            SUBSTR (v.basis, 1, 254) basis,
            NVL (v.datz, v.vdate) datz,
            v.comm,
            v.contact_fio,
            v.contact_tel,
            bars_zay.get_request_cover (v.id) covered,
            fnamekb,
            DECODE (NVL (v.identkb, 0), 0, 0, 1) kb,
            v.kv2 kv,
            NVL (zc.doc_desc, NULL) doc_desc,
            v.datt,
            v.obz,
            v.f092
       FROM v_zay_queue v,
            country c,
            country cc,
            zay_corpdocs zc
      WHERE     v.dk IN (2, 4)
            AND 2 > v.sos
            AND v.sos >= 0
            AND fdat >   bankdate
                       - (SELECT TO_NUMBER (val)
                            FROM birja
                           WHERE par = 'ZAY_DAY')
            AND v.branch LIKE
                   SYS_CONTEXT ('bars_context', 'user_branch') || '%'
            AND v.country = c.country(+)
            AND v.benefcountry = cc.country(+)
            AND v.id = zc.id(+)
   ORDER BY id DESC;

PROMPT *** Create  grants  V_ZAY_SALFORM ***
grant SELECT                                                                 on V_ZAY_SALFORM   to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAY_SALFORM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_SALFORM   to UPLD;
grant SELECT                                                                 on V_ZAY_SALFORM   to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_SALFORM.sql =========*** End *** 
PROMPT ===================================================================================== 
