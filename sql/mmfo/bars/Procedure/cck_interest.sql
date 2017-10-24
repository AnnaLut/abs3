

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_INTEREST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_INTEREST ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_INTEREST (p_dat2 date) is
  l_dat2_curr date ; -- дата (текущая), по которую надо начислить проц.
  l_dat2_next date ; -- следующая  банк-дата
  l_dat2_prev date ; -- предыдущая банк-дата
  l_dat2_last date ; -- посл календарная дата в текущ месяце
  l_fdat_next date ; -- след.пл.дата по ГПК, которая меньше или равна следующей банк-дате
  l_Dat2      date ;
  l_count int := 0 ;
  ------------------------------
  fl_   int   := 0 ;
  nInt_ number     ; remi_ number ;
  oo oper%rowtype  ;
begin
  l_dat2_curr  := Nvl(p_Dat2, gl.Bdate        ) ;  -- дата, по которую надо начислить проц.
  l_dat2_next  := Dat_Next_U (l_dat2_curr,  1 ) ;  -- следующая банк-дата
  l_dat2_prev  := Dat_Next_U (l_dat2_curr, -1 ) ;  -- пред банк-дата
  l_dat2_last  := last_day   (l_dat2_curr     ) ;  -- посл календарная дата в текущ месяце

  l_Dat2       := l_dat2_curr ;
  If to_char( l_dat2_curr, 'yyyymm') < to_char( l_dat2_next, 'yyyymm' ) then
     fl_    := 1 ;
     l_dat2 := l_dat2_last ;
  end if;
-------------------------------------------------------------------------------------------------------------------------------

for P in (select d.ND, d.WDATE, a.tip, a.KV, a.NLS, d.VIDD, GREATEST ( NVL( i.acr_dat+1, a.daos), a.daos)  dat1,
                 i.acc,   i.id,  i.basey, i.basem, nvl(i.s,0) s,  i.acra, i.acrb , nvl(i.tt,'%%1') tt, i.ROWID RI
          from  int_accn i, accounts a, nd_acc n, cc_deal d
          where d.sos >= 10         and d.sos < 14         and d.vidd in (1,2,3,11,12,13 )
            and d.nd = n.nd         and n.acc = a.acc      and a.acc = i.acc and i.id = 0
            and  i.acra is not null and i.acrb is not null and i.acr_dat < l_dat2_curr
            and a.tip in ('SS ', 'SP ','CR9' )
         )
