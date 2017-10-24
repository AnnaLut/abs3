
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/correctdate2.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CORRECTDATE2 ( KV_ int, OldDate_ date, Direct number:=1)
RETURN DATE is
dDat_ date;
n1_ Number;
nn_ Number:=1;
ed_ Number;
-- 0- сдвигать назад -1 сдв назад не вых за мес 1- сдв вперед 2 сдв вп не вых за мес
begin
  dDat_  := OldDate_;
  If Direct in (1,2) then  ed_:=1; else ed_:=-1; end if;
  While nn_=1
  loop
     begin
        SELECT count(kv) INTO nn_ FROM holiday
        WHERE kv= NVL(KV_,gl.baseval) and holiday=dDat_;
        dDat_:= dDat_ + ed_*nn_;
        dbms_output.put_line(dDat_);
     end;
  end loop;
  if Direct in (-1,2) and to_char(OldDate_,'mmyyyy')!=to_char(dDat_,'mmyyyy') then
     nn_:=1;
     dDat_  := OldDate_;
      While nn_=1
      loop
            SELECT count(kv) INTO nn_ FROM holiday
            WHERE kv= NVL(KV_,gl.baseval) and holiday=dDat_;
            dDat_:= dDat_ - ed_*nn_;
      end loop;
  end if;


 Return dDat_;
end CorrectDate2;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/correctdate2.sql =========*** End *
 PROMPT ===================================================================================== 
 