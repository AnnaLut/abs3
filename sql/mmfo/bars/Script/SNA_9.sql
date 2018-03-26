CREATE OR REPLACE PROCEDURE sna_9 IS  
      oo oper%rowtype ;  
      a9 accounts%rowtype; 
      S8 specparam%Rowtype;
--    x9 cck_ob22_9%rowtype;  
      nTmp_  int  ; l_cn int := 0;  
      L_dazs date ; 
begin oo.tt  := '024' ; 
      oo.vob := 6 ;  
      oo.ND  := 'SNA_MSFZ9'; 
      begin
         select count(*) into l_cn from sb_ob22 
         where R020 = '1509' and ob22 = '07' or  R020 = '1529' and ob22 = '15' or R020 = '2029' and ob22 = '15' or
               R020 = '2039' and ob22 = '11' or  R020 = '2069' and ob22 = '73' or R020 = '2079' and ob22 = '36' or 
               R020 = '2089' and ob22 = '39' or  R020 = '2109' and ob22 = '23' or R020 = '2119' and ob22 = '24' or 
               R020 = '2129' and ob22 = '39' or  R020 = '2139' and ob22 = '39' or R020 = '2209' and ob22 = 'J1' or 
               R020 = '2239' and ob22 = '70' ; 
         exception when no_data_found then  l_cn:=0;
      end;  
      if l_cn <>13 THEN 
         dbms_output.put_line( 'НЕ актуальний довідник SB_ob22 - '|| l_cn || '/13. Перенос SNA з ХХХ8 --> XXX9 НЕ ВИКОНАНО!' );
         return;                                                        
         --raise_application_error(-20000,'НЕ актуальний довідник SB_ob22 - '|| l_cn || '/13' );
      end if;

 foR MFO in (select * from mv_kf)
 loop bc.go( MFO.KF);  
      oo.mfoa := gl.aMfo  ;  
      oo.mfob := gl.aMfo  ;
      oo.vdat := gl.bdate ; 
      l_dazs  := DAT_NEXT_U(gl.bDate, 1) ;
      oo.ref  := null     ;
      ----------------------
      for a8 in ( select n.nd, a.* from accounts a, nd_acc n where n.acc = a.acc and a.tip ='SNA' and a.dazs is null and a.nbs like '___8' )
      loop  a9.nbs := substr(a8.nls,1,3) || '9';    ------- найти/открыть счет 2063 = SNA

          begin select a.* into a9 from accounts a, nd_acc n where n.acc = a.acc and a.tip ='SNA' and a.nbs = a9.nbs and n.nd = a8.ND and a.kv = a8.kv  and rownum = 1 ;
                If a9.dazs is not null then  update accounts set dazs = null where acc = a9.acc; end if;
          exception when no_data_found then  
                a9.nls := Vkrzn ( Substr( MFO.KF,1,5) , a9.nbs || '0' ||  substr(a8.nls,6,9)  ) ; 
                BEGIN SELECT 1 INTO nTmp_ FROM ACCOUNTS WHERE KV = A8.KV AND NLS = A9.NLS; 
                       While 1<2        
                       loop nTmp_ := trunc ( dbms_random.value (1, 999999999 ) ) ;
                             begin select 1 into nTmp_ from accounts where nls like a9.nbs||'_'||nTmp_  ;
                             EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ;
                             end;
                       end loop;         
                       a9.nls := vkrzn ( substr(gl.aMfo,1,5) , a9.nbs||'0'||nTmp_ );
                exception when no_data_found then  NULL;
                end ;
                op_reg_ex(mod_=>1, p1_=>a8.ND, p2_=>0, p3_=>a8.grp, p4_=>nTmp_, rnk_=>a8.rnk, nls_=>a9.nls, kv_=>a8.kv, nms_=>a8.nms, tip_=>a8.tip, isp_=> a8.isp, accR_=> a9.acc, tobo_=> a8.branch );
                --update accounts set pap = 2, mdat = a8.mdat  where acc = a9.aCC;
                --select   *   into a9 from accounts where acc = a9.acc;
          end;
          update accounts set pap = 2, mdate = a8.mdate  where acc = a9.aCC;
          select   *   into a9 from accounts where acc = a9.acc;

