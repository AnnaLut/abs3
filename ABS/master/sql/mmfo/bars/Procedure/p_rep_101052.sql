

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REP_101052.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REP_101052 ***

  CREATE OR REPLACE PROCEDURE BARS.P_REP_101052 (p_dat1   DATE,
                                         p_dat2   DATE,
                                         p_tag1   VARCHAR2,
                                         p_tag2   VARCHAR2,
                                         p_tag3   VARCHAR2,
                                         p_kf     VARCHAR2,
                                         p_ob22   VARCHAR2,
                                         p_nls_z  VARCHAR2,
                                         p_nls_po VARCHAR2,
                                         p_kv     VARCHAR2) IS
  CURSOR l_cur IS
    SELECT op.ref,
           op.tt,
           op.nam_a,
           op.nam_b,
           op.s * (decode(op.dk, 0, 1, 0)) debit,
           op.s * op.dk credit,
           op.nazn,
           op.pdat,
           op.vdat,
           (SELECT VALUE
              FROM operw opw
             WHERE opw.ref = op.ref
               AND opw.tag IN ('OW_DS')) edesc, --доп реквизит описание way4
           (SELECT VALUE
              FROM operw opw
             WHERE opw.ref = op.ref
               AND opw.tag IN ('OW_LD')) edate, --доп реквизит date
           (SELECT VALUE
              FROM operw opw
             WHERE opw.ref = op.ref
               AND opw.tag IN ('OWDRN')) eref
      FROM oper op
     WHERE op.ref IN
           (SELECT REF
              FROM accounts acc
              JOIN opldok opd
                ON opd.acc = acc.acc
             WHERE acc.kv LIKE p_kv
               AND acc.kf LIKE p_kf
               AND acc.nbs BETWEEN p_nls_z AND p_nls_po
               AND acc.ob22 IN
                   (SELECT regexp_substr(p_ob22, '[^,]+', 1, LEVEL)
                      FROM dual
                    CONNECT BY regexp_substr(p_ob22, '[^,]+', 1, LEVEL) IS NOT NULL)
               AND acc.kv LIKE p_kv
               AND opd.kf LIKE p_kv
               AND opd.fdat BETWEEN p_dat1 AND p_dat2
               AND opd.sos = 5)
       AND 0 < (SELECT COUNT(tag) --поиск по заданым тегам
                  FROM operw opw
                 WHERE op.ref = opw.ref
                   AND opw.tag IN (p_tag1, p_tag2, p_tag3))
     ORDER BY op.pdat,
              op.nlsa,
              op.vdat;
              
              l_row l_cur%ROWTYPE;
BEGIN

  -------------------------------------------------------------------
  DELETE FROM tmp_rep_101052;
  -------------------------------------------------------------------

  IF (p_kf = '%') THEN
    bc.go('/');
  ELSE
    IF (p_kf IS NOT NULL) THEN
      bc.subst_mfo(p_kf);
    END IF;
  END IF;
  BEGIN
    FOR l_row IN l_cur LOOP
      INSERT INTO tmp_rep_101052 VALUES l_row;
    END LOOP;
  EXCEPTION
    WHEN no_data_found THEN
      INSERT INTO tmp_rep_101052
        (REF)
      VALUES
        ('Данні відсутні');
  END;
  bc.home();
END p_rep_101052;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REP_101052.sql =========*** End 
PROMPT ===================================================================================== 
