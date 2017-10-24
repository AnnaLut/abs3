
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_rez_kat.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_REZ_KAT (acc_ number, rnk_ in number, nd_ number, datr_ date) return varchar2
is
    s080_ varchar2(1);
begin
    if datr_ >= to_date('01022017','ddmmyyyy')
    then
       if nd_ is not null then
          select nvl(max(s080),'0')
          into s080_
          from nbu23_rez s
          where s.fdat = datr_ and
                s.id not like 'DEB%' and
                s.rnk = rnk_ and
                s.nd = nd_;
       else
          select nvl(max(s080),'0')
          into s080_
          from nbu23_rez s
          where s.fdat=datr_ and
                s.id not like 'DEB%' and
                s.rnk = rnk_ and
                s.nd = acc_;
       end if;
    else
       if nd_ is not null then
          select nvl(max(kat),'0')
          into s080_
          from nbu23_rez s
          where s.fdat = datr_ and
                s.id not like 'DEB%' and
                s.rnk = rnk_ and
                s.nd = nd_;
       else
          select nvl(max(kat),'0')
          into s080_
          from nbu23_rez s
          where s.fdat=datr_ and
                s.id not like 'DEB%' and
                s.rnk = rnk_ and
                s.nd = acc_;
       end if;
    end if;

    return NVL(s080_,'0');
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_rez_kat.sql =========*** End 
 PROMPT ===================================================================================== 
 