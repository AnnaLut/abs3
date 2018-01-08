CREATE OR REPLACE PROCEDURE BARS.cp_ucenka ( p_dat01 date ) IS 

/*   Списание с капитала уценки по ЦБ, если есть резерв
     -----------------------------------------
     Версия 1.0   19-06-2017
*/

l_rnk  accounts.rnk%type;  oo         oper%rowtype;
l_dat  date             ;  dat31_     date        ;
l_pay  NUMBER           ;  l_rez_pay  NUMBER      ;

begin
   dat31_ := Dat_last_work(p_dat01 - 1);
   l_rez_pay   := nvl(F_Get_Params('REZ_PAY', 0) ,0); -- Формирование  резерва по факту (1 - ФАКТ)
   if l_rez_pay = 1 THEN  l_pay := 1;   else  l_pay := 0;  end if;

   for p in ( select nd,nvl(sum(rezb),0) from prvn_osaq    
              where  tip = 9 and  rezb <> 0 and  
                     nd in (select nd from nbu23_rez 
                            where fdat = p_dat01 and nbs in ('1405','1415','1435','3007','3015','3107','3115') and bv < 0)
              group by nd
             ) 
   Loop

      begin
         oo.tt := '096';
         l_dat := gl.bdate;
         z23.to_log_rez (user_id , -30 , p_dat01 ,'Начало Врегулюв.переоц.в зв`язку з форм.рез.');
         for k in (select a.* from accounts a,nbu23_rez n
                   where  substr(a.nls,1,4) in ('1405','1415','1435','3007','3015','3107','3115') and a.ostc > 0 and a.ostc=a.ostb and
                          a.nbs is null and n.fdat = p_dat01 and a.acc=n.acc and n.nd =p.nd
                   )
         LOOP
            begin
               select nls_fxp into oo.nlsb from cp_aCCC
               where  ryn  = (select ryn   from cp_deal  where accs = k.acc ) and
                      nlss = (select nls   from accounts where acc  = k.accc);
            EXCEPTION WHEN NO_DATA_FOUND THEN
               raise_application_error(-20012,'Не знайден рахунок результату переоцiнки 5102');
            end;

            begin
               select substr(trim(nms),1,38),rnk into oo.nam_b,l_rnk from accounts
               where  nls = oo.nlsb and kv = k.kv;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               raise_application_error(-20012,'Не знайден рахунок результату переоцiнки 5102');
            end;
            begin
               select okpo into oo.id_a  from customer where RNK = k.rnk;
            EXCEPTION WHEN NO_DATA_FOUND THEN oo.id_a := gl.aOkpo;
            end;
            begin
               select okpo into oo.id_b  from customer where RNK = l_rnk;
            EXCEPTION WHEN NO_DATA_FOUND THEN oo.id_b := gl.aOkpo;
            end;
            oo.nazn  := 'Врегулювання переоцінки в зв`язку з формуванням резерву на '||p_dat01||' р.';
            oo.nam_a := substr(trim(k.nms),1,38);
            gl.ref(oo.REF);
            gl.in_doc3( ref_  => oo.REF , tt_   => oo.tt  , vob_  => 96      , nd_   => oo.ref , pdat_ => SYSDATE, vdat_ => dat31_  ,
                        dk_   => 1      , kv_   => k.kv   , s_    => k.ostc  , kv2_  => k.kv   , s2_   => k.ostc , sk_   => null    ,
                        data_ => l_DAT  , datp_ => l_DAT  , nam_a_=> oo.nam_a, nlsa_ => k.nls  , mfoa_ => gl.aMfo, nam_b_=> oo.nam_b,
                        nlsb_ => oo.nlsb, mfob_ => gl.aMfo, nazn_ => oo.nazn , d_rec_=> null   , id_a_ => oo.id_a, id_b_ => oo.id_b ,
                        id_o_ => oo.id_o, sign_ => null   , sos_  => 1       , prty_ => null   , uid_  => nULL   );

            gl.payv(l_pay, oo.REF, dat31_, oo.TT, 1, k.kv, k.nls, k.ostc, k.kv, oo.nlsb, k.ostc) ;
         END LOOP;
         z23.to_log_rez (user_id , -30 , p_dat01 ,'Конец Врегулюв.переоц.в зв`язку з форм.рез.');
      end;
   end loop;
end;
/
show err;

grant EXECUTE  on cp_ucenka to BARS_ACCESS_DEFROLE;
grant EXECUTE  on cp_ucenka to RCC_DEAL;
grant EXECUTE  on cp_ucenka to START1;
