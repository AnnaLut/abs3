
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/obpc.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.OBPC is

g_head_version constant varchar2(64)  := 'Version 5.1 14/08/2017';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

-------------------------------------------------------------------------------
-- get_transit
-- функция получения транзитного счета для оплаты операций ПЦ
--
function get_transit (
  p_tran_type  varchar2,
  p_acc        number ) return varchar2;

-------------------------------------------------------------------------------
-- get_tr2924cash
-- функция получения транзитного счета 2924 для кассовых операций
--   (используется в настройке операций)
--
function get_tr2924cash (p_nls varchar2, p_kv number) return varchar2;

-------------------------------------------------------------------------------z
-- get_p_file_name
-- процедура получения имени файла P для ПЦ
--
procedure get_p_file_name (
  p_file_tip    in varchar2,
  p_file_name  out varchar2);

-------------------------------------------------------------------------------
-- set_form_flag
-- процедура установки флага отбора документа в файл для ПЦ
--
procedure set_form_flag (
  p_doctype   number,
  p_ref       number,
  p_dk        number,
  p_filename  pkk_que.f_n%type,
  p_filedate  pkk_que.f_d%type,
  p_cardacct  varchar2,
  p_trantype  varchar2,
  p_s         number );

-------------------------------------------------------------------------------
-- set_unform_flag
-- процедура снятия флага отбора документа в файл для ПЦ
--
procedure set_unform_flag (
  p_doctype  number,
  p_ref      number,
  p_dk       number );

-------------------------------------------------------------------------------
-- set_sparam
-- процедура установки спецпараметров счетов
--
procedure set_sparam (p_mode varchar2, p_acc number);

-------------------------------------------------------------------------------
-- bpk_deal
-- процедура заведения договора по БПК
--
procedure bpk_deal (
  p_rnk          number,
  p_kv           number,
  p_ob22         varchar2,
  p_kl           number,
  p_dp           number,
  p_nd       out number,
  p_err_code out number,
  p_err_msg  out varchar2 );

-------------------------------------------------------------------------------
-- pk_deal
-- процедура заведения договора по БПК
--
procedure pk_deal (
  p_rnk     number,
  p_tip     varchar2,
  p_kv      number,
  p_ob22    varchar2,
  p_branch  varchar2,
  p_kl      number,
  p_dp      number,
  p_nd  out number );

-------------------------------------------------------------------------------
-- open_acc
-- процедура открытия счета
--
procedure open_acc (
  p_nd      number,
  p_mode    varchar2,
  p_acc out number );

-------------------------------------------------------------------------------
-- check_acc
-- процедура проверки карточного счета при регистрации счета
--
procedure check_acc (p_acc number);

-------------------------------------------------------------------------------
-- import data
-- процедура заполнения таблиц obpc после импорта файлов acct, tran
--
procedure import_data (
  p_file_name      varchar2,
  p_file_id    out number );

-------------------------------------------------------------------------------
-- set_acc_params
-- Процедура обновления счетов по файлу acct*.dbf
--
procedure set_acc_params (p_file_id number);

-------------------------------------------------------------------------------
-- del_pkkque
-- процедура удаления документа из очереди на отправку в ПЦ
--
procedure del_pkkque (
  p_doctype  number,
  p_ref      number,
  p_dk       number );

-------------------------------------------------------------------------------
-- set_kvt_flag
-- процедура установки флага квитовки после квитовки документов
--
procedure set_kvt_flag (
  p_file_id  number,
  p_idn      number,
  p_ref      number,
  p_dk       number );

-------------------------------------------------------------------------------
-- pay_oper
-- процедура оплаты документов ПЦ
--
procedure pay_oper (p_file_id number);

-------------------------------------------------------------------------------
-- kvt_oper
-- процедура квитовки операций банка
--
procedure kvt_oper (p_file_id number);

-------------------------------------------------------------------------------
-- set_acc_limit
-- процедура установки лимитов на карточных счетах по принятому файлу acct*.dbf из ПЦ
--
procedure set_acc_limit (p_acc number, p_limit number, p_flag number);

-------------------------------------------------------------------------------
-- pk_ovr
-- процедура открытия/гашения овердрафта и учета неисп. лимита
--
procedure pk_ovr (p_mode int);

-------------------------------------------------------------------------------
-- arc_pc_files
-- процедура архивации файлов ПЦ
--
procedure arc_pc_files (p number);

-------------------------------------------------------------------------------
-- set_doc_cardacct
-- процедура установки доп.рекв. "Технический счет" для документа
--
procedure set_doc_cardacct (p_ref number, p_dk number, p_cardacct varchar2);

-------------------------------------------------------------------------------
-- sync_reference
-- процедура синхронизации справочников ПЦ
--
procedure sync_reference (p_ref varchar2, p_msg out varchar2);

-------------------------------------------------------------------------------
-- pay_dp
-- процедура начисления депозитов
--
procedure pay_dp (p_mode number);

-------------------------------------------------------------------------------
-- pay_elplat
-- процедура начисления зарплаты
--
procedure pay_elplat (p_mode number);

-------------------------------------------------------------------------------
-- delete_tran
-- удаление необработанных транзакций в архив
--
procedure delete_tran (p_idn number);

-------------------------------------------------------------------------------
-- load_xml_file
-- загрузка файла xml (зарплатный файл)
--
procedure load_xml_file (p_par number);

-------------------------------------------------------------------------------
-- pay_clob
--
procedure pay_clob (
  p_transit_acc  accounts.acc%type,
  p_filename     operw.value%type,
  p_buffer       clob ,
  p_file_id   out   number
 );

-------------------------------------------------------------------------------
-- pay_xml_file
-- оплата зарплатного файла xml
--
procedure pay_xml_file (
  p_transit_acc  accounts.acc%type,
  p_filename     operw.value%type );

-------------------------------------------------------------------------------
-- imp_acct
--
procedure imp_acct(p_id number);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.OBPC is

g_body_version constant varchar2(64)  := 'Version 8.5 14/08/2017';
g_body_defs    constant varchar2(512) := '';

g_modcode      constant varchar2(3)   := 'BPK';
g_nazn_dovr    constant varchar2(160) := 'Авто-відкриття кредиту';
g_nazn_kovr    constant varchar2(160) := 'Погашення кредиту';
g_nazn_k2208   constant varchar2(160) := 'Погашення процентів за користування кредитом';
g_nazn_k2207   constant varchar2(160) := 'Погашення простроченої заборгованості за кредитом';
g_nazn_k2209   constant varchar2(160) := 'Погашення прострочених нарахованих процентів за користування кредитом';
g_nazn_k3570   constant varchar2(160) := 'Погашення нарахованих комісій';
g_nazn_k3579   constant varchar2(160) := 'Погашення прострочених нарахованих комісій';
g_nazn_9129    constant varchar2(160) := 'Врегулювання зобов''язання за кредитною лінією по БПК';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header OBPC ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body OBPC ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
-- get_deal_id
-- функция получения ид. сделки по сиквенсу
--
function get_deal_id return number
is
  l_deal_id number;
begin
  select bars_sqnc.get_nextval('S_OBPCDEAL') into l_deal_id from dual;
  return l_deal_id;
end get_deal_id;

-------------------------------------------------------------------------------
function get_account_acc (p_nls varchar2, p_lcv varchar2) return number
is
  l_acc number;
begin
  begin
     select a.acc into l_acc
       from accounts a, tabval$global t
      where a.kv  = t.kv
        and a.nls = p_nls
        and t.lcv = p_lcv;
  exception when no_data_found then l_acc := null;
  end;

  return l_acc;
end;

-------------------------------------------------------------------------------
procedure get_account (p_acc in number, p_nls out varchar2, p_nms out varchar2)
is
  l_nls accounts.nls%type;
  l_nms accounts.nms%type;
begin
  begin
     select nls, substr(nms,1,38)
       into l_nls, l_nms
       from accounts
      where acc = p_acc and dazs is null;
  exception when no_data_found then
     l_nls := null;
     l_nms := null;
  end;
  p_nls := l_nls;
  p_nms := l_nms;
end get_account;

-------------------------------------------------------------------------------
-- get_transit
-- функция получения транзитного счета для оплаты операций ПЦ
--
function get_transit (
  p_tran_type  varchar2,
  p_acc        number ) return varchar2
is
  l_transit  varchar2(14);
begin

  begin
     select b.nls into l_transit
       from obpc_trans_tran t, accounts a, accounts b
      where a.acc = p_acc and a.dazs is null
        and t.tran_type = p_tran_type
        and t.tip = a.tip
        and t.kv = a.kv
        and t.branch = substr(a.tobo,1,15)
        and t.transit_acc = b.acc;
  exception when no_data_found then
     l_transit := null;
  end;

  return l_transit;

end get_transit;

-------------------------------------------------------------------------------
-- get_tr2924cash
-- функция получения транзитного счета 2924 для кассовых операций
--   (используется в настройке операций)
--
function get_tr2924cash (p_nls varchar2, p_kv number) return varchar2
is
  l_acc        number;
  l_tran_type  varchar2(2) := '18'; -- Внесення гот_вки на поповнення картрахунку
  l_transit    varchar2(14);
  l_branch     varchar2(30);
begin

  select acc, tobo into l_acc, l_branch
    from accounts
   where nls = p_nls and kv = p_kv;

  l_transit := get_transit(l_tran_type, l_acc);

  if l_transit is null then
     bars_error.raise_nerror(g_modcode, 'TRCASH_NOT_FOUND', l_branch);
  end if;

  return l_transit;

end get_tr2924cash;

-------------------------------------------------------------------------------
-- get_p_file_name
-- процедура получения имени файла P для ПЦ
--
procedure get_p_file_name (
  p_file_tip    in varchar2,
  p_file_name  out varchar2)
-- Структура файлу. 'P' С NN NNN N . NNN
-- + Тип картки (C - Cirrus/Maestro) (A - EC/MC, B-VISA, D-VISA etc.)
-- + Код банку (NN)
-- + Філія (NNN)
-- + Порядковий номер файлу (N)
-- + '.'
-- + Дата (NNN) /Julian date/
is
  l_bank_code    varchar2(2) := '04';
  l_branch_code  varchar2(3);
  l_file_d       date;
  l_file_n       number;
  l_file_s       varchar2(1);
  l_file_ext     varchar2(3);
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  l_branch_code := substr('000' || GetGlobalOption('PC_KF'), -3);

  l_file_d := sysdate;

  select nvl(min(decode(trunc(l_file_d), trunc(file_date), file_n, 0)),0)+1 n
    into l_file_n
    from obpc_file_n
   where file_char = p_file_tip;

  if l_file_n = 1 then
     l_file_n := nvl(getglobaloption('PC_FILEN'),1);
  end if;

  l_file_s := iif_n(l_file_n,9,to_char(l_file_n),to_char(l_file_n),iif_s(l_file_n,36,chr(l_file_n+55),'',''));

  -- № дня в году
  l_file_ext := substr('000' || to_char(trunc(l_file_d,'dd')-trunc(l_file_d,'yyyy')+1), -3);

  p_file_name := 'P' || p_file_tip || l_bank_code || l_branch_code || l_file_s || '.' || l_file_ext;

  update obpc_file_n
     set file_n    = l_file_n,
         file_date = l_file_d
   where file_char = p_file_tip;
*/
end get_p_file_name;

-------------------------------------------------------------------------------
-- set_form_flag
-- процедура установки флага отбора документа в файл для ПЦ
--
procedure set_form_flag (
  p_doctype   number,
  p_ref       number,
  p_dk        number,
  p_filename  pkk_que.f_n%type,
  p_filedate  pkk_que.f_d%type,
  p_cardacct  varchar2,
  p_trantype  varchar2,
  p_s         number )
is
  l_nls varchar2(14);
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  if p_doctype = 1 then

     update pkk_que
        set sos = 1,
            f_n = p_filename,
            f_d = p_filedate,
            card_acct = p_cardacct,
            tran_type = p_trantype,
            s = p_s
      where ref = p_ref
        and dk  = p_dk;

     -- пополнение
     if p_dk = 1 then

        -- добавление доп. реквизита "Технический счет"
        begin
           insert into operw (ref, tag, value)
           values (p_ref, 'CDAC', p_cardacct);
        exception when dup_val_on_index then
           update operw set value = p_cardacct where ref = p_ref and tag = 'CDAC';
        end;

        -- добавление доп. реквизита "Отправлен в файле"
        begin
           insert into operw (ref, tag, value)
           values (p_ref, 'OBFL', p_filename);
        exception when dup_val_on_index then
           update operw set value = p_filename where ref = p_ref and tag = 'OBFL';
        end;

        -- добавление доп. реквизита "Дата отправки"
        begin
           insert into operw (ref, tag, value)
           values (p_ref, 'OBDT', to_char(p_filedate,'dd/mm/yyyy hh24:mi:ss'));
        exception when dup_val_on_index then
           update operw set value = to_char(p_filedate,'dd/mm/yyyy hh24:mi:ss') where ref = p_ref and tag = 'OBDT';
        end;

     -- списание
     else

        -- добавление доп. реквизита "Технический счет"
        begin
           insert into operw (ref, tag, value)
           values (p_ref, 'CDAC2', p_cardacct);
        exception when dup_val_on_index then
           update operw set value = p_cardacct where ref = p_ref and tag = 'CDAC2';
        end;

        -- добавление доп. реквизита "Отправлен в файле"
        begin
           insert into operw (ref, tag, value)
           values (p_ref, 'OBFL2', p_filename);
        exception when dup_val_on_index then
           update operw set value = p_filename where ref = p_ref and tag = 'OBFL2';
        end;

        -- добавление доп. реквизита "Дата отправки"
        begin
           insert into operw (ref, tag, value)
           values (p_ref, 'OBDT2', to_char(p_filedate,'dd/mm/yyyy hh24:mi:ss'));
        exception when dup_val_on_index then
           update operw set value = to_char(p_filedate,'dd/mm/yyyy hh24:mi:ss') where ref = p_ref and tag = 'OBDT2';
        end;

     end if;

  elsif p_doctype = 2 then

     begin
        select nls into l_nls from pkk_inf where rec = p_ref;
     exception when no_data_found then
        l_nls := null;
     end;

     insert into pkk_inf_history (rec, nls, f_n, f_d, card_acct, tran_type, s)
     values (p_ref, l_nls, p_filename, p_filedate, p_cardacct, p_trantype, p_s);

     delete from pkk_inf where rec = p_ref;

  end if;
  */
end set_form_flag;

-------------------------------------------------------------------------------
-- set_unform_flag
-- процедура снятия флага отбора документа в файл для ПЦ
--
procedure set_unform_flag (
  p_doctype  number,
  p_ref      number,
  p_dk       number )
is
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  if p_doctype = 1 then

     update pkk_que
        set sos = 0,
            f_n = null,
            f_d = null
      where ref = p_ref
        and dk  = p_dk;

     -- изменение доп. реквизита "Отправлен в файле"
     if p_dk = 1 then
        update operw set value = value || '-розформовано' where ref = p_ref and tag = 'OBFL';
     else
        update operw set value = value || '-розформовано' where ref = p_ref and tag = 'OBFL2';
     end if;

  elsif p_doctype = 2 then

     -- возвращаем документ из истории
     for z in ( select nls from pkk_inf_history where rec = p_ref )
     loop
        insert into pkk_inf (rec, nls)
        values (p_ref, z.nls);

        delete from pkk_inf_history where rec = p_ref;
     end loop;

  end if;
