create or replace trigger TU_DPTFILEROW_UPD 
before update
of NLS, BRANCH_CODE, DPT_CODE, SUM, FIO, ID_CODE, PASP, BRANCH, EXCLUDED, FILE_PAYOFF_DATE, PAYOFF_DATE
on DPT_FILE_ROW
for each row
 WHEN ( nvl(old.nls,              '_') != nvl(new.nls,              '_')
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
     or new.payoff_date is null       and old.payoff_date is not null )
declare
  type       t_rowupdrec is record ( rowid    dpt_file_row.info_id%type
                                   , colname  varchar2(30)
                                   , oldval   varchar2(100)
                                   , newval   varchar2(100) );
  type       t_rowupdtbl is table of t_rowupdrec;
  l_rowupd   t_rowupdtbl := t_rowupdtbl();
  l_user     dpt_file_row_upd.user_id%type;
  l_bdat     dpt_file_row_upd.bnkdat%type;
  l_kf       dpt_file_row_upd.kf%type;
  l_branch   dpt_file_row.branch%type;
begin

  if nvl(:old.nls, '_') != nvl(:new.nls, '_')
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'NLS';
    l_rowupd(l_rowupd.last).oldval  := :old.nls;
    l_rowupd(l_rowupd.last).newval  := :new.nls;
  end if;

  if nvl(:old.fio, '_') != nvl(:new.fio, '_')
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'FIO';
    l_rowupd(l_rowupd.last).oldval  := :old.fio;
    l_rowupd(l_rowupd.last).newval  := :new.fio;
  end if;

  if nvl(:old.id_code, '_') != nvl(:new.id_code, '_')
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'ID_CODE';
    l_rowupd(l_rowupd.last).oldval  := :old.id_code;
    l_rowupd(l_rowupd.last).newval  := :new.id_code;
  end if;

  if nvl(:old.pasp, '_') != nvl(:new.pasp, '_')
  then
   l_rowupd.extend;
   l_rowupd(l_rowupd.last).rowid   := :old.info_id;
   l_rowupd(l_rowupd.last).colname := 'PASP';
   l_rowupd(l_rowupd.last).oldval  := :old.pasp;
   l_rowupd(l_rowupd.last).newval  := :new.pasp;
  end if;

  if nvl(:old.branch, '_') != nvl(:new.branch, '_')
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'BRANCH';
    l_rowupd(l_rowupd.last).oldval  := :old.branch;
    l_rowupd(l_rowupd.last).newval  := :new.branch;
  end if;

  if nvl(:old.branch_code, 0) != nvl(:new.branch_code, 0) then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'BRANCH_CODE';
    l_rowupd(l_rowupd.last).oldval  := to_char(:old.branch_code);
    l_rowupd(l_rowupd.last).newval  := to_char(:new.branch_code);
  end if;

  if nvl(:old.dpt_code, 0) != nvl(:new.dpt_code, 0)
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'DPT_CODE';
    l_rowupd(l_rowupd.last).oldval  := to_char(:old.dpt_code);
    l_rowupd(l_rowupd.last).newval  := to_char(:new.dpt_code);
  end if;

  if nvl(:old.sum, 0) != nvl(:new.sum, 0)
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'SUM';
    l_rowupd(l_rowupd.last).oldval  := to_char(:old.sum);
    l_rowupd(l_rowupd.last).newval  := to_char(:new.sum);
  end if;

  if nvl(:old.excluded, 0) != nvl(:new.excluded, 0)
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'EXCLUDED';
    l_rowupd(l_rowupd.last).oldval  := to_char(:old.excluded);
    l_rowupd(l_rowupd.last).newval  := to_char(:new.excluded);
  end if;

  if nvl(:old.file_payoff_date, '_') != nvl(:new.file_payoff_date, '_')
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'FILE_PAYOFF_DATE';
    l_rowupd(l_rowupd.last).oldval  := :old.file_payoff_date;
    l_rowupd(l_rowupd.last).newval  := :new.file_payoff_date;
  end if;

  if nvl(:old.payoff_date, to_date('01.01.2000','dd.mm.yyyy')) !=
     nvl(:new.payoff_date, to_date('01.01.2000','dd.mm.yyyy'))
  then
    l_rowupd.extend;
    l_rowupd(l_rowupd.last).rowid   := :old.info_id;
    l_rowupd(l_rowupd.last).colname := 'PAYOFF_DATE';
    l_rowupd(l_rowupd.last).oldval  := to_char(:old.payoff_date,'dd.mm.yyyy');
    l_rowupd(l_rowupd.last).newval  := to_char(:new.payoff_date,'dd.mm.yyyy');
  end if;

  if ( l_rowupd.count > 0 )
  then

    l_kf     := :old.KF;
    l_branch := :old.BRANCH;
    l_bdat   := GL.BD();
    l_user   := GL.USR_ID();

    forall i in l_rowupd.first .. l_rowupd.last
    insert
      into DPT_FILE_ROW_UPD
      ( REC_ID, KF, BRANCH, USER_ID, SYSDAT, BNKDAT, ROW_ID, COLUMNAME, OLD_VALUE, NEW_VALUE )
    values
      ( s_dptfilerowupd.nextval, l_kf, l_branch, l_user, sysdate, l_bdat
      , l_rowupd(i).rowid, l_rowupd(i).colname, l_rowupd(i).oldval, l_rowupd(i).newval );

    l_rowupd.delete;

  end if;

end TU_DPTFILEROW_UPD;
/

show errors;
