

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST_ACCOUNTS.sql 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_TRANSFORM_FORECAST_ACCOUNTS ***

  CREATE OR REPLACE PROCEDURE BARS.P_TRANSFORM_FORECAST_ACCOUNTS is
   l_count     number:= 0;
   l_tries     number:= 0;
   l_new_nls   accounts.nls%type;
   l_nbs       varchar2(100) := 'xxxx';
   l_acc_cnt   number :=0;
   l_new_nbs   accounts.nbs%type;
   l_new_ob22  accounts.ob22%type;
   l_trace     varchar2(100) := 'T2017.p_transform_forecast_accuonts: ';

begin

   bars_audit.info(l_trace||'��������� ������� �� �������������');

   for c in (select a.kf, a.kv, a.acc, a.nbs, a.nls, a.ob22
               from transform_2017_forecast t,
                    accounts a
              where t.new_nls is null
                and a.kf = t.kf
			    and a.acc = t.acc )
   loop
               bars_audit.info(l_trace||'��������� kf='||c.kf||', nls='||c.nls);
			   begin
                   select r020_new, ob_new
                     into l_new_nbs, l_new_ob22
                     from transfer_2017
                    where r020_old = c.nbs
                      and ob_old = c.ob22;
               exception when no_data_found then
                    bars_audit.info(l_trace||'� ����������� �� ������� ���� ���='||l_new_nbs||', ob22='||l_new_ob22);
               end;

			   l_new_nls := vkrzn( substr( c.kf, 1,5), l_new_nbs||'0' || substr( c.nls, 6,9));


			   --bars_audit.info(l_trace||'��������� ����� kf='||c.kf||', acc='||c.acc||', nls='||c.nls||' -> '||l_new_nls);

               l_tries := 0;
               while l_tries < 100 loop

                     l_count :=0;

                     select count(*) into l_count from
                     ( select 1  from accounts              where nls      = l_new_nls   and kf = c.kf
                       union all
                       select 1 from TRANSFORM_2017_FORECAST     where new_nls  = l_new_nls   and kf = c.kf
                     );

                     -- ���� ����� ���� ����� ��� � ����� ��� � �����������������
                     -- �������� ��� ��� ���������
                     if l_count = 0 then
                        -- �����, ���� �� �����
                        bars_audit.info(l_trace||'�� ����� ���� � ������������ - �������');
                        exit;
                     end if;
                     l_tries := l_tries + 1;
                     l_new_nls := vkrzn( substr( c.kf, 1,5), l_new_nbs||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) )) ;

             end loop;

             bars_audit.info(l_trace||'����� ���� ='||l_new_nls||' ������� ='||l_tries);

             if l_tries < 100 then
                update  TRANSFORM_2017_FORECAST set new_nbs = l_new_nbs, new_nls = l_new_nls, new_ob22 = l_new_ob22, insert_date = sysdate
                where acc = c.acc;
             else
                bars_audit.info(l_trace||'c��� �� ��������. kf='||c.kf||', acc='||c.acc||', nls='||c.nls);
             end if;



                commit;  -- ������ �� ����������� �����
                bars_audit.info(l_trace||'��������� �� '||c.nls);


   end loop;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST_ACCOUNTS.sql 
PROMPT ===================================================================================== 
