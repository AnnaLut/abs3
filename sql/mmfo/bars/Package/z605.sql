
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/z605.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.Z605 IS  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :='ver.1. 23.08.2017-1';

/*
COBUSUPABS-5819 Розрахунок простроч.заборгованості за КД, в т.ч. за пенею та 3% річних / V_605
*/
  procedure rep ( P_DAT1 DATE, p_dat2 date, p_dat1p date, p_dat2p date) ; -- друк уведомления клиенту

  procedure XXX ( p_mode int, p_Id number, p_KV int, p_nls varchar2, p_ir number ) ;
--'[PROC=>Z605.XXX(:M,:N,:V,:S,:R,)]'||
--'[PAR=>:M(SEM=1=КД 2=АСС 3=БПК,TYPE=N),:N(SEM=Iд_Дог,TYPE=N),:V(SEM=*Вал_рах,TYPE=N),:S(SEM=*Рахунок,TYPE=C),:R(SEM=Розмір_пені,TYPE=N)]'||
  procedure FRM ( p_mode int, p_Id number, p_KV int, p_nls varchar2, p_ir number , p_3 number ) ;
--     z605.FRM  ( 1,         :ND,         null,     null,          null,          3)
END ;
/
CREATE OR REPLACE PACKAGE BODY BARS.Z605 is  G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'ver.1. 04.09.2017-1';
  g_errn number := -20203;
 --#########################################################################
procedure rep ( P_DAT1 DATE, p_dat2 date, p_dat1p date, p_dat2p date) is -- друк уведомления клиенту
  l_key zapros.PKEY%type := '\BRS\SBR\CCK\605';
  rr reports%rowtype ;
  ------------------------
  l_Ret cbirep_queries.id%type;
  l_mod int    := to_number( pul.Get('MOD_605')) ;
  l_ND  number := to_number( pul.Get('ND_605' )) ;
  l_KV  number := to_number( pul.Get('KV_605' )) ;
  l_nls varchar2 (15) :=     pul.Get('NLS_605' ) ;
  l_acc number ;
begin
  l_key := l_key || '_'|| l_mod ;
  begin select r.* into rr from reports r, zapros z where z.pkey = l_key and r.param like z.KODZ||',3%';
  EXCEPTION  WHEN NO_DATA_FOUND THEN    raise_application_error(g_errn,'Відсутній в АБС звіт з кодом запиту PKEY='||l_key);
  end;

  If    l_mod in (1,3) then l_Ret := RS.create_report_query( p_rep_id => rr.id, p_xml_params =>'<ReportParams><Param ID=":ND" Value="'||l_ND||'" /></ReportParams>'   ) ;
  ElsIf l_mod=2        then
     begin select acc  into l_acc from accounts where kv =l_kv and nls = l_nls;
     EXCEPTION  WHEN NO_DATA_FOUND THEN    raise_application_error(g_errn,'Відсутній рах='||l_kv|| '/'||l_nls);
     end;                   l_Ret := RS.create_report_query( p_rep_id => rr.id, p_xml_params =>'<ReportParams><Param ID=":ACC" Value="'||l_acc||'" /></ReportParams>'   ) ;
  else RETURN;
  end if;

  if getglobaloption ('BMS') = '1'  then -- BMS Признак: 1-установлена рассылка сообщений
     bms.enqueue_msg( 'Друк звіту .'||rr.name, dbms_aq.no_delay, dbms_aq.never, gl.aUid );
  end if;

end REP;

procedure XXX ( p_mode int, p_Id number, p_KV int, p_nls varchar2, p_ir number ) is
--Z605.XXX(1,:N,null,null,:R)
begin  pul.put('MOD_605', p_mode );
       pul.put('ND_605' , p_ID   );
       pul.put('KV_605' , p_KV   );
       pul.put('NLS_605', p_NLS  );
       pul.put('IR_605' , p_ir   );
end xxx;
--'[PROC=>Z605.XXX(:M,:N,:V,:S,:R,)]'||
--'[PAR=>:M(SEM=1=КД 2=АСС 3=БПК,TYPE=N),:N(SEM=Iд_Дог,TYPE=N),:V(SEM=*Вал_рах,TYPE=N),:S(SEM=*Рахунок,TYPE=C),:R(SEM=Розмір_пені,TYPE=N)]'||

