

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_GETPARTNER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_GETPARTNER ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_GETPARTNER (p_dat date, p_mode number)
is
-------------
--   ��������� �� ���������� ������ ���������� ������������ �� �������� ��� ����� ��
--   ver.1.1 28/12/2015
--   ���������:
--           p_dat  - ���� ������������ (������ ���� ������������ �� �������� ��������, �������� 01/10/2011 ��� ������ �� 3-� �������)
--           p_mode - ����� �(1)/���(0) ����������������
-------------
  q_Dat_Beg  date := trunc( add_months( p_dat, -3),'Q');     -- ������ ���� ����.��������
  q_Dat_End  date := trunc(             p_dat     ,'Q');     -- ������ ���� �������� ��������

  l_title   varchar2(20) := 'FM P_FM_GETPARTNER:'; -- ��� �����������
  l_datfmt  char(4);
  l_cnt     number;
  l_list    varchar2(4000);
  l_rnk     number;
  l_pasp    varchar(50) := null;

begin

  l_pasp   := null;

-- �������������� �������� ����. ��������� ������ ������ 01/01, 01/04, 01/07, 01/10 - � ������ �������� �� ���������� �������. ����� - �������.
 select to_char(p_dat,'DDMM') into l_datfmt from dual;
 if l_datfmt not in ('0101','0104','0107','0110') then return;
 end if;

-- � ����������� �� ��������� ���������������� ������ ������ �� ���� ��� �������
 select count(*) into l_cnt from  fm_partner_arc where  dat = q_Dat_End;
 if l_cnt > 0 then
   if p_mode = 0 then return;
   else
        delete from fm_partner_arc where  dat = q_Dat_End;
   end if;
 end if;

 bars_audit.trace('%s 1.����� ��������� ���������� ������ ���������� ������������ �� �������� ��� ����� ��.',l_title);

-- ��������� �� ��������� �������
 insert into fm_partner_tmp (id_a, id_b, cnt, ref)
    select substr(para,1,10), substr(para,11,10), cnt, ref  from
     ( select f_para(id_a, id_b) para, count(*) cnt, max(ref) ref, row_number() over (partition by f_para(id_a, id_b) order by count(*) desc) lst
         from oper
        where id_a is not null and id_b is not null
          and id_a<>id_b
          and sos = 5 and vdat >= q_Dat_Beg and vdat < q_Dat_End
       group by f_para(id_a, id_b)
       having count(*) > 10 )
    where lst < 10;

  begin
    for l in (select distinct id_a  id
                from fm_partner_tmp
           union
             select distinct id_b  id
                from fm_partner_tmp
           )
       loop
         l_list := null;
         for k in (select decode (l.id, substr('0000000000'||o.id_a,-10), o.nam_b, o.nam_a) nms, decode (l.id, substr('0000000000'||o.id_a,-10), o.id_b, o.id_a) okpo,
                          decode (l.id, substr('0000000000'||o.id_a,-10), o.nlsb, o.nlsa) nls, decode (l.id, substr('0000000000'||o.id_a,-10), o.kv2, o.kv) kv
                 from fm_partner_tmp t, oper o
            where (t.id_a = l.id or t.id_b = l.id)
              and t.ref = o.ref)
                loop
				 l_pasp :=null;
                 if substr('0000000000'||k.okpo,-10) = '0000000000' then
                    begin
                      select rnk into l_rnk from accounts where nls = k.nls and kv = k.kv;
                    exception when no_data_found then l_rnk := null;
                    end;
                    begin
                      select '('||ser||numdoc||')' into l_pasp from person where rnk = l_rnk;
                    exception when no_data_found then l_pasp := null;
                    end;
                   end if;
                   l_list := substr(l_list || k.nms || '/' || to_char(k.okpo) || l_pasp ||'; ', 1, 4000);
        end loop;
         --��������� ��������� ������ � �����-��������������� ������ ������� �������� (���������� �� ��������� � ����������) ��������
         if l_list is not null then
        insert into fm_partner_arc (dat, okpo, partner_list)
                                values (q_Dat_End, l.id,       l_list);
         end if;

       end loop;

 end;

 commit;
 bars_audit.trace('%s 2.����� ��������� ���������� ������ ���������� ������������ �� �������� ��� ����� ��.',l_title);

exception when others then
    bars_audit.error (dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());

end p_fm_getpartner;
/
show err;

PROMPT *** Create  grants  P_FM_GETPARTNER ***
grant EXECUTE                                                                on P_FM_GETPARTNER to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_GETPARTNER to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_GETPARTNER.sql =========*** E
PROMPT ===================================================================================== 
