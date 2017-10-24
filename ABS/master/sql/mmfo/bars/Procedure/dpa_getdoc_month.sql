

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPA_GETDOC_MONTH.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPA_GETDOC_MONTH ***

  CREATE OR REPLACE PROCEDURE BARS.DPA_GETDOC_MONTH ( dat_ DATE )
IS

	dat1_	DATE;
	dat2_	DATE;

BEGIN

	DELETE FROM DPA_SPY_TEMP;

	dat1_ := TRUNC(TRUNC( dat_, 'MM') - 1, 'MM');
	dat2_ := TRUNC( dat_, 'MM') - 1;

	INSERT INTO DPA_SPY_TEMP (REF,TT,ACCA,S,KV,SK,DK,ACCB,FDAT)
	SELECT o1.ref, o1.tt, o1.acc, o1.s, p.kv, p.sk, 0, o2.acc, o1.fdat
    FROM opldok o1, opldok o2, oper p
    WHERE o1.dk=0 and o2.ref=o1.ref and o2.tt=o1.tt and o2.fdat=o1.fdat and o2.s=o1.s and o2.dk=1 and
          p.ref=o1.ref and
          o1.fdat BETWEEN dat1_ and dat2_ and
          o1.acc in
			(SELECT c.acc FROM accounts a, cust_acc c, list_dpa x
			 WHERE c.rnk=x.rnk and a.acc=c.acc and a.nbs='2600');

	INSERT INTO DPA_SPY_TEMP (REF,TT,ACCA,S,KV,SK,DK,ACCB,FDAT)
	SELECT o1.ref, o1.tt, o1.acc, o1.s, p.kv, p.sk, 1, o2.acc, o1.fdat
    FROM opldok o1, opldok o2, oper p
    WHERE o1.dk=1 and o2.ref=o1.ref and o2.tt=o1.tt and o2.fdat=o1.fdat and o2.s=o1.s and o2.dk=0 and
          p.ref=o1.ref and
          o1.fdat BETWEEN dat1_ and dat2_ and
          o1.acc in
			(SELECT c.acc FROM accounts a, cust_acc c, list_dpa x
			 WHERE c.rnk=x.rnk and a.acc=c.acc and a.nbs='2600');

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPA_GETDOC_MONTH.sql =========*** 
PROMPT ===================================================================================== 
