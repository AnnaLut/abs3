create or replace procedure AMOVE9 (p_ND number)  IS -- АВТО-ПЕРЕКЛАССИФИКАЦИЯ КД согласно доп.рекв. по вектору: от... до 01.01.2018 . далее - помесячно до 01.хх.2018

/*  
13.06.2018  – Спец.пар + ГПП

*/
  ----------------------
  procedure AMOVE1( p_ND_FROM number, p_TO_PROD varchar ) is -- процедура переклассификации актива
      d1  cc_deal%rowtype   ;   FF  cck_ob22%rowtype      ;  tt  cck_ob22%rowtype  ;    a8  accounts%rowtype ;    a2  accounts%rowtype ;
      SP  specparam%rowtype ;   SI  specparam_int%rowtype ;  CA  cc_add%rowtype    ;    i8  int_accn%rowtype ;    KK  K9%Rowtype  ; 
      a6  accounts%rowtype ;

      s_Err varchar2(100)   ;   p4_ int; s_DATVZ varchar2(10);  l_IFRS varchar2(20); n_POCI  int ;    acc_SN  number       ;
      ACC_SS number         ;   NBS_SS char(4)            ;      ACC_SP number     ;    IR_   number         ;

      function  Get_NLSX( p_NLS_old accounts.NLS%type,  p_KV accounts.KV%type, p_NBS_new accounts.NBS%type) return accounts.NLS%type IS  
            l_NLS_NEW accounts.NLS%type;   Fl_ int ;
      begin l_NLS_NEW := VKRZN ( Substr(gl.aMfo,1,5) , p_NBS_new ||'0'|| Substr (p_NLS_old,6,9) ) ;
            begin select 1 into fl_ from accounts where kv = p_KV and nls = l_NLS_NEW;
                  l_NLS_NEW := Get_NLS ( p_KV, p_NBS_new );
            exception when no_data_found then null;
            end;
            RETURN l_NLS_NEW ;
      end ;
      ----------------------
      procedure OB22(ax  accounts%rowtype ) is   sb sb_ob22%rowtype;
            GL_bdate        date; gl_aMFO varchar2(6); 
      begin  RETURN ;
         -----------------------------------------------
         GL_bdate := gl.Bdate; gl_Amfo := gl.Amfo ; 
         BC.go ('/') ;
         begin select * into sb from sb_ob22 where  r020||ob22 = ax.nbs||ax.ob22 ;
               If sb.D_OPEN > gl.bdate   then update sb_ob22 set D_OPEN  = GL_BDATE where  r020||ob22 = ax.nbs||ax.ob22 ;     end if ;
               If sb.d_close is not null then update sb_ob22 set d_close = null, 
                                                                 txt = (select name from ps where nbs = ax.NBS )  
                                                                                    where  r020||ob22 = ax.nbs||ax.ob22 ;     end if ;
         exception when no_data_found  then insert into sb_ob22 (r020,ob22,txt)   select nbs, ax.ob22, name from ps where nbs = ax.NBS;
         end;
         BC.go (gl_Amfo)  ;
      end ;

  begin 

     begin  
       s_Err := 'cck_ob22.BBBB.OO='||p_TO_PROD ;  select *   into tt from cck_ob22 where nbs||ob22 =      p_TO_PROD     and D_CLOSE is null ;
       s_Err := 'CC_DEAL.nd='      ||p_ND_FROM ;  select *   into d1 from cc_deal  where nd = p_ND_FROM and sos < 14  ;
       If D1.nd = d1.NDG then raise_application_error( -20333,'Не перекласифіковується ген.угода ' || s_Err ); end if ;
       s_Err := 'cck_ob22.BBBB.OO='||substr(d1.prod,1,6) ;  select *   into ff from cck_ob22 where nbs||ob22 = substr(d1.prod,1,6) and D_CLOSE is null ;
       s_Err := 'int_accn.8999*LIM' ;                       select a.* into a8 from accounts a, nd_acc n where n.nd = d1.nd and n.acc= a.acc and a.tip='LIM' ;
                                                            select *   into i8 from int_accn where acc = a8.acc and id = 0 ;
     exception when no_data_found then RETURN ; -- raise_application_error( -20333,'Не знайдено ' || s_Err );
     end;
   
     If ff.K9  = tt.k9  then RETURN ;  end if;  -- raise_application_error( -20333,'Корзина <FROM> = '||ff.k9  || ' та корзина <TO> = '|| tt.k9  || ' співпадають');  end if;
     If ff.NBS = tt.NBS then RETURN ;  end if;  -- raise_application_error( -20333,'Бал.рах <FROM> = '||ff.NBS || ' та Бал.рах <TO> = '|| tt.NBS || ' співпадають');  end if;

     begin select x.* into KK     from K9 x   where x.k9 = tt.k9;               exception when no_data_found then RETURN ;  end;   -- raise_application_error( -20333,'Не знайдено корзину № '|| tt.k9 || ' в довіднику K9');  end;
     begin select txt into l_IFRS from nd_txt where ND = d1.ND and tag ='IFRS'; exception when no_data_found then RETURN ;  end;   -- raise_application_error( -20333,'Не знайдено Дод.рекв <IFRS> для дог.'||d1.ND);  end;
     begin select decode (txt, 'Так',1, '1',1,0)  into n_POCI from nd_txt where ND = d1.ND and tag ='POCI'; exception when no_data_found then n_POCI := 0; end ;
  
     If kk.POCI <> n_POCI  or kk.IFRS <> l_IFRS then RETURN ;  end if ;   --     raise_application_error( -20333,'Дод.рекв дог.'||d1.ND || ' : IFRS='||l_IFRS|| ', POCI='||l_POCI|| '  НЕ відповідають корзині='||tt.k9 || ': IFRS='|| kk.IFRS || ', POCI='|| kk.POCI );       End if ;
     update cc_deal set prod = p_TO_PROD || substr( prod,7,20) where nd = d1.nd ;
     INSERT INTO cc_sob (ND,FDAT,ISP,TXT ,otm) VALUES (D1.ND, gl.bDATE, gl.auid,'Перекласифікація ' || d1.ND ,6);
   
     --Счета-довески 'SDI','SDF','SDM','SDA', 'SNA', 'SRR', 'REZ' предварительно онуляются.
     -- 01.01.2018 - процедурой облуления, а далее витриной FV
     for a1 in (select a.* from accounts a, nd_acc n 
                 where a.acc = n.acc 
                   and n.nd = d1.nd 
                   and (a.dazs is null OR  a.dazs > to_date ('01-01-2018','dd-mm-yyyy' ) ) 
                   and a.rnk =  d1.rnk 
                order by decode (a.tip, 'LIM', 0, 'SS ',1, 'SP ',2,  'SN ',3, 'SPN', 4, 5)
               )
     loop
         If a1.tip not in ('SS ','SP ','SN ','SPN','SNO','SDI','SNA' )  then     goto NEXT_ ;    end if; -- доп.счет
         If a1.tip = 'SNA' and tt.k9 = 3                                then     goto NEXT_ ;    end if;
         If a1.dazs >  to_date ('01-01-2018','dd-mm-yyyy' ) then update accounts set dazs = null where acc = a1.acc ;     end if ;

         If    a1.tip = 'SS ' then a2.NBS :=        tt.NBS           ; a2.ob22 := tt.ob22 ;
         ElsIf a1.tip = 'SP ' then a2.NBS :=        tt.NBS           ; a2.ob22 := tt.SP   ;
         ElsIf a1.tip = 'SN ' then a2.NBS := Substr(tt.NBS,1,3)||'8' ; a2.ob22 := tt.SN   ;                
         ElsIf a1.tip = 'SNO' then a2.NBS := Substr(tt.NBS,1,3)||'8' ; a2.ob22 := tt.SN   ;
         ElsIf a1.tip = 'SNA' then a2.NBS := Substr(tt.NBS,1,3)||'9' ; ---a2.ob22 := tt.SNA  ;
         ElsIf a1.tip = 'SPN' then a2.NBS := Substr(tt.NBS,1,3)||'8' ; a2.ob22 := tt.SPN  ;
         ElsIf a1.tip = 'SDI' then a2.NBS := Substr(tt.NBS,1,3)||'6' ; a2.ob22 := tt.SDI  ;
         else  a2.ob22 := null;
         end if ;

         a2.nls := Get_NLSX( A1.NLS, a1.KV, a2.NBS );

         a2.tip := a1.tip  ;
         a2.accc:= a1.accc ;

