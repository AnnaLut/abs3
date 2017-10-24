
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/correctdate.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CORRECTDATE ( KV_ int, OldDate_ date, EndDate_ date)
RETURN DATE is
dDat_ date;
n1_ Number;
nn_ Number;
ed_ Number;

begin
  dDat_:= OldDate_;
  If OldDate_ < EndDate_ then  ed_:=1; else ed_:=-1; end if;
  While 1<2
  loop
     begin
        SELECT kv INTO nn_ FROM holiday
        WHERE kv= NVL(KV_,gl.baseval) and holiday=dDat_;
        dDat_:= dDat_ + ed_;
     EXCEPTION WHEN NO_DATA_FOUND THEN Return dDat_;
     end;
  end loop;
end CorrectDate;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/correctdate.sql =========*** End **
 PROMPT ===================================================================================== 
 