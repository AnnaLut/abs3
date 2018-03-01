

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_BUYFORM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_BUYFORM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_BUYFORM ("ID", "SOS", "SVIZA", "CUST_BRANCH", "RNK",
 "NMK", "ACC0", "NLS_ACC0", "OSTC0", "ACC1", "NLS", "S2", "DIG", "S2S", "MFO0", "NLS0", "FDAT",
 "ND", "KOM", "SKOM", "KURS_Z", "KURS_F", "VDATE", "META", "AIM_NAME", "CONTRACT", "DATC", 
"NUM_VMD", "VMD1", "VMD5", "COUNTRY", "CBCOUNTRY", "BASIS", "BENEFCOUNTRY", "CBBENEFCOUNTRY",
 "BANK_CODE", "BANK_NAME", "PRODUCT_GROUP", "PRODUCT_GROUP_NAME", "DATZ", "COMM", "CONTACT_FIO",
 "CONTACT_TEL", "COVERED", "KB", "KV", "DOC_DESC", "KV_CONV", "LCV_CONV", "DATT","F092") AS 
  select v.id,
    sos,
    decode(viza,
		   -1,
           '-1-Відмовлено у візі',
           0,
           '0-Чекає на візу',
           2,
           '2-Підтверджено як пріоритетну',
           '1-Завізовано') sviza,
    cust_branch,
    rnk,
    nmk,
    acc0,
    nls_acc0,
    ostc0 / power(10, dig) ostc0,
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
    to_char(meta, '09') || ' ' || aim_name aim_name,
    contract,
    dat2_vmd datc,
    num_vmd,
    dat_vmd vmd1,
    dat5_vmd vmd5,
    v.country,
    c.name cbcountry,
    substr(basis, 1, 254) basis,
    benefcountry,
    cc.name cbbenefcountry,
    bank_code,
    bank_name,
    product_group,
    to_char(product_group, '09') || ' ' || product_group_name product_group_name,
    nvl(datz, vdate) datz,
    comm,
    contact_fio,
    contact_tel,
    bars_zay.get_request_cover(v.id) COVERED,
    decode(nvl(identkb, 0), 0, 0, 1) kb,
    kv2 kv,
    nvl(zc.doc_desc, null) doc_desc,
    nvl(kv_conv, 980) kv_conv,
    nvl(lcv_conv, 'UAH') lcv_conv,
    v.datt,
    v.f092
    from v_zay_queue v,
	  country c,
	  country cc,
	  zay_corpdocs zc
  where dk in (1, 3)
    and 2 > sos
    and branch LIKE SYS_CONTEXT('bars_context', 'user_branch') || '%'
    and v.country = c.country(+)
    and v.benefcountry = cc.country(+)
    and v.id = zc.id(+)
  order by id desc;

PROMPT *** Create  grants  V_ZAY_BUYFORM ***
grant SELECT                                                                 on V_ZAY_BUYFORM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_BUYFORM   to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_BUYFORM.sql =========*** End *** 
PROMPT ===================================================================================== 
