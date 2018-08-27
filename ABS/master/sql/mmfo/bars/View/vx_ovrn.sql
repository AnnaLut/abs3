CREATE OR REPLACE VIEW VX_OVRN AS
SELECT t.rnk,  t.kv,  t.nms,  t.NLS,  i.acr_dat,  y.dat1,  y.dat2,  x.acc8,  x.acc,       ROUND (ABS (x.pr), 0) PR,       1 - i.id ID,       aa.nls NLSA,       aa.nms NAM_a,       x.vn,
       DECODE (x.vn, 70, acrn.fprocn (x.acc8, 1, y.dat2), NULL) ip8,
       DECODE (x.vn, 60, acrn.fprocn (x.acc8, 0, y.dat2), NULL) ia8,
       DECODE (x.vn, 70, acrn.fprocn (x.acc, 1, y.dat2), NULL) ip2,
       DECODE (x.vn, 60, acrn.fprocn (x.acc, 0, y.dat2), NULL) ia2,
       SUBSTR (  CASE   WHEN aa.tip IN ('SPN')        THEN   CASE  WHEN OVRN.F2017 = 1  THEN  nbs_ob22_null ('6025', '17', t.branch)   ELSE   nbs_ob22_null ('6026', '17', t.branch)   END
                        WHEN x.vn IN (60,61,62,63,65)    THEN   nbs_ob22_null ('6020', '06', t.branch)
                        WHEN x.vn IN (70)             THEN   nbs_ob22_null ('7020', '06', t.branch)
                        ELSE                                 NULL
                 END,     1,15) NLSB,
       DECODE (x.vn,70, '����.������� �� ���.���.','����.�� ����.���.')  || ' �� ���.���'     NAM_B,
       SUBSTR (DECODE (x.vn,   60,'���.%% ���.�� ��� ',   70,'���.%% ����.',    61,'���.��� �� ��� 1 ��',  62,'���.��� �� ��� ����.',  63,'���.��� �� ���� NPP',65,'�������.%% ���.�� ���',    NULL), 1, 38) NAzn
FROM int_accn i,          accounts aa,          accounts t,
    (  SELECT acc, MIN(cdat) dat1, MAX(cdat) dat2 FROM ovr_intx     WHERE /*ISP = BARS.USER_ID and*/ mod1 = 1 and state=0     GROUP BY acc          ) y,
    (  SELECT acc8, acc,  VN,  SUM (decode(VN,65,dpr, pr)) pr        FROM ovr_intx     WHERE /*ISP = BARS.USER_ID and*/ mod1 = 1 and state=0     GROUP BY acc8, acc, VN) x
WHERE  x.acc = y.acc  AND x.acc = t.acc   AND t.acc = i.acc       AND i.id = DECODE (SIGN (x.pr), 1, 1, 0)       AND aa.acc = i.acra;

GRANT SELECT ON BARS.VX_OVRN TO BARS_ACCESS_DEFROLE;
