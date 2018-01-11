

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLIMPDOCS_UI.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLIMPDOCS_UI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLIMPDOCS_UI ("FN", "DAT", "IMPREF", "REF", "MFOA", "NLSA", "ID_A", "NAM_A", "MFOB", "NLSB", "ID_B", "NAM_B", "S", "S2", "KV", "KV2", "DK", "ND", "TT", "SK", "NAZN", "DATD", "DATP", "VDAT", "VOB", "ERRCODE", "ERRMSG", "STATUS", "TXTSTATUS", "D_REC", "BIS", "USERID") AS 
  SELECT   fn,
            TO_DATE (dat) AS dat,
            impref,
            REF,
            mfoa,
            nlsa,
            id_a,
            nam_a,
            mfob,
            nlsb,
            id_b,
            nam_b,
            s / 100 AS s,
            s2 / 100 AS s2,
            kv,
            kv2,
            dk,
            nd,
            tt,
            sk,
            nazn,
            TO_DATE (datd) AS datd,
            TO_DATE (datp) AS datp,
            TO_DATE (vdat) AS vdat,
            vob,
            errcode,
            errmsg,
            status,
            txtstatus,
            d_rec,
            bis,
            userid
     FROM   v_xmlimpdocs
 ;

PROMPT *** Create  grants  V_XMLIMPDOCS_UI ***
grant SELECT                                                                 on V_XMLIMPDOCS_UI to BARSREADER_ROLE;
grant SELECT                                                                 on V_XMLIMPDOCS_UI to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XMLIMPDOCS_UI to OPER000;
grant SELECT                                                                 on V_XMLIMPDOCS_UI to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_XMLIMPDOCS_UI to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLIMPDOCS_UI.sql =========*** End **
PROMPT ===================================================================================== 
