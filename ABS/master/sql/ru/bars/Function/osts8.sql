
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/osts8.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OSTS8 (acc_  saldoa.acc%type,  d1_   saldoa.fdat%type,  d2_   saldoa.fdat%type ) return number IS
-- получение среднего остатка по saldoa
 s_ number := 0;  dm_ date;  dx_ date ; kd_ int; k1_ int; k2_ int; k3_ int;
begin
  -- ошибка
  If d1_ > d2_ then return 0; end if;
  -- одна дата
  If d1_ = d2_ then
     select ostf-dos+kos into s_ from saldoa   where acc  = acc_ and fdat = (select max(fdat) from saldoa where acc=acc_ and fdat<= d1_);
     RETURN s_;
  end if;
  -- период
  select min(fdat), max(fdat), count(*) into dm_, dx_ , kd_ from saldoa where acc = acc_ and fdat >= d1_ and fdat <= d2_;
  begin
    -- в периоде не было изменений
    If kd_ = 0 then
       select ostf-dos+kos into s_ from saldoa   where acc  = acc_   and fdat = (select max(fdat) from saldoa where acc=acc_ and fdat< d1_);
       RETURN s_;
    end if;
    k1_ := dm_ - d1_ ;  k2_ := d2_ - dx_ ;  k3_ := d2_ - d1_ + 1;
    -- в периоде было 1 изменение
    If KD_  = 1 then
       select ostf*k1_ + (ostf-dos+kos) *(k2_+1) into s_ from saldoa  where acc  = acc_  and fdat = dm_;
       RETURN   round ( S_ / k3_, 0 );
    end if;
    -- в периоде было более 1-го изменения
    select sum( CASE WHEN fdat= dm_ THEN ostf*(dm_ -d1_ )                             WHEN dm_< fdat and fdat<dx_ THEN ostf*(fdat-pdat)
                     WHEN fdat= dx_ THEN ostf*(fdat-pdat)+(ostf-dos+kos)*(d2_-dx_+1)  ELSE 0
                end  ) into s_ from saldoa  where acc= acc_ and fdat >= dm_ and fdat<= dx_;
    s_ := round ( S_ / k3_, 0 );
  EXCEPTION WHEN NO_DATA_FOUND THEN s_:=0;
  end;
  return nvl(s_,0);
end OSTS8;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/osts8.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 