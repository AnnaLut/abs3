

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KJZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KJZ ***

  CREATE OR REPLACE PROCEDURE BARS.P_KJZ (ID_ SMALLINT, sdat_ Date) IS
acc_ int;    kv_ int;    kas_  varchar2(15);
ref_ INT;    dk_ int;    nd_   varchar2(10);  tt_ char(3);  sk_ int ;
s_   int;    s1_ int;      nls_  varchar2(15); pdat_ date;
dat_ date;  dat2_ date;  fdat_ date;  ud_ int; sk2_ int; stmt_ number;
ern  CONSTANT POSITIVE       := 123 ;
CURSOR a0 IS
  SELECT acc,kv,nls FROM accounts WHERE tip='KAS';

CURSOR O1 IS
SELECT p.fdat,p.s,o.userid,p.ref,p.dk,o.nd,decode(p.tt,o.tt,o.sk,t.sk),p.tt,o.PDAT,p.stmt
FROM OPER O, OPLDOK P, tts t
WHERE
    p.acc=acc_ AND p.fdat=dat_  AND
    p.sos=5 AND t.tt=p.tt AND o.ref=p.ref ;

CURSOR O2 IS
SELECT nls  FROM opl WHERE
    substr(nls,1,1) not in ('8','9') and
    ref=ref_ and tt=tt_ AND dk=1-DK_ AND fdat=fdat_ and sos=5 AND kv=kv_ AND
    s =(select max(s) from opl where
        ref=ref_ and tt=tt_ AND dk=1-DK_ AND fdat=fdat_ and sos=5 AND kv=kv_ )
		and stmt=stmt_;
BEGIN
-- dat_:=to_date(sdat_,'mm-dd-yyyy');
 dat_:=sdat_;
--- dat2_:=to_date(sdat2_,'mm-dd-yyyy');
 delete from tmp_kjz2 where id=id_;
 OPEN a0; LOOP FETCH a0 INTO acc_,kv_,kas_;            EXIT WHEN a0%NOTFOUND;
 OPEN O1; LOOP FETCH O1 INTO fdat_,s_,ud_,ref_,dk_,nd_,sk_,tt_,pdat_,stmt_;
       EXIT WHEN O1%NOTFOUND;

---  if sk_ is not null then
---     begin
---        select to_number(substr(value,1,2)) into sk2_
---        from operw where ref=ref_ and tag='SK';
---        exception when no_data_found then
---        sk2_:= NULL;
---     end;
---     if sk2_ is not null then
---        sk_:=sk2_ ;
---     end if;
---  end if;

  if sk_ is null then
     begin
        select to_number(substr(value,1,2)) into sk_
        from operw where ref=ref_ and tag='SK';
        exception when others then sk_:=0;
     end;
  end if;


 OPEN O2; LOOP FETCH O2 INTO nls_;                  EXIT WHEN O2%NOTFOUND;
 INSERT INTO tmp_kjz2 (ud,acc,id, dk, kas, nd, nls, s, sk, ref, fdat,tt,pdat) VALUES
                    (ud_,acc_,id_,dk_,kas_,nd_,nls_,s_,sk_,ref_,fdat_,tt_,trunc(pdat_));
 END LOOP;CLOSE O2;  END LOOP;CLOSE O1; END LOOP;CLOSE a0;
 commit;
END p_kjz;
/
show err;

PROMPT *** Create  grants  P_KJZ ***
grant EXECUTE                                                                on P_KJZ           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KJZ           to RPBN001;
grant EXECUTE                                                                on P_KJZ           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KJZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
