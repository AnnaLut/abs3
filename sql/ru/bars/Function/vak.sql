
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vak.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VAK (nbs_ varchar2 ) RETURN number IS
    kol_  int :=0 ;
    OB22_ valuables.OB22%type ;
    tt_   tts.TT%type ;
begin
  begin
--logger.info('AAA - 1 '||gl.aREF);
    select k.ob22 into ob22_ from  operw w,  VALUABLES k
    where w.tag='VA_KC'  and w.value=k.ob22  and w.ref=gl.aREF;

--logger.info('AAA - 2 '|| ob22_);

    -- электронные лотореи
    select tt into tt_ from  oper where ref=gl.aRef;

--logger.info('AAA - 3 '|| tt_);

    If ob22_ like '____#_' and tt_ = 'VA3' then

--logger.info('AAA - 4 '|| ob22_);

       KOL_:=0;
    else
       select to_number(value) into kol_
       from operw where tag='VA_KK' and ref=gl.aRef;
    end if;

  EXCEPTION  WHEN NO_DATA_FOUND THEN null;
  end;

--logger.info('AAA - 5 '|| kol_);

  return kol_*100 ;

end vak;
/
 show err;
 
PROMPT *** Create  grants  VAK ***
grant EXECUTE                                                                on VAK             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VAK             to PYOD001;
grant EXECUTE                                                                on VAK             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vak.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 