

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DPT_OB22.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DPT_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.P_DPT_OB22 ( dat_ DATE )
IS
  ob_   CHAR(2); obn_   CHAR(2);   accn_ INTEGER;
BEGIN
 FOR c IN
   (SELECT d.acc ACC, d.vidd VIDD, do.ob22 OB22, do.ob22n OB22N
    FROM dpt_deposit d, dpt_vidd_ob22 do
    WHERE d.DEPOSIT_ID <> 36 AND d.vidd=do.vidd AND d.dat_begin<=dat_ )
   LOOP
 DBMS_OUTPUT.PUT_LINE( 'ACC='||c.acc||', VIDD='||c.vidd||', OB22 DEP='||c.ob22||', OB22 DEN='||c.ob22n);
 SELECT acra INTO accn_ FROM int_accn WHERE id=1 AND acc=c.acc;
 DBMS_OUTPUT.PUT_LINE( 'ACCN='||accn_);
   BEGIN
     SELECT ob22 INTO ob_ FROM specparam_int WHERE acc=c.acc;
     DBMS_OUTPUT.PUT_LINE( 'OB_DEP_OLD='||ob_);
     IF ob_ IS NULL OR ob_<>c.ob22 THEN
       UPDATE specparam_int SET ob22=c.ob22 WHERE acc=c.acc;
     END IF;
     EXCEPTION WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE( '---------1% Before INSERT: '||c.acc||'-'||c.ob22);
      INSERT INTO specparam_int(acc,ob22) VALUES (c.acc,c.ob22);
   END;
   BEGIN
     SELECT ob22 INTO obn_ FROM specparam_int WHERE acc=accn_;
     DBMS_OUTPUT.PUT_LINE( 'OB_DEN_OLD='||obn_);
     IF obn_ IS NULL OR obn_<>c.ob22n THEN
       UPDATE specparam_int SET ob22=c.ob22n WHERE acc=accn_;
     END IF;
     EXCEPTION WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE( '---------2% Before INSERT: '||accn_||'-'||c.ob22n);
       INSERT INTO specparam_int(acc,ob22) VALUES (accn_,c.ob22n);
     END;
 END LOOP;
END p_dpt_ob22;
/
show err;

PROMPT *** Create  grants  P_DPT_OB22 ***
grant EXECUTE                                                                on P_DPT_OB22      to ABS_ADMIN;
grant EXECUTE                                                                on P_DPT_OB22      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_DPT_OB22      to START1;
grant EXECUTE                                                                on P_DPT_OB22      to VKLAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DPT_OB22.sql =========*** End **
PROMPT ===================================================================================== 
