

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_SCAN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_SCAN ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_SCAN (p_prod varchar2 ) is

/*
 --30.11.2015 Выполнение в дин.SQl-Продедур дополнительной бизнес-логики на КД при ежедневном сканировании  КП
 -- Добавлена финальная обработка ГРЕЙС-периода для SNO(ATO)
 -- From: Мешко Євгеній Іванович [mailto:MeshkoEI@oschadbank.ua]
 -- тел.: +380 (44) 249 31 43
*/

  n_Commit int := 100;  i_Commit int := 0;
  -- количество обработанных записей в курсоре для COMMIT; Это число должно быть подобрано эмпирически,
  -- Оно не д.б. слишком большим - чтобы не было очень больших транзакций. И  не дб слишком маленьк - чтобы время вып.процед не было очень большим.

  sSql_ varchar2(2000);
  g_Dat date    ;
  g_del int     := 5  ;
  g_acc number  ;
  g_Kv  number  ;
  g_Ref number  ;
  g_Err varchar2(252) ;
  title constant varchar2(32) := 'zbd.CCK_Scan ';
  l_error_message varchar2(4000);
begin
	
	logger.tms_info( title||'Start Додаткова щоденна бізнес-логіка продуктів КП');
	
  for k in (select d.nd, c.pFINIS , substr(d.prod,1, 6) PROD  from cc_deal d, cck_ob22 c
            where d.sos >= 10 and d.sos < 15 and d.vidd in (1,2,3,11,12,13) and substr(d.prod,1, 6) = c.nbS||c.ob22
           )
  loop

     -- Сканирование КД, у которых закончился грейс-перио
     begin select to_date(t.txt,'dd/mm/yyyy'), a.acc, a.kv, ad.refp
           into    g_Dat, g_Acc, g_Kv, g_Ref
           from nd_txt t, accounts a , nd_acc n, cc_add ad
           where t.tag = 'GRACE' and t.nd = n.nd and n.acc = a.acc and a.tip ='SNO' and ad.nd = n.nd and ad.nd=k.nd;

           If g_Dat > (gl.bdate - g_Del) and  g_Dat <= gl.Bdate then
              SNO.ADD31 (p_acc => G_acc, p_REF => G_REF, p_kv => g_kv, S_err => g_Err ) ;
              SNO.ADD32 (p_acc => G_acc, p_REF => G_REF, p_kv => g_kv, p_Del => g_Del ) ;
           end if ;

     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end;


     If k.pFINIS is not null and k.PROD like p_prod then
        sSql_ := 'begin ' ||  replace ( k.pFINIS, ':ND', to_char(k.ND) ) || '; end ; '  ;
        SAVEPOINT sp_before_CL;
        -----------------------
        begin execute  immediate sSql_ ; i_Commit := i_Commit + 1 ; If i_Commit >= n_Commit then  COMMIT; i_Commit := 0 ;   end if ;
        EXCEPTION  WHEN OTHERS THEN       --bars_audit.error('CCK_SCAN, проц.'|| k.pFINIS || ', КД='||k.nd|| '*' ||SQLERRM );
		  l_error_message := substr(sqlerrm||dbms_utility.format_error_backtrace(), 1, 4000);
          logger.tms_error( title||'проц.'|| k.pFINIS || ', КД='||k.nd|| chr(10) ||l_error_message);	
              ROLLBACK TO sp_before_CL ;
        end  ;
     end if  ;

  end loop   ;
	
	logger.tms_info( title||'Finish Додаткова щоденна бізнес-логіка продуктів КП');
	
exception when others 
	then 
		l_error_message := substr(sqlerrm||dbms_utility.format_error_backtrace(), 1, 4000);
    logger.tms_error( title||'exception: '|| chr(10) ||l_error_message);	 	 	
		
end CCK_Scan ;
/
show err;

PROMPT *** Create  grants  CCK_SCAN ***
grant EXECUTE                                                                on CCK_SCAN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_SCAN        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_SCAN.sql =========*** End *** 
PROMPT ===================================================================================== 
