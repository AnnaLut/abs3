PROMPT *** Insert Data in DPT_BONUS_SETTINGS for ZP-bonus***

declare
type kvx is table of number;
type tpx is table of number;
kv kvx;
dpt_type tpx;
begin
   
  delete from bars.dpt_bonus_settings where bonus_id = dpt_bonus.get_bonus_id('DPZP');
  kv := kvx(978, 840, 980);
  dpt_type := tpx(36, 37, 38, 39, 42, 46, 47, 48, 49, 50);
  for i in 1..kv.count loop
    for t in 1..dpt_type.count loop

        insert into bars.dpt_bonus_settings (dpt_type, dpt_vidd, kv, val, s, bonus_id, dat_begin, dat_end)
         values ( dpt_type(t), null, kv(i), decode(kv(i), 980, 0.5, 840, 0.25, 978, 0.25, 0), null, dpt_bonus.get_bonus_id('DPZP'), to_date('04.03.2015','DD.MM.YYYY'), null);
    end loop;
  end loop;
   
commit;
 
end;
/