*/
end set_unform_flag;

-------------------------------------------------------------------------------
-- set_sparam
-- процедура установки спецпараметров счетов
--
procedure set_sparam (p_mode varchar2, p_acc number)
is
  l_nd      number;
  l_pk_tip  accounts.tip%type;
  l_pk_nbs  accounts.nbs%type;
  l_pk_ob22 accounts.ob22%type;
  l_ob22    varchar2(2);
  l_s080    varchar2(1);
  l_s180    varchar2(1);
  l_s181    varchar2(1);
  l_s240    varchar2(2);
  l_s260    varchar2(2);
  l_s270    varchar2(2);
  l_r011    varchar2(1);
  l_r013    varchar2(1);
  l_s031    varchar2(2);
  l_nkd     specparam.nkd%type;
begin

  select min(nd) into l_nd
    from bpk_acc
   where p_acc = decode(p_mode, '2625', acc_pk,
         '2202', acc_ovr, '2208', acc_2208, '3570', acc_3570, '9129', acc_9129);

  select a.tip, a.nbs, a.ob22 into l_pk_tip, l_pk_nbs, l_pk_ob22
    from bpk_acc o, accounts a
   where o.acc_pk = a.acc and o.nd = l_nd;

  l_nkd := 'БПК_' || l_nd;

  if p_mode <> '2625' then
     begin
        select decode(p_mode, '2202', ob_2202, '2208', ob_2208, '3570', ob_3570, '9129', ob_9129)
          into l_ob22
          from bpk_nbs_ob22
         where tip  = l_pk_tip
           and nbs  = l_pk_nbs
           and ob22 = l_pk_ob22;
     exception when no_data_found then
        begin
           select decode(p_mode, '2202', ob_2202, '2208', ob_2208, '3570', ob_3570, '9129', ob_9129)
             into l_ob22
             from bpk_nbs_ob22
            where tip  = l_pk_tip
              and nbs  = l_pk_nbs
              and rownum = 1;
        exception when no_data_found then
           l_ob22 := '00';
        end;
     end;
  end if;

  -- карточный счет
  if p_mode = '2625' then

     -- R011 только для 2625
     --   -> 9 для ob22=16
     --   -> 1 для остальных
     select decode(nbs, '2625', decode(ob22,'16','9','1'), null)
       into l_r011
       from accounts
      where acc = p_acc;

     l_s080 := '1';
     l_s180 := null;
     l_s181 := null;
     l_s240 := '1';
     l_s260 := '08';
     l_s270 := null;
     l_r013 := '1';
     l_s031 := null;

  -- кредитный счет
  elsif p_mode = '2202' then

     begin
        select decode(nbs,'2202','5',null)
          into l_s240
          from accounts
         where acc = p_acc;
     exception when no_data_found then
        l_s240 := null;
     end;

     l_s080 := '1';
     l_s180 := 'B';
     l_s181 := null;
     l_s260 := '08';
     l_s270 := null;
     l_r011 := null;
     l_r013 := null;
     l_s031 := '33';

  -- счет проц. дох. за польз. кред. 2208
  elsif p_mode = '2208' then

     -- ob22, s080
     begin
        select nvl(s.s080,'1') s080,
               decode(l_pk_nbs, '2625', nvl(s.s180,'B'), null) s180,
               decode(l_pk_nbs, '2625', '1', nvl(s.s181,'1'))  s181,
               decode(l_pk_nbs, '2625', nvl(s.s240,'B'), nvl(s.s240,'6')) s240,
               nvl(s.s260,'08') s260,
               nvl(s.s270,'01') s270,
               decode(l_pk_nbs, '2625', 'E', 'A')  r011,
               decode(l_pk_nbs, '2625', '3', null) r013
          into l_s080, l_s180, l_s181, l_s240, l_s260, l_s270,
               l_r011, l_r013
          from bpk_acc o, specparam s
         where o.acc_2208 = p_acc
           and o.acc_ovr  = s.acc(+);
     exception when no_data_found then
        l_s080 := '1';
        l_s180 := null;
        l_s181 := '1';
        l_s240 := null;
        l_s260 := '08';
        l_s270 := '01';
        l_r011 := 'E';
        l_r013 := '3';
     end;

     l_s031 := null;

  -- счет комиссий 3570
  elsif p_mode = '3570' then

     l_s080 := '1';
     l_s180 := '1';
     l_s181 := null;
     l_s240 := '1';
     l_s260 := null;
     l_s270 := null;
     l_r011 := null;
     l_r013 := '3';
     l_s031 := null;

  -- счет неисп. лимита 9129
  elsif p_mode = '9129' then

     -- s080, s180 - по 2202(кред. счет), ob22 - по 2625(карт.счет)
     begin
        select nvl(s.s080,'1'), nvl(s.s180,'1'), nvl(s.s240,'1')
          into l_s080, l_s180, l_s240
          from bpk_acc o, specparam s
         where o.acc_9129 = p_acc
           and o.acc_ovr  = s.acc(+);
     exception when no_data_found then
        l_s080 := '1';
        l_s180 := '1';
        l_s240 := '1';
     end;

     l_s181 := null;
     l_s260 := null;
     l_s270 := null;
     l_r011 := null;
     l_r013 := '1';
     l_s031 := null;

  end if;

  -- заносим значения в specparam
  if l_s080 is not null
  or l_s180 is not null
  or l_s181 is not null
  or l_s240 is not null
  or l_s260 is not null
  or l_s270 is not null
  or l_r011 is not null
  or l_r013 is not null
  or l_s031 is not null then
     update specparam
        set s080 = l_s080,
            s180 = l_s180,
            s181 = l_s181,
            s240 = l_s240,
            s260 = l_s260,
            s270 = l_s270,
            r011 = l_r011,
            r013 = l_r013,
            s031 = l_s031,
            nkd  = nvl(nkd, l_nkd)
      where acc = p_acc;
     if sql%rowcount = 0 then
        insert into specparam (acc, s080, s180, s181, s240, s260, s270, r011, r013, s031, nkd)
        values (p_acc, l_s080, l_s180, l_s181, l_s240, l_s260, l_s270, l_r011, l_r013, l_s031, l_nkd);
     end if;
  end if;

  -- заносим значения в specparam_int
  if l_ob22 is not null then
     update specparam_int set ob22 = l_ob22
      where acc = p_acc;
     if sql%rowcount = 0 then
        insert into specparam_int (acc, ob22)
        values (p_acc, l_ob22);
     end if;
  end if;

exception when no_data_found then null;
end set_sparam;

-------------------------------------------------------------------------------
-- open_acc
-- процедура открытия счета
--
procedure open_acc (
  p_nd      number,
  p_mode    varchar2,
  p_acc out number )
is
  l_mfo          varchar2(6);
  l_nbs          varchar2(4);
  l_pk_rnk       number;
  l_pk_custtype  number;
  l_pk_nmk       varchar2(70);
  l_pk_acc       number;
  l_pk_nls       varchar2(14);
  l_pk_nbs       varchar2(4);
  l_pk_nms       varchar2(70);
  l_pk_kv        number;
  l_pk_isp       number;
  l_pk_tobo      varchar2(30);
  l_nls          varchar2(14);
  l_nms          varchar2(70);
  l_acc          number;
  l_tmp          varchar2(14);
  l_p4           number;
  i number;
begin

  l_mfo := gl.amfo;

  -- параметры счета
  select c.rnk, c.nmk,
         case
           when a.nbs = '2625' then 3
           else 2
         end custtype, a.acc, a.nls, a.nbs, a.nms, a.kv, a.isp, a.tobo
    into l_pk_rnk, l_pk_nmk, l_pk_custtype,
         l_pk_acc, l_pk_nls, l_pk_nbs, l_pk_nms, l_pk_kv, l_pk_isp, l_pk_tobo
    from bpk_acc o, accounts a, customer c
   where o.nd     = p_nd
     and o.acc_pk = a.acc
     and a.rnk    = c.rnk;

  -- определение БС
  -- 2202 ------------------
  if p_mode = '2202' then
     if l_pk_custtype = 3 then
        l_nbs := '2202';
     else
        l_nbs := '2062';
     end if;
     l_nms := substr('Кред. ' || l_pk_nms, 1, 70);
  -- 2208 ------------------
  elsif p_mode = '2208' then
     if l_pk_custtype = 3 then
        l_nbs := '2208';
     else
        if l_pk_nbs = '2605' then
           l_nbs := '2068';
        else       -- '2655'
           l_nbs := '2658';
        end if;
     end if;
     l_nms := substr('Нарах.дох.за кред. ' || l_pk_nmk, 1, 70);
  -- 3570 ------------------
  elsif p_mode = '3570' then
     l_nbs := '3570';
     l_nms := substr('Нарах.дох. ' || l_pk_nmk, 1, 70);
  -- 9129 ------------------
  elsif p_mode = '9129' then
     l_nbs := '9129';
     l_nms := substr('Невикор.ліміт ' || l_pk_nls, 1, 70);
  end if;

  -- определение счета:
  --   сначала по маске картсчета,
  --   если он занят, ищем свободный по порядку
  begin
     -- сначала ищем по маске карточного счета pk_nls
     l_nls := vkrzn(substr(l_mfo,1,5), l_nbs || '0' || substr(l_pk_nls,6,9));
     select nls into l_tmp from accounts where nls = l_nls and kv = l_pk_kv;

     -- счет нашли, он занят, определяем свободный
     i := 0;
     loop
        -- ищем счет
        l_nls := vkrzn(substr(l_mfo,1,5),
          l_nbs || '0' || lpad(to_char(i), 2, '0') || lpad(to_char(l_pk_rnk), 7, '0'));
        begin
           select nls into l_tmp from accounts where nls = l_nls and kv = l_pk_kv;
        exception when no_data_found then
           -- такого счета еще нет, нужно открыть
           exit;
        end;
        i := i + 1;
        if i = 100 then
           exit;
        end if;
     end loop;
  exception when no_data_found then null;
  end;

  -- открытие счета
  op_reg_ex(99, 0, 0, null, l_p4, l_pk_rnk,
     l_nls, l_pk_kv, l_nms, 'ODB', l_pk_isp, l_acc,
     '1', null, null, null, null, null, null, null, null, null, null, null,
     l_pk_tobo);

  -- добавление в таблицу договоров по БПК
  if p_mode = '2202' then
     update bpk_acc set acc_ovr  = l_acc where nd = p_nd;
  elsif p_mode = '2208' then
     update bpk_acc set acc_2208 = l_acc where nd = p_nd;
  elsif p_mode = '3570' then
     update bpk_acc set acc_3570 = l_acc where nd = p_nd;
  elsif p_mode = '9129' then
     update bpk_acc set acc_9129 = l_acc where nd = p_nd;
  end if;

  -- доступ как для карточного счета
  p_setAccessByAccmask(l_acc, l_pk_acc);

  -- спецпараметры
  set_sparam(p_mode, l_acc);

  p_acc := l_acc;

end open_acc;

-------------------------------------------------------------------------------
-- add_deal
-- добавление договора в портфель БПК
--
procedure add_deal (p_acc in number, p_nd out number)
is
  l_nd number;
begin

  begin
     select nd into l_nd from bpk_acc where acc_pk = p_acc;
  exception when no_data_found then
     select bars_sqnc.get_nextval('S_OBPCDEAL') into l_nd from dual;
     insert into bpk_acc (nd, acc_pk) values (l_nd, p_acc);
  end;

  p_nd := l_nd;

end add_deal;

-------------------------------------------------------------------------------
-- bpk_deal
-- процедура заведения договора по БПК
--
procedure bpk_deal (
  p_rnk          number,      /* РНК */
  p_kv           number,      /* код валюты */
  p_ob22         varchar2,    /* ob22 для картсчета */
  p_kl           number,      /* признак кредитной линии */
  p_dp           number,      /* признак депозита: =1 - 2635 - не используется */
  p_nd       out number,      /* номер договора */
  p_err_code out number,      /* 0-нет ошибки, 1-ошибка */
  p_err_msg  out varchar2     /* текст ошибки */
)
is
  l_tip  varchar2(3);         /* тип счета */
begin

  p_err_code := 0;
  p_err_msg  := null;

  select tip into l_tip from obpc_tips where ob22 = p_ob22;

  pk_deal(p_rnk, l_tip, p_kv, p_ob22, null, p_kl, p_dp, p_nd);

exception when others then
  p_err_code := 1;
  p_err_msg  := sqlerrm;
end bpk_deal;

-------------------------------------------------------------------------------
-- pk_deal
-- процедура заведения договора по БПК
--
procedure pk_deal (
  p_rnk     number,      /* РНК */
  p_tip     varchar2,    /* тип счета */
  p_kv      number,      /* код валюты */
  p_ob22    varchar2,    /* ob22 для картсчета */
  p_branch  varchar2,    /* код отделения */
  p_kl      number,      /* признак кредитной линии */
  p_dp      number,      /* признак депозита: =1 - 2635 - не используется */
  p_nd  out number       /* номер договора */
)
is
  l_custtype  customer.custtype%type;
  l_sed       customer.sed%type;
  l_nbs_pk    varchar2(4);
  l_nls_pk    varchar2(14);
  l_nms_pk    varchar2(70);
  l_acc_pk    number;
  l_nbs_ovr   varchar2(4);
  l_nls_ovr   varchar2(14);
  l_nms_ovr   varchar2(70);
  l_acc_ovr   number;
  l_grp       number;
  l_ob22      varchar2(2);
  l_tmp       number;
  l_nd        number;
  l_vid       number;
  l_mfo       varchar2(6);
  i           number;
  h varchar2(30) := 'obpc.pk_deal: ';
begin

  bars_audit.trace(h || 'Start: p_rnk=>' || p_rnk || ', p_tip=>' || p_tip ||
       ', p_kv=>' || p_kv || ', p_kl=>' || p_kl || ', p_dp=>' || p_dp || ', p_nd=>' || p_nd);

  -- тип клиента custtype
  select custtype, nvl(trim(sed),'00') into l_custtype, l_sed
    from customer
   where rnk = p_rnk;

  -- физ. лицо
  if l_custtype = 3 and l_sed <> '91' then
     l_vid := 0;
     l_nbs_pk := '2625';
  -- юр. лицо / физ. лицо-предприниматель
  else
     l_vid := 1;
     l_nbs_pk := '2605';
  end if;

  -- 1. карточный счет -------
  select f_newnls2(null, p_tip, l_nbs_pk, p_rnk, null, p_kv),
         f_newnms (null, p_tip, l_nbs_pk, p_rnk, null)
    into l_nls_pk, l_nms_pk
    from dual;

  -- проверка: счет не занят
  begin
     select 1 into l_tmp from accounts where nls = l_nls_pk and kv = p_kv;

     -- счет нашли, он занят, определяем свободный
     l_mfo := gl.amfo;
     i := 0;
     loop
        -- ищем счет
        l_nls_pk := vkrzn(substr(l_mfo,1,5),
          l_nbs_pk || '0' || lpad(to_char(i), 2, '0') || lpad(to_char(p_rnk), 7, '0'));

        begin
           select 1 into l_tmp from accounts where nls = l_nls_pk and kv = p_kv;
        exception when no_data_found then
           -- такого счета еще нет, нужно открыть
           exit;
        end;
        i := i + 1;
        if i = 100 then
           exit;
        end if;
     end loop;
  exception when no_data_found then null;
  end;

  l_grp := null;
  l_tmp := 0;

  -- открытие карточного пассивного счет
  op_reg_lock(99, 0, 0, l_grp, l_tmp, p_rnk, l_nls_pk, p_kv, l_nms_pk,
     p_tip, user_id, l_acc_pk, '1', 2,
     l_vid, null, null, null, null, null, null, null, null, null, p_branch);

  -- добавление в портфель БПК
  add_deal(l_acc_pk, l_nd);

  -- specparam_int: OB22
  if p_ob22 is not null then
     accreg.setAccountSParam(l_acc_pk, 'OB22', p_ob22);
  end if;

  -- specparams:
  set_sparam('2625', l_acc_pk);

  -- 2. кредит --------------
  if p_kl = 1 then

     open_acc(l_nd, '2202', l_acc_ovr);

  end if;

  p_nd := l_nd;

  bars_audit.trace(h || 'Finish. New deal with id ' || p_nd || ' opened.');