-----------------------------------------------------------------
procedure FRM ( p_mode int , p_Id number , p_KV int, p_nls varchar2,     p_ir  number , p_3 number ) is
                l_mode int ; l_id number ; l_KV int; l_nls varchar2(15); l_Acc number ; l_acra number;
             -- p_mode = 1  По КД . p_Id= ND
             -- p_mode = 2  По ACC. p_Id= ACC
             -- p_mode = 3  По BPK. p_Id= ACC
  --------------------
  procedure p_ND ( l_id number,l_mode int , l_Acc number ) is
     l_dat1 date ; l_dat2 date; l_ir number   ;
     dd cc_deal%rowtype ; aa accounts%rowtype ; w4 w4_acc%rowtype   ; ss saldoa%rowtype ;

     tt tmp_T605%rowtype; pp tmp_P605%rowtype ; kk tmp_K605%rowtype ;
     l_SP8 number:=0; l_fdat date; z_dat date ; x_Id number ;
     -----------------------------------------------
     CURSOR C_1 IS select a.tip, a.pap, s.acc, s.fdat, s.dos, s.kos
                   from (select * from saldoa where fdat >= l_dat1 and fdat <= l_dat2) s, (select * from nd_acc where nd=dd.nd) N,  accounts   A
                   where a.acc=s.acc and n.acc=a.acc and n.nd = l_id  and a.tip in ('SS ', 'SP ' , 'SN' ,  'SPN', 'SK0','SK0', 'SG ') ;
     -----------------------------------------------
     CURSOR C_2 IS select a.tip, a.pap, s.acc, s.fdat, s.dos, s.kos
                   from (select * from saldoa where fdat >= l_dat1 and fdat <= l_dat2) s, (select * from accounts where acc in (l_acc,l_acra)) A where a.acc=s.acc ;
     -----------------------------------------------
     CURSOR C_3 IS select a.tip, a.pap, s.acc, s.fdat, s.dos, s.kos
                   from (select * from saldoa where fdat >= l_dat1 and fdat <= l_dat2) s,
                        (select * from accounts where acc in ( w4.ACC_OVR, w4.ACC_2208, w4.ACC_3570, w4.ACC_2207, w4.ACC_3579, w4.ACC_2209) ) A where a.acc=s.acc ;
     -------------           (select * from accounts where acc in ( w4.acc_pk, w4.ACC_OVR, w4.ACC_2208, w4.ACC_3570, w4.ACC_2207, w4.ACC_3579, w4.ACC_2209) ) A where a.acc=s.acc ;
     -----------------------------------------------


  begin
     l_dat2 := gl.bdate ;

     begin
          If    l_mode in (3  ) then select * into w4 from w4_acc  where nd = l_id;
                begin select a.* into aa from accounts a           where a.acc =  w4.acc_OVR ;                     l_dat1 := aa.daos;
                EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error ( g_errn ,'НЕ знайдено позичк.рах.2203* для дог '||l_id);
                end;
          elsIf l_mode in (1,2) then select * into dd from cc_deal where nd = l_id and vidd in (1,2,3,11,12,13) ;   l_dat1 := dd.sdate;
                begin select a.* into aa from accounts a, nd_acc n where n.nd=dd.nd and n.acc= a.acc and a.tip='LIM';
                EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error ( g_errn ,'НЕ знайдено рах.LIM  для дог '||l_id);
                end;
         else                                     raise_application_error ( g_errn, 'НЕвідомиі тир угоди ' || l_mode );
         end if ;
     EXCEPTION WHEN NO_DATA_FOUND THEN            raise_application_error ( g_errn, 'НЕ знайдено угоду  ' || l_id );
     end;

     If NVL ( p_IR, 0) = 0 then   L_IR := to_number (pul.Get('IR_605' ))  ;
     else                         l_Ir := p_ir;
     end if;
     If l_IR is null and l_mode in (1,2)  then
        select max( acrn.fprocn(a.acc,2,gl.bdate) )  into l_ir from accounts a, nd_acc n where n.nd = dd.nd and n.acc = a.acc and a.tip in ('SP ','SPN', 'SK9');
     end if;
     If l_Ir is null then  raise_application_error ( g_errn, 'НЕ введено (НЕ знайдено) ставку пені для угоди ' || l_id ); end if;
     -----------------------

     If l_mode = 1  then

        x_id := dd.nd  ;
        for G in (select * from cc_lim where nd = dd.nd and fdat >= l_dat1 and fdat <= l_dat2 )
        loop tt.g03 := GREATEST ( 0, g.sumg);          pp.g03 := GREATEST ( 0, g.sumo-g.sumg-nvl(g.sumk,0)  );          kk.g03 := GREATEST ( 0, nvl(g.sumk,0)  );
             insert into  tmp_T605  (md, ND  ,G01 ,G03, g02, g04 ) values ( l_mode, x_id, g.fdat, tt.G03, 0, 0 ) ;
             insert into  tmp_P605  (md, ND  ,G01 ,G03, g02, g04 ) values ( l_mode, x_id, g.fdat, pp.G03, 0, 0 ) ;
             insert into  tmp_K605  (md, ND  ,G01 ,G03, g02, g04 ) values ( l_mode, x_id, g.fdat, kk.G03, 0, 0 ) ;
        end loop ; -- G
        OPEN C_1 ;

     ElsIf l_mode = 2 then
        x_id := l_acc ;
        begin select acra into l_acra from int_accn where acc = l_acc and id = 0 and acra is not null ;
        EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error( g_errn,'НЕ знайдено проц.карта(0)  рах.SS ' || l_acc );
        end;
        OPEN C_2 ;

     ElsIf l_mode = 3 then If w4.acc_2208 is null then raise_application_error( g_errn,'НЕ знайдено рах.2208* для дог '||l_id);  end If;
        x_id := w4.nd ;
        OPEN C_3 ;

     else RETURN ;
     end if;

     --------------------------- Анализ Выпосок по счетам
     LOOP
        If    l_mode = 1 then FETCH C_1 into aa.tip, aa.pap, ss.acc, ss.fdat, ss.dos, ss.kos ; EXIT WHEN c_1%NOTFOUND;
        ElsIf l_mode = 2 then FETCH C_2 into aa.tip, aa.pap, ss.acc, ss.fdat, ss.dos, ss.kos ; EXIT WHEN c_2%NOTFOUND;
        ElsIf l_mode = 3 then FETCH C_3 into aa.tip, aa.pap, ss.acc, ss.fdat, ss.dos, ss.kos ; EXIT WHEN c_3%NOTFOUND;
        else  RETURN ;
        end if;

        tt.G02 := 0;   pp.G02 := 0 ;   kk.G02 := 0 ;   tt.G04 := 0;   pp.G04 := 0 ;   kk.G04 := 0 ;

        If l_mode = 3 then
           If    ss.dos > 0 and ss.acc = w4.acc_OVR  then  tt.G02 := ss.dos;  ---COMMENT ON COLUMN BARS.TMP_T605.G02 IS 'Сума наданого кредиту';
           ElsIf ss.dos > 0 and ss.acc = w4.acc_2208 then  pp.G02 := ss.dos;
           ElsIf ss.dos > 0 and ss.acc = w4.acc_3570 then  kk.G02 := ss.dos;

