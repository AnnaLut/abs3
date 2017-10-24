

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_PROLONG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_PROLONG ***

  CREATE OR REPLACE PROCEDURE BARS.CC_PROLONG 
(p_nd   int, -- выбор по всем КД =0, или по одному
 p_dat  date -- тек.дата
 ) is
  l_wdate_old  date;
  l_wdatl      date;
  l_sour       number;
  l_kprol      number;
  l_txt        varchar2(300);
  l_fio        varchar2(60);
  l_id         int;
  l_sos        int;
  l_S080_old     Varchar2(1);
begin
  begin
    select id, fio into l_id, l_fio from staff where logname = USER;
  exception
    when no_data_found then l_fio := '';
  end;

  for k in (select d.nd,c.mdate, d.vidd, d.sdate
              from cc_deal d, cc_prol c
             where ( p_nd = 0 OR p_nd = d.nd)
               and d.nd = c.nd
               and d.vidd in (1,2,3,11,12,13) and d.sos<15
               and c.dmdat = p_dat and c.dmdat is not null
               and c.npp = (select max(npp) from cc_prol where nd = d.nd and dmdat = c.dmdat and c.dmdat is not null)
  )
  loop
      SELECT d.wdate
           , ( select min(s.s080)
                 from nd_acc n,
                      accounts a,
                      specparam s
                where n.nd=k.nd and n.acc=a.acc
                  and a.tip in ('SS ','SP ','SPN','SN ') and a.acc=s.acc )
        INTO l_wdate_old, l_s080_old
        FROM cc_deal d
       WHERE d.nd=K.ND;

      if ( l_wdate_old <> k.mdate )
      then

          select sour into l_sour from cc_add where nd = k.nd;

          select NVL(kprolog,0)+1, sos
            into l_kprol, l_sos
            from cc_deal
           where nd = k.nd;

          if l_wdate_old < k.mdate
          then
            l_txt := 'Змiни КД: Збiльшення термiну закiнчення з '|| to_char(l_wdate_old,'dd/mm/yyyy') ||' на ' || to_char(k.mdate,'dd/mm/yyyy') || ' (вик.'|| l_id ||' ' || l_fio ||')';
          else
            l_txt := 'Змiни КД: Зменшення термiну закiнчення з '|| to_char(l_wdate_old,'dd/mm/yyyy') ||' на ' || to_char(k.mdate,'dd/mm/yyyy') || ' (вик.'|| l_id ||' ' || l_fio ||')';
          end if;

          update cc_deal
             set wdate = k.mdate
               , kprolog = l_kprol
           where nd = k.nd;

          for l in
          ( select n.acc, a.mdate, a.tip, a.nls, a.kv
              from accounts a,
                   nd_acc n
             where n.acc=a.acc
	      	     and n.nd = k.nd
	      	     and a.dazs is null
	      	     and a.mdate Is Not Null
               and a.tip in ('LIM','SS ','SN ','SP ','SPN','SL ','SLN','SDI','SPI','SG ','SK0','SK9','CR9','SN8','SNA','SNO' )
          )
          loop

            update accounts
               set mdate = case
                             when l.tip='SS '
                              and k.vidd in (2,3,12,13)
                              and mdate is not null
                              and mdate <> l_wdate_old
                              and mdate < k.mdate
                             then mdate -- дата погашення траншу не міняється якщо відкривалися рахунки на кожен транш (дибілізм ощада)
                             else k.mdate
                           end
             where acc = l.acc
         returning mdate
              into l_wdatl;

            BARS.CCK_SPECPARAM(l.acc,l.nls,l.kv,l.tip,l_sour,l_s080_old, k.sdate, l_wdatl, k.vidd, k.nd);

          end loop;

          if l_sos = 0
          then -- макети дог.
            update cc_prol set mdate = k.mdate
             where npp = 0 and nd = k.nd;
          elsif l_sos > 0 and l_sos < 15
          then -- діючі дог.
            update cc_prol set txt = l_txt
             where nd = k.nd and dmdat = bankdate and npp = l_kprol;
          end if;

        end if;

  end loop;

end CC_PROLONG;
/
show err;

PROMPT *** Create  grants  CC_PROLONG ***
grant EXECUTE                                                                on CC_PROLONG      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_PROLONG      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_PROLONG.sql =========*** End **
PROMPT ===================================================================================== 
