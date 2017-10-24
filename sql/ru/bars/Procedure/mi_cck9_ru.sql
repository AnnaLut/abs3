

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MI_CCK9_RU.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MI_CCK9_RU ***

  CREATE OR REPLACE PROCEDURE BARS.MI_CCK9_RU ( p_Nd number) is
/*
08.12.2015 Sta Проводки по внебалансу - по ост по плановому
25.11.2015 Sta Закомм временно --------------- update cc_deal set wdate = gl.bdate where nd = p_nd; 
         ?? Не забыть убрать ????

19.11.2015 Sta    1) сворачивание 9 кл
           Luda   2 new) Расформирование резерва_23, который был создан ПОСЛЕ 01-11-2015, т.е. 01-12-2015 или еще позже
                  2-old) Расформирование резерва_23, который был создан ДО 01-12-2015(g_Dat) , т.е. 01-11-2015
*/

  oo oper%rowtype;
  nlsB8_ varchar2(15)  ; 

  g_Dat   date  := to_date ('01/12/2015','dd/mm/yyyy');
  l_dat01 date  := trunc(sysdate,'MM');
  l_dat31 date  ;
  l_rez   number:=0;
  TYPE CurTyp IS REF CURSOR;
  c0 CurTyp;

  TYPE r0Typ IS RECORD (
       S1       NUMBER,
       nms      accounts.nms%TYPE,
       kv       accounts.kv%TYPE,
       nls      accounts.nls%TYPE,
       branch   accounts.branch%TYPE,
       isp      accounts.isp%TYPE,
       nbs      accounts.nbs%TYPE,
       ob22     accounts.ob22%TYPE );
  xx r0Typ;

begin TUDA;
  nlsB8_ := vkrzn ( substr(gl.aMfo,1,5), '80060' )  ; 

  -- 1) сворачивание 9 кл
  oo.nlsb := BRANCH_USR.GET_BRANCH_PARAM2('NLS_9900',0);
  oo.ref  := null ;
  oo.tt   := '013';
  oo.nam_b:= 'Контр/рах 9900 позабаланс';
  oo.nd   := to_char(p_nd);
  oo.nazn := 'Міграція КД реф='|| p_nd;

  for k in (select * from V_ND_ACCOUNTS where (nbs like '9%'  or tip = 'SN8' and nls like '8008%' ) and nd = p_nd and ostB <> 0
            order by nls desc
           )
  loop
     If k.ostB >0 then oo.dk := 1 ; oo.s    :=   k.ostB ;  
     else              oo.dk := 0 ; oo.s    := - k.ostB ;  
     end if;
     oo.nam_a := substr(k.nms,1,38) ;
     oo.nlsa  := k.nls; 
     oo.kv    := k.kv ;

     If oo.ref is null then 
        gl.ref(oo.REF);   
        gl.in_doc3( ref_=>oo.REF  , tt_  =>oo.tt   , vob_  =>6       , nd_  =>oo.nd  , pdat_ =>SYSDATE, vdat_=>gl.bdate, 
                    dk_ =>oo.dk   , kv_  =>oo.kv   , s_    =>oo.s    , kv2_ =>oo.kv  , s2_   =>oo.s   , sk_  =>null    , 
                  data_ =>gl.BDATE, datp_=>gl.bdate, nam_a_=>oo.nam_a, nlsa_=>oo.nlsa, mfoa_ =>gl.aMfo, 
                  nam_b_=>oo.nam_b, nlsb_=>oo.nlsb , mfob_ =>gl.aMfo , nazn_=>oo.nazn,
                  d_rec_=>null    , id_a_=>gl.aOKPO, id_b_ =>gl.aOkpo, id_o_=>null, sign_ =>null, sos_ =>1, prty_=>null, uid_=> k.isp ) ;
        end if;

        If  oo.nlsa like '9%' then  gl.payv(0, oo.REF, gl.bDATE, oo.TT, oo.dk, oo.kv, oo.nlsa, oo.s , oo.kv, oo.nlsb, oo.S) ;
        else                        gl.payv(0, oo.REF, gl.bDATE, oo.TT, oo.dk, oo.kv, oo.nlsa, oo.s , oo.kv, nlsB8_, oo.S) ;
        end if;

  end loop;

