

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_PD9.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_PD9 ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_PD9 ("ND", "CC_ID", "RNK", "SDATE", "WDATE", "SOS", "NMK", "OKPO", "SDOG", "BRANCH", "OPR", "SPR", "VPZ", "SPZ", "PERF") AS 
  SELECT                                                /* +first_rows(10) */
         d.nd,
          d.cc_id,
          d.rnk,
          d.sdate,
          d.wdate,
          d.sos,
          UPPER (c.nmk),
          c.okpo,
          0 sdog,
          d.branch,
          make_docinput_url (
             'VS1',
             'Оприбуткувати',
             'Dk',
             '0',
             'DisR',
             '1',
             'VOB',
             '180',
             'DisA',
             '1',
             'DisB',
             '1',
             'reqv_FIO',
             C.NMK,
             'reqv_ND',
             d.ND,
             'NAZN',
             'Внесено в сховище #(VA_KC) по кредиту #(FIO) Ref кред. № #(ND)', --'  кред. дог. №'||d.nd|| ' вiд '|| d.sdate,
             'Nls_A',
             nbs_ob22_null (9910, '01'),
             'Nls_B',
             '#(nbs_ob22_null(substr(#(VA_KC),2,4),substr(#(VA_KC),7,2), SYS_CONTEXT (''bars_context'', ''user_branch'') ) )')
             OPR,
          make_docinput_url (
             'VS2',
             'Списати',
             'Dk',
             '1',
             'VOB',
             '180',
             'DisR',
             '1',
             'DisA',
             '1',
             'DisB',
             '1',
             'reqv_FIO',
             C.NMK,
             'reqv_ND',
             d.ND,
             'NAZN',
             'Винесено iз сховища #(VA_KC) по кредиту #(FIO) Ref кред. № #(ND)',
             'Nls_A',
             nbs_ob22_null (9910, '01'),
             'Nls_B',
             '#(nbs_ob22_null(substr(#(VA_KC),2,4),substr(#(VA_KC),7,2), SYS_CONTEXT (''bars_context'', ''user_branch'') ) )')
             SPR,
          make_docinput_url (
             'VSK',
             'Видати в пiдзвiт',
             'Dk',
             '1',
             'DisR',
             '1',
             'VOB',
             '180',
             'KV_A',
             980,
             'KV_B',
             980,
             'DisB',
             '1',
             'reqv_FIO',
             C.NMK,
             'reqv_ND',
             d.ND,
             'NAZN',
             'Видано в пiдзвiт з сховища #(VA_KC) по кредиту #(FIO) Ref кред. № #(ND)', --'  кред. дог. №'||d.nd|| ' вiд '|| d.sdate,
             'Nls_B',
             '#(nbs_ob22_null(substr(#(VA_KC),2,4),substr(#(VA_KC),7,2), SYS_CONTEXT (''bars_context'', ''user_branch'') ) )')
             VPZ,
          make_docinput_url (
             'VSL',
             'Здано з пiдзвiту',
             'Dk',
             '0',
             'DisR',
             '1',
             'VOB',
             '180',
             'KV_A',
             980,
             'KV_B',
             980,
             'DisB',
             '1',
             'reqv_FIO',
             C.NMK,
             'reqv_ND',
             d.ND,
             'NAZN',
             'Здано з пiдзвiту в сховище #(VA_KC) по кредиту #(FIO) Ref кред. № #(ND)',
             'Nls_B',
             '#(nbs_ob22_null(substr(#(VA_KC),2,4),substr(#(VA_KC),7,2), SYS_CONTEXT (''bars_context'', ''user_branch'') ) )')
             SPZ,
          make_docinput_url (
             'VS4',
             'Передати до філії банку',
             'Dk',
             '1',
             'VOB',
             '180',
             'DisR',
             '1',
             'DisA',
             '1',
             'DisB',
             '1',
             'reqv_FIO',
             C.NMK,
             'reqv_ND',
             d.ND,
             'NAZN',
             'Винесено iз сховища #(VA_KC) по кредиту #(FIO) Ref кред. № #(ND) для передачі до філії банку  ',
             'Nls_A',
             (nbs_ob22_null (9899, '17', cash_sxo.GET_SXO(d.branch))),
             'Nls_B',
             '#(nbs_ob22_null(substr(#(VA_KC),2,4),substr(#(VA_KC),7,2), SYS_CONTEXT (''bars_context'', ''user_branch'') ) )',
             'APROC',
             'begin null; end;@begin insert into cc_989917_ref (ref1) values (:REF);end;')
             PERF
     FROM v_cc_deal d, customer c
    WHERE     c.rnk = d.rnk
          AND c.custtype IN (3, 2)
          AND EXISTS
                 (SELECT 1
                    FROM branch
                   WHERE     branch = d.branch
                         AND branch LIKE
                                   SUBSTR (
                                      SYS_CONTEXT ('bars_context',
                                                   'user_branch'),
                                      1,
                                      15)
                                || '%')
--order by c.nmk
;

PROMPT *** Create  grants  CC_PD9 ***
grant FLASHBACK,SELECT                                                       on CC_PD9          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PD9          to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PD9          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_PD9          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_PD9.sql =========*** End *** =======
PROMPT ===================================================================================== 
