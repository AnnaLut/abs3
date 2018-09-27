

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KOL ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL (p_rnk integer, p_dat date, p_nd integer, p_acc integer) IS

/* Версия 1.0 30-09-2016
   Определение непогашенных остатков по счету
   -------------------------------------
*/

l_ostc  number ;  l_DATSP date;  l_nd    cc_deal.nd%type  ;
l_KOS   number ;  l_DASPN date;  l_tip   accounts.tip%type;
l_kol   number ;  l_datvz date;  l_nbs   accounts.nbs%type;
FL_     integer;  l_mdate date;

begin

   if p_acc is not null THEN
      begin
         select - nvl(ost_korr(p_acc,p_dat,null,a.nbs),0), a.mdate, tip, nvl(nbs,substr(nls,1,4))  into l_ostc, l_mdate, l_tip, l_nbs
         from accounts a where acc = p_acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_kol := 0; l_ostc := 0;
      END;

      If l_ostc >= 0 THEN l_KOL := 0;
         -- узнаем сумму всех кредитовых оборотов
         select nvl(sum(s.kos),0) into l_KOS  from  saldoa s,accounts a where  p_acc = a.acc and a.acc=s.acc and s.FDAT < p_dat;
         begin
            select l_kos-s into l_KOS from opldok where acc = p_acc and tt ='024' and dk=1 order by fdat;
         EXCEPTION WHEN NO_DATA_FOUND THEN null;
         end;
         for p in (--select s.fdat,sum((case when fdat=(select min(fdat) from saldoa where acc=a.acc) then greatest(-s.ostf,s.dos)
                   --                   else s.dos end)) DOS
                   --from   saldoa s,accounts a
                   --where  p_acc = a.acc and a.acc=s.acc and s.FDAT <= p_DAT
                   --group by s.fdat
                   --order by s.fdat
                   select fdat,sum(dos) dos 
                   from (select s.fdat fdat,case when fdat=(select min(fdat) from saldoa where acc=a.acc) then greatest(-s.ostf,s.dos)
                                            else s.dos end DOS
                         from   saldoa s,accounts a
                         where  a.acc = p_acc and a.acc=s.acc and s.FDAT < p_DAT
                         union  all 
                         select fdat, -s dos from opldok where acc = p_acc and tt ='024' and dk=0 order by fdat    
                        )
                   group by fdat
                   order by fdat
                  )
         loop
            FL_ := 0;
            l_KOS := l_KOS - p.DOS;
            If l_KOS < 0 THEN
               IF FL_ = 0 THEN
                  l_KOL := p_DAT - p.fdat;
                  FL_ := 1;
               end if;
               if FL_ = 1 THEN
                  update ND_KOL set dos = dos + p.dos where rnk= p_rnk and nd = p_nd and fdat = p.fdat;
                  if sql%rowcount=0 then
                     begin
                        insert into ND_kol (rnk, nd, fdat, dos) values (p_rnk, p_nd, p.fdat, p.dos);
                     exception when others then
                        --ORA-00001: unique constraint (BARS.XPK_CC_ACCP) violated
                       if SQLCODE = -00001 then
                          raise_application_error(-20000, 'ND_KOL dubl РНК'|| p_rnk || ' ND = '|| p_nd || ' Дата= ' || p.fdat);
                       else raise;
                       end if;
                     end;
                  end if;
               end if;
            end if;
         end loop;
      else
         l_kol := 0;  -- пассивные счета - нет просрочки
      end if;
   end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL.sql =========*** End *** ===
PROMPT ===================================================================================== 
