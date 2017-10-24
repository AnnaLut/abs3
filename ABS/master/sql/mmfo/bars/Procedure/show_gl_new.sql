

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SHOW_GL_NEW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SHOW_GL_NEW ***

  CREATE OR REPLACE PROCEDURE BARS.SHOW_GL_NEW (DAT_ date, MOD_ int) is
  DOSR_ number;  KOSR_ number;
  DOSQ_ number;  KOSQ_ number;
  OSTD_ number;  OSTK_ number;
  ost_  number;

  type t1_ is table of tmp_show_gl%rowtype index by binary_integer;

  s_ t1_;

  i_ binary_integer:=0;

begin
  if MOD_ = 1 then RETURN; end if;
  ----------------------------------
  -- MOD_ = 0  - ком банк , т.е. работаем по saldo B

  delete from Bars.Tmp_Show_GL;



for k in
(
 select a.kv,a.nbs,nvl(s.ost,0) ost,nvl(s.dos,0) dos,nvl(s.kos,0) kos,a.acc,s.dapp
 from sal s , accounts a
 where s.acc(+)=a.acc
and s.fdat(+)=dat_ and a.nbs is not null)

loop
  DOSR_:=0; KOSR_:=0; DOSQ_:=0; KOSQ_:=0; OSTD_:=0; OSTK_ :=0; OST_:=0;

  if DAT_=gl.bdate then
     -- по accounts ост в номинале
     if    k.ost<0 then OSTD_:= - k.ost;
     elsIf k.ost>0 then OSTK_:=   k.ost;
     end if;
     -- по accounts обороты в номинале
     If k.dapp= gl.BDATE then DOSR_:= k.dos; KOSR_ :=k.kos;
     else                     DOSR_:= 0    ; KOSR_ :=0    ;
     end if;
  else
  OST_:=k.ost;DOSR_:=k.dos; KOSR_:=k.kos;
--     begin
--       -- фактичечкий остаток и реал обороты в номин
--       select ostf,dos,kos INTO OST_,DOSR_,KOSR_
--       from saldoa where acc=k.ACC and fdat= k.fdat;
       if OST_<0 then  OSTD_:=-ost_; OSTK_:=0;
       else            OSTK_:= ost_; OSTD_:=0;
       end if;
--     exception when NO_DATA_FOUND THEN ost_:=0;dosr_:=0;kosr_:=0;
--     end;
  end if;

  if k.kv = gl.BASEVAL then
     --по нац вал - все готово
     DOSQ_:= DOSR_; KOSQ_:=KOSR_;
  else
     --реальные обороты в экв
     DOSR_:= gl.p_icurval(k.kv, DOSR_, DAT_);
     KOSR_:= gl.p_icurval(k.kv, KOSR_, DAT_);
     if DAT_=gl.bdate then
        -- остатки исх в экв
        OSTD_:= gl.p_icurval(k.kv, OSTD_, DAT_);
        OSTK_:= gl.p_icurval(k.kv, OSTK_, DAT_);
        -- остатки вх в экв
        OST_:= OST_ +k.dos -k.KOS;
        OST_:= gl.p_icurval(k.kv, OST_, DAT_-1 ) -gl.p_icurval(k.kv, OST_, DAT_);
        If   OST_ <= 0 then DOSQ_:= DOSR_ - OST_; KOSQ_:= KOSR_;
        else                KOSQ_:= KOSR_ + OST_; DOSQ_:= DOSR_;
        end if;
     else
        begin
           -- фактичечкий остаток и ВСЕ обороты в экв
           select ost,dos,kos    INTO   OST_, DOSQ_, KOSQ_
           from salB where acc=k.ACC and fdat = DAT_;
           if ost_<0 then OSTD_:=-ost_; OSTK_:=0;
           else           OSTK_:= ost_; OSTD_:=0;
           end if;
        exception when NO_DATA_FOUND THEN
           OSTD_:=0; OSTK_:=0; OST_:=0; DOSQ_:=0; KOSQ_:=0;
        end;
     end if;
  end if;

  if DOSR_+KOSR_+DOSQ_+KOSQ_+OSTD_+OSTK_>0 then

 -- s_(k.nbs).dosr :=nvl(s_(k.nbs).dosr,0)+DOSR_;

s_(k.nbs).nbs:=k.nbs;
s_(k.nbs).dosr :=nvl(s_(k.nbs).dosr,0)+DOSR_;
s_(k.nbs).kosr :=nvl(s_(k.nbs).kosr,0)+kOSR_;
s_(k.nbs).dosq :=nvl(s_(k.nbs).dosq,0)+DOSq_;
s_(k.nbs).kosq :=nvl(s_(k.nbs).kosq,0)+kOSq_;
s_(k.nbs).ostd :=nvl(s_(k.nbs).ostd,0)+ostd_;
s_(k.nbs).ostk :=nvl(s_(k.nbs).ostk,0)+ostk_;

--     update  Bars.Tmp_Show_GL_new
--         set dosr=dosr + DOSR_,  kosr=kosr + KOSR_,
--             dosq=dosq + DOSQ_,  kosq=kosq + KOSQ_,
--             ostd=ostd + OSTD_,  ostk=ostk + OSTK_
--       where nbs=k.NBS;

--     if SQL%rowcount = 0 then
--        insert into  Bars.Tmp_Show_GL_new
--        (  nbs, DOSR , KOSR , DOSQ , KOSQ , OSTD , OSTK ) values
--        (k.nbs, DOSR_, KOSR_, DOSQ_, KOSQ_, OSTD_, OSTK_);
--     end if;

  end if;
end loop;

i_:=s_.first;

loop
        insert into  Bars.Tmp_Show_GL
        (  nbs, DOSR , KOSR , DOSQ , KOSQ , OSTD , OSTK ) values
        (s_(i_).nbs, s_(i_).dosr, s_(i_).kosr, s_(i_).dosq, s_(i_).kosq, s_(i_).ostd, s_(i_).ostk);

if i_ = s_.last then
exit;
end if;

i_:=s_.next(i_);

end loop;


end ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SHOW_GL_NEW.sql =========*** End *
PROMPT ===================================================================================== 
