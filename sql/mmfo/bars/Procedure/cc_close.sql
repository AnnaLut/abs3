

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_CLOSE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_CLOSE ***

  CREATE OR REPLACE PROCEDURE BARS.CC_CLOSE (custtype_ int,dat_ date) is
 err_ varchar2(4000); 
begin 
 for k in (select nd,cc_id from cc_deal where sos>=10 and sos<15 and wdate<dat_ and 
             ( (custtype_=2 and vidd in (1,2,3)) or (custtype_=3 and vidd in (11,12,13)) or (custtype_=0 and vidd in (1,2,3,11,12,13)))
                   
          ) 
 loop 
   cck.cc_close(k.nd,err_);
   if trim(err_) is null then   
      INSERT INTO cc_sob (ND,FDAT,ISP,TXT,otm) values (k.ND,gl.bDATE,gl.aUID,'Договор закрыт.' ,6);
   end if;   
 end loop;
end;
/
show err;

PROMPT *** Create  grants  CC_CLOSE ***
grant EXECUTE                                                                on CC_CLOSE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_CLOSE        to RCC_DEAL;
grant EXECUTE                                                                on CC_CLOSE        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_CLOSE.sql =========*** End *** 
PROMPT ===================================================================================== 
