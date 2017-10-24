

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KRYM_SEP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KRYM_SEP ***

  CREATE OR REPLACE PROCEDURE BARS.P_KRYM_SEP ( p_mode int, p_ref number, p_nls37 varchar2, p_kv number ) is

  a37 accounts%rowtype;
  oo  oper%rowtype;
  i int;  j int; tmp_  VARCHAR2(230); tag_ VARCHAR2(10);  val_ VARCHAR2(250);  sim_ VARCHAR2(1);

/*
select * from arc_rrp where ref in (185952367); -- yes BIS
select * from arc_rrp where ref in (187857836); -- not BIS
insert into nlk_ref( ref1, acc) values( 185952367, 677);
insert into nlk_ref( ref1, acc) values( 187857836, 677);
*/
begin
  begin
    select * into a37 from accounts where kv = p_kv and nls = p_nls37 and ostc > 0 and ostb > 0;
  EXCEPTION when NO_DATA_FOUND THEN raise_application_error(-20000,'Не знайдено рах (3739)='|| p_nls37);
  end;

  for k in (select * from nlk_ref where acc = a37.acc and ref2 is null and nvl(p_Ref,0)  in (0, ref1) )
  loop
     select * into oo from oper where ref = k.ref1;
     oo.ref  := null     ;
     oo.tt   := 'PS2';
     oo.nazn := substr(oo.mfoa||'/'||oo.nlsa||';'||oo.nazn,1,160);
     oo.nlsa := a37.nls  ;
     oo.mfoa := gl.aMfo  ;
     gl.ref (oo.REF)     ;
     gl.in_doc3(ref_  => oo.ref , tt_   => oo.tt  , vob_   => oo.vob  , nd_   => oo.nd   , pdat_ => SYSDATE, vdat_ => gl.bdate ,
                dk_   => oo.dk  , kv_   => oo.kv  , s_     => oo.S    , kv2_  => oo.kv2  , s2_   => oo.S2  , sk_   => oo.sk    ,
                data_ => gl.bdate, datp_ => oo.datp, nam_a_ => oo.nam_a, nlsa_ => oo.nlsa , mfoa_ => oo.mfoa, nam_b_=> oo.nam_b ,
                nlsb_ => oo.nlsb, mfob_ => oo.mfob, nazn_  => oo.nazn , d_rec_=> oo.d_rec, id_a_ => oo.id_a, id_b_ => oo.id_b  ,
                id_o_ => null   , sign_ => null   , sos_   => 1       ,  prty_ => null   , uid_  => null   );
     paytt ( 0, oo.ref, gl.bdate, oo.tt, oo.dk, oo.kv, oo.nlsa,oo.s,oo.kv, oo.NLSb, oo.s);
     --BIS
     FOR c IN ( SELECT nazn, d_rec, bis FROM arc_rrp  WHERE ref = k.ref1 and bis>1 )
     LOOP
        tmp_ := trim(c.nazn||c.d_rec);
        i    := GREATEST( INSTR(tmp_,'#F'), INSTR(tmp_,'#C'), INSTR(tmp_,'#П') );
        WHILE i > 0
        LOOP -- обработка подряд идущих #F<TAG>:<VAL>#F<TAG>:<VAL>#
            sim_ := SUBSTR(tmp_,i+1,1);
            tmp_ := SUBSTR(tmp_,i+2  );
            i    := INSTR(tmp_,'#');
            IF i > 0 THEN
               IF sim_='F' THEN j :=INSTR(tmp_,':'); val_:=TRIM(SUBSTR(tmp_, j+1, i-j-1 )); tag_:=TRIM(SUBSTR ( tmp_, 1 , j-1 ));
               ELSE                                  val_:=TRIM(SUBSTR(tmp_, 1  , i-1   )); tag_:=sim_||TO_CHAR(c.bis-1);
               END IF;
               UPDATE operw SET value=value||CHR(13)||CHR(10)||val_ WHERE ref=oo.ref AND TRIM(tag)=tag_;
               IF SQL%ROWCOUNT=0 THEN   INSERT INTO operw(ref,tag,value) VALUES ( oo.ref , tag_, val_ );  END IF;
            END IF;
            i := GREATEST(INSTR(tmp_,'#F'),INSTR(tmp_,'#C'),INSTR(tmp_,'#П'));
        END LOOP;   -- WHILE i>0 LOOP
     END LOOP; -- SELECT

     update nlk_ref set ref2 = oo.ref where ref1 = k.ref1 and acc= a37.acc;
     INSERT INTO operw(ref,tag,value) VALUES (oo.ref,'REF92', to_char(k.ref1) );
--     INSERT INTO operw(ref,tag,value) VALUES (k.ref1,'REFT' , to_char(oo.ref) );

  end loop;

end p_krym_sep;
/
show err;

PROMPT *** Create  grants  P_KRYM_SEP ***
grant EXECUTE                                                                on P_KRYM_SEP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KRYM_SEP      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KRYM_SEP.sql =========*** End **
PROMPT ===================================================================================== 
