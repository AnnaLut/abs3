
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_days_past_due.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DAYS_PAST_DUE (p_dat date, p_acc number, p_DEL number) RETURN integer is
-- Определение к-ва дней просрочки по счету (с учетом параметров просрочки по договору для кредитов)

/* Версия 4.3   20-02-2019  06-10-2017  10-03-2017  04-10-2016 (2) 22-08-2016 --  (1) 29-07-2016
   20-02-2019(4.3) - Для дебиторки учитывать s180  COBUSUPABS-7190(COBUSUPABS-7264)
   06-10-2017(4.2) - Балансовые счета через ф-цию rez_f_deb
   06-10-2017(4.1) - Ускорила расчет
   10-03-2017 - Попадала отчетная дата включительно
   05-10-2016 - Убрала ACCOUNTS в sum(s.kos)+s.FDAT BETWEEN l_daos AND p_dat (ускорилось)
   04-10-2016 - MDATE только для фин. дебиторки
   22-08-2016 - К-во дней визнання (параметр на счете для дебиторки)
   Расчет к-ва дней просрочки по счету
 */

l_nd    cc_deal.nd%type    ; l_tip   accounts.tip%type; l_nbs   accounts.nbs%type; l_daos  accounts.daos%type;
l_s180  specparam.s180%type;
l_ostc  number             ; l_KOS   number           ; l_kol   number           ; l_s180k number            ;
l_DATSP date               ; l_DASPN date             ; l_datvz date             ; l_mdate date              ;

begin
   if p_acc is not null THEN
      begin
         select - nvl(ost_korr(p_acc,p_dat,null,a.nbs),0), a.mdate, tip, nvl(nbs,substr(nls,1,4)), daos, s.s180
         into   l_ostc, l_mdate, l_tip, l_nbs, l_daos, l_s180
         from accounts a, specparam s where a.acc = p_acc and a.acc = s.acc (+);
      EXCEPTION WHEN NO_DATA_FOUND THEN l_kol := 0; l_ostc := 0; return l_kol;
      END;
      l_s180k := 0;
      if l_nbs<>'3710' and  rez_f_deb (l_nbs) in (1) THEN
         -- утверждено COBUSUPABS-7190(COBUSUPABS-7264)
         If    l_s180 is null then l_s180k :=    0 ;
         ElsIf l_s180 = '3'   then l_s180k :=    7 ;       -- Вiд   2 до 7 дня
         ElsIf l_s180 = '4'   then l_s180k :=   21 ;       -- Вiд   8 до 21 дня
         ElsIf l_s180 = '5'   then l_s180k :=   31 ;       -- Вiд  22 до 31 дня
         ElsIf l_s180 = '6'   then l_s180k :=   92 ;       -- Вiд  32 до 92 днiв
         ElsIf l_s180 = '7'   then l_s180k :=  183 ;       -- Вiд  93 до 183 днiв
         ElsIf l_s180 = '8'   then l_s180k :=  365 ;       -- Вiд 184 до 365(366) днiв
         ElsIf l_s180 = 'A'   then l_s180k :=  274 ;       -- Вiд 184 до 274 днiв
         ElsIf l_s180 = 'B'   then l_s180k :=  365 ;       -- Вiд 275 до 365(366) днiв
         ElsIf l_s180 = 'C'   then l_s180k :=  548 ;       -- Від 366(367) до 548(549) днiв
         ElsIf l_s180 = 'D'   then l_s180k :=  730 ;       -- Від 549(550) днів до 2 років
         ElsIf l_s180 = 'E'   then l_s180k := 1095 ;       -- Більше 2 до 3 років
         ElsIf l_s180 = 'F'   then l_s180k := 1826 ;       -- Більше 3 до 5 років
         ElsIf l_s180 = 'G'   then l_s180k := 3652 ;       -- Більше 5 до 10 років
         ElsIf l_s180 = 'H'   then l_s180k := 9999 ;       -- Понад 10 років
         else                      l_s180k :=    0 ;       -- мусор 
         End if;
      elsif l_nbs = '3710'    then l_s180k :=    5 ;
      end if;

      if rez_f_deb (l_nbs) = 2  THEN  -- хоз.дебиторка
         begin
            select  case when  regexp_like(value,'^(\d{2}.\d{2}.\d{4})$')
                    then to_date(value,'dd-mm-yyyy')
                    else to_date(value,'dd-mon-yyyy')
                    end  into l_datvz from accountsw aw where tag='DATVZ' and aw.acc=p_acc;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_datvz := null;
         end;
      end if;

      if    l_mdate is not null and rez_f_deb (l_nbs) = 1 THEN  l_KOL := greatest(0,p_DAT - l_mdate);
      elsif l_datvz is not null                           THEN  l_KOL := greatest(0,p_DAT - l_datvz);
      else
         If l_ostc >= 0 THEN l_KOL := 0;
            begin
               select max(n.nd) into l_nd from nd_acc n where acc = p_acc;
               if    l_tip   in ('SP ','SL ') THEN l_DATSP := to_date(cck_app.Get_ND_TXT(l_ND,'DATSP'),'dd/mm/yyyy');
                  if l_DATSP is not null      THEN l_KOL   := p_DAT - l_DATSP; return l_kol; end if;
               elsif l_tip   in ('SPN','SK9') THEN l_DASPN := to_date(cck_app.Get_ND_TXT(l_ND,'DASPN'),'dd/mm/yyyy');
                  if l_DASPN is not null      THEN l_KOL   := p_DAT - l_DASPN; return l_kol; end if;
               end if;
            EXCEPTION WHEN NO_DATA_FOUND  THEN NULL;
            END;
            -- узнаем сумму всех кредитовых оборотов
            select nvl(sum(s.kos),0) + p_del into l_KOS  from saldoa s where s.acc = p_acc and s.FDAT BETWEEN l_daos AND p_dat-1;
            for p in (select s.fdat,sum((case when fdat=(select min(fdat) from saldoa where acc=s.acc) then greatest(-s.ostf,s.dos)
                                         else s.dos end)) DOS
                      from   saldoa s
                      where  p_acc = s.acc and s.FDAT < p_DAT
                      group  by s.fdat
                      order  by s.fdat)
            loop
               l_KOS := l_KOS - p.DOS;
               If l_KOS < 0 THEN
                  l_KOL := greatest(0,p_DAT - (p.fdat+l_s180k));
                  EXIT;
               end if;
            end loop;
         else
            l_kol := 0;  -- пассивные счета - нет просрочки
         end if;
      end if;
   end if;
   return l_kol;
end;
/
 show err;
 
PROMPT *** Create  grants  F_DAYS_PAST_DUE ***
grant EXECUTE                                                                on F_DAYS_PAST_DUE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DAYS_PAST_DUE to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_days_past_due.sql =========*** En
 PROMPT ===================================================================================== 
 