end pk_deal;

-------------------------------------------------------------------------------
-- import data
-- процедура заполнения таблиц obpc после импорта файлов acct, tran
--
procedure import_data (
  p_file_name      varchar2,
  p_file_id    out number )
is
  refcur SYS_REFCURSOR;
  l_file_id    number;
  l_count      number;
  l_str        varchar2(2000);
  l_region     varchar2(2);
  l_region_n   varchar2(10);
  l_branch     varchar2(5);
  l_branch_n   varchar2(35);
  l_mfo        varchar2(6);
  l_client     varchar2(6);
  l_type       varchar2(1);
  l_card_acct  varchar2(10);
  l_acc_type   varchar2(2);
  l_currency   varchar2(3);
  l_lacct      varchar2(25);
  l_client_n   varchar2(40);
  l_street     varchar2(30);
  l_city       varchar2(15);
  l_cntry      varchar2(15);
  l_pcode      varchar2(6);
  l_status     varchar2(1);
  l_post_date  date;
  l_crd        number(38,2);
  l_begin_bal  number(38,2);
  l_debit      number(38,2);
  l_credit     number(38,2);
  l_end_bal    number(38,2);
  l_avail_amt  number(38,2);
  l_mprew_bal  number(38,2);
  l_used_amnt  number(38,2);
  l_deposit    number(38,2);
  l_obu        number(38);
  l_card_type  number(38);
  l_open_date  date;
  l_works      varchar2(30);
  l_office     varchar2(25);
  l_quan_card  number(38);
  l_expiry     date;
  l_stop_date  date;
  l_min_bal    number(38,2);
  l_cond_set   number(38);
  l_serv_code  varchar2(2);
  l_reg_nr     varchar2(10);
  l_id_numb    varchar2(14);
  l_acc        number;
  g_mfo        varchar2(6);
  g_branch     varchar2(30);
  h varchar2(30) := 'obpc.import_data: ';
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.trace(h || 'Start. p_file_name=>' || p_file_name);

  select branch_usr.get_branch into g_branch from dual;
  if length(g_branch) <> 8 then
     -- Пользователю отделения g_branch запрещено выполнять данную функцию
     bars_error.raise_nerror(g_modcode, 'EXEC_FUNCTION_DENIED', g_branch);
  end if;

  select bc.extract_mfo into g_mfo from dual;

  select s_obpc_files.nextval into l_file_id from dual;
  bars_audit.trace(h || 'new l_file_id=>' || l_file_id);

  insert into obpc_files (id, file_name, file_date)
  values (l_file_id, p_file_name, sysdate);
  bars_audit.trace(h || 'info about file inserted to obpc_files.');

  -- проверка: ACCT и TRAN урезаны?
  select count(*) into l_count
    from all_tab_columns
   where table_name = 'TEST_OBPC_ACCT_' || g_mfo
     and column_name = 'REGION';

  if l_count = 1 then
     l_str := 'region, region_n, branch_n, obu, ';
  else
     l_str := 'null, null, null, null, ';
  end if;

  open refcur for
    'select ' || l_str || 'branch, mfo,
        client, type, card_acct, acc_type, currency, lacct, client_n,
        street, city, cntry, pcode, status, post_date, crd, begin_bal,
        debit, credit, end_bal, avail_amt, mprev_bal, used_amnt,
        card_type, open_date, works, office, quan_card, expiry, stop_date,
        cond_set, id_numb, serv_code
     from test_obpc_acct_' || g_mfo || '
     where mfo = ''' || g_mfo || '''';

  loop
     fetch refcur into l_region, l_region_n, l_branch_n, l_obu, l_branch, l_mfo,
        l_client, l_type, l_card_acct, l_acc_type, l_currency, l_lacct, l_client_n,
        l_street, l_city, l_cntry, l_pcode, l_status, l_post_date, l_crd, l_begin_bal,
        l_debit, l_credit, l_end_bal, l_avail_amt, l_mprew_bal, l_used_amnt,
        l_card_type, l_open_date, l_works, l_office, l_quan_card, l_expiry, l_stop_date,
        l_cond_set, l_id_numb, l_serv_code;
     exit when refcur%notfound;

     l_acc := get_account_acc(l_lacct, l_currency);

     delete from obpc_acct where card_acct = l_card_acct;


     insert into obpc_acct (id, region, region_n, branch, branch_n, mfo,
        client, type, card_acct, acc_type, currency, lacct, client_n,
        street, city, cntry, pcode, status, post_date, crd, begin_bal,
        debit, credit, end_bal, avail_amt, mprew_bal, used_amnt, obu,
        card_type, open_date, works, office, quan_card, expiry, stop_date,
        cond_set, id_numb, serv_code, acc)
     values (l_file_id, l_region, l_region_n, l_branch, l_branch_n, l_mfo,
        l_client, l_type, l_card_acct, l_acc_type, l_currency, l_lacct, l_client_n,
        l_street, l_city, l_cntry, l_pcode, l_status, l_post_date, l_crd, l_begin_bal,
        l_debit, l_credit, l_end_bal, l_avail_amt, l_mprew_bal, l_used_amnt, l_obu,
        l_card_type, l_open_date, l_works, l_office, l_quan_card, l_expiry, l_stop_date,
        l_cond_set, l_id_numb, l_serv_code, l_acc);
  end loop;
  close refcur;

  bars_audit.trace(h || 'data inserted to obpc_acct.');

  if l_count = 1 then
     l_str := 'tran_name, tran_russ, ';
  else
     l_str := 'null, null, ';
  end if;

  execute immediate '
  insert into obpc_tran (id, card_acct, currency, ccy, tran_date, tran_type,
     card, slip_nr, batch_nr, abvr_name, city, merchant, tran_amt, amount,
     tran_name, tran_russ, post_date, card_type, country, mcc_code, terminal )
  select ' || l_file_id || ',  card_acct, currency, ccy, tran_date, tran_type,
     card, slip_nr, batch_nr, abvr_name, city, merchant, tran_amt, amount, ' ||
     l_str || 'post_date, card_type, country, mcc_code, terminal
    from test_obpc_tran_' || g_mfo;
  bars_audit.trace(h || 'data inserted to obpc_tran.');

  execute immediate 'delete from test_obpc_acct_' || g_mfo;
  execute immediate 'delete from test_obpc_tran_' || g_mfo;

  p_file_id := l_file_id;

  bars_audit.trace(h || 'Finish.');
*/
end import_data;

-------------------------------------------------------------------------------
-- p_oper
-- процедура фактической оплаты документа (для функций овердрафта)
--
procedure p_oper (
  p_tt     oper.tt%type,
  p_vob    oper.vob%type,
  p_dk     oper.dk%type,
  p_nam_a  oper.nam_a%type,
  p_nlsa   oper.nlsa%type,
  p_id_a   oper.id_a%type,
  p_nam_b  oper.nam_b%type,
  p_nlsb   oper.nlsb%type,
  p_id_b   oper.id_b%type,
  p_kv     oper.kv%type,
  p_s      oper.s%type,
  p_nazn   oper.nazn%type )
is
  l_bdate  date;
  l_mfo    varchar2(6);
  l_ref    number;
begin

  l_bdate := gl.bdate;
  l_mfo   := gl.amfo;

  gl.ref (l_ref);

  insert into oper (ref, tt, vob, nd, dk, pdat, vdat, datd,
     nam_a, nlsa, mfoa, id_a,
     nam_b, nlsb, mfob, id_b, kv, s, kv2, s2, nazn, userid)
  values (l_ref, p_tt, p_vob, l_ref, p_dk, sysdate, l_bdate, l_bdate,
     p_nam_a, p_nlsa, l_mfo, p_id_a,
     p_nam_b, p_nlsb, l_mfo, p_id_b, p_kv, p_s, p_kv, p_s, p_nazn, user_id);

  gl.payv(0, l_ref, l_bdate, p_tt, p_dk, p_kv, p_nlsa, p_s, p_kv, p_nlsb, p_s);

  gl.pay(2, l_ref, l_bdate);

end p_oper;

-------------------------------------------------------------------------------
-- can_closeacc
--
--
function can_closeacc (p_acc in number, p_dazs out date) return number
is
  l_cnt  number;  -- признак возможности закрытия счета
begin
  begin
     select 1, dazs into l_cnt, p_dazs
       from accounts b
      where b.acc = p_acc
        and b.ostc = 0
        and b.ostb = 0
        and b.ostf = 0
        and (b.dapp is null or b.dapp < bankdate)
        and b.daos <= bankdate
     for update nowait;
  exception when no_data_found then
     l_cnt  := 0;
     p_dazs := null;
  end;
  return l_cnt;
end can_closeacc;

-------------------------------------------------------------------------------
-- set_acc_limit
-- процедура установки лимитов на карточных счетах по принятому файлу acct*.dbf из ПЦ
--
procedure set_acc_limit (p_acc number, p_limit number, p_flag number)
is
  i number;
  h varchar2(30) := 'obpc.set_acc_limit: ';
begin

  bars_audit.trace(h || 'Start. p_acc=>' || p_acc || ' p_limit=>' || p_limit || ' p_flag=>' || p_flag);

  if p_flag = 1 then
     begin
        select 1 into i from accounts where acc = p_acc for update of lim nowait;
        update accounts set lim = p_limit where acc = p_acc;
     exception when others then
        if ( sqlcode = -00054 ) then null;
        else raise;
        end if;
     end;
  end if;

  bars_audit.trace(h || 'Finish.');

end set_acc_limit;

-------------------------------------------------------------------------------
-- change_acc_params
-- процедура установки параметров счетов по файлу acct
--
procedure change_acc_params (p_file_id number)
is
begin
  -- обновление спецпараметров serv_code, cond_set, branch
  for k in ( select a.acc, a.serv_code, a.cond_set, branch
               from obpc_acct a, specparam_int s
              where a.id  = p_file_id
                and a.acc = s.acc
                and (    s.demand_kk       <> a.serv_code or s.demand_kk       is null
                      or s.demand_cond_set <> a.cond_set  or s.demand_cond_set is null
                      or s.demand_brn      <> a.branch    or s.demand_brn      is null ) )
  loop
     update specparam_int
        set demand_kk = k.serv_code,
            demand_cond_set = k.cond_set,
            demand_brn = k.branch
      where acc = k.acc;
  end loop;

  -- обновление спецпараметра works
  for k in ( select a.acc, a.works
               from obpc_acct a, accountsw w
              where a.id  = p_file_id
                and a.works is not null
                and a.acc = w.acc and w.tag = 'PK_WORK'
                and w.value <> a.works )
  loop
     update accountsw
        set value = k.works
      where acc = k.acc and tag = 'PK_WORK';
  end loop;

  -- добавление спецпараметра works
  for k in ( select a.acc, a.works
               from obpc_acct a
              where a.id  = p_file_id
                and a.acc is not null
                and a.works is not null
                and not exists
                    ( select 1 from accountsw w
                       where w.acc = a.acc and w.tag = 'PK_WORK' ) )
  loop
     -- защита, если на одном карт.счете два технических
     begin
        insert into accountsw (acc, tag, value)
        values (k.acc, 'PK_WORK', k.works);
     exception when dup_val_on_index then null;
     end;
  end loop;

  -- обновление спецпараметра office
  for k in ( select a.acc, a.office
               from obpc_acct a, accountsw w
              where a.id  = p_file_id
                and a.office is not null
                and a.acc = w.acc and w.tag = 'PK_OFFIC'
                and w.value <> a.office )
  loop
     update accountsw
        set value = k.office
      where acc = k.acc and tag = 'PK_OFFIC';
  end loop;

  -- добавление спецпараметра office
  for k in ( select a.acc, a.office
               from obpc_acct a
              where a.id  = p_file_id
                and a.acc is not null
                and a.office is not null
                and not exists
                    ( select 1 from accountsw w
                       where w.acc = a.acc and w.tag = 'PK_OFFIC' ) )
  loop
     -- защита, если на одном карт.счете два технических
     begin
        insert into accountsw (acc, tag, value)
        values (k.acc, 'PK_OFFIC', k.office);
     exception when dup_val_on_index then null;
     end;
  end loop;

end change_acc_params;

-------------------------------------------------------------------------------
-- set_acc_rate
-- процедура установки % ставки
--
procedure set_acc_rate (
  p_mode       varchar2,
  p_acc        number,
  p_card_type  varchar2,
  p_cond_set   varchar2 )
is
  l_ir    int_ratn.ir%type;
  l_bdat  int_ratn.bdat%type;
  l_intr  number(6,2);
  l_id    number;
  l_flag  boolean := false;
  i number;
begin

  -- %% ставка из справочника cond_set
  -- В?дсоток на залишок по рахунку
  if p_mode = 'PK' then
     select cred_intr into l_intr
       from demand_cond_set
      where card_type = p_card_type
        and cond_set  = p_cond_set;
     l_id := 1;
  -- Варт_сть користування кредитом
  elsif p_mode = 'KRED' then
     select deb_intr into l_intr
       from demand_cond_set
      where card_type = p_card_type
        and cond_set  = p_cond_set;
     l_id := 0;
  -- Стягнення за овердрафт
  elsif p_mode = 'OVR' then
     select olim_intr into l_intr
       from demand_cond_set
      where card_type = p_card_type
        and cond_set  = p_cond_set;
     l_id := 0;
  -- Стягнення за прострочені платежі
  elsif p_mode = '2207' then
     select late_intr into l_intr
       from demand_cond_set
      where card_type = p_card_type
        and cond_set  = p_cond_set;
     l_id := 0;
  end if;

  -- текущая % ставка
  begin

     select bdat, ir into l_bdat, l_ir
       from int_ratn i
      where acc  = p_acc
        and id   = l_id
        and bdat = ( select max(bdat)
                       from int_ratn
                      where acc = i.acc and id = i.id and bdat <= bankdate );

     -- если % ставка изменилась, нужно добавить/изменить
     if l_ir <> l_intr then

        -- если дата старая, добавляем
        if l_bdat <> bankdate then

           insert into int_ratn (acc, id, bdat, ir, idu)
           values (p_acc, l_id, bankdate, l_intr, user_id);
           l_flag := true;

        -- если сегодняшняя, меняем
        else

           update int_ratn
              set ir = l_intr
            where acc = p_acc and id = l_id and bdat = bankdate;
           l_flag := true;

        end if;

     end if;

  -- не нашли, нужно добавить
  exception when no_data_found then

     -- наверное, нету и в int_accn
     begin
        select id into i from int_accn where acc = p_acc and id = l_id;
     exception when no_data_found then
        insert into int_accn (acc, id, metr, basem, basey, freq, tt, io)
        values (p_acc, l_id, 0, null, 0, 1, '%%1', 0);
        l_flag := true;
     end;

     -- дата установки = дата первого движения по счету / банковская дата
     select nvl(min(fdat),bankdate) into l_bdat
       from saldoa
      where acc = p_acc and (dos<>0 or kos<>0);

     -- добавляем
     insert into int_ratn (acc, id, bdat, ir, idu)
     values (p_acc, l_id, l_bdat, l_intr, user_id);
     l_flag := true;

  end;

  if l_flag then
     commit;
  end if;

