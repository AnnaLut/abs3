CREATE OR REPLACE VIEW V_EDITPROPS
AS
    SELECT o.REF,
           o.tt,
           o.userid,
           o.nlsa,
           o.s/v1.denom s,
           v1.lcv lcv_a,
           o.vdat,
           o.s2/v2.denom s2,
           v2.lcv lcv_b,
           o.mfob,
           o.nlsb,
           o.dk,
           o.sk,
           o.datd,
           o.pdat
      FROM oper o, tabval$global v1, tabval$global v2
     WHERE     o.kv = v1.kv
           AND o.kv2 = v2.kv
           AND o.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');
/

GRANT SELECT ON V_EDITPROPS TO bars_access_defrole;
/

