/* Formatted on 11/01/2016 13:54:44 (QP5 v5.269.14213.34769) */
CREATE OR REPLACE FORCE VIEW V_DBO_DEPOSIT_LIST
(
   CUST_ID,
   DPT_ACCNUM,
   DPT_CURCODE,
   CUST_NAME,
   VIDD_CODE,
   VIDD_NAME,
   RATE,
   INT_KOS,
   DPT_SALDO,
   DAT_BEGIN,
   DAT_END,
   TERM_ADD,
   LIM,
   MINREP,
   DPT_ID,
   ISPROLOGABLE,
   ISCAPITALIZATION,
   PERCENTCHARGEACCOUNT,
   PERCENTACCOUNT,
   EXPIREACCOUNT
)
AS
   SELECT dpa.cust_id,
          dpa.dpt_accnum,
          dpa.dpt_curcode,
          dpa.cust_name,
          dpa.vidd_code,
          dpa.vidd_name,
          dpa.rate,
            (SELECT a.ostc
               FROM dpt_accounts da, accounts a
              WHERE     da.accid = a.acc
                    AND a.tip = 'DEN'
                    AND da.dptid = dpa.dpt_id)
          / 100
             AS int_kos,
          dpa.dpt_saldo / 100 AS dpt_saldo,
          dpa.dat_begin,
          dpa.dat_end,
          DECODE (
             v.term_add,
             0, TO_DATE (NULL),
               ADD_MONTHS (dpa.dat_begin, TRUNC (v.term_add, 0))
             + TRUNC (MOD (v.term_add, 1) * 100))
             AS term_add,
            (CASE
                WHEN (SELECT nbs
                        FROM accounts
                       WHERE acc = dpa.dpt_accid) = 2620
                THEN
                     (SELECT lim
                        FROM accounts
                       WHERE acc = dpa.dpt_accid)
                   * -1
                ELSE
                   dpa.dpt_saldo
             END)
          / 100
             AS lim,
          DECODE (v.LIMIT,  NULL, 0,  0, 1,  v.LIMIT) AS minrep,
          dpa.dpt_id,
          (CASE
              WHEN     v.fl_dubl = 2
                   AND (SELECT COUNT (1)
                          FROM dpt_extrefusals
                         WHERE dptid = dpa.dpt_id) = 0
              THEN
                 1
              ELSE
                 0
           END)
             AS isprologable,
          v.comproc AS iscapitalization,
          dpa.int_accnum AS percentchargeaccount,
          dpa.intrcp_acc AS percentaccount,
          dpa.dptrcp_acc AS expireaccount
     FROM v_dpt_portfolio_active dpa, dpt_vidd v
    WHERE dpa.vidd_code = v.vidd;

GRANT SELECT ON V_DBO_DEPOSIT_LIST TO BARS_ACCESS_DEFROLE;	