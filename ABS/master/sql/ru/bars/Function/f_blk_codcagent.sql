
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_blk_codcagent.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BLK_CODCAGENT (nlsb_ NUMBER, kv_ NUMBER, codcagent_ number) return number is
 fl_ int := 0 ;
begin

  begin
    select 1
    into fl_
    from dual
    where  EXISTS (
                    select 1 from customer where rnk =(SELECT a.rnk
                   FROM accounts a
                   where  a.nls=to_char(nlsb_)
                    and a.kv=980
                    and a.kf = sys_context('bars_context','user_mfo')
                    )
                    and CODCAGENT in (2,4) );
                      exception when NO_DATA_FOUND then null;
  end;

  RETURN FL_;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_blk_codcagent.sql =========*** En
 PROMPT ===================================================================================== 
 