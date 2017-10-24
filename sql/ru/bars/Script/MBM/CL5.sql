set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CL5
prompt Наименование операции: Internet-Banking CorpLight: Внутрішня

declare
    l_tt tts%rowtype; 
begin
  delete from op_rules where tt='CL5';
  delete from ttsap where tt='CL5';
  delete from ps_tts where tt='CL5';
  delete from tts_vob where tt='CL5';
  delete from chklist_tts where tt='CL5';
  delete from folders_tts where tt='CL5';
  
 
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
         select 'CL5' tt, 'Internet-Banking CorpLight: БПК' name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn
           from tts
          where tt = 'IB5';
  exception
    when dup_val_on_index then
      select * into l_tt from tts where tt = 'IB5';
      update tts set
            tt='CL5', 
            name='Internet-Banking CorpLight: БПК', 
            dk=l_tt.dk, 
            nlsm=l_tt.nlsm, 
            kv=l_tt.kv, 
            nlsk=l_tt.nlsk, 
            kvk=l_tt.kvk, 
            nlss=l_tt.nlss, 
            nlsa=l_tt.nlsa, 
            nlsb=l_tt.nlsb, 
            mfob=l_tt.mfob, 
            flc=l_tt.flc, 
            fli=l_tt.fli, 
            flv=l_tt.flv, 
            flr=l_tt.flr, 
            s=l_tt.s, 
            s2=l_tt.s2, 
            sk=l_tt.sk,
            proc=l_tt.proc, 
            s3800=l_tt.s3800, 
            rang=l_tt.rang, 
            flags=l_tt.flags, 
            nazn=l_tt.nazn
       where tt='CL5';
  end;
  
  insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
       select TAG, 'CL5' TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY
         from op_rules
        where tt = 'IB5';
  
  insert into ttsap(ttap, tt, dk)
       select ttap, 'CL5' tt, dk
         from ttsap
        where tt = 'IB5';
  
  insert into tts_vob(vob, tt)
       select vob, 'CL5' tt
         from tts_vob
        where tt = 'IB5';

    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
         select idchk, 'CL5' tt, priority, f_big_amount, sqlval, f_in_charge
           from chklist_tts
          where tt = 'IB5'; 

    insert into folders_tts(idfo, tt)
         select idfo, 'CL5' tt
           from folders_tts
          where tt = 'IB5';
end;
/

commit;
