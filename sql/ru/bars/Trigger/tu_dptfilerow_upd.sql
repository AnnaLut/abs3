

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEROW_UPD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPTFILEROW_UPD ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPTFILEROW_UPD 
before update of nls, branch_code, dpt_code, sum, fio, id_code, pasp,
                 branch, excluded, file_payoff_date, payoff_date
on dpt_file_row
for each row
 WHEN (
      nvl(old.nls,              '_') != nvl(new.nls,              '_')
   or nvl(old.fio,              '_') != nvl(new.fio,              '_')
   or nvl(old.id_code,          '_') != nvl(new.id_code,          '_')
   or nvl(old.pasp,             '_') != nvl(new.pasp,             '_')
   or nvl(old.branch,           '_') != nvl(new.branch,           '_')
   or nvl(old.branch_code,        0) != nvl(new.branch_code,        0)
   or nvl(old.dpt_code,           0) != nvl(new.dpt_code,           0)
   or nvl(old.sum,                0) != nvl(new.sum,                0)
   or nvl(old.excluded,           0) != nvl(new.excluded,           0)
   or nvl(old.file_payoff_date, '_') != nvl(new.file_payoff_date, '_')
   or old.payoff_date                != new.payoff_date
   or old.payoff_date is null       and new.payoff_date is not null
   or new.payoff_date is null       and old.payoff_date is not null
     ) declare
  type       t_rowupdrec is record (rowid    dpt_file_row.info_id%type,
                                    branch   dpt_file_row.branch%type,
                                    colname  varchar2(30),
                                    oldval   varchar2(100),
                                    newval   varchar2(100));
  type       t_rowupdtbl is table of t_rowupdrec;
  l_rowupd   t_rowupdtbl := t_rowupdtbl();
  l_user     staff$base.id%type := gl.auid;
  l_bdat     date               := gl.bdate;
  l_counter  number(2)          := 0;
begin

  if nvl(:old.nls, '_') != nvl(:new.nls, '_') then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'NLS';
     l_rowupd(l_counter).oldval  := :old.nls;
     l_rowupd(l_counter).newval  := :new.nls;
  end if;
  if nvl(:old.fio, '_') != nvl(:new.fio, '_') then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'FIO';
     l_rowupd(l_counter).oldval  := :old.fio;
     l_rowupd(l_counter).newval  := :new.fio;
  end if;
  if nvl(:old.id_code, '_') != nvl(:new.id_code, '_') then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'ID_CODE';
     l_rowupd(l_counter).oldval  := :old.id_code;
     l_rowupd(l_counter).newval  := :new.id_code;
  end if;
  if nvl(:old.pasp, '_') != nvl(:new.pasp, '_') then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'PASP';
     l_rowupd(l_counter).oldval  := :old.pasp;
     l_rowupd(l_counter).newval  := :new.pasp;
  end if;
  if nvl(:old.branch, '_') != nvl(:new.branch, '_') then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'BRANCH';
     l_rowupd(l_counter).oldval  := :old.branch;
     l_rowupd(l_counter).newval  := :new.branch;
  end if;
  if nvl(:old.branch_code, 0) != nvl(:new.branch_code, 0) then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'BRANCH_CODE';
     l_rowupd(l_counter).oldval  := to_char(:old.branch_code);
     l_rowupd(l_counter).newval  := to_char(:new.branch_code);
  end if;
  if nvl(:old.dpt_code, 0) != nvl(:new.dpt_code, 0) then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'DPT_CODE';
     l_rowupd(l_counter).oldval  := to_char(:old.dpt_code);
     l_rowupd(l_counter).newval  := to_char(:new.dpt_code);
  end if;
  if nvl(:old.sum, 0) != nvl(:new.sum, 0) then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'SUM';
     l_rowupd(l_counter).oldval  := to_char(:old.sum);
     l_rowupd(l_counter).newval  := to_char(:new.sum);
  end if;
  if nvl(:old.excluded, 0) != nvl(:new.excluded, 0) then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'EXCLUDED';
     l_rowupd(l_counter).oldval  := to_char(:old.excluded);
     l_rowupd(l_counter).newval  := to_char(:new.excluded);
  end if;
  if nvl(:old.file_payoff_date, '_') != nvl(:new.file_payoff_date, '_') then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'FILE_PAYOFF_DATE';
     l_rowupd(l_counter).oldval  := :old.file_payoff_date;
     l_rowupd(l_counter).newval  := :new.file_payoff_date;
  end if;
  if nvl(:old.payoff_date, to_date('01.01.2000','dd.mm.yyyy')) !=
     nvl(:new.payoff_date, to_date('01.01.2000','dd.mm.yyyy')) then
     l_rowupd.extend(1);
     l_counter := l_counter + 1;
     l_rowupd(l_counter).rowid   := :old.info_id;
     l_rowupd(l_counter).branch  := :old.branch;
     l_rowupd(l_counter).colname := 'PAYOFF_DATE';
     l_rowupd(l_counter).oldval  := to_char(:old.payoff_date,'dd.mm.yyyy');
     l_rowupd(l_counter).newval  := to_char(:new.payoff_date,'dd.mm.yyyy');
  end if;

  for i in 1..l_rowupd.count
  loop
      insert into dpt_file_row_upd
        (rec_id, row_id, branch, user_id, sysdat, bnkdat, columname, old_value, new_value)
      values
        (s_dptfilerowupd.nextval, l_rowupd(i).rowid, l_rowupd(i).branch, l_user,
         sysdate, l_bdat, l_rowupd(i).colname, l_rowupd(i).oldval, l_rowupd(i).newval);
  end loop;

end;
/
ALTER TRIGGER BARS.TU_DPTFILEROW_UPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPTFILEROW_UPD.sql =========*** E
PROMPT ===================================================================================== 
