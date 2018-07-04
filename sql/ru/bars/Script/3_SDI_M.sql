declare   oo oper%rowtype;  ow operW%rowtype;  DAT9_ date;   qq oper%rowtype; 
  KOL_ INT;
begin 

/*
На примере Ив-ФР
23.06.2018 был переход на МСФЗ-9.
На несколько часов ранее ( это неважно) была выполнена администраторами АБС штатная функция по ЕЖЕДНЕВНОЙ амортизации дисконта 
Общая сумма = 28 262,08 грн ( по 135 аналитическим счетам 60**)

Эти проводки текущего дня НЕ были учтены в расформировании  на 5031*03, 
и потому первое формирование на 5031*03 
отталкивалось не от НУЛЯ (на этот момент был не 0, а минус небольшая сумма ) ,
а от этой небольшой  отрицательной суммы , которая была создана текущими проводками по амортизации.
( все эти проводки в файле)
Деб.60** 
Крд 5031*03 
С маркировкой конца  2017 года
*/
 ------------------------
  ow.tag  := 'DATN' ;
  ow.value:= '29.12.2017' ;
  ------------------------
  SELECT COUNT(*) INTO KOL_ FROM MV_KF WHERE KF <> '336503'; -- дЛЯ иф УЖЕ СДЕЛАНО !!!!
  iF KOL_ <> 1 THEN return; END IF ;
  ---------------------------------
  tuda ;

  ow.kf := gl.kf;
  begin
  select nls, substr(nms,1,38) into qq.nlsB, qq.nam_b  From accounts  where kv = gl.baseval and nls like '5031_03';
  select min(s.fdat) into DAT9_ from saldoa s, accounts a where a.nls like '5031_03' and a.kv = 980 and a.acc= s.acc 
            and s.fdat >= to_date('22-06-2018', 'dd-mm-yyyy');

  --------------------------------------------------------------------------------------------------------------
  For x in ( select d.ref, d.fdat, d.tt, d.kv, k.nls,  d.sq/100, d.nazn
             from opl d,  opl K 
             where d.tip = 'SDI' 
               and k.ref = d.ref 
               and k.stmt = d.stmt 
               and k.dk = 1 
               and d.dk = 0 
               and d.nazn not like '%МСФЗ_9%'
               and d.fdat = DAT9_
            )
  loop select * into oo from oper where ref = x.REF ;
       oo.tt   := '013' ;
       oo.kv   := 980 ;
       oo.s    := oo.s2 ; 
       oo.vob  := 96 ;
       oo.vdat := to_date ('27-06-2018', 'dd-mm-yyyy') ;
       oo.ND   := 'FRS9_ZO3' ;
       oo.DK   := 1 ;
       oo.Nazn := Substr ('R='|| oo.REF|| '*' || oo.nazn, 1, 160) ;
       oo.Ref  := null ;
       oo.nlsa := x.NLS;
       oo.nlsb := qq.nlsb;
       oo.nam_b := qq.nam_b;
       gl.ref (oo.REF)  ;
       gl.in_doc3 (ref_=>oo.REF, tt_=> oo.tt, vob_=> oo.vob, nd_ =>oo.nd , pdat_=>SYSDATE, vdat_ =>oo.vdat, 
                    dk_ => oo.dk, kv_=> 980, s_ => oo.S2, kv2_=>980, s2_ =>oo.S2, sk_=> null,data_=>gl.bdate,datp_=>gl.bdate,
                 nam_a_ => oo.nam_a, nlsa_ => oo.nlsA, mfoa_ => gl.aMfo,
                 nam_b_ => oo.Nam_B, nlsb_ => oo.nlsB, mfob_ => gl.aMfo,
                 nazn_ => oo.NAZN ,
                 d_rec_=> null, id_a_=> null, id_b_=>null, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null 
                   );
       ow.ref := oo.Ref ;
       insert into operw values ow;
       gl.payv(0, oo.REF, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsA, oo.s, oo.kv2, oo.nlsB, oo.s2);
       gl.pay (2, oo.ref, gl.bdate);  -- по факту
  end loop; --x
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;
  commit ;
end;
/

