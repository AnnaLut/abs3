PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_OTC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KOL_OTC ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_OTC (p_rnk integer, p_dat date, p_nd integer, p_acc integer) IS

/* ������ 1.0 10-01-2018
   ���������� ������������� ������� �� �������
   -------------------------------------
*/

l_ostc  number ;  l_DATSP date;  l_nd    cc_deal.nd%type  ;
l_KOS   number ;  l_DASPN date;  l_tip   accounts.tip%type;
l_kol   number ;  l_datvz date;  l_nbs   accounts.nbs%type;
FL_     integer;  l_mdate date;
l_kor   INTEGER;  l_dat31 date; 

begin
   l_dat31 := Dat_last_work (p_dat - 1);  -- ��������� ������� ���� ������
   if trunc(p_dat,'MM') = p_dat     THEN l_kor := 1; 
   elsif    p_dat >= trunc(sysdate) THEN l_kor := 2;
   else                                  l_kor := 0;
   end if;
   --logger.info('REZ_nd_otc 2 : nd = ' || p_nd || ' l_ostc = '|| l_ostc || 'p_acc = ' || p_acc) ;
   if p_acc is not null THEN
      begin
         select - nvl(decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat) ),0), a.mdate, tip, nvl(nbs,substr(nls,1,4))  into l_ostc, l_mdate, l_tip, l_nbs
         from accounts a where acc = p_acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_kol := 0; l_ostc := 0;
      END;
      If l_ostc >= 0 THEN l_KOL := 0;
         -- ������ ����� ���� ���������� ��������
         select nvl(sum(s.kos),0) into l_KOS  from  saldoa s,accounts a where  p_acc = a.acc and a.acc=s.acc and s.FDAT <= p_dat;
         for p in (select s.fdat,sum((case when fdat=(select min(fdat) from saldoa where acc=a.acc) then greatest(-s.ostf,s.dos)
                                      else s.dos end)) DOS
                   from   saldoa s,accounts a
                   where  p_acc = a.acc and a.acc=s.acc and s.FDAT <= p_DAT
                   group by s.fdat
                   order by s.fdat)
         loop
            FL_ := 0;
            l_KOS := l_KOS - p.DOS;
            If l_KOS < 0 THEN
               IF FL_ = 0 THEN
                  l_KOL := p_DAT - p.fdat;
                  FL_ := 1;
               end if;
               if FL_ = 1 THEN
                  update ND_KOL_otc set dos = dos + p.dos where rnk= p_rnk and nd = p_nd and fdat = p.fdat;
                  if sql%rowcount=0 then
                     begin
                        insert into ND_kol_otc (rnk, nd, fdat, dos) values (p_rnk, p_nd, p.fdat, p.dos);
                     exception when others then
                       if SQLCODE = -00001 then
                          raise_application_error(-20000, 'ND_KOL_otc dubl ���'|| p_rnk || ' ND = '|| p_nd || ' ����= ' || p.fdat);
                       else raise;
                       end if;
                     end;
                  end if;
               end if;
            end if;
         end loop;
      else
         l_kol := 0;  -- ��������� ����� - ��� ���������
      end if;
   end if;
end;
/
show err;
PROMPT *** Create  grants  p_kol_cck_otc ***
grant EXECUTE   on  P_KOL_OTC  to BARS_ACCESS_DEFROLE;
grant EXECUTE   on  P_KOL_OTC  to RCC_DEAL;
grant EXECUTE   on  P_KOL_OTC  to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_OTC.sql =========*** End *** ===
PROMPT ===================================================================================== 
