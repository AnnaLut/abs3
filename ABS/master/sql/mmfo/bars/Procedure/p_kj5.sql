

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KJ5.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KJ5 ***

  CREATE OR REPLACE PROCEDURE BARS.P_KJ5 (id_ SMALLINT, sdat_ varchar2, sdat2_ varchar2 ) IS
acc_ int;    kv_ int;    kas_  varchar2(58);
ref_ INT;    dk_ int;    nd_   varchar2(10);
s_   int;    s1_ int;      nls_  varchar2(15);
dat_ date;  dat2_ date;  fdat_ date;  ud_ int; sk2_ int;
stmt_ number;
t_sk int; sk7_ int;
tt_ char(3);   -- з OPLDOK
o_tt char(3);  -- з OPER
sk_k int; sk_d int;
 sk_ int ;  sk5_ int;
--ern  CONSTANT POSITIVE       := 123 ;
 sErr_ varchar2(150);
 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);


--------  *** Верс_я 24/06-05 ***

CURSOR a0 IS
  SELECT acc,kv,substr(nls||' '||nms,1,58) FROM accounts WHERE tip='KAS';

CURSOR O1 IS
SELECT p.fdat, p.s, o.userid, p.ref, p.dk, o.nd,
       decode(p.tt,o.tt,o.sk,NULL), t.sk, p.tt, o.tt, p.STMT
FROM OPER O, OPLDOK P, tts t
WHERE  p.acc=acc_ AND p.fdat BETWEEN dat_ AND dat2_ AND
       p.sos=5 AND t.tt=p.tt AND o.ref=p.ref ;

CURSOR O2 IS
SELECT a.nls
FROM accounts a, opldok o
where a.acc=o.acc and o.ref=ref_ and o.dk=1-dk_ and o.stmt=stmt_;

BEGIN
 dat_:=to_date(sdat_,'mm-dd-yyyy');
 dat2_:=to_date(sdat2_,'mm-dd-yyyy');
 delete from tmp_kj where id=id_;

 OPEN a0; LOOP FETCH a0 INTO acc_,kv_,kas_;            EXIT WHEN a0%NOTFOUND;
 OPEN O1; LOOP FETCH O1 INTO fdat_, s_, ud_, ref_, dk_, nd_,
                             sk_, t_sk, tt_, o_tt, stmt_;
       EXIT WHEN O1%NOTFOUND;
                deb.trace( ern,'','tt_='|| tt_||o_tt||' '||ref_);
      sk7_:=NULL;
   if tt_ = o_tt then        -- основна операц_я
      if sk_ is not NULL then
         if (dk_ = 0 and sk_ < 40) then sk7_:=sk_;
         elsif (dk_ = 1 and sk_ > 39)  then sk7_:=sk_;
         else  sk7_:=0;
         end if;
      end if;
      -- все одно пр_оритет додрекв_зит_в SK_P, SK_V
           begin
                 select to_number(substr(value,1,2)) into sk5_
                 from operw
                 where ref=ref_
                       and tag=DECODE(dk_,0,'SK_P ','SK_V ');
                 exception when others then sk5_:=0;
           end;
           if sk5_ is not NULL and sk5_<>0
              then sk7_:=sk5_;
           else NULL;
           end if;
           ---  а може _снує додрекв_зит SK_A
           if sk7_ is NULL or sk7_= 0 then
              begin
              select to_number(substr(value,1,2)) into sk5_
              from operw
              where ref=ref_ and tag='SK_A';
              exception when others then sk5_:=NULL;
              end;

              if (dk_ = 0 and sk5_ < 40) then sk7_:=sk5_;
              elsif (dk_ = 1 and sk5_ > 39)  then sk7_:=sk5_;
              else sk7_:=NULL;
              end if;
           end if;
---
   else                          -- зв'язана операц_я
        sk7_:=t_sk;              -- ! пр_оритет СКП з карточки зв-ої операц_ї?
             deb.trace( ern,'','sk7_='|| sk7_||' ref '||ref_);
        if sk7_ is NULL then
           begin
           select to_number(substr(value,1,2)) into sk7_
           from operw
           where ref=ref_ and tag='SK';
           exception when others then sk7_:=0;
           end;
        end if;
   end if;
   sk_:=sk7_;
   if sk7_ is NULL then sk_:=0; end if;
       deb.trace( ern,'','sk_='|| sk_||' ref  '||ref_||' acc '||acc_);

 OPEN O2;  LOOP FETCH O2 INTO nls_;        EXIT WHEN O2%NOTFOUND;
 INSERT INTO tmp_kj (ud,acc,id, dk, kas, nd, nls, s, sk, ref, fdat,tt) VALUES
                    (ud_,acc_,id_,dk_,kas_,nd_,nls_,s_,sk_,ref_,fdat_,tt_);
 END LOOP; CLOSE O2;
 END LOOP; CLOSE O1;
 END LOOP; CLOSE a0;
 commit;
END p_kj5;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KJ5.sql =========*** End *** ===
PROMPT ===================================================================================== 
