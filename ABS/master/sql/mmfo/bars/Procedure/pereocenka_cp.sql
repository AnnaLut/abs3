PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/pereocenka_cp.sql ========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure pereocenka_cp ***

CREATE OR REPLACE PROCEDURE BARS.pereocenka_cp (p_dat01 date, p_mode number)  is
/*  pmode = 0 - рассформирование
            1 - формирование
    ----------------------------
   Версия 1.0   11-02-2019
   Дооцінка ЦП на суму сформованого резерву
   -------------------------------------
01) 11-02-2019(1.0) -  Операція - RXP
*/ 

l_nbs    accounts.nbs%type;
l_nms    accounts.nms%type;
l_rnk    accounts.rnk%type;
l_acc    accounts.acc%type;
l_nls    accounts.nls%type;
l_accc   accounts.accc%type;
l_grp    accounts.grp%type;
l_mdate  accounts.mdate%type;
l_tip    accounts.tip%type;
l_ost    number;
l_r1     int              ;
oo       oper%rowtype;
sdat01_  char(10);
l_sErr   VARCHAR2 (200);
l_kf     VARCHAR2 (20);
dat_v    date;
l_dazs   date;

TYPE CurTyp IS REF CURSOR;
  c0 CurTyp;

TYPE r0Typ IS RECORD (
     nd       number,
     kv       accounts.kv%TYPE,
     nb       char(3),
     ost      number,
     acc      number,
     nls      accounts.nls%type 
    );
  k r0Typ;

