CREATE OR REPLACE PACKAGE BARS.Z605 IS  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :='ver.1. 06.09.2017-1';

/*
  Розрахунок простроч.заборгованості за КД, в т.ч. за пенею та 3% річних / V_605
*/


  procedure rep ( D11 DATE, D12 date, D21 date, D22 date) ;            -- підготовка звіту в фаст-репорті-- Поставити в чергу "Друк звіту"
  --z605.rep( :D11, :D12, :D21, :D22)      -- :D11(SEM=Звіт_З_Дати,TYPE=D),:D12(SEM=Звіт_ПО_Дату,TYPE=D),:D21(SEM=Пеня_З_Дати,TYPE=D),:D22(SEM=Пеня_ПО_Дату,TYPE=D)

  procedure XXX ( p_mode int, p_Id number, p_KV int, p_nls varchar2, p_ir number ) ; -- Установка параметрів  в пул змінних
  --'[PROC=>Z605.XXX(:M,:N,:V,:S,:R,)][PAR=>:M(SEM=1=КД 2=АСС 3=БПК,TYPE=N),:N(SEM=Iд_Дог,TYPE=N),:V(SEM=*Вал_рах,TYPE=N),:S(SEM=*Рахунок,TYPE=C),:R(SEM=Розмір_пені,TYPE=N)]'||

  procedure FRM ( p_mode int, p_Id number, p_KV int, p_nls varchar2, p_ir number , p_3 number ) ;  -- формування звіту

END ;
/
 grant execute on  bars.z605  to  BARS_ACCESS_DEFROLE ;   

CREATE OR REPLACE PACKAGE BODY BARS.Z605 is  G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'ver.2.5 12.03.2018-1';
  g_errn number := -20203;
/*
 20/02/2018.....
11.02.2018 Обробка виносу на прострочку
22.12.2017 Зміна базової ставки пені в періоді нарахування
17.10.2017 Сухова раскраска цветом
 nCol = 1 - голубой - плановое событие
 nCol = 2 - зеленый - факт-событие (с план совпадают)
 nCol = 3 - красный - факт-событие ( с план НЕ  совпадают)
 nCol = 4 - серый - технич.собыние ( начисление, вынос на просрочку)
*/
 --#########################################################################