--коригування % доходів 1.xlsx
--Демкович Марія Степанівна <DemkovichMS@oschadbank.ua>
--Вт 06.03.2018 10:26

          If    a9.nbs = '1509' then a9.ob22 := '07' ;  ---- Надо добавить в скрипт по переносу SNA - счет 1509 с ОБ22=07 (Согласовано с Демкович МС)
          ElsIf a9.nbs = '1529' then a9.ob22 := '15' ;   
          elsIf a9.nbs = '2029'	then a9.ob22 := '15' ;
          elsIf a9.nbs = '2039'	then a9.ob22 := '11' ;
          elsIf a9.nbs = '2069'	then a9.ob22 := '73' ;
          elsIf a9.nbs = '2079'	then a9.ob22 := '36' ;
          elsIf a9.nbs = '2089'	then a9.ob22 := '39' ;
          elsIf a9.nbs = '2109'	then a9.ob22 := '23' ;
          elsIf a9.nbs = '2119'	then a9.ob22 := '24' ;
          elsIf a9.nbs = '2129'	then a9.ob22 := '39' ;
          elsIf a9.nbs = '2139'	then a9.ob22 := '39' ;
          elsIf a9.nbs = '2209'	then a9.ob22 := 'J1' ;
          elsIf a9.nbs = '2239'	then a9.ob22 := '70' ;
          else                       a9.ob22 := null ; 
          end if ;
          If a9.ob22 is not null THEN Accreg.setAccountSParam(a9.acc, 'OB22',  a9.ob22 ) ; end if;


/* 12.03.2018 
Вс 11.03.2018 15:06 Вікторія Семенова <viktoriia.semenova@unity-bars.com>

Пока предварительный (еще банк не подтвердил)  вариант такой :
1) при переносе остатков по SNA  со счетов БС=***8 на БС=***9  - сохранить(перенести)  ВСЕ доп.параметры со счета БС=***8
2) при открытии новых счетов SNA -  параметры S080, S180, S190, S240, S260, mDate, R011 - наследуем с 'SS ', 'SN ', 'SP ', 'SPN' (с одного из).
Параметр R013 - присваиваем значение "3"  для всех счетов - БС= 2209, 2239, 2069, 2089, 2079
*/
          delete from specparam where acc = a9.acc;
          begin select * into s8 from specparam where acc = a8.acc;    s8.acc := a9.acc ;    insert into specparam values s8;
          exception when no_data_found then  NULL;
          end ;

          -- перебросить остаток
          If A8.ostc <> 0 then

             If  A8.ostc > 0 then oo.dk := 1 ; oo.s :=  A8.ostc ;
             else                oo.dk := 0 ; oo.s := - A8.ostc ;
             end if ;
             --logger.info('SNA_0 1 : nls_9= ' || a9.nls || ' nls_8 = '|| a8.nls || ' dk = '|| oo.dk || ' oo.s = '|| oo.s || ' pap = '|| a9.pap) ;
             -- единый реф на все МФО
             if oo.ref is null then -- один реф на все МФО
                gl.ref (oo.REF);
                gl.in_doc3 (ref_ => oo.REF  , tt_  => oo.tt  , vob_ => oo.vob,   nd_ =>oo.nd  , pdat_ => SYSDATE, vdat_ =>  oo.vdat, dk_  => oo.dk,
                             kv_ => a8.kv   , s_   => oo.S   , kv2_ => a8.kv ,   s2_ =>oo.S   , sk_  =>   null  , data_ => gl.BDATE, datp_=>gl.bdate,
                           nam_a_=> Substr(a8.nms,1,38), nlsa_ => a8.nls, mfoa_ => gl.aMfo, 
                           nam_b_=> Substr(a9.nms,1,38), nlsB_ => a9.nls, mfoB_ => gl.aMfo, 
                           nazn_ => 'Зміна бал.рах. обліку НЕвизнаних проц.доходів згідно МСФЗ-9 ' ,
                           d_rec_=> null, id_a_ => gl.aOkpo, id_b_ =>gl.aOkpo ,id_o_ =>null, sign_ =>null,sos_=>1,prty_=>null,uid_=>null);
             end if;
             gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, a8.kv, a8.nls , oo.s, a8.kv, a9.nls, oo.s) ;
             update opldok set txt = 'Угода реф.' || a8.ND where ref = oo.ref and stmt = gl.astmt ;
             gl.pay (2, oo.ref, oo.vdat);  -- по факту

          end if; 
          update accounts set dazs = l_dazs  where acc = a8.aCC;
    end loop ;-- k 
    commit   ;
 end loop    ;  -- MFO
end sna_9    ;
/

--------------
/*
Внимание ! Перед выполнением этой процедуры справочник SB_ob22 должен быть актуальным, т.е. содержать в себе новые позиции
R020 = '1529', ob22 := '15' ;
R020 = '2029', ob22 := '15' ;
R020 = '2039', ob22 := '11' ;
R020 = '2069', ob22 := '73' ;
R020 = '2079', ob22 := '36' ;
R020 = '2089', ob22 := '39' ;
R020 = '2109', ob22 := '23' ;
R020 = '2119', ob22 := '24' ;
R020 = '2129', ob22 := '39' ;
R020 = '2139', ob22 := '39' ;
R020 = '2209', ob22 := 'J1' ;
R020 = '2239', ob22 := '70' ;
*/
exec sna_9   ;
/



--------------

