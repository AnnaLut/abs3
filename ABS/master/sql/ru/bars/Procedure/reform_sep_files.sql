create or replace procedure reform_sep_files
--
-- выполнение переформирования ночных фалов для текущего ММФО
--
is 

   l_trace     varchar2(1000) := 'reform_sep_files: ';
   l_count     number;
begin
   bars_audit.info(l_trace||'старт переформирования ночных файлов СЕП');

	
    bars_audit.info(l_trace||'блокировка прямых учасников');
	update lkl_rrp set blk=0 where blk=9;
	
	 select count(*) into l_count
     from banks 
	where mfop = gl.amfo 
	  and mfo <> gl.amfo 
	  and blk <> 0;
	
    bars_audit.info(l_trace||'заблокировано '||l_count||' прямых участников СЕП');
	
	for c in (select mfo from banks where mfop = gl.amfo and mfo <> gl.amfo order by mfo) loop
	   bars_audit.info(l_trace||'старт переформирования файлов для '|| c.mfo);
	   begin 
	      sep.pn_grc(c.mfo);
		  commit;
	   exception when others then
	      bars_audit.error(l_trace||'ошибка переформирования файлов для '|| c.mfo||': '|| sqlerrm);
		  bars_audit.error(l_trace||'участник СЕП с ММФО '||c.mfo||' будет заблокирован');
		  rollback;
          update lkl_rrp set blk = 3 where mfo = c.mfo;
		  commit;
	   end;
	   
	end loop;
	
end;
/

show err
grant execute on reform_sep_files to bars_access_defrole;