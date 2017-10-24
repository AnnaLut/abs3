create or replace procedure p_interest_cck1( p_type    in number default 0,  p_date_to in date)  is

/*  25.01.2017 Sta Разные начисления в КП ФЛ и ЮЛ

        ЮЛ   ФЛ
  p_type = 1 , 11 НА ВИМОГУ - по ВСІМ - Щомiсячне Нар. %%  та комісії
  p_type = 2 , 12 НА ВИМОГУ - з залишками на SG
  p_type = 3 , 13 ЩОДЕННЕ   - по пл. датах 
  p_type = 4 , 14 ЩОДЕННЕ   - по прострочених дог. 

  p_type < 0 НА ВИМОГУ - по 1 КД 
*/
   nInt_ number;
   dDat2_ date ;  -- пл.дата из ГПК -1 или заданная дата  = ПО 
   D_PREV date ;  -- пред.банк-да та
   D_NEXT date ;  -- след.банк-дата
   l_Nazn varchar2(160)  ;
   dd cc_deal%rowtype    ; 
   k1 sys_refcursor      ;   
   l_mode int := 1;
begin
   If p_type >= 0 and p_type not in (1, 2, 3, 4, 11, 12, 13, 14 ) then RETURN; end if;

   dDat2_ := nvl( p_date_to, gl.BDATE);   
   D_PREV := Dat_Next_U (dDat2_, -1 )   ;
   D_NEXT := dDat2_ + 1  ;

   If    p_type < 0  then -- НА ВИМОГУ- по 1 КД 
         open k1 for select nd, cc_id, sdate, wdate  from cc_deal d 
                     where nd = (- p_type) and sos >= 10 and sos< 14 and vidd in (1,2,3,11,12,13) ;

   ElsIf p_type in (1, 11)  then -- НА ВИМОГУ- по ВСІМ   
         open k1 for select nd, cc_id, sdate, wdate  from cc_deal d 
                     where sos >= 10 and sos< 14 
                       and ( p_type = 1 and vidd in ( 1, 2, 3) OR p_type = 11 and vidd in (11,12,13) ) ;


   ElsIf p_type in ( 2, 12 )  then -- НА ВИМОГУ- з залишками на SG
         open k1 for select nd, cc_id, sdate, wdate from cc_deal d 
                     where sos >= 10 and sos< 14 
                       and ( p_type = 2 and vidd in ( 1, 2, 3) OR p_type = 12 and vidd in (11,12,13) )
                        and exists (select 1 from accounts a, nd_acc n where a.ostc>0 and a.tip = 'SG ' and a.acc= n.acc and n.nd = d.nd ) ;

   ElsIf p_type in ( 3, 13 )  then -- ЩОДЕННЕ   - по пл. датах 
         open k1 for select nd, cc_id, sdate, wdate from cc_deal d 
                     where sos >= 10 and sos< 14 
                       and ( p_type = 3 and vidd in ( 1, 2, 3) OR p_type = 13 and vidd in (11,12,13) )
                       and exists (select 1 from cc_lim where nd = d.ND and fdat > D_PREV and fdat < D_NEXT ) ;

   ElsIf p_type in( 4, 14 )  then -- ЩОДЕННЕ  - по прострочених дог. 
         open k1 for select nd, cc_id, sdate, wdate from cc_deal d 
                     where sos = 13 and d.wdate < dDat2_  
                       and ( p_type = 4 and vidd in ( 1, 2, 3) OR p_type = 14 and vidd in (11,12,13) ) ;

   end if;

   if not k1%isopen then return ; end if ;

   loop fetch k1 into dd.nd, dd.cc_id, dd.sdate, dd.wdate ; exit when k1%notfound ;
   --------------------------------------------

      If p_type = 3 then  select max(fdat) - 1  into dDat2_ from cc_lim where nd= DD.ND and fdat > D_PREV and fdat < D_NEXT ; end if ;

      for p in (select a.nls, a.accc, a.acc, a.tip, i.basem, i.basey,  greatest (nvl( i.acr_dat, a.daos-1 ), dd.SDATE-1) + 1 dDat1, i.metr, i.id 
                from accounts a, int_accn i, nd_acc n
                where  n.nd  = DD.ND  and  n.acc = a.acc   and  a.tip in ('SS ','SP ', 'LIM', 'SPN','SK9')  and  a.acc = i.acc
                  and  i.id  IN (0,2) AND I.ACRA IS NOT NULL AND I.ACRB IS NOT NULL  and  i.acr_dat < dDat2_      )
      loop  delete from acr_intn;         l_Nazn := null ;

         If p.Tip    in   ('SS ' ) and p.accc is not null and p.BASEY = 2 and p.BASEM = 1 and p.id = 0   then  
            CCK.INT_METR_A(p.Accc, p.Acc, p.id, p.dDat1, dDat2_, nInt_, Null, l_mode ) ;    ------ начисление по ануитету

         ElsIf p.Tip in   ('SS ', 'SP ')  and p.accc is not null and p.id = 0                            then  
            acrn.p_int    (        p.Acc, p.id, p.dDat1, dDat2_, nInt_, Null, l_mode ) ;    ------ начисление банковское
     
         ElsIf p.Tip in   ('SP ', 'SPN','SK9')  and p.id = 2                                             then  
            acrn.p_int    (        p.Acc, p.id, p.dDat1, dDat2_, nInt_, Null, l_mode ) ;    ------ начисление пени

            l_Nazn := Substr( 'Нарахування пені. КД № ' || dd.cc_id                       || 
                                               ' від  ' || to_char(dd.sdate,'dd.mm.yyyy') || 
                                               ', рах.' || p.nls                          || 
                                         '. Період: з ' || to_char(p.dDat1,'dd.mm.yyyy')  ||
                                                 ' по ' || to_char( dDat2_,'dd.mm.yyyy')   , 1,160) ;

         ElsIf p.METR > 90 and p.Id = 2 and  p.TIP ='LIM'                                                then                      
            CC_KOMISSIA   (p.METR, p.Acc, p.Id, p.dDat1, dDat2_, nInt_, Null, l_mode)  ;   -------- Начисление комиссий 

            l_Nazn := Substr( 'Нарахування комісії. КД № ' || dd.cc_id                       || 
                                                  ' від  ' || to_char(dd.sdate,'dd.mm.yyyy') || 
                                            '. Період: з ' || to_char(p.dDat1,'dd.mm.yyyy')  ||
                                                    ' по ' || to_char( dDat2_,'dd.mm.yyyy')  , 1,160) ;
         end if;

         interest_utl.take_reckoning_data( p_base_year => p.basey,
                                           p_purpose   => l_Nazn,
                                           p_deal_id   => dd.ND ) ;
         ------------------
      end loop ; -- p
  end loop ; --k1
  close k1 ;

end p_interest_cck1;
/
