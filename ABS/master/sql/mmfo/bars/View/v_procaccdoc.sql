

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PROCACCDOC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PROCACCDOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PROCACCDOC ("NN", "REC", "REF", "MFOA", "NLSA", "MFOB", "NLSB", "DK", "S", "VOB", "ND", "KV", "DATD", "DATP", "NAM_A", "NAM_B", "NAZN", "NAZNK", "NAZNS", "ID_A", "ID_B", "ID_O", "REF_A", "BIS", "SIGN", "FN_A", "DAT_A", "REC_A", "FN_B", "DAT_B", "REC_B", "D_REC", "BLK", "SOS", "PRTY", "FA_NAME", "FA_LN", "FA_T_ARM3", "FA_T_ARM2", "FC_NAME", "FC_LN", "FC_T1_ARM2", "FC_T2_ARM2", "FB_NAME", "FB_LN", "FB_T_ARM2", "FB_T_ARM3", "FB_D_ARM3") AS 
  select 1 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"    -- ќтветные заквитованные кредитовые
     from arc_rrp a
    where a.dk = 1
      and (a.fn_a, a.dat_a) in (
                           select fn, dat
                             from zag_a
                            where otm >= 5 and dat >= gl.bd
                                  and dat < gl.bd + 1)
   union all
   select 2 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"     -- ќтветные заквитованные дебетовые
     from arc_rrp a
    where a.dk = 0
      and (a.fn_a, a.dat_a) in (
                           select fn, dat
                             from zag_a
                            where otm >= 5 and dat >= gl.bd
                                  and dat < gl.bd + 1)
   union all
   select 3 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"   -- Ќачальные заквитованные кредитовые
     from arc_rrp a
    where a.dk = 1
      and (a.fn_b, a.dat_b) in (
                           select fn, dat
                             from zag_b
                            where otm >= 5 and dat >= gl.bd
                                  and dat < gl.bd + 1)
   union all
   select 4 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"  -- ќтветные незаквитованные кредитовые
     from arc_rrp a
    where a.dk = 1
      and (a.fn_a, a.dat_a) in (
                            select fn, dat
                              from zag_a
                             where otm < 5 and dat >= gl.bd
                                   and dat < gl.bd + 1)
   union all
   select 5 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"   -- ќтветные незаквитованные дебетовые
     from arc_rrp a
    where a.dk = 0
      and (a.fn_a, a.dat_a) in (
                            select fn, dat
                              from zag_a
                             where otm < 5 and dat >= gl.bd
                                   and dat < gl.bd + 1)
   union all
   select 6 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"           --  Ќачальные незаквитованные
     from arc_rrp a
    where a.dk = 1
      and (a.fn_b, a.dat_b) in (
                            select fn, dat
                              from zag_b
                             where otm < 5 and dat >= gl.bd
                                   and dat < gl.bd + 1)
   union all
   select 7 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3",
          a."FB_D_ARM3"              --  Ќачальные неотобранные неопределенные
     from arc_rrp a, rec_que q
    where a.dk = 1
      and a.mfoa in (select mfo
                       from lkl_rrp
                      where mfo <> (select val
                                      from params
                                     where par = 'MFOP'))
      and a.fn_b is null
      and a.blk is null
      and a.rec = q.rec
   union all
   select 8 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3",
          a."FB_D_ARM3"             -- Ќачальные неотобранные разблокированные
     from arc_rrp a, rec_que q
    where a.dk = 1
      and a.mfoa in (select mfo
                       from lkl_rrp
                      where mfo <> (select val
                                      from params
                                     where par = 'MFOP'))
      and a.fn_b is null
      and a.blk = 0
      and a.sos = 3
      and a.rec = q.rec
   union all
   select 9 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3",
          a."FB_D_ARM3"             --  Ќачальные неотобранные заблокированные
     from arc_rrp a, rec_que q
    where a.dk = 1
      and a.rec = q.rec
      and a.mfoa in (select mfo
                       from lkl_rrp
                      where mfo <> (select val
                                      from params
                                     where par = 'MFOP'))
      and a.fn_b is null
      and a.blk > 0
   union all
   select 10 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3" --  ќтветные заблокированные кредитовые
     from arc_rrp a, rec_que q
    where a.dk = 1
      and a.mfob in (select mfo
                       from lkl_rrp
                      where mfo <> (select val
                                      from params
                                     where par = 'MFOP'))
      and a.blk > 0
      and a.rec = q.rec
   union all
   select 11 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"  --  ќтветные заблокированные дебетовые
     from arc_rrp a, rec_que q
    where a.dk = 0
      and a.mfob in (select mfo
                       from lkl_rrp
                      where mfo <> (select val
                                      from params
                                     where par = 'MFOP'))
      and a.blk > 0
      and a.rec = q.rec
   union all
   select 12 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"     -- ќтветные невы€сненные кредитовые
     from arc_rrp a
    where a.dk = 1
      and a.mfob in (select mfo
                       from lkl_rrp
                      where mfo <> (select val
                                      from params
                                     where par = 'MFOP'))
      and a.ref in (select ref
                      from t902)
      and a.sos = 5
   union all
   select 13 nn, a."REC", a."REF", a."MFOA", a."NLSA", a."MFOB", a."NLSB",
          a."DK", a."S", a."VOB", a."ND", a."KV", a."DATD", a."DATP",
          a."NAM_A", a."NAM_B", a."NAZN", a."NAZNK", a."NAZNS", a."ID_A",
          a."ID_B", a."ID_O", a."REF_A", a."BIS", a."SIGN", a."FN_A",
          a."DAT_A", a."REC_A", a."FN_B", a."DAT_B", a."REC_B", a."D_REC",
          a."BLK", a."SOS", a."PRTY", a."FA_NAME", a."FA_LN", a."FA_T_ARM3",
          a."FA_T_ARM2", a."FC_NAME", a."FC_LN", a."FC_T1_ARM2",
          a."FC_T2_ARM2", a."FB_NAME", a."FB_LN", a."FB_T_ARM2",
          a."FB_T_ARM3", a."FB_D_ARM3"      -- ќтветные невы€сненные дебетовые
     from arc_rrp a
    where a.dk = 0
      and a.mfob in (select mfo
                       from lkl_rrp
                      where mfo <> (select val
                                      from params
                                     where par = 'MFOP'))
      and a.ref in (select ref
                      from t902)
 ;

PROMPT *** Create  grants  V_PROCACCDOC ***
grant SELECT                                                                 on V_PROCACCDOC    to BARS014;
grant SELECT                                                                 on V_PROCACCDOC    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PROCACCDOC    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PROCACCDOC.sql =========*** End *** =
PROMPT ===================================================================================== 
