

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RET_POX.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RET_POX ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RET_POX ("POVERN", "VDAT", "ND", "NAM_A", "NLSA", "KV", "S", "NAZN", "MFOB", "NLSB", "NAM_B", "TT", "BRANCH", "REF") AS 
  SELECT make_docinput_url (
             p_tt            => 'PS2',
             p_visual_name   => 'Повернути',
             p_tag1          => 'Nd',
             p_value1        => o.nd,
             p_tag2          => 'Nam_A',
             p_value2        => SUBSTR (a.nms, 1, 38),
             p_tag3          => 'Nls_A',
             p_value3        => a.Nls,
             p_tag4          => 'Kv_A',
             p_value4        => a.Kv,
             p_tag5          => 'SumC',
             p_value5        => REPLACE (TO_CHAR (o.S / 100), ',', '.'),
             p_tag6          => 'Nazn',
             p_value6        => o.nazn,
             p_tag7          => 'Mfo_B',
             p_value7        => o.mfoa,
             p_tag8          => 'Nls_B',
             p_value8        => '2906603',
             p_tag9          => 'Nam_B',
             p_value9        => 'Повернення суми виплат на поховання',
             p_tag10         => 'Id_B',
             p_value10       => '00032129',
             p_tag11         => 'Vob',
             p_value11       => '1')
             povern,
          o.vdat,
          o.nd,
          SUBSTR (a.nms, 1, 38) nam_a,
          a.nls nlsa,
          a.kv,
          o.S / 100,
          o.nazn,
          o.mfoa,
          '2906603' nlsb,
          'Повернення суми виплат на поховання'
             Nam_b,
          'PS2' tt,
          a.branch,
          o.REF
     FROM oper o, v_gl a
    WHERE     o.sos = 5
          AND o.mfoa = '300465'
          AND o.nlsa LIKE '2906_%'
          AND o.mfob = gl.kf
          AND a.kv = o.kv
          AND a.nls = o.nlsb
          AND a.ob22 = '09'
          AND a.nbs = '2906'
          AND a.ostb >= o.s
          AND o.nazn LIKE 'W;%;На поховання;%'
          AND o.vdat > TO_DATE ('05-05-2012', 'dd-mm-yyyy')
          and exists (select 1 from v_gl av , opldok op, saldoa s where av.acc = op.acc and op.ref = o.ref and av.acc = s.acc
                                                                                               AND av.ob22 = '09'     AND av.nbs = '2906'  and av.kf = f_ourmfo
                                                                                               and s.fdat = op.fdat
                                                                                                );

PROMPT *** Create  grants  V_RET_POX ***
grant SELECT                                                                 on V_RET_POX       to BARSREADER_ROLE;
grant SELECT                                                                 on V_RET_POX       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RET_POX       to PYOD001;
grant SELECT                                                                 on V_RET_POX       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RET_POX.sql =========*** End *** ====
PROMPT ===================================================================================== 
