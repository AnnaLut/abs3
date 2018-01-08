

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_DPT_VIDD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_DPT_VIDD ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_DPT_VIDD 
before  insert or update or delete ON BARS.DPT_VIDD
for each row
declare
  l_userid  staff.id%type := gl.auid;
  l_actid   number(1);
begin
  bc.go('/');
  if inserting then
     l_actid := 0;
  elsif updating then
     l_actid := 1;
  elsif deleting then
     l_actid := 2;
  end if;

  if l_actid = 2 then
     insert into dpt_vidd_update
       (idu, useru, dateu, typeu,
        vidd, deposit_cod, type_name, type_cod,
        flag, kv, freq_n, freq_k, bsd, bsn, bsa,
        br_id, br_id_l, basem,
        nls_k, nlsn_k, comproc,
        basey, metr, amr_metr, tip_ost, acc7,
        duration, duration_days, term_type,
        id_stop, br_wd, min_summ, limit, max_limit,
        term_add, fl_dubl, term_dubl, extension_id, fl_2620,
        comments, idg, ids)
     values
       (0, l_userid, sysdate, l_actid,
        :OLD.vidd, :OLD.deposit_cod, :OLD.type_name, :OLD.type_cod,
        :OLD.flag, :OLD.kv, :OLD.freq_n, :OLD.freq_k, :OLD.bsd, :OLD.bsn, :OLD.bsa,
        :OLD.br_id, :OLD.br_id_l, :OLD.basem,
        :OLD.nls_k, :OLD.nlsn_k, :OLD.comproc,
        :OLD.basey, :OLD.metr, :OLD.amr_metr, :OLD.tip_ost, :OLD.acc7,
        :OLD.duration, :OLD.duration_days, :OLD.term_type,
        :OLD.id_stop, :OLD.br_wd, :OLD.min_summ, :OLD.limit, :OLD.max_limit,
        :OLD.term_add, :OLD.fl_dubl, :OLD.term_dubl, :OLD.extension_id, :OLD.fl_2620,
        :OLD.comments, :OLD.idg, :OLD.ids);
  else
     insert into dpt_vidd_update
       (idu, useru, dateu, typeu,
        vidd, deposit_cod, type_name, type_cod,
        flag, kv, freq_n, freq_k, bsd, bsn, bsa,
        br_id, br_id_l, basem,
        nls_k, nlsn_k, comproc,
        basey, metr, amr_metr, tip_ost, acc7,
        duration, duration_days, term_type,
        id_stop, br_wd, min_summ, limit, max_limit,
        term_add, fl_dubl, term_dubl, extension_id, fl_2620,
        comments, idg, ids)
     values
       (0, l_userid, sysdate, l_actid,
        :NEW.vidd, :NEW.deposit_cod, :NEW.type_name, :NEW.type_cod,
        :NEW.flag, :NEW.kv, :NEW.freq_n, :NEW.freq_k, :NEW.bsd, :NEW.bsn, :NEW.bsa,
        :NEW.br_id, :NEW.br_id_l, :NEW.basem,
        :NEW.nls_k, :NEW.nlsn_k, :NEW.comproc,
        :NEW.basey, :NEW.metr, :NEW.amr_metr, :NEW.tip_ost, :NEW.acc7,
        :NEW.duration, :NEW.duration_days, :NEW.term_type,
        :NEW.id_stop, :NEW.br_wd, :NEW.min_summ, :NEW.limit, :NEW.max_limit,
        :NEW.term_add, :NEW.fl_dubl, :NEW.term_dubl, :NEW.extension_id, :NEW.fl_2620,
        :NEW.comments, :NEW.idg, :NEW.ids);

     if ( :NEW.br_id != :OLD.br_id)
     then
      begin
        insert into dpt_brates(mod_code, vidd, date_entry, br_id, basey)
        values ('DPT', :NEW.vidd, sysdate, :NEW.br_id,:NEW.basey);
      exception when dup_val_on_index then null;
      end;
     end if;
  end if;
end;
/
ALTER TRIGGER BARS.TIUD_DPT_VIDD DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_DPT_VIDD.sql =========*** End *
PROMPT ===================================================================================== 