--         ElsIf ss.dos > 0 and aa.acc = w4.acc_PK   then  -- анализ деб.оборотов = погашено пени
--            for sd in (select a2.nbs,a2.ob22,o1.s from opldok o1,opldok o2,accounts a2 where o1.acc=ss.acc and o1.dk=0 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=1 and o2.acc=a2.acc)
--            loop  if sd.nbs ='6397' then l_SP8 := l_SP8 + sd.S ; end if ; end loop; --sd   упрлата пени

           ElsIf ss.kos > 0 then -- анализ кред.оборотов -- в корресконденции с 2625 = погашено задолженностей
              for sk in (select o2.s from opldok o1,opldok o2 where o1.acc=ss.acc and o1.dk=1 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=0 and o2.acc=w4.acc_pk)
              loop if    aa.acc in ( w4.acc_OVR , w4.acc_2207 ) then tt.G04 := tt.G04 + sk.S ; -- COMMENT ON COLUMN BARS.TMP_T605.G04 IS 'Сума погашеного кредиту';
                   elsIf aa.acc in ( w4.acc_2208, w4.acc_2209 ) then pp.G04 := pp.G04 + sk.S ;
                   elsIf aa.acc in ( w4.acc_3570, w4.acc_3579 ) then kk.G04 := kk.G04 + sk.S ;
                   end if;
              end loop ; -- sk
           end if;

        else
           If    ss.dos > 0 and aa.tip = 'SS ' then  tt.G02 := ss.dos;  ---COMMENT ON COLUMN BARS.TMP_T605.G02 IS 'Сума наданого кредиту';
           ElsIf ss.dos > 0 and aa.tip = 'SN ' then  pp.G02 := ss.dos;
           ElsIf ss.dos > 0 and aa.tip = 'SK0' then  kk.G02 := ss.dos;
           ElsIf ss.dos > 0 and aa.tip = 'SG ' then  -- анализ деб.оборотов = погашено пени
              for sd in (select a2.nbs,a2.ob22,o1.s from opldok o1,opldok o2,accounts a2 where o1.acc=aa.acc and o1.dk=0 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=1 and o2.acc=a2.acc)
              loop  if sd.nbs ='6397' then l_SP8 := l_SP8 + sd.S ; end if ; end loop; --sd   упрлата пени

           ElsIf aa.kos > 0 then -- анализ кред.оборотов -- погашено задолженностей
              for sk in (select a2.tip,o1.s from opldok o1,opldok o2,accounts a2 where o1.acc=aa.acc and o1.dk=1 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=0 and o2.acc=a2.acc)
              loop if    aa.tip in ('SS ','SP ') and sk.tip not in ('SS ','SP ','SN ','SPN','SK0','SK9') then tt.G04 := tt.G04 + sk.S ; -- COMMENT ON COLUMN BARS.TMP_T605.G04 IS 'Сума погашеного кредиту';
                   elsIf aa.tip in ('SN ','SPN') and sk.tip not in ('SS ','SP ','SN ','SPN','SK0','SK9') then pp.G04 := pp.G04 + sk.S ;
                   elsIf aa.tip in ('SK0','SK9') and sk.tip not in ('SS ','SP ','SN ','SPN','SK0','SK9') then kk.G04 := kk.G04 + sk.S ;
                   end if;
              end loop ; -- sk
           end if;
        end if;

        ----
        If tt.G02 >0 or tt.g04 >0 then Update tmp_T605 set g02 = tt.g02, g04 = tt.g04    where nd = x_id and g01 = ss.fdat and md = l_mode  ;
           if SQL%rowcount = 0 then    insert into tmp_T605 (md,ND,G01,G03,g02,g04) values (l_mode, x_id, ss.fdat, 0,  tt.g02, tt.g04  )    ; end if ;
        end if ;
        If pp.G02 >0 or pp.g04 >0 then Update tmp_p605 set g02 = pp.g02, g04 = pp.g04    where nd = x_id and g01 = ss.fdat  and md = l_mode ;
           if SQL%rowcount = 0 then    insert into tmp_p605 (md,ND,G01,G03,g02,g04) values (l_mode, x_id, ss.fdat, 0,  pp.g02, pp.g04  )    ; end if ;
        end if ;
        If kk.G02 >0 or kk.g04 >0 then Update tmp_k605 set g02 = kk.g02, g04 = kk.g04    where nd = x_id and g01 = ss.fdat  and md = l_mode ;
           if SQL%rowcount = 0 then    insert into tmp_k605 (md,ND,G01,G03,g02,g04) values (l_mode, x_id, ss.fdat, 0,  kk.g02, kk.g04  )    ; end if ;
        end if ;

      end loop; -- a1

      If    l_mode = 1 then  close C_1 ;
      ElsIf l_mode = 2 then  close C_2 ;
      ElsIf l_mode = 3 then  close C_3 ;
      else RETURN ;
      end if;


      l_fdat := null;
      for z in (select rowid RI, x.* from tmp_T605 x where md = l_mode and nd= x_id order by g01)
      loop select -NVL( SUM( decode (a.tip,'SS ', fost(a.acc,z.g01), 0) ),0) ,  -NVL( SUM( decode (a.tip,'SP ', fost(a.acc,z.g01), 0) ),0) ,    min( decode (a.tip,'SP ', DAT_SPZ(a.ACC,z.g01,0), null ))
           into  tt.g05, tt.g06, z_dat   from accounts a, nd_acc n     where n.nd = dd.nd and n.acc= a.acc and a.tip in ('SS ','SP ');
           tt.g07 := z.g01 -z_dat ;
           If l_fdat is not null then        tt.g09 := calp_AR ( tt.g06,  l_ir, l_fdat+1, z.g01 , 0);        tt.g11 := calp_AR ( tt.g06,  p_3 , l_fdat+1, z.g01 , 0);      end if;
           l_fdat := z.g01;
           update tmp_t605 Set g05=tt.g05, g06=tt.g06, g07=tt.g07, g08=l_ir, g09=tt.g09, g10=p_3, g11=tt.g11  where rowid = z.RI ;
      end loop; -- t


      l_fdat := null;
      for z in (select rowid RI, x.* from tmp_p605 x where md = l_mode and nd= x_id order by g01)
      loop  select -NVL( SUM( decode (a.tip,'SN ', fost(a.acc,z.g01), 0) ),0),       -NVL( SUM( decode (a.tip,'SPN', fost(a.acc,z.g01), 0) ),0),   min( decode (a.tip,'SPN', DAT_SPZ(a.ACC,z.g01,0), null ))
            into  pp.g05, pp.g06, z_dat    from accounts a, nd_acc n where n.nd = dd.nd and n.acc= a.acc and a.tip in ('SN ','SPN');
            pp.g07 := z.g01 -z_dat ;
            If l_fdat is not null then   pp.g09 := calp_AR ( pp.g06,  l_ir, l_fdat+1, z.g01 , 0);     pp.g11 := calp_AR ( pp.g06,  p_3 , l_fdat+1, z.g01 , 0);  end if;
            l_fdat := z.g01;
           update tmp_p605 Set g05=pp.g05, g06=pp.g06, g07=pp.g07, g08=l_ir, g09=pp.g09, g10=p_3, g11=pp.g11  where rowid = z.RI ;
      end loop; -- p

      l_fdat := null;
      for z in (select rowid RI, x.* from tmp_k605 x where md = l_mode and nd= x_id order by g01)
      loop select -NVL( SUM( decode (a.tip,'SK0', fost(a.acc, z.g01), 0) ),0),     -NVL( SUM( decode (a.tip,'SK9', fost(a.acc, z.g01), 0) ),0),    min( decode (a.tip,'SK9', DAT_SPZ(a.ACC,z.g01,0), null ))
           into  kk.g05, kk.g06, z_dat   from accounts a, nd_acc n where n.nd = dd.nd and n.acc= a.acc and a.tip in ('SK0 ','SK9');
           kk.g07 := z.g01 -z_dat ;
           If l_fdat is not null then   kk.g09 := calp_AR ( kk.g06,  l_ir, l_fdat+1, z.g01 , 0);    kk.g11 := calp_AR ( kk.g06,  p_3 , l_fdat+1, z.g01 , 0);  end if;
           l_fdat := z.g01;
           update tmp_k605 Set g05=kk.g05, g06=kk.g06, g07=kk.g07, g08=l_ir, g09=kk.g09, g10=p_3, g11=kk.g11  where rowid = z.RI ;
      end loop; -- k

  end p_ND;
  --------------------------------------------------------------------------
