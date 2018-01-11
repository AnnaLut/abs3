

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCT_STATEMENTS2.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCT_STATEMENTS2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCT_STATEMENTS2 ("STMT", "SOS", "TT", "REF", "DK", "DOS", "KOS", "COMM", "PDAT", "MFOA", "NLSA", "IDA", "KV", "NAM_A", "MFOB", "NLSB", "IDB", "KV2", "NAM_B", "ND", "FDAT", "ACC", "DKP") AS 
  SELECT o.stmt,
            o.sos,
            o.tt,
            o.REF,
            p.dk,
            DECODE (o.dk, 0, o.s / POWER (10, d.dig), 0) AS dos,
            DECODE (o.dk, 1, o.s / POWER (10, d.dig), 0) AS kos,
            p.nazn                     /*DECODE (o.tt, p.tt, p.nazn, t.name)*/
                  AS comm,
            p.pdat AS pdat,
            p.mfoa,
            p.nlsa,
            p.id_a,
            p.kv,
            p.nam_a,
            p.mfob,
            p.nlsb,
            p.id_b,
            p.kv2,
            p.nam_b,
            p.nd,
            o.fdat,
            o.acc,
            o.dk dkp
       FROM opldok o, /* 22.05.2017 lypskykh: changed to opldov from opldok to show docs from child accounts*/
            accounts a,
            oper p,
            tts t,
            tabval d
      WHERE o.REF = p.REF AND d.kv = a.kv AND a.acc = o.acc AND t.tt = o.tt
   ORDER BY fdat DESC, o.dk, o.s;

PROMPT *** Create  grants  V_ACCT_STATEMENTS2 ***
grant SELECT                                                                 on V_ACCT_STATEMENTS2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCT_STATEMENTS2.sql =========*** End
PROMPT ===================================================================================== 
