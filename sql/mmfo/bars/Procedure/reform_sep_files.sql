

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REFORM_SEP_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REFORM_SEP_FILES ***

  CREATE OR REPLACE PROCEDURE BARS.REFORM_SEP_FILES 
--
-- ���������� ���������������� ������ ����� ��� �������� ����
--
is

   l_trace     varchar2(1000) := 'reform_sep_files: ';
   l_count     number;
begin
   bars_audit.info(l_trace||'����� ���������������� ������ ������ ���');


    bars_audit.info(l_trace||'���������� ������ ���������');
	update lkl_rrp set blk=0 where blk=9;

	 select count(*) into l_count
     from banks
	where mfop = gl.amfo
	  and mfo <> gl.amfo
	  and blk <> 0;

    bars_audit.info(l_trace||'������������� '||l_count||' ������ ���������� ���');

	for c in (select mfo from banks where mfop = gl.amfo and mfo <> gl.amfo order by mfo) loop
	   bars_audit.info(l_trace||'����� ���������������� ������ ��� '|| c.mfo);
	   begin
	      sep.pn_grc(c.mfo);
		  commit;
	   exception when others then
	      bars_audit.error(l_trace||'������ ���������������� ������ ��� '|| c.mfo||': '|| sqlerrm);
		  bars_audit.error(l_trace||'�������� ��� � ���� '||c.mfo||' ����� ������������');
		  rollback;
          update lkl_rrp set blk = 3 where mfo = c.mfo;
		  commit;
	   end;

	end loop;

end;
/
show err;

PROMPT *** Create  grants  REFORM_SEP_FILES ***
grant EXECUTE                                                                on REFORM_SEP_FILES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REFORM_SEP_FILES.sql =========*** 
PROMPT ===================================================================================== 
