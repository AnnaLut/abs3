

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_GETPARTNER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_GETPARTNER ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_GETPARTNER (p_dat date, p_mode number)
is
-------------
--   Процедура по накоплению списка постоянных контрагентов по клиентам для анкет ФМ
--   ver.2.1 14/02/2017
--   модифицировано для работы в ММФО
--   Параметры:
--           p_dat  - дата формирования (первая дата последующего за отчетным квартала, например 01/10/2011 для данных за 3-й квартал)
--           p_mode - режим с(1)/без(0) переформирования
-------------
  q_Dat_Beg  date := trunc( add_months( p_dat, -3),'Q');     -- первая дата пред.квартала
  q_Dat_End  date := trunc(             p_dat     ,'Q');     -- первая дата текущего квартала

  l_title   varchar2(20) := 'FM P_FM_GETPARTNER:'; -- для трассировки
  l_datfmt  char(4);
  l_cnt     number;
  l_list    varchar2(4000);
  l_rnk     number;
  l_pasp    varchar(50) := null;

  l_nmk customer.NMK%type;

begin

  l_pasp   := null;

-- проанализируем входящую дату. выполняем расчет только 01/01, 01/04, 01/07, 01/10 - в начале квартала за предыдущий квартал. иначе - выходим.
 select to_char(p_dat,'DDMM') into l_datfmt from dual;
 if l_datfmt not in ('0101','0104','0107','0110') then return;
 end if;

-- в зависимости от параметра переформирования чистим данные за дату или выходим
 select count(*) into l_cnt from  fm_stable_partner_arc where  dat = q_Dat_End;
 if l_cnt > 0 then
   if p_mode = 0 then return;
   else
        delete from fm_stable_partner_arc where  dat = q_Dat_End;
   end if;
 end if;

 bars_audit.trace('%s 1.Старт процедуры накопления списка постоянных контрагентов по клиентам для анкет ФМ.',l_title);

