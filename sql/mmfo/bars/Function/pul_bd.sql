
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/pul_bd.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.PUL_BD return date is s_dat varchar2(10); l_dat date;
 begin
    
    s_dat := substr(  pul.GET ('BD') , 1 ,10 ) ;
   -- logger.info('XXXX1*'||s_dat||'*'); 
    
    If s_dat is null or length (s_dat) <>10 then l_dat := DAT_NEXT_U ( gl.bd, -1);
    else -- logger.info('XXXX2*'||s_dat||'*' );
    l_dat := to_date ( s_dat, 'dd.mm.yyyy');
    end if;
    
    --begin select f.fdat into l_dat  from fdat f where f.fdat =  l_dat;
    --EXCEPTION WHEN NO_DATA_FOUND THEN
    --logger.info('XXXX*'|| s_dat ) ;
     --l_dat := DAT_NEXT_U ( gl.bd, -1);
    --end;
    
    return l_dat;
 
 end PUL_BD;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/pul_bd.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 