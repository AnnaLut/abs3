CREATE OR REPLACE FORCE VIEW V_DPT_AGR_DAT_WEB
(
   DPT_ID,
   ND,
   BRANCH,
   RNK,
   NMK,
   OKPO,
   AGRMNT_ID,
   AGRMNT_NUM,
   AGRMNT_DATE,
   DATE_BEGIN,
   DATE_END
)
AS
   SELECT da.DPT_ID,
          d.ND,
          d.BRANCH,
          c.RNK,
          c.NMK,
          c.OKPO,
          da.AGRMNT_ID,
          da.AGRMNT_NUM,
          da.AGRMNT_DATE,
          da.DATE_BEGIN,
          da.DATE_END
     FROM dpt_agreements da, dpt_deposit d, customer c
    WHERE     da.agrmnt_type = 12
          AND da.dpt_id = d.deposit_id
          AND d.rnk = c.rnk         
          AND d.branch LIKE
                 SYS_CONTEXT ('bars_context', 'user_branch') || '%'
/

GRANT SELECT, UPDATE ON V_DPT_AGR_DAT_WEB TO DPT_ROLE
/