loop
   -------------------------------------------------- Шаг-1 = Начисление
   If fl_ = 1  then -- По 31 числам --
      If    p.Tip= 'SS ' and p.BASEY=2 and p.BASEM=1 then nInt_ := cck.FINT (p.ND, p.Dat1, l_dat2 ); -- начисление по ануитету
      else         acrn.p_int ( p.Acc, 0, p.Dat1, l_dat2, nInt_ , Null, 0 ); -- начисление банковское
      end if;
   elsIf p.tip = 'SP ' or p.WDATE <= l_dat2_curr then -- По просрочкам
      l_Dat2  := l_dat2_curr ;
      acrn.p_int (  p.Acc,0, p.Dat1, l_dat2, nInt_, Null, 0 ) ;
   Else    -- по промежуточные платедные даты
      select max(fdat) into l_fdat_next from cc_lim where nd = p.ND and fdat > l_dat2_curr+1 and fdat <=l_dat2_next;
      If l_fdat_next is not null then
         l_Dat2 := ( l_fdat_next - 1 ) ;
         If p.Tip= 'SS ' and p.BASEY=2 and p.BASEM=1 then nInt_ := cck.FINT (p.ND, p.Dat1, l_Dat2 ); -- начисление по ануитету
         else      acrn.p_int ( p.Acc, 0, p.Dat1, l_Dat2, nInt_ , Null, 0 ) ; -- начисление банковское
         end if;
      End if;
   end if;
   --------------------------------------------- Шаг-2 = Проводка
   SAVEPOINT do_OPL ;
   ------------------
   begin
      nInt_ := nInt_ + p.S   ; --\
      oo.s  := round (nInt_) ; ---| разница округлений для запоминания
      remi_ := nInt_ - oo.S  ; --/
      select kv, nls, substr(nms,1,38) into oo.kv , oo.nlsa, oo.nam_a from accounts where acc =  p.ACRA ;
      select kv, nls, substr(nms,1,38) into oo.kv2, oo.nlsb, oo.nam_b from accounts where acc =  p.ACRB ;
      If p.KV  <> oo.KV  then  -- вал ресурса HE = валюте нач.проц.
         oo.s := gl.p_Ncurval ( oo.kv ,  gl.p_icurval(p.KV, oo.s, gl.bdate) , gl.bdate) ;
      end if;
      UPDATE int_accN SET acr_dat = l_Dat2, s = remi_ WHERE rowid = p.RI ;
      If oo.s = 0 then  goto NextRec_ ; end if ;
      ------------------------------------------
      If    oo.KV  = oo.KV2     then oo.s2 := oo.s;
      ElsIf oo.KV2 = gl.baseval then oo.s2 := gl.p_icurval(oo.KV, oo.s, gl.bdate) ;
      else  oo.s2 := gl.p_Ncurval ( oo.kv2 ,  gl.p_icurval(oo.KV, oo.s, gl.bdate) , gl.bdate) ;
      end if;
      If   oo.s < 0 then oo.dk := 1 ;  oo.s := - oo.s ; oo.s2 := - oo.s2 ;
      Else               oo.Dk := 0 ;
      end if;
      oo.nazn := 'Нарах.%% по рах.'||p.Nls ||' з ' || to_char(p.Dat1,'dd.MM.yy') ||' по '||to_char(l_Dat2, 'dd.MM.yy') ||' вкл.';
      gl.ref (oo.REF);
      oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
      gl.in_doc3 (oo.REF, p.tt, 6, oo.nd, SYSDATE, gl.bdate, oo.dk,  oo.kv, oo.S , oo.kv2 ,oo.S2, null, gl.BDATE, gl.bdate,
                  oo.nam_a , oo.nlsa,  gl.aMfo , oo.nam_b , oo.nlsb,  gl.aMfo ,
                  oo.nazn  ,null, gl.aOkpo, gl.aOkpo, null, null, 1, null, null );
      gl.payv(0, oo.ref, gl.bdate, p.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.s2);
      gl.pay(2, oo.ref, gl.bdate);
      -- Вставка записи-истории о начислении процентов, если, в будущем будет необходимость СТОРНО или персчета процентов.
      ACRN.acr_dati ( p.ACC, p.ID , oo.REF,  ( p.Dat1-1 ), p.s );

  exception when others then  ROLLBACK TO do_OPL;
     declare  code_ NUMBER;   erm_ VARCHAR2(2048);  tmp_ VARCHAR2(2048);  status_ VARCHAR2(10);  l_recid number;
     begin    BARS_AUDIT.error ( p_msg     => 'CCK_INTEREST-err*'|| SQLERRM,
                                 p_module  => null,
                                 p_machine => null,
                                 p_recid   => l_recid
                                ) ;
             deb.trap(SQLERRM,code_,erm_,status_);
             IF code_<=-20000 THEN  bars_error.get_error_info( SQLERRM,erm_,tmp_,tmp_ );  END IF;
             -- l_txt := substr( l_txt ||l_recid||'*'|| erm_, 1, 70) ;
     end;
     goto NextRec_  ;
  end ;
  -------------------
  <<NextRec_>> null ;
  l_count  := l_count  + 1;
  If l_count  >= 200 then commit; l_count  := 0 ; end if;

end loop ; ----p
commit;
--------------------
end CCK_INTEREST;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_INTEREST.sql =========*** End 
PROMPT ===================================================================================== 