procedure rep ( D11 DATE, D12 date, D21 date, D22 date) Is            -- підготовка звіту в фаст-репорті-- Поставити в чергу "Друк звіту"
  --z605.rep( :D11, :D12, :D21, :D22)      -- :D11(SEM=Звіт_З_Дати,TYPE=D),:D12(SEM=Звіт_ПО_Дату,TYPE=D),:D21(SEM=Пеня_З_Дати,TYPE=D),:D22(SEM=Пе

  l_key1 zapros.PKEY%type ;
  l_key2 zapros.PKEY%type ;
  rr reports%rowtype ;
  rr1 reports%rowtype ;
  ------------------------
  l_Ret cbirep_queries.id%type;
  l_mod int    := to_number( pul.Get('MOD_605')) ;
  l_ND  number := to_number( pul.Get('ND_605' )) ;
  l_KV  number := to_number( pul.Get('KV_605' )) ;
  l_nls varchar2 (15) :=     pul.Get('NLS_605' ) ;
  l_acc number ;
  l_D11 DATE   ; l_D12 date ; l_D21 date ; l_D22 date ;

begin

  If d11 is null then select min(g01) into l_d11 from tmp_t605 where nd = l_ND; else l_d11 := d11 ; end if;
  If d12 is null then /*select max(g01) into l_d12 from tmp_t605;*/l_d12 := gl.bd; else l_d12 := d12 ; end if;
  If d21 is null then select min(g01) into l_d21 from tmp_t605 where nd = l_ND; else l_d21 := d21 ; end if;
  If d22 is null then /*select max(g01) into l_d22 from tmp_t605;*/l_d22 := gl.bd; else l_d22 := d22 ; end if;

     -- 11 <=   21            <= 22             <= 12
  If l_d11 > l_d21 OR l_d21 > l_d22  OR l_d22 > l_d12 then
     raise_application_error(g_errn,'НЕлогічна послідовність дат : ' || to_char(l_d11,'dd.mm.yyyy') ||
                                                              ' <= ' || to_char(l_d21,'dd.mm.yyyy') ||
                                                              ' <= ' || to_char(l_d22,'dd.mm.yyyy') ||
                                                              ' <= ' || to_char(l_d12,'dd.mm.yyyy') )  ;
  end if;
   -- Один отчет , думаю нет смысла одно и тоже дублировать
  If    l_mod in (1,2,3) then   l_key1 := '\BRS\SBER\REP\3006';
                                --l_key2 := '\BRS\SBER\***\3007';
                                --l_key2 := '\BRS\SBER\***\210';
 -- ElsIf l_mod = 2 then   l_key := '\BRS\SBER\REP\3006';
 -- ElsIf l_mod = 3 then   l_key := '\BRS\SBER\REP\3006';
  else  RETURN;
  end if;

-- как-то надо передать еще 4 параметрыа - даты  ????

  begin select r.* into rr from reports r, zapros z where z.pkey = l_key1 and r.param like z.KODZ||',3%';
        --select r.* into rr1 from reports r, zapros z where z.pkey = l_key2 and r.param like z.KODZ||',19%';
  EXCEPTION  WHEN NO_DATA_FOUND THEN    raise_application_error(g_errn,'Відсутній в АБС звіт з кодом запиту PKEY='||l_key1|| ' або '||l_key2);
  end;

  If    l_mod = 1 then
        l_Ret := RS.create_report_query( p_rep_id => rr.id, p_xml_params =>'<ReportParams><Param ID=":ND" Value="'||l_ND||'" /><Param ID=":sFdat1" Value="'||to_char(l_d11,'dd.mm.yyyy')||'"/><Param ID=":sFdat2" Value="'||to_char(l_d12,'dd.mm.yyyy')||'"/><Param ID=":sFdat3" Value="'||to_char(l_d21,'dd.mm.yyyy')||'"/><Param ID=":sFdat4" Value="'||to_char(l_d22,'dd.mm.yyyy')||'"/><Param ID=":TYP" Value="1" /></ReportParams>'   ) ;
        --l_Ret := RS.create_report_query( p_rep_id => rr1.id, p_xml_params =>'<ReportParams><Param ID=":ND" Value="'||l_ND||'" /><Param ID=":DAT1" Value="'||to_char(l_d11,'dd.mm.yyyy')||'"/><Param ID=":DAT2" Value="'||to_char(l_d12,'dd.mm.yyyy')||'"/><Param ID=":TYP" Value="1" /></ReportParams>'   ) ;
  ElsIf l_mod = 3        then
        l_Ret := RS.create_report_query( p_rep_id => rr.id, p_xml_params =>'<ReportParams><Param ID=":ND" Value="'||l_ND||'" /><Param ID=":sFdat1" Value="'||to_char(l_d11,'dd.mm.yyyy')||'"/><Param ID=":sFdat2" Value="'||to_char(l_d12,'dd.mm.yyyy')||'"/><Param ID=":sFdat3" Value="'||to_char(l_d21,'dd.mm.yyyy')||'"/><Param ID=":sFdat4" Value="'||to_char(l_d22,'dd.mm.yyyy')||'"/><Param ID=":TYP" Value="2" /></ReportParams>'   ) ;
        --l_Ret := RS.create_report_query( p_rep_id => rr1.id, p_xml_params =>'<ReportParams><Param ID=":ND" Value="'||l_ND||'" /><Param ID=":DAT1" Value="'||to_char(l_d11,'dd.mm.yyyy')||'"/><Param ID=":DAT2" Value="'||to_char(l_d12,'dd.mm.yyyy')||'"/><Param ID=":TYP" Value="2" /></ReportParams>'   ) ;
  ElsIf l_mod=2        then
     begin select acc  into l_acc from accounts where kv =l_kv and nls = l_nls;
     EXCEPTION  WHEN NO_DATA_FOUND THEN    raise_application_error(g_errn,'Відсутній рах='||l_kv|| '/'||l_nls);
     end;
        l_Ret := RS.create_report_query( p_rep_id => rr.id, p_xml_params =>'<ReportParams><Param ID=":ACC" Value="'||l_acc||'" /><Param ID=":sFdat1" Value="'||to_char(l_d11,'dd.mm.yyyy')||'"/><Param ID=":sFdat2" Value="'||to_char(l_d12,'dd.mm.yyyy')||'"/><Param ID=":sFdat3" Value="'||to_char(l_d21,'dd.mm.yyyy')||'"/><Param ID=":sFdat4" Value="'||to_char(l_d22,'dd.mm.yyyy')||'"/><Param ID=":TYP" Value="3" /></ReportParams>'   ) ;
        --l_Ret := RS.create_report_query( p_rep_id => rr1.id, p_xml_params =>'<ReportParams><Param ID=":ND" Value="'||l_acc||'" /><Param ID=":DAT1" Value="'||to_char(l_d11,'dd.mm.yyyy')||'"/><Param ID=":DAT2" Value="'||to_char(l_d12,'dd.mm.yyyy')||'"/><Param ID=":TYP" Value="0" /></ReportParams>'   ) ;
  else RETURN;
  end if;

 /* if getglobaloption ('BMS') = '1'  then -- BMS Признак: 1-установлена рассылка сообщений
     bms.enqueue_msg( 'Формування звіту '||rr.description||' по реф.Дог='|| l_nd||' додано у чергу', dbms_aq.no_delay, dbms_aq.never, gl.aUid );
  end if;*/
end REP;
------------------------
 function get_sum_rate(p_sum number,
                      p_rate number,
                      p_day  number,
                      p_date date)
   return number is
l_res number;
l_year number;
l_year_day number := 365;
begin

  SELECT EXTRACT (YEAR FROM p_date) into l_year FROM DUAL;

   IF ((l_year/4 = 0 AND l_year/100 != 0) OR (l_year/400 = 0)) THEN
    l_year_day :=366;
   ELSE  l_year_day :=365;
   END IF;

    l_res := p_sum*(p_rate/100/l_year_day)*p_day;

return nvl(l_res,0);
end;
procedure XXX ( p_mode int, p_Id number, p_KV int, p_nls varchar2, p_ir number ) is    l_Id number := p_ID; l_KV int := Nvl(p_KV, 980);
--Z605.XXX(1,:N,null,null,:R)
begin  pul.put('MOD_605', p_mode );

       If p_mode = 3 and L_Id is null then

          begin select w.nd into l_id from w4_acc w, accounts a where  a.kv =l_kv and a.nls = p_nls and a.acc = w.acc_pk;
          EXCEPTION WHEN NO_DATA_FOUND THEN  null;
          end;

       end if;

       pul.put('ND_605' , L_ID   );
       pul.put('KV_605' , l_KV   );

       pul.put('NLS_605', p_NLS  );
       pul.put('IR_605' , p_ir   );

end xxx;
--'[PROC=>Z605.XXX(:M,:N,:V,:S,:R,)]'||
--'[PAR=>:M(SEM=1=КД 2=АСС 3=БПК,TYPE=N),:N(SEM=Iд_Дог,TYPE=N),:V(SEM=*Вал_рах,TYPE=N),:S(SEM=*Рахунок,TYPE=C),:R(SEM=Розмір_пені,TYPE=N)]'||

-----------------------------------------------------------------
procedure FRM ( p_mode int , p_Id number , p_KV int, p_nls varchar2,     p_ir  number , p_3 number ) is
                l_mode int ; l_id number ; l_KV int; l_nls varchar2(15); l_Acc number ; l_acra number; x_acc number;
             -- p_mode = 1  По КД . p_Id= ND
             -- p_mode = 2  По ACC. p_Id= ACC
             -- p_mode = 3  По BPK. p_Id= ACC
  --------------------

  --------------------
  procedure p_ND ( l_id number,l_mode int , l_Acc number ) is
     l_dat1 date ; l_dat2 date; l_ir number   ;
     dd cc_deal%rowtype ; aa accounts%rowtype ; w4 w4_acc%rowtype   ; ss saldoa%rowtype ;

     tt tmp_T605%rowtype; pp tmp_P605%rowtype ; kk tmp_K605%rowtype ;
     l_SP8 number:=0; l_fdat date; z_dat date ; x_Id number ; l_count number ;
     pred_ir number:=0;  pred_dat date;
     -----------------------------------------------
     CURSOR C_1 IS select a.tip, a.pap, s.acc, s.fdat, s.dos, s.kos
                   from (select * from saldoa where fdat >= l_dat1 and fdat <= l_dat2) s, (select * from nd_acc where nd=dd.nd) N,  accounts   A
                   where a.acc=s.acc and n.acc=a.acc and n.nd = l_id  and a.tip in ('SS ', 'SP ' , 'SN' ,  'SPN', 'SK0','SK0', 'SG ') order by s.fdat  ;

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
                EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error ( g_errn ,'НЕ знайдено позичк.рах.2203* для дог '||l_id||' acc='|| w4.acc_OVR );
                end;
         elsIf l_mode in (1,2 ) then select * into dd from cc_deal where nd = l_id and vidd in (1,2,3,11,12,13) ;   l_dat1 := dd.sdate;
                begin select a.* into aa from accounts a, nd_acc n where n.nd=dd.nd and n.acc= a.acc and a.tip='LIM';
                EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error ( g_errn ,'НЕ знайдено рах.LIM  для дог '||l_id);
                end;
         /*elsIf l_mode in (2 ) then
                begin
                  select d.* into dd from nd_acc n, cc_deal d where n.acc = (select acc from accounts where nls = p_nls) and d.nd = n.nd and d.vidd in (1,2,3,11,12,13) ;
                  l_dat1 := dd.sdate;
                  select a.* into aa from accounts a, nd_acc n where n.nd=dd.nd and n.acc= a.acc and a.tip='LIM';
                EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error ( g_errn ,'НЕ знайдено договір для рахунку '||p_nls);
                end;*/
         else                                     raise_application_error ( g_errn, 'НЕвідомиі тир угоди ' || l_mode );
         end if ;
     EXCEPTION WHEN NO_DATA_FOUND THEN            raise_application_error ( g_errn, 'НЕ знайдено угоду  ' || l_id );
     end;

     If NVL ( p_IR, 0) = 0 then   L_IR := to_number (pul.Get('IR_605' ))  ;
     else                         l_Ir := p_ir;
     end if;
   /*  If l_IR is null and l_mode in (1,2)  then
        select max( acrn.fprocn(a.acc,2,gl.bdate) )  into l_ir from accounts a, nd_acc n where n.nd = dd.nd and n.acc = a.acc and a.tip in ('SP ','SPN', 'SK9');
     end if;
     If l_Ir is null then  raise_application_error ( g_errn, 'НЕ введено (НЕ знайдено) ставку пені для угоди ' || l_id ); end if;*/
     -----------------------

     If l_mode = 1  then

        x_id := dd.nd  ;
        -- nCol = 1 - голубой - плановое событие
        for G in (select * from cc_lim where nd = dd.nd and fdat >= l_dat1 and fdat <= l_dat2 )
        loop tt.g03 := GREATEST ( 0, g.sumg);          pp.g03 := GREATEST ( 0, g.sumo-g.sumg-nvl(g.sumk,0)  );          kk.g03 := GREATEST ( 0, nvl(g.sumk,0)  );
             insert into  tmp_T605  (md, ND, G01 ,G03, g02, g04, nCol ) values ( l_mode, x_id, g.fdat, tt.G03, 0, 0 , 1 ) ;
             insert into  tmp_P605  (md, ND, G01 ,G03, g02, g04, nCol ) values ( l_mode, x_id, g.fdat, pp.G03, 0, 0 , 1 ) ;
             insert into  tmp_K605  (md, ND, G01 ,G03, g02, g04, nCol ) values ( l_mode, x_id, g.fdat, kk.G03, 0, 0 , 1 ) ;
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

--         ElsIf ss.dos > 0 and ss.acc = w4.acc_PK   then  -- анализ деб.оборотов = погашено пени
--            for sd in (select a2.nbs,a2.ob22,o1.s from opldok o1,opldok o2,accounts a2 where o1.acc=ss.acc and o1.dk=0 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=1 and o2.acc=a2.acc)
--            loop  if sd.nbs ='6397' then l_SP8 := l_SP8 + sd.S ; end if ; end loop; --sd   упрлата пени

           ElsIf ss.kos > 0 then -- анализ кред.оборотов -- в корресконденции с 2625 = погашено задолженностей

--logger.info('XXX-1*'|| ss.acc||'*'|| ss.fdat||'*'|| ss.kos||'*'|| w4.acc_pk);


              for sk in (select o2.s from opldok o1,opldok o2 where o1.acc=ss.acc and o1.dk=1 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=0 and o2.acc=w4.acc_pk)
              loop if    ss.acc in ( w4.acc_OVR , w4.acc_2207 ) then tt.G04 := tt.G04 + sk.S ; -- COMMENT ON COLUMN BARS.TMP_T605.G04 IS 'Сума погашеного кредиту';
                   elsIf ss.acc in ( w4.acc_2208, w4.acc_2209 ) then pp.G04 := pp.G04 + sk.S ;
                   elsIf ss.acc in ( w4.acc_3570, w4.acc_3579 ) then kk.G04 := kk.G04 + sk.S ;
                   end if;
--logger.info('XXX-2*'|| sk.s);

              end loop ; -- sk
           end if;

        else
           If    ss.dos > 0 and aa.tip = 'SS ' then  tt.G02 := ss.dos;  ---COMMENT ON COLUMN BARS.TMP_T605.G02 IS 'Сума наданого кредиту';
           ElsIf ss.dos > 0 and aa.tip = 'SP ' then  tt.G06 := ss.dos; /*if ss.kos > 0 and ss.kos = ss.dos then  tt.G04 := ss.kos; end if;*/--lso
           ElsIf ss.dos > 0 and aa.tip = 'SN ' then  pp.G02 := ss.dos;   
               if ss.kos > 0  then  
                  --pp.G04 := ss.kos;
                  for sp in (select a2.tip,o1.s from opldok o1,opldok o2,accounts a2 where o1.acc=ss.acc and o1.dk=1 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=0 and o2.acc=a2.acc)
                    loop If aa.tip in ('SN ','SPN') and sp.tip not in ('SS ','SP ','SN ','SPN','SK0','SK9') then pp.G04 := pp.G04 + sp.S ;--logger.info('XXX-3*'|| pp.G04||'*');
                         end if;
                    end loop ; -- sk 
               end if;
           ElsIf ss.dos > 0 and ss.kos = 0 and aa.tip = 'SPN' then  pp.G06 := ss.dos;  --lso
           ElsIf ss.dos > 0 and aa.tip = 'SK0' then  kk.G02 := ss.dos;
           ElsIf ss.dos > 0 and aa.tip = 'SK9' then  kk.G06 := ss.dos; --lso
           ElsIf ss.dos > 0 and aa.tip = 'SG ' then  -- анализ деб.оборотов = погашено пени
              for sd in (select a2.nbs,a2.ob22,o1.s from opldok o1,opldok o2,accounts a2 where o1.acc=ss.acc and o1.dk=0 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=1 and o2.acc=a2.acc)
              loop  if sd.nbs ='6397' then l_SP8 := l_SP8 + sd.S ; end if ; end loop; --sd   упрлата пени
           ElsIf ss.kos > 0 then -- анализ кред.оборотов -- погашено задолженностей
              logger.info('XXX-1*'|| ss.acc||'*'|| ss.fdat||'*'|| ss.kos||'*'|| ss.fdat);
              for sk in (select a2.tip,o1.s from opldok o1,opldok o2,accounts a2 where o1.acc=ss.acc and o1.dk=1 and o1.fdat=ss.fdat and o1.ref=o2.ref and o1.stmt=o2.stmt and o2.dk=0 and o2.acc=a2.acc)
              loop if    aa.tip in ('SS ','SP ') and sk.tip not in ('SS ','SP ','SN ','SPN','SK0','SK9') then tt.G04 := tt.G04 + sk.S ;logger.info('XXX-2*'|| tt.G04||'*'); -- COMMENT ON COLUMN BARS.TMP_T605.G04 IS 'Сума погашеного кредиту';
                   elsIf aa.tip in ('SN ','SPN') and sk.tip not in ('SS ','SP ','SN ','SPN','SK0','SK9') then pp.G04 := pp.G04 + sk.S ;logger.info('XXX-3*'|| pp.G04||'*');
                   elsIf aa.tip in ('SK0','SK9') and sk.tip not in ('SS ','SP ','SN ','SPN','SK0','SK9') then kk.G04 := kk.G04 + sk.S ;
                   end if;
              end loop ; -- sk
           end if;
        end if;


/*        ----
COMMENT ON COLUMN tmp_T605.G02  IS 'Сума наданого кредиту';
COMMENT ON COLUMN tmp_T605.G04  IS 'Сума погашеного кредиту';
 nCol = 2 - зеленый - факт-событие (с план совпадают)
 nCol = 3 - красный - факт-событие ( с план НЕ  совпадают)
*/

        If tt.G02 >0 or tt.g04 >0 then Update tmp_T605 set g02 = tt.g02, g04 = tt.g04, nCol = 2     where nd = x_id and g01 = ss.fdat and md = l_mode  ;
           if SQL%rowcount = 0 then    insert into tmp_T605 (md,ND,G01,G03,g02,g04,nCol) values (l_mode, x_id, ss.fdat, 0,  tt.g02, tt.g04, 3  )    ; end if ;
         /*  if tt.G06 >0 and tt.g04 = tt.G06   then
             Update tmp_T605 set G06 = tt.G06     where nd = x_id and g01 = ss.fdat and md = l_mode  ;
           end if;*/
        end if ;
        If tt.G06 >0 and aa.tip = 'SP ' and tt.g04 =0 then /*Update tmp_T605 set g02 = tt.g02, g06 = tt.g06, nCol = 4     where nd = x_id and g01 = ss.fdat and md = l_mode  ; --lso
           if SQL%rowcount = 0 then  */  insert into tmp_T605 (md,ND,G01,G02,G03,  G04, G06,nCol) values (l_mode, x_id, ss.fdat,tt.g02, 0, tt.g04, tt.g06, 4  )    ;
              bars_audit.info('Z605_t ss.fdat = '||ss.fdat||' tt.g06= '||tt.g06||' aa.tip= '||aa.tip);
           if ss.kos >0 and ss.kos = tt.G06   then
             Update tmp_T605 set G04 = ss.kos     where nd = x_id and g01 = ss.fdat and md = l_mode and  nCol = 4 ;
           end if;
        end if ;
        If pp.G02 >0 or pp.g04 >0 then
          begin
               --Update tmp_p605 set g02 = pp.g02, g04 = pp.g04, nCol = 2     where nd = x_id and g01 = ss.fdat  and md = l_mode ;
               if pp.g04 >0 and pp.G02 >0  then
                 Update tmp_p605 set g02 = pp.g02, g04 = pp.g04, nCol = 2     where nd = x_id and g01 = ss.fdat  and md = l_mode ;
               elsif pp.G02 >0 then
                 Update tmp_p605 set g02 = pp.g02, nCol = 2     where nd = x_id and g01 = ss.fdat  and md = l_mode ;
               elsif pp.g04 >0 then
                 Update tmp_p605 set g04 = pp.g04, nCol = 2     where nd = x_id and g01 = ss.fdat  and md = l_mode ;

               end if;
               bars_audit.info('Z605_pp2 ss.fdat = '||ss.fdat||' pp.g02= '||pp.g02||' aa.tip= '||aa.tip||' pp.g04= '||pp.g04||' ss.dos= '||ss.dos||' ss.kos= '||ss.kos);
           if SQL%rowcount = 0 then    insert into tmp_p605 (md,ND,G01,G03,g02,g04,nCol) values (l_mode, x_id, ss.fdat, 0,  pp.g02, pp.g04, 3  );
               bars_audit.info('Z605_pp2i ss.fdat = '||ss.fdat||' pp.g02= '||pp.g02||' aa.tip= '||aa.tip||' pp.g04= '||pp.g04||' ss.dos= '||ss.dos||' ss.kos= '||ss.kos);
            end if ;
          end;
        end if ;
        If pp.G06 >0 and aa.tip = 'SPN' and pp.g04 =0 and pp.G06<>ss.kos then /*Update tmp_p605 set g02 = pp.g02, g06 = pp.g06, nCol = 4     where nd = x_id and g01 = ss.fdat and md = l_mode  ; --lso
           if SQL%rowcount = 0 then */   insert into tmp_p605 (md,ND,G01,G02,G03, G04 ,G06,nCol) values (l_mode, x_id, ss.fdat,pp.g02, 0,  pp.g04, pp.g06, 4  )     ; --end if ;
           bars_audit.info('Z605_pp ss.fdat = '||ss.fdat||' pp.g06= '||pp.g06||' aa.tip= '||aa.tip||' pp.g04= '||pp.g04||' ss.kos= '||ss.kos);
        end if ;
        If kk.G02 >0 or kk.g04 >0 then Update tmp_k605 set g02 = kk.g02, g04 = kk.g04, nCol = 2    where nd = x_id and g01 = ss.fdat  and md = l_mode ;
           if SQL%rowcount = 0 then    insert into tmp_k605 (md,ND,G01,G03,g02,g04,nCol) values (l_mode, x_id, ss.fdat, 0,  kk.g02, kk.g04, 3  )    ; end if ;
        end if ;
        If kk.G06 >0 and aa.tip = 'SK9' and kk.g04 =0 then /*Update tmp_p605 set g02 = pp.g02, g06 = pp.g06, nCol = 4     where nd = x_id and g01 = ss.fdat and md = l_mode  ; --lso
           if SQL%rowcount = 0 then */   insert into tmp_k605(md,ND,G01,G02,G03, G04 ,G06,nCol) values (l_mode, x_id, ss.fdat,kk.g02, 0,  kk.g04, kk.g06, 4  )     ; --end if ;
        end if ;

      end loop; -- a1

      If    l_mode = 1 then  close C_1 ;
      ElsIf l_mode = 2 then  close C_2 ;
      ElsIf l_mode = 3 then  close C_3 ;
      else RETURN ;
      end if;

      --Тело
      --l_fdat := null;-- LSO
      l_ir   := null;
      for z in (select rowid RI, x.* from tmp_T605 x where md = l_mode and nd= x_id order by g01)
      loop
         bars_audit.info('Z605_t001 z.g01 = '||z.g01||' z.g06= '||z.g06||' z.g04= '||z.g04);
           select -NVL( SUM( decode (a.tip,'SS ', fost(a.acc,z.g01), 0) ),0),
                  --case when z.G06 <> 0 and z.G06 = z.G04 then z.G06 else -NVL( SUM( decode (a.tip,'SP ', fost(a.acc,z.g01), 0) ),0) end,
                    -NVL( SUM( decode (a.tip,'SP ', fost(a.acc,z.g01), 0) ),0),
                   min( decode (a.tip,'SP ', DAT_SPZ(a.ACC,z.g01,0), null ))
           into  tt.g05, tt.g06, z_dat   from accounts a, nd_acc n     where n.nd = dd.nd and n.acc= a.acc and a.tip in ('SS ','SP ');
         bars_audit.info('Z605_t002 z.g01 = '||z.g01||' tt.g06= '||tt.g06);



           IF z_dat = z.g01 and z.g04 = 0 and tt.g06 > 0 and z.g03 = 0 THEN
            SELECT MIN (g01) - z_dat
              INTO tt.g07
              FROM tmp_t605
             WHERE g01 > z.g01 AND g04 > 0 AND nd = z.nd and ncol <> 4;
             --bars_audit.info('Z605_t0 z.g01 = '||z.g01||' tt.g07= '||tt.g07||' z_dat= '||z_dat);
           elsif tt.g06 > 0 and z.g03 > 0 and z_dat < z.g01 and z.ncol not in (1,4) then
                 SELECT (z.g01+1) - max (g01)
                  INTO tt.g07
                  FROM tmp_t605
                 WHERE g01 < z.g01 /*AND g04 > 0*/ AND g03 = 0 /*and g07 = 0*/ AND nd = z.nd;
              --bars_audit.info('Z605_t1 z.g01 = '||z.g01||' tt.g07= '||tt.g07||' z_dat= '||z_dat);
           elsif tt.g06 > 0 and z.g03 = 0 and z_dat < z.g01 and z.g04  = 0 and z.ncol = 4  then
              SELECT min (g01) - z.g01
              INTO tt.g07
              FROM tmp_t605
             WHERE g01 > z.g01  AND nd = z.nd;
             --bars_audit.info('Z605_t2 z.g01 = '||z.g01||' tt.g07= '||tt.g07||' z_dat= '||z_dat);



           elsif tt.g06 > 0 and z.g03 = 0 and z.g04 > 0  then
              SELECT min (g01) - z.g01
              INTO tt.g07
              FROM tmp_t605
             WHERE g01 > z.g01  AND nd = z.nd;
            -- bars_audit.info('Z605_t3 z.g01 = '||z.g01||' tt.g07= '||tt.g07||' z_dat= '||z_dat);



           elsif z.g03 > 0 and tt.g06 > 0 and z.ncol in (1,4)  then
              SELECT nvl(min (g01),trunc(sysdate)) - z.g01
              INTO tt.g07
              FROM tmp_t605
             WHERE g01 > z.g01  AND nd = z.nd;
            -- bars_audit.info('Z605_t4 z.g01 = '||z.g01||' tt.g07= '||tt.g07||' z_dat= '||z_dat);
           ELSE
            tt.g07 :=0;
           END IF;
           --tt.g07 := (z.g01+1) -z_dat ; --lso
           l_fdat := z.g01;
           If l_fdat is not null  then

              tt.g09 := null;

              If NVL ( p_IR, 0) =0  then -- базова ставка що є на рахунку простроченого тіла
                 begin select a.acc   into  x_Acc  from accounts a, nd_acc n where n.nd = dd.nd and n.acc = a.acc and a.tip in ('SP ')  and rownum =1 ;
                       l_ir := acrn.fprocn( x_acc, 2, l_fdat+1 ) ;
                       tt.g09 :=  get_sum_rate(tt.g06/100,l_ir,tt.g07,z.g01);
                       --bars_audit.info('Z605_t l_fdat = '||l_fdat||' l_ir= '||l_ir);
                       --acrn.p_int( acc_ =>  x_acc, id_ =>2,   dt1_ =>l_fdat,     dt2_ => z.g01+tt.g07,   int_ => tt.g09,    ost_ => NULL,   mode_ => 0 );
                       --bars_audit.info('Z605_t1 l_fdat = '||l_fdat||' z.g01= '||z.g01||' l_ir= '||l_ir||' tt.g09= '||tt.g09);
                       --select tt.g06*(g08/100/365)*tt.g07 into tt.g09 from tmp_t605 where rowid = z.RI;
                 EXCEPTION WHEN NO_DATA_FOUND THEN null;
                 end;
              else 
                 l_ir := p_ir;
                 tt.g09 :=  get_sum_rate(tt.g06/100,l_ir,tt.g07,z.g01);
              end if;

              If tt.g09 is null then
                 tt.g09 := calp_AR ( tt.g06,  l_ir, l_fdat, z.g01+tt.g07 , 0);  -- розрахункова пеня
                  bars_audit.info('Z605_t1_1 l_fdat = '||l_fdat||' z.g01= '||z.g01||' l_ir= '||l_ir||' tt.g09= '||tt.g09);
              end if;
              -- bars_audit.info('Z605_t1_2 l_fdat = '||l_fdat||' l_ir= '||l_ir||' tt.g09= '||tt.g09);
              tt.g11 :=   get_sum_rate(tt.g06/100,p_3,tt.g07,z.g01);
              --tt.g11 := calp_NR ( tt.g06,  p_3 , z.g01, z.g01+tt.g07 , 0);       --додатково 3%
                   bars_audit.info('Z605_t1_3 z.g01 = '||z.g01||' tt.g07= '||tt.g07||' p_3= '||p_3||' tt.g06= '||tt.g06||' tt.g11= '||tt.g11);
               if tt.g07 = 0 then
                tt.g09 :=0;
                tt.g11 :=0;
               end if;
           end if;
           --l_fdat := z.g01;-- LSO
           bars_audit.info('Z605_ttttt l_fdat = '||l_fdat||' l_ir= '||l_ir||' tt.g06= '||tt.g06||' tt.g07= '||tt.g07||' z.RI= '||z.RI);

           update tmp_t605 Set g05=tt.g05, g06=nvl(decode(tt.g06,0, z.g06,tt.g06),0), g07=tt.g07, g08=nvl(l_ir,0), g09=round(tt.g09,2), g10=p_3, g11= round(tt.g11,2) where rowid = z.RI;
           delete tmp_t605 where g06 = 0 and ncol = 4 and nd = z.nd;
      end loop; -- t

      -- проценты
      --l_fdat := null;-- LSO
      l_ir   := null;
      for z in (select rowid RI, x.* from tmp_p605 x where md = l_mode and nd= x_id order by g01)
      loop  select -NVL( SUM( decode (a.tip,'SN ', fost(a.acc,z.g01), 0) ),0),
                   --case when z.G06 <> 0 then z.G06 else -NVL( SUM( decode (a.tip,'SPN', fost(a.acc,z.g01), 0) ),0) end,
                   -NVL( SUM( decode (a.tip,'SPN', fost(a.acc,z.g01), 0) ),0),
                    min( decode (a.tip,'SPN', DAT_SPZ(a.ACC,z.g01,0), null ))
            into  pp.g05, pp.g06, z_dat    from accounts a, nd_acc n where n.nd = dd.nd and n.acc= a.acc and a.tip in ('SN ','SPN');

           if pp.g06 > 0 then
             SELECT min (g01) - z.g01
              INTO pp.g07
              FROM tmp_p605
             WHERE g01 > z.g01  AND nd = z.nd;
           elsIF z_dat = z.g01 and z.g04 = 0 and pp.g06 > 0 and z.g03 = 0 THEN
            SELECT MIN (g01) - z_dat
              INTO pp.g07
              FROM tmp_t605
             WHERE g01 > z.g01 AND g04 > 0 AND nd = z.nd and ncol <> 4;
             bars_audit.info('Z605_p0 z.g01 = '||z.g01||' pp.g07= '||pp.g07||' z_dat= '||z_dat);
           elsif pp.g06 > 0 and z.g03 > 0 and z_dat < z.g01 and z.ncol not in (1,4) then
                 SELECT (z.g01+1) - max (g01)
                  INTO pp.g07
                  FROM tmp_p605
                 WHERE g01 < z.g01 /*AND g04 > 0*/ AND g03 = 0 /*and g07 = 0*/ AND nd = z.nd;
              bars_audit.info('Z605_p1 z.g01 = '||z.g01||' pp.g07= '||pp.g07||' pp.g06 = '||pp.g06||' z.g03 = '||z.g03);
           elsif pp.g06 > 0 and z.g03 = 0 and z_dat < z.g01 and z.g04  = 0 and z.ncol = 4  then
             /* SELECT z.g01 - max (g01)
              INTO tt.g07
              FROM tmp_t605
             WHERE g01 < z.g01  AND nd = z.nd;*/
              SELECT min (g01) - z.g01
              INTO pp.g07
              FROM tmp_p605
             WHERE g01 > z.g01  AND nd = z.nd;
           elsif pp.g06 > 0 and z.g03 = 0 and z.g04 > 0  then
             /* SELECT (z.g01+1) - max (g01)
              INTO tt.g07
              FROM tmp_t605
             WHERE g01 < z.g01 and g06 = 0 AND nd = z.nd;*/
              SELECT min (g01) - z.g01
              INTO pp.g07
              FROM tmp_p605
             WHERE g01 > z.g01  AND nd = z.nd;
           elsif z.g03 > 0 and pp.g06 > 0 and z.ncol in (1,4)  then
              SELECT min (g01) - z.g01
              INTO pp.g07
              FROM tmp_p605
             WHERE g01 > z.g01  AND nd = z.nd;
           ELSE
            pp.g07 :=0;
           END IF;

           -- pp.g07 := (z.g01+1) -z_dat ; --lso
            l_fdat := z.g01;--LSO
           If l_fdat is not null  then

               pp.g09 := null;

               If NVL ( p_IR, 0) =0  then -- базова ставка що є на рахунку прострочених проц
                  begin select a.acc into    x_Acc  from accounts a, nd_acc n where n.nd = dd.nd and n.acc = a.acc and a.tip in ('SPN')  and rownum =1 ;
                        l_ir := acrn.fprocn( x_acc, 2, l_fdat ) ;
                       -- acrn.p_int( acc_ =>  x_acc, id_ =>2,   dt1_ =>l_fdat,     dt2_ => z.g01+pp.g07,   int_ => pp.g09,    ost_ => NULL,   mode_ => 0 );
                        pp.g09 :=  get_sum_rate(pp.g06/100,l_ir,pp.g07,z.g01);
                        if pp.g07 = 0 then
                        pp.g09 :=0;
                       end if;
                  EXCEPTION WHEN NO_DATA_FOUND THEN null;
                  end;
               else
                  l_ir := p_ir;
                  pp.g09 :=  get_sum_rate(pp.g06/100,l_ir,pp.g07,z.g01);
               end if;

               If pp.g09 is null then
                  pp.g09 := calp_AR ( pp.g06,  l_ir, l_fdat, z.g01+pp.g07 , 0);  -- розрахункова пеня
               end if;

               pp.g11 :=   get_sum_rate(pp.g06/100,p_3,pp.g07,z.g01);
               --pp.g11 := calp_NR ( pp.g06,  p_3 , l_fdat, z.g01+pp.g07 , 0);         --додатково 3%

               if pp.g07 = 0 then
                pp.g09 :=0;
                pp.g11 :=0;
               end if;
           end if;
            --l_fdat := z.g01;--LSO
           update tmp_p605 Set g05=case when pp.g06 > 0 then pp.g05+pp.g06 else pp.g05 end, g06=pp.g06, g07=pp.g07, g08=nvl(l_ir,0), g09=round(pp.g09,2), g10=p_3, g11=round(pp.g11,2)  where rowid = z.RI ;
           delete tmp_p605 where g06 = 0 and ncol = 4 and nd = z.nd;
          /* delete from tmp_p605 where (nd, g01, g06) in
             (select nd, g01, g06 from tmp_p605 where nd = z.nd and g06 > 0 group by nd, g01, g06 having count(*) > 1) and  ncol = 4;*/
      end loop; -- p
           delete from tmp_p605 where (nd, g01, g06) in
             (select nd, g01, g06 from tmp_p605 where nd = x_id and g06 > 0 group by nd, g01, g06 having count(*) > 1) and  ncol = 4;
           delete from tmp_p605 where (nd, g01, g04) in
             (select nd, g01, g04 from tmp_p605 where nd = x_id and g04 > 0 group by nd, g01, g04 having count(*) > 1) and  ncol = 3;
           delete from tmp_p605 where (nd, g01, g02) in
             (select nd, g01, g02 from tmp_p605 where nd = x_id and g02 > 0 group by nd, g01, g02 having count(*) > 1) and  ncol = 3;
      -- комиссия
      --l_fdat := null;--LSO
      l_ir   := null;
      for z in (select rowid RI, x.* from tmp_k605 x where md = l_mode and nd= x_id order by g01)
      loop select -NVL( SUM( decode (a.tip,'SK0', fost(a.acc, z.g01), 0) ),0),
                  -NVL( SUM( decode (a.tip,'SK9', fost(a.acc, z.g01), 0) ),0),
                   min( decode (a.tip,'SK9', DAT_SPZ(a.ACC,z.g01,0), null ))
           into  kk.g05, kk.g06, z_dat   from accounts a, nd_acc n where n.nd = dd.nd and n.acc= a.acc and a.tip in ('SK0 ','SK9');

           IF z_dat IS NOT NULL and z.g04 = 0 and kk.g06 > 0 THEN
            SELECT MIN (g01) - z_dat
              INTO kk.g07
              FROM tmp_k605
             WHERE g01 > z.g01 AND g04 > 0 AND nd = z.nd and ncol <> 4;
             bars_audit.info('Z605_p0 z.g01 = '||z.g01||' kk.g07= '||kk.g07||' z_dat= '||z_dat);
           ELSE
            kk.g07 :=0;
           END IF;

           --kk.g07 := (z.g01+1) -z_dat ; --lso
           l_fdat := z.g01;--LSO
           If l_fdat is not null then

              kk.g09 := null;

              If NVL ( p_IR, 0) =0  then -- базова ставка що є на рахунку простроченої комісії
                 begin select a.acc into    x_Acc  from accounts a, nd_acc n where n.nd = dd.nd and n.acc = a.acc and a.tip in ('SK9')  and rownum =1 ;
                       l_ir := acrn.fprocn( x_acc, 2, l_fdat ) ;
                       --acrn.p_int( acc_ =>  x_acc,  id_ =>2,   dt1_ =>l_fdat,     dt2_ => z.g01+kk.g07,   int_ => kk.g09,    ost_ => NULL,   mode_ => 0 );
                        kk.g09 :=  get_sum_rate(kk.g06/100,l_ir,kk.g07,z.g01);
                 EXCEPTION WHEN NO_DATA_FOUND THEN null;
                 end;
              else 
                 l_ir := p_ir;
                 kk.g09 :=  get_sum_rate(kk.g06/100,l_ir,kk.g07,z.g01);
              end if;

              If kk.g09 is null then
                 kk.g09 := calp_AR ( kk.g06,  l_ir, l_fdat, z.g01+kk.g07 , 0);  -- розрахункова пеня
              end if;

              kk.g11 := calp_AR ( kk.g06,  p_3 , l_fdat, z.g01+kk.g07 , 0);  --додатково 3%

           end if;
           --l_fdat := z.g01;--LSO
           update tmp_k605 Set g05=kk.g05, g06=kk.g06, g07=kk.g07, g08=nvl(l_ir,0), g09=round(kk.g09,2), g10=p_3, g11=trunc(kk.g11,2)  where rowid = z.RI ;
           delete tmp_k605 where g06 = 0 and ncol = 4 and nd = z.nd;
      end loop; -- k

      begin
           if l_mode = 1 then
            bars_audit.info('Z605.FRM INFLATION_ND_CCK l_id = '||l_id||' l_dat1='||l_dat1||' l_dat2 = '||l_dat2);
            REP_INFLATION_COURT.INFLATION_ND(l_id, to_char(l_dat1,'dd/mm/yyyy'), to_char(l_dat2,'dd/mm/yyyy'),1);
           elsif l_mode = 2 then
            bars_audit.info('Z605.FRM INFLATION_ND_ACC l_acc = '||l_acc||' l_dat1='||l_dat1||' l_dat2 = '||l_dat2);
            REP_INFLATION_COURT.INFLATION_ND(l_acc, to_char(l_dat1,'dd/mm/yyyy'), to_char(l_dat2,'dd/mm/yyyy'),0);
           elsif l_mode = 3 then
            bars_audit.info('Z605.FRM INFLATION_ND_BPK l_id = '||l_id||' l_dat1='||l_dat1||' l_dat2 = '||l_dat2);
            REP_INFLATION_COURT.INFLATION_ND(l_id, to_char(l_dat1,'dd/mm/yyyy'), to_char(l_dat2,'dd/mm/yyyy'),2);
           end if;

           /*begin
                   select count(1)
                     into l_count
                   from  tmp_inflation_court
                    where nd = l_id;
                  bars_audit.info('Z605.FRM INFLATION count '||l_count);

           end;*/

      EXCEPTION WHEN OTHERS THEN
         bars_audit.info('Z605.FRM INFLATION'||substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000));
      end;

  end p_ND;
  --------------------------------------------------------------------------