--------------- update cc_deal set wdate = gl.bdate where nd = p_nd; 
  ------------------------------------------------------
  oo.nazn  := 'Розформування резерву в зв"язку з переносом кредиту';
  oo.tt    := 'ARE';
  oo.vob   := 6 ;
  oo.nd    := to_char(p_ND);
  oo.dk    := 1 ;
  oo.pdat  := SYSDATE ;
  oo.vdat  := gl.bdate;
  oo.datd  := gl.bdate; 
  oo.datp  := gl.bdate;
  oo.mfoa  := gl.aMfo ;
  oo.mfob  := gl.aMfo ;
  ---------------------  

  l_dat31  := Dat_last (l_dat01 -4 , l_dat01 -1 );  
  begin
     -- Проводки по резерву сделаны, надо сворачивать
     select 1 into l_rez from rez_protocol where dat= l_dat31 and crc='1' and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN  l_rez := 0; -- не надо сворачивать расчет резерва все урегулирует
  END;

  if l_rez = 1 THEN 

     if gl.bdate >= g_Dat then   
        -- 2 new) Расформирование резерва_23, который был создан ПОСЛЕ 01-11-2015, т.е. 01-12-2015 или еще позже
        OPEN c0 FOR
        select x.s1, a.nms, a.kv , a.nls, a.branch, a.isp, a.nbs, a.ob22 
        from  (select acc_rez acc,sum(rez_0) S1 from  nbu23_rez  where REZ_0 <>0 AND 
                      acc in (select N.acc from nd_acc  n where n.ND=p_Nd and fdat=l_dat01) group by ACC_rez UNION ALL
               select acc_rezn   ,sum(rezn)     from  nbu23_rez  where REZn  <>0 AND 
                      acc in (select N.acc from nd_acc  n where n.ND=p_Nd and fdat=l_dat01) group by acc_rezn UNION ALL
               select acc_rez_30 ,sum(rez_30)   from  nbu23_rez  where REZ_30<>0 AND 
                      acc in (select N.acc from nd_acc  n where n.ND=p_Nd and fdat=l_dat01) group by acc_rez_30) x, accounts a
        where x.acc=a.acc;

     else
        -- 2-old) Расформирование резерва_23, который был создан ДО 01-12-2015(g_Dat) , т.е. 01-11-2015
        OPEN c0 FOR
        select x.s1, a.nms, a.kv, a.nls, a.branch, a.isp, a.nbs, a.ob22
        from  (select acc_rez acc,sum(rez-rezn) S1 from nbu23_rez  where greatest(REZ-rezn,0) <>0 AND 
                      acc in (select N.acc from nd_acc  n where n.ND=p_Nd and fdat=l_dat01) group by ACC_rez UNION ALL
               select acc_rezn   ,sum(rezn)        from nbu23_rez  where REZn  <>0 AND 
                      acc in (select N.acc from nd_acc  n where n.ND=p_Nd and fdat=l_dat01) group by acc_rezn) x, accounts a
        where x.acc=a.acc;  
     end if;

     loop      FETCH c0 INTO xx ;      EXIT WHEN c0%NOTFOUND;

         -- A = 2401*
         oo.nam_a := substr(xx.nms,1,38) ; oo.nlsa := xx.nls ;  oo.kv := xx.kv ;  oo.kv2 := gl.baseVal; oo.userid := xx.isp ;
         oo.s     := xx.s1*100;  
         oo.s2    := gl.p_icurval (xx.kv, oo.s, l_dat31) ;
         -- B = 7700*
         begin
            select nls, substr(nms,1,38) into oo.nlsb, oo.nam_b  from accounts 
            where (nbs,ob22) = (select nbs_7r,ob22_7r from srezerv_ob22 s, accounts  
                                where nbs_rez=xx.nbs and ob22_rez = xx.ob22 and rownum=1 ) and branch=xx.branch and dazs is null;
            gl.REF (oo.ref);
            gl.in_doc3
                  ( ref_=>oo.REF  , tt_  =>oo.tt   , vob_  =>6       , nd_  =>oo.nd  , pdat_ =>SYSDATE, vdat_=>gl.bdate, 
                    dk_ =>oo.dk   , kv_  =>oo.kv   , s_    =>oo.s    , kv2_ =>oo.kv2 , s2_   =>oo.s2  , sk_  =>null    , 
                  data_ =>gl.BDATE, datp_=>gl.bdate, nam_a_=>oo.nam_a, nlsa_=>oo.nlsa, mfoa_ =>gl.aMfo, 
                  nam_b_=>oo.nam_b, nlsb_=>oo.nlsb , mfob_ =>gl.aMfo , nazn_=>oo.nazn,
                  d_rec_=>null    , id_a_=>gl.aOKPO, id_b_ =>gl.aOkpo, id_o_=>null, sign_ =>null, sos_ =>1, prty_=>null, uid_=> oo.userid ) ;
----------  INSERT INTO oper values oo;
----        paytt  (0, oo.ref, oo.vdat,oo.tt, oo.dk,oo.kv,oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.s2);
            gl.payv(0, oo.ref, oo.vdat,oo.tt, oo.dk,oo.kv,oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.s2);
         EXCEPTION WHEN NO_DATA_FOUND THEN  null;
         end;
     end loop;
  end if;

  update  nbu23_rez z 
     set dat_mi = gl.bdate
  where z.fdat = l_dat01 and  z.acc in (select acc from nd_acc where nd = p_ND) ;

----------------------

end mi_CCK9_RU;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MI_CCK9_RU.sql =========*** End **
PROMPT ===================================================================================== 