--1) открыть счет текущей датой
         Op_Reg_Ex( 1, d1.Nd, 0, a1.GRP, p4_, a1.RNK, a2.NLS, a1.kv, a1.NMS, a2.TIP, a1.ISP, a2.ACC,'1',NULL,NULL,NULL,NULL,NULL,NULL,null,NULL,NULL,NULL,null,a1.branch,NULL ) ;
         Update accounts set mdate = a1.mdate, accc = a1.accc where acc = a2.Acc;
         Update accounts set TIP = 'X'||SUBSTR(A1.TIP,2,2) where acc = a1.Acc;

--2) Установить ему об22
         If a2.ob22 is not  null then   
            --OB22(a2) ;  
            Accreg.setAccountSParam(a2.acc, 'OB22', a2.ob22 ) ;  
         end if;
         select * into a2 from accounts where acc = a2.acc;

-- 3) Наследовать проц.карточки
         If a1.tip in ('SS ','SP ')   then  
            NBS_SS := a2.NBS ;
            If a1.tip ='SS ' then  ACC_SS := a2.ACC ;
            Else                   ACC_SP := a2.ACC ;
            end if;

 -- Воспроизвести ВСЕ проц.карточки и ставки по SS + SP
            for ii in (select * from int_accn where acc = a1.acc)
            loop ii.acc := a2.acc; 
                  insert into int_accn values II ; 
                  IR_ := acrn.Fprocn ( a1.acc, ii.ID, gl.bdate)  ;
                  insert into int_RATN (acc, id, Bdat, IR) select a2.acc, ii.id, gl.Bdate, IR_ from int_Ratn where acc = a1.acc and id = ii.id and rownum = 1 ;
            end loop; -- ii
 -- Подобрать / открыть счет 6 клВоспроизвести ВСЕ проц.карточки по SS + SP            

            begin select nbs6  into a6.nbs from NBS_SS_SD where nbs2 = a2.nbs  ;
                  If a2.kv=980 then a6.ob22 :=  tt.SD_N;
                  else              a6.ob22 :=  tt.SD_I;
                  end if ;
            exception when no_data_found then a6.nbs := null;
            end ; 

            -- Найти счет 60*
            If a6.nbs is NOT null and a6.ob22 is NOT null then
               a6.nls := nbs_ob22_null (nbs_  => a6.nbs,  ob22_ => a6.ob22,  p_branch => substr( a2.branch,1,15) );

               If a6.nls is null then  -- открыть сче 6/7 кл
