

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ARCH_FORW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ARCH_FORW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_ARCH_FORW ("REF_REPO", "REF", "ID", "CP_ID", "KV", "NAME", "DAT_UG", "DAT_OPL", "TIP", "IR", "DAT_ROZ", "SUMB", "T", "TQ", "N", "D", "P", "R", "S", "Z", "VD", "VP", "STR_REF", "OP", "NAME_OP", "SOS", "SN", "REF_MAIN", "NOM", "ND", "NBS", "NBB", "NTIK", "RNK_EMI") AS 
  SELECT a.ref_repo,
          a.REF,
          a.id,
          k.cp_id,
          k.kv,
          k.name,
          a.dat_ug,
          a.dat_opl,
          k.tip,
          k.ir,
          a.dat_roz,
          a.sumb / 100,
          a.t / 100,
          a.tq / 100,
          a.n / 100,
          a.d / 100,
          a.p / 100,
          a.r / 100,
          a.s / 100,
          a.z / 100,
          a.vd / 100,
          a.vp / 100,
          a.str_ref,
          a.op,
          CASE
             WHEN OP = 1
             THEN
                'Купівля'
             WHEN OP = 2
             THEN
                'Продаж'
             WHEN OP = 3
             THEN
                'Переведення'
             WHEN OP = 4
             THEN
                'Сплата %'
             WHEN OP = 5
             THEN
                'Оприбуткування гарантії на 1 пакет'
             WHEN OP = 6
             THEN
                'Зміна гарантії на 1 пакет'
             WHEN OP = 7
             THEN
                'Списання гарантії на 1 пакет'
             WHEN OP = 20
             THEN
                'Погашення'
             WHEN OP = 22
             THEN
                'Погашення (частк)'
             WHEN OP = -2
             THEN
                'FORWARD - Продаж'
             ELSE
                NULL
          END
             AS name_op,
          o.sos,
          a.sn / 100,
          a.ref_main,
          a.nom,
          o.nd,
          SUBSTR (o.nlsa, 1, 4) nbs,
          ct.nbb,
          ct.ntik,
          k.rnk_emi
     FROM cp_arch a,
          oper o,
          (SELECT id,
                  cp_id,
                  tip,
                  ir,
                  kv,
                  name,
                  rnk AS rnk_emi
             FROM cp_kod
            WHERE id > 0) k,
          cp_ticket ct
    WHERE     k.id = a.id
          AND a.REF = o.REF
          AND NVL (o.sos, 3) > 0
          AND ct.REF(+) = a.REF
          AND a.OP = -2 and a.DAT_ROZ <= gl.bd;

PROMPT *** Create  grants  V_CP_ARCH_FORW ***
grant SELECT                                                                 on V_CP_ARCH_FORW  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ARCH_FORW  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ARCH_FORW  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ARCH_FORW.sql =========*** End ***
PROMPT ===================================================================================== 