begin

  If NVL(p_mode, 0 ) = 0  then  l_mode := to_number( pul.get ('MOD_605' ) ) ; else l_mode := p_mode ; end if ;
  If NVL( p_id , 0 ) = 0  then  l_id   := to_number( pul.get ('ND_605'  ) ) ; else l_id   := p_id   ; end if ;
  If l_mode not in (1, 2, 3) or l_id   is null  then RETURN ;  end if   ;
  If NVL( p_KV , 0 ) = 0  then  l_KV   := to_number( pul.get ('KV_605'  ) ) ; else l_kv   := p_kv   ; end if ;
  If NVL( p_nls,'*') ='*' then  l_nls  :=            pul.get ('NLS_605' )   ; else l_nls  := p_nls  ; end if ;
  --------------------------------------------------------------
  delete from tmp_T605 where nd = l_Id and md = l_mode ;
  delete from tmp_P605 where nd = l_Id and md = l_mode ;
  delete from tmp_K605 where nd = l_Id and md = l_mode ;

  If    l_mode = 1 then  p_ND  (l_id, l_mode, null  )  ;
  ElsIf l_mode = 2 then
     begin select a.acc into l_acc from accounts a, nd_acc n where  n.nd = l_id and n.acc= a.acc and a.tip ='SS ' and a.kv = l_kv and a.nls = l_nls ;
     EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(g_errn,'НЕ знайдено рах.SS='||l_kv||'/'||l_nls||' для дог '||l_id);
     end;
     p_ND  (l_id, l_mode, l_acc )  ;
  ElsIf l_mode = 3 then  RETURN; --p_BPK (l_id, l_mode)  ;
  end if;

  update tmp_t605 Set g02=g02/100, g03=g03/100, g04=g04/100, g05=g05/100, g06=g06/100, g09=g09/100, g11=g11/100;
  update tmp_p605 Set g02=g02/100, g03=g03/100, g04=g04/100, g05=g05/100, g06=g06/100, g09=g09/100, g11=g11/100;
  update tmp_k605 Set g02=g02/100, g03=g03/100, g04=g04/100, g05=g05/100, g06=g06/100, g09=g09/100, g11=g11/100;

end FRM;

---Аномимный блок --------------
begin null ;
END Z605;
/
 show err;
 
PROMPT *** Create  grants  Z605 ***
grant EXECUTE                                                                on Z605            to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/z605.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 