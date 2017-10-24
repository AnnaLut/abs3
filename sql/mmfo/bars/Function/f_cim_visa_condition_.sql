
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cim_visa_condition_.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CIM_VISA_CONDITION_ (p_dk in number, p_kv in number, p_nlsa in varchar2, p_nlsb in varchar2, 
                                                p_tt in varchar2 := null, p_ref in number := null) return number
                                                                    -- 0 - �����, 1 - ������, 2 - � �������, null - ��� �� �������                                    
   is
      -- l_trace constant varchar2(100) := cim_mgr.g_trace_module || 'check_visa_condition';
       l_res number;
       l_ref number;
       l_sos number;
       l_n number;
       l_dk number;
       l_nlsa varchar2(4);
       l_nlsb varchar2(4);
       l_vdat date;
       l_s number;
       l_txt varchar2(2);

   begin
          --bars_audit.trace('%s: entry point (p_dk=>%s, p_kv=%s, p_nlsa=%s, p_nlsb=%s)', l_trace, p_dk, p_kv, p_nlsa, p_nlsb);   
       l_nlsa:=substr(p_nlsa, 1, 4); l_nlsb:=substr(p_nlsb, 1, 4); 
       if p_dk = 1 then 
         if p_kv = 980 then --���.
           if -- � ������� 2600, 2650 �� 1919 (��� �� �� ��)
              ( l_nlsa in ( '2600', '2650' ) and l_nlsb in ( '1919', '1600' ) )
              or ( l_nlsa in ( '2530', '2541', '2542', '2544', '2545', '2603' ) and l_nlsb = '1919' )     
              or -- � ������� 1919 �� 2600 (��� �� �� ��) (���������� �����)
              ( l_nlsa = '1919' and l_nlsb like '2600' )
              -- ( p_nlsa like '26%' and p_nlsb like '3739%' )
             then l_res := 1;
           elsif --( p_nlsa like '2900%' and ( p_nlsb like '2600%' or p_nlsb like '2650%') ) or--??  
                   -- � ������� 2603 �� 2900, 2600 ��� 2650 (��� �� �� ��)    
                   ( l_nlsa = '2603' and l_nlsb in ( '2900', '2603' ) )
                   or -- � ������� 2909, ���������� � ���������� ������� �� 2603 (����� ��� ��)
                   ( l_nlsa = '2909' and l_nlsb = '2603' )
                   or -- � ������� 3739 �� ������� 1919 (����������� � ����� �� ���������� ���������� ��������� ���������� �����)
                   ( l_nlsa = '3739' and l_nlsb = '1919' )
                   or -- � ������� 1919 �� ������� 1602 (����������� � ����� �� ���������� ���������� ��������� ���������� �����)
                   ( l_nlsa = '1919' and l_nlsb = '1602' )
                   or -- � ������� 2622 �� ������� 2620
                   ( l_nlsa = '2622' and l_nlsb = '2620' )  
                   or -- � ������� 3739 �� ������� 2603 ??
                   ( l_nlsa = '3739' and l_nlsb = '2603' )               
             then l_res :=  0;
           elsif ( p_ref is not null and l_nlsa = '2603' and l_nlsb in ( '2600', '2650', '2530', '2541', '2542', '2544', '2545' ) ) then
               select vdat, s into l_vdat, l_s from oper where ref=p_ref;
               select count(*) into l_n from oper o 
                 where o.sos=5 and o.kv=980 and o.s=l_s and substr(decode(o.dk, 1, o.nlsa, o.nlsb), 1, 4)='3739' and decode(o.dk, 1, o.nlsb, o.nlsa)=p_nlsa and 
                       o.vdat <= l_vdat and o.vdat >= l_vdat-4;
               if l_n>0 then l_res := 0; else l_res := null; end if;     
           else l_res := null; 
           end if;
         else   -- ��. ������
           if -- ������
              -- � ������� ������ 26 �� 3739 (��� �� �� ��)
              ( ( p_nlsa like '26%' or l_nlsa in ('2530', '2541', '2542', '2544', '2545', '2560', '2555' ) ) and  l_nlsb in ( '1919', '3739' ) )
              or -- � ������� 2602, 2620  �� 1500 ��� 1502 (���������)
              ( l_nlsa in ( '2602', '2620' ) and l_nlsb in ( '1500', '1502' ) )
              or -- � ������� 2650 �� 1600 
              ( l_nlsa in ( '2650', '2620') and l_nlsb = '1600' )
               or -- � ������� 2909 �� 1919 
              ( l_nlsa in ( '2909', '2063') and l_nlsb = '1919' )
              or -- � ������� 2600 ��� 2650 �� 2600 ��� 2650 
              ( l_nlsa in ( '2600', '2650', '2620' ) and 
                l_nlsb in ( '2600', '2650', '2620', '2602' ) )
              or ( l_nlsa in ('2600', '2555') and l_nlsb = '2605' )  
              or ( l_nlsa='2625' and l_nlsb='2620' )  
             then l_res := 1; 
             
             elsif p_nlsb like '100%' then
               if l_nlsa in ( '2530', '2544', '2545', '2560', '2600', '2620', '2625', '2650' ) then l_res :=  1;
               elsif l_nlsa in ( '2520', '2541', '2542') 
               then    
                 select nvl( ( select ob22 from accounts where kv=p_kv and nls=p_nlsa ), 'xx') into l_txt from dual;
                 if l_txt in ('01', '02', 'xx') then l_res :=  1; else l_res := null; end if;
               else l_res := null; end if;    
 
             elsif -- ����� 
                   -- � ������� 2603 �� 2900, 2600 ��� 2650 (��� �� �� ��)
                   ( l_nlsa = '2603' and l_nlsb in ( '2600', '2603', '2650', '2900' ) )
                   or -- � ������� 3739 �� 2603, 2600 ��� 2650 (����� ��� ��)
                      -- � ������� 2909 �� 2603, 2600, 2620 ��� 2650 (����� ��� ��)
                      -- � ������� 2909 �� ������� 2620 (����������� � �������� ����� �� ���������� ���������� ��������� � ������� ����� 
                        -- �� ����������� � �������� ����� �� ������� ������������-��������� � ������� �����)
                   ( l_nlsa in ( '2909', '3739' )  and l_nlsb in ( '2600', '2603', '2620', '2650', '2909') )
                   or -- � ������� 3739 �� ������� 1919 (����������� � �������� ����� �� ���������� ���������� ��������� ���������� �����)
                   ( l_nlsa = '3739' and l_nlsb in ('1919','2555') )
                   or -- � ������� 1919 �� ������� 1602 (����������� � �������� ����� �� ���������� ���������� ��������� ���������� �����)
                   ( l_nlsa = '1919' and l_nlsb = '1602' )
                   or -- � ������� 2900 �� ������� 2650 
                   ( l_nlsa = '2900' and l_nlsb = '2650' )
                   or -- � ������� 1500,1600 �� ������� 2909 
                   ( l_nlsa in ('1500', '1600') and l_nlsb like '2909' )
                   or ( l_nlsa in ('2620', '2625', '2909') and l_nlsb='2625' )                                 
             then l_res :=  0;
            
           end if;
         end if; 
       else --������� ��������
         if p_tt is not null and p_ref is not null and p_tt = 'GO1'then
            if substr(p_nlsa, 1, 2) in ('25', '26') and substr(p_nlsb, 1, 4)='2900' and p_kv != 980 then l_res:=0; else l_res:=null; end if;     
           /*
           select count(*), max(ref_pf), max(dk) into l_n, l_ref, l_dk from zayavka where ref=p_ref;
           if l_n=1 then
             if l_dk=3 then l_res:=0;
             elsif l_ref is not null and l_dk=1 then
               select sos into l_sos from oper where ref=l_ref;
               if l_sos = 5 then l_res:=0; else l_res:=2; end if;
             else l_res:=null;  
             end if;  
           else l_res:=null;
           end if;*/
         elsif p_nlsb like '100%' and l_nlsa in ( '2924', '2625' ) then
           begin
             select case when w.value='2' then 0 else null end into l_res from operw w where w.tag='REZID' and w.ref=p_ref;
           end;  
         elsif p_nlsb like '100%' and ( p_nlsa like '262%' or p_nlsa like '263%' ) or p_nlsb like '110%' and p_nlsa like '2620%' then
           begin
             select case when R.REZID=2 or c.country != 804 then 0 else null end into l_res 
               from accounts a join customer c on c.rnk=a.rnk join codcagent r on r.codcagent=c.codcagent where a.nls=p_nlsa and a.kv=p_kv;
           end; 
         elsif p_kv != 980 and  p_nlsb like '100%' then 
           if l_nlsa in ( '2520', '2530', '2541', '2542', '2544', '2545', '2600', '2603', '2605', '2650', '2555' ) then l_res:=0;
           else l_res := null; 
           end if;          
         else 
           l_res := null;      
         end if;    
       end if;     
       
       --bars_audit.trace('%s: done, l_res=%s', l_trace, l_res); 
       --bars_audit.trace('CIM ������ �������� ���� ���������� ���. dk: '||p_dk||' kv:'||p_kv||' nlsa:'||p_nlsa||
       --                ' nlsb:'||p_nlsb||' tt:'||p_tt||' ref:'||p_ref||' result: '||l_res);
	   return l_res;
   end f_cim_visa_condition_;
/
 show err;
 
PROMPT *** Create  grants  F_CIM_VISA_CONDITION_ ***
grant EXECUTE                                                                on F_CIM_VISA_CONDITION_ to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cim_visa_condition_.sql =========
 PROMPT ===================================================================================== 
 