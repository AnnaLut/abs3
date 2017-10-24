

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ARJK_DATF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ARJK_DATF ***

  CREATE OR REPLACE PROCEDURE BARS.P_ARJK_DATF 
(p_id  varchar2,  -- код пулу
 p_dat date,
 p_isp  int,
 p_mode int   -- =0 только протокол, =1 - протокол с проводками
 )
Is

 -- Разделение начисленных проц от даты финансирования до отчетной по заданному пулу
 l_datf date;
 l_dat1 date;            -- Дата нач нач проц
 l_dat2 date;            -- дата кон нач проц
 l_int  number;          --сумма расчетных процентов
 BBBBoo_ varchar2(6);
 oo oper%rowtype    ;
 ss accounts%rowtype;
 a6 accounts%rowtype;
 b6 accounts%rowtype;

begin
 EXECUTE IMMEDIATE 'truncate table CCK_AN_TMP_UPB';
 begin  select datf into l_datf from arjk where id = to_number(p_id) and datf is not null;
 exception when no_data_found then   raise_application_error(-20203,'HE знайдено пул '|| p_id || ' з датою фiнансування', TRUE);
 end;
 oo.nazn :=  'Перерахування нарахованих доходiв, які передані АРЖК до Пулу № '|| p_id||
             ', починаючи з ' || to_char(l_datf,'dd.mm.yyyy') || ', на валові доходи банку';

 -------------------
 for k in (SELECT d.branch, d.nd,  d.cc_id,   d.sdate,  d.wdate, d.rnk,   a.kv,  a.acc,
                  TO_DATE( cck_app.get_nd_txt (d.nd, 'DINDU'),'dd/mm/yyyy') DINDU,
                  to_date( cck_app.get_nd_txt (d.nd, 'DO_DU'),'dd/mm/yyyy') DO_DU
           FROM cc_deal d,  nd_acc n,   accounts a ,  (select nd from nd_txt where tag ='ARJK' and  txt = p_id) t
           WHERE d.nd = n.nd  AND n.acc = a.acc  AND a.tip = 'LIM' and d.nd = t.nd
          )

 loop
    l_dat1 := greatest (     k.DINDU       , l_datf );              -- Дата нач нач проц
    l_dat2 := least    ( nvl(k.DO_DU,p_dat), p_dat  );   -- дата кон нач проц

    acrn.p_int( acc_ =>k.acc, id_ =>0,  dt1_ =>l_dat1,  dt2_ =>l_dat2, int_ =>l_int, ost_ =>NULL, mode_ =>0);
    l_int  := -round(l_int,0);
    ---------------------------------------
    If l_int <= 0 then goto RecNext; end if;

    If p_mode = 1 then
       begin
          select   * into ss from accounts               where tip   ='SS ' and acc in (select acc from nd_acc where nd = k.nd);
          select a.* into b6 from int_accn i, accounts a where i.acrb=a.acc and i.acc=ss.acc and i.id = 0;
          If    b6.nls like '6046%' then  oo.nlsa := nbs_ob22_null (b6.nbs, '65', b6.branch);
          ElsIf b6.nls like '6042%' then  oo.nlsa := nbs_ob22_null (b6.nbs, 'F5', b6.branch);
          elsIf b6.nls like '6111%' then  oo.nlsa := nbs_ob22_null (b6.nbs, '37', b6.branch);
          else  goto RecNext;
          end if;
          select * into a6 from accounts where kv=b6.kv and nls =oo.nlsa;
       exception when no_data_found then goto RecNext;
       end;
       gl.ref (oo.REF);
       gl.in_doc3( oo.ref, '013', 6, substr(to_char(oo.REF),1,10), SYSDATE , gl.BDATE, 1,  a6.kv, l_int, b6.kv,l_int, null,
                   gl.BDATE, gl.bdate, substr(a6.nms,1,38) , a6.nls, gl.aMfo, substr(b6.nms,1,38),  b6.nls, gl.aMfo,
                   oo.nazn, null, null, null, null, null,1, null, p_isp  );
       gl.payv( 0, oo.ref , gl.bDATE , '013', 1    , a6.kv, a6.nls, l_int, b6.kv, b6.nls, l_int );
    end if;

    insert into  s_ARJK_DATF( TOBO,   CC_ID,   SDATE,   WDATE,   RNK,  IN_DAT,  OUT_DAT, S     , nls   , name)
                 values ( k.branch, k.cc_id, k.sdate, k.wdate, k.rnk, k.DINDU, k.DO_DU , l_int , a6.nls, b6.nls ) ;
     <<RecNext>> null;
 end loop;

end  P_ARJK_DATF  ;
/
show err;

PROMPT *** Create  grants  P_ARJK_DATF ***
grant EXECUTE                                                                on P_ARJK_DATF     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ARJK_DATF     to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ARJK_DATF.sql =========*** End *
PROMPT ===================================================================================== 