---               OB22 ( a6 ) ;
                  OP_BS_OB1( PP_BRANCH => substr( a2.branch,1,15), P_BBBOO => a6.nbs||a6.ob22) ;
                  a6.nls := nbs_ob22_null (nbs_  => a6.nbs,  ob22_ => a6.ob22,  p_branch => substr( a2.branch,1,15) );
               end if;
            end if;

            If a6.nls is not null then 
               select * into a6 from accounts where kv = gl.baseval and nls = a6.nls;     
            end if;

         end if; -- a1.tip in ('SS ','SP ')

         If a1.tip in ('SN ', 'SPN' )  then
            Update int_accn set acra = a2.ACC, acrB = a6.ACC  where acc in (ACC_SS, ACC_SP) and acra = a1.ACC and id = 0 ;
         end if ;

-- 4) Поменять ГПП
         If a1.tip in ('SN ', 'SNO')  then 
            update accounts set ostf = a1.ostf where   acc = a2.acc ;
            update accounts set ostf = 0       where   acc = a1.acc ;
            update opldok x set x.acc=a2.acc where x.acc=a1.acc and exists (select 1 from SNO_REF where nd=d1.nd and ref= x.REF) and x.sos=3 ; 
            If a1.tip = 'SNO' then
               update SNO_REF set acc = a2.acc where acc = a1.acc and nd = d1.ND ; 
               update SNO_GPP set acc = a2.acc where acc = a1.acc and nd = d1.ND ;
            end if; 
         end if;

-- 5) Наследовать Допреквизиты . Особенности  DATVZ
         -- Для вновь открываемых – я его расчитываю
         insert into ACCOUNTSW (ACC,TAG,VALUE) select   a2.acc, TAG,VALUE from ACCOUNTSW where acc = a1.acc  and tag <> 'DATVZ'; 
         If a1.tip in ( 'SP ', 'SPN') then 
            s_DATVZ := to_char( DAT_SPZ(a1.ACC,gl.Bdate,0), 'DD/MM/YYYY') ;
            insert into ACCOUNTSW (ACC,TAG,VALUE) values ( a2.acc, 'DATVZ' , s_DATVZ  ) ;
         end if;