begin

  If NVL(p_mode, 0 ) = 0  then  l_mode := to_number( pul.get ('MOD_605' ) ) ; else l_mode := p_mode ; end if ;
  If NVL( p_id , 0 ) = 0  then  l_id   := to_number( pul.get ('ND_605'  ) ) ; else l_id   := p_id   ; end if ;
  If l_mode not in (1, 2, 3) or l_id   is null  then RETURN ;  end if   ;
  If NVL( p_KV , 0 ) = 0  then  l_KV   := to_number( pul.get ('KV_605'  ) ) ; else l_kv   := p_kv   ; end if ;
  If NVL( p_nls,'*') ='*' then  l_nls  :=            pul.get ('NLS_605' )   ; else l_nls  := p_nls  ; end if ;
  --------------------------------------------------------------
    EXECute immediate 'truncate table tmp_ani34 ' ;

delete from tmp_T605 where nd = l_Id and md = l_mode ;
delete from tmp_P605 where nd = l_Id and md = l_mode ;
delete from tmp_K605 where nd = l_Id and md = l_mode ;

  If    l_mode in ( 1, 3 )  then  p_ND  (l_id, l_mode, null  )  ;
  ElsIf l_mode in ( 2    )  then
     begin
        --select a.acc into l_acc from accounts a, nd_acc n where  n.nd = l_id and n.acc= a.acc and a.tip ='SS ' and a.kv = l_kv and a.nls = l_nls ;
        select a.acc into l_acc from accounts a where  a.kv = l_kv and a.nls = l_nls ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
       --raise_application_error(g_errn,'НЕ знайдено рах.SS='||l_kv||'/'||l_nls||' для дог '||l_id);
       raise_application_error(g_errn,'НЕ знайдено рахунок'||l_nls);
     end;
     p_ND  (l_id, l_mode, l_acc )  ;
  ElsIf l_mode = 3 then  RETURN; --p_BPK (l_id, l_mode)  ;
  end if;

  update tmp_t605 Set g02=g02/100, g03=g03/100, g04=g04/100, g05=g05/100, g06=g06/100, g09=g09, g11=g11 where nd = l_Id and md = l_mode;
  update tmp_p605 Set g02=g02/100, g03=g03/100, g04=g04/100, g05=g05/100, g06=g06/100, g09=g09, g11=g11 where nd = l_Id and md = l_mode;
  update tmp_k605 Set g02=g02/100, g03=g03/100, g04=g04/100, g05=g05/100, g06=g06/100, g09=g09, g11=g11 where nd = l_Id and md = l_mode;



end FRM;

---Аномимный блок --------------
begin null ;
END Z605;
/
