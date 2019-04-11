CREATE OR REPLACE VIEW V_SEP_DOCS_FIND AS
SELECT o.dk DK,
                                 o.REF REF,
                                 a.mfoa MFOA,
                                 a.nlsa NLSA,
                                 a.s / 100 S,
                                nvl((SELECT nlsb
                                               FROM arc_rrp
                                              WHERE rec = t.rec_o), a.nlsb) NLSB,
                                 a.nam_b NAMB,
                                 a.nazn NAZN,
                                 a.d_rec DREC,
                                 a.rec REC,
                                 o.fdat FDAT,
                                 a.nd ND,
                                 a.nam_a NAMA,
                                 a.vob VOB,
                                 a.datd DATD,
                                 a.datp DATP,
                                 a.id_a OKPOA,
                                 case when t.rec_o is not null then nvl(k.okpo,a.id_b )
                                 else a.id_b
                                 end OKPOB,
                                 k.okpo OKPOB2,
                                 s.nms NAMB2,
                                 CASE
                                    WHEN    s.nls IS NOT NULL
                                         OR nvl((SELECT nlsb
                                               FROM arc_rrp
                                              WHERE rec = t.rec_o), a.nlsb) <> a.nlsb
                                    THEN
                                       1
                                    ELSE
                                       0
                                 END
                                    OTM,
                                 a.kv KV,
                                 s.nlsalt NLSALT,
                                 s.dazs DAZS,
                                 t.blk BLK,
                                 t.otm SOS,
                                 t.rec_o RECO,
                                 t.stmp STMP,
                                 s.blkk BLKK,
                                 a.mfob MFOB,
                                 o.acc ACC,
                                 a.fa_name FA_NAME,
                                 a.fa_ln FA_LN,
                                 case
                                  when (select count(1) from fdat d where d.fdat between a.datp and bankdate)>=4 then 1
                                  else 0
                                 end PAYTODAY

                            FROM arc_rrp a,
                                 opldok o,
                                 t902 t,
                                 accounts s,
                                 customer k
                           WHERE     o.acc IN (SELECT acc
                                                 FROM accounts
                                                WHERE tip IN ('902', '90D'))
                                 AND o.tt IN ('R01', 'D01')
                                 AND a.rec = t.rec
                                 AND o.REF = t.REF
                                 AND a.nlsb = s.nls(+)
                                 AND a.kv = s.kv(+)
                                 AND s.rnk = k.rnk(+);

grant SELECT                                                                 on V_SEP_DOCS_FIND          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SEP_DOCS_FIND          to BARS_ACCESS_DEFROLE;