exception when no_data_found then null;
end set_acc_rate;

-------------------------------------------------------------------------------
-- set_accounts_rate
-- процедура установки % ставки для кред. счетов
--
procedure set_accounts_rate (p_file_id number)
is
begin

  -- установка % ставки для карт.счета
  -- установка % ставки для технического овердрафта (2625-A)
  for k in ( select o.acc_pk, t.card_type, t.cond_set
               from obpc_acct t, bpk_acc o, demand_cond_set d, accounts b
              where t.id = p_file_id
                and t.acc = o.acc_pk
                and o.acc_pk = b.acc and b.dazs is null
                and t.card_type = d.card_type
                and t.cond_set  = d.cond_set )
  loop
     set_acc_rate('PK',  k.acc_pk, k.card_type, k.cond_set);
     set_acc_rate('OVR', k.acc_pk, k.card_type, k.cond_set);
  end loop;

  -- установка % ставки для законного овердрафта (2202)
  for k in ( select o.acc_ovr, t.card_type, t.cond_set
               from obpc_acct t, bpk_acc o, demand_cond_set d, accounts b
              where t.id = p_file_id
                and t.acc = o.acc_pk
                and o.acc_ovr = b.acc and b.dazs is null
                and t.card_type = d.card_type
                and t.cond_set  = d.cond_set )
  loop
     set_acc_rate('KRED', k.acc_ovr, k.card_type, k.cond_set);
  end loop;

  -- установка % ставки для просрочки (2207)
  for k in ( select o.acc_2207, t.card_type, t.cond_set
               from obpc_acct t, bpk_acc o, demand_cond_set d, accounts b
              where t.id = p_file_id
                and t.acc = o.acc_pk
                and o.acc_2207 = b.acc and b.dazs is null
                and t.card_type = d.card_type
                and t.cond_set  = d.cond_set )
  loop
     set_acc_rate('2207', k.acc_2207, k.card_type, k.cond_set);
  end loop;

end set_accounts_rate;

-------------------------------------------------------------------------------
-- close_accounts
-- Процедура закрытия счетов
--
procedure close_accounts (p_file_id  number)
is
  l_close  number;   -- Признак: счет закрывать
  l_cnt    number;
  l_dazs_2208 date := null;
  l_dazs_2209 date := null;
  l_dazs_3570 date := null;
  l_dazs_3579 date := null;
  l_dazs_ovr  date := null;
  l_dazs_2207 date := null;
  l_vob    number;
  l_dk     number;
  l_tt     varchar2(3);
  l_s      number;
  l_nlsk   tts.nlsk%type;
  l_nms99  varchar2(38);
  l_nls99  varchar2(14);
  l_iserr  boolean := false;
  ora_lock exception;
  pragma exception_init(ora_lock, -54);
  h varchar2(30) := 'obpc.close_accounts: ';
begin

  bars_audit.trace(h || 'Start. p_file_id=>' || p_file_id);

  -- закрытие счетов:
  -- 1. закрываем те счета, у кот. status = 4 - карточка закрыта
  for k in ( select a.acc, a.nls, a.kv, o.acc_9129,
                    o.acc_ovr,  o.acc_3570, o.acc_2208,
                    o.acc_2207, o.acc_3579, o.acc_2209
               from obpc_acct b, bpk_acc o, accounts a
              where b.status = 4
                and b.acc = a.acc
                and a.acc = o.acc_pk
                and a.ostc = 0
                and a.ostb = 0
                and a.ostf = 0
                and a.dazs is null
                and (a.dapp <  bankdate or a.dapp is null)
                and a.daos <= bankdate )
  loop
     begin
        savepoint sp_before;
        l_close := 1;

        -- блокируем карточный счет
        select 1 into l_cnt
          from accounts
         where acc = k.acc
        for update nowait;

        -- дополнительные проверки:
        -- 1) счет 2208/2209
        if l_close = 1 and k.acc_2208 is not null then
           l_close := can_closeacc(k.acc_2208, l_dazs_2208);
        end if;
        if l_close = 1 and k.acc_2209 is not null then
           l_close := can_closeacc(k.acc_2209, l_dazs_2209);
        end if;

        -- 2) счет 3570\3579
        if l_close = 1 and k.acc_3570 is not null then
           l_close := can_closeacc(k.acc_3570, l_dazs_3570);
        end if;
        if l_close = 1 and k.acc_3579 is not null then
           l_close := can_closeacc(k.acc_3579, l_dazs_3579);
        end if;

        -- 3) счет овердрафта/2207
        if l_close = 1 and k.acc_ovr is not null then
           l_close := can_closeacc(k.acc_ovr, l_dazs_ovr);
        end if;
        if l_close = 1 and k.acc_2207 is not null then
           l_close := can_closeacc(k.acc_2207, l_dazs_2207);
        end if;

        if l_close = 1 then

           update accounts set dazs = bankdate where acc = k.acc;

           if k.acc_2208 is not null and l_dazs_2208 is null then
              update accounts set dazs = bankdate where acc = k.acc_2208;
           end if;
           if k.acc_2209 is not null and l_dazs_2209 is null then
              update accounts set dazs = bankdate where acc = k.acc_2209;
           end if;

           if k.acc_3570 is not null and l_dazs_3570 is null then
              update accounts set dazs = bankdate where acc = k.acc_3570;
           end if;
           if k.acc_3579 is not null and l_dazs_3579 is null then
              update accounts set dazs = bankdate where acc = k.acc_3579;
           end if;

           if k.acc_ovr is not null and l_dazs_ovr is null then
              update accounts set dazs = bankdate where acc = k.acc_ovr;
           end if;
           if k.acc_2207 is not null and l_dazs_2207 is null then
              update accounts set dazs = bankdate where acc = k.acc_2207;
           end if;

           begin
              insert into accountsw(acc, tag, value)
              values (k.acc, 'RCLOS', 'Закрито по файлу з ПЦ');
           exception when dup_val_on_index then null;
           end;

           bars_audit.trace(h || 'Account ' || k.nls || ' (' || k.kv || ')' || ' closed.');

        end if;

        commit;

     exception
        when ORA_LOCK then
             rollback to sp_before;
             l_iserr := true;
     end;

  end loop;

  if (l_iserr) then
    bars_error.raise_nerror(g_modcode, 'LOCKED_ACCOUNT_FOUND');
  end if;

  bars_audit.trace(h || 'Accounts closed.');

  -- 2. закрытие счетов 9129
  l_tt  := 'O99';
  l_vob := 6;
  l_dk  := 0;

  -- пар-ры счета 9900
  begin
     select t.nlsk into l_nlsk from tts t where t.tt = l_tt;

     if substr(l_nlsk,1,2)='#(' then -- Dynamic account number present
        begin
           execute immediate
             'select ' || substr(l_nlsk,3,length(l_nlsk)-3) || ' from dual' into l_nlsk;
        exception when others then
           raise_application_error(-(20203),'\9351 - Cannot get account nom via '||l_nlsk||' '||SQLERRM,TRUE);
        end;
     end if;
  exception when no_data_found then l_nlsk := null;
  end;

  if l_nlsk is not null then
     for k in ( select a9.acc, a9.nls, a9.kv, substr(a9.nms,1,38) nms, a9.ostc, c.okpo
                  from bpk_acc o, accounts a, accounts a9, customer c
                 where o.acc_pk = a.acc
                   and ( a.lim = 0 or a.dazs is not null )
                   and o.acc_9129 = a9.acc and a9.dazs is null
                   and a9.ostc = a9.ostb and a9.ostf = 0
                   and a9.rnk = c.rnk )
     loop
        begin
           l_s := abs(k.ostc);

           if l_s > 0 then
              select a.nls, substr(a.nms,1,38)
                into l_nls99, l_nms99
                from accounts a
               where a.nls = l_nlsk and a.kv = k.kv;

              p_oper(l_tt, l_vob, l_dk, k.nms, k.nls, k.okpo,
                l_nms99, l_nls99, f_ourokpo, k.kv, l_s, g_nazn_9129);
           end if;

           -- счет не закрываем сразу, т.к. в этот день были обороты

        exception when no_data_found then null;
        end;
     end loop;

  end if;

end close_accounts;

-------------------------------------------------------------------------------
-- set_acc_params
-- Процедура обработки счетов по файлу acct*.dbf
--
procedure set_acc_params (p_file_id number)
is
  g_branch varchar2(30);
  h varchar2(30) := 'obpc.set_acc_params: ';
begin

  bars_audit.trace(h || 'Start.');

  select branch_usr.get_branch into g_branch from dual;
  if length(g_branch) <> 8 then
     -- Пользователю отделения g_branch запрещено выполнять данную функцию
     bars_error.raise_nerror(g_modcode, 'EXEC_FUNCTION_DENIED', g_branch);
  end if;

  -- обновление параметров счетов
  change_acc_params (p_file_id);
  bars_audit.trace(h || 'Params modified.');

  -- обновление % ставок
  set_accounts_rate(p_file_id);
  bars_audit.trace(h || 'Rates setted.');

  -- закрытие счетов
  close_accounts(p_file_id);
  bars_audit.trace(h || 'Accounts closed.');

  bars_audit.trace(h || 'Finish.');

end set_acc_params;

-------------------------------------------------------------------------------
-- check_acc
-- процедура проверки карточного счета при регистрации счета
--
procedure check_acc (p_acc number)
is
  l_tip  varchar2(3);
  l_nd   number;
begin

  select tip into l_tip
    from accounts where acc = p_acc and substr(nls,1,4) in ('2625', '2605', '2655');

  if l_tip not like 'PK%' then
     bars_error.raise_nerror(g_modcode, 'INCORRECT_BPK_TIP');
  end if;

  -- добавление в портфель БПК
  add_deal(p_acc, l_nd);

  -- бывали случаи открытия карт. счетов с nbs=null
  update accounts set nbs = substr(nls,1,4) where acc = p_acc and nbs is null;

exception when no_data_found then null;
end check_acc;

-------------------------------------------------------------------------------
-- set_operw
-- заполнение доп. рекв. операций
--
procedure set_operw (p_ref number, p_tag varchar2, p_value varchar2)
is
begin
  begin
     insert into operw (ref, tag, value)
     values (p_ref, p_tag, p_value);
  exception when dup_val_on_index then
     update operw set value = p_value where ref = p_ref and trim(tag) = trim(p_tag);
  end;
end set_operw;

-------------------------------------------------------------------------------
-- tran_to_arc
-- удаление в архив транзакций
--
procedure tran_to_arc (p_idn number, p_ref number)
is
begin
  raise_application_error(-20000, 'Нерабочая процедура');
/*
  for k in ( select id, idn, card_acct, currency, ccy, tran_date, tran_type,
                    card, slip_nr, batch_nr, abvr_name, city, merchant, tran_amt, amount,
                    tran_name, tran_russ, post_date, card_type, country, mcc_code, terminal
               from obpc_tran
              where idn = p_idn )
  loop

     insert into obpc_tran_hist (id, idn, ref, card_acct, currency, ccy, tran_date, tran_type,
        card, slip_nr, batch_nr, abvr_name, city, merchant, tran_amt, amount,
        tran_name, tran_russ, post_date, card_type, country, mcc_code, terminal)
     values (k.id, k.idn, p_ref, k.card_acct, k.currency, k.ccy, k.tran_date, k.tran_type,
        k.card, k.slip_nr, k.batch_nr, k.abvr_name, k.city, k.merchant, k.tran_amt, k.amount,
        k.tran_name, k.tran_russ, k.post_date, k.card_type, k.country, k.mcc_code, k.terminal);

     delete from obpc_tran where idn = k.idn;

  end loop;
*/
end tran_to_arc;

-------------------------------------------------------------------------------
-- del_pkkque
-- процедура удаления документа из очереди на отправку в ПЦ
--
procedure del_pkkque (
  p_doctype  number,
  p_ref      number,
  p_dk       number )
is
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  if p_doctype = 1 then

     for k in (select acc, f_n, f_d
                 from pkk_que
                where ref = p_ref and dk = p_dk )
     loop
        insert into pkk_history (ref, dk, f_n, f_d, acc)
        values (p_ref, p_dk, k.f_n, k.f_d, k.acc);

        delete from pkk_que where ref = p_ref and dk = p_dk;
     end loop;

  elsif p_doctype = 2 then

     for k in (select nls from pkk_inf where rec = p_ref )
     loop
        insert into pkk_inf_history (rec, nls, f_n, f_d)
        values (p_ref, k.nls, null, null);

        delete from pkk_inf where rec = p_ref;
     end loop;

  end if;
*/
end del_pkkque;

-------------------------------------------------------------------------------
-- set_pay_flag
-- процедура установки флага оплаты после оплаты документов
--
procedure set_pay_flag (
  p_file_id  number,
  p_idn      number,
  p_ref      number,
  p_dk       number,
  p_cardacc  varchar2 )
is
begin

  if p_dk = 1 then
     -- добавление доп. реквизита "Технический счет"
     set_operw(p_ref, 'CDAC', p_cardacc);
     -- добавление доп. реквизита "Код файла ПЦ"
     set_operw(p_ref, 'OBQF', to_char(p_file_id));
  else
     -- добавление доп. реквизита "Технический счет"
     set_operw(p_ref, 'CDAC2', p_cardacc);
     -- добавление доп. реквизита "Код файла ПЦ"
     set_operw(p_ref, 'OBQF2', to_char(p_file_id));
  end if;

  -- удаление в архив транзакций
  tran_to_arc(p_idn, p_ref);

end set_pay_flag;

-------------------------------------------------------------------------------
-- set_kvt_flag
-- процедура установки флага квитовки после квитовки документов
--
procedure set_kvt_flag (
  p_file_id  number,
  p_idn      number,
  p_ref      number,
  p_dk       number )
