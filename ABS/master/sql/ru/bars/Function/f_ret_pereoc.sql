
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_pereoc.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_PEREOC (dat_ in date, kodf_ in varchar2, kodp_ varchar2, 
        nbuc_ varchar2 default null, typ_ number default null) return number 
is
    pereoc_ number := 0;
begin
    select kor
    into pereoc_
    from (select nvl(sum(skor),0) kor, f_codobl_tobo(acc, typ_) nbuc
          from OTCN_ARCH_PEREOC
           where datf = dat_ and
                 kodf = kodf_ and
                 kodp like kodp_ || '%'
         group by f_codobl_tobo(acc, typ_))
    where typ_ is not null and
          (nbuc = nbuc_ and typ_ in ('1', '2', '4', '6') or
           typ_ = '0') or
           typ_ is null;         
    
    return pereoc_;
exception
    when no_data_found then 
        return 0;
end; 
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_pereoc.sql =========*** End *
 PROMPT ===================================================================================== 
 