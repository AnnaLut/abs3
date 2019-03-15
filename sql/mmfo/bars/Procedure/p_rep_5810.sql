
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/p_rep_5810.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.P_REP_5810 (p_dat1 DATE,
                                       p_dat2 DATE,
                                       p_mfo  VARCHAR2) IS
  l_mfo VARCHAR(6) := TRIM(p_mfo);
  CURSOR c_table IS
    SELECT rownum,
           op.mfoa,
           (SELECT NAME FROM branch WHERE branch = op.branch) b,
           to_char(op.pdat, 'DD.MM.YYYY hh24:mi:ss') pdat,
           to_char(op.odat, 'DD.MM.YYYY hh24:mi:ss') odat,
           op.s / 100 s,
           round((op.s / 100) * 0.0035, 2) prcnt,
           to_char(op.datd, 'DD.MM.YYYY') datd,
           op.nd,
           to_char(p_dat1, 'DD.MM.YYYY') sfdat1,
           to_char(p_dat2, 'DD.MM.YYYY') sfdat2,
           nam_b,
           op.id_b
      FROM oper op
     WHERE op.mfob = '300584'
       AND op.nlsb = '26007201036089'
       AND op.ref IN (SELECT REF
                        FROM opldok od
                       WHERE od.tt = 'TO1'
                         AND od.dk = 0
                         AND od.fdat BETWEEN p_dat1 AND p_dat2
                         AND od.sos = 5
                         AND od.kf LIKE l_mfo);
BEGIN
  DELETE FROM tmp_rep_5810;
  

  bc.go(l_mfo);
  FOR l_row IN c_table LOOP
    INSERT INTO tmp_rep_5810 VALUES l_row;
  END LOOP;
  bc.home();

END p_rep_5810;

/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/p_rep_5810.sql =========*** End **
 PROMPT ===================================================================================== 
 