is
begin
  if p_dk = 1 then
     -- добавление доп. реквизита "Код файла ПЦ"
     set_operw (p_ref, 'OBQF', to_char(p_file_id));
  else
     -- добавление доп. реквизита "Код файла ПЦ"
     set_operw (p_ref, 'OBQF2', to_char(p_file_id));
  end if;

  -- удаление в архив транзакций
  tran_to_arc(p_idn, p_ref);

  -- удаление из очереди документов для ПЦ
  del_pkkque(1, p_ref, p_dk);

end set_kvt_flag;

-------------------------------------------------------------------------------
procedure iget_k_nls (
  p_mode   in varchar2,
  p_nd     in number,
  p_k_acc  in number,
  p_kv     in number,
  p_nls   out varchar2,
  p_nms   out varchar2 )
is
  l_nd     number;
  l_k_acc  number;
  l_k_nls  varchar2(14);
  l_k_nms  varchar2(38);
begin

  l_k_acc := p_k_acc;

  begin

     -- счет комиссии есть
     if l_k_acc is not null then
        begin
           select nls, substr(nms,1,38)
             into l_k_nls, l_k_nms
             from accounts
            where acc = l_k_acc
              and kv  = p_kv
              and dazs is null;
        exception when no_data_found then
           l_k_acc := null;
        end;
     end if;

     -- счета комиссии нет, открываем
     if l_k_acc is null then

        -- открываем счет
        open_acc(p_nd, p_mode, l_k_acc);

        select nls, substr(nms,1,38)
          into l_k_nls, l_k_nms
          from accounts
         where acc = l_k_acc;

     end if;

     p_nls := l_k_nls;
     p_nms := l_k_nms;

  exception when no_data_found then
     p_nls := null;
     p_nms := null;
  end;

end iget_k_nls;

-------------------------------------------------------------------------------
procedure iget_nlsa (
  p_tt    in varchar2,
  p_acc   in number,
  p_s     in number,
  p_kv    in number,
  p_nlsa out varchar2,
  p_nmsa out varchar2 )
is
  l_bankdate date;
  l_ost_pk   number;
  l_nd       number;
  l_acc      number;
  l_nls      oper.nlsa%type;
  l_nms      oper.nam_a%type;
begin

  l_bankdate := gl.bdate;
  l_nls := null;
  l_nms := null;

  -- Для операций комиссии проверка на остаток карт.счета,
  --   если нужно - использовать 3570.
  if p_tt in ('PK%','PK^') then

     -- остаток на карт. счете
     l_ost_pk := fost(p_acc, l_bankdate);

     if l_ost_pk - p_s < 0 then

        begin

           select nd, acc_3570 into l_nd, l_acc
             from bpk_acc
            where acc_pk = p_acc;

           iget_k_nls ('3570', l_nd, l_acc, p_kv, l_nls, l_nms);

        exception when no_data_found then

           l_nls := null;
           l_nms := null;

        end;

     end if;

  -- Для операций %% проверка на остаток карт.счета,
  --   если нужно - использовать 2208.
  elsif p_tt in ('PK5','PK6') then

     -- остаток на карт. счете
     l_ost_pk := fost(p_acc, l_bankdate);

     if l_ost_pk - p_s < 0 then

        begin

           select nd, acc_2208 into l_nd, l_acc
             from bpk_acc
            where acc_pk = p_acc;

           iget_k_nls ('2208', l_nd, l_acc, p_kv, l_nls, l_nms);

        exception when no_data_found then

           l_nls := null;
           l_nms := null;

        end;

     end if;

  end if;

  -- Для остальных операций платим с карточного 2625
  if l_nls is null then

     begin
        select nls, substr(nms,1,38)
          into l_nls, l_nms
          from accounts
         where acc = p_acc
           and dazs is null;
     exception when no_data_found then
        l_nls := null;
     end;

  end if;

  p_nlsa := l_nls;
  p_nmsa := l_nms;

end iget_nlsa;

-------------------------------------------------------------------------------
-- iget_transit
-- процедура получения транзитного счета для оплаты операций ПЦ
--
procedure iget_transit (
  p_tran_type   in varchar2,
  p_acc         in number,
  p_card_type   in number,
  p_out_nls    out varchar2,
  p_out_nms    out varchar )
is
  l_nls  accounts.nls%type;
  l_nms  accounts.nms%type;
begin

  begin
     select b.nls, substr(b.nms,1,38)
       into l_nls, l_nms
       from obpc_trans_tran t, accounts a, accounts b
      where a.acc = p_acc
        and t.tran_type = p_tran_type
        and t.tip = a.tip
        and t.kv = a.kv
        and t.branch = substr(a.tobo,1,15)
        and t.transit_acc = b.acc;
  exception when no_data_found then
     l_nls := null;
     l_nms := null;
  end;

  p_out_nls := l_nls;
  p_out_nms := l_nms;

end iget_transit;

-------------------------------------------------------------------------------
-- iget_nlsb
-- процедура получения счета-2 (6/7 кл.) для оплаты операций ПЦ
--
procedure iget_nlsb (
  p_tran_type   in varchar2,
  p_acc         in number,
  p_card_type   in number,
  p_out_kv     out number,
  p_out_nls    out varchar2,
  p_out_nms    out varchar )
is
  l_kv   accounts.kv%type;
  l_nls  accounts.nls%type;
  l_nms  accounts.nms%type;
begin

  begin
     select b.nls, b.kv, substr(b.nms,1,38)
       into l_nls, l_kv, l_nms
       from obpc_trans_tran t, accounts a, accounts b
      where a.acc = p_acc
        and t.tran_type = p_tran_type
        and t.tip = a.tip
        and t.kv = a.kv
        and t.branch = substr(a.tobo,1,15)
        and decode(a.nbs, '2625', acc_f_short, acc_u_short) = b.acc
        and b.dazs is null;
  exception when no_data_found then
     l_kv  := null;
     l_nls := null;
     l_nms := null;
  end;

  p_out_kv  := l_kv;
  p_out_nls := l_nls;
  p_out_nms := l_nms;

end iget_nlsb;

-------------------------------------------------------------------------------
-- pay_oper
-- процедура оплаты документов ПЦ
--
procedure pay_oper (p_file_id  number)
is
  l_bankdate  date;
  l_mfo       varchar2(6);
  l_okpo      varchar2(14);
  l_flag      number;
  l_flag_tt   number;
  l_flag_ttv  number;
  l_nls_a     varchar2(14);
  l_nam_a     varchar2(38);
  l_nls_t     varchar2(14);
  l_nam_t     varchar2(38);
  l_kv_b      number;
  l_nls_b     varchar2(14);
  l_nam_b     varchar2(38);
  l_kv1       number;
  l_nls1      varchar2(14);
  l_nam1      varchar2(38);
  l_kv2       number;
  l_nls2      varchar2(14);
  l_nam2      varchar2(38);
  l_s1        number;
  l_s2        number;
  l_tt        varchar2(3);
  l_dk        number;
  l_vob       number;
  l_nazn      varchar2(160);
  bPay        boolean;
  rat_o       number;
  rat_b       number;
  rat_s       number;
  l_ref       number;
  g_branch    varchar2(30);
  y number := 0;

  l_iserr  boolean := false;
  l_errm   varchar2(2000);
  err exception;

  h varchar2(30) := 'obpc.pay_oper: ';

begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.trace(h ||' Start.');

  select branch_usr.get_branch into g_branch from dual;
  if length(g_branch) <> 8 then
     -- Пользователю отделения g_branch запрещено выполнять данную функцию
     bars_error.raise_nerror(g_modcode, 'EXEC_FUNCTION_DENIED', g_branch);
  end if;

  l_bankdate := gl.bdate;
  l_mfo      := f_ourmfo;
  l_okpo     := f_ourokpo;

  -- цикл по отсортированным операциям
  for z in ( select tt, tt_v from obpc_tt_in order by ord )
  loop

     -- флаг оплаты операций
     select nvl(min(value),1) into l_flag_tt  from tts_flags where tt = z.tt   and fcode = 37;
     select nvl(min(value),1) into l_flag_ttv from tts_flags where tt = z.tt_v and fcode = 37;

     -- цикл по транзакциям
     for k in ( select t.idn, t.card_acct, s.kv, a.lacct nls,
                       a.card_type, a.cond_set, a.client_n,
                       a.city, a.branch, a.works,
                       abs(t.amount)*100 summ, t.tran_type, t.tran_date,
                       t.merchant, t.abvr_name,
                       b.name, b.dk,
                       s.acc, s.nms, r.okpo, i.pay_flg
                  from obpc_tran t, obpc_trans b, obpc_acct a, obpc_trans_in i,
                       accounts s, customer r
                 where t.id  = p_file_id
                   and t.tran_type = b.tran_type and b.bof = 0
                   and b.tran_type = i.tran_type and i.tt = z.tt
                   and t.card_acct = a.card_acct
                   and a.acc = s.acc and s.dazs is null
                   and s.rnk = r.rnk
                    -- сумма операции <> 0
                   and t.amount <> 0 )
     loop

        bPay := true;

        -- 1. счет-А (2625/3570/2208)
        iget_nlsa(z.tt, k.acc, k.summ, k.kv, l_nls_a, l_nam_a);

        -- 2. транзитный счет (2924)
        iget_transit(k.tran_type, k.acc, k.card_type, l_nls_t, l_nam_t);

        -- 3. счет-Б (2920/6-7класс)
        -- 3.1 счет-Б = 2920
        if k.pay_flg = 1 then

           if k.merchant is not null then
              begin
                 -- card_type:
                 -- MC: 0-EC/MC, 1-CIRRUS/MAESTRO
                 -- VISA: 2-ELECTRON, 3-DOMESTIC, 4-VISA
                 select a.nls, a.kv, substr(a.nms,1,38)
                   into l_nls_b, l_kv_b, l_nam_b
                   from obpc_merch m, accounts a
                  where m.merch = k.merchant
                    and m.card_system = iif_s(k.card_type,1,'MC','MC','VISA')
                    and m.kv = k.kv
                    and m.transit_acc = a.acc and m.kv = a.kv;
              exception when no_data_found then
                 l_nls_b := null;
                 l_kv_b  := null;
                 l_nam_b := null;
              end;
           end if;

        -- 3.2 счет-Б = 6/7 класс
        elsif k.pay_flg = 2 then

           iget_nlsb(k.tran_type, k.acc, k.card_type, l_kv_b, l_nls_b, l_nam_b);

        -- 3.3 счет-Б не указан
        else

           l_kv_b  := null;
           l_nls_b := null;
           l_nam_b := null;

        end if;

        -- 4. для oper
        l_s1  := k.summ;
        l_dk  := 1-k.dk;
        l_vob := 6;
        l_kv1 := k.kv;
        l_kv2 := nvl(l_kv_b, k.kv);

        if l_mfo = '300465' then
           l_nazn := substr(k.name, 1, 160);
        else
           select substr(k.name || ', ' || k.client_n || ', ' ||
                  to_char(k.tran_date,'dd.mm.yyyy') ||
                  nvl2(k.abvr_name, ', '||k.abvr_name, '') ||
                  nvl2(k.city, ', '||k.city, '') || ', ' ||
                  k.branch || ', ' || k.card_acct || ', ' ||
                  k.tran_type || ', ' || k.works, 1, 160)
             into l_nazn from dual;
        end if;

        if l_kv1 = l_kv2 then
           l_tt := z.tt;
           l_s2 := l_s1;
           l_flag := l_flag_tt;
        elsif l_kv1 <> 980 and l_kv2 = 980 then
           l_tt := z.tt_v;

           GetXRate(rat_o, rat_b, rat_s, l_kv1, 980, l_bankdate);
           l_s2 := l_s1 * rat_o;
           l_flag := l_flag_ttv;
        else
           bPay := false;
        end if;

        l_nls1 := l_nls_a;
        l_nam1 := l_nam_a;

        l_nls2 := nvl(l_nls_b, l_nls_t);
        l_nam2 := nvl(l_nam_b, l_nam_t);

        -- Оплата
        if bPay = true and l_nls1 is not null and l_nls2 is not null then

           begin
              savepoint sp_before;

              gl.ref (l_ref);

              insert into oper (ref, tt, vob, nd, dk, pdat, vdat, datd,
                 nam_a, nlsa, mfoa, id_a,
                 nam_b, nlsb, mfob, id_b, kv, s, kv2, s2, nazn, userid)
              values (l_ref, l_tt, l_vob, l_ref, l_dk, sysdate, l_bankdate, l_bankdate,
                 l_nam1, l_nls1, l_mfo, k.okpo,
                 l_nam2, l_nls2, l_mfo, l_okpo,
                 l_kv1, l_s1, l_kv2, l_s2, l_nazn, user_id);

              -- варианты проводок:
              -- 1+2: 1. Д2625 - К2924, 2. Д2924 - К2920 (6/7 класс)
              -- 2. Д2625 - К2924
              -- 2. Д3570(2208) - К2924
              -- 2. Д3570(2208) - К6/7 класс

              -- 1 - если нужно (если оплата идет со счета 2625
              -- и ч/з транзит перебросить на счет 2920/6-7класс)
              if l_nls1 = k.nls then

                 if l_nls_t is not null and l_nls_t <> l_nls2 then

                    -- Д2625 - К2924 - одновалютная проводка
                    gl.payv(l_flag, l_ref, l_bankdate, l_tt, l_dk,
                       l_kv1, l_nls1,  l_s1,
                       l_kv1, l_nls_t, l_s1);

                    l_nls1 := l_nls_t;
                    l_nam1 := l_nam_t;

                 end if;

              end if;

              -- 2 - обязательная проводка
              gl.payv(l_flag, l_ref, l_bankdate, l_tt, l_dk,
                 l_kv1, l_nls1, l_s1,
                 l_kv2, l_nls2, l_s2);

              obpc.set_pay_flag(p_file_id, k.idn, l_ref, k.dk, k.card_acct);

              y := y + 1;
              if y > 100 then commit; y := 0; end if;

           exception when others then
              l_errm := substr(sqlerrm, 1, 2000);
              if ( sqlcode <= -20000 ) then
                 l_iserr := true;
                 rollback to sp_before;
              else raise;
              end if;
           end;

        end if;

     end loop;

  end loop;

  bars_audit.trace(h ||' Finish.');

  commit;

  if (l_iserr) then
     bars_error.raise_nerror(g_modcode, 'PAY_ERORR', l_errm);
  end if;
*/
end pay_oper;

