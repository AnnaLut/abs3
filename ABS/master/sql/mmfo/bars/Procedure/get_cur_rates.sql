

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_CUR_RATES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_CUR_RATES ***

  CREATE OR REPLACE PROCEDURE BARS.GET_CUR_RATES (p_dat date)
is
  l_datp  cur_rates$base.vdate%type;
  l_bsum  cur_rates$base.bsum%type;
  l_rateo cur_rates$base.rate_o%type;
  l_rateb cur_rates$base.rate_b%type;
  l_rates cur_rates$base.rate_s%type;
begin
  -- временное решение для разметки курсов
  for b in
     (select b.branch, t.kv
	    from branch b, tabval t
	   where t.kv <> gl.baseval
	     and b.branch <> '/'
	   order by b.branch, t.kv)
  loop
    begin
      select c.vdate, c.bsum, c.rate_o, c.rate_b, c.rate_s
        into l_datp, l_bsum, l_rateo, l_rateb, l_rates
	    from cur_rates$base c
       where c.branch = b.branch
		 and c.kv = b.kv
	     and c.vdate =
		    (select max(r.vdate) from cur_rates$base R
			  where r.branch = b.branch
			    and r.kv = b.kv
                and r.vdate <= p_dat);
    exception
      when no_data_found then
        l_datp := null;
		l_rateo := null;
    end;

	if (p_dat != l_datp and l_datp is not null) then
       if l_rateb is null then l_rateb := l_rateo - 5; end if;
       if l_rates is null then l_rates := l_rateo + 5; end if;
       begin
         insert into cur_rates$base
           (kv, vdate, bsum, rate_o, rate_b, rate_s, branch)
         values
           (b.kv, p_dat, l_bsum, l_rateo, l_rateb, l_rates, b.branch);
       exception
          when dup_val_on_index then
             null;
       end;
	end if;

  end loop; -- b

end;

 
/
show err;

PROMPT *** Create  grants  GET_CUR_RATES ***
grant EXECUTE                                                                on GET_CUR_RATES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_CUR_RATES.sql =========*** End
PROMPT ===================================================================================== 