--6) спецпарам ------------------------------------------------------
         begin select * into SP from specparam where acc = a1.acc; 
               sp.acc := a2.acc ;
               begin select R011_NEW, R013_NEW  into sp.R011, SP.R013 
                     from   RECLASS9_SPEC
                     where  R020_new = a2.nbs and R020_OLD = a1.NBS and R011_OLD = sp.R011 and  R013_old = SP.R013  ;


               exception when no_data_found then 
                    If    a2.nbs ='2390' then If sp.r011='2' then sp.r011 := '1'; elsif  sp.r011='3' then sp.r011 := '2'; end if;
                    ElsIf a2.nbs ='2394' then if sp.r011='1' then sp.r011 := '7'; end if ;
                    ElsIf a2.nbs ='2395' then If sp.r011='1' then sp.r011 := '8'; elsif  sp.r011='2' then sp.r011 := '9'; end if;
                    ElsIf a2.nbs ='2396' then If sp.r011='2' then sp.r011 := '1'; elsif  sp.r011='3' then sp.r011 := '2'; end if;
                    ElsIf a2.nbs ='2398' then If sp.r011='1' then sp.r011 := '8'; elsif  sp.r011='2' then sp.r011 := '9'; end if;
                    ---------------------------------------------------------------------------------------------------------------
                    ElsIf a2.nbs ='2043' then If sp.r011='2' then sp.r011 := '5'; elsif  sp.r011='3' then sp.r011 := '6'; end if;
                    ElsIf a2.nbs ='2046' then If sp.r011='2' then sp.r011 := '5'; elsif  sp.r011='3' then sp.r011 := '6'; end if;      
                    ElsIf a2.nbs ='2048' then If sp.r011='2' then sp.r011 := '5'; elsif  sp.r011='3' then sp.r011 := '6'; end if;      
                    ElsIf a2.nbs ='2044' then if sp.r011='1' then sp.r011 := '7'; end if ;
                    ElsIf a2.nbs ='2045' then If sp.r011='1' then sp.r011 := '2'; elsif  sp.r011='2' then sp.r011 := '9'; end if;
                    ---------------------------------------------------------------------------------------------------------------
                    ElsIf a2.nbs ='2141' then If sp.r011='1' then sp.r011 := '4'; elsif  sp.r011='2' then sp.r011 := '5'; end if;
                    ElsIf a2.nbs ='2142' then If sp.r011='1' then sp.r011 := '6'; elsif  sp.r011='2' then sp.r011 := '7'; elsif  sp.r011='3' then  sp.r011 := '8';  end if;
                    ElsIf a2.nbs ='2243' then If sp.r011='1' then sp.r011 := '4'; elsif  sp.r011='2' then sp.r011 := '5'; elsif  sp.r011='3' then  sp.r011 := '6';  end if;
                    ElsIf a2.nbs ='2143' then If sp.r011='1' then sp.r011 := '9'; elsif  sp.r011='2' then sp.r011 := 'A'; end if;
                    end if;
               end ; 
               ---------------------------------------------------------------------------------------------------------------
               Delete from specparam where  acc = sp.acc ;
               insert into specparam values sp ;
         exception when no_data_found then null;
         end ; 

--7) спецпарам INT
         begin select * into SI from specparam_int where acc = a1.acc; 
               SI.acc := a2.acc  ;  
               si.ob22:= a2.ob22 ;
               delete from specparam_int where acc = si.acc ;
               insert into specparam_int values SI ;
         exception when no_data_found then null;
         end ; 
-- 8) Связываем счет сo старым  КД 
         insert into nd_acc(nd, acc) select  D1.nd,a2.acc from dual where not exists (select 1 from nd_acc where nd= d1.nd and acc=a2.acc) ;
      
         <<NEXT_>>  null;
     end loop ; ---a1
   end ;
-------------------- 
begin    bc.go ('300465' ) ;  
  If gl.aMfo <> '300465' then RETURN; end if;
  -------------------------------------------
  FOR k in ( select x.ND, x.PROD, x.IFRS, x.POCI ,  FN_K9 (x.IFRS, x.POCI)  kk9, r.TO_K9 , r.TO_PROD 
             From RECLASS9 r,  
                 (select d.ND, d.prod, t.txt IFRS,  NVL( (select decode (txt, 'Так',1, '1',1,0)  from nd_txt  where tag = 'POCI' and nd = d.nd), 0) POCI
                  from (select * from nd_txt  where tag = 'IFRS') t,
                       (select * from cc_deal where vidd in (1, 2, 3) and sos >=10 and sos<=14 and p_ND in ( 0, nd)  ) d 
                  where d.nd = t.nd    
                  ) x   
             where FN_K9 (x.IFRS, x.POCI) = r.TO_K9  and r.FROM_PROD  = Substr(x.prod,1,6)   
           )
  loop AMOVE1 ( k.ND, k.to_PROD );  end loop; -- процедура переклассификации актива  

end AMOVE9;
/
show err;
grant execute on AMOVE9 to BARS_ACCESS_DEFROLE;
grant execute on AMOVE9 to RCC_DEAL;
grant execute on AMOVE9 to START1;
