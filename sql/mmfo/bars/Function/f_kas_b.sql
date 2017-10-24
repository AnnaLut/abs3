
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_kas_b.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KAS_B          (ref_ in NUMBER,stmt_ in NUMBER,nlsa_ in varchar2,dk_ in NUMBER)
 return varchar2 is
nlsb_ varchar2(15); -- определяет счет Б для кассовой проводки
                    -- 25-03-2003 QWA доработали для несимметричных бухмоделей
begin
  begin
    select nls into nlsb_ from
    (select b.nls
    from accounts a,opldok o,accounts b,opldok l
    where a.acc=o.acc and b.acc=l.acc
       and o.ref=ref_ and o.ref=l.ref
       and o.stmt=stmt_ and o.stmt=l.stmt
       and a.nls=nlsa_ and o.dk=dk_ and b.nls<>nlsa_ and l.dk<>dk_
    order by l.s desc) K where rownum=1;
  exception when NO_DATA_FOUND THEN nlsb_:='';
  end ;
 RETURN nlsb_;
end f_kas_b;
 
/
 show err;
 
PROMPT *** Create  grants  F_KAS_B ***
grant EXECUTE                                                                on F_KAS_B         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_KAS_B         to RPBN001;
grant EXECUTE                                                                on F_KAS_B         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_kas_b.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 