begin
   l_kf:=sys_context('bars_context','user_mfo');
   bc.go('/300465/000010/');   
   sdat01_ := to_char( p_DAT01,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');
   oo.vdat := Dat_last_work (p_dat01 -1 );
   if p_mode = 1 THEN  dat_v := Dat_last_work (p_dat01 -1 );
   else                dat_v := Dat_last_work (add_months( p_dat01, -1 ) -1 );
   end if;
   --oo.nlsb := '5102431141187';
   oo.nlsb := '510281218';
   begin
      select okpo into oo.id_b from  customer  where rnk in (select rnk from accounts where nls=oo.nlsb and kv=980);
   EXCEPTION  WHEN NO_DATA_FOUND  THEN  oo.id_a:=null;
   end;

   if p_mode = 1 THEN 

      OPEN c0 FOR  select nd, kv, substr(nbs,1,3) nb, sum(rez)*100 ost, null acc, null nls from nbu23_rez 
                   where fdat=p_dat01 and rez<>0 and nbs in ('1410','1411','1412','1413','1414','1415','1416','1418',
                                                             '3110','3111','3112','3113','3114','3115','3116','3118') 
                   group by nd, kv, substr(nbs,1,3); 
   else 
      OPEN c0 FOR  select null nd, kv, substr(nls,1,3) nb, nvl(ost_korr(a.acc,oo.vdat,null,'1415'),0) ost, acc, nls  from accounts a where tip ='SR';
   end if;

   LOOP
   FETCH c0 INTO k;
   EXIT WHEN c0%NOTFOUND;
      l_acc := k.acc; 
      l_nls := k.nls; 
      if p_mode = 1 THEN 
         -- есть ли счет переоценки за счет резерва 
         begin 
            --logger.info('PEREOC 1 : nd = ' || k.nd || ' kv ='  ||k.kv || ' rez =' ||k.rez  || ' nb =' ||k.nb) ;
            select a.nls, a.acc, substr(a.nms,1,38), ost_korr(a.acc,oo.vdat,null,'1415'), dazs, tip into l_nls, l_acc, oo.nam_a, l_ost, l_dazs, l_tip 
            from cp_accounts c, accounts a where c.cp_ref = k.nd AND c.cp_acctype='SR' and c.cp_acc=a.acc;
            if l_tip<>'SR' THEN
               UPDATE accounts SET tip = 'SR', pap=1  WHERE acc = l_acc;
            end if;
            if l_dazs is not null THEN
               UPDATE accounts SET dazs = null WHERE acc = l_acc;
            end if;
         EXCEPTION  WHEN NO_DATA_FOUND  THEN  
            l_ost := 0;
            l_nbs := k.nb||'5';
            -- Наименование , РНК, дата окончания из счета номинала или др. любого счета
            begin
               --logger.info('PEREOC 2 : nd = ' || k.nd ) ;            
               select substr(a.nms,1,38), a.rnk, a.mdate into oo.nam_a, l_rnk, l_mdate from cp_accounts c, accounts a where c.cp_ref = k.nd and c.cp_acctype='N' and c.cp_acc = a.acc;
            EXCEPTION  WHEN NO_DATA_FOUND  THEN                                                                       
               begin
                  --logger.info('PEREOC 3 : nd = ' || k.nd ) ;
                  select substr(a.nms,1,38), a.rnk, a.mdate into oo.nam_a, l_rnk, l_mdate from cp_accounts c, accounts a where c.cp_ref = k.nd and rownum=1 and c.cp_acc = a.acc;
               EXCEPTION  WHEN NO_DATA_FOUND  THEN   NULL;                                                                      
               end;
            end; 
            -- Консолидированный счет
            begin 
               --logger.info('PEREOC 4 : nd = ' || k.nd ) ;
               select a.acc into l_accc from cp_deal d, cp_accc c, accounts a where ref = k.nd and d.ryn = c.ryn and c.nlss = a.nls and kv = k.kv and substr(vidd,1,3)=k.nb;
            EXCEPTION  WHEN NO_DATA_FOUND  THEN  
               -- logger.info('PEREOC 5 : nd = ' || k.nd ) ;
               l_sErr := l_sErr  || 'НЕ знайдено в CP_ACCC ref=' || k.nd || ' нет материнского счета';
               raise_application_error(  -20203,l_sErr, TRUE);
            end;      
   
            l_nls := l_nbs||'01'||substr('100000000'|| REF_CP_NBU(k.nd), -8 );
            --  logger.info('PEREOC 6 : nd = ' || k.nd || ' l_nls= '  || l_nls) ;
            -- открытие счета переоценки
            cp.CP_REG_EX(99, 0, 0, l_GRP, l_r1, l_RNK, l_NLS, k.KV, oo.nam_a, 'SR', gl.aUid, l_acc);
            UPDATE accounts SET mdate = l_mdate, accc = l_accc, seci = 4, pos = 1, pap=1, tip='SR' WHERE acc = l_acc;
            UPDATE accounts SET daos = oo.vdat WHERE acc = l_acc and daos > oo.vdat;
            begin
-- -- logger.info('PEREOC 7 : nd = ' || k.nd || ' l_acc= '  || l_acc) ;
               insert into cp_accounts (cp_ref, cp_acctype, cp_acc) values (k.nd,'SR',l_acc);
            exception when dup_val_on_index then  null;
            end;
         END;
      end if;

      begin
         select substr(a.nms,1,38) into oo.nam_a from accounts a where a.acc = l_acc;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN null;      
      end;                                                                

      begin
         select okpo into oo.id_a from  customer  where rnk in (select rnk from accounts where acc=l_acc);
      EXCEPTION  WHEN NO_DATA_FOUND  THEN  oo.id_a:=null;
      end;

      if p_mode = 0 THEN oo.dk := 0;
         oo.nazn := 'Списання дооцінки на суму сформованого резерву ';
      else               oo.dk := 1;
         oo.nazn := 'Дооцінка на суму сформованого резерву cтаном на ' || sdat01_;
      end if;

      if k.ost<>0 THEN 
         gl.ref (oo.REF);
         oo.datd := gl.bdate;
         oo.tt   := 'RXP'; 
         oo.vob  := 96;
         oo.nd   := 'PRC'||trim (Substr( '       '||to_char(oo.ref) , -7 ) ) ;
         oo.kv   := k.kv;
         oo.kv2  := 980;
         oo.s    := abs(k.ost);
         oo.s2   := gl.p_icurval ( oo.kv, oo.s, dat_v );
         oo.nlsa := l_nls;
         --oo.nazn := 'Дооцінка на суму сформованого резерву cтаном на ' || sdat01_;
         begin 
            select a.nms into oo.nam_b from  accounts a where a.nls = oo.nlsb and a.kv = 980;
         EXCEPTION  WHEN NO_DATA_FOUND  THEN  
            l_sErr := l_sErr  || 'НЕ знайдено в ACCOUNTS рах : ' || oo.nlsb  ;
            raise_application_error(  -20203,l_sErr, TRUE);
         end;      
         --logger.info('PEREOC 8 : nd = ' || k.nd || ' oo.nlsa= '  || oo.nlsa || ' oo.nlsb= '  || oo.nlsb) ;  
         gl.in_doc3 (ref_   => oo.REF  , tt_   => oo.tt  , vob_  => oo.vob ,  nd_  => oo.nd   , pdat_ => SYSDATE, vdat_ => oo.vdat, dk_   => oo.dk,
                     kv_    => oo.kv   , s_    => oo.S   , kv2_  => oo.kv2 , s2_   => oo.S2   , sk_   => null   , data_ => oo.datd, datp_ => oo.datd,
                     nam_a_ => oo.nam_a, nlsa_ => oo.nlsa, mfoa_ => gl.aMfo, nam_b_=> oo.nam_b, nlsb_ => oo.nlsb, mfob_ => gl.aMfo, nazn_ => oo.nazn, 
                     d_rec_ => null    , id_a_ => oo.id_a, id_b_ => oo.id_b, id_o_ => null    , sign_ => null   ,sos_   => 1      , prty_ => null,
                     uid_   => null);
         gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa , oo.s, oo.kv2    ,oo.nlsb, oo.s2);
         gl.pay (2, oo.ref, gl.bdate);  -- по факту
      end if;

   end LOOP;
   if p_mode = 1 THEN 
      nbu23_sr (P_dat01);
   end if;
   bc.go(l_kf);
end;
/
show err;
PROMPT *** Create  grants  pereocenka_cp ***
grant EXECUTE                                                                on pereocenka_cp      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on pereocenka_cp      to RCC_DEAL;
grant EXECUTE                                                                on pereocenka_cp      to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/pereocenka_cp.sql ========*** End **
PROMPT ===================================================================================== 

