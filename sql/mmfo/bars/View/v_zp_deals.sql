create or replace view v_zp_deals
as
SELECT z.id,
          z.deal_id,
          z.start_date,
          z.close_date,
          z.rnk,
          c.nmk,
          z.deal_name,
          c.okpo,
          f.id fs,
          f.name fs_name,
          z.sos,
          sos.name sos_name,
          z.deal_premium,
          z.central,
          z.kod_tarif,
          z.acc_2909,
          a.nls nls_2909,
          a.ostc / 100 ostc_2909,
          a.ostb / 100 ostb_2909,
          z.acc_3570,
          aa.nls nls_3570,
          aa.ostc / 100 ostc_3570,
          aa.ostb / 100 ostb_3570,
          z.branch,
          z.kf,
          z.user_id,
          s.fio,
          CASE
             WHEN z.sos IN (1,
                            2,
                            3,
                            4,
                            6)
             THEN
                z.comm_reject
             ELSE
                NULL
          END
             comm_reject,
          CASE WHEN i.rnk IS NULL THEN 'Ні' ELSE 'Так' END corp2,
          t.name tarif_name,
          t.tar / 100 tar,
          CASE
             WHEN (SELECT MAX (pr)
                     FROM tarif_scale
                    WHERE kod = z.kod_tarif AND kf = z.kf AND t.tip = 1)
                     IS NOT NULL
             THEN
                   'до '
                || TO_CHAR (
                      (SELECT MAX (pr)
                         FROM tarif_scale
                        WHERE kod = z.kod_tarif AND kf = z.kf AND t.tip = 1),
                      'FM90D9999')
                || ' %'
             ELSE
                TO_CHAR (t.pr, 'FM90D9999') || ' %'
          END
             max_tarif,
          CASE
             WHEN (SELECT pr
                     FROM acc_tarif
                    WHERE     acc = z.acc_2909
                          AND kf = z.kf
                          AND kod = z.kod_tarif)
                     IS NULL
             THEN
                NULL
             ELSE
                   TO_CHAR (
                      (SELECT pr
                         FROM acc_tarif
                        WHERE     acc = z.acc_2909
                              AND kf = z.kf
                              AND kod = z.kod_tarif),
                      '90D99')
                || ' %'
          END
             ind_acc_tarif,
          t.tip,
          c.nmkv
     FROM zp_deals z,
          customer c,
          accounts a,
          accounts aa,
          zp_deals_fs f,
          staff$base s,
          barsaq.ibank_rnk i,
          tarif t,
          zp_deals_sos sos
    WHERE     c.rnk = z.rnk
          AND f.id(+) = z.fs
          AND a.acc = z.acc_2909
          AND z.acc_3570 = aa.acc(+)
          AND s.id = z.user_id
          AND z.rnk = i.rnk(+)
          AND z.kod_tarif = t.kod(+)
          AND z.kf =t.kf(+)
          AND t.kv(+) = '980'
          AND z.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          AND sos.sos = z.sos;
/
grant select,delete,update,insert on bars.v_zp_deals to bars_access_defrole;
/