-------------------------------------------------------------------------------
-- kvt_oper
-- процедура квитовки операций банка
--
procedure kvt_oper (p_file_id  number)
is
  l_chkid      number;
  l_chkid_hex  varchar2(2);
  l_chkid2     number;
  l_chkid2_hex varchar2(2);
  l_ref        number;
  l_dk         number;
  l_tt         varchar2(3);
  l_nlsa       varchar2(14);
  l_kv         number;
  l_s          number;
  l_nlsb       varchar2(14);
  l_kv2        number;
  l_s2         number;
  l_sos        number;
  l_nextvisagrp oper.nextvisagrp%type;
  l_currvisagrp oper.currvisagrp%type;
  l_nxt        varchar2(4);
  l_stmt       number;
  l_fdat       date;
  l_flag       number;
  l_acc        number;
  l_bdate      date;
  b_kvt        boolean := false;
  g_branch     varchar2(30);
  y number := 0;

  l_iserr  boolean := false;
  l_errm   varchar2(2000);
  err exception;

  h varchar2(30) := 'obpc.kvt_oper: ';
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.trace(h ||' Start.');

  select branch_usr.get_branch into g_branch from dual;
  if length(g_branch) <> 8 then
     -- Пользователю отделения g_branch запрещено выполнять данную функцию
     bars_error.raise_nerror(g_modcode, 'EXEC_FUNCTION_DENIED', g_branch);
  end if;

  l_chkid  := getglobaloption('BPK_CHK');
  l_chkid2 := getglobaloption('BPK_CHK2');
  if l_chkid is null or l_chkid2 is null then
     bars_error.raise_nerror(g_modcode, 'CHK_NOT_FOUND');
  end if;
  l_chkid_hex  := lpad(chk.to_hex(l_chkid),2,'0');
  l_chkid2_hex := lpad(chk.to_hex(l_chkid2),2,'0');

  l_bdate := gl.bdate;

  for k in ( select t.idn, t.card_acct, t.tran_type, abs(t.amount) amount, s.dk
               from obpc_tran t, obpc_trans s
              where t.id = p_file_id
                and t.tran_type = s.tran_type
                and s.bof = 1 )
  loop

     select min(q.ref) into l_ref
       from pkk_que q
      where q.sos = 1
        and q.card_acct = k.card_acct
        and q.tran_type = k.tran_type
        and q.s = k.amount * 100;

     if l_ref is not null then

        b_kvt := false;

        -- доплата с транзита фактических / виза плановых
        begin
           savepoint sp_bof1;

           select o.tt, o.kv, p.acc, p.s, a.nls, o.sos, o.currvisagrp, o.nextvisagrp
             into l_tt, l_kv, l_acc, l_s, l_nlsb, l_sos, l_currvisagrp, l_nextvisagrp
             from oper o, pkk_que p, accounts a
            where o.ref = l_ref
              and o.ref = p.ref
              and p.dk  = k.dk
              and p.acc = a.acc
              and o.sos > 0;

           -- доплата с транзита
           if l_sos = 5 then

              -- защита от дурака:
              -- если документ завизирован технической визой Контролер БПК,
              --   просто квитуем,
              -- иначе - доплата
              if l_currvisagrp = l_chkid_hex then

                 b_kvt := true;

              else

                 l_nlsa := get_transit(k.tran_type, l_acc);

                 if l_nlsa is not null and l_nlsb is not null then

                    gl.payv(0, l_ref, l_bdate, l_tt, k.dk,
                       l_kv, l_nlsa, l_s,
                       l_kv, l_nlsb, l_s);

                    gl.pay(2, l_ref, l_bdate);

                    -- виза 30 Контролер БПК
                    insert into oper_visa (ref, dat, userid, groupid, status)
                    values (l_ref, sysdate, user_id, l_chkid, 2);

                    b_kvt := true;

                 end if;

              end if;

           elsif l_sos > 0 and l_nextvisagrp = l_chkid_hex then

              -- виза l_chkid - последняя?
              begin
                 select substr(CHK.GetNextVisaGroup(l_ref,l_nextvisagrp),1,2)
                   into l_nxt
                   from dual;
              exception when no_data_found then
                 bars_error.raise_nerror(g_modcode, '...');
              end;

              -- виза l_chkid - последняя:
              --   документ оплачиваем
              if l_nxt = '!!' then

                 gl.pay(2, l_ref, l_bdate);

              -- виза l_chkid - не последняя, будет еще l_chkid2:
              --   визируем проводку на списание
              else

                 begin
                    select stmt into l_stmt
                      from opldok
                     where ref = l_ref
                       and tt  = l_tt
                       and acc = l_acc
                       and dk  = k.dk;
                 exception when no_data_found then
                    bars_error.raise_nerror(g_modcode, '...');
                 end;

                 l_fdat := null;

                 -- запоминаем дату валютирования проводки на пополнение
                 select min(fdat) into l_fdat from opldok where ref = l_ref and stmt <> l_stmt and sos < 5;

                 -- меняем дату валютирования проводки на пополнение на будущую (чтоб она сейчас не платилась)
                 if l_fdat is not null then
                    update opldok set fdat = bankdate + 1 where ref = l_ref and stmt <> l_stmt;
                 end if;

                 -- оплата (виза) документа - оплатится только проводка на списание
                 gl.pay(2, l_ref, l_bdate);

                 -- меняем дату валютирования проводки назад
                 if l_fdat is not null then
                    update opldok set fdat = l_fdat where ref = l_ref and stmt <> l_stmt and sos < 5;
                 end if;

              end if;

              -- виза 30 Контролер БПК
--              insert into oper_visa (ref, dat, userid, groupid, status)
--              values (l_ref, sysdate, user_id, l_chkid, 2);
              chk.put_visa (
                  ref_    => l_ref,

                  tt_     => l_tt,
                  grp_    => l_chkid,
                  status_ => 2,
                  keyid_  => null,
                  sign1_  => null,
                  sign2_  => null );

              b_kvt := true;

           elsif l_sos > 0 and l_nextvisagrp = l_chkid2_hex then

              gl.pay(2, l_ref, l_bdate);

              -- виза 31 Контролер БПК-2
--              insert into oper_visa (ref, dat, userid, groupid, status)
--              values (l_ref, sysdate, user_id, l_chkid2, 2);
              chk.put_visa (
                  ref_    => l_ref,
                  tt_     => l_tt,
                  grp_    => l_chkid2,
                  status_ => 2,
                  keyid_  => null,
                  sign1_  => null,
                  sign2_  => null );

              b_kvt := true;

           end if;

        exception
           when no_data_found then null;
           when others then
              l_errm := substr(sqlerrm, 1, 2000);
              if ( sqlcode <= -20000 ) then
                 l_iserr := true;
                 rollback to sp_bof1;
              else raise;
              end if;
        end;

        -- квитовка документа
        if b_kvt then
           set_kvt_flag(p_file_id, k.idn, l_ref, k.dk);
           y := y + 1;
           if y > 100 then commit; y := 0; end if;
        end if;

     end if;

  end loop;

  bars_audit.trace(h ||' Finish.');

  commit;

  if (l_iserr) then
     bars_error.raise_nerror(g_modcode, 'PAY_ERORR', l_errm);
  end if;
*/
end kvt_oper;

-------------------------------------------------------------------------------
-- pk_ovr
-- процедура открытия/гашения овердрафта и учета неисп. лимита
--
procedure pk_ovr (p_mode int)
-- p_mode = 2 - Открытие/гашение овердрафта (2202, 3570, 2208)
-- p_mode = 9 - формирование внебаланса по неиспользованому лимиту (раскрытие и урегулирование)
is
  l_bdate  date;
  l_mfo    varchar2(6);
  l_ref    number;
  l_dk     number;
  l_tt     varchar2(3);
  l_vob    number;
  l_s      number;
  l_acc    number;
  l_nls    varchar2(14);
  l_nms    varchar2(70);
  l_ost    number;
  pk_ost   number;
  l_card_type number;
  l_cond_set  number;
  l_nlsk   tts.nlsk%type;
  l_nls99  varchar2(14);
  l_nms99  varchar2(38);
  l_s9     number;
  l_s2     number;
  l_dazs   date;
  g_branch varchar2(30);
  y number := 0;
  h varchar2(30) := 'obpc.pk_ovr: ';
begin

  bars_audit.trace(h ||' Start. p_mode=>' || to_char(p_mode));

  select branch_usr.get_branch into g_branch from dual;
  if length(g_branch) <> 8 then
     -- Пользователю отделения g_branch запрещено выполнять данную функцию
     bars_error.raise_nerror(g_modcode, 'EXEC_FUNCTION_DENIED', g_branch);
  end if;

  l_bdate := gl.bdate;
  l_mfo   := gl.amfo;

  if p_mode = 2 then
     -- Открытие овердрафта (2202, 3570, 2208)
     l_dk  := 1;
     l_tt  := 'OVR';
     l_vob := 6;
     for k in ( select o.nd, a.acc pk_acc, a.nls pk_nls, substr(a.nms,1,38) pk_nms,
                       a.kv, a.lim, a.grp, a.isp, a.rnk, a.tobo, c.custtype, c.nmk, c.okpo,
                       o.acc_ovr ovr_acc, o.acc_2208 d_acc,
                       o.acc_2207 s_acc, o.acc_2209 s9_acc,
                       o.acc_3570 k_acc, o.acc_3579 k9_acc
                  from bpk_acc o, accounts a, customer c
                 where o.acc_pk = a.acc
                   and substr(a.tip,1,2) = 'PK' and a.tip not in ('PKY', 'PKZ')
                   and a.pap = 2
                   and a.ostc <> 0
                   and a.dazs is null
                   and a.rnk = c.rnk )
     loop

        savepoint DO_PROVODKI_1;
        begin

        -- остаток на карт. счете
        pk_ost := fost(k.pk_acc, l_bdate);

        if pk_ost < 0 then

           -- 1. сначала законный овердрафт 2202
           if k.lim <> 0 then
              if k.ovr_acc is not null then
                 l_acc := k.ovr_acc;
              else
                 -- открываем счет
                 open_acc(k.nd, '2202', l_acc);
                 -- устанавливаем %% ставку
                 begin
                    -- если на карт.счет зарегитрировано несколько карточек, берем первую с таким же лимитом
                    select card_type, cond_set into l_card_type, l_cond_set
                      from obpc_acct
                     where acc = k.pk_acc
                       and crd = k.lim/100
                       and rownum = 1;
                    set_acc_rate('KRED', l_acc, l_card_type, l_cond_set);
                 exception when no_data_found then null;
                 end;
              end if;
              -- остаток на счете овердрафта 2202
              l_ost := fost(l_acc, l_bdate);
              if k.lim + l_ost > 0 then
                 get_account(l_acc, l_nls, l_nms);
                 l_s := least(abs(pk_ost), k.lim + l_ost);
                 p_oper (l_tt, l_vob, l_dk, l_nms, l_nls, k.okpo,
                   k.pk_nms, k.pk_nls, k.okpo, k.kv, l_s, g_nazn_dovr);
                 pk_ost := pk_ost + l_s;
              end if;
           end if;

           -- 2. комиссию убрали, т.к. она платится при приеме tran

           -- 3. плату за кредит убрали, т.к. она платится при приеме tran

           -- 4. технический овердрафт тоже убрали, дебетовый остаток остается
           --    на карточном счете

        elsif pk_ost > 0  then

           -- гашение 2209
           if pk_ost > 0 and k.s9_acc is not null then
              l_acc := k.s9_acc;
              -- остаток на счете 2209
              l_ost := fost(l_acc, l_bdate);
              if l_ost < 0 then
                 get_account(l_acc, l_nls, l_nms);
                 l_s := least(abs(l_ost), pk_ost);
                 p_oper (l_tt, l_vob, l_dk, k.pk_nms, k.pk_nls, k.okpo,
                   l_nms, l_nls, k.okpo, k.kv, l_s, g_nazn_k2209);
                 pk_ost := pk_ost - l_s;
              end if;
           end if;

           -- гашение 3579
           if pk_ost > 0 and k.k9_acc is not null then
              l_acc := k.k9_acc;
              -- остаток на счете 3579
              l_ost := fost(l_acc, l_bdate);
              if l_ost < 0 then
                 get_account(l_acc, l_nls, l_nms);
                 l_s := least(abs(l_ost), pk_ost);
                 p_oper (l_tt, l_vob, l_dk, k.pk_nms, k.pk_nls, k.okpo,
                   l_nms, l_nls, k.okpo, k.kv, l_s, g_nazn_k3579);
                 pk_ost := pk_ost - l_s;
              end if;
           end if;

           -- гашение 2207
           if pk_ost > 0 and k.s_acc is not null then
              l_acc := k.s_acc;
              -- остаток на счете 2207
              l_ost := fost(l_acc, l_bdate);
              if l_ost < 0 then
                 get_account(l_acc, l_nls, l_nms);
                 l_s := least(abs(l_ost), pk_ost);
                 p_oper (l_tt, l_vob, l_dk, k.pk_nms, k.pk_nls, k.okpo,
                   l_nms, l_nls, k.okpo, k.kv, l_s, g_nazn_k2207);
                 pk_ost := pk_ost - l_s;
              end if;
           end if;

           -- гашение 2208
           if pk_ost > 0 and k.d_acc is not null then
              l_acc := k.d_acc;
              -- остаток на счете 2208
              l_ost := fost(l_acc, l_bdate);
              if l_ost < 0 then
                 get_account(l_acc, l_nls, l_nms);
                 l_s := least(abs(l_ost), pk_ost);
                 p_oper (l_tt, l_vob, l_dk, k.pk_nms, k.pk_nls, k.okpo,
                   l_nms, l_nls, k.okpo, k.kv, l_s, g_nazn_k2208);
                 pk_ost := pk_ost - l_s;
              end if;
           end if;

           -- гашение 3570
           if pk_ost > 0 and k.k_acc is not null then
              l_acc := k.k_acc;
              -- остаток на счете 3570
              l_ost := fost(l_acc, l_bdate);
              if l_ost < 0 then
                 get_account(l_acc, l_nls, l_nms);
                 l_s := least(abs(l_ost), pk_ost);
                 p_oper (l_tt, l_vob, l_dk, k.pk_nms, k.pk_nls, k.okpo,
                   l_nms, l_nls, k.okpo, k.kv, l_s, g_nazn_k3570);
                 pk_ost := pk_ost - l_s;
              end if;
           end if;

           -- гашение кредита 2202
           if pk_ost > 0 and k.ovr_acc is not null then
              l_acc := k.ovr_acc;
              -- остаток на счете овердрафта 2202
              l_ost := fost(l_acc, l_bdate);
              if l_ost < 0 then
                 get_account(l_acc, l_nls, l_nms);
                 l_s := least(abs(l_ost), pk_ost);
                 p_oper (l_tt, l_vob, l_dk, k.pk_nms, k.pk_nls, k.okpo,
                   l_nms, l_nls, k.okpo, k.kv, l_s, g_nazn_kovr);
                 pk_ost := pk_ost - l_s;
              end if;
           end if;

        end if;

        y := y + 1;
        if y > 100 then commit; y := 0 ; end if;

        exception when others then
           bars_audit.info('PK_OVR: k.pk_nls=>'||k.pk_nls||': '||sqlerrm);
           rollback to DO_PROVODKI_1;  goto kin_1;
        end;
        <<kin_1>> NULL;
     end loop;

  elsif p_mode = 9 then
     -- формирование внебаланса по неиспользованому лимиту (раскрытие и урегулирование)
     l_tt  := 'O99';
     l_vob := 6;

     -- Цикл по валютам
     for v in ( select distinct a.kv
                  from accounts a, (select unique tip from obpc_tips) t
                 where a.tip = t.tip
                   and a.dazs is null )
     loop
        -- пар-ры счета 9900
        begin
           select t.nlsk into l_nlsk
             from tts t where t.tt = l_tt;

           if substr(l_nlsk,1,2)='#(' then -- Dynamic account number present
              begin
                 execute immediate
                   'select ' || substr(l_nlsk,3,length(l_nlsk)-3) || ' from dual' into l_nlsk;
              exception when others then
                 raise_application_error(-(20203),'\9351 - Cannot get account nom via '||l_nlsk||' '||SQLERRM,TRUE);
              end;
           end if;

           select a.nls, substr(a.nms,1,38)
             into l_nls99, l_nms99
             from accounts a
            where a.nls = l_nlsk and a.kv = v.kv;

        exception when no_data_found then return;
        end;

        -- ЦИКЛ ПО ВСЕМ КАРТ. СЧЕТАМ В ВАЛЮТЕ C.KV С УСТ. ЛИМИТАМИ
        for k in ( select o.nd, a.acc, decode(sign(a.lim), 1, a.lim, 0) lim, a.nls,
                          a.isp, a.grp, a.rnk, a.mdate, a.tobo, a.dazs,
                          b.acc acc9, b.nls nls9, substr(b.nms,1,38) nms9, b.ostc ostc9, b.dazs dazs9,
                          c.ostc ostc2, r.okpo
                     from accounts a, bpk_acc o, accounts b, accounts c, customer r,
                          (select unique tip from obpc_tips) t
                    where a.tip = t.tip
                      and a.kv = v.kv
                      and decode(sign(a.lim), 1, a.lim, 0) >= 0
                      and a.acc = o.acc_pk
                      and o.acc_9129 = b.acc(+)
                      and o.acc_ovr  = c.acc(+)
                      and a.rnk = r.rnk )
        loop
           savepoint DO_PROVODKI_2;
           begin
              -- если нет лимита и нет счета 9129, урегулировать ничего не нужно
              -- (если нет лимита, но есть счет 9129. м.б. лимит был, его сняли и урегулировать нужно)
              if k.lim = 0 and k.acc9 is null then null;
              else
                 -- узнать ACC и остаток счетa 9129
                 if k.acc9 is not null then
                    l_acc  := k.acc9;
                    l_nls  := k.nls9;
                    l_nms  := k.nms9;
                    l_s9   := k.ostc9;
                    l_dazs := k.dazs9;
                 else
                    l_acc := null;
                    l_s9  := 0;
                 end if;

                 -- узнать остаток счетa 2202 (ИСП. ОВЕРДРАФТ)
                 if k.ostc2 is not null then
                    l_s2 := k.ostc2;
                 else
                    l_s2 := 0;
                 end if;

                 -- ВЫЧИСЛЯЕМ СУММУ ПРОВОДКИ ДЛЯ УРЕГУЛИРОВАНИЯ 9129
                 -- 1) если каким-то образом (ручная проводка) получилось,
                 --   что ost2 > лимита на карточном счете,
                 --   нужно ost9 -> 0 (т.е. весь лимит использовался), s=l_s9, dk=0
                 -- 2) если счет 2625 закрыт, сворачиваем 9129 (проводка на сумму l_s9)
                 if k.lim >= abs(l_s2) and k.dazs is null then
                    l_s9 := k.lim + l_s2 + l_s9;
                 end if;

                 if l_s9 <> 0 then

                    if l_acc is null then
                       -- открываем счет
                       open_acc(k.nd, '9129', l_acc);

                       update accounts
                          set mdate = k.mdate
                        where acc = l_acc;

                       select nls, substr(nms,1,38)
                         into l_nls, l_nms
                         from accounts
                        where acc = l_acc;
                    else
                       if l_dazs is not null then
                          update accounts set dazs = null where acc = l_acc;
                       end if;
                    end if;

                    if l_s9 > 0 then l_dk := 1; else l_dk := 0; end if;
                    l_s   := abs(l_s9);
                    l_nms := substr(l_nms, 1, 38);

                    -- доп. проверка: проводки только по 9 кл.
                    if substr(l_nls,1,1) = '9' and substr(l_nls99,1,1) = '9' then
                       p_oper(l_tt, l_vob, l_dk, l_nms, l_nls, k.okpo,
                         l_nms99, l_nls99, f_ourokpo, v.kv, l_s, g_nazn_9129);
                    end if;

                 end if;
              end if;

           exception when others then
              bars_audit.info('PK_OVR: k.nls=>'||k.nls||' nls_=>'||l_nls||': '||sqlerrm);
              rollback to DO_PROVODKI_2;  goto kin_2;
           end;
           <<kin_2>> NULL;
        end loop;
     end loop;

     -- Закрытие 9129
     for i in ( select b.acc
                  from accounts a, accounts b, bpk_acc c
                 where a.dazs is not null
                   and a.dazs < l_bdate
                   and a.acc = c.acc_pk and c.acc_9129 = b.acc
                   and b.nbs = '9129'
                   and a.kv = b.kv
                   and b.ostc = 0
                   and b.dazs is null and b.dapp < l_bdate )
     loop
        update accounts set dazs = l_bdate where acc = i.acc;
     end loop;

  end if;

  bars_audit.trace(h ||' Finish.');

