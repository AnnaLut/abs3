

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OBS_BPK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OBS_BPK ***

  CREATE OR REPLACE PROCEDURE BARS.OBS_BPK 
   (p_dat01     date,
    p_acc2207   number,
    p_acc2209   number,
    p_acc3579   number,
    p_acc2625   number,
    obs_bpk_    out number,
    kol_        out number) is

/* Версия 04-12-2015 (25-09-2015)
04-12-2015 Не считалось кол-во дней просрочки (исправлено)
           Добавлены счета для определения к-ва дней просрочки 3579,2625 < 0
 */

nbs_    varchar2 (4);
SP_     number;
i_      number;
acc_    number;
SUM_KOS number;
koln1_  number;
dat01_  date  := p_dat01;
dat31_  date  := Dat_last (dat01_ - 4, dat01_-1 ) ;  -- последний рабочий день месяца;
FDAT_   date  := p_dat01;
DAT_P   date  ;
OBS_    int   ;

begin

   i_      :=1;  obs_    :=1;   obs_bpk_:=1;   koln1_  :=0;

   while  i_<5
   loop
      if    i_=1 THEN  acc_:=p_acc2207;
      elsif i_=2 THEN  acc_:=p_acc2209;
      elsif i_=3 THEN  acc_:=p_acc3579;
      else             acc_:=p_acc2625;
      end if;
      kol_   := 0;
      if acc_ is not null THEN nbs_:='2207';
         SP_ := -nvl(ost_korr(acc_,dat31_,null,nbs_),0) ;
         If SP_>0 THEN  -- УЗНАЕМ НА СКОЛЬКО ДНЕЙ ПРОСРОЧЕНО
            KOL_ := 0;  DAT_P := DAT01_;
            -- узнаем сумму всех кредитовых оборотов
            select sum(s.kos)  into   SUM_KOS   from   saldoa s,accounts a where  acc_=s.acc and a.acc=acc_ and s.FDAT<=DAT31_;
            for p in (select s.fdat,sum((case when fdat=(select min(fdat) from saldoa where acc=a.acc) then greatest(-s.ostf,s.dos)
                                         else s.dos end)) DOS
                      from   saldoa s,accounts a
                      where  acc_=s.acc and a.acc=acc_ and s.FDAT<=DAT31_
                      group by s.fdat
                      order by s.fdat)
            loop
               SUM_KOS:= SUM_KOS - p.DOS;
               If SUM_KOS < 0 THEN DAT_P := p.FDAT; KOL_  := DAT01_- DAT_P;
                  EXIT;
               end if;
            end loop;
         else
            kol_:=0;
         end if;
         if KOL_ is not null THEN
            If    KOL_<= 7  then OBS_:=1;
            ElsIf KOL_<=30  then OBS_:=2;
            ElsIf KOL_<=90  then OBS_:=3;
            ElsIf KOL_<=180 then OBS_:=4;
            Else                 OBS_:=5;
            end if;
         end if;
         obs_bpk_:= greatest (obs_,obs_bpk_);
      end if;
      i_     := i_+1;
      koln1_ := greatest (kol_,koln1_);
   end loop;
   kol_ := koln1_;
end;
/
show err;

PROMPT *** Create  grants  OBS_BPK ***
grant EXECUTE                                                                on OBS_BPK         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OBS_BPK         to RCC_DEAL;
grant EXECUTE                                                                on OBS_BPK         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OBS_BPK.sql =========*** End *** =
PROMPT ===================================================================================== 
