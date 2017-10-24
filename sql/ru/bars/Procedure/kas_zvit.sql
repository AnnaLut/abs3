

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KAS_ZVIT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KAS_ZVIT ***

  CREATE OR REPLACE PROCEDURE BARS.KAS_ZVIT ( mode_ int, p_dat date, TIP int) is
l_sql varchar2 (4000) ;
l_col_name varchar2 (4000) := ''' ''';
l_viem varchar2 (4000) ;
begin

l_sql :=  'SELECT unique
          branch,
          kodv, TO_CHAR (dat2, ''dd/mm/yyyy'') dat2,
          sum(nvl(kz.s, kz.kol)) over (partition by kz.dat2, kz.branch, kz.kv, kz.kodv) s_br_kv,
          idm  маршрут
     FROM v_kas_z kz
    WHERE vid = '||mode_||' AND   TO_CHAR ('||
	     case when tip = 0 then 'dat2'
		      when tip = 1 then 'vdat'
			  else 'dat2'
		 end
		 ||', ''dd/mm/yyyy'') = '''||TO_CHAR (p_dat, 'dd/mm/yyyy')||''' and sos >= 0 '||
		 case when tip = 0 then 'and vdat is null'
		      else null
		 end
		 ||' order by branch, kodv desc)
)';


for k in (select unique kodv as kodv from v_kas_z  where vid = mode_ and  (case when tip = 0 then dat2
		      when tip = 1 then vdat
			  else dat2
		 end) = p_dat and sos >=0)
loop
l_col_name := l_col_name ||', '''|| k.kodv||''''  ;
end loop;

l_viem := 'CREATE OR REPLACE FORCE VIEW kas_zvh as SELECT * FROM (select * from (select * from ('||l_sql||
                                        ') pivot (
                                            SUM(s_br_kv)
                                            FOR kodv IN
                                                    ( '||l_col_name|| ')
                                        )';
  begin
EXECute immediate l_viem;
     exception  when others then
        raise_application_error(-20100, 'Тело SQL=' || l_viem );
      end;

      begin
				EXECute immediate '
							GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.KAS_ZVH TO START1
								  ';
	  exception  when others then
        raise_application_error(-20100, 'Grant');
      end;

end  ;
/
show err;

PROMPT *** Create  grants  KAS_ZVIT ***
grant EXECUTE                                                                on KAS_ZVIT        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KAS_ZVIT        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KAS_ZVIT.sql =========*** End *** 
PROMPT ===================================================================================== 