end pk_ovr;

-------------------------------------------------------------------------------
-- arc_pc_files
-- процедура архивации файлов ПЦ
--
procedure arc_pc_files (p number)
is
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  update obpc_files set arc = 1 where nvl(arc,0) = 0;
*/
end arc_pc_files;

-------------------------------------------------------------------------------
-- set_doc_cardacct
-- процедура установки доп.рекв. "Технический счет" для документа
--
procedure set_doc_cardacct (p_ref number, p_dk number, p_cardacct varchar2)
is
begin
  if p_dk = 1 then
     set_operw (p_ref, 'CDAC', p_cardacct);
  else
     set_operw (p_ref, 'CDAC2', p_cardacct);
  end if;
end set_doc_cardacct;

-------------------------------------------------------------------------------
-- sync_reference
-- процедура синхронизации справочников ПЦ
--
procedure sync_reference (p_ref varchar2, p_msg out varchar2)
is
  l_refname  varchar2(30);
  g_mfo      varchar2(6);
  i          number := 0;
  h varchar2(30) := 'obpc.sync_cond_set: ';
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  bars_audit.trace(h || 'Start. p_ref => ' || p_ref);

  -- полный доступ
  bc.set_policy_group('WHOLE');

  l_refname := upper(trim(p_ref));

  -- COND_SET - справочник условий счетов
  if l_refname = 'COND_SET' then

     -- добавление новых
     execute immediate
      'insert into demand_cond_set (
         card_type, cond_set, name, currency, c_validity, bl_10,
         deb_intr, olim_intr, cred_intr, late_intr, card_fee, card_fee1, note, change_date)
       select card_type, cond_set, name, currency, c_validity, bl_10,
         deb_intr, olim_intr, cred_intr, late_intr, card_fee, card_fee1, note, sysdate
         from pcimp_cond_set
        where (card_type, cond_set) not in
              (select card_type, cond_set from demand_cond_set)';
     bars_audit.trace(h || 'New record inserted.');

     -- изменение существующих
     execute immediate
       'update demand_cond_set
           set name       = (select name       from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               currency   = (select currency   from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               c_validity = (select c_validity from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               bl_10      = (select bl_10      from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               deb_intr   = (select deb_intr   from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               olim_intr  = (select olim_intr  from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               cred_intr  = (select cred_intr  from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               late_intr  = (select late_intr  from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               card_fee   = (select card_fee   from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               card_fee1  = (select card_fee1  from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               note       = (select note       from pcimp_cond_set where card_type = demand_cond_set.card_type and cond_set = demand_cond_set.cond_set),
               change_date = sysdate
         where (card_type, cond_set) in
               (select card_type, cond_set from pcimp_cond_set)';
     bars_audit.trace(h || 'Old record updated.');

     -- не удаляем, в таблице есть дата последнего обновления

  -- FILIALES - справочник филиалов
  elsif l_refname = 'FILIALES' then

     -- добавление новых
     execute immediate
      'insert into demand_filiales (
         code, name, city, street, mfo, client_0, client_1, abvr_name, change_date)
       select code, name, city, street, mfo, client_0, client_1, abvr_name, sysdate
         from pcimp_filiales
        where code not in (select code from demand_filiales)';
     bars_audit.trace(h || 'New record inserted.');

     -- изменение существующих
     execute immediate
       'update demand_filiales
           set code      = (select code      from pcimp_filiales where code = demand_filiales.code),
               name      = (select name      from pcimp_filiales where code = demand_filiales.code),
               city      = (select city      from pcimp_filiales where code = demand_filiales.code),
               street    = (select street    from pcimp_filiales where code = demand_filiales.code),
               mfo       = (select mfo       from pcimp_filiales where code = demand_filiales.code),
               client_0  = (select client_0  from pcimp_filiales where code = demand_filiales.code),
               client_1  = (select client_1  from pcimp_filiales where code = demand_filiales.code),
               abvr_name = (select abvr_name from pcimp_filiales where code = demand_filiales.code),
               change_date = sysdate
         where code in (select code from pcimp_filiales)';
     bars_audit.trace(h || 'Old record updated.');

     -- не удаляем, в таблице есть дата последнего обновления

  -- TR_TYPE - справочник транзакций
  elsif l_refname = 'TR_TYPE' then

     -- добавление новых
     execute immediate
      'insert into obpc_trans (tran_type, name, bof, dk, name_russ)
       select tran_type, tran_russ, -1, 0, substr(tran_russ,1,40)
         from pcimp_tr_type
        where tran_type not in (select tran_type from obpc_trans)';
     bars_audit.trace(h || 'New record inserted.');

     -- изменение существующих
     execute immediate
       'update obpc_trans
           set name_russ  = (select substr(tran_russ,1,40) from pcimp_tr_type where tran_type = obpc_trans.tran_type)
         where tran_type in (select tran_type from pcimp_tr_type)';
     bars_audit.trace(h || 'Old record updated.');

     -- не удаляем

  else

     bars_error.raise_nerror(g_modcode, 'UNKNOWN_FILE_TO_IMPORT', l_refname);

  end if;

  -- вернуться в свою область видимости
  bc.set_context();

  -- добавляем клише в справочник банкоматов
  if l_refname = 'FILIALES' then

     select getglobaloption('GLB-MFO') into g_mfo from dual;

     -- удаление чужих банкоматов
     delete from obpc_merch m
      where exists ( select 1
                       from demand_filiales
                      where ( client_0 = m.merch or client_1 = m.merch )
                        and mfo <> g_mfo );

     -- добавление своих новых
     for z in ( select client_0 merch, 840 kv, 'MC' card_system
                  from demand_filiales
                 where (client_0,840,'MC') not in (select merch, kv, card_system from obpc_merch)
                   and mfo = g_mfo
                 union all
                select client_0 merch, 840 kv, 'VISA'
                  from demand_filiales
                 where (client_0,840,'VISA') not in (select merch, kv, card_system from obpc_merch)
                   and mfo = g_mfo
                 union all
                select client_1, 980, 'MC'
                  from demand_filiales
                 where (client_1,980,'MC') not in (select merch, kv, card_system from obpc_merch)
                   and mfo = g_mfo
                 union all
                select client_1, 980, 'VISA'
                  from demand_filiales
                 where (client_1,980,'VISA') not in (select merch, kv, card_system from obpc_merch)
                   and mfo = g_mfo )
     loop
        insert into obpc_merch (merch, kv, card_system)
        values (z.merch, z.kv, z.card_system);
        i := i + 1;
     end loop;

     if i > 0 then
        p_msg := bars_msg.get_msg(g_modcode, 'FILIALES_ADDED', to_char(i));
     end if;

  end if;

  bars_audit.trace(h || 'Finish.');
*/
exception when others then
  -- вернуться в свою область видимости
  bc.set_context();
  -- Ошибка импорта файла %s: %s
  bars_error.raise_nerror(g_modcode, 'REF_IMPORT_ERROR', l_refname, sqlerrm);
end sync_reference;

-------------------------------------------------------------------------------
-- pay_dp_one
-- процедура оплаты (депозитов)
--
procedure pay_dp_one (
  p_tr_type varchar2,
  p_tt      varchar2,
  p_nls_t   varchar2,
  p_nam_t   varchar2,
  p_s       number,
  p_acc     number,
  p_nls     varchar2,
  p_nms     varchar2,
  p_kv      number,
  p_okpo    varchar2,
  p_cardacct varchar2 )
is
  l_bankdate date;
  l_mfo    varchar2(6);
  l_okpo   varchar2(14);
  l_ref    number;
  l_vob    number;
  l_dk     number;
  l_s      number;
  l_nazn   varchar2(160);
  l_flag   number;
begin

  l_bankdate := gl.bdate;
  l_mfo      := f_ourmfo;
  l_okpo     := f_ourokpo;

  select name_russ, dk into l_nazn, l_dk
    from obpc_trans
   where tran_type = p_tr_type;

--  l_nls_t := obpc.get_transit(p_tr_type, p_acc);

  if p_nls_t is not null and p_s is not null and p_s <> 0 then

     select value into l_flag from tts_flags where tt = p_tt and fcode = 37;

     l_s   := p_s * 100;
     l_vob := 6;

     gl.ref (l_ref);

     gl.in_doc2 (l_ref, p_tt, l_vob, l_ref, sysdate, l_bankdate,
        l_dk, p_kv, l_s, p_kv, l_s, null, null, l_bankdate, l_bankdate,
        substr(p_nam_t,1,38), p_nls_t, l_mfo,
        substr(p_nms,1,38),   p_nls,   l_mfo,
        l_nazn, null, p_okpo, l_okpo, null, null, 0, 0);

     paytt (null, l_ref, l_bankdate, p_tt, l_dk,
        p_kv, p_nls_t, l_s,
        p_kv, p_nls,   l_s);

--     set_operw (l_ref, 'CDAC ', p_cardacct);

  end if;
exception when no_data_found then null;
end pay_dp_one;

-------------------------------------------------------------------------------
-- pay_dp
-- процедура начисления депозитов
--
procedure pay_dp (p_mode number)
-- p_mode - acc З/П счета (счет-Д)
is
  l_nls_t varchar2(14);
  l_nam_t varchar2(38);
begin

  begin
     select nls, substr(nms,1,38) into l_nls_t, l_nam_t
       from accounts a
      where a.acc = p_mode;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', '(acc=' || to_char(p_mode) || ')', 980);
  end;

  for k in ( select d.id, d.s_int_d, d.s_int_ss, d.s_int_cr,
                    a.acc, a.nls, a.kv, c.okpo,
                    s.fio nms, s.acc_card, s.num_conv
               from obpc_dp d, accounts a, obpc_sprav s, customer c
              where d.sos = 0
                and d.num_conv = s.num_conv
                and s.vid_z = 2 and s.vid_s = 2
                and s.acc_bal = a.nls
                and a.kv = 980 and substr(a.tip,1,2) = 'PK'
                and a.rnk = c.rnk )
  loop
     pay_dp_one('10', 'PKI', l_nls_t, l_nam_t, k.s_int_d,  k.acc, k.nls, k.nms, k.kv, k.okpo, k.acc_card);
     pay_dp_one('2U', 'PKC', l_nls_t, l_nam_t, k.s_int_ss, k.acc, k.nls, k.nms, k.kv, k.okpo, k.acc_card);
     pay_dp_one('2U', 'PKC', l_nls_t, l_nam_t, k.s_int_cr, k.acc, k.nls, k.nms, k.kv, k.okpo, k.acc_card);
     update obpc_dp set sos = 5 where id = k.id;
  end loop;

end pay_dp;

-------------------------------------------------------------------------------
-- pay_elplat
-- процедура начисления зарплаты
--
procedure pay_elplat (p_mode number)
-- p_mode - acc З/П счета (счет-Д)
is
  l_nls_t varchar2(14);
  l_nam_t varchar2(38);
begin

  begin
     select nls, substr(nms,1,38) into l_nls_t, l_nam_t
       from accounts a
      where a.acc = p_mode;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', '(acc=' || to_char(p_mode) || ')', 980);
  end;

  for k in ( select distinct d.id, d.nls, d.s, s.acc_card,
                    a.acc, a.nms, a.kv, a.tip, c.okpo
               from obpc_elplat d, accounts a, obpc_sprav s, customer c
              where d.sos = 0
                and d.nls = s.acc_bal and s.vid_z = 1
                and d.nls = a.nls and a.kv = 980
                and a.rnk = c.rnk )
  loop
     pay_dp_one('1A', 'PKS', l_nls_t, l_nam_t, k.s,  k.acc, k.nls, k.nms, k.kv, k.okpo, k.acc_card);
     update obpc_elplat set sos = 5 where id = k.id;
  end loop;
end pay_elplat;

-------------------------------------------------------------------------------
-- delete_tran
-- удаление необработанных транзакций в архив
--
procedure delete_tran (p_idn number)
is
  g_branch varchar2(30);
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  select branch_usr.get_branch into g_branch from dual;
  if length(g_branch) <> 8 then
     -- Пользователю отделения g_branch запрещено выполнять данную функцию
     bars_error.raise_nerror(g_modcode, 'EXEC_FUNCTION_DENIED', g_branch);
  end if;

  for k in ( select id, idn, card_acct, currency, ccy, tran_date, tran_type,
                    card, slip_nr, batch_nr, abvr_name, city, merchant, tran_amt, amount,
                    tran_name, tran_russ, post_date, card_type, country, mcc_code, terminal
               from obpc_tran
              where idn = p_idn )
  loop

     insert into obpc_tran_arc (id, idn, card_acct, currency, ccy, tran_date, tran_type,
        card, slip_nr, batch_nr, abvr_name, city, merchant, tran_amt, amount,
        tran_name, tran_russ, post_date, card_type, country, mcc_code, terminal, doneby)
     values (k.id, k.idn, k.card_acct, k.currency, k.ccy, k.tran_date, k.tran_type,
        k.card, k.slip_nr, k.batch_nr, k.abvr_name, k.city, k.merchant, k.tran_amt, k.amount,
        k.tran_name, k.tran_russ, k.post_date, k.card_type, k.country, k.mcc_code, k.terminal, user_name);

     delete from obpc_tran where idn = k.idn;

  end loop;
*/
end delete_tran;


procedure get_xml_attr_parse (
  p_node  in dbms_xmldom.DOMNode,
  p_nls  out varchar2,
  p_nms  out varchar2,
  p_okpo out varchar2,
  p_s    out number )
is
  g_numb_mask varchar2(100) := '9999999999999999999999999D99999999';
  g_nls_mask  varchar2(100) := 'NLS_NUMERIC_CHARACTERS = ''.,''';
  i number;
begin
  -- вычитывае нужные  атрибуты
  --  <ROW NLS="262565156610"
  --       FIO="ВЕРНИГОРА НАД_Я ФЕДОР_ВНА"
  --       INN="1809320726"
  --       SUMMA="880.51" />

  p_nls := substr (
     dbms_xmldom.getNodeValue(
     dbms_xmldom.getnameditem(
     dbms_xmldom.getattributes(p_node), 'NLS')), 1, 14);

  p_nms := substr (
     dbms_xmldom.getNodeValue(
     dbms_xmldom.getnameditem(
     dbms_xmldom.getattributes(p_node), 'FIO')), 1, 38);

  p_okpo := substr (
     dbms_xmldom.getNodeValue(
     dbms_xmldom.getnameditem(
     dbms_xmldom.getattributes(p_node), 'INN')), 1, 10);

  p_s := to_number(
     dbms_xmldom.getNodeValue(
     dbms_xmldom.getnameditem(
     dbms_xmldom.getattributes(p_node),'SUMMA')), g_numb_mask, g_nls_mask) * 100;
end get_xml_attr_parse;
-------------------------------------------------------------------------------
-- get_xml_attr
--
procedure get_xml_attr (
  p_node  in dbms_xmldom.DOMNode,
  p_nls  out varchar2,
  p_nms  out varchar2,
  p_okpo out varchar2,
  p_s    out number )
is
  g_numb_mask varchar2(100) := '9999999999999999999999999D99999999';
  g_nls_mask  varchar2(100) := 'NLS_NUMERIC_CHARACTERS = ''.,''';
  i number;
begin
  -- вычитывае нужные  атрибуты
  --  <ROW NLS="262565156610"
  --       FIO="ВЕРНИГОРА НАД_Я ФЕДОР_ВНА"
  --       INN="1809320726"
  --       SUMMA="880.51" />

  get_xml_attr_parse (p_node,p_nls,p_nms,p_okpo,p_s);

  if p_nls is null then
     bars_error.raise_nerror(g_modcode, 'XML_TAG_EMPTY', 'NLS');
  end if;

  begin
     select 1 into i from accounts where nls = p_nls and kv = 980;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', p_nls, '980');
  end;

  if p_nms is null then
     begin
        select substr(nms, 1, 38) into p_nms from accounts where nls = p_nls and kv = 980;
     exception when no_data_found then
        bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', p_nls, '980');
     end;
  end if;

  if p_okpo is null then
     begin
        select substr(c.okpo, 1, 10) into p_okpo
          from accounts a, customer c
         where a.nls = p_nls and a.kv = 980
           and a.rnk = c.rnk;
     exception when no_data_found then
        bars_error.raise_nerror(g_modcode, '4', p_nls, '980');
     end;
  end if;

  if p_s is null then
     bars_error.raise_nerror(g_modcode, 'XML_TAG_EMPTY', 'SUMMA');
  end if;

end get_xml_attr;

-------------------------------------------------------------------------------
-- load_xml_file
-- загрузка файла xml (зарплатный файл)
--
procedure load_xml_file (p_par number)
is
  l_clob     clob;
  l_parser   dbms_xmlparser.Parser := dbms_xmlparser.newParser;
  l_doc      dbms_xmldom.DOMDocument;
  l_children dbms_xmldom.DOMNodeList;
  l_child    dbms_xmldom.DOMNode;
  l_length   number;
  l_nls      varchar2(14);
  l_nms      varchar2(38);
  l_okpo     varchar2(10);
  l_s        number;
begin

  delete from tmp_bpk_salary;

  -- вычитываем clob из врем таблицы
  bars_lob.import_clob(l_clob);

  -- парсим
  dbms_xmlparser.parseClob(l_parser, l_clob);
  l_doc := dbms_xmlparser.getDocument(l_parser);

  -- вычитываем свой тег (параметр)
  l_children := dbms_xmldom.getElementsByTagName(l_doc, 'ROW' );
  l_length   := dbms_xmldom.getLength(l_children);

  for i in 0 .. l_length - 1
  loop

     l_child := dbms_xmldom.item(l_children, i);

     get_xml_attr(l_child, l_nls, l_nms, l_okpo, l_s);

     if l_nls  is not null and
        l_nms  is not null and
        l_okpo is not null and
        l_s    is not null then
        insert into tmp_bpk_salary (nls, nms, okpo, s)
        values (l_nls, l_nms, l_okpo, l_s);
     end if;

  end loop;

end load_xml_file;

-------------------------------------------------------------------------------
-- pay_clob
--
procedure pay_clob (
  p_transit_acc  accounts.acc%type,
  p_filename     operw.value%type,
  p_buffer       clob,
  p_file_id out   number  
  )
is
  l_clob   clob;
  l_parser dbms_xmlparser.Parser := dbms_xmlparser.newParser;
  l_doc    dbms_xmldom.DOMDocument;
  l_children dbms_xmldom.DOMNodeList;
  l_child    dbms_xmldom.DOMNode;
  l_length   number;

  l_bankdate date;
  l_mfo      varchar2(6);
  l_kv       number := 980;
  l_tt       varchar2(3) := 'PKS';
  l_nazn     varchar2(160);

  l_transit_nls  varchar2(14);
  l_transit_nms  varchar2(38);
  l_transit_kv   number;
  l_transit_okpo varchar2(10);

  l_pk_nls  varchar2(14);
  l_pk_nms  varchar2(38);
  l_pk_okpo varchar2(10);
  l_s       number;

  l_ref      oper.REF%type    ;
  
  type  l_obpc_salary_import_log is  table of obpc_salary_import_log%rowtype;
  l_tab                  l_obpc_salary_import_log :=l_obpc_salary_import_log();  
  
  l_file_id   number;

begin

  p_file_id:=null;

  l_bankdate := gl.bdate;
  l_mfo      := f_ourmfo;

  begin
     select substr(nvl(nazn, 'Зарахування зарплати на картрахунок'),1,160)
       into l_nazn
       from tts
      where tt = l_tt;
  exception when no_data_found then
     l_nazn := 'Зарахування зарплати на картрахунок';
  end;

  begin
     select a.nls, a.kv, substr(a.nms,1,38), c.okpo
       into l_transit_nls, l_transit_kv, l_transit_nms, l_transit_okpo
       from accounts a, customer c
      where a.acc = p_transit_acc
        and a.rnk = c.rnk;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', null, to_char(l_kv));
  end;

  if l_kv <> l_transit_kv then
     bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', l_transit_nls, to_char(l_kv));
  end if;

  -- парсим
  dbms_xmlparser.parseClob(l_parser, p_buffer);
  l_doc := dbms_xmlparser.getDocument(l_parser);

  -- вычитываем свой тег (параметр)
  l_children := dbms_xmldom.getElementsByTagName(l_doc, 'ROW' );
  l_length   := dbms_xmldom.getLength(l_children);

  l_file_id := bars_sqnc.get_nextval('s_obpc_salary_import');
  
  for i in 0 .. l_length -1
  loop
     
     l_tab.extend;
     l_tab(i+1).file_id   := l_file_id;
     l_tab(i+1).file_name := p_filename;
     l_tab(i+1).crt_date  := sysdate;
     

     l_child := dbms_xmldom.item(l_children, i);
 

     begin
        get_xml_attr      (l_child, l_pk_nls, l_pk_nms, l_pk_okpo, l_s);
     exception when others then
        l_tab(i+1).error    := sqlerrm; 
        get_xml_attr_parse(l_child, l_pk_nls, l_pk_nms, l_pk_okpo, l_s);
     end;
     
     
     l_tab(i+1).nls    := l_pk_nls;     
     l_tab(i+1).fio    := l_pk_nms;     
     l_tab(i+1).inn    := l_pk_okpo;     
     l_tab(i+1).summa  := l_s;    

     if l_pk_nls        is not null and
        l_pk_nms        is not null and
        l_pk_okpo       is not null and
        l_tab(i+1).error     is  null and
        nvl(l_s,0) <> 0 then

       -- оплата одного
       gl.ref (l_ref);
       gl.in_doc3(
          ref_  => l_ref,
          tt_   => l_tt,
          vob_  => 6,
          nd_   => substr(to_char(l_ref),1,10),
          pdat_ => sysdate,
          vdat_ => l_bankdate,
          dk_   => 1,
          kv_   => l_kv,
          s_    => l_s,
          kv2_  => l_kv,
          s2_   => l_s,
          sk_   => null,
          data_ => l_bankdate,
          datp_ => l_bankdate,
          nam_a_=> l_transit_nms,
          nlsa_ => l_transit_nls,
          mfoa_ => l_mfo,
          nam_b_=> l_pk_nms,
          nlsb_ => l_pk_nls,
          mfob_ => l_mfo,
          nazn_ => l_nazn,
          d_rec_=> null,
          id_a_ => l_transit_okpo,
          id_b_ => l_pk_okpo,
          id_o_ => null,
          sign_ => null,
          sos_  => 1,
          prty_ => null,
          uid_  => user_id);

       payTT( 0, l_ref, l_bankdate, l_tt, 1,
          l_kv, l_transit_nls , l_s,
          l_kv, l_pk_nls, l_s );

       insert into operw (ref, tag, value) values (l_ref, 'IMPFL', p_filename);
       insert into operw (ref, tag, value) values (l_ref, 'SK_ZB', '84');

       l_tab(i+1).status  := 'Документ створено';   
       l_tab(i+1).ref  :=l_ref;   
       
     elsif l_pk_nls        is not null and instr(l_tab(i+1).error,'BPK-00021')>0
     then
       l_tab(i+1).status  := 'Документ не створено';   
       l_tab(i+1).link    := 'Посилання для введеня документу';  
     else 
       l_tab(i+1).status  := 'Документ не створено'; 
     end if;

     if l_tab(i+1).error is not null
     then 
     p_file_id:=l_file_id;
     end if;
     
  end loop;
  
     forall j in indices of l_tab
      
     insert into obpc_salary_import_log values l_tab(j) ;
  
     l_tab.delete();
     l_tab := null;
  
  
end pay_clob;

-------------------------------------------------------------------------------
-- pay_xml_file
-- оплата зарплатного файла xml
--
procedure pay_xml_file (
  p_transit_acc  accounts.acc%type,
  p_filename     operw.value%type )
is
  l_clob clob;
  l_id number;
begin
  -- вычитываем clob из врем таблицы
  bars_lob.import_clob(l_clob);
  pay_clob(p_transit_acc, p_filename, l_clob,l_id);
end pay_xml_file;

-------------------------------------------------------------------------------
-- imp_acct
--
procedure imp_acct(p_id number)
is
  refcur SYS_REFCURSOR;
  l_branch     varchar2(5);
  l_mfo        varchar2(6);
  l_card_acct  varchar2(10);
  l_acc_type   varchar2(2);
  l_currency   varchar2(3);
  l_lacct      varchar2(25);
  l_client_n   varchar2(40);
  l_card_type  number(38);
  l_tip        char(3);
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  delete from obpc_acct_imp;

  open refcur for
    'select branch, mfo, card_acct, acc_type, currency,
            lacct, client_n, card_type
       from test_obpc_acct_imp';

  loop
     fetch refcur into l_branch, l_mfo, l_card_acct, l_acc_type, l_currency,
        l_lacct, l_client_n, l_card_type;
     exit when refcur%notfound;

     begin
        select tip into l_tip
          from demand_acc_type
         where card_type = l_card_type
           and acc_type  = l_acc_type;
     exception when no_data_found then
        l_tip := null;
     end;

     insert into obpc_acct_imp (branch, mfo, card_acct, acc_type, currency,
        lacct, client_n, card_type, tip)
     values (l_branch, l_mfo, l_card_acct, l_acc_type, l_currency,
        l_lacct, l_client_n, l_card_type, l_tip);
  end loop;
  close refcur;
*/
end imp_acct;

end;
/
 show err;
 
PROMPT *** Create  grants  OBPC ***
grant EXECUTE                                                                on OBPC            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OBPC            to OBPC;
grant EXECUTE                                                                on OBPC            to WR_ALL_RIGHTS;
grant EXECUTE                                                                on OBPC            to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/obpc.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 