PROMPT =============== *** start onetime set bonus  *** ==========================

declare
  l_title constant varchar2(16) := 'dpt_bonus_addit:';
  l_bonusval  number;
  l_bonus_cnt number;
  l_bonusdate date;
  l_zp_count  number;
  p_dat       DATE := trunc(sysdate);
  l_brate     bars.int_ratn.br%type;
  l_irate     bars.int_ratn.ir%type;
  l_indrate   bars.Dpt_Vidd_Extdesc%rowtype;
  l_brtype    varchar2(25);
  l_err varchar2(200);
BEGIN
  
  
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf)
  
   LOOP
    bc.go(cur.kf);
    bars_audit.info('Onetime_set_bonus. «апуск процедуры расчета льгот дл€ kf = '||to_char(cur.kf));
    
   For i in (select * from tmp_int_ddpt tid
        where tid.kf = cur.kf
        and nvl(trim(tid.note),'-') <> 'OK') loop

       BEGIN
        l_bonusval := 0;
        l_err := '';
        
        bars_audit.trace('%s запуск процедуры расчета льгот', l_title);
        l_err := l_err ||'1-';
        bars.dpt_bonus.set_bonus(i.deposit_id); -- рассчитываем бонус
        commit;
        bars_audit.trace('%s льготы рассчитаны', l_title);
        bars_audit.trace('%s поиск бонусной процентной ставки, не требующей подтверждени€', l_title);
        
          delete from dpt_depositw
           where tag = 'BONUS'
             and DPT_ID = i.deposit_id;
          l_err := l_err ||'3-';
          DPT_BONUS.SET_BONUS_RATE(i.deposit_id, p_dat + 1, l_bonusval);
          l_err := l_err ||'4-';
          bars_audit.trace('%s встановлена бонусна ставка = %s',
                           l_title,
                           to_char(l_bonusval));

        -- если прогрессивный
        if i.type_code = 'MPRG' then       --#3
        l_err := l_err ||'5-';
          begin
            select *
              into l_indrate --индивидуальна€ ставка дл€ этого кол-ва пролонгаций
              from bars.Dpt_Vidd_Extdesc dve
             where dve.base_rate = i.br
               and dve.ext_num = i.cnt_dubl
               and dve.type_id = i.ext_id;

          exception
            when others then
              l_indrate := null;
          end;

         if nvl(l_indrate.indv_rate,0) <> 0 --#4
         then 
          l_bonusval := l_bonusval + l_indrate.indv_rate;
          l_err := l_err ||'6-';
          merge into bars.int_ratn ir
          using (select *
                   from bars.int_ratn
                  where acc = i.acc
                    and bdat = p_dat + 1
                    and br = l_brate
                    and id = 1) x
          on (ir.acc = x.acc and ir.bdat = x.bdat and ir.br = x.br and ir.id = x.id)
          When matched then
            update
               set ir.ir = l_bonusval,
                   op    = case
                             when nvl(l_indrate.indv_rate, 0) != 0 and nvl(l_indrate.oper_id, 0) = 0 then
                              1
                             else
                              l_indrate.oper_id
                           end 
           When not matched then 
             insert(ir.acc, ir.id, ir.bdat, ir.ir, ir.br, ir.op) values(i.acc, 1, trunc(p_dat + 1), l_bonusval, l_indrate.base_rate, l_indrate.oper_id);
           l_err := l_err ||'7-';
           begin
              INSERT INTO dpt_depositw (dpt_id, tag, value, branch)
              VALUES (i.deposit_id, 'BONUS', to_char(l_bonusval), i.branch);
           exception when dup_val_on_index then
              update dpt_depositw
              set value = to_char(l_bonusval),
               branch = i.branch
              where tag = 'BONUS' and dpt_id = i.deposit_id;
            end;
            l_err := l_err ||'8-';
            bars_audit.trace('%s значение бонуса записано в доп.реквизиты вклада', l_title);                
            
          end if; --#4
        end if; --#3
        
        if i.type_code = 'MPRG' then -- но, если депозит прогрессивный, то берем дату открыти€ или каждой 12-й пролонгации
              select nvl(max(dat_begin), i.dat_begin)
              into l_bonusdate
              from bars.dpt_deposit_clos
              where deposit_id = i.deposit_id
              and nvl(cnt_dubl,0) = trunc(nvl(i.cnt_dubl,0)/12) * 12;
        else
              l_bonusdate := i.dat_begin;
        end if;
        l_zp_count := dpt_bonus.get_MMFO_ZPcard_count(i.rnk, l_bonusdate);
        
        update BARS.tmp_int_ddpt 
        set note = 'OK',
        bonus = l_bonusval,
        open_zp_cnt = l_zp_count
        where deposit_id = i.deposit_id
        and acc = i.acc
        and kf = i.kf;
         
        EXCEPTION 
          WHEN OTHERS 
           THEN 
             l_err := substr(l_err ||' - '||sqlerrm, 1,200);
        update BARS.tmp_int_ddpt 
        set note = 'err: '||l_err
        where deposit_id = i.deposit_id
        and acc = i.acc
        and kf = i.kf;
        END;
        
  end loop;
  commit;
  bars_audit.info('Onetime_set_bonus. Ћьготы дл€ kf = '||to_char(cur.kf)||' рассчитаны ');
  end loop;
  bc.home;

end;
/
show error

PROMPT =============== *** finish onetime set bonus  *** ==========================