-- вставляем во временную таблицу
 --insert into fm_partner_tmp (rnk_a, rnk_b, cnt, ref)
 insert into fm_stable_partner_tmp(rnk_a, RNK_B, CNT, REF, kf)
 select SUBSTR(para, 1 ,INSTR(para, '/', 1, 1)-1), SUBSTR(para, INSTR(para,'/', 1, 1)+1), cnt, ref, kf
 from
 (
   select concat_rnk(case when a1.rnk is not null then '#' else '' end ||
                      coalesce(case when substr('0000000000' || o.ID_A, -10) = '0000000000' then null else substr('0000000000' || o.ID_A, -10) end,
                               case when a1.rnk is not null then TO_CHAR(a1.rnk) else null end,
                               ow1.VALUE,
                               o.NLSA),
                     case when a2.rnk is not null then '#' else '' end ||
                      coalesce(case when substr('0000000000' || o.ID_B, -10) = '0000000000' then null else substr('0000000000' || o.ID_B, -10) end,
                               case when a2.rnk is not null then TO_CHAR(a2.rnk) else null end,
                               ow2.VALUE,
                               o.NLSB)
                    ) para,
          count(*) cnt,
          max(o.REF) ref,
          row_number() over (partition by concat_rnk(
                                                      case when a1.rnk is not null then '#' else '' end ||
                                                      coalesce(case when substr('0000000000' || o.ID_A, -10) = '0000000000' then null else substr('0000000000' || o.ID_A, -10) end,
                                                               case when a1.rnk is not null then TO_CHAR(a1.rnk) else null end,
                                                               ow1.VALUE,
                                                               o.NLSA),
                                                      case when a2.rnk is not null then '#' else '' end ||
                                                      coalesce(case when substr('0000000000' || o.ID_B, -10) = '0000000000' then null else substr('0000000000' || o.ID_B, -10) end,
                                                               case when a2.rnk is not null then TO_CHAR(a2.rnk) else null end,
                                                               ow2.VALUE,
                                                               o.NLSB)
                                                    ) order by count(*) desc) lst,
          o.KF
   from oper o
   left join accounts a1 on o.NLSA = a1.NLS and o.KV = a1.kv and o.MFOA = a1.KF
   left join accounts a2 on o.NLSB = a2.NLS and o.KV = a2.KV and o.MFOB = a2.KF
   left join operw   ow1 on ow1.REF = o.ref and ow1.TAG = 'ф   ' --client A, passp
   left join operw   ow2 on ow2.REF = o.ref and ow2.TAG = 'Ф   ' --client B, passp
   where
   (
     (a1.rnk is not null and a1.nbs in (2560, 2570, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2610, 2611, 2615, 2620, 2622, 2625, 2630, 2635, 2640, 2641, 2642, 2643, 2650, 2651, 2652, 2655))
     or/*кто-то является клиентом и речь о счете из перечня*/
     (a2.rnk is not null and a2.nbs in (2560, 2570, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2610, 2611, 2615, 2620, 2622, 2625, 2630, 2635, 2640, 2641, 2642, 2643, 2650, 2651, 2652, 2655))
   )
   and sos = 5 and vdat >= q_Dat_Beg and vdat < q_Dat_End
   and case when a1.rnk is not null then '#' else '' end ||
        coalesce(case when substr('0000000000' || o.ID_A, -10) = '0000000000' then null else substr('0000000000' || o.ID_A, -10) end,
                 case when a1.rnk is not null then TO_CHAR(a1.rnk) else null end,
                 ow1.VALUE,
                 o.NLSA) != /*client A != client B*/
       case when a2.rnk is not null then '#' else '' end ||
        coalesce(case when substr('0000000000' || o.ID_B, -10) = '0000000000' then null else substr('0000000000' || o.ID_B, -10) end,
                 case when a2.rnk is not null then TO_CHAR(a2.rnk) else null end,
                 ow2.VALUE,
                 o.NLSB)
   group by concat_rnk(case when a1.rnk is not null then '#' else '' end ||
                        coalesce(case when substr('0000000000' || o.ID_A, -10) = '0000000000' then null else substr('0000000000' || o.ID_A, -10) end,
                                 case when a1.rnk is not null then TO_CHAR(a1.rnk) else null end,
                                 ow1.VALUE,
                                 o.NLSA),
                       case when a2.rnk is not null then '#' else '' end ||
                        coalesce(case when substr('0000000000' || o.ID_B, -10) = '0000000000' then null else substr('0000000000' || o.ID_B, -10) end,
                                 case when a2.rnk is not null then TO_CHAR(a2.rnk) else null end,
                                 ow2.VALUE,
                                 o.NLSB)
                      ), o.kf
   having count(*)>10
 );

  begin
    for l in (select distinct rnk_a  rnk, kf
                from fm_stable_partner_tmp
                where rnk_a like '#%'
           union
             select distinct rnk_b  rnk, kf
                from fm_stable_partner_tmp
                where rnk_b like '#%'
           )
       loop
         l_list := null;
         for k in (select case when t.RNK_A = l.rnk then o.NAM_B when t.RNK_B = l.rnk then o.NAM_A end as C_NMS,
                          case when t.RNK_A = l.rnk then t.RNK_B when t.RNK_B = l.rnk then t.RNK_A end as C_data,
                          case when t.RNK_A = l.rnk then o.ID_B when t.RNK_B = l.rnk then o.ID_A end as C_OKPO,
                          case when t.RNK_A = l.rnk then o.NLSB when t.RNK_B = l.rnk then o.NLSA end as C_NLS,
                          o.KV as C_KV,
                          t.kf,
                          o.mfoa, --?
                          o.mfob, --?
                          case when t.rnk_a = l.rnk then '1' when t.rnk_b = l.rnk then '2' end as way
                   from fm_stable_partner_tmp t
                   left join oper o on t.REF = o.REF
                   where (t.RNK_A = l.rnk or t.RNK_B = l.rnk) and t.kf = l.kf /*review?*/
                   order by t.CNT desc)
                   loop
                     l_pasp :=null;
                     begin
                        select rnk into l_rnk from accounts where nls = k.c_nls and kv = k.c_kv and kf = nvl(case when k.way = '1' then k.mfoa when k.way = '2' then k.mfob end, k.kf);
                     exception when no_data_found then l_rnk := null;
                     end;
                     begin
                       select nmk into l_nmk from customer where rnk = l_rnk;
                     exception when no_data_found then l_nmk := null;
                     end;
                     if substr('0000000000'||k.C_okpo,-10) = '0000000000' then
                     begin
                        select '('||ser||numdoc||')' into l_pasp from person where rnk = l_rnk;
                     exception when no_data_found then l_pasp := null;
                     end;
                     end if;
                     l_list := substr(l_list || nvl(l_nmk, k.c_nms) || '/' || to_char(k.C_OKPO) || l_pasp ||'; ', 1, 4000);
                   end loop;
         --вставляем расчетные данные с датой-идентификатором первый квартал текущего (следующего по отношению в расчетному) квартала
         if l_list is not null then
            begin
              --вставляем okpo или rnk(если окпо 0000000000)
              insert into fm_stable_partner_arc
                (dat, partner_list, rnk, kf)
              values
                (q_Dat_End, l_list, ltrim(l.rnk, '#'), l.kf);
            exception when dup_val_on_index then null;
            end;
         end if;

       end loop;

 end;

 commit;
 bars_audit.trace('%s 2.Финиш процедуры накопления списка постоянных контрагентов по клиентам для анкет ФМ.',l_title);

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
