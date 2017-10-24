
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_op_bal.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OP_BAL (ref_ IN NUMBER, stmt_ IN NUMBER)
RETURN NUMBER IS
 bal_   NUMBER;  -- признак балансовой проводки (1 - бал, 8 - безбал)
 accd_  NUMBER;  -- асс ƒт-счета
 nbsd_  CHAR(4); -- бал.счет ƒт-счета
 acccd_ NUMBER;  -- консолид.счет дл€ ƒт-счета
 nbsdd_ CHAR(4); -- бал.счет консолид.счета дл€ ƒт-счета
 fdat_  date;
 tt_  char(3);
 ern  CONSTANT POSITIVE := 208;
 err  EXCEPTION;
 erm  VARCHAR2(80);
 -- ‘”Ќ ÷»я ƒЋя ќƒЌќ«Ќј„Ќќ√ќ ќѕ–≈ƒ≈Ћ≈Ќ»я "ЅјЋјЌ—ќ¬ќ—“»" ѕ–ќ¬ќƒ »
 -- используетс€ в своде документов дн€
BEGIN
  IF f_ourmfo = '322498' AND ref_ = 433834 THEN RETURN 8; END IF;
-- »сключаем операции по нал учету, была проблема tt='PO3' и STMT=0
  Begin
    select distinct tt into tt_ from opldok where ref=ref_ and stmt=stmt_;
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 8;
 end;
	if tt_='PO3' then RETURN 8; end if;
  BEGIN
	SELECT d.acc, nvl(d.nbs,'8888'), d.accc, nvl(dd.nbs,'8888'),o.fdat,o.tt
	  INTO accd_, nbsd_, acccd_, nbsdd_ ,fdat_,tt_
	  FROM opldok o, accounts d, accounts dd
     WHERE o.ref=ref_  AND o.stmt=stmt_ AND
	       o.acc=d.acc AND o.dk=0       AND
		   d.accc=dd.acc(+);
    EXCEPTION WHEN NO_DATA_FOUND THEN bal_:=8;
  END;
    -- 1. ƒт-счет - балансовый
  IF substr(nbsd_,1,1) NOT IN ('0','8') THEN
        bal_:=1;
  -- 2. ƒт-счет - внебалансовый, но у него есть родитель и он балансовый
  ELSIF
      substr(nbsd_,1,1) IN ('0','8')
              AND substr(nbsdd_,1,1) NOT IN ('0','8')
      THEN
        -- частный случай ƒемарка (нештатный режим)
           IF f_ourmfo = '353575'
              and fdat_=to_date('05-12-2005','dd-mm-yyyy')
              and tt_='003' THEN bal_:='8';
           ELSE  bal_:=1;   end if;
  -- 3. ƒт-счет - внебалансовый, и у него нет родител€ или есть, но внебалансовый
  ELSE
     -- Ќаходим контрсчет ( т-счет)
     BEGIN
	   SELECT 8 INTO bal_
	     FROM opldok o, accounts k, accounts kk
        WHERE o.ref=ref_  AND o.stmt=stmt_ AND o.acc=k.acc AND
		      o.dk=1      AND k.accc=kk.acc(+)             AND
			  substr(nvl(k.nbs,'8888'),1,1)  IN ('0','8')  AND
			  substr(nvl(kk.nbs,'8888'),1,1) IN ('0','8');
     EXCEPTION WHEN NO_DATA_FOUND THEN
  	   erm := '9313 - No balance! '||ref_||' '||stmt_;
       RAISE err;
     END;
  END IF;
  RETURN bal_;
EXCEPTION    WHEN err THEN
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
--   WHEN OTHERS THEN
--        raise_application_error(-(20000+ern),SQLERRM,TRUE);
END f_op_bal;
 
/
 show err;
 
PROMPT *** Create  grants  F_OP_BAL ***
grant EXECUTE                                                                on F_OP_BAL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OP_BAL        to RPBN001;
grant EXECUTE                                                                on F_OP_BAL        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_op_bal.sql =========*** End *** =
 PROMPT ===================================================================================== 
 