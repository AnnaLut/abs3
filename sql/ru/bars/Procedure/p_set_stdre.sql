

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_STDRE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_STDRE ***

  CREATE OR REPLACE PROCEDURE BARS.P_SET_STDRE 
( p_sdate1 varchar2,
  p_sdate2 varchar2
)
  is


begin

  for x in (
                   select  o.vdat, o.nlsa, o.nlsb
                          from oper o
                         where o.sos = 5
                         and o.vdat > to_date(p_sdate1,'dd/MM/yyyy')
                         and o.vdat < to_date(p_sdate2,'dd/MM/yyyy')
                         and o.nlsa in
                         (
                         '37398903',
                         '37398300026700',
                         '37392301002563',
                         '37398000098003',
                         '37395000980030',
                         '37399100000503',
                         '37397000003',
                         '37393003001000',
                         '37395303',
                         '37393000980030',
                         '37399900001003',
                         '373920000003',
                         '37392000098031',
                         '373950036',
                         '37394916038',
                         '373990000003',
                         '37398900003',
                         '37392003',
                         '37395100000003',
                         '37395000000003',
                         '37394030000000',
                         '37396101015242',
                         '3739620003',
                         '37396005',
                         '37390000980130'
                         )
                          and nlsb like '2620%'

               )
    loop
             for y in       (select a.nls, d.nd from accounts a, nd_acc n, cc_deal d
                            where a.acc = n.acc
                            and a.nls = x.nlsb
                            and N.ND = d.nd
                            and substr(d.prod,1,6) in ('220257','220347','220258','220348'))
                    loop
                    cck_app.Set_ND_TXT(y.nd,'STDRE',x.vdat);
                    bars_audit.Info('cc.STDRE_nd = ' || y.nd || ', x.vdat = ' || x.vdat);
                    end loop;
    end loop;


end;
/
show err;

PROMPT *** Create  grants  P_SET_STDRE ***
grant EXECUTE                                                                on P_SET_STDRE     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SET_STDRE     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_STDRE.sql =========*** End *
PROMPT ===================================================================================== 
