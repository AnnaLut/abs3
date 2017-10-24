

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_LIMVAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_LIMVAL ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_LIMVAL 
after update of sos ON BARS.OPER
for each row
 WHEN (
old.sos!=5 and new.sos=5 and new.tt in ('AA4','AA6','AAL','AAE','TMP','TTI','TM8')
      ) declare
  l_sq      number;
  l_vidd    number;
  l_serd    varchar2(32);
  l_pasp    varchar2(64);
  l_fio     varchar2(254);
  l_ret     varchar2(4000);
  l_limeq   varchar2(254);
  l_kurs    number(20,8);
  l_kuro    number(20,8);
  l_drday   varchar2(14);
  l_kodm number;
  l_tipm number;

--l_dat     date;
begin
--begin
--  select dat
--  into   l_dat
--  from   oper_visa
--  where  ref=:new.ref and
--         status=2;
--exception when no_data_found then
--  l_dat := null;
--end;
  begin
    select value
    into   l_limeq
    from   operw
    where  ref=:new.ref and
           tag='LIMEQ';
  exception when no_data_found then
    l_limeq := null;
  end;
--bars_audit.info('ref='||:new.ref||', l_dat='||to_char(l_dat,'DD/MM/YYYY HH24:MI:SS')||', sysdate='||to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'));
--if :new.SOS_TRACKER<10 then
--if l_dat is not null and sysdate-l_dat<0.000173611111111111 then -- 15 секунд
  if l_limeq is null then
    begin
--    select eqv_obs(:new.kv,:new.s,trunc(sysdate),0)
--    into   l_sq
--    from   dual;
--    вычитываем официальный курс
--if :new.tt in('TMP','TTI','TM8') then  l_kuro:=1;
--else
      begin
        select rate_o/bsum
        into   l_kuro
        from   cur_rates$base
        where  vdate=bankdate and
               kv=:new.kv     and
               branch='/'||f_ourmfo_g||'/';
  exception when  no_data_found then
    l_kuro:=1;
  end;
--end if;
--    bars_audit.info('limval: kuro='||l_kuro);
   if :new.tt in('AA4','AA6') then
      select nvl(p.passp,1),
             case when nvl(p.passp,1) = 7
               then
                 ' '
               else
                 substr(replace(trim(w.value),' '),1,2)
             end,
             case when nvl(p.passp,1) = 7
               then
                 replace(trim(w.value),' ')
               else
                 substr(replace(trim(w.value),' '),3)
             end,
             w2.value,
             to_number(replace(w3.value,',','.'))  ,
             case when :new.tt  in('TTI') then :new.s  else to_number(replace(w3.value,',','.'))*:new.s end,
       w4.value
      into   l_vidd,
             l_serd,
             l_pasp,
             l_fio ,
             l_kurs,
             l_sq,
       l_drday
      from   operw w ,
             operw w1,
             operw w2,
             operw w3,
       operw w4,
             passpv p
      where  w.ref=:new.ref  and
             w.tag='PASPN'   and
             w1.ref=:new.ref and
             w1.tag= case when :new.tt in('TMP','TTI','TM8') then 'PASP ' else 'PASPV' end  and
             w2.ref=:new.ref and
             w2.tag='FIO  '  and
             w3.ref=:new.ref and
             w3.tag= case when :new.tt in('TMP','TTI','TM8') then 'MKURS' else 'KURS ' end  and
       w4.ref=:new.ref and
             w4.tag='DRDAY'  and
             p.name(+)=w1.value;

  else
         select nvl(p.passp,1),
                case when nvl(p.passp,1) = 7
                  then
                    ' '
                  else
                    substr(replace(trim(w.value),' '),1,2)
                end,
                case when nvl(p.passp,1) = 7
                  then
                    replace(trim(w.value),' ')
                  else
                    substr(replace(trim(w.value),' '),3)
                end,
             w2.value,
             to_number(replace(w3.value,',','.'))  ,
             case when :new.tt  in('TTI') then :new.s  else to_number(replace(w3.value,',','.'))*:new.s end
      into   l_vidd,
         l_serd,
         l_pasp,
         l_fio ,
         l_kurs,
         l_sq
      from   operw w ,
         operw w1,
         operw w2,
         operw w3,
         passpv p
      where  w.ref=:new.ref  and
         w.tag='PASPN'   and
         w1.ref=:new.ref and
         w1.tag= case when :new.tt in('TMP','TTI','TM8') then 'PASP ' else 'PASPV' end  and
         w2.ref=:new.ref and
         w2.tag='FIO  '  and
         w3.ref=:new.ref and
         w3.tag= case when :new.tt in('TMP','TTI','TM8') then 'MKURS' else 'KURS ' end  and
         p.name(+)=w1.value;
      l_drday:='01/01/0001';



      Begin
           l_kodm := f_dop(:new.ref, 'BM__C');

           select type_
           into l_tipm
           from bank_metals
           where kod =  l_kodm;

           if l_tipm in (1,2, 4)
                 then
                 l_kurs := to_number(f_dop(:new.ref, 'BM__R'));
                 l_sq   := to_number(f_dop(:new.ref, 'BM__K'))*to_number(f_dop(:new.ref, 'BM__R'))*100;
                      --round(l_sq/100,2);
               --  l_kuro := 1;
          end if;


       EXCEPTION when NO_DATA_FOUND THEN null;
     End;

    end if;


--    bars_audit.info('limval: l_kurs='||l_kurs);
    exception when no_data_found then
      l_vidd := 1;
      l_serd := 'XX';
      l_pasp := 'NNNNNN';
      l_fio  := 'FIO';
      l_kurs := l_kuro;
    end;
    begin
     val_service.set_eq(sysdate          ,  --vdat_    varchar2,
                         bankdate         ,  --datb_    varchar2,
                         :new.pdat,          --pdat_
                         l_vidd           ,  --vidd_    number  ,
                         l_serd           ,  --serd_    varchar2,
                         l_pasp           ,  --pasp_    varchar2,
                         l_fio            ,  --fio_     varchar2,
                         nvl(l_sq,0)      ,  --sq_      number  ,
                         :new.kv          ,  --kv_      number  ,
                         :new.s           ,  --s_       number  ,
                         to_char(:new.ref),  --ref_     varchar2,
                         :new.branch      ,  --branch_  varchar2,
                         to_char(l_kurs)  ,  --kurs_    number  , комерческий курс
                         to_char(l_kuro)  ,  --kuro_    number  , офіційний курс
                         to_char(:new.tt),
                         nvl(l_drday,'01/01/0001'),
                         l_ret);             --ret_ out varchar2)
--    bars_audit.info('limval: l_ret='||l_ret);
      if l_ret is not null then
        bars_error.raise_nerror('BRS','NOT_PAY_150',l_ret);
      else
        begin
          insert
          into   operw (ref,tag,value)
                values (:new.ref,'LIMEQ',to_char(l_sq));
        exception when dup_val_on_index then
          null;
        end;
      end if;
    exception when others then
      if instr(sqlerrm,'ORA-00001: unique constraint (BARS.PK_LIMDAT) violated')>0 then
        null;
      else
--      logger.info('limval=>'||sqlerrm);
        raise;
      end if;
    end;
  end if;
end tau_oper_limval;
/
ALTER TRIGGER BARS.TAU_OPER_LIMVAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_LIMVAL.sql =========*** End
PROMPT ===================================================================================== 
