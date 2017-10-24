

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REE_CHECKS_SALBUY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REE_CHECKS_SALBUY ***

  CREATE OR REPLACE PROCEDURE BARS.P_REE_CHECKS_SALBUY (p_dat date, p_mode int )
  -- процедура формирования реестра купленных/проданных дорожных чеков за дату
  -- p_mode 1/2 (покупка/продажа)
is
 l_bane  varchar2(100) := null;
 l_nomc  varchar2(4)   := null;
 l_numc  varchar2(20)  := null;
 l_backtime varchar2(10) := null;
 l_skom  number := 0;
 l_prkom number := 0;
 m       number := 0;
 l_numcall  varchar2(1000) := null;
 l_cnt   number := 0;
begin
 -- удалим все старое за выбранную дату
 delete from  tmp_ref_info_checks where dat = p_dat and usid = USER_ID;
 -- идем по оговоренным типам операций за выбранную дату
 if p_mode = 1 then --ПОКУПКА!!!
  begin
   for k in (select o.*, t.lcv from oper o, tabval t where o.tt in ('115','125','130','140') and o.vdat = p_dat and o.kv = t.kv and o.sos in (5,-2))
    loop
      -- ищем сумму дочерних операций по комиссии
     begin
      select sum(o.s)/100  into l_skom
        from opldok o
       where o.ref = k.ref
         and o.tt in ('120', '128')
         and o.dk = 0;
     exception when no_data_found then l_skom := null;
     end;
      -- выбираем процент из кодов тарифов дочерних операций
     begin
      select pr into l_prkom
        from tarif f, ttsap ts, tts t
       where ts.tt = k.tt
         and ts.ttap in ('120', '128')
         and ts.ttap = t.tt
         --and f.kv = k.kv
         and to_char(f.kod) = substr(substr(t.s,instr(t.s,'F_TARIF')),instr( substr(t.s,instr(t.s,'F_TARIF')),'(')+1,
                                    instr( substr(t.s,instr(t.s,'F_TARIF')),',') - (instr( substr(t.s,instr(t.s,'F_TARIF')),'(')+1));
     exception when no_data_found then l_prkom := null;
     end;
      -- если операция сторнирована - запомним время сторнирования и обнулим процент комиссии, чтоб ничего не отображалось там
     if k.sos<0 then
         select to_char(dat,'HH24:MI:SS') into l_backtime from oper_visa where ref = k.ref and status = 3;
         l_prkom := null;
         l_skom  := null;
     else l_backtime := null;
     end if;

     -- выберем для полученных операций доп.реквизиты
     for m in 1 .. 15
       loop
        begin
          select substr(max(decode(tag,'BANE'||m,value,'BAE'||trim(to_char(m,'00')),value,'')),1,100),
                 substr(max(decode(tag,'NOMC'||m,value,'NDC'||trim(to_char(m,'00')),value,'')),1,4),
                 substr(max(decode(tag,'NUMC'||m,value,'NUC'||trim(to_char(m,'00')),value,'')),1,20)
            into l_bane, l_nomc, l_numc
            from operw
           where ref = k.ref;
        if l_bane is not null and l_nomc is not null and l_numc is not null then
        -- вставляем все выбранные данные в таблицу для отчета
        insert into tmp_ref_info_checks (  ref,   branch,   dat,    kv,    s, skom, prkom,  sos, backtime,   bane,   nomc,   numc,  cnt,    usid, r_type)
                                 values (k.ref, k.branch, p_dat, k.lcv, null, null,  null, null,     null, l_bane, l_nomc, l_numc, null, USER_ID,      0);
        end if;
        exception when no_data_found then null;
        end;
       end loop;

       -- в рамках одного выбранного референса подобъем итоги
       for s in (select ref, count(*) cn, count(*)*to_number(nomc) ss, nomc, bane, sum(count(*)) over (partition by ref) cnt
                   from TMP_REF_INFO_CHECKS
                  where usid = USER_ID and ref = k.ref and r_type = 0
                 group by ref, nomc, bane)
         loop
             l_numcall := null;
             for n in (select trim(numc) numc from TMP_REF_INFO_CHECKS where ref = s.ref and nomc = s.nomc and bane = s.bane)
               loop
                 l_numcall := l_numcall ||' '|| n.numc;
               end loop;
          -- вставляем модифицированную подстроку
          insert into tmp_ref_info_checks (  ref,   branch,   dat,    kv,    s, skom, prkom,  sos, backtime,   bane,   nomc,      numc,  cnt,    usid, r_type)
                                   values (k.ref, k.branch, p_dat, k.lcv, s.ss, null,  null, null,     null, s.bane, s.nomc, l_numcall, s.cn, USER_ID, 1);
          l_cnt := s.cnt;
         end loop;
          -- вставляем итоговую строку
          insert into tmp_ref_info_checks (  ref,   branch,   dat,    kv,       s,   skom,   prkom,   sos,   backtime, bane, nomc, numc,   cnt,    usid, r_type)
                                   values (k.ref, k.branch, p_dat, k.lcv, k.s/100, l_skom, l_prkom, k.sos, l_backtime, null, null, null, l_cnt, USER_ID, 2);

      --  delete from tmp_ref_info_checks where ref = k.ref and r_type = 0;
   end loop;
  end;
 end if;
end;
/
show err;

PROMPT *** Create  grants  P_REE_CHECKS_SALBUY ***
grant EXECUTE                                                                on P_REE_CHECKS_SALBUY to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REE_CHECKS_SALBUY to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REE_CHECKS_SALBUY.sql =========*
PROMPT ===================================================================================== 
