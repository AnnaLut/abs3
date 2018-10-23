 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_ow.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_OW 
is

g_header_version  constant varchar2(64)  := 'version 4.289 22/08/2018';
g_header_defs     constant varchar2(512) := '';

subtype t_trmask is OW_TRANSNLSMASK%rowtype;                      

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

-- Конвертит blob в clob
function blob_to_clob (blob_in in blob) return clob;

-------------------------------------------------------------------------------
-- ow_init
-- процедура инициализации параметров пакета
--
procedure ow_init;

-- процедура импорта файлов от Way4 - для вертушки
procedure w4_import_files (
  p_filename     varchar2,
  p_filebody     blob,
  p_msg      out varchar2,
  p_docs     out nocopy clob );

-- процедура формирования файлов для Way4 - для вертушки
procedure w4_form_files (
  p_filename out varchar2,
  p_filebody out nocopy clob );

-- процедура импорта файла *.xml
procedure import_file (
  p_filename in     varchar2,
  p_fileid   in out number,
  p_msg         out varchar2 );

-- процедура разбора файлов xml
procedure parse_file (
  p_fileid in number );

-- процедура установки статуса обработки файла
procedure set_file_status (
  p_id     number,
  p_nrow   number,
  p_status number,
  p_err    varchar2 );

-- процедура импорта файла на обновление реквизитов клиентоа OpenPack.xml
procedure import_op_file (
  p_impid  in number,
  p_err   out number );

-- импорт различных файлов (данные уже помещены в табл. imp_file)
procedure import_files (
  p_mode     number,
  p_filename varchar2 );

-- процедура оплаты файла
procedure pay_oic_file (p_id number);

-- процедура установки флага оплаты документа
procedure set_pay_flag (
  p_fileid    in number,
  p_fileidn   in number,
  p_ref       in number,
  p_par       in number );

-- процедура ручной квитовки документа:
--   документ из файла ПЦ ATransfers (p_id, p_idn)
--   квитуется с документом АБС p_ref
procedure matching_ref (p_id number, p_idn number, p_ref number, p_par number);

-- процедура принудительной оплаты документа, отправленного в ПЦ
--   (без квитовки, не дожидаясь подтверждения из ПЦ)
procedure payment_ref (p_ref number, p_dk number);

-- процедура удаления транзакции из файла в архив без оплаты в АБС
procedure delete_tran (p_id number, p_idn number);

-- процедура удаления документа из очереди на отправку в ПЦ
procedure del_pkkque (p_ref number, p_dk number);

-- процедура удаления файла (для возможности повторного импорта)
procedure delete_file (p_fileid number);

-- процедура клиринга - межфилиальных расчетов между ГОУ и РУ
procedure cliring (p_par number);

-- функция возвращает транзитный счет отделения счета p_acc
function get_transit (p_acc number, p_defnull number default 0) return varchar2;

-- процедура формирования файлов пополнения/списания IIC*
procedure form_iic_file (p_mode in out number, p_filename out varchar2, p_impfileid out number);

-- процедура снятия отметки об отправке документа
procedure unform_iic_doc (
  p_filename in varchar2,
  p_ref      in number,
  p_dk       in number );

-- процедура снятия отметки об отправке счета
procedure unform_iic_acc (
  p_filename in varchar2,
  p_acc      in number );

-- процедура регистрации клиента по файлу
procedure create_customer (
  p_client in out ow_salary_data%rowtype,
  p_branch        varchar2 );

-- процедура обновления незаполненных реквизитов клиента
procedure alter_client (p_rnk number, p_clientdata ow_salary_data%rowtype);

-- процедура проверки заполнения обязательных реквизитов для перерегистрации карточки
procedure check_pkcustomer (p_pk_nd in number);

-- функция проверки перед открытием карточки
function check_opencard (
  p_rnk       in number,
  p_cardcode  in varchar2 ) return varchar2;

-- процедура проверки перед открытием карточки по З/П файлу
procedure check_salary_opencard (
  p_id       number,
  p_cardcode varchar2 );

-- процедура установки флага открытия карточки
procedure set_salary_flagopen (
  p_id       number,
  p_idn      number,
  p_flagopen number );

-- процедура установки acc счета Instant
procedure set_salary_accinstant (
  p_id         number,
  p_idn        number,
  p_accinstant number );

-- процедура сохранения фото клиента
procedure set_salary_photo (
  p_id    number,
  p_idn   number,
  p_photo blob );

-- процедура открытия карточки
procedure open_card (
  p_rnk           in number,
  p_nls           in varchar2,
  p_cardcode      in varchar2,
  p_branch        in varchar2,
  p_embfirstname  in varchar2,
  p_emblastname   in varchar2,
  p_secname       in varchar2,
  p_work          in varchar2,
  p_office        in varchar2,
  p_wdate         in date,
  p_salaryproect  in number,
  p_term          in number,
  p_branchissue   in varchar2,
  p_barcode       in varchar2 default null,
  p_cobrandid     in varchar2 default null,
  p_sendsms       in number default 1,
  p_nd            out number,
  p_reqid         out number );

-- процедура добавления запроса для CardMake
procedure add_deal_to_cmque (
  p_nd       in number,
  p_opertype in number,
  p_ad_rnk in number default null, -- RNK клиента на которого необходимо выпустить доп. карту.
  p_card_type in varchar2 default null, -- карточный субпродукт
  p_cntm in integer default null  -- срок действия карты
   );

-- процедура установки % ставок
procedure set_accounts_rate (p_par number);

-- процедура установки спецпараметров счетов
procedure set_sparam (p_mode varchar2, p_acc number, p_trmask t_trmask);

-- процедура изменения типа карточки
procedure cng_card ( p_nd number, p_card varchar2 );

-- процедура переформирования запроса в CardMake
procedure form_request (p_id number, p_opertype number);

-- процедура импорта файла зарплатных проектов - для WEB
procedure w4_import_salary_file (
  p_filename  in varchar2,
  p_filebody  in clob,
  p_fileid   out number,
  p_flag_kk   in number default 0 );

-- процедура импорта файла зарплатных проектов
procedure import_salary_file (
  p_filename in     varchar2,
  p_fileid   in out number );

-- процедура создания БПК по файлу З/П проекта - для WEB
procedure w4_create_salary_deal (
  p_fileid      in number,
  p_proect_id   in number,
  p_card_code   in varchar2,
  p_branch      in varchar2,
  p_isp         in number,
  p_ticketname out varchar2,
  p_ticketbody out nocopy clob );

-- процедура создания БПК по файлу З/П проекта - для WEB
procedure create_salary_deal (
  p_fileid    in number,
  p_proect_id in number,
  p_card_code in varchar2,
  p_branch    in varchar2,
  p_isp       in number );

-- процедура формирования тикета на файл З/П проекта
procedure form_salary_ticket (
  p_fileid     in out number,
  p_ticketname    out varchar2 );

procedure form_salary_ticket_ex (
  p_fileid     in out number,
  p_ticketname    out varchar2 );

-- функция поиска клиента по ОКПО и паспортным данным
function found_client (
  p_okpo    varchar2,
  p_paspser varchar2,
  p_paspnum varchar2,
  p_spd     number default 0 ) return number;

-- процедура перевыпуска счета PK для Way4
procedure pk_reopen_card (
  p_cardcode      in varchar2,
  p_salaryproect  in number );

-- процедура переноса остатка со счета PK на счет Way4
procedure pk_repay_card (p_pk_nd number);

-- процедура закрытия счетов PK
procedure pk_close_card (p_pk_nd number);

-- процедура проверки: можно закрыть договор?
procedure can_close_deal (
  p_nd   in number,
  p_msg out varchar2 );

-- процедура закрытия счетов договора
procedure close_deal (
  p_nd   in number,
  p_msg out varchar2 );

-- процедура обработки запросов CardMake
procedure cm_process_request ( p_mode in number );

-- процедура удаления запросов CardMake
procedure cm_delete_request ( p_opertype number, p_datein date, p_nls varchar2 );

-- процедура синхронизации З/П проектов CardMake
procedure cm_salary_sync (p_par number);

-- процедура открытия карт Instant
procedure create_instant_cards (
  p_cardcode varchar2,
  p_branch   varchar2,
  p_cardnum  number );

-- процедура установки параметра "Дата выдачи карты"
procedure set_idat ( p_nd number, p_dat date );

-- процедура привязки счетов БПК
procedure set_w4_acc (
  p_acc_pk    accounts.acc%type,
  p_nls_ovr   accounts.nls%type,
  p_nls_9129  accounts.nls%type,
  p_nls_2208  accounts.nls%type,
  p_nls_3570  accounts.nls%type,
  p_nls_2207  accounts.nls%type,
  p_nls_2209  accounts.nls%type,
  p_nls_3579  accounts.nls%type );

function get_impid (p_mode number default null) return number;

function get_nd_param (p_nd number, p_tag varchar2) return varchar2;

function get_nd_param_indate (p_nd number, p_tag varchar2) return date;

function get_nd_param_innumber (p_nd number, p_tag varchar2) return number;

procedure set_nd_param (p_nd number, p_tag varchar2, p_value varchar2);

procedure set_nd_param_indate (p_nd number, p_tag varchar2, p_value date);

procedure set_nd_param_innumber (p_nd number, p_tag varchar2, p_value number);

procedure set_msgcode_payaccad (p_ref number, p_flag number);

function get_nls_on2625_cardpay (p_nls varchar2, p_kv number, p_pk_acc number) return varchar2;

function get_nls_on2625_cardpay (p_nls varchar2, p_kv number) return varchar2;

procedure set_pass_date (
  p_nd         number,
  p_pass_date  date,
  p_pass_state number );
procedure create_dop_kk (p_nd number, p_cardcode varchar2);
procedure check_dop_kk (p_nd in number, p_msg out varchar2);
procedure set_bpk_parameter(p_nd number, p_tag varchar2, p_value varchar2);


procedure pay_2625_cardpay(
  p_id       in number,
  p_filename in varchar2,
  p_filedate in date,
  p_start_id in number default null,
  p_end_id   in number default null,
  p_bdate    in date default null
  );

procedure pay_others_cardpay(
  p_id       in number,
  p_filename in varchar2,
  p_filedate in date,
  p_start_id in number default null,
  p_end_id   in number default null,
  p_bdate    in date default null);

--запуск процесса в параллельном режиме
procedure run_parallel(p_task           in varchar2,
                       p_chunk          in varchar2,
                       p_stmt           in varchar2,
                       p_parallel_level integer);

--Проверка возможности выпуска карты школьника
procedure check_ad_pupil_card(p_nd        in number,
                              p_pupil_rnk in number,
                              p_msg       out varchar2);

--Создание карты школьника
procedure create_ad_pupil_card(p_nd        in number,
                               p_pupil_rnk in number,
                               p_cardcode  in varchar2,
                               p_term      in number);

procedure create_key(p_key_value  in varchar2,
                      p_start_date in date,
                      p_end_date   in date);

procedure edit_key (p_key_id in number, p_end_date in date);

procedure disable_key (p_key_id in number);

procedure reverse_locpay(p_ref in number);

--Функции перекодирования в/с base64
function encodeclobtobase64(p_clob clob) return clob;

function decodeclobfrombase64(p_clob clob) return clob;

procedure add_sep_rev_to_queue;

procedure set_term(p_nd   number,
                   p_bdat date,
                   p_term number);

function f_add_deal_to_cmque(p_nd        in number,
                             p_opertype  in number,
                             p_ad_rnk    in number default null, -- RNK клиента на которого необходимо выпустить доп. карту.
                             p_card_type in varchar2 default null, -- карточный субпродукт
                             p_cntm      in integer default null, -- срок действия карты
                             p_wait_confirm in integer default null
                             ) return cm_client_que%rowtype;

procedure web_import_files(p_filename varchar2,
                           p_filebody blob,
                           p_fileid   out number,
               p_msg out varchar2);

procedure unform_iic(p_file_name in varchar2,
                     p_ref       in number,
                     p_dk        in number,
                     p_acc       in number);

-- процедура проверки платежа по документам перед ручным проведением
procedure check_bpdoc (p_fileid    in number,
                       p_fileidn   in number);

procedure create_instant_cards_m (p_cardcode    varchar2,
                                  p_delivery_br varchar2,
                                  p_cardnum     number );

procedure confirm_acc(p_acc     in number_list,
                      p_confirm in number);

procedure web_out_files(p_mode in number,
                        p_filename out varchar2,
                        p_filebody out clob,
                        p_msg out varchar2
                        );

function check_available(p_nls in varchar2, p_kv in number, p_s in number)
  return boolean;

procedure final_payment (p_ref  in number,
                         p_dk   in number,
                         b_kvt out boolean,
                         -- p_mode - режим квитовки:
                         --   0 - квитовка документов, инициированных Банком
                         --   1 - квитовка документов, инициированных 3-й стороной (ВЕБ-Банкинг)
                         --   2 - квитовка документов, свободные реквизиты
                         p_mode in number default 0 );

procedure set_cck_sob (
  p_ref           number,
  p_dk            number,
  p_acc           number,
  p_transfer_flag number,
  p_sucs_flag     boolean );

-------------------------------------------------------------------------------
-- COBUMMFO-7501
function get_nls (  
                    p_nls      in accounts.nls%type
                    , p_nlsalt in accounts.nls%type
                    , p_kf     in accounts.kf%type
                 ) return accounts.nls%type;
                 
--function get_new_nbs(p_nbs in varchar2) return varchar2;
procedure open_2203 (
   p_pk_acc  in number,
   p_oldacc  in number,
   p_oldnls  in varchar2,
   p_oldnms  in varchar2,
   p_newnbs  in varchar2,
   p_newacc out number);



  function check_cust_dk(p_rnk customer.rnk%TYPE, p_card_code w4_card.code%TYPE) return integer;

  --процедура получения данных по адресам клиента
procedure get_address_client(
  p_rnk in  number,
  p_type in number,
  p_city_type out varchar2,
  p_house out varchar2,
  p_flat out varchar2,
  p_street_type out varchar2,
  p_street out varchar2
  );
  ---процедура зміни статуса запиту до СМ з 99 на  1 після відповіді СМ W4_CARD_ADD (6327)
  procedure add_deal_to_cmque_dk(
            p_datemod     in cm_client_que.datemod%TYPE,
            p_resp_txt    in cm_client_que.resp_txt%TYPE,
            p_reqid       in cm_client_que.id%TYPE
          ) ;




end;

/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_OW 
is

--
-- constants
--
g_body_version    constant varchar2(64)  := 'version 6.023 22/08/2018';
g_body_defs       constant varchar2(512) := '';

g_modcode         constant varchar2(3)   := 'BPK';

g_filetype_atrn   constant varchar2(30)  := 'ATRANSFERS';
g_filetype_ftrn   constant varchar2(30)  := 'FTRANSFERS';
g_filetype_strn   constant varchar2(30)  := 'STRANSFERS';
g_filetype_doc    constant varchar2(30)  := 'DOCUMENTS';
g_filetype_rxa    constant varchar2(30)  := 'RXADVAPL';
g_filetype_riic   constant varchar2(30)  := 'R_IIC_DOCUMENTS';
g_filetype_cng    constant varchar2(30)  := 'CNGEXPORT';
g_filetype_roic   constant varchar2(30)  := 'R_DOCUMENTS_REV';

g_keytype         constant varchar2(30)  := 'WAY_DOC';
g_check_limit     number;
-- латиница: A-Z(загловн_ л_тери),
-- цифри: 1234567890,
-- символи:  ' (апостроф),  / (слеш), - (тире), . (точка)
g_w4_engname_char constant varchar2(100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/-.';
g_w4_fio_char     constant varchar2(100) := 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'||'АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'||chr(39)||'-';
g_w4_email_char   constant varchar2(100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@-.';
g_digit           constant varchar2(100) := '1234567890';

-- Запросы CardMake:
-- закрытие счета
g_cmaccrequest_closeacc    number := 1;
-- изменение субпродукта
g_cmaccrequest_altersub    number := 2;
-- изменение терміну дії основної картки
g_cmaccrequest_alterexpire number := 3;


g_chkid       number;
g_chkid_hex   varchar2(2);
g_chkid2      number;
g_chkid2_hex  varchar2(2);

-- Код операции гашения КД с карточки
g_tt_asg      varchar2(3);

-- Код бранча для Way4
g_w4_branch   varchar2(4);
-- Количество счетов в файле IIC
g_iicnum      number;
-- Маршрут создания НК: 1-через CardMake, 0-через Way4
g_w4_lc       number;
-- 1=Проверять Дату выдачи карты при миграции PK
g_check_idat  number;
-- счет 3800 для ГОУ
g_nls3800     varchar2(14);
-- счет 9900 для ГОУ
g_nls9900     varchar2(14);
-- бранч, который передается в CM
g_cm_branch   varchar2(30);

--
--  types
--
type t_cng   is table of ow_cng_data%rowtype;
type t_atrn  is table of ow_oic_atransfers_data%rowtype;
type t_strn  is table of ow_oic_stransfers_data%rowtype;
type t_doc   is table of ow_oic_documents_data%rowtype;
type t_salp  is table of ow_salary_data%rowtype;
type t_operw is table of operw%rowtype;

type t_tr2924 is record ( branch v_w4_tr2924.branch%type,
                          nls    v_w4_tr2924.nls%type );
type t_tr2924_tbl is table of t_tr2924;
g_nls_trans t_tr2924_tbl;

type t_product is record ( product_grp  w4_product_groups.code%type,
                           product_code w4_product.code%type,
                           card_code    w4_card.code%type,
                           sub_code     w4_card.sub_code%type,
                           kv           w4_product.kv%type,
                           nbs          w4_product.nbs%type,
                           ob22         w4_product.ob22%type,
                           tip          w4_product.tip%type,
                           custtype     w4_product_groups.client_type%type,
                           schemeid     w4_product_groups.scheme_id%type,
                           rate         cm_product.percent_osn%type,
                           flag_instant w4_subproduct.flag_instant%type,
                           date_instant w4_subproduct.date_instant%type,
                           flag_kk      w4_subproduct.flag_kk%type );

type t_iicdoc_tbl is table of v_ow_iicfiles_form%rowtype;

type t_insurance is record(nd         w4_acc.nd%type,
                           last_name  varchar2(30),
                           first_name varchar2(30),
                           midl_name  varchar2(30),
                           okpo       varchar2(10),
                           ser        person.ser%type,
                           numdoc     person.numdoc%type,
                           pdate      person.pdate%type,
                           bday       person.bday%type,
                           phone      person.cellphone%type,
                           adr        customer.adr%type,
                           ins_number ins_w4_deals.deal_id%type,
                           datefrom   date,
                           dateto     date,
                           ext_id     ins_w4_deals.ins_ext_id%type,
                           ext_code   INS_EWA_PROD_PACK.EWA_TYPE_ID%type,
                           haveins    number,
                           haveoldins number,
                           ins_ukr_id number,
                           ins_wrd_id number,
                           nls        accounts.nls%type,
                           logname    staff$base.logname%type,
                           branch_u   branch.branch%type,
                           mfo        varchar2(6),
                           ins_nls    varchar2(15),
                           ins_mfo    varchar2(12),
                           ins_okpo   customer.okpo%type,
                           ins_name   ins_partners.name%type
                           );

type t_newnb is record(nbs varchar2(4),
                      ob22 varchar2(2));
-------------------------------------------------------------------------------
-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header bars_ow ' || g_header_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      ||  g_header_defs;
end header_version;

-------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body bars_ow ' || g_body_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      || g_body_defs;
end body_version;

function get_new_nbs_ob22(p_nbs in varchar2, p_ob22 in varchar2)
  return t_newnb is
  l_newnb t_newnb;
begin
  select t.r020_new, t.ob_new
    into l_newnb
    from transfer_2017 t
   where t.r020_old = p_nbs
     and t.ob_old = p_ob22;
  return l_newnb;
exception
  when others then
    l_newnb.nbs := p_nbs;
    l_newnb.ob22 := p_ob22;
    return l_newnb;
end;

/*function get_new_nbs(p_nbs in varchar2) return varchar2
  is
begin
  return case substr(p_nbs, 1, 4)
                when '2202' then
                 '2203'
                when '2207' then
                 '2203'
                when '2209' then
                 '2208'
                when '3579' then
                 '3570'
                else
                 substr(p_nbs, 1, 4)
         end;
end;*/
-------------------------------------------------------------------------------
---процедура зміни статуса запиту до СМ з 99 на  1 після відповіді СМ
--W4_CARD_ADD (6327)
---
procedure add_deal_to_cmque_dk(
            p_datemod     in cm_client_que.datemod%TYPE,
            p_resp_txt    in cm_client_que.resp_txt%TYPE,
            p_reqid       in cm_client_que.id%TYPE
          )
  is
 l_card_code_add w4_card_add.card_code_add%TYPE;
 l_rnk customer.rnk%TYPE;
 l_reqid_add cm_client_que.id%TYPE;
begin
   select  a.rnk ,   ad.card_code_add
   into    l_rnk,   l_card_code_add
   from cm_client_que q
     INNER JOIN accounts a on a.acc=q.acc
     inner join w4_card_ADD ad on ad.card_code=q.card_type
   where q.id=p_reqid;
 -------
for rec in (
    select q.id
    from cm_client_que q
         inner join accounts a on a.acc=q.acc and a.rnk=l_rnk and q.card_type=l_card_code_add    )
 loop
  update cm_client_que
      set datemod     = p_datemod,
          oper_status = 1,
          resp_txt    = p_resp_txt
    where id = rec.id ;
 end loop;
end add_deal_to_cmque_dk ;
--------------------------------------------------------------------
--перевірка клієнта на відповідність вимог для відкриття додаткової картки до ЗП картки
-- w4_card_add
function check_cust_dk(p_rnk customer.rnk%TYPE, p_card_code w4_card.code%TYPE) return integer
is
  l_err integer:=0;
begin
  --відсутня заборгованність ?
    begin
     select l_err+1 into l_err from accounts acc
     where tip in ( 'SK9', 'SP', 'SPN') and ostc != 0 and acc.rnk=p_rnk;
     if l_err>0 then
       logger.info('BARS_OW.check_cust_kk:присутня прострочена заборгованість');
       return l_err;
     end if;
    exception
     when no_data_found then null;
    end;
  --валідний вік
    begin
      select l_err+0 into l_err  from person p where p.rnk =p_rnk and
      (select trunc(months_between(sysdate,p.bday)/12) from dual )<74 and
      (select trunc(months_between(sysdate,p.bday)/12) from dual )>18 ;
    exception
      when no_data_found then l_err:=l_err+1 ;
      logger.info('BARS_OW.check_cust_kk:вік клієнта не відповідає вимогам');
      return l_err;
    end;
 /* --вже існує картка , що відкривається
    begin
      select l_err+1 into l_err from  w4_deal where cust_rnk = p_rnk and card_code = p_card_code;
     if l_err>0 then
       logger.info('BARS_OW.check_cust_kkв:вже відкрита додаткова картка');
       return l_err;
     end if;
    exception
      when no_data_found then null;
    end;*/
  --валідний тип документа
    begin
     select l_err+0 into l_err  from person p where rnk =p_rnk and  passp in (1,7);
    exception
     when no_data_found then
      l_err:=l_err+1 ;
      logger.info('BARS_OW.check_cust_kk:документ клієнта не відповідає вимогам');
      return l_err;
    end;
  --валідність кода ОКПО - відключити для тесту
    begin
--    select  f_validokpo(okpo)*(-1)+l_err into l_err from customer where rnk=p_rnk ;
     select l_err+1 into l_err from customer where rnk=p_rnk and (f_validokpo(okpo)*(-1))!=0;
     if l_err>0 then
       logger.info('BARS_OW.check_cust_kk: код ОКПО  не коректний');
       return l_err;
     end if;
    exception
       when no_data_found then null;
    end;
 --
    --без помилок
    return l_err;
end;
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- дані адреси клієнта (COBUMMFO-7587)
procedure get_address_client(
  p_rnk in  number,
  p_type in number,
  p_city_type out varchar2,
  p_house out varchar2,
  p_flat out varchar2,
  p_street_type out varchar2,
  p_street out varchar2
  )
  as
begin
 select
     case
       when to_char(ca.locality_type_n) is not null then --NEW
                                                (select ln.settlement_tp_nm
                                                 from adr_settlement_types ln
                                                 where ln.settlement_tp_id=ca.locality_type_n )
         else --OLD
           (select lo.name from address_locality_type lo where lo.id=ca.locality_type )
     end  city_type
     ,ca.home as  house
     ,ca.room as  flat
     ,case
       when to_char(ca.street_type_n) is not null then --NEW
                                              (select sn.str_tp_nm
                                               from adr_street_types sn
                                               where sn.str_tp_id=ca.street_type_n )
         else --OLD
            (select so.name from address_street_type so where so.id=ca.street_type )
     end street_type
     ,ca.street
     into p_city_type,p_house,p_flat,p_street_type,p_street
     from customer_address ca
        left join address_street_type adst on adst.id=ca.street_type
     where ca.rnk = p_rnk and ca.type_id = p_type;
 exception
   when no_data_found then --null;
       p_city_type:=null;
       p_house:=null;
       p_flat:=null;
       p_street_type:=null;
       p_street:=null;
end;

-------------------------------------------------------------------------------
procedure check_address_client ( p_rnk in customer.rnk%TYPE,p_cm_err_msg out varchar2)
as
  l_city_type    varchar2(250);
  l_house        varchar2(250);--customer_address.home%TYPE;
  l_flat         varchar2(50); --customer_address.room%TYPE;
  l_street_type  varchar2(250);--address_street_type.name%TYPE;
  l_street       varchar2(250);--customer_address.street%TYPE;
  l_cm_err_msg   varchar2(1000);
begin

    get_address_client(p_rnk => p_rnk,p_type => 1, --
    p_city_type =>l_city_type,    p_house =>l_house,    p_flat => l_flat,    p_street_type =>l_street_type,    p_street => l_street    );
    if l_city_type   is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Тип населеного пункту'''' (прописки) не заповнено'||'</br>'; end if;
    if l_street_type is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Тип вулиці'''' (прописки) не заповнено'||'</br>';end if;
    if l_street      is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Вулиця'''' (прописки) не заповнено'||'</br>';end if;
    if l_house       is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Будинок'''' (прописки) не заповнено'||'</br>';end if;

    get_address_client(p_rnk => p_rnk,p_type => 2, --
    p_city_type =>l_city_type,    p_house =>l_house,    p_flat => l_flat,    p_street_type =>l_street_type,    p_street => l_street    );
    if l_city_type    is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Тип населеного пункту'''' (проживання) не заповнено'||'</br>'; end if;
    if l_street_type  is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Тип вулиці'''' (проживання) не заповнено'||'</br>';end if;
    if l_street       is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Вулиця'''' (проживання) не заповнено'||'</br>';end if;
    if l_house        is null then l_cm_err_msg:=l_cm_err_msg||'Поле ''''Будинок'''' (проживання) не заповнено'||'</br>';end if;

    p_cm_err_msg:=l_cm_err_msg;
end;


--процедура для проставления счетам 2924 признака пакетной оплаты
procedure setoptfor2924w4 is
  pragma autonomous_transaction;
  type l_acc is table of rowid;
  l_tab_rowid l_acc;
  ora_lock exception;
  pragma exception_init(ora_lock, -54);
begin
  select rowid bulk collect
    into l_tab_rowid
    from accounts a
   where a.nls in (select nls from v_w4_tr2924) and nvl(a.opt, 0) <> 1 and
         a.dazs is null and a.pap = 3
     for update nowait;
  if l_tab_rowid.count > 0 then
    forall i in 1 .. l_tab_rowid.count
      update accounts a set a.opt = 1 where rowid = l_tab_rowid(i);
  end if;
  commit;
exception
  when ora_lock then
    null;
end;
-------------------------------------------------------------------------------
-- ow_init
-- процедура инициализации параметров пакета
--
procedure ow_init is
  h varchar2(100) := 'bars_ow.ow_init. ';
begin

  g_chkid  := getglobaloption('BPK_CHK');
  g_chkid2 := getglobaloption('BPK_CHK2');
  if g_chkid is null then
     g_chkid := 30;
  end if;
  if g_chkid2 is null then
     g_chkid2 := 31;
  end if;
  g_chkid_hex  := lpad(chk.to_hex(g_chkid),2,'0');
  g_chkid2_hex := lpad(chk.to_hex(g_chkid2),2,'0');

  g_tt_asg := nvl(getglobaloption('ASG_FOR_BPK'), 'W4Y');

  select branch, nls
    bulk collect
    into g_nls_trans
    from v_w4_tr2924;
  --проставим признак пакетной оплаты по 2924
  setoptfor2924w4;
  begin
     select substr(val,1,4) into g_w4_branch from ow_params where par = 'W4_BRANCH';
  exception when no_data_found then
     g_w4_branch := '0000';
  end;

  begin
     select to_number(nvl(val,'1000')) into g_iicnum from ow_params where par = 'IICNUM';
  exception when others then
     g_iicnum := 1000;
  end;

  begin
     select to_number(nvl(val,'0')) into g_w4_lc from ow_params where par = 'W4_LC';
  exception when others then
     g_w4_lc := 0;
  end;

  begin
     select to_number(nvl(val,'0')) into g_check_idat from ow_params where par = 'CHECK_IDAT';
  exception when others then
     g_check_idat := 0;
  end;

  begin
     select val into g_nls3800 from ow_params where par = 'NLS_3800';
  exception when no_data_found then
     g_nls3800 := null;
  end;

  begin
     select val into g_nls9900 from params where par = 'NLS_9900';
  exception when no_data_found then
     g_nls9900 := null;
  end;

  /*if getglobaloption('GLB-MFO') = '300465' then
     g_cm_branch := '/300465/000000/';
  else
     g_cm_branch := null;
  end if;*/
  g_check_limit :=getglobaloption ('W4CHEKLIM');

  bars_audit.trace(h || 'Params:' ||
     ' g_chkid=>' || to_char(g_chkid) ||
     ' g_chkid2=>' || to_char(g_chkid2) ||
     ' g_chkid_hex=>' || g_chkid_hex ||
     ' g_chkid2_hex=>' || g_chkid2_hex ||
     ' g_w4_branch=>' || g_w4_branch ||
     ' g_iicnum=>' || g_iicnum ||
     ' g_w4_lc=>' || g_w4_lc ||
     ' g_check_idat=>' || g_check_idat);

end ow_init;

-------------------------------------------------------------------------------
function get_file_type ( p_filename  in varchar2 ) return varchar2
is
  l_filename varchar2(100);
  l_filetype varchar2(100);
begin

  l_filename := upper(p_filename);

  if instr(l_filename, 'CNGEXPORT') > 0 then
     l_filetype := g_filetype_cng;
  elsif instr(l_filename, 'OIC_ATRANSFERS') > 0 then
     l_filetype := g_filetype_atrn;
  elsif instr(l_filename, 'OIC_FTRANSFERS') > 0 then
     l_filetype := g_filetype_ftrn;
  elsif instr(l_filename, 'OIC_STRANSFERS') > 0 then
     l_filetype := g_filetype_strn;
  elsif instr(l_filename, 'R_OIC_DOCUMENTS') > 0 then
     l_filetype := g_filetype_roic;
  elsif instr(l_filename, 'OIC_DOCUMENTS') > 0 then
     l_filetype := g_filetype_doc;
  elsif instr(l_filename, 'RXADVAPL') > 0 then
     l_filetype := g_filetype_rxa;
  elsif instr(l_filename, 'R_IIC_DOCUMENTS') > 0 then
     l_filetype := g_filetype_riic;
  else
     l_filetype := null;
  end if;

  return l_filetype;

end get_file_type;

function get_ins_data(p_nls in varchar2) return t_insurance is
  l_insurance t_insurance;
begin

  select w.nd,
         min(decode(tt.tag, 'SN_LN', substr(tt.value, 1, 30), null)) last_name,
         min(decode(tt.tag, 'SN_FN', substr(tt.value, 1, 30), null)) first_name,
         min(decode(tt.tag, 'SN_MN', substr(tt.value, 1, 30), null)) midle_name,
         t.okpo, p.ser, p.numdoc, p.pdate, p.bday,
         '+380'||case when regexp_like(substr(coalesce(cw.value, p.cellphone, p.teld),-9), '[0-9]') then 
                           substr(coalesce(cw.value, p.cellphone, p.teld),-9) 
                      else '000000000'
                 end, 
         t.adr, iw.deal_id,
         decode(iw.date_from, null, trunc(sysdate), iw.date_from) dateform,
         case when iw.date_to is null then  add_months(trunc(sysdate), case when months_between(w.dat_end, trunc(sysdate)) < 12 then 12 
                                                                       when months_between(w.dat_end, trunc(sysdate)) < 24 and  months_between(w.dat_end, trunc(sysdate)) > 12 then 24 
                                                                       else  least(nvl(to_number(aw.value), 0), 36) end ) - 1 else iw.date_to end,
         case
           when iw.ins_ext_id is not null and
                iw.ins_ext_id in (wd.ins_ukr_id, wd.ins_wrd_id) then
            iw.ins_ext_id
           else
            wd.ins_ukr_id
         end,
         decode(iw.nd, null, 0, case when iw.ins_ext_id in (wd.ins_ukr_id, wd.ins_wrd_id) then 1 else 0 end),
         decode(iw.nd, null, 0, 1),
         wd.ins_ukr_id, wd.ins_wrd_id, a.nls,
         sys_context('bars_global', 'user_name') logname,
         a.branch branch,
         sys_context('bars_context', 'user_mfo') mfo
    into l_insurance.nd,
         l_insurance.last_name,
         l_insurance.first_name,
         l_insurance.midl_name,
         l_insurance.okpo, l_insurance.ser, l_insurance.numdoc, l_insurance.pdate, l_insurance.bday,
         l_insurance.phone, l_insurance.adr, l_insurance.ins_number,
         l_insurance.datefrom, l_insurance.dateto,
         l_insurance.ext_id,
         l_insurance.haveins,
         l_insurance.haveoldins,
         l_insurance.ins_ukr_id, l_insurance.ins_wrd_id, l_insurance.nls,
         l_insurance.logname,
         l_insurance.branch_u,
         l_insurance.mfo
    from customer t
    join person p
      on t.rnk = p.rnk
    join accounts a
      on t.rnk = a.rnk and a.nls = p_nls
    join w4_acc w
      on a.acc = w.acc_pk
    join w4_card wd
      on w.card_code = wd.code
    left join ins_w4_deals iw
      on w.nd = iw.nd
    left join customerw tt
      on tt.rnk = t.rnk and tt.tag in ('SN_FN', 'SN_LN', 'SN_MN')
    left join accountsw aw
      on a.acc = aw.acc and aw.tag = 'PK_TERM'
    left join customerw cw on t.rnk = cw.rnk and cw.tag = 'MPNO'
   group by w.nd, t.okpo, p.ser, p.numdoc, p.pdate, p.bday,
           '+380'||case when regexp_like(substr(coalesce(cw.value, p.cellphone, p.teld),-9), '[0-9]') then 
                             substr(coalesce(cw.value, p.cellphone, p.teld),-9) 
                        else '000000000'
                   end,
            t.adr, iw.deal_id,
            decode(iw.date_from, null, trunc(sysdate), iw.date_from),
            case when iw.date_to is null then  add_months(trunc(sysdate), case when months_between(w.dat_end, trunc(sysdate)) < 12 then 12 
                                                                       when months_between(w.dat_end, trunc(sysdate)) < 24 and  months_between(w.dat_end, trunc(sysdate)) > 12 then 24 
                                                                       else  least(nvl(to_number(aw.value), 0), 36) end ) - 1 else iw.date_to end,
            case
              when iw.ins_ext_id is not null and
                   iw.ins_ext_id in (wd.ins_ukr_id, wd.ins_wrd_id) then
               iw.ins_ext_id
              else
               wd.ins_ukr_id
            end,
            decode(iw.nd, null, 0, case when iw.ins_ext_id in (wd.ins_ukr_id, wd.ins_wrd_id) then 1 else 0 end),
            decode(iw.nd, null, 0, 1),
            wd.ins_ukr_id, wd.ins_wrd_id, a.nls, a.branch;

  --отримання реквізитів страхової компанії
    ins_ewa_mgr.get_prodpack_ins_k(l_insurance.ext_id,
                                   l_insurance.ins_nls,
                                   l_insurance.ins_mfo,
                                   l_insurance.ext_code,
                                   l_insurance.ins_okpo,
                                   l_insurance.ins_name);

  return l_insurance;
end;
-------------------------------------------------------------------------------
function get_impid (p_mode number default null) return number
is
  l_id number;
begin
  select bars_sqnc.get_nextval('S_OWIMPFILE') into l_id from dual;
  return l_id;
end get_impid;

-------------------------------------------------------------------------------
-- COBUMMFO-7501
-- get_nls
-- функция номер счета
--
function get_nls (  
                    p_nls      in accounts.nls%type
                    , p_nlsalt in accounts.nls%type
                    , p_kf     in accounts.kf%type
                 ) return accounts.nls%type
is
   l_nls       accounts.nls%type := null;
   l_type_flag ow_params.par%type;
begin
   if p_nlsalt is null or not regexp_like(p_nlsalt, '^26[0,2,5]5') 
   or (regexp_like(p_nlsalt, '^26[0,2,5]5') and regexp_like(p_nls, '^26[0,2,5]5')) then
      l_nls := p_nls;
   else 
      if regexp_like(p_nlsalt, '^2625') then
		 l_type_flag := 'W4_IICNLSP';
      else
		 l_type_flag := 'W4_IICNLSU';
	  end if;
      begin
		 select decode(p.val, '1', p_nls, p_nlsalt)
         into l_nls
         from ow_params p
         where p.par = l_type_flag and p.kf = p_kf;
	  exception
		 when others then
			l_nls := p_nlsalt;
	  end;
   end if;
   return l_nls;

end get_nls;

-------------------------------------------------------------------------------
-- get_nls_trans
-- функция возвращает транзитный счет отделения p_branch
--
function get_nls_trans ( p_branch varchar2 ) return varchar2
is
  l_nls varchar2(14) := null;
begin

  for i in g_nls_trans .first .. g_nls_trans.last
  loop
     if g_nls_trans(i).branch = substr(p_branch,1,15) then
        l_nls := g_nls_trans(i).nls;
        exit;
     end if;
  end loop;

  return l_nls;

end get_nls_trans;

-------------------------------------------------------------------------------
-- get_transit
-- функция возвращает транзитный счет отделения счета p_acc
--
function get_transit (p_acc number, p_defnull number default 0) return varchar2
is
  l_nls     varchar2(14) := null;
  l_branch  accounts.tobo%type := null;
begin

  begin
     select tobo into l_branch from accounts where acc = p_acc;
  exception when no_data_found then
     bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', p_acc);
  end;

  if length(l_branch) > 8 then
     l_nls := get_nls_trans(l_branch);
  else
     l_nls := null;
  end if;

  if l_nls is null and p_defnull = 0 then
     bars_error.raise_nerror('SVC', 'BRANCHPARAM_NOTEXISTS', 'TR2924_WAY4', substr(l_branch,1,15));
  end if;

  return l_nls;

end get_transit;

-------------------------------------------------------------------------------
-- get_newaccountnumber
-- функция возвращает свободный номер счета
--
function get_newaccountnumber (p_rnk number, p_nbs varchar2) return varchar2
is
  l_mfo varchar2(6)  := gl.amfo;
  l_nls varchar2(14) := null;
  l_tmp number;
  i     number;
  n     number;
  r     number;
begin
  i := 0;
  loop
     n := case when length(to_char(i))<=2 then 2 else length(to_char(i)) end;
     r := 9 - n;
     -- ищем счет
     l_nls := vkrzn(substr(l_mfo,1,5), p_nbs || '0' || lpad(to_char(i), n, '0') || substr(lpad(to_char(p_rnk), 7, '0'),-r));
     begin
        select 1 into l_tmp from accounts where nls = l_nls;
     exception
        when no_data_found then
           -- такого счета еще нет, можем открывать
           exit;
        when too_many_rows then
           -- мультивалютный счет, ищем дальше
           null;
     end;
     i := i + 1;
  end loop;
  return l_nls;
end get_newaccountnumber;
------------------------------------------------------------------
--процедура для проставления счетам признака пакетной оплаты
procedure setoptfornlsw4(p_nls in accounts.nls%type) is
  pragma autonomous_transaction;
  type l_acc is table of rowid;
  l_tab_rowid l_acc;
  ora_lock exception;
  pragma exception_init(ora_lock, -54);
begin
  select rowid bulk collect
    into l_tab_rowid
    from accounts a
   where a.nls = p_nls and a.dazs is null and a.pap = 3
     for update nowait;
  if l_tab_rowid.count > 0 then
    forall i in 1 .. l_tab_rowid.count
      update accounts a set a.opt = 1 where rowid = l_tab_rowid(i);
  end if;
  commit;
exception
  when ora_lock then
    null;
end;
-------------------------------------------------------------------------------
-- get_account
-- функция для получения параметров счета для оплаты документа
--
function get_account (
  p_nls     in varchar2,
  p_kv      in number,
  p_nms    out varchar2,
  p_okpo   out varchar2,
  p_branch out varchar2 ) return boolean
is
  f boolean;
  l_opt accounts.opt%type;

begin
  begin
     select nms, okpo, tobo, opt
       into p_nms, p_okpo, p_branch, l_opt
       from (  -- COBUMMFO-7501
               select substr(nvl(c.nmk, a.nms),1,38) nms, c.okpo, a.tobo, nvl(a.opt,0) opt
               from accounts a
               join customer c on c.rnk = a.rnk
               where (a.nls = p_nls or a.nlsalt = p_nls) and a.kv = p_kv and a.dazs is null
               order by a.daos 
            )
      where rownum = 1;
      f := true;
      if l_opt = 0 and substr(p_nls,1,4) in ('2920',2924) then
         setoptfornlsw4(p_nls);
      end if;
  exception when no_data_found then
     p_nms    := null;
     p_okpo   := null;
     p_branch := null;
     f := false;
  end;
  return f;
end get_account;

-------------------------------------------------------------------------------
-- get_account
-- функция для получения параметров счета для оплаты документа
--
function get_account (
  p_nls     in varchar2,
  p_kv      in number,
  p_nms    out varchar2,
  p_okpo   out varchar2,
  p_branch out varchar2,
  p_acc    out number
   ) return boolean
is
  f boolean;
  l_opt accounts.opt%type;

begin
  begin
     select nms, okpo, tobo, opt, acc
       into p_nms, p_okpo, p_branch, l_opt, p_acc
       from (  -- COBUMMFO-7501
               select substr(nvl(c.nmk, a.nms),1,38) nms, c.okpo, a.tobo, nvl(a.opt,0) opt, a.acc
               from accounts a
               join customer c on c.rnk = a.rnk
               where (a.nls = p_nls or a.nlsalt = p_nls) and a.kv = p_kv  and a.dazs is null
               order by a.daos 
            )
      where rownum = 1;
      f := true;
      if l_opt = 0 and substr(p_nls,1,4) in ('2920',2924) then
         setoptfornlsw4(p_nls);
      end if;
  exception when no_data_found then
     p_nms    := null;
     p_okpo   := null;
     p_branch := null;
     p_acc    := null;
     f := false;
  end;
  return f;
end get_account;
-------------------------------------------------------------------------------
-- EXTRACT()
--
--   безопаcно получает значение по XPath
--
--
function extract (p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return varchar2 is
begin
  return p_xml.extract(p_xpath).getStringVal();
exception when others then
  if sqlcode = -30625 then
    return p_default;
  else
    raise;
  end if;
end extract;

-------------------------------------------------------------------------------
-- CONVERT_TO_NUMBER()
--
--   Конвертит строку в число  соответсвующим exept
--
--
function convert_to_number (p_str varchar2) return number
is
begin
  return to_number(replace(replace(p_str, ',', substr(to_char(11/10),2,1)), '.', substr(to_char(11/10),2,1)));
exception when others then
  raise_application_error(-20000, sqlerrm, true);
end convert_to_number;

-------------------------------------------------------------------------------
-- blob_to_clob()
--
--   Конвертит blob в clob
--
--
function blob_to_clob (blob_in in blob) return clob
is
    v_clob    clob;
    v_varchar varchar2(32767);
    v_start   pls_integer := 1;
    v_buffer  pls_integer := 32767;
begin
  dbms_lob.createtemporary(v_clob, true);

  for i in 1..ceil(dbms_lob.getlength(blob_in) / v_buffer)
  loop
     v_varchar := utl_raw.cast_to_varchar2(dbms_lob.substr(blob_in, v_buffer, v_start));
     dbms_lob.writeappend(v_clob, length(v_varchar), v_varchar);
     v_start := v_start + v_buffer;
  end loop;

  return v_clob;

end blob_to_clob;

function encodeclobtobase64(p_clob clob) return clob is
  l_clob   clob;
  l_len    number;
  l_pos    number := 1;
  l_buf    varchar2(32767);
  l_amount number := 32767;
begin
  l_len := dbms_lob.getlength(p_clob);
  dbms_lob.createtemporary(l_clob, true);

  while l_pos <= l_len
  loop
    dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
    l_buf := utl_encode.text_encode(l_buf, encoding => utl_encode.base64);
    l_pos := l_pos + l_amount;
    dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
  end loop;

  return l_clob;
end;

function decodeclobfrombase64(p_clob clob) return clob is
  l_clob   clob;
  l_len    number;
  l_pos    number := 1;
  l_buf    varchar2(32767);
  l_amount number := 32767;
begin
  l_len := dbms_lob.getlength(p_clob);
  dbms_lob.createtemporary(l_clob, true);

  while l_pos <= l_len
  loop
    dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
    l_buf := utl_encode.text_decode(l_buf, encoding => utl_encode.base64);
    l_pos := l_pos + l_amount;
    dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
  end loop;

  return l_clob;
end;
-------------------------------------------------------------------------------
-- check_permitted_char
-- функция проверки разрешенных символов
--
function check_permitted_char (p_str varchar2, p_permitted_char varchar2) return boolean
is
  b_check boolean := false;
  l_char  varchar2(1);
begin
  for i in 1..length(p_str)
  loop
     b_check := false;
     l_char  := substr(p_str, i, 1);
     for j in 1..length(p_permitted_char)
     loop
        if l_char = substr(p_permitted_char, j, 1) then
           b_check := true;
           exit;
        end if;
     end loop;
     if not b_check then
        exit;
     end if;
  end loop;
  return b_check;
end check_permitted_char;

-------------------------------------------------------------------------------
function check_eng (p_str varchar2) return boolean
is
begin
  return check_permitted_char(p_str, g_w4_engname_char);
end check_eng;

-------------------------------------------------------------------------------
function check_fio (p_str varchar2) return boolean
is
begin
  return check_permitted_char(p_str, g_w4_fio_char);
end check_fio;

-------------------------------------------------------------------------------
function check_email (p_str varchar2) return boolean
is
begin
  if instr(p_str,'@') = 0 then
     return false;
  end if;
  return check_permitted_char(p_str, g_w4_email_char);
end check_email;

-------------------------------------------------------------------------------
function check_digit (p_str varchar2) return boolean
is
begin
  return check_permitted_char(p_str, g_digit);
end check_digit;

-------------------------------------------------------------------------------
procedure set_file_status (
  p_id     number,
  p_nrow   number,
  p_status number,
  p_err    varchar2 )
is
begin
   update ow_files
      set file_n = p_nrow,
          file_status = p_status,
          err_text = p_err
    where id = p_id;
end set_file_status;

-------------------------------------------------------------------------------
-- set_operw
-- заполнение доп. рекв. операций
--
procedure set_operw (p_ref number, p_tag varchar2, p_value varchar2)
is
begin
  if p_value is null then
     delete from operw where ref = p_ref and trim(tag) = trim(p_tag);
  else
     begin
        insert into operw (ref, tag, value)
        values (p_ref, p_tag, p_value);
     exception when dup_val_on_index then
        update operw set value = p_value where ref = p_ref and trim(tag) = trim(p_tag);
     end;
  end if;
end set_operw;

-------------------------------------------------------------------------------
procedure fill_operw_tbl (
  p_tbl in out t_operw,
  p_ref in     operw.ref%type,
  p_tag in     operw.tag%type,
  p_val in     operw.value%type )
is
begin
  if p_val is not null then
     p_tbl.extend;
     p_tbl(p_tbl.count).ref   := p_ref;
     p_tbl(p_tbl.count).tag   := p_tag;
     p_tbl(p_tbl.count).value := p_val;
     p_tbl(p_tbl.count).kf    := sys_context('bars_context','mfo');
  end if;
end fill_operw_tbl;

-------------------------------------------------------------------------------
-- final_payment
-- оплата по факту/доплата документа
--
procedure final_payment (
  p_ref  in number,
  p_dk   in number,
  b_kvt out boolean,
  -- p_mode - режим квитовки:
  --   0 - квитовка документов, инициированных Банком
  --   1 - квитовка документов, инициированных 3-й стороной (ВЕБ-Банкинг)
 --   2 - квитовка документов, свободные реквизиты
  p_mode in number default 0 )
is
  l_bdate  date;
  l_acc    number;
  l_nlsa   oper.nlsa%type;
  l_nlsb   oper.nlsb%type;
  l_kv     oper.kv%type;
  l_dk     oper.dk%type;
  l_tt     oper.tt%type;
  l_s      oper.s%type;
  l_s2     oper.s2%type;
  l_sos    oper.sos%type;
  l_nxt    varchar2(4);
  l_stmt   number;
  l_fdat   date;
  l_nextvisagrp oper.nextvisagrp%type;
  l_currvisagrp oper.currvisagrp%type;
  l_tt_w4_flag number;
  l_locpay_flag number := 0;
  l_isourmfo pls_integer;
  h varchar2(100) := 'bars_ow.final_payment. ';
----------------------------------------------------------------------------------------
  PROCEDURE put_ack(ref_ NUMBER, grp_ NUMBER) AS
    sum_   NUMBER;
    ack_   NUMBER;
    tt_    CHAR(3);
    chk_   VARCHAR2(80);
    hex_   VARCHAR2(6);

    pay_er EXCEPTION;
    PRAGMA EXCEPTION_INIT(pay_er, -20203);

    pos_   NUMBER;

    msg_   VARCHAR2(100);

    fli_   NUMBER;
    flg_   NUMBER;
    refL_  NUMBER;
    refA_  VARCHAR2(9);
    prty_  NUMBER;
    sos_   NUMBER;

    err_   NUMBER;    -- Return code
    rec_   NUMBER;    -- Record number
    mfoa_  VARCHAR2(12);   -- Sender's MFOs
    nlsa_  VARCHAR2(15);   -- Sender's account number
    mfob_  VARCHAR2(12);   -- Destination MFO
    nlsb_  VARCHAR2(15);   -- Target account number
    dk_    NUMBER;         -- Debet/Credit code
    s_     DECIMAL(24);    -- Amount
    vob_   NUMBER;         -- Document type
    nd_    VARCHAR2(10);   -- Document number
    kv_    NUMBER;         -- Currency code
    datD_  DATE;           -- Document date
    datP_  DATE;           -- Posting date
    nam_a_  VARCHAR2(38);  -- Sender's customer name
    nam_b_  VARCHAR2(38);  -- Target customer name
    nazn_   VARCHAR(160);  -- Narrative
    nazns_ CHAR(2);        -- Narrative contens type
    id_a_  VARCHAR2(14);   -- Sender's customer identifier
    id_b_  VARCHAR2(14);   -- Target's customer identifier
    id_o_  VARCHAR2(8);    -- Teller identifier
    sign_  OPER.SIGN%TYPE; -- Signature
    datA_  DATE;           -- Input file date/time
    d_rec_ VARCHAR2(80);   -- Additional parameters

    l_dk   oper.dk%type;
  BEGIN

     BEGIN
        SELECT o.tt,o.chk,o.refl
          INTO   tt_, chk_, refL_
          FROM oper o
         WHERE o.ref=ref_ AND o.sos>0 AND o.sos<5 AND o.vdat<=gl.bDATE
           FOR UPDATE OF sos NOWAIT;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN;
     END;

     -- читаем флаги из tts
     select fli, SUBSTR(flags,38,1) into fli_, flg_ from tts where tt=tt_;


     BEGIN
        SELECT SUM(DECODE(dk,0,-s,s)) INTO sum_
          FROM opldok
         WHERE ref = ref_ AND sos < 5 AND fdat <= gl.bDATE;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
          sum_ := NULL;
     END;

     if l_dk in (2,3) then
        sum_ := 0;
     end if;

     IF sum_ = 0 THEN     -- Check if the document acknowleged

        BEGIN  -- Clear document

           SAVEPOINT chk_pay_before;
           hex_:=chk.put_stmp(grp_);


           UPDATE oper SET chk=RTRIM(NVL(chk,''))||hex_ WHERE ref=ref_
               RETURNING chk INTO chk_;
           INSERT INTO oper_visa (ref, dat, userid, groupid, status)
                 VALUES (ref_, sysdate, user_id, grp_,    1);

           chk.doc_ack ( ref_,tt_,chk_,ack_);

           IF ack_ = 1 THEN

              gl.pay ( 2, ref_, gl.bDATE);

              IF fli_=1 AND (flg_=0 OR flg_=1 OR flg_=3) THEN

                 SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                        datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                        id_o, sign, d_rec, sos, ref_a, prty
                   INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                        datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                        id_o_,sign_,d_rec_, sos_, refA_, prty_
                   FROM oper WHERE ref=ref_;

                 IF sos_ = 5 THEN -- Value date arrived

                    IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
                       nazns_ := '11';
                    ELSE
                       nazns_ := '10';
                    END IF;

                    datA_  := TO_DATE (TO_CHAR(datP_,'MM-DD-YYYY')||' '||
                              TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

                    err_ := -1;
                    rec_ :=  0;

                    sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                           vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                            NULL,nazns_,id_a_,id_b_,'******',refA_,0,'00',
                                 NULL,NULL,datA_,d_rec_,0,ref_);

                    IF err_=0 THEN
                       IF prty_>0 THEN    -- Set SSP flag
                           UPDATE arc_rrp SET prty=prty_ WHERE rec=rec_;
                       END IF;
                    ELSE
                       ROLLBACK TO chk_pay_before;
                       raise_application_error(-20000, 'Невозможно передать в СЭП: Ош.'||err_);
                    END IF;

                 END IF;
              END IF;
           END IF; -- ack_ = 1

        EXCEPTION
           WHEN OTHERS THEN ROLLBACK TO chk_pay_before;

               msg_ := SUBSTR(SQLERRM,13,100);
               pos_ := INSTR(msg_,CHR(10));

               IF pos_ > 0 THEN
                  msg_ := SUBSTR(msg_,1,pos_-1);
               END IF;
               raise_application_error(-20000, 'Невозможно передать в СЭП: Ош.'||msg_);
        END;
     END IF;
  END;
begin

  bars_audit.info(h || 'Start. p_ref=>' || p_ref);

  l_bdate := gl.bdate;

  b_kvt := false;

  begin

     if p_mode = 0 then
        select a.acc, a.nls,  a.kv, q.dk, o.tt, decode(o.kv, o.kv2, o.s, decode(o.dk, 0, o.s, o.s2)), o.sos, o.currvisagrp, o.nextvisagrp, nvl2(trim(wt.tt),1,0), nvl2(ow.ref,1,0), decode(o.mfoa, o.mfob, 1, 0), o.s2
          into l_acc, l_nlsb, l_kv, l_dk, l_tt, l_s, l_sos, l_currvisagrp, l_nextvisagrp, l_tt_w4_flag, l_locpay_flag, l_isourmfo, l_s2
          from ow_pkk_que q, oper o, accounts a, w4_sto_tts wt, ow_locpay_match ow
         where q.ref = p_ref
           and q.dk  = p_dk
           and q.sos = 1
           and q.ref = o.ref
           and q.acc = a.acc
           and o.sos > 0
           and o.tt = wt.tt(+)
           and q.ref = ow.ref(+);
     elsif p_mode = 2 then
        select a.acc, a.nls,  a.kv, 0, o.tt, decode(o.kv, o.kv2, o.s, decode(o.dk, 0, o.s, o.s2)), o.sos, o.currvisagrp, o.nextvisagrp, nvl2(trim(wt.tt),1,0), decode(o.mfoa, o.mfob, 1, 0), o.s2
          into l_acc, l_nlsb, l_kv, l_dk, l_tt, l_s, l_sos, l_currvisagrp, l_nextvisagrp, l_tt_w4_flag, l_isourmfo, l_s2
          from ow_locpay_match q, oper o, accounts a, tabval$global v, w4_sto_tts wt
         where q.ref = p_ref
           and q.state  in(0, 2)
           and q.ref = o.ref
           and a.kf     = sys_context('bars_context','mfo')
           and v.kv = a.kv and o.kv = a.kv
           and o.nlsa = a.nls
           and o.sos >= 0
           and o.tt = wt.tt(+);
     else
        select a.acc, a.nls,  a.kv, t.dk, o.tt, decode(o.kv, o.kv2, o.s, decode(o.dk, 0, o.s, o.s2)), o.sos, o.currvisagrp, o.nextvisagrp, nvl2(trim(wt.tt),1,0), decode(o.mfoa, o.mfob, 1, 0), o.s2
          into l_acc, l_nlsb, l_kv, l_dk, l_tt, l_s, l_sos, l_currvisagrp, l_nextvisagrp, l_tt_w4_flag, l_isourmfo, l_s2
          from mway_match q, oper o, accounts a, ow_match_tt t, tabval$global v, w4_sto_tts wt
         where q.ref_tr = p_ref
           and q.state  = 0
           and q.ref_tr = o.ref
           and o.tt     = t.tt and t.dk = p_dk
           and a.kf     = sys_context('bars_context','mfo')
           and q.nls_tr in(a.nls, a.nlsalt) -- COBUMMFO-7501
           and q.lcv_tr = v.lcv and v.kv = a.kv
           and o.sos > 0
           and o.tt = wt.tt(+);
     end if;

     -- доплата с транзита
     if l_sos = 5 then

        -- защита от дурака:
        -- если документ завизирован технической визой Контролер БПК, ничего не платим
        if l_currvisagrp = g_chkid_hex then

           b_kvt := true;

        else

           -- для операций, инициированных банком, берем общий транзитный счет
           if p_mode = 0 then
              l_nlsa := get_transit(l_acc, 0);

           -- для платежей на свободные реквизиты берем 2924/27
           elsif p_mode = 2 then
             l_nlsa := GetGlobalOption('NLS_292427_LOCPAY');

           -- для операций, инициированных 3-й стороной (ВЕБ-Банкинг), берем 2924(16)-для ЦА/2924(14)-для РУ
           else
              if f_ourmfo = '300465' then
                 l_nlsa := GetGlobalOption('NLS_292416_INTG');
              else
                 l_nlsa := nbs_ob22_null('2924', '14');
              end if;
           end if;

           if l_nlsa is not null and l_nlsb is not null then
            -- Не квитуем операцию при переводах на свободные реквизиты в рамках одного РУ.
             -- if l_locpay_flag = 0 then
              gl.payv(0, p_ref, l_bdate, l_tt, l_dk,
                 l_kv, l_nlsa, l_s,
                 l_kv, l_nlsb, l_s);

              gl.pay(2, p_ref, l_bdate);
 if p_mode = 2 then
              update oper t
                 set t.sos = 5
              where t.ref = p_ref and t.sos <> 5;
              delete from ref_que where ref = p_ref;
  end if;
                 -- По платежам на СЕП не ставим 30 визу.
                 if l_tt not in ('OW6', 'WO6') then
              -- виза 30 Контролер БПК
                    insert into oper_visa
                      (ref, dat, userid, groupid, status)
                      select p_ref, sysdate, user_id, g_chkid, 2
                        from dual
                       where not exists
                       (select 1
                                from oper_visa
                               where ref = p_ref and groupid = g_chkid);
              end if;
             -- end if;
              b_kvt := true;

           end if;

        end if;

     elsif l_sos > 0 and l_nextvisagrp = g_chkid_hex then

        -- виза g_chkid - последняя?
        begin
           select substr(CHK.GetNextVisaGroup(p_ref,l_nextvisagrp),1,2)
             into l_nxt
             from dual;
        exception when no_data_found then
           bars_error.raise_nerror(g_modcode, '...');
        end;

        -- виза g_chkid - последняя:
        --   документ оплачиваем
        if l_nxt = '!!' then
           if l_tt_w4_flag = 1 and l_isourmfo = 0 then
              put_ack(p_ref, g_chkid);
           else
              gl.pay(2, p_ref, l_bdate);
           end if;
        -- виза g_chkid - не последняя, будет еще g_chkid2:
        --   визируем проводку на списание
        else

           begin
              select stmt into l_stmt
                from opldok
               where ref = p_ref
                 and tt  = l_tt
                 and acc = l_acc
                 and dk  = l_dk;
           exception when no_data_found then
              bars_error.raise_nerror(g_modcode, '...');
           end;

           l_fdat := null;

           -- запоминаем дату валютирования проводки на пополнение
           select min(fdat) into l_fdat from opldok where ref = p_ref and stmt <> l_stmt and sos < 4;

           -- меняем дату валютирования проводки на пополнение на будущую (чтоб она сейчас не платилась)
           if l_fdat is not null then
              update opldok set fdat = bankdate + 1 where ref = p_ref and stmt <> l_stmt;
           end if;

           -- оплата (виза) документа - оплатится только проводка на списание
           gl.pay(2, p_ref, l_bdate);

           -- меняем дату валютирования проводки назад
           if l_fdat is not null then
              update opldok set fdat = l_fdat where ref = p_ref and stmt <> l_stmt and sos < 4;
           end if;

        end if;

        -- виза 30 Контролер БПК
        chk.put_visa (
            ref_    => p_ref,
            tt_     => l_tt,
            grp_    => g_chkid,
            status_ => 2,
            keyid_  => null,
            sign1_  => null,
            sign2_  => null );

        b_kvt := true;

     elsif l_sos > 0 and l_nextvisagrp = g_chkid2_hex then

        gl.pay(2, p_ref, l_bdate);

        -- виза 31 Контролер БПК-2
        chk.put_visa (
            ref_    => p_ref,
            tt_     => l_tt,
            grp_    => g_chkid2,
            status_ => 2,
            keyid_  => null,
            sign1_  => null,
            sign2_  => null );

        b_kvt := true;

     end if;

  exception when no_data_found then null;
  end;

  bars_audit.info(h || 'Finish.');

end final_payment;

-------------------------------------------------------------------------------
procedure set_cck_sob (
  p_ref           number,
  p_dk            number,
  p_acc           number,
  p_transfer_flag number,
  p_sucs_flag     boolean )
is
  l_nd_kd nd_acc.nd%type;
  l_nlsb  oper.nlsb%type;
  l_txt   cc_sob.txt%type;
  l_kv2   oper.kv2%type;
  l_accounts_row accounts%rowtype;

begin

  select max(n.nd) into l_nd_kd
    from nd_acc n, cc_deal d
   where n.acc = p_acc
     and n.nd = d.nd
     and d.sos >= 10 and d.sos < 15;

  if l_nd_kd is not null then

     select decode(dk,p_dk,nlsa,nlsb), decode(dk,p_dk,kv,kv2) into l_nlsb, l_kv2 from oper where ref = p_ref;
     if newnbs.g_state = 1 then
        l_accounts_row := account_utl.read_account(l_nlsb, l_kv2);

        l_txt := case when l_nlsb like '2__9%' and l_accounts_row.tip = 'SPN' then 'Погашення проср. %%'
                      when l_nlsb like '3578%' and l_accounts_row.tip = 'SK9' then 'Погашення проср. комісії'
                      when l_nlsb like '2__7%' and l_accounts_row.tip = 'SP ' then 'Погашення проср. тіла КД'
                      when l_nlsb like '2__8%' then 'Погашення %%'
                      when l_nlsb like '3578%' then 'Погашення комісії'
                      when l_nlsb like '6___%' then 'Погашення пені'
                      else 'Погашення тіла КД'
                 end;
     else
        l_txt := case when l_nlsb like '2__9%' then 'Погашення проср. %%'
                      when l_nlsb like '3579%' then 'Погашення проср. комісії'
                      when l_nlsb like '2__7%' then 'Погашення проср. тіла КД'
                      when l_nlsb like '2__8%' then 'Погашення %%'
                      when l_nlsb like '3578%' then 'Погашення комісії'
                      when l_nlsb like '6___%' then 'Погашення пені'
                      else 'Погашення тіла КД'
                  end;
     end if;
     l_txt := l_txt || ': Реф.' || p_ref || ' ' ||
              case when p_transfer_flag = 1 then 'відправлено до ПЦ'
                   when p_transfer_flag = 2 then 'сквитовано'
                   else ''
              end;

     l_txt := l_txt || ' ' ||
              case when p_sucs_flag = true then 'успішно'
                   else 'неуспішно'
              end;

     insert into cc_sob (nd, fdat, id, isp, txt, otm, freq, psys)
     values (l_nd_kd, trunc(sysdate), null, user_id, l_txt, null, null, null);

  end if;

end set_cck_sob;

-------------------------------------------------------------------------------
-- iparse_oic_atransfers_file
-- процедура разбора файла OIC_ATransfers*.xml
--
procedure iparse_oic_atransfers_file (
  p_fileid    in number,
  p_filebody  in clob )
is

  l_parser       dbms_xmlparser.parser;
  l_doc          dbms_xmldom.domdocument;
  l_filetrailer  dbms_xmldom.DOMNodeList;
  l_trailer      dbms_xmldom.DOMNode;
  l_analyticlist dbms_xmldom.DOMNodeList;
  l_analytic     dbms_xmldom.DOMNode;
  l_rec          t_atrn := t_atrn();

  l_filetype     ow_files.file_type%type;
  l_file_n       number(6);
  l_file_summ    number(20,2);
  l_idn          number;
  l_check_n      number;
  l_check_summ   number(20,2) := 0;
  l_status       number;
  l_err          varchar2(254);

  l_str varchar2(2000);

  h varchar2(100) := 'bars_ow.iparse_oic_atransfers_file. ';

  -- процедура пакетной вставки коллекции
  procedure bulk_insert(l_rec in t_atrn) is
  begin
    forall j in l_rec.first .. l_rec.last
      insert into ow_oic_atransfers_data values l_rec(j);
  end;

begin

  bars_audit.info(h || 'Start.');

  -- тип файла (ATransfers/FTransfers)
  begin
     select file_type into l_filetype from ow_files where id = p_fileid;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, p_filebody);
  bars_audit.info(h||'clob loaded');

  l_doc := dbms_xmlparser.getdocument(l_parser);
  bars_audit.info(h||'getdocument done');

  l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'FileTrailer');
  l_trailer := dbms_xmldom.item(l_filetrailer, 0);

  dbms_xslprocessor.valueof(l_trailer, 'CheckSum/RecsCount/text()', l_str);
  l_file_n := convert_to_number(l_str);

  dbms_xslprocessor.valueof(l_trailer, 'CheckSum/HashTotalAmount/text()', l_str);
  l_file_summ := convert_to_number(l_str);

  l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'Analytic');
  bars_audit.info(h||'getelementsbytagname done');

  for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1
  loop

     -- счетчик транзакций
     l_idn := i + 1;

     l_analytic := dbms_xmldom.item(l_analyticlist, i);

     l_rec.extend;

     l_rec(l_rec.last).id  := p_fileid;
     l_rec(l_rec.last).idn := l_idn;

     dbms_xslprocessor.valueof(l_analytic, 'SynthRefN/text()', l_str);
     l_rec(l_rec.last).anl_synthrefn := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'SynthCode/text()', l_str);
     l_rec(l_rec.last).anl_synthcode := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'TransferDescription/text()', l_str);
     l_rec(l_rec.last).anl_trndescr := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

     dbms_xslprocessor.valueof(l_analytic, 'AnalyticRefN/text()', l_str);
     l_rec(l_rec.last).anl_analyticrefn := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Credit/AnalyticAccount/AccountNumber/text()', l_str);
     l_rec(l_rec.last).credit_anlaccount := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Credit/SyntAccount/AccountNumber/text()', l_str);
     l_rec(l_rec.last).credit_syntaccount := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Credit/Amount/text()', l_str);
     l_rec(l_rec.last).credit_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Credit/Currency/text()', l_str);
     l_rec(l_rec.last).credit_currency := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Debit/AnalyticAccount/AccountNumber/text()', l_str);
     l_rec(l_rec.last).debit_anlaccount := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Debit/SyntAccount/AccountNumber/text()', l_str);
     l_rec(l_rec.last).debit_syntaccount := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Debit/Amount/text()', l_str);
     l_rec(l_rec.last).debit_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'Debit/Currency/text()', l_str);
     l_rec(l_rec.last).debit_currency := trim(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'PostingDate/text()', l_str);
     l_rec(l_rec.last).anl_postingdate := to_date(l_str,'yyyy-mm-dd');

     dbms_xslprocessor.valueof(l_analytic, 'DocInfo/LocalDt/text()', l_str);
     l_rec(l_rec.last).doc_localdate := to_date(l_str,'yyyy-mm-dd');

     dbms_xslprocessor.valueof(l_analytic, 'DocInfo/Description/text()', l_str);
     l_rec(l_rec.last).doc_descr := substr(trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8')),1,160);

     dbms_xslprocessor.valueof(l_analytic, 'DocInfo/AmountData/Amount/text()', l_str);
     l_rec(l_rec.last).doc_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_analytic, 'DocInfo/AmountData/Currency/text()', l_str);
     l_rec(l_rec.last).doc_currency := trim(l_str);

     if l_filetype = g_filetype_atrn then

        dbms_xslprocessor.valueof(l_analytic, 'DocInfo/DocRefSet/Parm[ParmCode="DRN"]/Value/text()', l_str);
        l_rec(l_rec.last).doc_drn := convert_to_number(l_str);

        dbms_xslprocessor.valueof(l_analytic, 'Extra/AddData/Parm[ParmCode="OperationRN"]/Value/text()', l_str);
        l_rec(l_rec.last).doc_orn := convert_to_number(l_str);

        dbms_xslprocessor.valueof(l_analytic, 'DocInfo/AmountData/Extra/AddData/Parm[ParmCode="TRANS_INFO"]/Value/text()', l_str);
        l_rec(l_rec.last).trans_info  := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

     else

        dbms_xslprocessor.valueof(l_analytic, 'DocInfo/DocRefSet/Parm[ParmCode="2924*016"]/Value/text()', l_str);
        l_rec(l_rec.last).account_2924_016 := substr(trim(l_str),1,14);

     end if;
     l_rec(l_rec.last).kf := sys_context('bars_context','user_mfo');
     l_check_summ := l_check_summ + l_rec(l_rec.last).debit_amount + l_rec(l_rec.last).credit_amount;

     -- пакетная вставка каждых 10к
     if mod(i, 10000) = 0 then
        bulk_insert(l_rec);
        l_rec.delete;
     end if;

  end loop;

  -- оставшиеся записи
  bulk_insert(l_rec);

  bars_audit.info(h||'load done');

  --free (не забыть делать очистку в случае ошибок)
  l_rec.delete();
  l_rec := null;
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);

  l_check_n := l_idn;

  bars_audit.info(h || to_char(l_idn) || ' rows parsed:' ||
     ' l_check_n=>' || to_char(l_check_n) ||
     ' l_file_n=>' || to_char(l_file_n) ||
     ' l_check_summ=>' || to_char(l_check_summ) ||
     ' l_file_summ=>' || to_char(l_file_summ));

  if l_check_n <> l_file_n or l_check_summ <> l_file_summ then
     l_file_n := 0;
     l_status := 3;
     l_err    := 'Не співпадають контрольні суми';
     delete from ow_oic_atransfers_data where id = p_fileid;
  else
     l_status := 1;
     l_err    := null;
  end if;
  set_file_status(p_fileid, l_file_n, l_status, l_err);

  bars_audit.info(h || 'Finish.');

end iparse_oic_atransfers_file;

-------------------------------------------------------------------------------
-- iparse_oic_stransfers_file
-- процедура разбора файла OIC_STransfers*.xml
--
procedure iparse_oic_stransfers_file (
  p_fileid    in number,
  p_filebody  in clob )
is
  l_filebody    xmltype;

  l_file_n      number(6);
  l_file_summ   number(20,2);
  l_check_n     number;
  l_check_summ  number(20,2);
  l_status      number;
  l_err         varchar2(254);

  l_synth_synthrefn    ow_oic_stransfers_data.synth_synthrefn%type;
  l_synth_synthcode    ow_oic_stransfers_data.synth_synthcode%type;
  l_synth_trndescr     ow_oic_stransfers_data.synth_trndescr%type;
  l_credit_syntaccount ow_oic_stransfers_data.credit_syntaccount%type;
  l_credit_amount      ow_oic_stransfers_data.credit_amount%type;
  l_credit_localamount ow_oic_stransfers_data.credit_localamount%type;
  l_credit_currency    ow_oic_stransfers_data.credit_currency%type;
  l_debit_syntaccount  ow_oic_stransfers_data.debit_syntaccount%type;
  l_debit_amount       ow_oic_stransfers_data.debit_amount%type;
  l_debit_localamount  ow_oic_stransfers_data.debit_localamount%type;
  l_debit_currency     ow_oic_stransfers_data.debit_currency%type;
  l_synth_postingdate  ow_oic_stransfers_data.synth_postingdate%type;

  i number;

  c_file varchar2(48) := '/AccountingTransactionFile/FileTrailer/CheckSum/';
  c_data varchar2(53) := '/AccountingTransactionFile/AccountingTransactionList/';
  c_syntetic varchar2(100);
  l_xml      xmltype;

  h varchar2(100) := 'bars_ow.iparse_oic_stransfers_file. ';

begin

  bars_audit.info(h || 'Start.');

  l_filebody := xmltype(p_filebody);

  l_file_n    := convert_to_number(extract(l_filebody, c_file || 'RecsCount/text()', null));
  l_file_summ := convert_to_number(extract(l_filebody,c_file || 'HashTotalAmount/text()', null));

  l_check_summ := 0;

  i := 0;

  loop

     -- счетчик транзакций
     i := i + 1;

     c_syntetic := c_data || 'Synthetic[' || i || ']';

     -- выход при отсутствии транзакций
     if l_filebody.existsnode(c_syntetic) = 0 then
        exit;
     end if;

     l_xml := xmltype(extract(l_filebody,c_syntetic,null));

     l_synth_synthrefn    :=        extract(l_xml,'/Synthetic/SynthRefN/text()', null);
     l_synth_synthcode    :=        extract(l_xml,'/Synthetic/SynthCode/text()', null);
     l_synth_trndescr     :=        extract(l_xml,'/Synthetic/TransferDescription/text()', null);
     l_credit_syntaccount := substr(extract(l_xml,'/Synthetic/Credit/SyntAccount/AccountNumber/text()', null),1,30);
     l_credit_amount      := convert_to_number(extract(l_xml,'/Synthetic/Credit/Amount/text()', null));
     l_credit_localamount := convert_to_number(extract(l_xml,'/Synthetic/Credit/LocalAmount/text()', null));
     l_credit_currency    :=        extract(l_xml,'/Synthetic/Credit/Currency/text()', null);
     l_debit_syntaccount  := substr(extract(l_xml,'/Synthetic/Debit/SyntAccount/AccountNumber/text()', null),1,30);
     l_debit_amount       := convert_to_number(extract(l_xml,'/Synthetic/Debit/Amount/text()', null));
     l_debit_localamount  := convert_to_number(extract(l_xml,'/Synthetic/Debit/LocalAmount/text()', null));
     l_debit_currency     :=        extract(l_xml,'/Synthetic/Debit/Currency/text()', null);

     l_check_summ := l_check_summ + l_debit_amount + l_credit_amount;

     insert into ow_oic_stransfers_data (id, idn,
        synth_synthrefn,
        synth_synthcode,
        synth_trndescr,
        credit_syntaccount,
        credit_amount,
        credit_localamount,
        credit_currency,
        debit_syntaccount,
        debit_amount,
        debit_localamount,
        debit_currency,
        synth_postingdate)
     values (p_fileid, i,
        l_synth_synthrefn,
        l_synth_synthcode,
        l_synth_trndescr,
        l_credit_syntaccount,
        l_credit_amount,
        l_credit_localamount,
        l_credit_currency,
        l_debit_syntaccount,
        l_debit_amount,
        l_debit_localamount,
        l_debit_currency,
        l_synth_postingdate);

  end loop;

  l_check_n := i - 1;

  bars_audit.info(h || to_char(i) || ' rows parsed:' ||
     ' l_check_n=>' || to_char(l_check_n) ||
     ' l_file_n=>' || to_char(l_file_n) ||
     ' l_check_summ=>' || to_char(l_check_summ) ||
     ' l_file_summ=>' || to_char(l_file_summ));

  if l_check_n <> l_file_n or l_check_summ <> l_file_summ then
     l_file_n := 0;
     l_status := 3;
     l_err    := 'Не співпадають контрольні суми';
     delete from ow_oic_stransfers_data where id = p_fileid;
  else
     l_status := 1;
     l_err    := null;
  end if;
  set_file_status(p_fileid, l_file_n, l_status, l_err);

  bars_audit.info(h || 'Finish.');

end iparse_oic_stransfers_file;

-------------------------------------------------------------------------------
-- iparse_oic_doc
-- процедура разбора файла OIC_Documents*.xml
--
procedure iparse_oic_doc (
  p_fileid    in number,
  p_filebody  in xmltype )
is

  l_filebody    xmltype;

  l_file_n      number(6);
  l_file_summ   number(20,2);
  l_check_n     number;
  l_check_summ  number(20,2);
  l_status      number;
  l_err         varchar2(254);

  l_rec         ow_oic_documents_data%rowtype;

  i number;
  j number;
  l_tmp varchar2(2000);

  c_file varchar2(48) := '/DocFile/FileTrailer/CheckSum/';
  c_data varchar2(53) := '/DocFile/DocList/';
  c_doc  varchar2(254);
  c_parm varchar2(254);
  l_xml  xmltype;
  l_socmnt varchar2(254);
  l_dtls1  varchar2(254);
  l_dtls2  varchar2(254);
  h varchar2(100) := 'bars_ow.iparse_oic_doc. ';

begin

  bars_audit.info(h || 'Start.');

  l_filebody := p_filebody;

  l_file_n    := convert_to_number(extract(l_filebody, c_file || 'RecsCount/text()', null));
  l_file_summ := convert_to_number(extract(l_filebody, c_file || 'HashTotalAmount/text()', null));

  l_check_summ := 0;

  i := 0;

  loop

     -- счетчик транзакций
     i := i + 1;

     c_doc := c_data || 'Doc[' || i || ']';

     -- выход при отсутствии транзакций
     if l_filebody.existsnode(c_doc) = 0 then
       exit;
     end if;

     l_xml := xmltype(extract(l_filebody,c_doc,null));

     l_rec.doc_localdate       := to_date(extract(l_xml, '/Doc/LocalDt/text()', null),'yyyy-mm-dd hh24:mi:ss');
                     l_tmp :=             extract(l_xml, '/Doc/Description/text()', null);
     l_rec.doc_descr           :=  substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254);
     l_rec.cnt_contractnumber  :=  substr(extract(l_xml, '/Doc/ContractFor/ContractNumber/text()', null), 1, 100);
     l_rec.cnt_clientregnumber :=  substr(extract(l_xml, '/Doc/ContractFor/Client/ClientInfo/RegNumber/text()', null), 1, 10);
                     l_tmp :=             extract(l_xml, '/Doc/ContractFor/Client/ClientInfo/CompanyName/text()', null);
     l_rec.cnt_clientname      :=  substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,38);
     l_rec.org_cbsnumber       :=  substr(extract(l_xml, '/Doc/Originator/CBSNumber/text()', null), 1, 100);
     l_rec.dest_institution    :=  substr(extract(l_xml, '/Doc/Destination/InstInfo/Institution/text()', null), 4, 6);
     l_rec.bill_phasedate      := to_date(extract(l_xml, '/Doc/Billing/PhaseDate/text()', null), 'yyyy-mm-dd');
     l_rec.bill_amount         := convert_to_number(extract(l_xml, '/Doc/Billing/Amount/text()', null));
     l_rec.bill_currency       := convert_to_number(extract(l_xml, '/Doc/Billing/Currency/text()', null));

     l_rec.doc_drn := null;

     j := 0;

     loop

        j := j + 1;

        c_parm := '/Doc/DocRefSet/Parm[' || j || ']';

        -- выход при отсутствии транзакций
        if l_xml.existsnode(c_parm) = 0 then
           exit;
        end if;

        l_tmp := substr(extract(l_xml, c_parm || '/ParmCode/text()', null),1,100);
        if l_tmp = 'DRN' then
           l_rec.doc_drn := extract(l_xml, c_parm || '/Value/text()', null);
           exit;
        end if;

     end loop;

     l_rec.doc_socmnt := null;
     l_socmnt := null;
     l_dtls1 := null;
     l_dtls2 := null;
     j := 0;

     loop

        j := j + 1;

        c_parm := '/Doc/ContractFor/AddData/Parm[' || j || ']';

        -- выход при отсутствии транзакций
        if l_xml.existsnode(c_parm) = 0 then
           exit;
        end if;

        l_tmp := extract(l_xml, c_parm || '/ParmCode/text()', null);
        if l_tmp = 'SO_CMNT' then
           l_tmp := extract(l_xml, c_parm || '/Value/text()', null);
           l_socmnt := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254);
        elsif l_tmp = 'SO_DTLS1' then
           l_tmp := extract(l_xml, c_parm || '/Value/text()', null);
           l_dtls1 := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254);
        elsif l_tmp = 'SO_DTLS2' then
           l_tmp := extract(l_xml, c_parm || '/Value/text()', null);
           l_dtls2 := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254);
        end if;

     end loop;

     l_rec.doc_socmnt := substr(nvl(trim(l_dtls1 || ' ' || l_dtls2), l_socmnt), 1, 254);

     l_rec.doc_trdetails := null;

     j := 0;

     loop

        j := j + 1;

        c_parm := '/Doc/Transaction/Extra/AddData/Parm[' || j || ']';

        -- выход при отсутствии транзакций
        if l_xml.existsnode(c_parm) = 0 then
           exit;
        end if;

        l_tmp := extract(l_xml, c_parm || '/ParmCode/text()', null);
        if l_tmp = 'TR_DETAILS' then
           l_tmp := extract(l_xml, c_parm || '/Value/text()', null);
           l_rec.doc_trdetails := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254);
        elsif
           l_tmp = 'TR_PREFIX' then
           l_tmp := extract(l_xml, c_parm || '/Value/text()', null);
           l_rec.doc_socmnt := nvl(substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254),'') ||l_rec.cnt_clientname||'/Відшкодування за дату '|| l_rec.doc_trdetails;
        end if;

     end loop;

     l_rec.id  := p_fileid;
     l_rec.idn := i;
     l_rec.kf := sys_context('bars_context','user_mfo');
     -- вставка в таблицу
     insert into ow_oic_documents_data values l_rec;

     l_check_summ := l_check_summ + l_rec.bill_amount;

  end loop;

  l_check_n := i - 1;

  bars_audit.info(h || to_char(i) || ' rows parsed:' ||
     ' l_check_n=>' || to_char(l_check_n) ||
     ' l_file_n=>' || to_char(l_file_n) ||
     ' l_check_summ=>' || to_char(l_check_summ) ||
     ' l_file_summ=>' || to_char(l_file_summ));

  if l_check_n <> l_file_n or l_check_summ <> l_file_summ then
     l_file_n := 0;
     l_status := 3;
     l_err    := 'Не співпадають контрольні суми';
     delete from ow_oic_documents_data where id = p_fileid;
  else
     l_status := 1;
     l_err    := null;
  end if;
  set_file_status(p_fileid, l_file_n, l_status, l_err);

  bars_audit.info(h || 'Finish.');

end iparse_oic_doc;

-------------------------------------------------------------------------------
-- iparse_oic_docf
-- процедура разбора файла OIC_Documents*FINES*.xml
--
procedure iparse_oic_docf (
  p_fileid    in number,
  p_filebody  in xmltype )
is

  l_filebody  xmltype;
  l_xml_doc   xmltype;
  l_xml_extra xmltype;

  l_file_n     number(6);
  l_check_n    number := 0;
  l_check_summ number(20,2) := 0;
  l_status     number := 1;
  l_err        varchar2(254) := null;
  l_idn        number := 0;

  l_rec        ow_oic_documents_data%rowtype;

  c_file       varchar2(100) := '/DocFile/FileTrailer/CheckSum/';
  c_doclist    varchar2(100) := '/DocFile/DocList/';

  c_batch      varchar2(254);
  c_doc        varchar2(254);
  c_extra      varchar2(254);
  c_parm       varchar2(254);

  y number;
  i number;
  j number;
  g number;
  l_tmp varchar2(2000);

  h varchar2(100) := 'bars_ow.iparse_oic_docf. ';

begin

  bars_audit.info(h || 'Start.');

  l_filebody := p_filebody;

  l_file_n    := convert_to_number(extract(l_filebody, c_file || 'RecsCount/text()', null));
  --l_file_summ := convert_to_number(extract(l_filebody, c_file || 'HashTotalAmount/text()', null));
  l_rec.work_flag := 1;

  l_check_summ := 0;

  y := 0;

  loop

     -- счетчик DocBatch
     y := y + 1;

     c_batch := c_doclist || 'DocBatch[' || y || ']';

     -- выход при отсутствии DocBatch
     if l_filebody.existsnode(c_batch) = 0 then
        exit;
     end if;

     -- Счет получателя (К)
     l_rec.cnt_contractnumber  :=  substr(extract(l_filebody, c_batch || '/BatchHeader/ContractFor/ContractNumber/text()', null), 1, 100);
     -- Ид. код получателя (К)
     l_rec.cnt_clientregnumber :=  substr(extract(l_filebody, c_batch || '/BatchHeader/ContractFor/Client/ClientInfo/RegNumber/text()', null), 1, 10);
     -- Наименование получателя  (К)
                     l_tmp     :=         extract(l_filebody, c_batch || '/BatchHeader/ContractFor/Client/ClientInfo/CompanyName/text()', null);
     l_rec.cnt_clientname      :=  substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,38);
     -- Счет отправителя (Д)
     l_rec.org_cbsnumber       :=  substr(extract(l_filebody, c_batch || '/BatchHeader/Originator/CBSNumber/text()', null), 1, 100);
     -- Код банка (МФО) получателя (К)
     l_rec.dest_institution    :=  substr(extract(l_filebody, c_batch || '/BatchHeader/Destination/InstInfo/Institution/text()', null), 4, 6);

     i := 0;

     loop

        -- счетчик транзакций
        i := i + 1;

        c_doc := c_batch || '/DocList/Doc[' || i || ']';

        -- выход при отсутствии транзакций Doc
        if l_filebody.existsnode(c_doc) = 0 then
           exit;
        end if;

        l_xml_doc := xmltype(extract(l_filebody,c_doc,null));

        l_rec.doc_localdate :=           to_date(extract(l_xml_doc, '/Doc/LocalDt/text()', null),'yyyy-mm-dd hh24:mi:ss');
        l_rec.bill_amount   := convert_to_number(extract(l_xml_doc, '/Doc/Transaction/Amount/text()', null));
        l_rec.bill_currency := convert_to_number(extract(l_xml_doc, '/Doc/Transaction/Currency/text()', null));
        l_rec.msgcodes := extract(l_xml_doc, '/Doc/TransType/TransCode/MsgCode/text()', null);
        l_rec.postingstatus := extract(l_xml_doc, '/Doc/Status/PostingStatus/text()', null);
        l_rec.doc_descr := null;
        l_rec.repost_doc := null;

        j := 0;

        loop

           -- счетчик Extra
           j := j + 1;
           c_extra := '/Doc/Transaction/Extra[' || j || ']';
           -- выход при отсутствии Extra
           if l_xml_doc.existsnode(c_extra) = 0 then
              exit;
           end if;
           l_xml_extra := xmltype(extract(l_xml_doc,c_extra,null));

           l_tmp := extract(l_xml_extra, '/Extra/Type/text()', null);
           if l_tmp = 'AddInfo' then
              g := 0;
              loop
                 -- счетчик Parm
                 g := g + 1;
                 c_parm := '/Extra/AddData/Parm[' || g || ']';
                 -- выход при отсутствии Parm
                 if l_xml_extra.existsnode(c_parm) = 0 then
                    exit;
                 end if;
                 l_tmp := extract(l_xml_extra, c_parm || '/ParmCode/text()', null);
                 if l_tmp = 'REPOST_DOC' then
                    l_tmp := extract(l_xml_extra,  c_parm || '/Value/text()', null);
                    l_rec.repost_doc := substr(trim(dbms_xmlgen.convert(l_tmp,1)), 1, 100);
                 elsif l_tmp = 'FINE_INFO' then
                    l_tmp := extract(l_xml_extra,  c_parm || '/Value/text()', null);
                    l_rec.doc_descr := substr(trim(dbms_xmlgen.convert(l_tmp,1)), 1, 254);
                    exit;
                 end if;
              end loop;
           end if;

        end loop;

        l_idn := l_idn + 1;
        l_rec.id  := p_fileid;
        l_rec.idn := l_idn;
        l_rec.doc_drn       := null;
        l_rec.doc_socmnt    := null;
        l_rec.doc_trdetails := null;
        l_rec.kf := sys_context('bars_context','user_mfo');
        -- вставка в таблицу
        insert into ow_oic_documents_data values l_rec;

        l_check_n    := l_check_n + 1;
        l_check_summ := l_check_summ + l_rec.bill_amount;

     end loop;

  end loop;

  if l_check_n <> l_file_n then
     l_file_n := 0;
     l_status := 3;
     l_err    := 'Не співпадають контрольні суми';
     delete from ow_oic_documents_data where id = p_fileid;
  else
     l_status := 1;
     l_err    := null;
  end if;

  set_file_status(p_fileid, l_file_n, l_status, l_err);

  bars_audit.info(h || 'Finish.');

end iparse_oic_docf;


-------------------------------------------------------------------------------
-- iparse_oic_docl
-- процедура разбора файла OIC_Documents*LOCPAY*.xml
--
procedure iparse_oic_docl (
  p_fileid    in number,
  p_filebody  in xmltype )
is

  l_filebody    xmltype;

  l_file_n      number(6);
  l_file_summ   number(20,2);
  l_check_n     number;
  l_check_summ  number(20,2);
  l_status      number;
  l_err         varchar2(254);

  l_rec         ow_oic_documents_data%rowtype;

  i             number;
  j             number;
  k             number;
  g             number;
  l_tmp         varchar2(2000);

  c_file        varchar2(48) := '/DocFile/FileTrailer/CheckSum/';
  c_data        varchar2(53) := '/DocFile/DocList/';
  c_doc         varchar2(254);
  c_extra       varchar2(254);
  c_parm        varchar2(254);
  l_xml         xmltype;
  l_xml_extra   xmltype;
  l_recamount   number;
  l_extraamount number;
  l_transamount number;
  h varchar2(100) := 'bars_ow.iparse_oic_docl. ';
  l_sign        varchar2(2000);
  l_signf       varchar2(2000);
  l_key         raw(500) := utl_i18n.string_to_raw(crypto_utl.get_key_value(gl.bDATE, g_keytype),  'utf8');
  l_key_p       raw(500);
  l_nwdate      date;
  l_dcntnb      varchar2(100);
begin

  bars_audit.info(h || 'Start.');

  if l_key is null then
     raise_application_error(-20000, 'Не задано ключ по платежам на вільні реквізити.');
  end if;
  l_filebody := p_filebody;

  l_file_n    := convert_to_number(extract(l_filebody, c_file || 'RecsCount/text()', null));
  l_file_summ := convert_to_number(extract(l_filebody, c_file || 'HashTotalAmount/text()', null));

  l_check_summ := 0;

  i := 0;

  l_rec.work_flag := 0;
  l_rec.failures_count := 0;
  loop

     -- счетчик транзакций
     i := i + 1;

     c_doc := c_data || 'Doc[' || i || ']';

     -- выход при отсутствии транзакций
     if l_filebody.existsnode(c_doc) = 0 then
       exit;
     end if;

     l_xml := xmltype(extract(l_filebody,c_doc,null));

     l_rec.doc_localdate       := to_date(extract(l_xml, '/Doc/LocalDt/text()', null),'yyyy-mm-dd hh24:mi:ss');
     l_nwdate                  := to_date(extract(l_xml, '/Doc/NWDt/text()', null),'yyyy-mm-dd hh24:mi:ss');
     l_rec.cnt_contractnumber  :=  substr(extract(l_xml, '/Doc/Destination/ContractNumber/text()', null), 1, 100);
     l_dcntnb                  :=  substr(extract(l_xml, '/Doc/Originator/ContractNumber/text()', null), 1, 100);
     l_rec.cnt_clientregnumber :=  substr(extract(l_xml, '/Doc/Destination/Client/ClientInfo/TaxpayerIdentifier/text()', null), 1, 10);
                     l_tmp :=             extract(l_xml, '/Doc/Destination/Client/ClientInfo/ShortName/text()', null);
     l_rec.cnt_clientname      :=  substr(trim(convert(dbms_xmlgen.convert(l_tmp,1), 'CL8MSWIN1251', 'UTF8')), 1, 38);
                     l_tmp :=             extract(l_xml, '/Doc/Destination/Client/ClientInfo/RegNumber/text()', null);
     -- Серию и номер паспорта для СЄП Запишем в tr_details
     l_rec.doc_trdetails       := substr(trim(convert(dbms_xmlgen.convert(l_tmp,1), 'CL8MSWIN1251', 'UTF8')), 1, 38);
     l_rec.org_cbsnumber       :=  substr(extract(l_xml, '/Doc/Originator/RBSNumber/text()', null), 1, 100);
     l_rec.dest_institution    :=  substr(extract(l_xml, '/Doc/Destination/InstInfo/Institution/text()', null), 1, 6);
     l_rec.bill_phasedate      := to_date(extract(l_xml, '/Doc/Billing/PhaseDate/text()', null), 'yyyy-mm-dd');
     l_rec.bill_amount         := convert_to_number(extract(l_xml, '/Doc/Billing/Amount/text()', null));
     l_rec.bill_currency       := convert_to_number(extract(l_xml, '/Doc/Billing/Currency/text()', null));
     l_recamount               := convert_to_number(extract(l_xml, '/Doc/Reconciliation/Amount/text()', '0'));
     l_transamount             := convert_to_number(extract(l_xml, '/Doc/Transaction/Amount/text()', '0'));

     l_rec.doc_drn := null;
     l_rec.doc_rrn := null;
     j := 0;
     loop

        j := j + 1;

        c_parm := '/Doc/DocRefSet/Parm[' || j || ']';

        -- выход при отсутствии транзакций
        if l_xml.existsnode(c_parm) = 0 then
           exit;
        end if;

        l_tmp := substr(extract(l_xml, c_parm || '/ParmCode/text()', null),1,100);
        if l_tmp = 'DRN' then
           l_rec.doc_drn := extract(l_xml, c_parm || '/Value/text()', null);
        elsif l_tmp = 'RRN' then
           l_rec.doc_rrn := extract(l_xml, c_parm || '/Value/text()', null);
        end if;

     end loop;

     k := 0;
     l_extraamount := 0;
     loop

        -- счетчик Extra
        k := k + 1;
        c_extra := '/Doc/Transaction/Extra[' || k || ']';
        -- выход при отсутствии Extra
        if l_xml.existsnode(c_extra) = 0 then
           exit;
        end if;
        l_xml_extra := xmltype(extract(l_xml,c_extra,null));
        l_extraamount := l_extraamount +  abs(convert_to_number(extract(l_xml_extra, '/Extra/Amount/text()', '0')));

        l_tmp := extract(l_xml_extra, '/Extra/Type/text()', null);

        if l_tmp = 'AddInfo' then
           g := 0;
           l_rec.doc_socmnt := null;
           l_signf := null;
           loop
              -- счетчик Parm
              g := g + 1;
              c_parm := '/Extra/AddData/Parm[' || g || ']';
              -- выход при отсутствии Parm
              if l_xml_extra.existsnode(c_parm) = 0 then
                 exit;
              end if;
              l_tmp := extract(l_xml_extra, c_parm || '/ParmCode/text()', null);
              if l_tmp = 'DTL' then
                 l_tmp := extract(l_xml_extra,  c_parm || '/Value/text()', null);
                 l_rec.doc_socmnt := replace(replace(substr(convert(trim(dbms_xmlgen.convert(l_tmp,1)), 'CL8MSWIN1251', 'UTF8'), 1, 254),'%SEMICOLON%', ';'), '%EQUALS%', '=');
              elsif l_tmp = 'CNTRL_INF' then
                 l_signf := extract(l_xml_extra, c_parm || '/Value/text()', null);
              end if;
           end loop;
        end if;

     end loop;
     if trim(l_rec.doc_socmnt) is null or length(l_rec.doc_socmnt) < 2 then
        l_tmp := extract(l_xml, '/Doc/SourceDtls/MerchantName/text()', null);
        l_rec.doc_socmnt :=replace(replace(convert(substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254), 'CL8MSWIN1251', 'UTF8'),'%SEMICOLON%', ';'), '%EQUALS%', '=');
     end if;
     l_rec.doc_data := l_xml.getClobVal();
     l_rec.id  := p_fileid;
     l_rec.idn := i;
     l_sign := 'RRN'||to_char(l_rec.doc_rrn)||to_char(l_rec.doc_localdate,'yyyymmddhh24miss')||to_char(l_nwdate,'yyyymmddhh24miss')||
               l_dcntnb||l_rec.cnt_contractnumber||l_rec.dest_institution||to_char(l_rec.bill_currency)||to_char(l_rec.bill_amount);
     if dbms_crypto.Mac(src => utl_i18n.string_to_raw(l_sign,  'utf8'), typ =>dbms_crypto.hmac_sh1 , key => l_key) =  l_signf then
        l_rec.is_sign_ok := 'Y';
     else
        if l_rec.bill_phasedate < gl.bDATE then
           l_key_p := utl_i18n.string_to_raw(crypto_utl.get_key_value(l_rec.bill_phasedate, g_keytype, true),  'utf8');
           if l_key_p is not null then
              if dbms_crypto.Mac(src => utl_i18n.string_to_raw(l_sign,  'utf8'), typ => dbms_crypto.hmac_sh1 , key => l_key_p) =  l_signf then
              l_rec.is_sign_ok := 'Y';
           else
              l_rec.is_sign_ok := 'N';
           end if;
        else
           l_rec.is_sign_ok := 'N';
        end if;
        else
           l_rec.is_sign_ok := 'N';
        end if;
     end if;

     l_rec.kf := sys_context('bars_context','user_mfo');
     -- вставка в таблицу
     insert into ow_oic_documents_data values l_rec;

     l_check_summ := l_check_summ + abs(l_rec.bill_amount) + abs(l_recamount) + abs(l_transamount) + l_extraamount;

  end loop;

  l_check_n := i - 1;

  bars_audit.info(h || to_char(i) || ' rows parsed:' ||
     ' l_check_n=>' || to_char(l_check_n) ||
     ' l_file_n=>' || to_char(l_file_n) ||
     ' l_check_summ=>' || to_char(l_check_summ) ||
     ' l_file_summ=>' || to_char(l_file_summ));

  if l_check_n <> l_file_n or l_check_summ <> l_file_summ then
     l_file_n := 0;
     l_status := 3;
     l_err    := 'Не співпадають контрольні суми';
     delete from ow_oic_documents_data where id = p_fileid;
  else
     l_status := 1;
     l_err    := null;
  end if;
  set_file_status(p_fileid, l_file_n, l_status, l_err);

  bars_audit.info(h || 'Finish.');
end;
-- iparse_oic_docr
-- процедура разбора файла OIC_Documents*FreeReqisites*.xml
--
procedure iparse_oic_docr (p_fileid   number,  p_filebody  clob)
is

  l_parser         dbms_xmlparser.parser;
  l_doc            dbms_xmldom.domdocument;
  l_batchlist      dbms_xmldom.DOMNodeList;
  l_batch          dbms_xmldom.DOMNode;
  l_doclist        dbms_xmldom.DOMNodeList;
  l_doc_item       dbms_xmldom.DOMNode;
  l_element        dbms_xmldom.DOMElement;
  l_documents      dbms_xmldom.DOMNodeList;
  l_document       dbms_xmldom.DOMNode;
  l_trans          dbms_xmldom.DOMNodeList;
  l_element_doc    dbms_xmldom.DOMElement;
  l_extra          dbms_xmldom.DOMNode;
  l_tran           dbms_xmldom.DOMNode;
  l_translist      dbms_xmldom.DOMNodeList;
  l_element_extra  dbms_xmldom.DOMElement;
  l_extraslist     dbms_xmldom.DOMNodeList;
  l_add_data       dbms_xmldom.DOMNode;
  l_parms          dbms_xmldom.DOMNodeList;
  l_parm           dbms_xmldom.DOMNode;
  l_docrefsetlist  dbms_xmldom.DOMNodeList;
  l_docrefset      dbms_xmldom.DOMNode;
  l_parm_refs      dbms_xmldom.DOMNodeList;
  l_parm_ref       dbms_xmldom.DOMNode;

  h varchar2(100) := 'bars_ow.iparse_oic_docr. '; --FreeReqisites
  q number :=0 ;
  l_nwdt date;
  l_dcntnb varchar2(100);
  l_rec            ow_oic_documents_data%rowtype;
  l_rec_commision  ow_oic_documents_data%rowtype;

  l_signf  varchar2(2000);
  l_signf1  varchar2(2000);
  l_sign   varchar2(2000);
  l_str    varchar2(4000);
  l_str_if varchar2(4000);
  l_key    raw(500) := utl_i18n.string_to_raw(crypto_utl.get_key_value(gl.bDATE, g_keytype));
  l_key_p  raw(500);

  l_fee_doc number;
  l_doc_pay number;

  l_total_doc_amount number;




begin

 bars_audit.info(h || 'Start.');

  if l_key is null then
     raise_application_error(-20000, 'Не задано ключ по платежам на вільні реквізити.');
  end if;

          l_rec.work_flag:=2;
          l_rec.id  := p_fileid;
          l_rec.kf := sys_context('bars_context','user_mfo');
          l_rec_commision.work_flag:=2;
          l_rec_commision.id  := p_fileid;
          l_rec_commision.kf := sys_context('bars_context','user_mfo');



  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, p_filebody);

  l_doc := dbms_xmlparser.getdocument(l_parser);

  l_batchlist := dbms_xmldom.getelementsbytagname(l_doc, 'DocBatch');

 for i in 0 .. dbms_xmldom.getlength(l_batchlist) - 1
 loop


  l_batch      := dbms_xmldom.item(l_batchlist, i);
  dbms_xslprocessor.valueof(l_batch, 'BatchHeader/Destination/InstInfo/Institution/text()', l_str);
  l_rec_commision.dest_institution       := substr(l_str,4,6);
  dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/ContractNumber/text()', l_str);
  l_rec_commision.cnt_contractnumber     := substr(l_str,1,100);
  dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/Client/ClientInfo/RegNumber/text()', l_str);
  l_rec_commision.cnt_clientregnumber     := substr(l_str,1,10);
  dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/Client/ClientInfo/CompanyName/text()', l_str);
  l_rec_commision.cnt_clientname     := substr(trim(dbms_xmlgen.convert(l_str,1)),1,38);
  dbms_xslprocessor.valueof(l_batch, 'BatchHeader/Originator/CBSNumber/text()', l_str);
  l_rec.org_cbsnumber               := substr(l_str,1,100);
  l_rec_commision.org_cbsnumber     := substr(l_str,1,100);


  l_element := dbms_xmldom.makeElement(l_batch);
  l_documents:=dbms_xmldom.getchildrenbytagname(l_element,'DocList');
  l_document:= dbms_xmldom.item(l_documents, 0);
  l_doclist:=dbms_xmldom.getChildNodes(l_document);

     if dbms_xmldom.getlength(l_doclist) = 0 then
       exit ;
     end if;

     for n in 0 .. dbms_xmldom.getlength(l_doclist) - 1
     loop
         l_fee_doc:=0;
         l_doc_pay:=0;

         l_rec.idn := q+1;
         q:=q+1;
         l_rec_commision.idn := q+1;
         q:=q+1;

         l_doc_item:= dbms_xmldom.item(l_doclist, n);
         dbms_xslprocessor.valueof(l_doc_item, 'LocalDt/text()',l_str);
          l_rec.doc_localdate       := to_date(l_str,'yyyy-mm-dd hh24:mi:ss');
          l_rec_commision.doc_localdate        := to_date(l_str,'yyyy-mm-dd hh24:mi:ss');
         dbms_xslprocessor.valueof(l_doc_item, 'Status/PostingStatus/text()', l_str);
          l_rec.postingstatus:=l_str;
          l_rec_commision.postingstatus:=l_str;
         dbms_xslprocessor.valueof(l_doc_item, 'Billing/PhaseDate/text()', l_str);
          l_rec.bill_phasedate:=to_date(l_str,'yyyy-mm-dd');
          l_rec_commision.bill_phasedate:=to_date(l_str,'yyyy-mm-dd');
         dbms_xslprocessor.valueof(l_doc_item, 'NWDt/text()', l_str);
          l_nwdt := to_date(l_str,'yyyy-mm-dd hh24:mi:ss');
         dbms_xslprocessor.valueof(l_doc_item, 'Originator/ContractNumber/text()', l_str);
          l_dcntnb:=substr(l_str,1,100);
         dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Currency/text()', l_str);
          l_rec.bill_currency     := convert_to_number(l_str);
          l_rec_commision.bill_currency     := convert_to_number(l_str);
          dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Amount/text()', l_str);
          l_total_doc_amount:=convert_to_number(l_str);
          l_str:=null;

          l_element_doc := dbms_xmldom.makeElement(l_doc_item);


          l_docrefsetlist:=dbms_xmldom.getchildrenbytagname(l_element_doc,'DocRefSet');
          l_docrefset:= dbms_xmldom.item(l_docrefsetlist, 0);
          l_parm_refs:=dbms_xmldom.getChildNodes(l_docrefset);

                  for o in 0 .. dbms_xmldom.getlength(l_parm_refs) - 1
                  loop
                    l_parm_ref:=dbms_xmldom.item(l_parm_refs, o);
                    dbms_xslprocessor.valueof(l_parm_ref, 'ParmCode/text()', l_str_if);
                    if l_str_if='RRN'
                    then
                        dbms_xslprocessor.valueof(l_parm_ref, 'Value/text()', l_str);
                        l_rec.doc_rrn:=l_str;
                        l_rec_commision.doc_rrn:=l_str;

                    end if;
                  end loop;

          l_str:=null;

          l_translist:=dbms_xmldom.getchildrenbytagname(l_element_doc,'Transaction');
          l_tran:= dbms_xmldom.item(l_translist, 0);
          l_trans:=dbms_xmldom.getChildNodes(l_tran);


                 for m in 0 .. dbms_xmldom.getlength(l_trans) - 1
                 loop
                     l_extra:=dbms_xmldom.item(l_trans, m);
                     if dbms_xmldom.getNodeName(l_extra)='Extra'
                         then
                            dbms_xslprocessor.valueof(l_extra, 'Type/text()', l_str);
                             if  l_str='AddInfo' then

                                l_element_extra := dbms_xmldom.makeElement(l_extra);
                                l_extraslist:=dbms_xmldom.getchildrenbytagname(l_element_extra,'AddData');
                                l_add_data:= dbms_xmldom.item(l_extraslist, 0);
                                l_parms:=dbms_xmldom.getChildNodes(l_add_data);

                                for b in 0 .. dbms_xmldom.getlength(l_parms) - 1
                                loop
                                   l_parm:=dbms_xmldom.item(l_parms, b);
                                   dbms_xslprocessor.valueof(l_parm, 'ParmCode/text()', l_str_if);
                                  l_str:=null;
                                   if     l_str_if='OB_FEE'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec_commision.bill_amount:=convert_to_number(l_str);
                                   if  nvl(l_rec_commision.bill_amount,0)=0
                                           then
                                           l_fee_doc:=0;
                                           else
                                           l_fee_doc:=1;
                                           end if;
                                   elsif  l_str_if='OB_CNTRL_INF'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_signf:=l_str;
                                   l_doc_pay:=l_doc_pay+1;
                                   elsif  l_str_if='OB_TRANS_AMNT'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec.bill_amount:=convert_to_number(l_str);
                                   l_doc_pay:=l_doc_pay+1;
                                   elsif  l_str_if='OB_RCPT_MFO'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec.dest_institution:= l_str;
                                   l_doc_pay:=l_doc_pay+1;
                                   elsif  l_str_if='OB_RCPT_ACNT'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec.cnt_contractnumber:= substr(l_str,1,100);
                                   l_doc_pay:=l_doc_pay+1;
                                   elsif  l_str_if='OB_RCPT_EGRPOU'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec.cnt_clientregnumber:= substr(l_str,1,10);
                                   l_doc_pay:=l_doc_pay+1;
                                   elsif  l_str_if='OB_RCPT_NAME'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec.cnt_clientname:= substr(trim(dbms_xmlgen.convert(l_str,1)),1,38);
                                   l_doc_pay:=l_doc_pay+1;
                                   elsif  l_str_if='OB_PMNT_DTLS'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec.doc_socmnt:= substr(trim(dbms_xmlgen.convert(l_str,1)), 1, 254);
                                   l_rec_commision.doc_socmnt:= substr(trim(dbms_xmlgen.convert(l_str,1)), 1, 254);
                                   l_doc_pay:=l_doc_pay+1;
                                   elsif  l_str_if='OB_REGNUMBER'
                                   then dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                                   l_rec.doc_trdetails:=substr(trim(dbms_xmlgen.convert(l_str,1)), 1, 38);
                                   l_rec_commision.doc_trdetails:=substr(trim(dbms_xmlgen.convert(l_str,1)), 1, 38);
                                   l_doc_pay:=l_doc_pay+1;
                                   end if;

                                end loop;
                             end if;
                     end if;
                 end loop;

            l_sign := 'RRN'||trim(to_char(l_rec.doc_rrn))||to_char(l_rec.doc_localdate,'yyyymmddhh24miss')||to_char(l_nwdt,'yyyymmddhh24miss')||
                       trim(l_dcntnb)||trim(l_rec.cnt_contractnumber)||trim(l_rec.dest_institution)||trim(to_char(l_rec.bill_currency))||trim(to_char(l_rec.bill_amount,9999999999990.99));
            l_signf1 := dbms_crypto.Mac(src => utl_i18n.string_to_raw(l_sign), typ =>dbms_crypto.hmac_sh1 , key => l_key);
      --      bars_audit.info(h || to_char(i) || ' crypto_Mac:' || ' l_sign=>' || to_char(l_sign) || ' l_signf  from file=>' || to_char(l_signf) || ' l_signf  calc=>' || to_char(l_signf1));
             if l_signf1 =  l_signf then
                l_rec.is_sign_ok := 'Y';
                l_rec_commision.is_sign_ok := 'Y';

             else
                if l_rec.bill_phasedate < gl.bDATE then
                   l_key_p := utl_i18n.string_to_raw(crypto_utl.get_key_value(l_rec.bill_phasedate, g_keytype, true));
                   if l_key_p is not null then
                      if dbms_crypto.Mac(src => utl_i18n.string_to_raw(l_sign), typ => dbms_crypto.hmac_sh1 , key => l_key_p) =  l_signf then
                      l_rec.is_sign_ok := 'Y';
                      l_rec_commision.is_sign_ok := 'Y';

                   else
                      l_rec.is_sign_ok := 'N';
                      l_rec_commision.is_sign_ok := 'N';

                   end if;
                else
                   l_rec.is_sign_ok := 'N';
                   l_rec_commision.is_sign_ok := 'N';
                end if;
                else
                   l_rec.is_sign_ok := 'N';
                   l_rec_commision.is_sign_ok := 'N';
                end if;
             end if;

         if l_fee_doc=0
         then
         l_rec_commision.bill_amount:=0;
         end if;

         if l_total_doc_amount<>l_rec_commision.bill_amount+l_rec.bill_amount
         then
         l_rec_commision.doc_descr:='Невідповідність загальної суми платежу';
         l_rec.doc_descr:='Невідповідність загальної суми платежу';
         else
         l_rec_commision.doc_descr:=null;
         l_rec.doc_descr:=null;
         end if;

         if l_doc_pay=8 and l_rec.postingstatus='Posted'
         then
         insert into ow_oic_documents_data values l_rec;
                 if l_fee_doc=1 and l_rec_commision.postingstatus='Posted'
                 then
                 insert into ow_oic_documents_data values l_rec_commision;
                 else q:=q-1;
                 end if;
         else q:=q-2;
         end if;



     end loop;
 end loop;

  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);

 set_file_status(p_fileid, q, 1, null);

     bars_audit.info(h || 'Finish.');

end;



-------------------------------------------------------------------------------
-- iparse_oic_documents_file
-- процедура разбора файла OIC_Documents*.xml
--
procedure iparse_oic_documents_file (
  p_fileid    in number,
  p_filebody  in clob )
is

  l_filebody    xmltype;
  l_file_receiver varchar2(254);

begin

  l_filebody := xmltype(p_filebody);

  l_file_receiver := substr(extract(l_filebody, '/DocFile/FileHeader/' || 'Receiver/text()', null), 1, 100);
  if l_file_receiver = 'FINES' then
     iparse_oic_docf(p_fileid, l_filebody);
  elsif l_file_receiver = 'LOCPAY' then
     iparse_oic_docl(p_fileid, l_filebody);
  elsif l_file_receiver = 'FreeReqisites' then
     iparse_oic_docr(p_fileid, p_filebody);

  else
     iparse_oic_doc(p_fileid, l_filebody);
  end if;

end iparse_oic_documents_file;

-------------------------------------------------------------------------------
-- iparse_cng_file
-- процедура разбора файла CNGEXPORT*.xml
--
procedure iparse_cng_file (
  p_fileid    in number,
  p_filebody  in clob )
is

  l_parser         dbms_xmlparser.parser;
  l_doc            dbms_xmldom.domdocument;
  l_fileheader     dbms_xmldom.DOMNodeList;
  l_header         dbms_xmldom.DOMNode;
  l_contractlist   dbms_xmldom.DOMNodeList;
  l_contract       dbms_xmldom.DOMNode;
  l_rec            t_cng := t_cng();
  l_pardate        date := null;
  l_filedate       date := null;
  l_acc            number;
  l_nls            accounts.nls%type;
  l_lcv            varchar2(3);

  l_id  number;
  l_idn number := 0;
  l_str varchar2(2000);

  h varchar2(100) := 'bars_ow.iparse_cng_file. ';

  -- процедура пакетной вставки коллекции
  procedure bulk_insert(l_rec in t_cng) is
  begin
    forall j in l_rec.first .. l_rec.last
      insert into ow_cng_data values l_rec(j);
  end;

begin

  bars_audit.info(h || 'Start.');

  l_id := p_fileid;

--  delete from ow_cng_data;
  -- дата предыдущего баланса
  select nvl(min(to_date(val,'dd.mm.yyyy')), sysdate-7) into l_pardate from ow_params where par = 'CNGDATE';

  l_parser := dbms_xmlparser.newparser;
  dbms_xmlparser.parseclob(l_parser, p_filebody);
  bars_audit.info(h||'clob loaded');

  l_doc := dbms_xmlparser.getdocument(l_parser);
  bars_audit.info(h||'getdocument done');

  -- Заголовок файла
  l_fileheader := dbms_xmldom.getelementsbytagname(l_doc, 'FileHeader');
  l_header := dbms_xmldom.item(l_fileheader, 0);

  -- дата баланса
  dbms_xslprocessor.valueof(l_header, 'CreationDate/text()', l_str);
  l_filedate := to_date(l_str, 'yyyy-mm-dd');

  -- проверка дат баланса
  if l_filedate < l_pardate then
     begin
        select file_name into l_str from ow_files where id = l_id;
     exception when no_data_found then l_str := to_char(l_id);
     end;
     -- ставим статус "обработан с ошибкой"
     set_file_status(p_fileid, null, 3, 'Дата балансу в файлі менше за встановлену дату балансу');
     bars_audit.info(h || l_str ||': Дата балансу в файлі менше за встановлену дату балансу');
     raise_application_error(-20000, l_str ||': Дата балансу в файлі менше за встановлену дату балансу');
  elsif l_filedate > l_pardate then
     -- удаляем старый баланс
     delete from ow_cng_data where cngdate < l_filedate;
     -- сохраняем дату баланса
     update ow_params
        set val = to_char(l_filedate, 'dd.mm.yyyy')
      where par = 'CNGDATE';
  end if;

  -- Тело файла
  l_contractlist := dbms_xmldom.getelementsbytagname(l_doc, 'ContractRs');
  bars_audit.info(h||'getelementsbytagname done');

  for i in 0 .. dbms_xmldom.getlength(l_contractlist) - 1
  loop

     l_idn := i + 1;

     l_contract := dbms_xmldom.item(l_contractlist, i);

     l_rec.extend;

     l_rec(l_rec.last).id  := l_id;
     l_rec(l_rec.last).idn := l_idn;

     dbms_xslprocessor.valueof(l_contract, 'Contract/ContractIDT/ContractNumber/text()', l_str);
     l_rec(l_rec.last).contract_id := l_str;

     dbms_xslprocessor.valueof(l_contract, 'Contract/ContractIDT/RBSNumber/text()', l_str);
     l_rec(l_rec.last).contract_acc := l_str;

     dbms_xslprocessor.valueof(l_contract, 'Contract/Currency/text()', l_str);
     l_rec(l_rec.last).contract_currency := l_str;

     dbms_xslprocessor.valueof(l_contract, 'Contract/ContractName/text()', l_str);
     l_rec(l_rec.last).contract_name := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

     dbms_xslprocessor.valueof(l_contract, 'Contract/DateOpen/text()', l_str);
     l_rec(l_rec.last).contract_dateopen := to_date(l_str,'YYYY-MM-DD');

     dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/FirstName/text()', l_str);
     l_rec(l_rec.last).plastic_title := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

     dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/FirstName/text()', l_str);
     l_rec(l_rec.last).plastic_firstname := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

     dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/LastName/text()', l_str);
     l_rec(l_rec.last).plastic_lastname := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

     dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/CompanyName/text()', l_str);
     l_rec(l_rec.last).plastic_companyname := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

     dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="AVAILABLE"]/Amount/text()', l_str);
     l_rec(l_rec.last).avl_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="OWN_BALANCE"]/Amount/text()', l_str);
     l_rec(l_rec.last).own_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="CR_LIMIT"]/Amount/text()', l_str);
     l_rec(l_rec.last).cr_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="06"]/Amount/text()', l_str);
     l_rec(l_rec.last).mob_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="SEC_DEPOSIT"]/Amount/text()', l_str);
     l_rec(l_rec.last).sec_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="ADRESS1"]/Amount/text()', l_str);
     l_rec(l_rec.last).ad_amount := convert_to_number(l_str);

     dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="VIRTUAL"]/Amount/text()', l_str);
     l_rec(l_rec.last).virtual_amount := convert_to_number(l_str);

     l_nls := l_rec(l_rec.last).contract_acc;
     l_lcv := l_rec(l_rec.last).contract_currency;
     begin
        select acc into l_acc
          from accounts
         where nls = l_nls
           and kv  = decode(l_lcv,'UAH',980,'USD',840,'EUR',978);
     exception when no_data_found then
        l_acc := null;
     end;
     l_rec(l_rec.last).acc := l_acc;

     l_rec(l_rec.last).cngdate := l_filedate;
     l_rec(l_rec.last).kf := sys_context('bars_context','user_mfo');
     -- пакетная вставка каждых 10к
     if mod(i, 10000) = 0 then
        bulk_insert(l_rec);
        l_rec.delete;
     end if;

  end loop;

  -- оставшиеся записи
  bulk_insert(l_rec);

  -- удаляем старые данные по счетам файла,
  --   1) если заимпортировали файл, переименовали его и заимпортировали еще раз,
  --   2) если Way4 прислал файл, передумал и прислал еще раз.
  delete from ow_cng_data
   where (id, idn) in ( select c.id, c.idn
                          from ow_cng_data c, ow_cng_data d
                         where c.id <> p_fileid
                           and d.id  = p_fileid
                           and c.contract_acc = d.contract_acc and c.contract_currency = d.contract_currency );

  -- ставим статус "обработан"
  set_file_status(p_fileid, l_idn, 2, null);

  bars_audit.info(h||'load done');

  -- free (не забыть делать очистку в случае ошибок)
  l_rec.delete();
  l_rec := null;
  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);

  bars_audit.info(h || to_char(l_idn) || ' rows parsed.');

  for z in ( select a.acc, decode(a.pap,2,1,-1) * nvl(abs(c.cr_amount),0) * 100 lim
               from ow_cng_data c, accounts a
              where c.id = p_fileid
                and c.acc = a.acc
                and a.dazs is null
                and a.lim <> decode(a.pap,2,1,-1) * nvl(abs(c.cr_amount),0) * 100 )
  loop
     update accounts set lim = z.lim where acc = z.acc;
  end loop;

  bars_audit.info(h || 'Finish.');

end iparse_cng_file;

-- iparse_cng_file
-- процедура разбора файла CNG - " _GL_BAL.txt"
--

procedure iparse_cng_file_txt (
  p_fileid    in number,
  p_filebody  in clob )
is
  l_id       number;
  l_filebody clob;
  l_idn      number := 0;
  l_idn_lim  number := 0;
  l_kf       varchar2(6);
  l_nls      varchar2(15);
  l_dat_bal  date;
  l_data     varchar2(4000);
  l_acc      number;
  l_pardate  date := null;
  l_filedate date := null;
  l_str      varchar2(2000);

  type t_cng_txt   is table of ow_cng_data_txt%rowtype;
  l_rec  t_cng_txt := t_cng_txt();

  type t_cng_txt_r is record ( acc_pk ow_cng_data_txt.acc_pk%type, nbs_ow ow_cng_data_txt.nbs_ow%type, ost ow_cng_data_txt.ost%type );

  type t_cng_txt_lim   is table of t_cng_txt_r;
  l_rec_lim  t_cng_txt_lim := t_cng_txt_lim();

  h varchar2(100) := 'bars_ow.iparse_cng_file_txt. ';

    -- процедура пакетной вставки коллекции+апдейт accounts
  procedure bulk_insert(l_rec in t_cng_txt) is
  begin

    forall j in l_rec.first .. l_rec.last
      insert into ow_cng_data_txt values l_rec(j);
  end;

  procedure bulk_update(l_rec_lim in t_cng_txt_lim) is
  begin
    forall k in l_rec_lim.first .. l_rec_lim.last
      update accounts set lim = decode(pap,2,1,-1) * nvl(abs(l_rec_lim(k).ost),0) * 100
       where l_rec_lim(k).acc_pk = acc
         and l_rec_lim(k).nbs_ow ='NLS_9129'
         and dazs is null
         and lim <> decode(pap,2,1,-1) * nvl(abs(l_rec_lim(k).ost),0) * 100 ;
  end;

begin

  bars_audit.info(h || 'Start.');

  l_id       := p_fileid;
  l_filebody := p_filebody;

  delete ow_cng_data_txt;

  bars_audit.info(h || 'Deleted.');

  import_flat_file(l_filebody);

  bars_audit.info(h || 'Imported to TMP_IMP_FILE.');

  -- дата предыдущего баланса
  select nvl(min(to_date(val,'dd.mm.yyyy')), trunc(sysdate-7)) into l_pardate from ow_params where par = 'CNGDATE';

-- дата нового баланса баланса
    select min(to_date( substr(line,instr(line,'/')-2,10),'dd/mm/yyyy')) into l_filedate from TMP_IMP_FILE
    where rownum=1;

  -- проверка дат баланса
  if l_filedate < l_pardate then
     begin
        select file_name into l_str from ow_files where id = l_id;
     exception when no_data_found then l_str := to_char(l_id);
     end;
     -- ставим статус "обработан с ошибкой"
     set_file_status(p_fileid, null, 3, 'Дата балансу в файлі менше за встановлену дату балансу');
     bars_audit.info(h || l_str ||': Дата балансу в файлі менше за встановлену дату балансу');
     raise_application_error(-20000, l_str ||': Дата балансу в файлі менше за встановлену дату балансу');
  elsif l_filedate > l_pardate then
     update ow_params
        set val = to_char(l_filedate, 'dd.mm.yyyy')
      where par = 'CNGDATE';
  end if;



  for c0 in (select t.line,
                    t.nls ,
                    a.acc ,
                    t.kf,
                    t.data,
                    t.dat_bal
           from
             (select line,
                     trim(substr(line,instr(line,'-')+1,14)) nls,
                     substr(line,1,6) kf,
                     substr(line,instr(line,'/')+9,length(line)) data,
                     to_date( substr(line,instr(line,'/')-2,10),'dd/mm/yyyy') dat_bal
                from TMP_IMP_FILE ) t,
             accounts a
            where a.nls=t.nls
            and trim(t.data) <>'0'
            )
  loop

    l_data    := c0.data;
    l_nls     := c0.nls;
    l_acc     := c0.acc;
    l_kf      := c0.kf;
    l_dat_bal := c0.dat_bal;

    if instr(l_data,'NLS_9129=')>0
     then
    l_rec_lim.extend;
    l_rec_lim(l_rec_lim.last).nbs_ow  := 'NLS_9129';
    l_rec_lim(l_rec_lim.last).acc_pk  := l_acc;
    l_rec_lim(l_rec_lim.last).ost:=substr(l_data,instr(l_data,'NLS_9129=')+length('NLS_9129')+1,instr(substr(l_data,instr(l_data,'NLS_9129=')+length('NLS_9129')+1,length(l_data)),';')-1);
    l_idn_lim := l_idn_lim + 1;
    end if;

    if mod(l_idn_lim, 10000) = 0 then
       bulk_update(l_rec_lim);
       l_rec_lim.delete;
    end if;

        for c1 in (select * from ow_cng_types )
            loop

            if  instr(l_data,c1.nbs_ow||'=')>0
             then
            l_rec.extend;
            l_idn := l_idn + 1;
            l_rec(l_rec.last).id      := l_id;
            l_rec(l_rec.last).idn     := l_idn;
            l_rec(l_rec.last).kf      := l_kf;
            l_rec(l_rec.last).nls     := l_nls;
            l_rec(l_rec.last).dat_bal := l_dat_bal;
            l_rec(l_rec.last).nbs_ow  := c1.nbs_ow;
            l_rec(l_rec.last).acc_pk  := l_acc;
            l_rec(l_rec.last).ost:=substr(l_data,instr(l_data,c1.nbs_ow||'=')+length(c1.nbs_ow)+1,instr(substr(l_data,instr(l_data,c1.nbs_ow||'=')+length(c1.nbs_ow)+1,length(l_data)),';')-1);
            end if;

            -- пакетная вставка каждых 10к
            if mod(l_idn, 10000) = 0 then
                    bulk_insert(l_rec);
                    l_rec.delete;
            end if;

            end loop;


  end loop;

  -- оставшиеся записи
  bulk_insert(l_rec);

  bulk_update(l_rec_lim);

  bars_audit.info(h || 'Imported data.');

  -- ставим статус "обработан"
  set_file_status(l_id, l_idn, 2, null);

  l_rec.delete();
  l_rec := null;

  l_rec_lim.delete();
  l_rec_lim := null;

  bars_audit.info(h || 'Finish.');

end iparse_cng_file_txt;

-------------------------------------------------------------------------------
-- iparse_riic_file
-- процедура разбора квитанции RIIC*.*
--
procedure iparse_riic_file (
  p_fileid    in number,
  p_filename  in varchar2,
  p_filebody  in clob )
is
  l_filebody     xmltype;

  l_iic_filename ow_iicfiles.file_name%type;
  l_iic_n        ow_iicfiles.file_n%type;
  l_filestatus   ow_files.file_status%type := 2;
  l_status     varchar2(23);
  l_acceptrec  number;
  l_rejectrec  number;
  l_msg_code   varchar2(100);
  l_resp_class varchar2(100);
  l_resp_code  varchar2(100);
  l_resp_text  varchar2(254);
  l_drn        number;
  l_srn        number;
  l_tmp        varchar2(100);
  l_dk         number;
  l_acc        number;
  l_nls        varchar2(14);
  l_kv         number;

  c_filetrailer  varchar2(48)  := '/DocFile/FileTrailer/';
  c_doclist      varchar2(100) := '/DocFile/DocList/';
  c_doc          varchar2(100);
  c_parm         varchar2(100);
  l_xml          xmltype;
  l_err          varchar2(254) := null;
  l_msg          varchar2(254) := null;

  l_payflag number;
  l_tt      varchar2(3);
  b_kvt     boolean := false;
  l_p1      number;
  l_p2      number;

  i number := null;
  j number;
  h varchar2(100) := 'bars_ow.iparse_riic_file. ';

begin

  bars_audit.info(h || 'Start: p_filename=>' || p_filename);

  begin
     select file_name, file_n
       into l_iic_filename, l_iic_n
       from ow_iicfiles
      where upper(p_filename) like upper('%'||file_name||'%');
  exception when no_data_found then
     l_filestatus := 3;
     l_msg := 'Квитанція на неіснуючий файл';
     bars_audit.info(h || p_filename || ': ' || l_msg);
  end;

  if l_filestatus <> 3 then

     l_filebody := xmltype(p_filebody);

     l_status    :=    substr(extract(l_filebody, c_filetrailer || '/LoadingStatus/text()', null),1,23);
     l_acceptrec := to_number(extract(l_filebody, c_filetrailer || '/NOfAcceptedRecs/text()', null));
     l_rejectrec := to_number(extract(l_filebody, c_filetrailer || '/NOfRejectedRecs/text()', null));

     if l_iic_n <> l_acceptrec + l_rejectrec then
        l_filestatus := 3;
        l_msg := 'Кількість документів квитанції не відповідає кількості документів файла';
        bars_audit.info(h || p_filename || ': ' || l_msg);
     end if;

  end if;

  if l_filestatus <> 3 then

  i := 0;

  loop

     -- счетчик документов
     i := i + 1;

     c_doc := c_doclist || 'Doc[' || i || ']';

     -- выход при отсутствии транзакций
     if l_filebody.existsnode(c_doc) = 0 then
        exit;
     end if;

     l_xml := xmltype(extract(l_filebody,c_doc,null));

     l_msg_code   := substr(extract(l_xml, '/Doc/TransType/TransCode/MsgCode/text()', null),1,100);
     l_resp_class := substr(extract(l_xml, '/Doc/Status/RespClass/text()', null),1,100);
     l_resp_code  := substr(extract(l_xml, '/Doc/Status/RespCode/text()', null),1,100);
     l_resp_text  := substr(extract(l_xml, '/Doc/Status/RespText/text()', null),1,254);

     j := 0;

     loop

        j := j + 1;

        c_parm := '/Doc/DocRefSet/Parm[' || j || ']';

        -- выход при отсутствии транзакций
        if l_xml.existsnode(c_parm) = 0 then
           exit;
        end if;

        l_tmp := substr(extract(l_xml, c_parm || '/ParmCode/text()', null),1,100);
        if l_tmp = 'DRN' then
           l_drn := to_number(extract(l_xml, c_parm || '/Value/text()', null));
        elsif l_tmp = 'SRN' then
           l_srn := to_number(extract(l_xml, c_parm || '/Value/text()', null));
        end if;

     end loop;

     l_err := null;
     l_acc := null;

     -- счета
     if l_msg_code = 'PAYFAAS' then

        -- ищем счет
        l_tmp := substr(extract(l_xml, '/Doc/Destination/ContractNumber/text()', null),1,100);
        l_nls := trim(replace(l_tmp, g_w4_branch||'-', ''));
        l_kv  := to_number(extract(l_xml, '/Doc/Billing/Currency/text()', null));

        begin
           select acc into l_acc from accounts where nls = l_nls and kv = l_kv;
        exception when no_data_found then
           l_acc := null;
           l_err := 'Квитовка счета ' || l_nls || '/' || l_kv || ' - счет не найден';
           bars_audit.info(h || p_filename || ': ' || l_err);
           l_msg := substr(l_msg || l_err, 1, 254);
        end;

        if l_acc is not null then
           -- сохраняем историю
           insert into ow_acc_history (acc, s, dat, f_n, resp_class, resp_code, resp_text)
           select acc, s, dat, f_n, l_resp_class, l_resp_code, l_resp_text
             from ow_acc_que
            where upper(f_n) = upper(substr(p_filename,3))
              and acc = l_acc
              and sos = 1;
           -- ошибка
           if l_resp_class = 'Error' then
              -- повторно отправить файл
              begin
                 update ow_acc_que
                    set sos = 0,
                        f_n = null
                  where upper(f_n) = upper(substr(p_filename,3))
                    and acc = l_acc
                    and sos = 1;
              exception when dup_val_on_index then
                 -- уже есть новые данные для отправки по этому счету, удаляем старые
                 delete from ow_acc_que
                  where upper(f_n) = upper(substr(p_filename,3))
                    and acc = l_acc
                    and sos = 1;
              end;
           -- успешная обработка
           else
              delete from ow_acc_que
               where upper(f_n) = upper(substr(p_filename,3))
                 and acc = l_acc
                 and sos = 1;
           end if;
        end if;

     -- документы
     else
        begin
           select dk into l_dk from ow_msgcode where msgcode = l_msg_code;

           -- квитовка строки
           update ow_pkk_que
              set drn = l_drn,
                  resp_class = l_resp_class,
                  resp_code  = l_resp_code,
                  resp_text  = l_resp_text
            where f_n = l_iic_filename
              and ref = l_srn
              and dk  = l_dk
           returning acc into l_acc;
           -- если не нашли, смотрим на уже сквитованные документы
           if sql%rowcount = 0 then 

              -- якщо регіон не втягнув всі файли до міграції в ммфо
              -- добавляємо ключ до референса.
              update ow_pkk_que
                 set drn = l_drn,
                     resp_class = l_resp_class,
                     resp_code  = l_resp_code,
                     resp_text  = l_resp_text
               where f_n = l_iic_filename
                 and ref = bars_sqnc.rukey(to_char(l_srn))
                 and dk  = l_dk
              returning acc into l_acc;                            
           if sql%rowcount = 0 then
              update ow_pkk_history
                 set drn = l_drn,
                     resp_class = l_resp_class,
                     resp_code  = l_resp_code,
                     resp_text  = l_resp_text
               where f_n = l_iic_filename
                 and ref = bars_sqnc.rukey(to_char(l_srn))
                 and dk  = l_dk
              returning acc into l_acc;                            
              if sql%rowcount = 0 then
                 update ow_pkk_history
                    set drn = l_drn,
                        resp_class = l_resp_class,
                        resp_code  = l_resp_code,
                        resp_text  = l_resp_text
                  where f_n = l_iic_filename
                    and ref = l_srn
                    and dk  = l_dk
                 returning acc into l_acc;
                 if sql%rowcount = 0 then
                    l_err := 'Квитовка док. ' || l_srn || ' - док. не відправлявся в файлі ' || l_iic_filename ||';';
                    bars_audit.info(h || p_filename || ': ' || l_err);
                    l_msg := substr(l_msg || l_err, 1, 254);
                 end if;
              end if;
           end if;
           end if;

           begin
              select t.pay_flag, o.tt into l_payflag, l_tt
                from obpc_trans_out t, oper o
               where o.ref = l_srn
                 and o.tt = t.tt
                 and t.dk = l_dk;
           exception when no_data_found then 
              begin
              l_srn :=  to_number(bars_sqnc.rukey(to_char(l_srn)));
              select t.pay_flag, o.tt into l_payflag, l_tt
                from obpc_trans_out t, oper o
               where o.ref = l_srn
                 and o.tt = t.tt
                 and t.dk = l_dk;
           exception when no_data_found then null;
           end;
           end;

           -- оплата/сторнирование при квитовке
           if l_srn is not null and l_err is null and l_payflag in (1, 2) then
              b_kvt := false;
              -- успешная квитовка
              if l_payflag = 1 and l_resp_code = '0' then
                 begin
                 final_payment(l_srn, l_dk, b_kvt);
                 -- квитовка документа
                 if b_kvt then
                    -- доп. реквизиты
                    if l_dk = 1 then
                       set_operw(l_srn, 'OW_FL', p_filename);
                    else
                       set_operw(l_srn, 'OWFL2', p_filename);
                    end if;
                    -- удаление из очереди на отправку/квитовку
                    del_pkkque(l_srn, l_dk);
                 end if;
                 exception
                   when others then

                    l_err := substr('Квитовка док.' || l_srn || '-ошибка:'||sqlerrm,1,254);
                    bars_audit.info(h ||'Err:' || p_filename|| ' Ref:'||l_srn||' '|| dbms_utility.format_error_stack() || chr(10) ||
                                    dbms_utility.format_error_backtrace());
                    l_msg := substr(l_msg || l_err, 1, 254);
                    update ow_pkk_que
                       set resp_text  = l_err
                    where f_n = l_iic_filename
                       and ref = l_srn
                       and dk = l_dk
                    returning acc into l_acc;
                 end;
              end if;
              -- ошибка квитовки
              if l_payflag in (1, 2) and l_resp_code <> '0' then
                 -- удаление из очереди на отправку/квитовку
                 del_pkkque(l_srn, l_dk);
                 -- сторнируем документ
                 begin
                    savepoint sp_back;
                    if l_tt = g_tt_asg then
                       declare
                          l_asg_nd  number;
                          l_asg_dat date;
                       begin
                          select to_number(min(decode(trim(tag),'ND', value, null))),
                                 to_date(min(decode(trim(tag),'MDATE', value, null)), 'dd.mm.yyyy')
                            into l_asg_nd, l_asg_dat
                            from operw
                           where ref = l_srn;
                          if l_asg_nd is not null and l_asg_dat is not null then
                             execute immediate 'declare l_asg_ref number; begin l_asg_ref := ' || l_srn || '; cck_dpk.modi_ret_ex(:nd, l_asg_ref, :dat); end;' using l_asg_nd, l_asg_dat;
                          else
                             p_back_dok(l_srn, 5, null, l_p1, l_p2);
                          end if;
                       end;
                    else
                       p_back_dok(l_srn, 5, null, l_p1, l_p2);
                    end if;
                    update operw set
                           value = substr( 'Повернено по квитанції ПЦ ' ||
                                            p_filename ||'('||
                                            l_resp_code||'#'||
                                            l_resp_text||')'
                                            ,1,220
                                          )
                    where ref = l_srn and tag = 'BACKR';

                    insert into oper_visa (ref, dat, userid, groupid, status)
                    values (l_srn, sysdate, user_id, g_chkid, 3);
                 exception when others then
                    rollback to sp_back;
                    bars_audit.info(h ||'Err:' || p_filename|| ' ' || dbms_utility.format_error_stack() || chr(10) ||
                                    dbms_utility.format_error_backtrace());
                 end;
              end if;
              if l_tt = g_tt_asg then
                 set_cck_sob(l_srn, l_dk, l_acc, 2, b_kvt);
              end if;
           end if;

        exception when no_data_found then
           l_err := 'Квитовка док. ' || l_srn || ' - неизвестный код MsgCode - ' || l_msg_code;
           bars_audit.info(h || p_filename || ': ' || l_err);
           l_msg := substr(l_msg || l_err, 1, 254);
        end;
     end if;

  end loop;

  -- квитовка файла
  update ow_iicfiles
     set tick_name = p_filename,
         tick_date = sysdate,
         tick_status = l_status,
         tick_accept_rec = l_acceptrec,
         tick_reject_rec = l_rejectrec
   where file_name = l_iic_filename;

  end if;

  -- ставим статус
  set_file_status(p_fileid, (case when i is null then null else i-1 end), l_filestatus, l_msg);

  bars_audit.info(h || 'Finish.');

end iparse_riic_file;

-------------------------------------------------------------------------------
-- set_sparam
-- процедура установки спецпараметров счетов
--
procedure set_sparam (p_mode varchar2, p_acc number, p_trmask t_trmask)
is
  l_nd         number;
  l_pk_tip     accounts.tip%type;
  l_pk_nbs     accounts.nbs%type;
  l_pk_ob22    accounts.ob22%type;
  l_grpcode    w4_product.grp_code%type;
  l_sp_name    sparam_list.name%type;
  l_sp_tabname sparam_list.tabname%type;
  l_sp_tag     sparam_list.tag%type;
  l_ob22       varchar2(2) := null;
  h varchar2(100) := 'bars_ow.set_sparam. ';
begin

  bars_audit.trace(h || 'Start: nbs=>' || p_trmask.nbs || ' p_acc=>' || to_char(p_acc));

  -- читаем параметры карточного счета
  begin
/*            case p_mode
               when '2625'  then 'o.acc_pk'
               when 'OVR'   then 'o.acc_ovr'
               when '2202'  then 'o.acc_ovr'
               when '2203'  then 'o.acc_ovr'
               when '2062'  then 'o.acc_ovr'
               when '2063'  then 'o.acc_ovr'
               when '2208'  then 'o.acc_2208'
               when '2068'  then 'o.acc_2208'
               when '3570'  then 'o.acc_3570'
               when '2628'  then 'o.acc_2628'
               when '2608'  then 'o.acc_2628'
               when '2658'  then 'o.acc_2628'
               when '2528'  then 'o.acc_2628'
               when '2548'  then 'o.acc_2628'
               when '2627'  then 'o.acc_2627'
               when '2607'  then 'o.acc_2627'
               when '2657'  then 'o.acc_2627'
               when '2627X' then 'o.acc_2627X'
               when '2625D' then 'o.acc_2625D'
               when '2207'  then 'o.acc_2207'
               when '2067'  then 'o.acc_2207'
               when '2209'  then 'o.acc_2209'
               when '2069'  then 'o.acc_2209'
               when '3579'  then 'o.acc_3579'
               when '9129'  then 'o.acc_9129'
               else ''''''
            end*/     
    execute immediate
    'select o.nd, a.tip, nvl(a.nbs, substr(a.nls,1,4)), a.ob22, p.grp_code
       from w4_acc o, accounts a, w4_card c, w4_product p
      where o.acc_pk = a.acc
        and :p_acc = o.' ||p_trmask.a_w4_acc|| '
        and o.card_code = c.code
        and c.product_code = p.code'
       into l_nd, l_pk_tip, l_pk_nbs, l_pk_ob22, l_grpcode
      using p_acc;
  exception when no_data_found then
     -- Для режима p_mode не найден счет ACC=p_acc
     bars_audit.error(h || 'Для режима ' || p_trmask.nbs || ' не найден счет ACC=' || to_char(p_acc));
     bars_error.raise_nerror(g_modcode, 'MODEANDACC_NOT_FOUND', p_trmask.nbs, to_char(p_acc));
  end;

  -- читаем ОБ22
  if p_mode = '0' then
     begin
/*
decode(p_mode,
               'OVR',   ob_ovr,
               '2202',  ob_ovr,
               '2203',  ob_ovr,
               '2062',  ob_ovr,
               '2063',  ob_ovr,
               '2208',  ob_2208,
               '2068',  ob_2208,
               '3570',  ob_3570,
               '2628',  ob_2628,
               '2608',  ob_2628,
               '2658',  ob_2628,
               '2528',  ob_2628,
               '2548',  ob_2628,
               '2627',  ob_2627,
               '2607',  ob_2627,
               '2657',  ob_2627,
               '2627X', ob_2627X,
               '2625D', ob_2625D,
               '2207',  ob_2207,
               '2067',  ob_2207,
               '2209',  ob_2209,
               '2069',  ob_2209,
               '3579',  ob_3579,
               '9129',  ob_9129, null)
*/  
       execute immediate
        'select '||p_trmask.a_w4_nbs_ob22|| 
          ' from w4_nbs_ob22
         where tip  = :pk_tip
           and nbs  = :pk_nbs
           and ob22 = :pk_ob22'
          into l_ob22
         using l_pk_tip, l_pk_nbs, l_pk_ob22;
     exception when no_data_found then
        l_ob22 := null;
     end;
     -- для счетов 2625D, 2625X ОБ22 как для карточного счета
     if p_trmask.nbs in('2620', '2625') and l_ob22 is null then
        l_ob22 := l_pk_ob22;
     end if;
     accreg.setAccountSParam(p_acc, 'NKD', 'БПК_' || l_nd);
     accreg.setAccountSParam(p_acc, 'OB22', l_ob22);
  end if;

  -- спецпараметры
  for z in ( select sp_id, value
               from w4_sparam
              where grp_code = l_grpcode
                and tip = l_pk_tip
                and nbs = p_trmask.nbs
                and sp_id is not null
                and value is not null
                and(p_mode = '1' or (p_mode = '0' and tipad = p_trmask.tip))
                 )
  loop
     begin
        select name, tabname, tag into l_sp_name, l_sp_tabname, l_sp_tag
          from sparam_list
         where spid = z.sp_id;

        if upper(l_sp_tabname) = 'ACCOUNTSW' and l_sp_tag is not null then
           accreg.setAccountwParam(p_acc, l_sp_tag, z.value);
        else
           accreg.setAccountSParam(p_acc, l_sp_name, z.value);
        end if;
     exception when no_data_found then null;
     end;
  end loop;

  bars_audit.trace(h || 'Finish.');

end set_sparam;

-------------------------------------------------------------------------------
-- open_acc
-- процедура открытия счета
--
procedure open_acc (
  p_pk_acc  number,
  p_trmask  t_trmask,
  p_acc out number )
is
  l_cardcode     w4_acc.card_code%type;
  l_edat         date;
  l_nd           number;
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
  l_pk_daos      date;
  l_pk_isp       number;
  l_pk_tobo      varchar2(30);
  l_nls          varchar2(14);
  l_nms          varchar2(70) := null;
  l_acc          number;
  l_tmp          number;
  l_mdate        date   := null;
  l_p4           number;
  l_pap          number := null;
  l_sql          varchar2(4000);
  h varchar2(100) := 'bars_ow.open_acc. ';
begin

  bars_audit.trace(h || 'Start: p_pk_acc=>' || to_char(p_pk_acc) || ' nbs=>' || to_char(p_trmask.nbs)||' tip=>'||p_trmask.tip);

  l_mfo := gl.amfo;

  -- параметры счета
  begin
     select o.nd, o.card_code, o.dat_end, c.rnk, c.nmk,
            case
              when a.nbs in('2625', '2620') then 3
              else 2
            end custtype, a.acc, a.nls, a.nbs, a.nms, a.kv, a.daos, a.isp, a.tobo
       into l_nd, l_cardcode, l_edat, l_pk_rnk, l_pk_nmk, l_pk_custtype,
            l_pk_acc, l_pk_nls, l_pk_nbs, l_pk_nms, l_pk_kv, l_pk_daos, l_pk_isp, l_pk_tobo
       from w4_acc o, accounts a, customer c
      where o.acc_pk = p_pk_acc
        and o.acc_pk = a.acc
        and a.rnk    = c.rnk;
  exception when no_data_found then
     -- Счет ACC=p_pk_acc не найден в портфеле БПК-Way4
     bars_audit.trace(h || 'Счет ACC=' || to_char(p_pk_acc) || ' не найден в портфеле БПК-Way4');
     bars_error.raise_nerror(g_modcode, 'W4ACC_NOT_FOUND', to_char(p_pk_acc));
  end;

  -- определение БС

/*  if newnbs.g_state = 1 then
     l_nbs := get_new_nbs(substr(p_mode,1,4));
  else
     l_nbs := substr(p_mode,1,4);
  end if;*/
/*  l_nms := case when p_mode in ('2202', '2203', '2062', '2063') then
                     substr('Кред. ' || l_pk_nms, 1, 70)
                when p_mode in ('2208', '2068') then
                     substr('Нарах.дох.за кред. ' || l_pk_nms, 1, 70)
                when p_mode in ('2628', '2608', '2658', '2528', '2548') then
                     substr('Нарах.витрати ' || l_pk_nms, 1, 70)
                when p_mode in ('2627', '2607', '2657') then
                     substr('Нарах.дох. ' || l_pk_nmk, 1, 70)
                when p_mode = '2627X' then
                     substr('Нарах.дох. за несанкц.овердрафт ' || l_pk_nmk, 1, 70)
                when p_mode = '2625D' then
                     substr('Моб.зб. ' || l_pk_nmk, 1, 70)
                when p_mode in ('2207', '2067') then
                     substr('Простр.заборг. за кред. ' || l_pk_nmk, 1, 70)
                when p_mode in ('2209', '2069') then
                     substr('Простр.нарах.дох. за кред. ' || l_pk_nmk, 1, 70)
                when p_mode = '3570' then
                     substr('Нарах.дох. ' || l_pk_nmk, 1, 70)
                when p_mode = '3579' then
                     substr('Простр.нарах.дох.(коміс.) ' || l_pk_nmk, 1, 70)
                when p_mode = '9129' then
                     substr('Невикор.ліміт ' || l_pk_nls, 1, 70)
                else null
           end;*/
  l_nms := substr(replace(replace(replace(p_trmask.nms,'#NMS', l_pk_nms), '#NMK', l_pk_nmk), '#NLS', l_pk_nls), 1, 70);
  if l_nms is null then
     -- Неизвестный режим счета p_mode
     bars_audit.trace(h || 'Неизвестный режим счета ' || to_char(p_trmask.nbs)||p_trmask.tip);
     bars_error.raise_nerror(g_modcode, 'UNKNOWN_MODE', to_char(p_trmask.nbs)||p_trmask.tip);
  end if;

  -- mdate для 2202/2203/2062/2063, 2208/2068, 2207/2067, 2209/2069, 9129
  if p_trmask.nbs in ('2202', '2203', '2062', '2063', '2208', '2068', '2207', '2067', '2209', '2069', '9129') then
     l_mdate := l_edat;
     if p_trmask.nbs = '2208' then
        l_pap := 1;
     end if;
  end if;

  -- определение счета:
  --   сначала по маске картсчета,
  --   если он занят, ищем свободный по порядку
  begin
     -- сначала ищем по маске карточного счета pk_nls
     l_nls := vkrzn(substr(l_mfo,1,5), p_trmask.nbs || '0' || substr(l_pk_nls,6,9));
     select 1 into l_tmp from accounts where nls = l_nls and kv = l_pk_kv;
     -- счет нашли, он занят, определяем свободный
     l_nls := get_newaccountnumber(l_pk_rnk, p_trmask.nbs);
  exception when no_data_found then null;
  end;

  -- открытие счета
  op_reg_ex(99, 0, 0, null, l_p4, l_pk_rnk,
     l_nls, l_pk_kv, l_nms, p_trmask.tip, l_pk_isp, l_acc,
     '1', l_pap, null, null, null, null, null, null, null, null, null, null,
     l_pk_tobo);

  bars_audit.trace(h || 'Account ' || l_nls || '/' || to_char(l_pk_kv) || ' opened.');

  if l_mdate is not null then
     update accounts set mdate = l_mdate where acc = l_acc;
  end if;
/*
  -- добавление в таблицу договоров по БПК
  if p_mode in ('2202', '2203', '2062', '2063') then
     update w4_acc set acc_ovr = l_acc where acc_pk = p_pk_acc;
  elsif p_mode in ('2208', '2068') then
     update w4_acc set acc_2208 = l_acc where acc_pk = p_pk_acc;
  elsif p_mode = '3570' then
     update w4_acc set acc_3570 = l_acc where acc_pk = p_pk_acc;
  elsif p_mode in ('2628', '2608', '2658', '2528', '2548') then
     update w4_acc set acc_2628 = l_acc where acc_pk = p_pk_acc;
  elsif p_mode in ('2627', '2607', '2657') then
     update w4_acc set acc_2627 = l_acc where acc_pk = p_pk_acc;
  elsif p_mode = '2627X' then
     update w4_acc set acc_2627X = l_acc where acc_pk = p_pk_acc;
  elsif p_mode = '2625D' then
     update w4_acc set acc_2625D = l_acc where acc_pk = p_pk_acc;
  elsif p_mode in ('2207', '2067') then
     update w4_acc set acc_2207 = l_acc where acc_pk = p_pk_acc;
  elsif p_mode in ('2209', '2069') then
     update w4_acc set acc_2209 = l_acc where acc_pk = p_pk_acc;
  elsif p_mode = '3579' then
     update w4_acc set acc_3579 = l_acc where acc_pk = p_pk_acc;
  elsif p_mode = '9129' then
     update w4_acc set acc_9129 = l_acc where acc_pk = p_pk_acc;*/
  if p_trmask.a_w4_acc is not null then
     l_sql := 'update w4_acc set '|| p_trmask.a_w4_acc||' = :acc where acc_pk = :acc_pkk';
     execute immediate l_sql using l_acc, p_pk_acc;
  else
     -- Неизвестный режим счета p_mode
     bars_audit.error(h || 'Неизвестный режим счета ' ||  to_char(p_trmask.nbs)||p_trmask.tip);
     bars_error.raise_nerror(g_modcode, 'UNKNOWN_MODE',  to_char(p_trmask.nbs)||p_trmask.tip);
  end if;

  -- спецпараметры
  set_sparam(0, l_acc, p_trmask);
  bars_audit.trace(h || 'Specparams for account ' || l_nls || '/' || to_char(l_pk_kv) || ' set.');

  p_acc := l_acc;

  bars_audit.trace(h || 'Finish.');

end open_acc;

-------------------------------------------------------------------------------
procedure ipay_doc (
  p_tt     oper.tt%type,
  p_vob    in oper.vob%type,
  p_dk     in oper.dk%type,
  p_sk     in oper.sk%type,
  p_nam_a  in oper.nam_a%type,
  p_nlsa   in oper.nlsa%type,
  p_mfoa   in oper.mfoa%type,
  p_id_a   in oper.id_a%type,
  p_nam_b  in oper.nam_b%type,
  p_nlsb   in oper.nlsb%type,
  p_mfob   in oper.mfob%type,
  p_id_b   in oper.id_b%type,
  p_kv     in oper.kv%type,
  p_s      in oper.s%type,
  p_kv2    in oper.kv2%type,
  p_s2     in oper.s2%type,
  p_nazn   in oper.nazn%type,
  p_ref   out number,
  p_mode   in number default 0,
  p_d_rec  in varchar2 default null)
is
/************************************************************************
  *p_mode = 1 - Вільні реквізити                                          *
  *         2 - Відміна операції по вільним реквізитам                    *
  *         3 - Понад лімітні операції по вільним реквізитам, не платимо  *
  *         4 - Реверсал по вільним реквізитам                            *
  *         5 - Платіж на користь страхової компанії                      *
  *************************************************************************/

  l_bdate  date;
  l_mfo    varchar2(6);
  l_ref    number;
  l_flag   number;
  l_nlsa   oper.nlsa%type;
  l_nlsb   oper.nlsb%type;
  l_sos    number := null;
  l_acc    number;
  l_tip    accounts.tip%type;
begin

  l_bdate := gl.bdate;
  l_mfo   := gl.amfo;

  select nvl(min(value),1) into l_flag from tts_flags where tt = p_tt and fcode = 37;

  gl.ref (l_ref);

  gl.in_doc3 (ref_    => l_ref,
              tt_     => p_tt,
              vob_    => p_vob,
              nd_     => to_char(l_ref),
              pdat_   => sysdate,
              vdat_   => l_bdate,
              dk_     => p_dk,
              kv_     => p_kv,
              s_      => p_s,
              kv2_    => p_kv2,
              s2_     => p_s2,
              sk_     => p_sk,
              data_   => l_bdate,
              datp_   => l_bdate,
              nam_a_  => p_nam_a,
              nlsa_   => p_nlsa,
              mfoa_   => nvl(p_mfoa,l_mfo),
              nam_b_  => p_nam_b,
              nlsb_   => p_nlsb,
              mfob_   => nvl(p_mfob,l_mfo),
              nazn_   => p_nazn,
              d_rec_  => p_d_rec,
              id_a_   => p_id_a,
              id_b_   => p_id_b,
              id_o_   => null,
              sign_   => null,
              sos_    => null,
              prty_   => 0,
              uid_    => user_id);

  if p_mode in(1, 3) then     l_nlsa := GetGlobalOption('NLS_292427_LOCPAY');

     if l_mfo <> p_mfob then
        l_nlsb := get_proc_nls('T00', p_kv);
     else
        if substr(p_nlsb, 1, 4) in ('2625', '2605', '2655', '2620', '2600', '2650', '2520', '2541', '2542', '3550', '3551') then
           select acc, tip into l_acc, l_tip from accounts where nls = p_nlsb and rownum = 1;
           if l_tip like 'W4%' then
              l_nlsb := get_transit(l_acc);
           else
              l_nlsb := p_nlsb;
           end if;
        else 
           l_nlsb := p_nlsb;
        end if;
     end if;
     
     gl.payv(0, l_ref, l_bdate, p_tt, p_dk, p_kv, l_nlsa, p_s, p_kv2, l_nlsb, p_s2);
     if l_mfo = p_mfob and p_mode = 1 then
        gl.pay(2, l_ref, l_bdate);
     end if;
  elsif p_mode = 2 then
     l_nlsa := GetGlobalOption('NLS_292427_LOCPAY');
     gl.payv(0, l_ref, l_bdate, p_tt, p_dk, p_kv, l_nlsa, p_s, p_kv2, p_nlsb, p_s2);
     gl.pay(2, l_ref, l_bdate);
  elsif p_mode = 4 then
     gl.dyntt2(l_sos,
               1,
               null,
               l_ref,
               l_bdate,
               l_bdate,
               p_tt,
               1,
               p_kv,
               nvl(p_mfoa,l_mfo),
               p_nlsa,
               p_s,
               p_kv2,
               nvl(p_mfob,l_mfo),
               p_nlsb,
               p_s2,
               null,
               null);
  elsif p_mode = 5 then
     if l_mfo <> p_mfob then
        l_nlsb := get_proc_nls('T00', p_kv);
     else
        l_nlsb := p_nlsb;
     end if;
     gl.payv(0, l_ref, l_bdate, p_tt, p_dk, p_kv, p_nlsa, p_s, p_kv2, l_nlsb, p_s2);
  else
     paytt ( flg_ => null,
             ref_ => l_ref,
            datv_ => l_bdate,
              tt_ => p_tt,
             dk0_ => p_dk,
             kva_ => p_kv,
            nls1_ => p_nlsa,
              sa_ => p_s,
             kvb_ => p_kv2,
            nls2_ => p_nlsb,
              sb_ => p_s2 );
  end if;

  p_ref := l_ref;

end ipay_doc;

-------------------------------------------------------------------------------
procedure irec_oic_atrn_to_arc (
  p_atrn  ow_oic_atransfers_data%rowtype,
  p_ref   number )
is
begin

  insert into ow_oic_atransfers_hist (id, idn,
     anl_synthcode, anl_trndescr, anl_analyticrefn,
     credit_anlaccount, credit_amount, credit_currency,
     debit_anlaccount, debit_amount, debit_currency,
     anl_postingdate, doc_drn, doc_orn, doc_localdate, doc_descr,
     doc_amount, doc_currency, ref, trans_info)
  values (p_atrn.id, p_atrn.idn,
     p_atrn.anl_synthcode, p_atrn.anl_trndescr, p_atrn.anl_analyticrefn,
     p_atrn.credit_anlaccount, p_atrn.credit_amount, p_atrn.credit_currency,
     p_atrn.debit_anlaccount, p_atrn.debit_amount, p_atrn.debit_currency,
     p_atrn.anl_postingdate, p_atrn.doc_drn, p_atrn.doc_orn, p_atrn.doc_localdate, p_atrn.doc_descr,
     p_atrn.doc_amount, p_atrn.doc_currency, p_ref, p_atrn.trans_info);

  delete from ow_oic_atransfers_data where id = p_atrn.id and idn = p_atrn.idn;

  -- оплаченные документы сохраняем для просмотра
  if p_ref is not null then
     begin
        insert into ow_oic_ref (id, ref)
        values (p_atrn.id, p_ref);
     exception when dup_val_on_index then null;
     end;
  end if;

end irec_oic_atrn_to_arc;

-------------------------------------------------------------------------------
procedure irec_oic_atrn_to_arc (
  p_id           ow_oic_atransfers_data.id%type,
  p_anlsynthcode ow_oic_atransfers_data.anl_synthcode%type,
  p_anltrndescr  ow_oic_atransfers_data.anl_trndescr%type,
  p_nlsa         ow_oic_atransfers_data.nlsa%type,
  p_nlsb         ow_oic_atransfers_data.nlsb%type,
  p_kv1          ow_oic_atransfers_data.debit_currency%type,
  p_kv2          ow_oic_atransfers_data.credit_currency%type,
  p_ref          number )
is
begin

  for z in ( select *
               from ow_oic_atransfers_data
              where id = p_id
                and anl_synthcode = p_anlsynthcode
                and anl_trndescr  = p_anltrndescr
                and nlsa = p_nlsa
                and nlsb = p_nlsb
                and debit_currency = p_kv1
                and credit_currency = p_kv2 )
  loop

     irec_oic_atrn_to_arc(z, p_ref);

  end loop;

end irec_oic_atrn_to_arc;

-------------------------------------------------------------------------------
procedure irec_oic_atrn_to_arc (
  p_id    ow_oic_atransfers_data.id%type,
  p_idn   ow_oic_atransfers_data.idn%type,
  p_ref   number )
is
begin

  for z in ( select *
               from ow_oic_atransfers_data
              where id  = p_id
                and idn = p_idn )
  loop

     irec_oic_atrn_to_arc(z, p_ref);

  end loop;

end irec_oic_atrn_to_arc;

-------------------------------------------------------------------------------
procedure irec_oic_strn_to_arc (
  p_strn  ow_oic_stransfers_data%rowtype,
  p_ref   number )
is
begin

  delete from ow_oic_stransfers_data where id = p_strn.id and idn = p_strn.idn;

  -- оплаченные документы сохраняем для просмотра
  if p_ref is not null then
     begin
        insert into ow_oic_ref (id, ref)
        values (p_strn.id, p_ref);
     exception when dup_val_on_index then null;
     end;
  -- удаленные из оплаты сохраняем для истории
  else
     insert into ow_oic_stransfers_hist (id, idn,
        synth_synthrefn, synth_synthcode, synth_trndescr,
        credit_syntaccount, credit_amount, credit_localamount, credit_currency,
        debit_syntaccount, debit_amount, debit_localamount, debit_currency,
        synth_postingdate)
     values (p_strn.id, p_strn.idn,
        p_strn.synth_synthrefn, p_strn.synth_synthcode, p_strn.synth_trndescr,
        p_strn.credit_syntaccount, p_strn.credit_amount, p_strn.credit_localamount, p_strn.credit_currency,
        p_strn.debit_syntaccount, p_strn.debit_amount, p_strn.debit_localamount, p_strn.debit_currency,
        p_strn.synth_postingdate);
  end if;

end irec_oic_strn_to_arc;

-------------------------------------------------------------------------------
procedure irec_oic_doc_to_arc (
  p_doc   ow_oic_documents_data%rowtype,
  p_ref   number )
is
begin

  delete from ow_oic_documents_data where id = p_doc.id and idn = p_doc.idn;

  -- оплаченные документы сохраняем для просмотра
  if p_ref is not null then
     begin
        insert into ow_oic_ref (id, ref)
        values (p_doc.id, p_ref);
     exception when dup_val_on_index then null;
     end;
  -- удаленные из оплаты сохраняем для истории
  else
     insert into ow_oic_documents_hist (id, idn,
        doc_localdate, doc_descr, doc_drn, doc_socmnt, doc_trdetails,
        cnt_contractnumber, cnt_clientregnumber, cnt_clientname,
        org_cbsnumber, dest_institution,
        bill_phasedate, bill_amount, bill_currency,doc_data, work_flag,is_sign_ok,
        msgcodes, repost_doc, postingstatus)
     values (p_doc.id, p_doc.idn,
        p_doc.doc_localdate, p_doc.doc_descr, p_doc.doc_drn, p_doc.doc_socmnt, p_doc.doc_trdetails,
        p_doc.cnt_contractnumber, p_doc.cnt_clientregnumber, p_doc.cnt_clientname,
        p_doc.org_cbsnumber, p_doc.dest_institution,
        p_doc.bill_phasedate, p_doc.bill_amount, p_doc.bill_currency, p_doc.doc_data, p_doc.work_flag, p_doc.is_sign_ok,
        p_doc.msgcodes, p_doc.repost_doc, p_doc.postingstatus);
  end if;

end irec_oic_doc_to_arc;

-------------------------------------------------------------------------------
-- iparse_roic_doc_rev
-- процедура разбора файла R_OIC_Documents*LOCPAYREV*.xml
--
procedure iparse_roic_doc_rev(p_fileid   in number,
                              p_filename in varchar2,
                              p_filebody in clob) is

  l_parser       dbms_xmlparser.parser;
  l_doc          dbms_xmldom.domdocument;
  l_filetrailer  dbms_xmldom.domnodelist;
  l_trailer      dbms_xmldom.domnode;
  l_analyticlist dbms_xmldom.domnodelist;
  l_analytic     dbms_xmldom.domnode;
  l_rec          ow_oic_documents_data%rowtype;
  l_str          varchar2(2000);
  l_resp_class ow_locpay_match.resp_class%type;
  l_resp_code  ow_locpay_match.resp_code%type;
  l_resp_text  ow_locpay_match.resp_text%type;
  l_filestatus ow_files.file_status%type := 2;

  l_status       varchar2(23);
  l_acceptrec    number;
  l_rejectrec    number;
  l_oic_filename ow_iicfiles.file_name%type;
  l_oic_n        ow_iicfiles.file_n%type;
  l_msg          varchar2(254) := null;

  h varchar2(100) := 'bars_ow.iparse_roic_doc_rev. ';
begin
  bars_audit.info(h || 'Start: p_filename=>' || p_filename);

  begin
    select file_name, file_n
      into l_oic_filename, l_oic_n
      from ow_oicrevfiles
     where upper(p_filename) like upper('%'||file_name||'%');
  exception
    when no_data_found then
      l_filestatus := 3;
      l_msg        := 'Квитанція на неіснуючий файл';
      bars_audit.info(h || p_filename || ': ' || l_msg);
  end;

  if l_filestatus <> 3 then

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    bars_audit.info(h || 'clob loaded');

    l_doc := dbms_xmlparser.getdocument(l_parser);
    bars_audit.info(h || 'getdocument done');

    l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'FileTrailer');
    l_trailer     := dbms_xmldom.item(l_filetrailer, 0);

    dbms_xslprocessor.valueof(l_trailer, 'LoadingStatus/text()', l_str);
    l_status := substr(l_str, 1, 23);

    dbms_xslprocessor.valueof(l_trailer, 'NOfAcceptedRecs/text()', l_str);
    l_acceptrec := convert_to_number(l_str);

    dbms_xslprocessor.valueof(l_trailer, 'NOfRejectedRecs/text()', l_str);
    l_rejectrec := convert_to_number(l_str);
    if l_oic_n <> l_acceptrec + l_rejectrec then
      l_filestatus := 3;
      l_msg        := 'Кількість документів квитанції не відповідає кількості документів файла';
      bars_audit.info(h || p_filename || ': ' || l_msg);
    end if;

    if l_filestatus <> 3 then
      l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'Doc');
      bars_audit.info(h || 'getelementsbytagname done');
      for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1
      loop

      l_analytic := dbms_xmldom.item(l_analyticlist, i);

      dbms_xslprocessor.valueof(l_analytic, 'DocRefSet/Parm[ParmCode="RRN"]/Value/text()', l_str);
      l_rec.doc_rrn := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Status/RespClass/text()', l_str);
      l_resp_class := substr(l_str,1,100);
      dbms_xslprocessor.valueof(l_analytic, 'Status/RespCode/text()', l_str);
      l_resp_code := substr(l_str,1,100);
      dbms_xslprocessor.valueof(l_analytic, 'Status/RespText/text()', l_str);
      l_resp_text := substr(l_str,1,254);
      if l_resp_class = 'Error' then
        update ow_locpay_match t
           set t.state = 3,
               t.resp_class = l_resp_class,
               t.resp_code = l_resp_code,
               t.resp_text = l_resp_text
        where t.rrn = l_rec.doc_rrn and t.revfile_name = l_oic_filename;

      else
        update ow_locpay_match t
           set t.state = 2,
               t.resp_class = l_resp_class,
               t.resp_code = l_resp_code,
               t.resp_text = l_resp_text
        where t.rrn = l_rec.doc_rrn and t.revfile_name = l_oic_filename;
      end if;

      end loop;

    end if;

  end if;

    --квитовка файла
    update ow_oicrevfiles
     set tick_name = p_filename,
         tick_date = sysdate,
         tick_status = l_status,
         tick_accept_rec = l_acceptrec,
         tick_reject_rec = l_rejectrec
   where file_name = l_oic_filename;
    -- ставим статус
  set_file_status(p_fileid, l_acceptrec + l_rejectrec, l_filestatus, l_msg);

  bars_audit.info(h || 'Finish.');
end iparse_roic_doc_rev;


-------------------------------------------------------------------------------
procedure iparse_cm_mobile_file (p_clob in clob, p_filename in varchar2, p_fileid in number default null)
is
  l_filebody   xmltype;
  l_xml        xmltype;
  c_clientlist varchar2(100) := '/ChangesExportFile/ChangesList/';
  c_client     varchar2(100);
  c_phone      varchar2(100);
  l_rnk        number;
  l_mphone     varchar2(12);
  l_tmp        varchar2(100);
  i number;
  j number;
  l_custtype   customer.custtype%type;
  l_filetype   ow_cl_info_data_error%rowtype;
  l_ismmfo     params$base.val%type := nvl(getglobaloption('IS_MMFO'), '0');

begin

  l_filebody := xmltype(p_clob);

  i := 0;

  loop

     i := i + 1;

     c_client := c_clientlist || 'ChangedItem[' || i || ']/ClientRs/Client';

     -- выход при отсутствии транзакций
     if l_filebody.existsnode(c_client) = 0 then
        exit;
     end if;

     l_xml := xmltype(extract(l_filebody,c_client,null));

     l_rnk := to_number(substr(extract(l_xml, '/Client/ClientInfo/ClientNumber/text()', null), 5));
     if l_ismmfo = '1' then
        l_rnk := to_number(bars_sqnc.rukey(p_key => to_char(l_rnk)));
     end if;
     l_mphone := null;

     j := 0;

     l_filetype.file_name := p_filename;
     l_filetype.rnk       := l_rnk;
     loop

        j := j + 1;

        c_phone := '/Client/PhoneList/Phone[' || j || ']';

        -- выход при отсутствии транзакций
        if l_xml.existsnode(c_phone) = 0 then
           exit;
        end if;

        l_tmp := substr(extract(l_xml, c_phone || '/PhoneType/text()', null),1,100);
        if l_tmp = 'Mobile' then
           l_mphone := substr(extract(l_xml, c_phone || '/PhoneNumber/text()', null), 1, 12);
        end if;

     end loop;
     l_filetype.mphone := l_mphone;
     l_filetype.kf := sys_context('bars_context','user_mfo');
     begin
       select rnk, custtype
         into l_tmp, l_custtype
         from customer
        where rnk = l_rnk;
       kl.setcustomerelement(rnk_ => l_rnk,
                             tag_ => 'MPNO ',
                             val_ => l_mphone,
                             otd_ => 0);
        --Створюємо заявку в СМ при оновленні моб. номера телефону.
        for k in (select w.nd, decode(l_custtype, 3, 3, 8) opertype
                    from accounts a
                   join w4_acc w on a.acc = w.acc_pk and a.rnk = l_rnk)
        loop
         begin
          add_deal_to_cmque(p_nd => k.nd, p_opertype => k.opertype);
         exception
           when others then
             l_filetype.err_text := dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace();
             insert into ow_cl_info_data_error values l_filetype;
         end;
        end loop;

     exception
       when no_data_found then
         l_filetype.err_text := 'Клієнта РНК ' || l_rnk || ' не знайдено';
         insert into ow_cl_info_data_error values l_filetype;
     end;

  end loop;
  set_file_status(p_fileid, i-1, 2, null);

end iparse_cm_mobile_file;

-------------------------------------------------------------------------------
-- parse_file
-- процедура разбора файлов xml
--
procedure parse_file ( p_fileid in number )
is
  l_filetype ow_files.file_type%type;
  l_filename ow_files.file_name%type;
  l_fileblob blob;
  l_fileclob clob;
  l_u        blob;
  l_err      ow_files.err_text%type;
  l_status   number;
  h varchar2(100) := 'bars_ow.parse_file. ';
begin

  bars_audit.info(h || 'Start. p_fileid=>' || p_fileid);

  -- определяем тип файла
  begin
     select file_type, file_name, file_body
       into l_filetype, l_filename, l_fileblob
      from ow_files
     where id = p_fileid;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;
  bars_audit.info(h || 'l_filetype=>' || l_filetype);

  -- разархивируем blob
  if lower(substr(l_filename,-4)) = '.zip' then
     -- zip
     l_u := ow_utl .get_filefromzip(l_fileblob);
  else
     -- gzip
     l_u := utl_compress.lz_uncompress(l_fileblob);
  end if;
  -- преобразуем в clob
  l_fileclob := blob_to_clob(l_u);

  if l_filetype = g_filetype_atrn then
     iparse_oic_atransfers_file (p_fileid, l_fileclob);
  elsif l_filetype = g_filetype_ftrn then
     -- структура atransfers и ftransfers одинаковая, отличаются только алгоритмы оплаты
     iparse_oic_atransfers_file (p_fileid, l_fileclob);
  elsif l_filetype = g_filetype_strn then
     iparse_oic_stransfers_file (p_fileid, l_fileclob);
  elsif l_filetype = g_filetype_doc then
     iparse_oic_documents_file (p_fileid, l_fileclob);
  elsif l_filetype = g_filetype_cng then
     if instr(upper(l_filename), 'CL_INFO') > 0 then
        iparse_cm_mobile_file(l_fileclob, l_filename, p_fileid);
     else
  if instr(upper(l_filename),'_GL_BAL') > 0
        then
        iparse_cng_file_txt (p_fileid, l_fileclob);
        else
        iparse_cng_file (p_fileid, l_fileclob);
  end if;
 end if;
  elsif l_filetype = g_filetype_riic then
     iparse_riic_file (p_fileid, l_filename, l_fileclob);
  elsif l_filetype = g_filetype_roic then
     iparse_roic_doc_rev (p_fileid, l_filename, l_fileclob);

--  elsif l_filetype = g_filetype_rxa then
--     bars_owcrv.parse_rxa_file (p_fileid, l_filename, l_fileclob);
  end if;

  begin
     select file_status into l_status from ow_files where id = p_fileid;
     if l_status <> 0 then
        update ow_files set file_body = empty_blob() where id = p_fileid;
     end if;
  exception when no_data_found then null;
  end;

  bars_audit.info(h || 'Finish.');

exception when others then
  if ( sqlcode = -19202 or sqlcode = -31011 ) then
     l_err := 'Порушено структуру файла';
  else
     l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
              dbms_utility.format_error_backtrace(), 1, 254);
  end if;
  begin
     select file_status into l_status from ow_files where id = p_fileid;
     if l_status <> 3 then
        set_file_status(p_fileid, null, 3, substr('Loading error: ' || l_err, 1, 254));
     end if;
  exception when no_data_found then null;
  end;
  bars_audit.info(h || 'Loading error: ' ||
     dbms_utility.format_error_stack() || chr(10) ||
     dbms_utility.format_error_backtrace());
end parse_file;

-------------------------------------------------------------------------------
-- del_pkkque
-- процедура удаления документа из очереди на отправку в ПЦ
--
procedure del_pkkque ( p_ref number, p_dk number )
is
begin

  for k in (select acc, f_n, resp_class, resp_code, resp_text, drn
              from ow_pkk_que
             where ref = p_ref and dk = p_dk )
  loop
     insert into ow_pkk_history (ref, dk, f_n, acc, resp_class, resp_code, resp_text, drn)
     values (p_ref, p_dk, k.f_n, k.acc, k.resp_class, k.resp_code, k.resp_text, k.drn);

     delete from ow_pkk_que where ref = p_ref and dk = p_dk;
  end loop;

end del_pkkque;

-------------------------------------------------------------------------------
procedure iset_rrn (p_operw_tbl in out t_operw, p_ref in number, p_anl_trndescr in ow_oic_atransfers_data.anl_trndescr%type)
is
begin
  if p_anl_trndescr like '%#RRN%' then
     -- anl_trndescr="#RRN***#Назначение платежа", где *** - значение RRN
     fill_operw_tbl(p_operw_tbl, p_ref, 'OWRRN', substr(p_anl_trndescr, instr(p_anl_trndescr, '#RRN')+4, instr(substr(p_anl_trndescr, instr(p_anl_trndescr, '#RRN')+4), '#')-1));
  end if;
end iset_rrn;

-------------------------------------------------------------------------------
-- ikvt_one
-- доплата с транзита фактических / виза плановых
--
procedure ikvt_one (
  p_atrn     ow_oic_atransfers_data%rowtype,
  p_ref      number,
  p_filename varchar2 )
is
  b_kvt  boolean;
  l_dk   number;
  l_err  varchar2(254);
  l_operw_tbl t_operw := t_operw();
  h varchar2(100) := 'bars_ow.ikvt_one. ';
begin

  bars_audit.trace(h || 'Start: p_ref=>' || to_char(p_ref));

  savepoint sp_bof1;

  begin
     select dk into l_dk from ow_msgcode where synthcode = p_atrn.anl_synthcode;
     final_payment(p_ref, l_dk, b_kvt);
  exception when no_data_found then
     b_kvt := false;
  end;

  -- квитовка документа
  if b_kvt then

     -- доп. реквизиты из файла аналитических проводок
     l_operw_tbl := t_operw();

     if l_dk = 1 then
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_FL', p_filename);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_PD', to_char(p_atrn.anl_postingdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_LD', to_char(p_atrn.doc_localdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_DS', p_atrn.doc_descr);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_AM', to_char(p_atrn.doc_amount) || '/' || p_atrn.doc_currency);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_SC', p_atrn.anl_synthcode);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDRN', to_char(p_atrn.doc_drn));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWARN', p_atrn.anl_analyticrefn);
     else
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWFL2', p_filename);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWPD2', to_char(p_atrn.anl_postingdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWLD2', to_char(p_atrn.doc_localdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDS2', p_atrn.doc_descr);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWAM2', to_char(p_atrn.doc_amount) || '/' || p_atrn.doc_currency);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWSC2', p_atrn.anl_synthcode);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDR2', to_char(p_atrn.doc_drn));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWAR2', p_atrn.anl_analyticrefn);
     end if;
     begin
        forall i in 1 .. l_operw_tbl.count
          insert into operw values l_operw_tbl (i);
     exception
        when others then
          null;
     end;
     -- удаление в архив
     irec_oic_atrn_to_arc(p_atrn, p_ref);

     -- удаление из очереди на отправку/квитовку
     del_pkkque(p_ref, l_dk);

  end if;

  bars_audit.trace(h || 'Finish.');

exception when others then
  if ( sqlcode <= -20000 ) then
     l_err := substr(sqlerrm,1,254);
  else
     l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace(),1,254);
  end if;
  rollback to sp_bof1;
  update ow_oic_atransfers_data
     set err_text = l_err
   where id = p_atrn.id and idn = p_atrn.idn;
end ikvt_one;

-------------------------------------------------------------------------------
-- ikvt_oneontt
-- доплата с транзита документов ВЕБ-Банкинга
--
procedure ikvt_oneontt (
  p_atrn     ow_oic_atransfers_data%rowtype,
  p_ref      number,
  p_id       number,
  p_filename varchar2 )
is
  b_kvt  boolean;
  l_dk   number;
  l_err  varchar2(254);
  l_operw_tbl t_operw := t_operw();
  h varchar2(100) := 'bars_ow.ikvt_oneontt. ';
begin

  bars_audit.trace(h || 'Start: p_ref=>' || to_char(p_ref));

  savepoint sp_bof1;

  begin
     select dk into l_dk from ow_match_tt where code = p_atrn.doc_descr;
     final_payment(p_ref, l_dk, b_kvt, 1);
  exception when no_data_found then
     b_kvt := false;
  end;

  -- квитовка документа
  if b_kvt then

     -- доп. реквизиты из файла аналитических проводок
     l_operw_tbl := t_operw();

     if l_dk = 1 then
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_FL', p_filename);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_PD', to_char(p_atrn.anl_postingdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_LD', to_char(p_atrn.doc_localdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_DS', p_atrn.doc_descr);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_AM', to_char(p_atrn.doc_amount) || '/' || p_atrn.doc_currency);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OW_SC', p_atrn.anl_synthcode);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDRN', to_char(p_atrn.doc_drn));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWARN', p_atrn.anl_analyticrefn);
     else
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWFL2', p_filename);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWPD2', to_char(p_atrn.anl_postingdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWLD2', to_char(p_atrn.doc_localdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDS2', p_atrn.doc_descr);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWAM2', to_char(p_atrn.doc_amount) || '/' || p_atrn.doc_currency);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWSC2', p_atrn.anl_synthcode);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDR2', to_char(p_atrn.doc_drn));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWAR2', p_atrn.anl_analyticrefn);
     end if;
     iset_rrn(l_operw_tbl, p_ref, p_atrn.anl_trndescr);

     forall i in 1 .. l_operw_tbl.count
        insert into operw values l_operw_tbl(i);

     -- удаление в архив
     irec_oic_atrn_to_arc(p_atrn, p_ref);

     -- установка статуса квитовки
     -- mway_mgr.set_state_trans(p_id, 1);
     update mway_match set state = 1 where id = p_id;

  end if;

  bars_audit.trace(h || 'Finish.');

exception when others then
  if ( sqlcode <= -20000 ) then
     l_err := substr(sqlerrm,1,254);
  else
     l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace(),1,254);
  end if;
  rollback to sp_bof1;
  update ow_oic_atransfers_data
     set err_text = l_err
   where id = p_atrn.id and idn = p_atrn.idn;
end ikvt_oneontt;

-------------------------------------------------------------------------------
-- ikvt_oneonlocpay
-- доплата с транзита документов на свободные реквизиты.
--
procedure ikvt_oneonlocpay (
  p_atrn     ow_oic_atransfers_data%rowtype,
  p_ref      number,
  p_filename varchar2 )
is
  b_kvt  boolean;
  l_dk   number :=1;
  l_err  varchar2(254);
  l_operw_tbl t_operw := t_operw();
  h varchar2(100) := 'bars_ow.ikvt_oneonlocpay. ';
begin

  bars_audit.trace(h || 'Start: p_ref=>' || to_char(p_ref));

  savepoint sp_bof1;

     final_payment(p_ref, l_dk, b_kvt, 2);

  -- квитовка документа
  if b_kvt then

     -- доп. реквизиты из файла аналитических проводок
     l_operw_tbl := t_operw();

        fill_operw_tbl(l_operw_tbl, p_ref, 'OWFL2', p_filename);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWPD2', to_char(p_atrn.anl_postingdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWLD2', to_char(p_atrn.doc_localdate, 'dd.MM.yyyy'));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDS2', p_atrn.doc_descr);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWAM2', to_char(p_atrn.doc_amount) || '/' || p_atrn.doc_currency);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWSC2', p_atrn.anl_synthcode);
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWDR2', to_char(p_atrn.doc_drn));
        fill_operw_tbl(l_operw_tbl, p_ref, 'OWAR2', p_atrn.anl_analyticrefn);


     forall i in 1 .. l_operw_tbl.count
        insert into operw values l_operw_tbl(i);

     -- удаление в архив
     irec_oic_atrn_to_arc(p_atrn, p_ref);

     -- установка статуса квитовки
     -- mway_mgr.set_state_trans(p_id, 1);
     update ow_locpay_match set state = decode(state, 0, 10, 11) where ref = p_ref;

  end if;

  bars_audit.trace(h || 'Finish.');

exception when others then
  if ( sqlcode <= -20000 ) then
     l_err := substr(sqlerrm,1,254);
  else
     l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace(),1,254);
  end if;
  rollback to sp_bof1;
  update ow_oic_atransfers_data
     set err_text = l_err
   where id = p_atrn.id and idn = p_atrn.idn;
end ikvt_oneonlocpay;
-------------------------------------------------------------------------------
-- matching_ref
-- процедура ручной квитовки документа:
--   документ из файла ПЦ ATransfers (p_id, p_idn)
--   квитуется с документом АБС p_ref
--
procedure matching_ref (p_id number, p_idn number, p_ref number, p_par number)
is
  l_filename  ow_files.file_name%type;
  l_atrn ow_oic_atransfers_data%rowtype;
  h varchar2(100) := 'bars_ow.matching_ref. ';
begin

  bars_audit.info(h || 'Start:' ||
     ' p_id=>'  || to_char(p_id) ||
     ' p_idn=>' || to_char(p_idn) ||
     ' p_ref=>' || to_char(p_ref));

  begin
     select file_name into l_filename from ow_files where id = p_id;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_id=>' || to_char(p_id));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  begin

     -- если документ удаелен, восстанавливаем его
     if p_par = 0 then
        insert into ow_oic_atransfers_data (id, idn,
               anl_synthcode, anl_trndescr, anl_analyticrefn,
               credit_anlaccount, credit_amount, credit_currency,
               debit_anlaccount, debit_amount, debit_currency,
               anl_postingdate, doc_drn, doc_orn, doc_localdate, doc_descr,
               doc_amount, doc_currency)
        select id, idn,
               anl_synthcode, anl_trndescr, anl_analyticrefn,
               credit_anlaccount, credit_amount, credit_currency,
               debit_anlaccount, debit_amount, debit_currency,
               anl_postingdate, doc_drn, doc_orn, doc_localdate, doc_descr,
               doc_amount, doc_currency
          from ow_oic_atransfers_hist
         where id = p_id and idn = p_idn;
        delete from ow_oic_atransfers_hist where id = p_id and idn = p_idn;
     end if;

     select *
       into l_atrn
       from ow_oic_atransfers_data
      where id = p_id
        and idn = p_idn ;

     ikvt_one (l_atrn, p_ref, l_filename);

  exception when no_data_found then
     bars_audit.info(h || 'Row not found p_id=>' || to_char(p_id) || ' p_idn=>' || to_char(p_idn));
     bars_error.raise_nerror(g_modcode, 'FILEREC_NOT_FOUND');
  end;

  bars_audit.info(h || 'Finish.');

end matching_ref;

-------------------------------------------------------------------------------
-- payment_ref
-- процедура принудительной оплаты документа, отправленного в ПЦ
--   (без квитовки, не дожидаясь подтверждения из ПЦ)
--
procedure payment_ref (p_ref number, p_dk number)
is
  i number;
  b_kvt boolean;
  h varchar2(100) := 'bars_ow.payment_ref. ';
begin

  bars_audit.info(h || 'Start: p_ref=>' || to_char(p_ref) || ' p_dk=>' || to_char(p_dk));

  begin
     select 1 into i from ow_pkk_que where ref = p_ref and dk = p_dk and sos = 1;
  exception when no_data_found then
     bars_audit.info(h || 'Referens ' || to_char(p_ref) || '(' || to_char(p_dk) || ') not sending to Way4');
     bars_error.raise_nerror(g_modcode, 'REF_NOT_SENDING');
  end;

  -- оплата по факту/доплата документа
  final_payment(p_ref, p_dk, b_kvt);

  if b_kvt then

     -- доп. реквизит
     set_operw(p_ref, 'OW_FL', 'Ручная оплата');

     -- удаление из очереди на отправку/квитовку
     del_pkkque(p_ref, p_dk);

  end if;

  bars_audit.info(h || 'Finish.');

end payment_ref;

-------------------------------------------------------------------------------
-- delete_tran
-- процедура удаления транзакции из файла в архив без оплаты в АБС
--
procedure delete_tran (p_id number, p_idn number)
is
  l_atrn  ow_oic_atransfers_data%rowtype;
  l_strn  ow_oic_stransfers_data%rowtype;
  l_doc   ow_oic_documents_data%rowtype;
  l_filetype varchar2(100);
  h varchar2(100) := 'bars_ow.delete_tran. ';
begin

  bars_audit.info(h || 'Start: p_id=>' || to_char(p_id) || ' p_idn=>' || to_char(p_idn));

  -- определяем тип файла
  begin
     select file_type into l_filetype from ow_files where id = p_id;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_id=>' || to_char(p_id));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  bars_audit.info(h || 'l_filetype=>' || l_filetype);

  if l_filetype in (g_filetype_atrn, g_filetype_ftrn) then

     begin
        select *
          into l_atrn
          from ow_oic_atransfers_data
         where id = p_id and idn = p_idn;
     exception when no_data_found then
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
     end;

     irec_oic_atrn_to_arc(l_atrn, null);

  elsif l_filetype = g_filetype_strn then

     begin
        select *
          into l_strn
          from ow_oic_stransfers_data
         where id = p_id and idn = p_idn;
     exception when no_data_found then
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
     end;

     irec_oic_strn_to_arc(l_strn, null);

  elsif l_filetype = g_filetype_doc then

     begin
        select *
          into l_doc
          from ow_oic_documents_data
         where id = p_id and idn = p_idn;
     exception when no_data_found then
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
     end;

     irec_oic_doc_to_arc(l_doc, null);

  end if;

  bars_audit.info(h || 'Finish.');

end delete_tran;

-------------------------------------------------------------------------------
-- ikvt_cardpaymant
-- процедура квитовки документов по файлу oic_atransfers
--
procedure ikvt_cardpayment (p_id number, p_filename varchar2)
is
  h varchar2(100) := 'bars_ow.ikvt_cardpayment. ';

  --------------------------
  procedure kvt_on_synthcode
  is
     l_atrn   t_atrn;
     l_ref    number;
     y number := 0;
     l varchar2(100) := 'bars_ow.kvt_on_synthcode. ';
  begin

     -- PTBACA - операция пополнения с комиссией
     -- PFBACA - операция списания
     -- PABACA - операция пополнения без комиссии
     select *
       bulk collect
       into l_atrn
       from ow_oic_atransfers_data a
      where id = p_id
         -- обрабатываем операции пополнения/списания, инициированные банком
        and exists ( select 1 from ow_msgcode where synthcode  = a.anl_synthcode )
      order by anl_synthcode desc ;

     bars_audit.info(l || 'l_atrn.count=>' || l_atrn.count);

     for i in 1..l_atrn.count loop

        if l_atrn(i).doc_drn is not null then

           -- ищем документ в списке несквитованных документов
           begin
              select ref into l_ref from ow_pkk_que where drn = l_atrn(i).doc_drn;
           exception when no_data_found then
              l_ref := null;
           end;

           -- нашли - квитуем
           if l_ref is not null then

              ikvt_one(l_atrn(i), l_ref, p_filename);

           -- не нашли
           else

              -- ищем документ в списке сквитованных (вручную) документов
              begin
                 select ref into l_ref from ow_pkk_history where drn = l_atrn(i).doc_drn;
              exception when no_data_found then
                 l_ref := null;
              end;

              -- нашли - удаляем строчку в архив без квитовки, т.к. документ уже сквитован
              if l_ref is not null then
                 irec_oic_atrn_to_arc(l_atrn(i), l_ref);
              -- не нашли - бьем тревогу
              else
                 update ow_oic_atransfers_data
                    set err_text = 'Не знайдено документ з DRN=' || to_char(l_atrn(i).doc_drn)
                  where id = l_atrn(i).id and idn = l_atrn(i).idn;
              end if;

           end if;

        else

           update ow_oic_atransfers_data
              set err_text = 'Не заповнено DRN'
            where id = l_atrn(i).id and idn = l_atrn(i).idn;

        end if;

        y := y + 1;
        if y > 100 then commit; y := 0; end if;

     end loop;

  end kvt_on_synthcode;

  -------------------
  procedure kvt_on_tt
  is
     l_atrn   t_atrn;
     l_ref    number;
     l_id     number;
     y number := 0;
     l varchar2(100) := 'bars_ow.kvt_on_tt. ';
  begin

     select *
       bulk collect
       into l_atrn
       from ow_oic_atransfers_data a
      where id = p_id
         -- обрабатываем операции пополнения/списания, инициированные 3-ей системой (ВЕБ-Банкинг)
        and exists ( select 1 from ow_match_tt where code = a.doc_descr and tt is not null )
         -- только по карточным счетам
         -- исключаем документы погашения задолженности по кредиту
        and ( (substr(debit_anlaccount,1,4)  in (select unique nbs from w4_nbs_ob22) and not regexp_like (credit_anlaccount,'^NLS_(((220|357)[0-9])|(6[0-9]{3})|9129|9900)_(2625|2620)+'))
           or (substr(credit_anlaccount,1,4) in (select unique nbs from w4_nbs_ob22) and not regexp_like (debit_anlaccount,'^NLS_(((220|357)[0-9])|(6[0-9]{3})|9129|9900)_(2625|2620)+')));

     bars_audit.info(l || 'l_atrn.count=>' || l_atrn.count);

     for i in 1..l_atrn.count loop

        -- ищем документ в списке несквитованных документов
        begin
           select q.id, q.ref_tr into l_id, l_ref
             from mway_match q, oper o, ow_match_tt t, tabval$global v,
                  accounts a -- COBUMMFO-7501
            where q.state  = 0
              and q.ref_tr = o.ref
              and o.sos    = 5
              and o.tt     = t.tt
              and t.code   = l_atrn(i).doc_descr
              -- and q.nls_tr = decode(t.dk, 0, l_atrn(i).debit_anlaccount, l_atrn(i).credit_anlaccount) -- Comment COBUMMFO-7501
              and q.nls_tr in (a.nls, a.nlsalt) -- Comment COBUMMFO-7501
              and decode(t.dk, 0, l_atrn(i).debit_anlaccount, l_atrn(i).credit_anlaccount) in (a.nls, a.nlsalt) -- Comment COBUMMFO-7501
              and q.lcv_tr = v.lcv and v.kv = decode(t.dk, 0, l_atrn(i).debit_currency, l_atrn(i).credit_currency)
              and q.sum_tr = decode(t.dk, 0, l_atrn(i).debit_amount, l_atrn(i).credit_amount) * 100
              and trunc(q.date_tr) = l_atrn(i).doc_localdate
              and rownum = 1;
        exception when no_data_found then
           l_ref := null;
        end;

        -- нашли - квитуем
        if l_ref is not null then

           ikvt_oneontt(l_atrn(i), l_ref, l_id, p_filename);

        -- не нашли
        else

           update ow_oic_atransfers_data
              set err_text = 'Не знайдено документ в АБС'
            where id = l_atrn(i).id and idn = l_atrn(i).idn;

        end if;

        y := y + 1;
        if y > 100 then commit; y := 0; end if;

     end loop;

  end kvt_on_tt;

  -------------------
  procedure kvt_on_locpay
  is
     l_atrn   t_atrn;
     l_ref    number;
     y number := 0;
     l varchar2(100) := 'bars_ow.kvt_on_tt. ';
  begin

     select *
       bulk collect
       into l_atrn
       from ow_oic_atransfers_data a
      where id = p_id
         -- только по карточным счетам
         -- исключаем документы погашения задолженности по кредиту
        and (credit_anlaccount = 'NLS_LOCPAY');

     bars_audit.info(l || 'l_atrn.count=>' || l_atrn.count);

     for i in 1..l_atrn.count loop

        -- ищем документ в списке несквитованных документов
        begin
           select q.ref into l_ref
             from ow_locpay_match q, oper o
            where q.state  in(0, 2)
              and q.ref = o.ref
              and o.sos    in(0, 5)
              and q.drn = l_atrn(i).doc_drn
              and rownum = 1;
        exception when no_data_found then
           l_ref := null;
        end;

        -- нашли - квитуем
        if l_ref is not null then

           ikvt_oneonlocpay(l_atrn(i), l_ref,  p_filename);

        -- не нашли
        else

           update ow_oic_atransfers_data
              set err_text = 'Не знайдено документ в АБС'
            where id = l_atrn(i).id and idn = l_atrn(i).idn;

        end if;

        y := y + 1;
        if y > 100 then commit; y := 0; end if;

     end loop;

  end kvt_on_locpay;
begin

  bars_audit.info(h || 'Start.');

  -- 1. Квитовка документов, инициированных Банком
  kvt_on_synthcode;

  -- 2. Квитовка документов, инициируемых 3-ей системой (ВЕБ-Банкинг)
  --    (веббанкинг порождает документ в барсе и отправляет документ в ПЦ,
  --     при получении файла из ПЦ мы должны сопоставить документ в барсе с документом из файла)
  kvt_on_tt;

  -- 3. Квитовка документов по платежам на свободные реквизиты

  kvt_on_locpay;

  bars_audit.info(h || 'Finish.');

end ikvt_cardpayment;


function get_branch_ondrn_cardpay (p_dat date, p_drn number) return varchar2
is
   l_branch varchar2(30);
begin
   begin
      select max(a.branch)
        into l_branch
        from accounts a,
             ( select case
                         when t.debit_anlaccount like tt.mask
                           or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.debit_anlaccount
                         when t.credit_anlaccount like tt.mask
                           or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.credit_anlaccount
                         when substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.debit_anlaccount,instr(t.debit_anlaccount,'_',-1)+1)
                         when substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.credit_anlaccount,instr(t.credit_anlaccount,'_',-1)+1)
                      end nls, t.kf
                 from ow_files f, ow_oic_atransfers_data t, ow_trans_mask tt
                where f.id = t.id
                  and ( t.debit_anlaccount like tt.mask
                     or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22)
                     or t.credit_anlaccount like tt.mask
                     or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) )
                  and trunc(f.file_date) = p_dat
                  and t.doc_drn = p_drn
               union all
               select case
                         when t.debit_anlaccount like tt.mask
                           or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.debit_anlaccount
                         when t.credit_anlaccount like tt.mask
                           or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.credit_anlaccount
                         when substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.debit_anlaccount,instr(t.debit_anlaccount,'_',-1)+1)
                         when substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.credit_anlaccount,instr(t.credit_anlaccount,'_',-1)+1)
                      end nls, t.kf
                 from ow_files f, ow_oic_atransfers_hist t, ow_trans_mask tt
                where f.id = t.id
				  and t.kf = sys_context('bars_context','user_mfo')
                  and ( t.debit_anlaccount like tt.mask
                     or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22)
                     or t.credit_anlaccount like tt.mask
                     or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) )
                  and trunc(f.file_date) = p_dat
                  and t.doc_drn = p_drn  ) t
       where a.nls = t.nls and a.kf = t.kf;
   exception when no_data_found then
      l_branch := null;
   end;
   return l_branch;
end get_branch_ondrn_cardpay;

-------------------------
function get_branch_onorn_cardpay (p_dat date, p_orn number) return varchar2
is
   l_branch varchar2(30);
begin
   begin
      select max(a.branch)
        into l_branch
        from accounts a,
             ( select case
                         when t.debit_anlaccount like tt.mask
                           or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.debit_anlaccount
                         when t.credit_anlaccount like tt.mask
                           or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.credit_anlaccount
                         when substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.debit_anlaccount,instr(t.debit_anlaccount,'_',-1)+1)
                         when substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.credit_anlaccount,instr(t.credit_anlaccount,'_',-1)+1)
                      end nls, t.kf
                 from ow_files f, ow_oic_atransfers_data t, ow_trans_mask tt
                where f.id = t.id
				  and t.kf = sys_context('bars_context','user_mfo')				
                  and ( t.debit_anlaccount like tt.mask
                     or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22)
                     or t.credit_anlaccount like tt.mask
                     or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) )
                  and trunc(f.file_date) = p_dat
                  and t.doc_orn = p_orn
               union all
               select case
                         when t.debit_anlaccount like tt.mask
                           or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.debit_anlaccount
                         when t.credit_anlaccount like tt.mask
                           or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22) then t.credit_anlaccount
                         when substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.debit_anlaccount,instr(t.debit_anlaccount,'_',-1)+1)
                         when substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) then substr(t.credit_anlaccount,instr(t.credit_anlaccount,'_',-1)+1)
                      end nls, t.kf
                 from ow_files f, ow_oic_atransfers_hist t, ow_trans_mask tt
                where f.id = t.id
                  and ( t.debit_anlaccount like tt.mask
                     or substr(t.debit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.debit_anlaccount, instr(t.debit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22)
                     or t.credit_anlaccount like tt.mask
                     or substr(t.credit_anlaccount,1,4) in (select nbs from w4_nbs_ob22)
                     or substr(t.credit_anlaccount, instr(t.credit_anlaccount,'_',-1)+1,4) in (select nbs from w4_nbs_ob22) )
                  and trunc(f.file_date) = p_dat
                  and t.doc_orn = p_orn  ) t
       where a.nls = t.nls and a.kf = t.kf;
   exception when no_data_found then
      l_branch := null;
   end;
   return l_branch;
end get_branch_onorn_cardpay;

-----------------------
function get_nls_on2625_cardpay (p_nls varchar2, p_kv number, p_pk_acc number) return varchar2
is
   l_nls     varchar2(100) := null;
   l_acc     number;
   l_nls_tip varchar2(20);
   l_trmask  t_trmask;
   l_sql     varchar2(4000);  
begin

   if p_nls like 'NLS\_%\_%' escape '\' and p_pk_acc is not null then
      begin 
        select * into l_trmask from OW_TRANSNLSMASK t where p_nls like mask||'%';

        --l_nls_tip := substr(replace(p_nls,'NLS_',''),1,instr(replace(p_nls,'NLS_',''),'_')-1);


      
  /*      begin
         select decode(l_nls_tip,
                '2202',  w.acc_ovr,
                '2203',  w.acc_ovr,
                '2062',  w.acc_ovr,
                '2063',  w.acc_ovr,
                '2208',  w.acc_2208,
                '2068',  w.acc_2208,
                '3570',  w.acc_3570,
                '2628',  w.acc_2628,
                '2608',  w.acc_2628,
                '2658',  w.acc_2628,
                '2528',  w.acc_2628,
                '2548',  w.acc_2628,
                '2627',  w.acc_2627,
                '2607',  w.acc_2627,
                '2657',  w.acc_2627,
                '2627X', w.acc_2627X,
                '2625D', w.acc_2625D,
                '2207',  w.acc_2207,
                '2067',  w.acc_2207,
                '2209',  w.acc_2209,
                '2069',  w.acc_2209,
                '3579',  w.acc_3579,
                '9129',  w.acc_9129, null)
           into l_acc
           from w4_acc w
          where w.acc_pk = p_pk_acc;
      exception when no_data_found then
         bars_error.raise_nerror(g_modcode, 'W4ACC_NOT_FOUND', p_pk_acc);
        end;*/
        l_sql :='select '||l_trmask.a_w4_acc||' from w4_acc w where w.acc_pk = :p_pk_acc';
        begin
          execute immediate l_sql
             into l_acc
            using p_pk_acc;
        exception when no_data_found then
           bars_error.raise_nerror(g_modcode, 'W4ACC_NOT_FOUND', p_pk_acc);
      end;
      -- открываем счет
      if l_acc is null then
           open_acc(p_pk_acc, l_trmask, l_acc);
      end if;

      begin
         select nls into l_nls from accounts where acc = l_acc;
      exception when no_data_found then
         l_nls := null;
      end;
      exception
        when no_data_found then
          l_nls := null;
      end; 
   end if;

   return l_nls;

end get_nls_on2625_cardpay;

-----------------------
function get_nls_on2625_cardpay (p_nls varchar2, p_kv number) return varchar2
is
   l_nls    varchar2(14) := null;
   l_pk_nls varchar2(30);
   l_pk_acc number;
begin

   -- счет NLS_BBBB_2625
   if p_nls like 'NLS\_%\_%' escape '\' then

      -- счет 2625
      l_pk_nls := substr(p_nls, instr(p_nls,'_',-1)+1);

      -- ищем счет 2625
      if l_pk_nls is not null then
         begin
			-- COBUMMFO-7501
            select acc
            into l_pk_acc
            from (
                    select a.acc
                    from accounts a
                    where (a.nls = l_pk_nls or a.nlsalt = l_pk_nls ) and a.kv = p_kv  and a.dazs is null
                    order by a.daos
                 )
             where rownum = 1;
         exception when no_data_found then
            l_pk_acc := null;
         end;
      end if;

      -- находим счет
      if l_pk_acc is not null then
         l_nls := get_nls_on2625_cardpay(p_nls, p_kv, l_pk_acc);
      end if;

   end if;

   return l_nls;

end get_nls_on2625_cardpay;

---------------------
function get_nls_3800_cardpay (p_dat date, p_drn number, p_orn number) return varchar2
is
   l_nls accounts.nls%type;
begin
   if p_orn is not null then
      begin
         -- поиск по doc_orn
         select a.nls into l_nls
           from ow_files f, ow_oic_atransfers_hist t, opldok p, accounts a
          where f.id = t.id
            and trunc(f.file_date) = p_dat
            and t.doc_orn = p_orn
            and t.ref = p.ref
            and p.acc = a.acc
            and a.nbs = '3800'
            and rownum = 1;
      exception when no_data_found then
         l_nls := null;
      end;
   end if;
   if l_nls is null and p_drn is not null then
      begin
         -- поиск по doc_drn
         select a.nls into l_nls
           from ow_files f, ow_oic_atransfers_hist t, opldok p, accounts a
          where f.id = t.id
            and trunc(f.file_date) = p_dat
            and t.doc_drn = p_drn
            and t.ref = p.ref
            and p.acc = a.acc
            and a.nbs = '3800'
            and rownum = 1;
      exception when no_data_found then
         l_nls := null;
      end;
   end if;
   return l_nls;
end get_nls_3800_cardpay;

---------------------
function get_nls_3801_cardpay (
  p_nls      varchar2,
  p_dat      date,
  p_drn      number,
  p_orn      number,
  p_currency number,
  p_branch   varchar2 ) return varchar2
is
   l_kv      number := null;
   l_nls3800 accounts.nls%type := null;
   l_nls3801 accounts.nls%type := null;
   l_branch  varchar2(30) := null;
begin

   -- валюта известна
   if nvl(p_currency,980) <> 980 then
      l_kv := p_currency;
   end if;

   -- валюта неизвестна, пробуем найти ее по 3800 операции
   if l_kv is null and p_orn is not null then
      begin
         select credit_currency into l_kv
           from ow_oic_atransfers_hist
          where doc_orn = p_orn
            and credit_anlaccount like 'NLS_3800%'
            and rownum = 1;
      exception when no_data_found then
         begin
            select debit_currency into l_kv
              from ow_oic_atransfers_hist
             where doc_orn = p_orn
               and debit_anlaccount like 'NLS_3800%'
               and rownum = 1;
         exception when no_data_found then
            l_kv := null;
         end;
      end;
   end if;

   -- не нашли валюту по операции, пробуем найти ее по документу
   if l_kv is null and p_drn is not null then
      begin
         select credit_currency into l_kv
           from ow_oic_atransfers_hist
          where doc_drn = p_drn
            and credit_anlaccount like 'NLS_3800%'
            and rownum = 1;
      exception when no_data_found then
         begin
            select debit_currency into l_kv
              from ow_oic_atransfers_hist
             where doc_drn = p_drn
               and debit_anlaccount like 'NLS_3800%'
               and rownum = 1;
         exception when no_data_found then
            l_kv := null;
         end;
      end;
   end if;

   -- валюта известна, ищем счет 3800
   if l_kv is not null then
      -- счет 3800 известен
      if g_nls3800 is not null then
         l_nls3800 := g_nls3800;
      end if;
      -- ищем счет по уже сформированному документу по 3800
      if l_nls3800 is null then
         l_nls3800 := get_nls_3800_cardpay(p_dat, p_drn, p_orn);
      end if;
      -- счет 3800 не нашли, пробуем определить бранч
      if l_nls3800 is null then
         if p_branch is not null then
            l_branch := p_branch;
         end if;
         -- ищем бранч по drn
         if l_branch is null and p_drn is not null then
            l_branch := get_branch_ondrn_cardpay(p_dat, p_drn);
         end if;
         -- ищем бранч по orn
         if l_branch is null and p_orn is not null then
            l_branch := get_branch_onorn_cardpay(p_dat, p_orn);
         end if;
         if l_branch is not null then
            begin
               select nls into l_nls3800
                 from accounts
                where nbs = '3800'
                   -- ОБ22 у 3800 и 3801 совпадают
                  and ob22 = substr(p_nls,-2)
                  and kv = l_kv
                  and branch = substr(p_branch,1,15)
                  and dazs is null
                  and rownum = 1;
            exception when no_data_found then
               l_nls3800 := null;
            end;
         end if;
      end if;
   end if;

   -- есть 3800, определяем 3801 по указанной валюте
   if l_nls3800 is not null and l_kv is not null then
      begin
         select b.nls into l_nls3801
           from vp_list v, accounts a, accounts b
          where v.acc3800 = a.acc
            and v.acc3801 = b.acc
            and a.nls = l_nls3800 and a.kv = l_kv;
      exception when no_data_found then
         l_nls3801 := null;
      end;
   end if;

   return l_nls3801;

end get_nls_3801_cardpay;

----------------
function get_nls_cardpay (
   p_dat date,
   p_drn number,
   p_orn number,
   p_nls varchar2,
   p_kv  number,
     --  p_synthcode - код синт.проводки для определения бранча, используется только из pay_others
   p_synthcode varchar2 default null,
     -- p_currency - валюта документа для счета 3801/980, используется только из pay_others
   p_currency  number default null ) return varchar2
is
   l_branch  varchar2(30) := null;
   l_nls     varchar2(30) := null;
   --l_nls3800 ow_params.val%type := null;
   l_pk_nls  varchar2(30);
   l_pk_acc  number;
   l_newnb t_newnb;
begin

   -- 1. счет NLS_BBBB_2625
   if p_nls like 'NLS\_%\_%' escape '\' then

      -- счет 2625
      l_pk_nls := substr(p_nls, instr(p_nls,'_',-1)+1);

      -- ищем счет 2625
      if l_pk_nls is not null then
         begin
			-- COBUMMFO-7501
            select acc
            into l_pk_acc
            from (
                    select a.acc
                    from accounts a
                    where (a.nls = l_pk_nls or a.nlsalt = l_pk_nls ) and a.kv = p_kv and a.dazs is null
                    order by a.daos
                 )
             where rownum = 1;
         exception when no_data_found then
            l_pk_acc := null;
         end;
      end if;

      -- находим счет
      if l_pk_acc is not null then
         l_nls := get_nls_on2625_cardpay(p_nls, p_kv, l_pk_acc);
      end if;

   -- 2. если нужно искать счет по формуле
   elsif substr(p_nls,1,3) = 'NLS' then

      -- ищем бранч по drn
      if p_drn is not null then
         l_branch := get_branch_ondrn_cardpay(p_dat, p_drn);
      end if;
      -- ищем бранч по orn
      if l_branch is null and p_orn is not null then
         l_branch := get_branch_onorn_cardpay(p_dat, p_orn);
      end if;

      -- ищем бранч по операции и маске счета (для кодов 'KABABA', 'DABABA' бранч 000000)
      if l_branch is null then
         begin
            select branch into l_branch from ow_comis_mask where synthcode = p_synthcode and p_nls like nls_mask;
         exception when no_data_found then
            l_branch := null;
         end;
      end if;

      -- 2.1 если бранч не нашли, счет определить не сможем
      if l_branch is null then

         l_nls := null;

      -- 2.2 определяем счет NLS_3801OO (можно определить, если известна валюта документа)
      elsif p_nls like 'NLS_3801%' then

         l_nls := get_nls_3801_cardpay(p_nls, p_dat, p_drn, p_orn, p_currency, l_branch);

        --2.2.1 определяем счет NLS_9900 (если зашол по маске NLS_9900)
      elsif p_nls like 'NLS_9900%' then

            l_nls := g_nls9900;
      -- 2.3 определяем счет NLS_BBBBOO (BBBB - НБС, OO - ОБ22)
      else
         if newnbs.g_state = 1 then
            l_newnb := get_new_nbs_ob22(substr(p_nls,5,4), substr(p_nls,-2));
            l_nls := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, l_branch);
         else
            l_nls := nbs_ob22_null(substr(p_nls,5,4), substr(p_nls,-2), l_branch);
         end if;

      end if;

   -- 3. счет в нормальном виде
   else

      l_nls := p_nls;

   end if;

   return l_nls;

end get_nls_cardpay;

-----------------
-- для pay_others
procedure get_nls_cardpay (
   p_dat  in  date,
   p_atrn in  ow_oic_atransfers_data%rowtype,
   p_nlsa out varchar2,
   p_nlsb out varchar2 )
is
   l_branch varchar2(30) := null;
   l_nls    varchar2(30) := null;
   l_kv     number := null;
   l_newnb t_newnb;
begin

   p_nlsa := null;
   p_nlsb := null;

   -- счет в нормальном виде
   if p_atrn.debit_anlaccount not like 'NLS%' then
      p_nlsa := p_atrn.debit_anlaccount;
   -- счет NLS_3801OO
   elsif p_atrn.debit_anlaccount like 'NLS_3801%' then
      p_nlsa := get_nls_3801_cardpay(p_atrn.debit_anlaccount, p_dat, p_atrn.doc_drn, p_atrn.doc_orn, p_atrn.doc_currency, l_branch);
   end if;

   -- счет в нормальном виде
   if p_atrn.credit_anlaccount not like 'NLS%' then
      p_nlsb := p_atrn.credit_anlaccount;
   -- счет NLS_3801OO
   elsif p_atrn.credit_anlaccount like 'NLS_3801%' then
      p_nlsb := get_nls_3801_cardpay(p_atrn.credit_anlaccount, p_dat, p_atrn.doc_drn, p_atrn.doc_orn, p_atrn.doc_currency, l_branch);
   end if;

   if p_nlsa is null or p_nlsb is null then

      -- по DRN уже есть функция
      if p_atrn.doc_drn is not null or p_atrn.doc_orn is not null then

         -- передаем код синт.проводки для определения бранча
         if p_nlsa is null then
            p_nlsa := get_nls_cardpay(p_dat, p_atrn.doc_drn, p_atrn.doc_orn, p_atrn.debit_anlaccount,  p_atrn.debit_currency,  p_atrn.anl_synthcode, p_atrn.doc_currency);
         end if;
         if p_nlsb is null then
            p_nlsb := get_nls_cardpay(p_dat, p_atrn.doc_drn, p_atrn.doc_orn, p_atrn.credit_anlaccount, p_atrn.credit_currency, p_atrn.anl_synthcode, p_atrn.doc_currency);
         end if;

      -- DRN пусто
      else

         -- определяем нормальный счет, по которому потом определим бранч
         if p_atrn.debit_anlaccount not like 'NLS%' then
            l_nls := p_atrn.debit_anlaccount;
            l_kv  := p_atrn.debit_currency;
         elsif p_atrn.credit_anlaccount not like 'NLS%' then
            l_nls := p_atrn.credit_anlaccount;
            l_kv  := p_atrn.credit_currency;
         end if;

         -- определяем бранч
         if l_nls is not null then
            begin
               select tobo into l_branch
                 from accounts
                where nls = l_nls and kv = l_kv;
            exception when no_data_found then
               l_branch := null;
            end;
         end if;

         -- ищем бранч по операции и маске счета (для кодов 'KABABA', 'DABABA' бранч 000000)
         if l_branch is null then
            begin
               select branch into l_branch from ow_comis_mask where synthcode = p_atrn.anl_synthcode and p_atrn.debit_anlaccount like nls_mask;
            exception when no_data_found then
               begin
                  select branch into l_branch from ow_comis_mask where synthcode = p_atrn.anl_synthcode and p_atrn.credit_anlaccount like nls_mask;
               exception when no_data_found then
                  l_branch := null;
               end;
            end;
         end if;

         -- по бранчу ищем счета
         if l_branch is not null then

            if p_nlsa is null then
               l_nls := p_atrn.debit_anlaccount;
               -- счет NLS_3801OO
               if l_nls like 'NLS_3801%' then
                  p_nlsa := get_nls_3801_cardpay(l_nls, p_dat, p_atrn.doc_drn, p_atrn.doc_orn, p_atrn.doc_currency, l_branch);
               -- счет NLS_BBBBOO (BBBB - НБС, OO - ОБ22)
               elsif l_nls like 'NLS%' then
                  if newnbs.g_state = 1 then
                     l_newnb := get_new_nbs_ob22(substr(l_nls,5,4), substr(l_nls,-2));
                     p_nlsa := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, l_branch);
                  else
                     p_nlsa := nbs_ob22_null(substr(l_nls,5,4), substr(l_nls,-2), l_branch);
                  end if;
               -- нормальный счет - оставляем как есть
               end if;
            end if;

            if p_nlsb is null then
               l_nls := p_atrn.credit_anlaccount;
               -- счет NLS_3801OO
               if l_nls like 'NLS_3801%' then
                  p_nlsb := get_nls_3801_cardpay(l_nls, p_dat, p_atrn.doc_drn, p_atrn.doc_orn, p_atrn.doc_currency, l_branch);
               -- счет NLS_BBBBOO (BBBB - НБС, OO - ОБ22)
               elsif l_nls like 'NLS%' then
                  if newnbs.g_state = 1 then
                     l_newnb := get_new_nbs_ob22(substr(l_nls,5,4), substr(l_nls,-2));
                     p_nlsb := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, l_branch);
                  else
                     p_nlsb := nbs_ob22_null(substr(l_nls,5,4), substr(l_nls,-2), l_branch);
                  end if;
               -- нормальный счет - оставляем как есть
               end if;
            end if;

         end if;

      end if;

   end if;

end get_nls_cardpay;

-----------------
-- для pay_2625
procedure get_nls_cardpay (
   p_nlsa     in out varchar2,
   p_kva      in     number,
   p_nlsb     in out varchar2,
   p_kvb      in     number,
   p_dat      in     date,
   p_drn      in     number,
   p_orn      in     number,
   p_currency in     number )
is
   l_pk_nls    varchar2(14) := null;
   l_pk_kv     number;
   l_pk_acc    number := null;
   l_pk_branch varchar2(30);
   l_nbs       varchar2(4);
   l_newnb t_newnb;

   function get_nls_side2 (p_nls varchar2, p_kv number) return varchar2
   is
      l_nls varchar2(100);
   begin

      -- счет NLS_TRANS
 if p_nls = 'NLS_TRANS' or p_nls = 'NLS_2924016CK' then

         l_nls := get_transit(l_pk_acc,1);

      elsif  p_nls = 'NLS_LOCPAY_FEE' then

         l_nls :=  GetGlobalOption('NLS_292427_LOCPAYFEE');
      elsif p_nls = 'NLS_LOCPAY' then
         l_nls :=  GetGlobalOption('NLS_292427_LOCPAY');
      -- счет NLS_9900
      elsif p_nls = 'NLS_9900' then

         if g_nls9900 is not null then
            l_nls := g_nls9900;
         else
            begin
               select val into l_nls
                 from branch_parameters
                where tag    = 'NLS_9900'
                  and branch = l_pk_branch;
            exception when no_data_found then
               l_nls := null;
            end;
         end if;

      -- счет NLS_%_2625%
      elsif p_nls like 'NLS\_%\_%' escape '\' then

         l_nls := get_nls_on2625_cardpay(p_nls, p_kv, l_pk_acc);

      -- счет NLS_3801OO
      elsif p_nls like 'NLS_3801%' then

         l_nls := get_nls_3801_cardpay(p_nls, p_dat, p_drn, p_orn, p_currency, l_pk_branch);

      -- счет NLS_BBBBOO (BBBB - НБС, OO - ОБ22)
      elsif p_nls like 'NLS%' then
         if newnbs.g_state = 1 then
            l_newnb := get_new_nbs_ob22(substr(p_nls,5,4), substr(p_nls,-2));
            l_nls := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, l_pk_branch);
         else
            l_nls := nbs_ob22_null(substr(p_nls,5,4), substr(p_nls,-2), l_pk_branch);
         end if;

         begin
           for i in (select *
                       from accounts t
                      where t.nls = l_nls and nvl(t.opt, 0) <> 1 and t.dazs is null and pap = 3
                        for update nowait)
           loop
             update accounts t set t.opt = 1 where t.nls = l_nls;
             exit;
           end loop;
         exception
           when others then
             null;
         end;
      -- счет в нормальном виде
      else

         l_nls := p_nls;

      end if;

      return l_nls;

   end;

begin

   -- определяем счет 2625
   begin
      select unique nbs into l_nbs from w4_nbs_ob22 where nbs = substr(p_nlsa,1,4);
      l_pk_nls := p_nlsa;
      l_pk_kv  := p_kva;
   exception when no_data_found then
      begin
         select unique nbs into l_nbs from w4_nbs_ob22 where nbs = substr(p_nlsb,1,4);
         l_pk_nls := p_nlsb;
         l_pk_kv  := p_kvb;
      exception when no_data_found then
         if p_nlsa like 'NLS\_%\_%' escape '\' then
            l_pk_nls := substr(p_nlsa, instr(p_nlsa,'_',-1)+1);
            l_pk_kv  := p_kva;
         elsif p_nlsb like 'NLS\_%\_%' escape '\' then
            l_pk_nls := substr(p_nlsb, instr(p_nlsb,'_',-1)+1);
            l_pk_kv  := p_kvb;
         end if;
      end;
   end;

   -- ищем счет 2625
   if l_pk_nls is not null then
      begin
         /* Comment COBUMMFO-7501
          select acc, tobo into l_pk_acc, l_pk_branch
          from accounts
          where nls = l_pk_nls and kv = l_pk_kv;*/
         -- COBUMMFO-7501
         select acc, tobo
         into l_pk_acc, l_pk_branch
         from (
                 select a.acc, a.tobo
                 from accounts a
                 where (a.nls = l_pk_nls or a.nlsalt = l_pk_nls ) and a.kv = l_pk_kv and a.dazs is null
                 order by a.daos
              )
         where rownum = 1;
      exception when no_data_found then
         l_pk_acc := null;
         l_pk_branch := null;
      end;
   end if;

   -- определяем счета
   if l_pk_acc is not null then
      p_nlsa := get_nls_side2(p_nlsa, p_kva);
      p_nlsb := get_nls_side2(p_nlsb, p_kvb);
   end if;

end get_nls_cardpay;

-------------------------------
-- для pay_multicurrency
procedure get_nls_multicurrency_cardpay (
   p_dat    in     date,
   p_drn    in     number,
   p_orn    in     number,
   p_nlsa   in out varchar2,
   p_kv1    in     number,
   p_nlsb   in out varchar2,
   p_kv2    in     number,
   p_branch    out varchar2 )
is
  --l_nls    varchar(14) := null;
  l_branch varchar2(30) := null;
  l_newnb t_newnb;
begin

   -- в счете-А указана маска счета
   if p_nlsa like 'NLS%' then

      -- 1. счет NLS_BBBB_2625
      if p_nlsa like 'NLS\_%\_%' escape '\' then

         -- ищем счет по 2625
         p_nlsa := get_nls_on2625_cardpay(p_nlsa, p_kv1);

         -- если в счете-Б указана маска, определяем счет по формуле
         if p_nlsb like 'NLS%' then

            -- если нашли счет-А
            if p_nlsa is not null then
               -- находим бранч счета-А
               begin
                  select tobo into l_branch from accounts where nls = p_nlsa and kv = p_kv1;
               exception when no_data_found then
                  p_nlsa   := null;
                  l_branch := null;
               end;
            end if;

            if p_nlsb like 'NLS_3800%' and g_nls3800 is not null then
               p_nlsb := g_nls3800;
            else
               -- определяем счет по формуле
               if l_branch is not null then
                  if newnbs.g_state = 1 then
                     l_newnb := get_new_nbs_ob22(substr(p_nlsb,5,4), substr(p_nlsb,-2));
                     p_nlsb := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, l_branch);
                  else
                     p_nlsb := nbs_ob22_null(substr(p_nlsb,5,4), substr(p_nlsb,-2), l_branch);
                  end if;
               else
                  p_nlsb := get_nls_cardpay(p_dat, p_drn, p_orn, p_nlsb, p_kv2);
               end if;
            end if;

         end if;

      -- 2. счет NLS_BBBBOO
      elsif p_nlsa like 'NLS%' then

         if p_nlsa like 'NLS_3800%' and g_nls3800 is not null then
            p_nlsa := g_nls3800;
         else
            p_nlsa := get_nls_cardpay(p_dat, p_drn, p_orn, p_nlsa, p_kv1);
         end if;

         -- если в счете-Б указана маска, определяем счет по формуле
         if p_nlsb like 'NLS%' then
            p_nlsb := get_nls_cardpay(p_dat, p_drn, p_orn, p_nlsb, p_kv2);
         end if;

      end if;

   -- в счете-А указан счет
   else

      -- еслив счете-Б указана маска счета, находим счет-Б по формуле
      if p_nlsb like 'NLS%' then

         -- находим бранч счета-А
         begin
            select tobo into l_branch from accounts where nls = p_nlsa and kv = p_kv1;
         exception when no_data_found then
            p_nlsa   := null;
            l_branch := null;
         end;

         if p_nlsb like 'NLS_3800%' and g_nls3800 is not null then
            p_nlsb := g_nls3800;
         else
            if l_branch is not null then
               if newnbs.g_state = 1 then
                  l_newnb := get_new_nbs_ob22(substr(p_nlsb,5,4), substr(p_nlsb,-2));
                  p_nlsb := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, l_branch);
               else
                  p_nlsb := nbs_ob22_null(substr(p_nlsb,5,4), substr(p_nlsb,-2), l_branch);
               end if;
            else
               p_nlsb := get_nls_cardpay(p_dat, p_drn, p_orn, p_nlsb, p_kv2);
            end if;
         end if;

      end if;

   end if;

   p_branch := l_branch;

end get_nls_multicurrency_cardpay;

--------------------------
procedure get_nls_onbranch_cardpay (
   p_nlsa   in out varchar2,
   p_nlsb   in out varchar2,
   p_kv     in     number,
   p_branch in     varchar2 )
is
  l_newnb t_newnb;
begin
   -- счет А
   if p_nlsa like 'NLS%' then
      -- счет типа NLS_%_2625%
      if p_nlsa like 'NLS\_%\_%' escape '\' then
         p_nlsa := get_nls_on2625_cardpay(p_nlsa, p_kv);
      -- счет типа NLS_BBBBOO (BBBB - НБС, OO - ОБ22)
      elsif p_branch is not null then
         if newnbs.g_state = 1 then
            l_newnb := get_new_nbs_ob22(substr(p_nlsa,5,4), substr(p_nlsa,-2));
            p_nlsa := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, p_branch);
         else
            p_nlsa := nbs_ob22_null(substr(p_nlsa,5,4), substr(p_nlsa,-2), p_branch);
         end if;
      end if;
   end if;
   -- счет Б
   if p_nlsb like 'NLS%' then
      -- счет типа NLS_%_2625%
      if p_nlsb like 'NLS\_%\_%' escape '\' then
         p_nlsb := get_nls_on2625_cardpay(p_nlsb, p_kv);
      -- счет типа NLS_BBBBOO (BBBB - НБС, OO - ОБ22)
      elsif p_branch is not null then
         if newnbs.g_state = 1 then
            l_newnb := get_new_nbs_ob22(substr(p_nlsb,5,4), substr(p_nlsb,-2));
            p_nlsb := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, p_branch);
         else
            p_nlsb := nbs_ob22_null(substr(p_nlsb,5,4), substr(p_nlsb,-2), p_branch);
         end if;
      end if;
   end if;
end get_nls_onbranch_cardpay;

-----------------
function get_nazn_cardpay(p_atrn ow_oic_atransfers_data%rowtype, p_insurance out t_insurance)
  return varchar2 is
   l_nazn varchar2(160);
l_insurance  t_insurance;
  l_errcode    number;
  l_errmsg     varchar2(4000);
begin
   if p_atrn.debit_anlaccount like 'NLS_6%' then
      l_nazn := 'Сторнування операції';
 --формуємо призначення платежу на користь СК
  elsif p_atrn.credit_anlaccount = 'NLS_2924016CK' then
    begin
      l_insurance := get_ins_data(p_atrn.debit_anlaccount);

      ins_ewa_mgr.get_purpose(p_branch           => l_insurance.branch_u,
                              p_user_name        => l_insurance.logname,
                              p_mfob             => null,
                              p_nameb            => null,
                              p_accountb         => null,
                              p_okpob            => l_insurance.ins_okpo,
                              p_ammount          => p_atrn.debit_amount*100,
                              p_commission       => 0,
                              p_number           => l_insurance.ins_number,
                              p_date_from        => l_insurance.datefrom,
                              p_date_to          => l_insurance.dateto,
                              p_date             => l_insurance.datefrom,
                              p_cust_name_last   => l_insurance.last_name,
                              p_cust_name_first  => l_insurance.first_name,
                              p_cust_name_middle => l_insurance.midl_name,
                              p_cust_okpo        => l_insurance.okpo,
                              p_cust_series      => l_insurance.ser,
                              p_cust_number      => l_insurance.numdoc,
                              p_cust_birthdate   => l_insurance.bday,
                              p_cust_phone       => l_insurance.phone,
                              p_cust_address     => l_insurance.adr,
                              p_external_id      => l_insurance.ext_code,
                              p_purpose          => l_nazn,
                              p_errcode          => l_errcode,
                              p_errmessage       => l_errmsg,
                              p_ext_idn          => l_insurance.ext_id
                              );

    p_insurance := l_insurance;
    exception
      when others then
        l_nazn := null;
    end;
   else
      begin
         select nazn into l_nazn
           from ow_nazn_mask
          where p_atrn.anl_synthcode like maskid;
      exception when no_data_found then
         -- anl_trndescr="#RRN***#Назначение платежа", где *** - значение RRN
         if substr(p_atrn.anl_trndescr,1,1) = '#' then
            l_nazn := substr(p_atrn.anl_trndescr, instr(p_atrn.anl_trndescr, '#', -1, 1)+1, 160);
         else
            l_nazn := substr(p_atrn.anl_trndescr, 1, 160);
         end if;
      end;
   end if;
   return l_nazn;
end get_nazn_cardpay;

---------------------------
--Процеруа оплаты документов по счету NLS3800 файла oic_atransfers
procedure pay_multicurrency_cardpay(
  p_id       in number,
  p_filename in varchar2,
  p_filedate in date)
is
   l_atrn         t_atrn;
   l_nls          ow_oic_atransfers_data.debit_anlaccount%type;
   l_s            number;
   l_kv           number;
   l_nlsa         ow_oic_atransfers_data.debit_anlaccount%type;
   l_nlsb         ow_oic_atransfers_data.credit_anlaccount%type;
   l_nam_a        oper.nam_a%type;
   l_nam_b        oper.nam_b%type;
   l_id_a         oper.id_a%type;
   l_id_b         oper.id_b%type;
   l_s1           oper.s%type;
   l_s2           oper.s2%type;
   l_kv1          oper.kv%type;
   l_kv2          oper.kv2%type;
   l_idn2         number;
   l_branch_a     varchar2(30);
   l_branch_b     varchar2(30);
   l_branch_oper  varchar2(30);
   l_tt           oper.tt%type;
   l_vob          oper.vob%type;
   l_dk           oper.dk%type;
   l_sk           oper.sk%type;
   l_nazn         oper.nazn%type;
   l_ref          number;
   bPay           boolean;
   l_credit_anlaccount ow_oic_atransfers_data.credit_anlaccount%type;
   l_debit_anlaccount  ow_oic_atransfers_data.debit_anlaccount%type;
   l_branch       varchar2(30);
   l_err          varchar2(254);
   l_operw_tbl t_operw := t_operw();
   l varchar2(100) := 'bars_ow.pay_multicurrency. ';
   y number := 0;
  l_insurance  t_insurance;
begin

   bars_audit.info(l || 'Start.');

   select *
     bulk collect
     into l_atrn
     from ow_oic_atransfers_data a
    where id = p_id
       -- исключаем операции пополнения/списания, инициированные банком
      and not exists ( select 1 from ow_msgcode where synthcode = a.anl_synthcode )
       -- исключаем операции пополнения/списания, инициированные 3-ей системой
      and not exists ( select 1 from ow_match_tt where code = a.doc_descr )
      and ( credit_anlaccount like 'NLS_3800%'
         or debit_anlaccount like 'NLS_3800%' )
      and doc_orn is not null
      and err_text is null
    order by idn ;

   bars_audit.info(l || 'l_atrn.count=>' || l_atrn.count);

   for i in 1..l_atrn.count loop

      bPay   := true;
      l_err  := null;
      l_idn2 := null;

      -- назначение платежа
  l_nazn := get_nazn_cardpay(l_atrn(i), l_insurance);
      if l_nazn is null then
         bPay  := false;
         l_err := 'Пусте призначення платежу;';
      end if;

      if bPay then

         -- ищем такой же orn с debit_anlaccount like 'NLS_3801%'
         begin
            select idn,
                   decode(substr(l_atrn(i).credit_anlaccount,1,8),'NLS_3800',credit_anlaccount,debit_anlaccount),
                   decode(substr(l_atrn(i).credit_anlaccount,1,8),'NLS_3800',credit_amount,debit_amount),
                   decode(substr(l_atrn(i).credit_anlaccount,1,8),'NLS_3800',credit_currency,debit_currency)
              into l_idn2, l_nls, l_s, l_kv
              from ow_oic_atransfers_data
             where id = p_id
               and doc_orn = l_atrn(i).doc_orn
               and anl_synthcode = l_atrn(i).anl_synthcode
               and decode(substr(l_atrn(i).credit_anlaccount,1,8),'NLS_3800',debit_anlaccount,credit_anlaccount) like 'NLS_3801%';
         exception when no_data_found then
            l_idn2 := null;
            l_nls  := null;
            l_s    := null;
            l_kv   := null;
         when too_many_rows then
            l_idn2 := null;
            l_nls  := null;
            l_s    := null;
            l_kv   := null;
         end;

         if l_atrn(i).credit_anlaccount like 'NLS_3800%' then
            l_nlsa := l_atrn(i).debit_anlaccount;
            l_s1   := l_atrn(i).debit_amount * 100;
            l_kv1  := l_atrn(i).debit_currency;
            if l_idn2 is not null then
               l_nlsb := l_nls;
               l_s2   := l_s*100;
               l_kv2  := l_kv;
            else
               l_nlsb := l_atrn(i).credit_anlaccount;
               l_s2   := l_atrn(i).credit_amount * 100;
               l_kv2  := l_atrn(i).credit_currency;
            end if;
         else
            if l_idn2 is not null then
               l_nlsa := l_nls;
               l_s1   := l_s*100;
               l_kv1  := l_kv;
            else
               l_nlsa := l_atrn(i).debit_anlaccount;
               l_s1   := l_atrn(i).debit_amount * 100;
               l_kv1  := l_atrn(i).debit_currency;
            end if;
            l_nlsb := l_atrn(i).credit_anlaccount;
            l_s2   := l_atrn(i).credit_amount * 100;
            l_kv2  := l_atrn(i).credit_currency;
         end if;
         l_debit_anlaccount  := l_nlsa;
         l_credit_anlaccount := l_nlsb;

         get_nls_multicurrency_cardpay(p_filedate, l_atrn(i).doc_drn, l_atrn(i).doc_orn, l_nlsa, l_kv1, l_nlsb, l_kv2, l_branch);

         -- счет-А (Дебет)
         if l_nlsa is null then
            bPay  := false;
            l_err := l_debit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsa, l_kv1, l_nam_a, l_id_a, l_branch_a) then
               bPay   := false;
               l_err  := l_nlsa || '-Рахунок не знайдено;';
               l_nlsa := null;
            end if;
         end if;

         -- счет-Б (Кредит)
         if l_nlsb is null then
            bPay  := false;
            l_err := l_credit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsb, l_kv2, l_nam_b, l_id_b, l_branch_b) then
               bPay   := false;
               l_err  := l_nlsb || '-Рахунок не знайдено;';
               l_nlsb := null;
            end if;
         end if;

      end if;

      if l_err is not null then
         update ow_oic_atransfers_data
            set err_text = l_err
          where id = p_id and (idn = l_atrn(i).idn or idn = l_idn2);
      end if;

      if bPay and l_nlsa is not null and l_nlsb is not null
              and l_s1 > 0 and l_s2 > 0 then

         l_err := null;

         if l_kv1 = l_kv2 then
            l_tt := 'OW1';
         else
            l_tt := 'OW2';
         end if;

         l_vob := 6;
         l_dk  := 1;
         l_sk  := null;

         begin
            savepoint sp_pay;

            ipay_doc (l_tt, l_vob, l_dk, l_sk,
               l_nam_a, l_nlsa, null, l_id_a,
               l_nam_b, l_nlsb, null, l_id_b,
               l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref);

            -- доп. реквизиты для файла аналитических проводок
            l_operw_tbl := t_operw();

            fill_operw_tbl(l_operw_tbl, l_ref, 'OW_FL', p_filename);
            fill_operw_tbl(l_operw_tbl, l_ref, 'OW_PD', to_char(l_atrn(i).anl_postingdate, 'dd.MM.yyyy'));
            fill_operw_tbl(l_operw_tbl, l_ref, 'OW_LD', to_char(l_atrn(i).doc_localdate, 'dd.MM.yyyy'));
            fill_operw_tbl(l_operw_tbl, l_ref, 'OW_DS', l_atrn(i).doc_descr);
            fill_operw_tbl(l_operw_tbl, l_ref, 'OW_AM', to_char(l_atrn(i).doc_amount) || '/' || l_atrn(i).doc_currency);
            fill_operw_tbl(l_operw_tbl, l_ref, 'OW_SC', l_atrn(i).anl_synthcode);
            fill_operw_tbl(l_operw_tbl, l_ref, 'OWDRN', to_char(l_atrn(i).doc_drn));
            fill_operw_tbl(l_operw_tbl, l_ref, 'OWARN', l_atrn(i).anl_analyticrefn);

            forall i in 1 .. l_operw_tbl.count
               insert into operw values l_operw_tbl(i);

            -- меняем branch на самый низкий уровень
            l_branch_oper := greatest(sys_context('bars_context','user_branch'),
                             greatest(l_branch_a, l_branch_b));
            if l_branch_oper <> sys_context('bars_context','user_branch') then
               update oper set tobo = l_branch_oper where ref = l_ref;
            end if;

            -- удаление в архив
            irec_oic_atrn_to_arc(l_atrn(i), l_ref);

            if l_idn2 is not null then
               irec_oic_atrn_to_arc(p_id, l_idn2, l_ref);
            end if;

            y := y + 1;
            if y > 100 then commit; y := 0; end if;

         exception when others then
            if ( sqlcode <= -20000 ) then
               l_err := substr(sqlerrm,1,254);
            else
               l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
                  dbms_utility.format_error_backtrace(),1,254);
            end if;
            rollback to sp_pay;
            update ow_oic_atransfers_data
               set err_text = l_err
             where id = p_id and ( idn = l_atrn(i).idn or idn = l_idn2 );
         end;

      end if;

   end loop;

   bars_audit.info(l || 'Finish.');

end pay_multicurrency_cardpay;

function send_request_insurance(p_body in clob) return wsm_mgr.t_response is
  l_url         params$global.val%type :=  getglobaloption('ABSBARS_WEBSERVER_PROTOCOL')||'://'||getglobaloption('ABSBARS_WEBSERVER_IP_ADRESS')||getglobaloption('OWEWAURL');
  l_wallet_path varchar2(256) := getglobaloption('PATH_FOR_ABSBARS_WALLET');
  l_wallet_pwd  varchar2(256) := getglobaloption('PASS_FOR_ABSBARS_WALLET');
  l_response    wsm_mgr.t_response;

begin
  wsm_mgr.prepare_request(p_url         => l_url,
                          p_action      => null,
                          p_http_method => wsm_mgr.g_http_post,
                          p_wallet_path => l_wallet_path,
                          p_wallet_pwd  => l_wallet_pwd,
                          p_body        => p_body);

  wsm_mgr.add_header(p_name  => 'Content-Type',
                     p_value => wsm_mgr.g_ct_xml ||'; '||wsm_mgr.g_cc_utf8);
  -- позвать метод веб-сервиса
  wsm_mgr.execute_api(l_response);
  return l_response;
end;

function get_ins_xml(p_insurance in t_insurance) return xmltype is
  l_xml xmltype;
  l_ewa_userid varchar2(10) :=  getglobaloption('EWAID');
  l_stz varchar2(10) := sessiontimezone;
begin
  select xmlelement("ParamsEwa",
                    xmlelement("nd", p_insurance.nd),
                    xmlelement("branch", p_insurance.branch_u),
                    xmlelement("param",
                               xmlelement("type", case when p_insurance.ins_ukr_id is not null and p_insurance.ins_wrd_id is null then 'custom' else 'tourism' end),
                               xmlelement("user",
                                          xmlelement("id", l_ewa_userid)
                                          ),
                               xmlelement("tariff",
                                          xmlelement("type", case when p_insurance.ins_ukr_id is not null and p_insurance.ins_wrd_id is null then 'custom' else 'tourism' end),
                                          xmlelement("id", p_insurance.ext_id)
                                          ),
                               xmlelement("date", p_insurance.datefrom),
                               xmlelement("dateFrom", to_char(p_insurance.datefrom - 1 , 'YYYY-MM-DD')||
                                                              'T'||case l_stz when '+03:00' then '21' when '+02:00' then '22' else '00' end||':00:00.000+0000'),
                               xmlelement("dateTo", p_insurance.dateto),
                               xmlelement("customer",
                                          xmlforest(p_insurance.okpo "code",
                                                    case when p_insurance.okpo = '0000000000' then 'true' else 'false' end "dontHaveCode",
                                                    p_insurance.last_name||' '||p_insurance.first_name||' '|| p_insurance.midl_name "name",
                                                    p_insurance.last_name "nameLast",
                                                    p_insurance.first_name "nameFirst",
                                                    p_insurance.midl_name "nameMiddle",
                                                    p_insurance.adr "address",
                                                    p_insurance.phone "phone",
                                                    p_insurance.bday "birthDate"
                                                    ),
                                          xmlelement("document",
                                                     xmlforest('PASSPORT' "type",
                                                               p_insurance.ser "series",
                                                               p_insurance.numdoc "number",
                                                               p_insurance.pdate "date"
                                                              )
                                                     ),
                                          xmlelement("legal", 'false')
                                          ),
                               xmlelement("insuranceObject",
                                          xmlelement("type", 'person'),
                                          xmlelement("document",
                                                     xmlforest('PASSPORT' "type",
                                                               p_insurance.ser "series",
                                                               p_insurance.numdoc "number",
                                                               p_insurance.pdate "date"
                                                              )
                                                     ),
                                          xmlforest(p_insurance.okpo "code",
                                                    p_insurance.phone "phone",
                                                    p_insurance.bday "birthDate",
                                                    p_insurance.last_name "nameLast",
                                                    p_insurance.first_name "nameFirst",
                                                    p_insurance.midl_name "nameMiddle",
                                                    p_insurance.adr "address",
                                                    case when p_insurance.okpo = '0000000000' then 'true' else 'false' end "dontHaveCode",
                                                    p_insurance.last_name||' '||p_insurance.first_name||' '|| p_insurance.midl_name "name"
                                                    )
                                          ),
                               xmlelement("state", 'DRAFT'),
                                case
                                  when p_insurance.ins_ukr_id is not null and p_insurance.ins_wrd_id is not null then
                                    decode(p_insurance.ext_id, p_insurance.ins_ukr_id,xmlelement("coverageDays", p_insurance.dateto - p_insurance.datefrom + 1), null)
                                  else
                                    null
                                  end,
                               xmlelement("customFields",
                                          xmlelement("CustomFields",
                                                     xmlforest('card_doc' "code",
                                                               'БПК_'||p_insurance.nd "value"
                                                               )
                                                     ),
                                          xmlelement("CustomFields",
                                                     xmlforest('card_number' "code",
                                                               p_insurance.nls "value"
                                                               )
                                                     )
                                          )
                              )
                    )
    into l_xml
    from dual;

  return l_xml;
end;

procedure set_w4_deal(p_nd in number) is
  pragma autonomous_transaction;
begin
  ins_pack.set_w4_deal(p_nd => p_nd);
  commit;
end;

procedure create_insurance_deal(p_insurance in t_insurance) is
  l_xml      xmltype;
  l_clob     clob;
  l_response wsm_mgr.t_response;
  l_tmp_id number;
  l_err varchar2(4000);
  l_ins_w4_deal ins_w4_deals%rowtype;
  h varchar2(100) := 'bars_ow.create_insurance_deal';
begin
    select case
                     when t.ins_ukr_id = p_insurance.ext_id then
                        t.tmp_id_ukr
                     else
                        t.tmp_id_wrd
                 end
        into l_tmp_id
        from w4_card t
     where (t.ins_ukr_id = p_insurance.ext_id or
                  t.ins_wrd_id = p_insurance.ext_id)
         and rownum = 1;
  l_xml := get_ins_xml(p_insurance);

  l_clob := l_xml.getclobval;
  l_ins_w4_deal := ins_pack.get_ins_w4_deal(p_insurance.nd);
  set_w4_deal(p_insurance.nd);
  l_response := send_request_insurance(l_clob);

  ins_pack.set_w4_ins_id(p_nd => p_insurance.nd ,p_ins_id => p_insurance.ext_id ,p_tmp_id => l_tmp_id);

  if l_ins_w4_deal.nd is not null then
    ins_pack.ins_w4_deal_to_arc(l_ins_w4_deal);
  end if;
exception
  when others then
    l_err := dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace();
    bars_audit.info(h || 'Error: ' || l_err);
    if l_clob is not null then
       if l_ins_w4_deal.nd is not null then
         ins_pack.ins_w4_deal_to_arc(l_ins_w4_deal);
       end if;
       merge into ins_w4_deals t
       using (select p_insurance.nd nd, 'ERROR' err, l_clob reqbody,
                     p_insurance.datefrom datefrom, p_insurance.dateto dateto
                from dual) tt
       on (t.nd = tt.nd)
       when not matched then
         insert
           (t.nd, state, err_msg, requestxml,date_from, date_to)
         values
           (tt.nd, tt.err, l_err, tt.reqbody, datefrom, dateto)
       when matched then
         update
            set t.state      = tt.err,
                t.requestxml = tt.reqbody,
                t.err_msg    = l_err,
                t.date_from  = p_insurance.datefrom,
                t.date_to    = p_insurance.dateto,
                t.deal_id    = null;
    end if;
end;

------------------
procedure pay_2625_cardpay(
  p_id       in number,
  p_filename in varchar2,
  p_filedate in date,
  p_start_id in number default null,
  p_end_id   in number default null,
  p_bdate    in date default null
  )
is
   l_atrn         t_atrn;
   l_nlsa         ow_oic_atransfers_data.debit_anlaccount%type;
   l_nlsb         ow_oic_atransfers_data.credit_anlaccount%type;
   l_nam_a        oper.nam_a%type;
   l_nam_b        oper.nam_b%type;
   l_id_a         oper.id_a%type;
   l_id_b         oper.id_b%type;
   l_s1           oper.s%type;
   l_s2           oper.s2%type;
   l_kv1          oper.kv%type;
   l_kv2          oper.kv2%type;
   l_branch_a     varchar2(30);
   l_branch_b     varchar2(30);
   l_branch_oper  varchar2(30);
   l_tt           oper.tt%type;
   l_vob          oper.vob%type;
   l_dk           oper.dk%type;
   l_sk           oper.sk%type;
   l_nazn         oper.nazn%type;
   l_ref          number;
   bPay           boolean;
   l_err          varchar2(254);
   l_operw_tbl t_operw := t_operw();
   l varchar2(100) := 'bars_ow.pay_2625. ';
   y number := 0;
 l_isinspay     number;-- признак страхового платежа 0-нет/1-да
   l_insurance    t_insurance;
   l_nls_trans    varchar2(15);
   l_ref_add      number;
   l_cur_bdate    date;
   l_errumsg      varchar2(1000);
   l_erracode     varchar2(1000);
   l_erramsg      varchar2(1000);
   l_acc_row      accounts%rowtype;

   l_newnb        t_newnb;
begin

   bars_audit.info(l || 'Start.');
   if p_bdate is not null then
      gl.pl_dat(p_bdate);
   end if;
   select *
     bulk collect
     into l_atrn
     from ow_oic_atransfers_data a
    where id = p_id
       -- исключаем операции пополнения/списания, инициированные банком
      and not exists ( select 1 from ow_msgcode where synthcode = a.anl_synthcode )
       -- исключаем операции пополнения/списания, инициированные 3-ей системой, кроме гашения задолженности по кредиту
        and (not exists ( select 1 from ow_match_tt where code = a.doc_descr ) or
             (exists ( select 1 from ow_match_tt where code = a.doc_descr ) and
             (regexp_like(debit_anlaccount,'^NLS_(((220|357)[0-9])|(6[0-9]{3})|9129|9900)_(2625|2620)+') or regexp_like(credit_anlaccount,'^NLS_(((220|357)[0-9])|(6[0-9]{3})|9129|9900)_(2625|2620)+'))))
       -- 2625% or NLS_%_2625%
      and ( substr(debit_anlaccount,1,4) in (select unique nbs from w4_nbs_ob22)
         or substr(debit_anlaccount, instr(debit_anlaccount,'_',-1)+1,4) in (select unique nbs from w4_nbs_ob22)
         or substr(credit_anlaccount,1,4) in (select unique nbs from w4_nbs_ob22)
         or substr(credit_anlaccount, instr(credit_anlaccount,'_',-1)+1,4) in (select unique nbs from w4_nbs_ob22) )
      and err_text is null
      and (idn between p_start_id and p_end_id or p_start_id is null)
    order by idn;

   bars_audit.info(l || 'l_atrn.count=>' || l_atrn.count);

   for i in 1..l_atrn.count loop

   begin

      savepoint sp1;

      bPay  := true;
      l_err := null;
 l_isinspay := 0;

      l_nlsa := l_atrn(i).debit_anlaccount;
      l_s1   := l_atrn(i).debit_amount * 100;
      l_kv1  := l_atrn(i).debit_currency;

      l_nlsb := l_atrn(i).credit_anlaccount;
      l_s2   := l_atrn(i).credit_amount * 100;
      l_kv2  := l_atrn(i).credit_currency;
      if l_nlsb = 'NLS_2924016CK' then
         l_isinspay := 1;
      end if;

      l_nazn := get_nazn_cardpay(l_atrn(i), l_insurance);
      if l_nazn is null then
         bPay  := false;
         l_err := 'Пусте призначення платежу;';
      end if;

      if l_isinspay = 1 and (l_insurance.ins_nls is null or l_insurance.ins_mfo is null) then
         bPay  := false;
         l_err := 'Не заповнені реквізити страхової компанії';
      end if;

      if bPay then

         get_nls_cardpay(l_nlsa, l_kv1, l_nlsb, l_kv2, p_filedate, l_atrn(i).doc_drn, l_atrn(i).doc_orn, l_atrn(i).doc_currency);

         -- счет-А (Дебет)
         if l_nlsa is null then
            bPay  := false;
            l_err := l_atrn(i).debit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsa, l_kv1, l_nam_a, l_id_a, l_branch_a) then
               bPay   := false;
               l_err  := l_nlsa || '-Рахунок не знайдено;';
               l_nlsa := null;
            end if;
         end if;

         -- счет-Б (Кредит)
         if l_nlsb is null then
            bPay  := false;
            l_err := l_atrn(i).credit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsb, l_kv2, l_nam_b, l_id_b, l_branch_b) then
               bPay   := false;
               l_err  := l_nlsb || '-Рахунок не знайдено;';
               l_nlsb := null;
            end if;
         end if;

      end if;

      if bpay then
         if substr(l_nlsa,1,4) in ('2909', '2900') then
            begin
               if not check_available(l_nlsa, l_atrn(i).debit_currency, l_atrn(i).debit_amount) then
                  bPay   := false;
                  l_err  := l_nlsa || '-Недостатньо коштів на рахунку;';
               end if;
            exception
              when others then
                if sqlcode = -54 then
                   bPay   := false;
                   l_err  := l_nlsa || '-locked account';
                else
                   raise;
                end if;
            end;
         end if;
      end if;

      if bpay then
         if substr(l_nlsb,1,4) in('3570', '3579', '3578', '9129', '2202', '2203', '2207', '2208', '2209') then
            begin
              if not check_available(l_nlsb, l_atrn(i).credit_currency, l_atrn(i).credit_amount) then
                 bPay   := false;
                 l_err  := l_nlsb || '-Недостатньо коштів на рахунку;';
              end if;
            exception
              when others then
                if sqlcode = -54 then
                   bPay   := false;
                   l_err  := l_nlsb || '-locked account';
                else
                   raise;
                end if;
            end;
         end if;
      end if;
      if l_err is not null then
         update ow_oic_atransfers_data
            set err_text = l_err
          where id = p_id and idn = l_atrn(i).idn;
      end if;

      if bPay and l_nlsa is not null and l_nlsb is not null
              and l_s1 > 0 and l_s2 > 0 then

         l_err := null;

         if l_kv1 = l_kv2 then
            if l_atrn(i).debit_anlaccount = 'NLS_LOCPAY' then
               l_tt := 'OWR';
               if newnbs.g_state = 1 then
                  l_newnb :=  get_new_nbs_ob22('2909', '80');
                  l_nlsa := nbs_ob22 (l_newnb.nbs, l_newnb.ob22);
               else
                  l_nlsa := nbs_ob22 ('2909','80');

               end if;
            else
               l_tt := 'OW1';
            end if;

         else
            l_tt := 'OW2';
         end if;

         l_vob := 6;
         l_dk  := 1;
         l_sk  := null;
         if substr(l_nlsa,1,4) = '1004' then
            l_vob := 56;
            l_sk  := 29;
         elsif substr(l_nlsb,1,4) = '1004' then
            l_vob := 56;
            l_sk  := 58;
         end if;

         begin
            if l_atrn(i).debit_anlaccount = 'NLS_LOCPAY' then
               ipay_doc (l_tt, l_vob, l_dk, l_sk,
                  l_nam_a, l_nlsa, null, l_id_a,
                  l_nam_b, l_nlsb, null, l_id_b,
                  l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref, 4);
            else
               ipay_doc (l_tt, l_vob, l_dk, l_sk,
                  l_nam_a, l_nlsa, null, l_id_a,
                  l_nam_b, l_nlsb, null, l_id_b,
                  l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref);
            end if;
         exception
            when others then
              bars_error.get_error_info(p_errtxt   => sqlerrm ,
                                        p_errumsg  => l_errumsg,
                                        p_erracode => l_erracode,
                                        p_erramsg  => l_erramsg);
              -- Якщо помилка, що рахунок закрито пробуємо реанімувати інакше помилка
              if l_erracode = 'BRS-09303' then
                 l_acc_row := account_utl.read_account(p_account_number => l_nlsa,
                                                       p_currency_id    => l_kv1);
                 if l_acc_row.tip like 'W4%' and l_acc_row.nbs is not null and l_acc_row.dazs is not null then
                    accreg.p_acc_restore(l_acc_row.acc);
                 end if;
                 
                 l_acc_row := account_utl.read_account(p_account_number => l_nlsb,
                                                       p_currency_id    => l_kv2);
                 if l_acc_row.tip like 'W4%' and l_acc_row.nbs is not null and l_acc_row.dazs is not null then
                    accreg.p_acc_restore(l_acc_row.acc);
                 end if;
                 -- Якщо все ок відкриваємо рахунок
         if l_atrn(i).debit_anlaccount = 'NLS_LOCPAY' then
            ipay_doc (l_tt, l_vob, l_dk, l_sk,
               l_nam_a, l_nlsa, null, l_id_a,
               l_nam_b, l_nlsb, null, l_id_b,
               l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref, 4);
         else
            ipay_doc (l_tt, l_vob, l_dk, l_sk,
               l_nam_a, l_nlsa, null, l_id_a,
               l_nam_b, l_nlsb, null, l_id_b,
               l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref);
         end if;
              else
                 raise;
              end if;
         end;

         if l_atrn(i).credit_anlaccount = 'NLS_LOCPAY_FEE' then
            update ow_locpay_match t
               set t.ref_fee = l_ref
             where t.revflag in (0, 1, 2) and t.state in (10, 11) and
                   t.drn = l_atrn(i).doc_drn;
         end if;
         -- доп. реквизиты для файла аналитических проводок
         l_operw_tbl := t_operw();

         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_FL', p_filename);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_PD', to_char(l_atrn(i).anl_postingdate, 'dd.MM.yyyy'));
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_LD', to_char(l_atrn(i).doc_localdate, 'dd.MM.yyyy'));
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_DS', l_atrn(i).doc_descr);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_AM', to_char(l_atrn(i).doc_amount) || '/' || l_atrn(i).doc_currency);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_SC', l_atrn(i).anl_synthcode);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OWDRN', to_char(l_atrn(i).doc_drn));
         fill_operw_tbl(l_operw_tbl, l_ref, 'OWARN', l_atrn(i).anl_analyticrefn);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OWTRI', substr(l_atrn(i).trans_info,1,220));


         forall i in 1 .. l_operw_tbl.count
            insert into operw values l_operw_tbl(i);

         -- меняем branch на самый низкий уровень
         l_branch_oper := greatest(sys_context('bars_context','user_branch'),
                          greatest(l_branch_a, l_branch_b));
         if l_branch_oper <> sys_context('bars_context','user_branch') then
            update oper set tobo = l_branch_oper where ref = l_ref;
         end if;

         -- удаление в архив
         irec_oic_atrn_to_arc(l_atrn(i), l_ref);

         if l_isinspay = 1 then
             -- формуємо запит на відкриття договору страхування, по новим договорам
            if l_insurance.haveins = 0 then
               create_insurance_deal(l_insurance);
               --перечитаємо значення призначення платежу так як було відкриття нового договоу
               l_nazn := get_nazn_cardpay(l_atrn(i), l_insurance);
            end if;

            -- формуємо проводки на страхову компанію
            -- так як файл приймається в минуломі дні,
            -- то проводку потрібно сформувати в поточному
            l_cur_bdate := gl.bdate;
            gl.pl_dat(bankdate_g);
            if l_insurance.ins_mfo = gl.amfo  then
               l_tt := 'OW1';
            else
               l_tt := 'OWI';
            end if;
            ipay_doc (l_tt, l_vob, l_dk, l_sk,
               l_nam_b, l_nlsb, null, l_id_b,
               l_insurance.ins_name, l_insurance.ins_nls, l_insurance.ins_mfo, l_insurance.ins_okpo,
               l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref_add, 5) ;

            forall i in 1 .. l_operw_tbl.count
               insert into operw (ref, tag, value, kf)
               values (l_ref_add, l_operw_tbl(i).tag, l_operw_tbl(i).value, l_operw_tbl(i).kf);

            if l_branch_oper <> sys_context('bars_context','user_branch') then
               update oper set tobo = l_branch_oper where ref = l_ref_add;
            end if;

            update oper set refl = l_ref where ref = l_ref_add;
            update oper set nazn = l_nazn where ref = l_ref;

            gl.pl_dat(l_cur_bdate);

         end if;

         y := y + 1;
         if y > 100 then commit; y := 0; end if;

      end if;

   exception when others then
      if ( sqlcode <= -20000 ) then
         l_err := substr(sqlerrm,1,254);
      else
         l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
            dbms_utility.format_error_backtrace(),1,254);
      end if;
      rollback to sp1;
      update ow_oic_atransfers_data
         set err_text = l_err
       where id = p_id and idn = l_atrn(i).idn;
   end;

   end loop;

   bars_audit.info(l || 'Finish.');

end pay_2625_cardpay;

------------------
procedure pay_cons_cardpay(
  p_id       in number,
  p_filename in varchar2,
  p_filedate in date)
is
   --l_atrn         t_atrn;
   l_nlsa         ow_oic_atransfers_data.debit_anlaccount%type;
   l_nlsb         ow_oic_atransfers_data.credit_anlaccount%type;
   l_nam_a        oper.nam_a%type;
   l_nam_b        oper.nam_b%type;
   l_id_a         oper.id_a%type;
   l_id_b         oper.id_b%type;
   l_s1           oper.s%type;
   l_s2           oper.s2%type;
   l_kv1          oper.kv%type;
   l_kv2          oper.kv2%type;
   l_branch_a     varchar2(30);
   l_branch_b     varchar2(30);
   --l_branch_oper  varchar2(30);
   l_tt           oper.tt%type;
   l_vob          oper.vob%type;
   l_dk           oper.dk%type;
   l_sk           oper.sk%type;
   l_nazn         oper.nazn%type;
   l_ref          number;
   --bPay           boolean;
   l_err          varchar2(254);
   l_operw_tbl t_operw := t_operw();
   l varchar2(100) := 'bars_ow.pay_cons. ';
   y number := 0;
begin

   bars_audit.info(l || 'Start.');

   bars_audit.info(l || 'Identification accounts...');

   for z in ( select a.idn, a.doc_drn, a.doc_orn, a.anl_trndescr,
                     a.debit_anlaccount, a.debit_currency kv1,
                     a.credit_anlaccount, a.credit_currency kv2
                from ow_oic_atransfers_data a, ow_cons_mask m
               where a.id = p_id
                  -- исключаем операции пополнения/списания, инициированные банком
                 and not exists ( select 1 from ow_msgcode where synthcode = a.anl_synthcode )
                  -- исключаем операции пополнения/списания, инициированные 3-ей системой
                 and not exists ( select 1 from ow_match_tt where code = a.doc_descr )
                 and a.doc_drn is not null
                 and a.err_text is null
                 and a.anl_synthcode like m.maskid )
   loop

      l_err := null;

      if z.anl_trndescr is null then
         l_err := 'Пусте призначення платежу;';
      end if;

      if l_err is null then

         l_nlsa := get_nls_cardpay(p_filedate, z.doc_drn, z.doc_orn, z.debit_anlaccount, z.kv1);
         l_nlsb := get_nls_cardpay(p_filedate, z.doc_drn, z.doc_orn, z.credit_anlaccount, z.kv2);

         -- счет-А (Дебет)
         if l_nlsa is null then
            l_err := z.debit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsa, z.kv1, l_nam_a, l_id_a, l_branch_a) then
               l_err  := l_nlsa || '-Рахунок не знайдено;';
               l_nlsa := null;
            end if;
         end if;

         -- счет-Б (Кредит)
         if l_nlsb is null then
            l_err := z.credit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsb, z.kv2, l_nam_b, l_id_b, l_branch_b) then
               l_err  := l_nlsb || '-Рахунок не знайдено;';
               l_nlsb := null;
            end if;
         end if;

      end if;

      update ow_oic_atransfers_data
         set nlsa  = l_nlsa,
             nam_a = l_nam_a,
             id_a  = l_id_a,
             nlsb  = l_nlsb,
             nam_b = l_nam_b,
             id_b  = l_id_b,
             branch = greatest(sys_context('bars_context','user_branch'),
                      greatest(l_branch_a, l_branch_b)),
             err_text = l_err
       where id = p_id and idn = z.idn;

   end loop;

   bars_audit.info(l || 'Accounts identified...');
   bars_audit.info(l || 'Payment...');

   for z in ( select a.anl_synthcode, a.anl_trndescr,
                     a.nlsa, a.nlsb, a.nam_a, a.nam_b, a.id_a, a.id_b,
                     a.debit_currency kv1, a.credit_currency kv2,
                     sum(a.debit_amount) s1,
                     sum(a.credit_amount) s2,
                     count(*) c
                from ow_oic_atransfers_data a, ow_cons_mask m
               where a.id = p_id
                  -- исключаем операции пополнения/списания, инициированные банком
                 and not exists ( select 1 from ow_msgcode where synthcode = a.anl_synthcode )
                 and a.doc_drn is not null
                 and a.nlsa is not null
                 and a.nlsb is not null
                 and a.branch is not null
                 and a.err_text is null
                 and a.anl_synthcode like m.maskid
               group by anl_synthcode, anl_trndescr,
                     nlsa, nlsb, nam_a, nam_b, id_a, id_b,
                     debit_currency, credit_currency )
   loop

   begin

      savepoint sp1;

      if z.nlsa like '6%' then
         l_nazn := 'Сторнування операції';
      else
         begin
            select nazn into l_nazn
              from ow_nazn_mask
             where z.anl_synthcode like maskid;
         exception when no_data_found then
            l_nazn := substr(z.anl_trndescr, 1, 160);
         end;
      end if;

      if z.nlsa is not null and z.nlsb is not null and
         z.s1 > 0 and z.s2 > 0 and
         l_nazn is not null then

         l_err := null;

         l_nlsa  := z.nlsa;
         l_nam_a := z.nam_a;
         l_id_a  := z.id_a;
         l_s1    := z.s1 * 100;
         l_kv1   := z.kv1;

         l_nlsb  := z.nlsb;
         l_nam_b := z.nam_b;
         l_id_b  := z.id_b;
         l_s2    := z.s2 * 100;
         l_kv2   := z.kv2;

         if l_kv1 = l_kv2 then
            l_tt := 'OW1';
         else
            l_tt := 'OW2';
         end if;

         l_vob := 6;
         l_dk  := 1;
         l_sk  := null;
         if substr(l_nlsa,1,4) = '1004' then
            l_vob := 56;
            l_sk  := 29;
         elsif substr(l_nlsb,1,4) = '1004' then
            l_vob := 56;
            l_sk  := 58;
         end if;

         ipay_doc (l_tt, l_vob, l_dk, l_sk,
            l_nam_a, l_nlsa, null, l_id_a,
            l_nam_b, l_nlsb, null, l_id_b,
            l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref);

         -- доп. реквизиты для файла аналитических проводок
         l_operw_tbl := t_operw();

         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_FL', p_filename);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_SC', z.anl_synthcode);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_NN', z.c);

         forall i in 1 .. l_operw_tbl.count
            insert into operw values l_operw_tbl(i);

         -- удаление в архив
         irec_oic_atrn_to_arc(p_id, z.anl_synthcode, z.anl_trndescr,
            z.nlsa, z.nlsb, z.kv1, z.kv2, l_ref);

         y := y + 1;
         if y > 100 then commit; y := 0; end if;

      end if;

   exception when others then
      if ( sqlcode <= -20000 ) then
         l_err := substr(sqlerrm,1,254);
      else
         l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
            dbms_utility.format_error_backtrace(),1,254);
      end if;
      rollback to sp1;
            update ow_oic_atransfers_data
               set err_text = l_err
             where id = p_id
               and anl_synthcode = z.anl_synthcode
               and anl_trndescr  = z.anl_trndescr
               and nlsa = z.nlsa
               and nlsb = z.nlsb
               and debit_currency = z.kv1
               and credit_currency = z.kv2;
   end;

   end loop;

   bars_audit.info(l || 'Documents paid...');

end pay_cons_cardpay;

function check_available(p_nls in varchar2, p_kv in number, p_s in number)
  return boolean is
  l_accnts accounts%rowtype;
  l_result boolean := true;
begin
  l_accnts := account_utl.lock_account(p_nls, p_kv, p_lock_mode => 1);
  if l_accnts.pap = 1 and l_accnts.lim + l_accnts.ostc + p_s * 100 > 0 then
    l_result := false;
  elsif l_accnts.pap = 2 and l_accnts.lim + l_accnts.ostc - p_s * 100 < 0 then
    l_result := false;
  end if;
  return l_result;
end;
--------------------
procedure pay_others_cardpay(
  p_id       in number,
  p_filename in varchar2,
  p_filedate in date,
  p_start_id in number default null,
  p_end_id   in number default null,
  p_bdate     in date default null
  )
is
   l_atrn         t_atrn;
   l_nlsa         ow_oic_atransfers_data.debit_anlaccount%type;
   l_nlsb         ow_oic_atransfers_data.credit_anlaccount%type;
   l_nam_a        oper.nam_a%type;
   l_nam_b        oper.nam_b%type;
   l_id_a         oper.id_a%type;
   l_id_b         oper.id_b%type;
   l_s1           oper.s%type;
   l_s2           oper.s2%type;
   l_kv1          oper.kv%type;
   l_kv2          oper.kv2%type;
   l_branch_a     varchar2(30);
   l_branch_b     varchar2(30);
   l_branch_oper  varchar2(30);
   l_tt           oper.tt%type;
   l_vob          oper.vob%type;
   l_dk           oper.dk%type;
   l_sk           oper.sk%type;
   l_nazn         oper.nazn%type;
   l_ref          number;
   l_idn          number;
   bPay           boolean;
   l_err          varchar2(254);
   l_operw_tbl t_operw := t_operw();
   l varchar2(100) := 'bars_ow.pay_others. ';
   y number := 0;
l_insurance  t_insurance;
begin

   bars_audit.info(l || 'Start.');
   if p_bdate is not null then
      gl.pl_dat(p_bdate);
   end if;
   select *
     bulk collect
     into l_atrn
     from ow_oic_atransfers_data a
    where id = p_id
       -- исключаем операции пополнения/списания, инициированные банком
      and not exists ( select 1 from ow_msgcode where synthcode = a.anl_synthcode )
       -- исключаем операции пополнения/списания, инициированные 3-ей системой
       -- убрали проверку, т.к. признак "операции пополнения/списания, инициированные 3-ей системой"
       --   ПЦ ставит и для операций Д2924-К2924, которые нужно платить, а не квитовать
       --   (операции по 2625 уже сквитованы в ikvt_cardpayment или для них указана ошибка err_text)
       -- and not exists ( select 1 from ow_match_tt where code = a.doc_descr )
      and err_text is null
      and (idn between p_start_id and p_end_id or p_start_id is null)
    order by idn ;

   bars_audit.info(l || 'l_atrn.count=>' || l_atrn.count);

   for i in 1..l_atrn.count loop

   begin

      savepoint sp1;

      bPay  := true;
      l_err := null;

      -- дополнительная проверка для 3801:
      --   если по какой-то причине не оплачена проводка по 3800 с таким же DRN,
      --   3801 не платим
      if l_atrn(i).credit_anlaccount like 'NLS_3801%'
      or l_atrn(i).debit_anlaccount  like 'NLS_3801%' then
         begin
            select idn into l_idn
              from ow_oic_atransfers_data
             where id = p_id
               and doc_orn = l_atrn(i).doc_orn
               and anl_synthcode = l_atrn(i).anl_synthcode
               and decode(substr(l_atrn(i).credit_anlaccount,1,8),'NLS_3801',debit_anlaccount,credit_anlaccount) like 'NLS_3800%';
            bPay  := false;
            l_err := 'Не оплачена проводка по 3800;';
         exception when no_data_found then null;
         end;
      end if;

      if bPay then
 l_nazn := get_nazn_cardpay(l_atrn(i), l_insurance);
         if l_nazn is null then
            bPay  := false;
            l_err := 'Пусте призначення платежу;';
         end if;
      end if;

      if bPay then

         get_nls_cardpay(p_filedate, l_atrn(i), l_nlsa, l_nlsb);

         -- счет-А (Дебет)
         if l_nlsa is null then
            bPay  := false;
            l_err := l_atrn(i).debit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsa, l_atrn(i).debit_currency, l_nam_a, l_id_a, l_branch_a) then
               bPay   := false;
               l_err  := l_nlsa || '-Рахунок не знайдено;';
               l_nlsa := null;
            end if;
         end if;

         -- счет-Б (Кредит)
         if l_nlsb is null then
            bPay  := false;
            l_err := l_atrn(i).credit_anlaccount || '-Рахунок не знайдено;';
         else
            if not get_account(l_nlsb, l_atrn(i).credit_currency, l_nam_b, l_id_b, l_branch_b) then
               bPay   := false;
               l_err  := l_nlsb || '-Рахунок не знайдено;';
               l_nlsb := null;
            end if;
         end if;
      end if;
      if bpay then
         if substr(l_nlsa,1,4) in ('2909', '2900') then
            begin
               if not check_available(l_nlsa, l_atrn(i).debit_currency, l_atrn(i).debit_amount) then
                  bPay   := false;
                  l_err  := l_nlsa || '-Недостатньо коштів на рахунку;';
               end if;
            exception
              when others then
                if sqlcode = -54 then
                   bPay   := false;
                   l_err  := l_nlsa || '-locked account';
                else
                   raise;
                end if;
            end;
         end if;
      end if;

      if bpay then
         if substr(l_nlsb,1,4) in('3570', '3579', '3578', '9129', '2202', '2203', '2207', '2208', '2209') then
            begin
              if not check_available(l_nlsb, l_atrn(i).credit_currency, l_atrn(i).credit_amount) then
                 bPay   := false;
                 l_err  := l_nlsb || '-Недостатньо коштів на рахунку;';
              end if;
            exception
              when others then
                if sqlcode = -54 then
                   bPay   := false;
                   l_err  := l_nlsb || '-locked account';
                else
                   raise;
                end if;
            end;
         end if;
      end if;

      if l_err is not null then
         update ow_oic_atransfers_data
            set err_text = l_err
          where id = p_id and idn = l_atrn(i).idn;
      end if;

      l_s1  := l_atrn(i).debit_amount * 100;
      l_kv1 := l_atrn(i).debit_currency;
      l_s2  := l_atrn(i).credit_amount * 100;
      l_kv2 := l_atrn(i).credit_currency;

      if bPay and l_nlsa is not null and l_nlsb is not null
              and l_s1 > 0 and l_s2 > 0 then

         l_err := null;

         if l_kv1 = l_kv2 then
            l_tt := 'OW1';
         else
            l_tt := 'OW2';
         end if;

         l_vob := 6;
         l_dk  := 1;
         l_sk  := null;
         if substr(l_nlsa,1,4) = '1004' then
            l_vob := 56;
            l_sk  := 29;
         elsif substr(l_nlsb,1,4) = '1004' then
            l_vob := 56;
            l_sk  := 58;
         end if;

         ipay_doc (l_tt, l_vob, l_dk, l_sk,
            l_nam_a, l_nlsa, null, l_id_a,
            l_nam_b, l_nlsb, null, l_id_b,
            l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref);

         -- доп. реквизиты для файла аналитических проводок
         l_operw_tbl := t_operw();

         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_FL', p_filename);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_PD', to_char(l_atrn(i).anl_postingdate, 'dd.MM.yyyy'));
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_LD', to_char(l_atrn(i).doc_localdate, 'dd.MM.yyyy'));
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_DS', l_atrn(i).doc_descr);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_AM', to_char(l_atrn(i).doc_amount) || '/' || l_atrn(i).doc_currency);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OW_SC', l_atrn(i).anl_synthcode);
         fill_operw_tbl(l_operw_tbl, l_ref, 'OWDRN', to_char(l_atrn(i).doc_drn));
         fill_operw_tbl(l_operw_tbl, l_ref, 'OWARN', l_atrn(i).anl_analyticrefn);
         iset_rrn(l_operw_tbl, l_ref, l_atrn(i).anl_trndescr);

         forall i in 1 .. l_operw_tbl.count
            insert into operw values l_operw_tbl(i);

         -- меняем branch на самый низкий уровень
         l_branch_oper := greatest(sys_context('bars_context','user_branch'),
                          greatest(l_branch_a, l_branch_b));
         if l_branch_oper <> sys_context('bars_context','user_branch') then
            update oper set tobo = l_branch_oper where ref = l_ref;
         end if;

         -- удаление в архив
         irec_oic_atrn_to_arc(l_atrn(i), l_ref);

         y := y + 1;
         if y > 100 then commit; y := 0; end if;

      end if;

   exception when others then
      if ( sqlcode <= -20000 ) then
         l_err := substr(sqlerrm,1,254);
      else
         l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
            dbms_utility.format_error_backtrace(),1,254);
      end if;
      rollback to sp1;
      update ow_oic_atransfers_data
         set err_text = l_err
       where id = p_id and idn = l_atrn(i).idn;
   end;

   end loop;

   bars_audit.info(l || 'Finish.');

end pay_others_cardpay;

procedure run_parallel(p_task           in varchar2,
                       p_chunk          in varchar2,
                       p_stmt           in varchar2,
                       p_parallel_level integer) is
begin

  dbms_parallel_execute.create_task(p_task);
  dbms_parallel_execute.create_chunks_by_sql(p_task, p_chunk, false);
  dbms_parallel_execute.run_task(p_task,
                                 p_stmt,
                                 dbms_sql.native,
                                 parallel_level => p_parallel_level);
  dbms_parallel_execute.drop_task(p_task);

end;
-------------------------------------------------------------------------------
-- ipay_cardpayment
-- процедура оплаты документов по файлу oic_atransfers
--
procedure ipay_cardpayment (
  p_id       number,
  p_filename varchar2,
  p_filedate date
   )
is
  h                 varchar2(100)   := 'bars_ow.ipay_cardpayment. ';
  l_useparallelexec params$global.val%type;
  l_sql_chunk       varchar2(32000);
  l_sql_stmt        varchar2(32000);
  l_parallel_level  number;
  l_parallel_group  number;
  l_task_2625       varchar2(35) := 'PCD_2625'||to_char(current_timestamp,'ddmmyyyyhh24missff');
  l_task_other      varchar2(35) := 'PCD_OTHER'||to_char(current_timestamp,'ddmmyyyyhh24missff');
  -------------------------

begin

  bars_audit.info(h || 'Start.');
  begin
    l_useparallelexec := trim(get_global_param('USEPAREXEC'));
  exception
    when others then
      l_useparallelexec := '0';
  end;
  if l_useparallelexec = '1' then
     bars_login.set_long_session();
     begin
       l_parallel_level := to_number(trim(get_global_param('NUMPARLEVEL')));
     exception
       when others then
         l_parallel_level := 5;
     end;
     begin
       l_parallel_group := to_number(trim(get_global_param('NUMPARGROUP')));
     exception
       when others then
         l_parallel_group := 50;
     end;
  end if;
  -- 1. сначала NLS_3800
  pay_multicurrency_cardpay(p_id, p_filename, p_filedate);

  -- 2. проводки по счетам 2625%, NLS_%_2625%

  if l_useparallelexec = '1' then
     -- создаем группы
     l_sql_chunk := 'select * from (select unique decode(level, 1, min_id, (min_id + step * (level - 1))) start_id,
                                           decode(level,'||
                                                  to_char(l_parallel_group)||',
                                                  max_id,
                                                  decode(level, 1, min_id, (min_id + step * (level - 1))) + step - 1) end_id
                                      from (select min(idn) min_id, max(idn) max_id,
                                                   trunc((max(idn) - min(idn)) / '||to_char(l_parallel_group)||') step
                                              from ow_oic_atransfers_data t
                                             where id = '||to_char(p_id)||')
                                    connect by level <='|| to_char(l_parallel_group)||') where start_id <=end_id';
      --Запуск
      l_sql_stmt := 'begin
                      bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => '|| USER_ID||',
                                            p_hostname  => null,
                                            p_appname   => '' w4_parjob '');
                      bc.go('''||gl.amfo||''');
                      bars_ow.pay_2625_cardpay('||p_id||',
                                               '''||p_filename||''',
                                               to_date('''||to_char(p_filedate,' dd.mm.yyyy
                                                       ')||''',
                                                       '' dd.mm.yyyy ''),
                                               :start_id,
                                               :end_id,
                                               to_date('''||to_char(gl.bDATE,' dd.mm.yyyy
                                                       ')||''',
                                                       '' dd.mm.yyyy ''));
                      bars_login.logout_user;
                    exception
                      when others then
                        bars_login.logout_user;
                    end;';

      run_parallel(p_task => l_task_2625, p_chunk => l_sql_chunk, p_stmt =>l_sql_stmt , p_parallel_level =>l_parallel_level );
  else
     pay_2625_cardpay(p_id, p_filename, p_filedate);
  end if;

  -- 3. консолидированные проводки
  pay_cons_cardpay(p_id, p_filename, p_filedate);

  -- 4. все остальное
  if l_useparallelexec = '1' then
     -- создаем группы
     l_sql_chunk :=  'select * from (select unique decode(level, 1, min_id, (min_id + step * (level - 1))) start_id,
                                           decode(level,'||
                                                  to_char(l_parallel_group)||',
                                                  max_id,
                                                  decode(level, 1, min_id, (min_id + step * (level - 1))) + step - 1) end_id
                                      from (select min(idn) min_id, max(idn) max_id,
                                                   trunc((max(idn) - min(idn)) / '||to_char(l_parallel_group)||') step
                                              from ow_oic_atransfers_data t
                                             where id = '||to_char(p_id)||')
                                    connect by level <='|| to_char(l_parallel_group)||') where start_id <=end_id';

      --Запуск
      l_sql_stmt := 'begin
                      bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => '||USER_ID||',
                                            p_hostname  => null,
                                            p_appname   => '' w4_parjob '');
                      bc.go('''||gl.amfo||''');
                      bars_ow.pay_others_cardpay('||p_id||',
                                                 '''||p_filename||''',
                                                 to_date('''||to_char(p_filedate,' dd.mm.yyyy
                                                         ')||''',
                                                         '' dd.mm.yyyy ''),
                                                 :start_id,
                                                 :end_id,
                                                 to_date('''||to_char(gl.bDATE,' dd.mm.yyyy
                                                         ')||''',
                                                         '' dd.mm.yyyy ''));
                      bars_login.logout_user;
                    exception
                      when others then
                        bars_login.logout_user;
                    end;';
      run_parallel(p_task => l_task_other, p_chunk => l_sql_chunk, p_stmt =>l_sql_stmt , p_parallel_level =>l_parallel_level );

  else
    pay_others_cardpay(p_id, p_filename, p_filedate);
  end if;

  if l_useparallelexec = '1' then
    update ow_oic_atransfers_data t
       set t.err_text = null
     where t.id = p_id and (lower(t.err_text) like 'ora-20203:%lock%' or lower(t.err_text) like '%-locked account');

    pay_2625_cardpay(p_id, p_filename, p_filedate);

    pay_others_cardpay(p_id, p_filename, p_filedate);
  end if;

  bars_audit.info(h || 'Finish.');

end ipay_cardpayment;

-------------------------------------------------------------------------------
-- ipay_oic_atransfers_file
-- процедура оплаты файла oic_atransfers
--
procedure ipay_oic_atransfers_file (
  p_id       number,
  p_filename varchar2,
  p_filedate date )
is
  h varchar2(100) := 'bars_ow.ipay_oic_atransfers_file. ';
begin

  bars_audit.info(h || 'Start.');

  -- квитовка
  ikvt_cardpayment(p_id, p_filename);

  -- оплата
  ipay_cardpayment(p_id, p_filename, trunc(p_filedate));

  bars_audit.info(h || 'Finish.');

end ipay_oic_atransfers_file;

-------------------------------------------------------------------------------
-- ipay_oic_ftransfers_file
-- процедура оплаты файла oic_ftransfers
--
procedure ipay_oic_ftransfers_file (
  p_id       number,
  p_filename varchar2 )
is
  l_atrn         t_atrn;
  l_nlsa         ow_oic_atransfers_data.debit_anlaccount%type;
  l_nlsb         ow_oic_atransfers_data.credit_anlaccount%type;
  l_nam_a        oper.nam_a%type;
  l_nam_b        oper.nam_b%type;
  l_id_a         oper.id_a%type;
  l_id_b         oper.id_b%type;
  l_s1           oper.s%type;
  l_s2           oper.s2%type;
  l_kv1          oper.kv%type;
  l_kv2          oper.kv2%type;
  l_branch_a     varchar2(30);
  l_branch_b     varchar2(30);
  l_branch_oper  varchar2(30);
  l_tt           oper.tt%type;
  l_vob          oper.vob%type;
  l_dk           oper.dk%type;
  l_sk           oper.sk%type;
  l_nazn         oper.nazn%type;
  l_ref          number;
  --l_idn          number;
  bPay           boolean;
  l_err          varchar2(254);
  l_operw_tbl t_operw := t_operw();
  y number := 0;
  h varchar2(100) := 'bars_ow.ipay_oic_ftransfers_file. ';

  function get_nls (p_nls varchar2, p_nls2924 varchar2) return varchar2
  is
     l_branch  varchar2(30) := null;
     l_nls     varchar2(14) := null;
     l_newnb t_newnb;
  begin
     -- счет по маске NLS_7110%, NLS_6110%
     if p_nls like 'NLS%' then
        begin
           select branch into l_branch from accounts where nls = p_nls2924 and rownum = 1;
        exception when no_data_found then null;
        end;
        if l_branch is not null then
           if newnbs.g_state = 1 then
              l_newnb := get_new_nbs_ob22(substr(p_nls,5,4), substr(p_nls,-2));
              l_nls := nbs_ob22_null(l_newnb.nbs, l_newnb.ob22, l_branch);
           else
              l_nls := nbs_ob22_null(substr(p_nls,5,4), substr(p_nls,-2), l_branch);
           end if;
        end if;
     else
        l_nls := p_nls;
     end if;
     return l_nls;
  end get_nls;

begin

  bars_audit.info(h || 'Start.');

  select *
    bulk collect
    into l_atrn
    from ow_oic_atransfers_data a
   where id = p_id
     and account_2924_016 is not null
     and err_text is null
   order by idn ;

  for i in 1..l_atrn.count loop

     bPay  := true;
     l_err := null;

     l_nazn := l_atrn(i).anl_trndescr;

     -- счет-А (Дебет) - NLS_710011/2924
     l_nlsa := get_nls(l_atrn(i).debit_anlaccount, l_atrn(i).account_2924_016);
     if l_nlsa is null then
        bPay  := false;
        l_err := l_atrn(i).debit_anlaccount || '-Рахунок не знайдено (по ' || l_atrn(i).account_2924_016 || ');';
     else
        if not get_account(l_nlsa, l_atrn(i).debit_currency, l_nam_a, l_id_a, l_branch_a) then
           bPay   := false;
           l_err  := l_nlsa || '-Рахунок не знайдено;';
           l_nlsa := null;
        end if;
     end if;

     -- счет-Б (Кредит) - 2924/NLS_6110B9
     l_nlsb := get_nls(l_atrn(i).credit_anlaccount, l_atrn(i).account_2924_016);
     if l_nlsb is null then
        bPay  := false;
        l_err := l_atrn(i).credit_anlaccount || '-Рахунок не знайдено (по ' || l_atrn(i).account_2924_016 || ');';
     else
        if not get_account(l_nlsb, l_atrn(i).credit_currency, l_nam_b, l_id_b, l_branch_b) then
           bPay   := false;
           l_err  := l_nlsb || '-Рахунок не знайдено;';
           l_nlsb := null;
        end if;
     end if;

     if l_err is not null then
        update ow_oic_atransfers_data
           set err_text = l_err
         where id = p_id and idn = l_atrn(i).idn;
     end if;

     l_s1  := l_atrn(i).debit_amount * 100;
     l_kv1 := l_atrn(i).debit_currency;
     l_s2  := l_atrn(i).credit_amount * 100;
     l_kv2 := l_atrn(i).credit_currency;

     if bPay and l_nlsa is not null and l_nlsb is not null
             and l_s1 > 0 and l_s2 > 0 then

        l_err := null;

        if l_kv1 = l_kv2 then
           l_tt := 'OW1';
        else
           l_tt := 'OW2';
        end if;

        l_vob := 6;
        l_dk  := 1;
        l_sk  := null;

        begin
           savepoint sp_pay;

           ipay_doc (l_tt, l_vob, l_dk, l_sk,
              l_nam_a, l_nlsa, null, l_id_a,
              l_nam_b, l_nlsb, null, l_id_b,
              l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref);

           -- доп. реквизиты для файла аналитических проводок
           l_operw_tbl := t_operw();

           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_FL', p_filename);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_PD', to_char(l_atrn(i).anl_postingdate, 'dd.MM.yyyy'));
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_LD', to_char(l_atrn(i).doc_localdate, 'dd.MM.yyyy'));
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_DS', l_atrn(i).doc_descr);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_AM', to_char(l_atrn(i).doc_amount) || '/' || l_atrn(i).doc_currency);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_SC', l_atrn(i).anl_synthcode);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OWDRN', to_char(l_atrn(i).doc_drn));
           fill_operw_tbl(l_operw_tbl, l_ref, 'OWARN', l_atrn(i).anl_analyticrefn);

           forall i in 1 .. l_operw_tbl.count
              insert into operw values l_operw_tbl(i);

           -- меняем branch на самый низкий уровень
           l_branch_oper := greatest(sys_context('bars_context','user_branch'),
                            greatest(l_branch_a, l_branch_b));
           if l_branch_oper <> sys_context('bars_context','user_branch') then
              update oper set tobo = l_branch_oper where ref = l_ref;
           end if;

           -- удаление в архив
           irec_oic_atrn_to_arc(l_atrn(i), l_ref);

           y := y + 1;
           if y > 100 then commit; y := 0; end if;

        exception when others then
           if ( sqlcode <= -20000 ) then
              l_err := substr(sqlerrm,1,254);
           else
              l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
                 dbms_utility.format_error_backtrace(),1,254);
           end if;
           rollback to sp_pay;
           update ow_oic_atransfers_data
              set err_text = l_err
            where id = p_id and idn = l_atrn(i).idn;
        end;

     end if;

  end loop;

  bars_audit.info(h || 'Finish.');

end ipay_oic_ftransfers_file;

-------------------------------------------------------------------------------
--
--
procedure ipay_oic_stransfers_file (
  p_id       number,
  p_filename varchar2 )
is
  l_strn     t_strn;
  l_tt       oper.tt%type;
  l_vob      oper.vob%type;
  l_dk       oper.dk%type;
  l_sk       oper.sk%type;
  l_nam_a    oper.nam_a%type;
  l_nlsa     oper.nlsa%type;
  l_id_a     oper.id_a%type;
  l_nam_b    oper.nam_b%type;
  l_nlsb     oper.nlsb%type;
  l_id_b     oper.id_b%type;
  l_kv1      oper.kv%type;
  l_s1       oper.s%type;
  l_kv2      oper.kv2%type;
  l_s2       oper.s2%type;
  l_nazn     oper.nazn%type;
  l_branch   accounts.tobo%type;
  l_ref      number;
  bPay       boolean;
  l_err      varchar2(254) := null;
  l_operw_tbl t_operw := t_operw();
  h varchar2(100) := 'bars_ow.ipay_oic_stransfers_file. ';
  y number := 0;

  function iget_nazn (p_synthcode varchar2, p_trndescr varchar2) return varchar2
  is
     l_nazn varchar2(160);
  begin
     if p_synthcode like 'A1____' then
        l_nazn := 'Розрахунки за операціями АТМ. ATM: Our ATM --> Our VISA Cards';
     elsif p_synthcode like 'A1____F' then
        l_nazn := 'Списання комісії за операціями АТМ. ATM Fee: Our ATM --> Our VISA Cards';
     elsif p_synthcode like 'R1____' then
        l_nazn := 'Розрахунки за операціями еквайрінгу. Retail: Our POS --> Our VISA Cards';
     elsif p_synthcode like 'R1____F' then
        l_nazn := 'Списання комісії за операціями еквайрінгу. Retail Fee: Our POS --> Our VISA Cards';
     elsif p_synthcode like 'C1____' then
        l_nazn := 'Розрахунки по POS-терміналах. Cash: Our POS --> Our VISA Cards';
     elsif p_synthcode like 'C1____F' then
        l_nazn := 'Списання комісії за розрахунки по POS-терміналах. Cash Fee: Our POS --> Our VISA Cards';
     else
        l_nazn := p_trndescr;
     end if;
     return l_nazn;
  end iget_nazn;

begin

  bars_audit.info(h || 'Start.');

  select *
    bulk collect
    into l_strn
    from ow_oic_stransfers_data
   where id = p_id
   order by idn;

  bars_audit.info(h || 'l_strn.count=>' || l_strn.count);

  for i in 1..l_strn.count loop

     bPay  := true;
     l_err := null;

     l_s1 := l_strn(i).debit_amount * 100;
     l_s2 := l_strn(i).credit_amount * 100;

     -- назначение платежа для файла синтетических проводок
     l_nazn := iget_nazn(l_strn(i).synth_synthcode, l_strn(i).synth_trndescr);

     -- счет-А (Дебет)
     if get_account(l_strn(i).debit_syntaccount, l_strn(i).debit_currency, l_nam_a, l_id_a, l_branch) then
        l_nlsa := l_strn(i).debit_syntaccount;
        l_kv1  := l_strn(i).debit_currency;
     else
        bPay   := false;
        l_err  := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Рахунок ' || l_strn(i).debit_syntaccount || '/' || l_strn(i).debit_currency || ' не знайдено',1,254);
        l_nlsa := null;
     end if;

     -- счет-Б (Кредит)
     if get_account(l_strn(i).credit_syntaccount, l_strn(i).credit_currency, l_nam_b, l_id_b, l_branch) then
        l_nlsb := l_strn(i).credit_syntaccount;
        l_kv2  := l_strn(i).credit_currency;
     else
        bPay   := false;
        l_err  := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Рахунок ' || l_strn(i).credit_syntaccount || '/' || l_strn(i).credit_currency || ' не знайдено',1,254);
        l_nlsb := null;
     end if;

     update ow_oic_stransfers_data
        set err_text = l_err
      where id = p_id and idn = l_strn(i).idn;

     if bPay and l_nlsa is not null and l_nlsb is not null
             and l_s1 > 0 and l_s2 > 0 then

        if l_kv1 = l_kv2 then
           l_tt := 'OW1';
        else
           l_tt := 'OW2';
        end if;

        l_vob := 6;
        l_dk  := 1;
        l_sk  := null;

        begin
           savepoint sp_pay;

           ipay_doc (l_tt, l_vob, l_dk, l_sk,
              l_nam_a, l_nlsa, null, l_id_a,
              l_nam_b, l_nlsb, null, l_id_b,
              l_kv1, l_s1, l_kv2, l_s2, l_nazn, l_ref);

           -- доп. реквизиты для файла синтетических проводок
           l_operw_tbl := t_operw();

           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_FL', p_filename);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_PD', to_char(l_strn(i).synth_postingdate, 'dd.MM.yyyy'));
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_DS', l_strn(i).synth_trndescr);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OW_SC', l_strn(i).synth_synthcode);

           forall i in 1 .. l_operw_tbl.count
              insert into operw values l_operw_tbl(i);

           -- удаление в архив
           irec_oic_strn_to_arc(l_strn(i), l_ref);

           y := y + 1;
           if y > 100 then commit; y := 0; end if;

        exception when others then
           if ( sqlcode <= -20000 ) then
              l_err := substr(sqlerrm,1,254);
           else
              l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
                 dbms_utility.format_error_backtrace(),1,254);
           end if;
           rollback to sp_pay;
           update ow_oic_stransfers_data
              set err_text = l_err
            where id = p_id and idn = l_strn(i).idn;
        end;

     end if;

  end loop;

  bars_audit.info(h || 'Finish.');

end ipay_oic_stransfers_file;

-------------------------------------------------------------------------------
--
--
procedure ipay_oic_documents_file (
  p_id       number,
  p_filename varchar2 )
is
  l_doc    t_doc;
  l_tt     oper.tt%type;
  l_vob    oper.vob%type;
  l_dk     oper.dk%type;
  l_sk     oper.sk%type;
  l_nam_a  oper.nam_a%type;
  l_nlsa   oper.nlsa%type;
  l_id_a   oper.id_a%type;
  l_nam_b  oper.nam_b%type;
  l_nlsb   oper.nlsb%type;
  l_id_b   oper.id_b%type;
  l_mfob   oper.mfob%type;
  --l_kv1    oper.kv%type;
  l_s      oper.s%type;
  l_kv     oper.kv2%type;
  l_nazn   oper.nazn%type;
  l_branch_a     varchar2(30);
  l_branch_b     varchar2(30);
  l_branch_oper  varchar2(30);
  l_ref    number;
  l_tip_pk accounts.tip%type;
  bPay     boolean;
  l_err    varchar2(254);
  l_operw_tbl t_operw := t_operw();
  h varchar2(100) := 'bars_ow.ipay_oic_documents_file. ';
  y number := 0;
  --l_val_okpo number;
  l_res pls_integer;
  l_isoverlimit boolean;
  l_d_rec oper.d_rec%type;
  l_psn varchar2(100);
  l_errumsg varchar2(1000);
  l_erracode varchar2(1000);
  l_erramsg varchar2(1000);
  l_mode number;
  l_acc    accounts.acc%type;
  l_newnb t_newnb;
  l_reverse boolean;
begin

  bars_audit.info(h || 'Start.');

  select *
    bulk collect
    into l_doc
    from ow_oic_documents_data
   where id = p_id
   order by idn
    for update skip locked;

  bars_audit.info(h || 'l_doc.count=>' || l_doc.count);

  for i in 1..l_doc.count loop

     bPay  := true;
     l_err := null;
     l_d_rec := null;
     l_isoverlimit := false;
     l_s    := l_doc(i).bill_amount * 100;
     l_kv   := l_doc(i).bill_currency;
     l_nazn := substr(nvl(trim(l_doc(i).doc_socmnt || ' ' || case when l_doc(i).work_flag = 0 then '' else  l_doc(i).doc_trdetails end),l_doc(i).doc_descr), 1, 160);
     l_mfob := l_doc(i).dest_institution;

     -- счет-А (Дебет)
     if get_account(l_doc(i).org_cbsnumber, l_doc(i).bill_currency, l_nam_a, l_id_a, l_branch_a, l_acc) then
        l_nlsa := l_doc(i).org_cbsnumber;
     else
        bPay  := false;
        l_err := substr('Рахунок ' || l_doc(i).org_cbsnumber || '/' || l_doc(i).bill_currency || '  не знайдено', 1, 254);
     end if;

     -- счет-Б (Кредит)
     if l_mfob = gl.amfo then
        if get_account(l_doc(i).cnt_contractnumber, l_doc(i).bill_currency, l_nam_b, l_id_b, l_branch_b) then
           l_nlsb := l_doc(i).cnt_contractnumber;
           -- проверка ОКПО
           if l_id_b <> l_doc(i).cnt_clientregnumber then
              bPay  := false;
              l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Код клієнта в файлі (' || l_doc(i).cnt_clientregnumber || ') не відповідає коду клієнта в АБС (' || l_id_b || ')', 1, 254);

           end if;
        else
           bPay  := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Рахунок ' || l_doc(i).cnt_contractnumber || '/' || l_doc(i).bill_currency || '  не знайдено', 1, 254);
        end if;
     else
 if regexp_like (l_nazn, '[[:cntrl:]]') then
           bPay  := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Призначення платежу містить недруковані символи.', 1, 254);
        end if;
        if l_doc(i).cnt_contractnumber <> vkrzn(substr(l_mfob,1,5), l_doc(i).cnt_contractnumber) then
           bPay  := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Невірний контрольний розряд рахунку ' || l_doc(i).cnt_contractnumber || ' МФО ' || l_mfob, 1, 254);
        else
           if v_okpo(l_doc(i).cnt_clientregnumber) <> l_doc(i).cnt_clientregnumber then
              bPay  := false;
              l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Невірний контрольний розряд ЄДРПОУ ' || l_doc(i).cnt_clientregnumber, 1, 254);
           else
              l_nlsb  := l_doc(i).cnt_contractnumber;
              l_nam_b := l_doc(i).cnt_clientname;
              l_id_b  := l_doc(i).cnt_clientregnumber;
              l_branch_b := sys_context('bars_context','user_branch');
           end if;
        end if;
     end if;

     --Если не совпала цифровая подпись по платежам
     --на свободные реквизиты(LOCPAY) отправляем реверсал
     if l_doc(i).work_flag = 0 and l_doc(i).is_sign_ok = 'N' then
        bPay := false;
        l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Цифровий підпис не пройшов перевірку', 1, 254);
     end if;

     if l_doc(i).work_flag = 1 then

        l_nazn := replace(l_nazn, ':', ';');

        if l_doc(i).msgcodes not in ('124020000', '0515') then
           bPay := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'MsgCode відмінний від: 124020000, 0515', 1, 254);
        end if;
        if trim(l_doc(i).repost_doc) is not null then
           bPay := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Реверсал REPOST_DOC = '||l_doc(i).repost_doc , 1, 254);
        end if;
        if trim(l_doc(i).postingstatus) is not null and trim(l_doc(i).postingstatus) <> 'Posted' then
           bPay := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Статус документа відмінний від Posted: '||l_doc(i).postingstatus , 1, 254);
        end if;
        if instr(l_doc(i).doc_descr, '::', 1, 1) > 0 then
           bPay := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Платіж потребує ручного розбору: ', 1, 254);
        end if;
     end if;

     if l_doc(i).work_flag = 2 then
         if l_doc(i).doc_descr='Невідповідність загальної суми платежу' then
           bPay := false;
           l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Невідповідність загальної суми платежу.Платіж потребує ручного розбору: ', 1, 254);
         end if;


         if l_doc(i).is_sign_ok = 'N' then
            bPay := false;
            l_err := substr(iif_s(length(l_err), 0, '', '', l_err||' ') || 'Цифровий підпис не пройшов перевірку', 1, 254);
         end if;
      end if;



     if not bPay then

        update ow_oic_documents_data
           set err_text = l_err
         where id = p_id and idn = l_doc(i).idn;
        if l_doc(i).work_flag = 0 then
          begin
            savepoint sp_pay_indef;
            l_mode := 2;
            l_tt := 'OW7';
            l_nazn := substr('Відміна операції по причині: '||l_err, 1, 160);

            if newnbs.g_state = 1 then
               l_newnb :=  get_new_nbs_ob22('2909', '80');
               l_nlsb := nbs_ob22 (l_newnb.nbs, l_newnb.ob22);
            else
               l_nlsb := nbs_ob22 ('2909','80');
            end if;
            l_nam_b := l_doc(i).cnt_clientname;
            ipay_doc (l_tt, l_vob, 1, l_sk,
               l_nam_a, l_nlsa, null,   l_id_a,
               l_nam_b, l_nlsb, null, l_id_b,
               l_kv, l_s, l_kv, l_s, l_nazn, l_ref, l_mode);
            -- доп. реквизиты для файла документов
            l_operw_tbl := t_operw();

            fill_operw_tbl(l_operw_tbl, l_ref, 'OWCFL', p_filename);
            fill_operw_tbl(l_operw_tbl, l_ref, 'OWCLD', to_char(l_doc(i).doc_localdate, 'dd.MM.yyyy'));
            fill_operw_tbl(l_operw_tbl, l_ref, 'OWCDS', l_doc(i).doc_descr);
            fill_operw_tbl(l_operw_tbl, l_ref, 'OWCAM', to_char(l_doc(i).bill_amount) || '/' || l_doc(i).bill_currency);
            fill_operw_tbl(l_operw_tbl, l_ref, 'OWCRN', to_char(l_doc(i).doc_drn));
            fill_operw_tbl(l_operw_tbl, l_ref, 'OWRRN', to_char(l_doc(i).doc_rrn));

            forall i in 1 .. l_operw_tbl.count
               insert into operw values l_operw_tbl(i);
            --Добавим документ в очередь для квитовки
            insert into ow_locpay_match(ref, drn, rrn, revflag, doc_data, rev_message, acc)
            values (l_ref, l_doc(i).doc_drn, l_doc(i).doc_rrn, 1, l_doc(i).doc_data, l_err, l_acc);
            irec_oic_doc_to_arc(l_doc(i), l_ref);
          exception
            when others then
            rollback to sp_pay_indef;
            bars_audit.error(h||'Помилка формуваня платежу на вільні реквізити з рахунку:#'||l_doc(i).org_cbsnumber||
                                ' на рахунок:#'||l_doc(i).cnt_contractnumber ||
                                ' на суму:#'||l_doc(i).bill_amount||' DRN:#'||l_doc(i).doc_drn||':'||utl_tcp.CRLF||
               dbms_utility.format_error_stack() || chr(10) ||
               dbms_utility.format_error_backtrace());
          end;
        end if;

     elsif bPay and l_nlsa is not null and l_nlsb is not null
        and l_s > 0 then

        if l_mfob = gl.amfo then
           if l_doc(i).work_flag = 0 then
              l_tt := 'OW5';
           else
              l_tt := 'OW1';
           end if;
           -- проверка на 2605 PK/W4
           if l_nlsb like '2605%' or l_nlsb like '2600%'  then
              begin
                 select tip into l_tip_pk
                   from accounts
                  where nls = l_nlsb
                    and kv = l_kv
                    and (tip like 'PK%' or tip like 'W4%');
                 l_tt := 'PKR';
              exception when no_data_found then
                   if l_doc(i).work_flag = 0 then
                      l_tt := 'OW5';
                   else
                      l_tt := 'OW1';
                   end if;
              end;
           end if;
        else
           if l_doc(i).work_flag = 0 then
              l_tt := 'OW6';
           else
              l_tt := 'OW3';
           end if;
        end if;
        l_vob := 6;
        l_dk  := 1;
        l_sk  := null;

        begin
           savepoint sp_pay;
           if l_doc(i).work_flag = 0 then
              if l_id_a in ('0000000000', '9999999999') then
                 select '#Ф' || case
                          when t.ser || t.numdoc is not null then
                           t.ser || ' ' || t.numdoc
                          else
                           'Клієнтом не надано'
                        end || '#'
                   into l_d_rec
                   from person t
                   join accounts a
                     on t.rnk = a.rnk and a.nls = l_nlsa;
              end if;
              if l_id_b in ('0000000000', '9999999999') and l_doc(i).doc_trdetails is not null then
                 if l_d_rec is null then
                    l_d_rec := '#ф'||l_doc(i).doc_trdetails||'#';
                 else
                    l_d_rec := l_d_rec||'ф'||l_doc(i).doc_trdetails||'#';
                 end if;
              elsif l_id_b in ('0000000000', '9999999999') and l_doc(i).doc_trdetails is null then
                 if l_d_rec is null then
                    l_d_rec := '#ф'||'Клієнтом не надано'||'#';
                 else
                    l_d_rec := l_d_rec||'ф'||'Клієнтом не надано'||'#';
                 end if;
              end if;

              l_mode := 1;

              ipay_doc (l_tt, l_vob, l_dk, l_sk,
                 l_nam_a, l_nlsa, null,   l_id_a,
                 l_nam_b, l_nlsb, l_mfob, l_id_b,
                 l_kv, l_s, l_kv, l_s, l_nazn, l_ref, l_mode, l_d_rec);
              --Добавим документ в очередь для квитовки
              insert into ow_locpay_match(ref, drn, rrn, doc_data, acc)
              values (l_ref, l_doc(i).doc_drn, l_doc(i).doc_rrn, l_doc(i).doc_data, l_acc);
           else
              ipay_doc (l_tt, l_vob, l_dk, l_sk,
                 l_nam_a, l_nlsa, null,   l_id_a,
                 l_nam_b, l_nlsb, l_mfob, l_id_b,
                 l_kv, l_s, l_kv, l_s, l_nazn, l_ref);
           end if;

           if l_doc(i).work_flag = 0 and g_check_limit = 1 then
              begin
                 l_res := lcs_pack_service.f_stop(l_ref);
              exception
                when others then
                  l_isoverlimit := true;
              end;
           end if;

           if l_isoverlimit then

              rollback to sp_pay;

              savepoint sp_pay;

              l_tt := case l_tt
                        when 'OW5' then
                         'WO5'
                        when 'OW6' then
                         'WO6'
                      end;
              l_mode := 3;
              ipay_doc (l_tt, l_vob, l_dk, l_sk,
                 l_nam_a, l_nlsa, null,   l_id_a,
                 l_nam_b, l_nlsb, l_mfob, l_id_b,
                 l_kv, l_s, l_kv, l_s, l_nazn, l_ref, l_mode, l_d_rec);
              --Добавим документ в очередь для квитовки
              insert into ow_locpay_match(ref, drn, rrn, doc_data, acc)
              values (l_ref, l_doc(i).doc_drn, l_doc(i).doc_rrn, l_doc(i).doc_data, l_acc);
           end if;
           -- доп. реквизиты для файла документов
           l_operw_tbl := t_operw();

           fill_operw_tbl(l_operw_tbl, l_ref, 'OWCFL', p_filename);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OWCLD', to_char(l_doc(i).doc_localdate, 'dd.MM.yyyy'));
           fill_operw_tbl(l_operw_tbl, l_ref, 'OWCDS', l_doc(i).doc_descr);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OWCAM', to_char(l_doc(i).bill_amount) || '/' || l_doc(i).bill_currency);
           fill_operw_tbl(l_operw_tbl, l_ref, 'OWCRN', to_char(l_doc(i).doc_drn));
           fill_operw_tbl(l_operw_tbl, l_ref, 'OWRRN', to_char(l_doc(i).doc_rrn));


           forall i in 1 .. l_operw_tbl.count
              insert into operw values l_operw_tbl(i);

           -- меняем branch на самый низкий уровень
           l_branch_oper := greatest(sys_context('bars_context','user_branch'),
                            greatest(l_branch_a, l_branch_b));
           if l_branch_oper <> sys_context('bars_context','user_branch') then
              update oper set tobo = l_branch_oper where ref = l_ref;
           end if;

           -- удаление в архив
           irec_oic_doc_to_arc(l_doc(i), l_ref);

           y := y + 1;
           if y > 100 then commit; y := 0; end if;

        exception when others then
           if ( sqlcode <= -20000 ) then
              l_err := substr(sqlerrm,1,254);
           else
              l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
                 dbms_utility.format_error_backtrace(),1,254);
           end if;
           rollback to sp_pay;
            if l_doc(i).work_flag = 0 then
              begin
                savepoint sp_pay_indef_1;
                l_tt := 'OW7';
                l_mode := 2;
                l_reverse := true;
                bars_error.get_error_info(p_errtxt => l_err,
                                          p_errumsg => l_errumsg,
                                          p_erracode => l_erracode,
                                          p_erramsg => l_erramsg);
                if l_erracode not in ('BRS-09300','BRS-09301', 'BRS-09302', 'BRS-09303', 'BRS-09304','BRS-09305') then
                   l_errumsg := 'Відхилено по технічній причині';
                   l_reverse := false;                                 
                end if;
                bars_audit.error(h||'Помилка формуваня платежу на вільні реквізити з рахунку:#'||l_doc(i).org_cbsnumber||
                                ' на рахунок:#'||l_doc(i).cnt_contractnumber ||
                                ' на суму:#'||l_doc(i).bill_amount||' DRN:#'||l_doc(i).doc_drn||':'||utl_tcp.CRLF|| 
                                dbms_utility.format_error_stack() || utl_tcp.CRLF || dbms_utility.format_error_backtrace());                  
                if l_doc(i).failures_count > 99 or l_reverse then
                l_nazn := substr('Відміна операції по причині: '||l_errumsg, 1, 160);
                if newnbs.g_state = 1 then
                   l_newnb :=  get_new_nbs_ob22('2909', '80');
                   l_nlsb := nbs_ob22 (l_newnb.nbs, l_newnb.ob22);
                else
                   l_nlsb := nbs_ob22 ('2909','80');
                end if;
                ipay_doc (l_tt, l_vob, l_dk, l_sk,
                   l_nam_a, l_nlsa, null,   l_id_a,
                   l_nam_b, l_nlsb, null, l_id_b,
                   l_kv, l_s, l_kv, l_s, l_nazn, l_ref, l_mode);
                -- доп. реквизиты для файла документов
                l_operw_tbl := t_operw();

                fill_operw_tbl(l_operw_tbl, l_ref, 'OWCFL', p_filename);
                fill_operw_tbl(l_operw_tbl, l_ref, 'OWCLD', to_char(l_doc(i).doc_localdate, 'dd.MM.yyyy'));
                fill_operw_tbl(l_operw_tbl, l_ref, 'OWCDS', l_doc(i).doc_descr);
                fill_operw_tbl(l_operw_tbl, l_ref, 'OWCAM', to_char(l_doc(i).bill_amount) || '/' || l_doc(i).bill_currency);
                fill_operw_tbl(l_operw_tbl, l_ref, 'OWCRN', to_char(l_doc(i).doc_drn));
                fill_operw_tbl(l_operw_tbl, l_ref, 'OWRRN', to_char(l_doc(i).doc_rrn));

                forall i in 1 .. l_operw_tbl.count
                   insert into operw values l_operw_tbl(i);

                --Добавим документ в очередь для квитовки
                insert into ow_locpay_match(ref, drn, rrn, revflag, doc_data, rev_message, acc)
                values (l_ref, l_doc(i).doc_drn, l_doc(i).doc_rrn, 1, l_doc(i).doc_data, substr(l_errumsg, 1, 254), l_acc);
                irec_oic_doc_to_arc(l_doc(i), l_ref);
                else
                  update ow_oic_documents_data
                     set err_text = l_err,
                         failures_count = failures_count + 1
                   where id = p_id and idn = l_doc(i).idn;
                end if;
              exception
                when others then
                rollback to sp_pay_indef_1;
                bars_audit.error(h||'Помилка формуваня платежу на вільні реквізити з рахунку:#'||l_doc(i).org_cbsnumber||
                                ' на рахунок:#'||l_doc(i).cnt_contractnumber ||
                                ' на суму:#'||l_doc(i).bill_amount||' DRN:#'||l_doc(i).doc_drn||':'||utl_tcp.CRLF||
                   dbms_utility.format_error_stack() || chr(10) ||
                   dbms_utility.format_error_backtrace());
              end;
            end if;
        end;

     end if;

  end loop;

  bars_audit.info(h || 'Finish.');

end ipay_oic_documents_file;

procedure check_bpdoc (
  p_fileid    in number,
  p_fileidn   in number)
is
  l_filename ow_files.file_name%type;
  l_filetype ow_files.file_type%type;
  l_atrn     ow_oic_atransfers_data%rowtype;
  l_strn     ow_oic_stransfers_data%rowtype;
  l_doc      ow_oic_documents_data%rowtype;
  l_operw_tbl t_operw := t_operw();
  h varchar2(100) := 'bars_ow.check_bpdoc. ';
begin

  bars_audit.info(h || 'Start.');

  begin
     select file_name, file_type into l_filename, l_filetype from ow_files where id = p_fileid;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  if l_filetype in (g_filetype_atrn, g_filetype_ftrn) then

     begin
        select *
          into l_atrn
          from ow_oic_atransfers_data
         where id = p_fileid
           and idn = p_fileidn;
     exception when no_data_found then
        bars_audit.info(h || 'Row not found p_fileid=>' || to_char(p_fileid) || ' p_fileidn=>' || to_char(p_fileidn));
        raise_application_error(-20000, 'Документ файлу вже оплачено!');
     end;

  elsif l_filetype = g_filetype_strn then

     begin
        select *
          into l_strn
          from ow_oic_stransfers_data
         where id = p_fileid
           and idn = p_fileidn;
     exception when no_data_found then
        bars_audit.info(h || 'Row not found p_fileid=>' || to_char(p_fileid) || ' p_fileidn=>' || to_char(p_fileidn));
        raise_application_error(-20000, 'Документ файлу вже оплачено!');
     end;

  elsif l_filetype = g_filetype_doc then

     begin
        select *
          into l_doc
          from ow_oic_documents_data
         where id = p_fileid
           and idn = p_fileidn;
     exception when no_data_found then
        bars_audit.info(h || 'Row not found p_fileid=>' || to_char(p_fileid) || ' p_fileidn=>' || to_char(p_fileidn));
        raise_application_error(-20000, 'Документ файлу вже оплачено!');
     end;

  end if;

  bars_audit.info(h || 'Finish.');

end;

-------------------------------------------------------------------------------
-- set_pay_flag
-- процедура установки флага оплата документа
--
procedure set_pay_flag (
  p_fileid    in number,
  p_fileidn   in number,
  p_ref       in number,
  p_par       in number )
is
  l_filename ow_files.file_name%type;
  l_filetype ow_files.file_type%type;
  l_atrn     ow_oic_atransfers_data%rowtype;
  l_strn     ow_oic_stransfers_data%rowtype;
  l_doc      ow_oic_documents_data%rowtype;
  l_operw_tbl t_operw := t_operw();
  h varchar2(100) := 'bars_ow.set_pay_flag. ';
begin

  bars_audit.info(h || 'Start.');

  begin
     select file_name, file_type into l_filename, l_filetype from ow_files where id = p_fileid;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  if l_filetype in (g_filetype_atrn, g_filetype_ftrn) then

     -- если документ удаелен, восстанавливаем его
     if p_par = 0 then
        insert into ow_oic_atransfers_data (id, idn,
               anl_synthcode, anl_trndescr, anl_analyticrefn,
               credit_anlaccount, credit_amount, credit_currency,
               debit_anlaccount, debit_amount, debit_currency,
               anl_postingdate, doc_drn, doc_orn, doc_localdate, doc_descr,
               doc_amount, doc_currency)
        select id, idn,
               anl_synthcode, anl_trndescr, anl_analyticrefn,
               credit_anlaccount, credit_amount, credit_currency,
               debit_anlaccount, debit_amount, debit_currency,
               anl_postingdate, doc_drn, doc_orn, doc_localdate, doc_descr,
               doc_amount, doc_currency
          from ow_oic_atransfers_hist
         where id = p_fileid and idn = p_fileidn;
        delete from ow_oic_atransfers_hist where id = p_fileid and idn = p_fileidn;
     end if;

     begin
        select *
          into l_atrn
          from ow_oic_atransfers_data
         where id = p_fileid
           and idn = p_fileidn;
     exception when no_data_found then
        bars_audit.info(h || 'Row not found p_fileid=>' || to_char(p_fileid) || ' p_fileidn=>' || to_char(p_fileidn));
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
     end;

     -- доп. реквизиты для файла аналитических проводок
     l_operw_tbl := t_operw();

     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_FL', l_filename);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_PD', to_char(l_atrn.anl_postingdate, 'dd.MM.yyyy'));
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_LD', to_char(l_atrn.doc_localdate, 'dd.MM.yyyy'));
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_DS', l_atrn.doc_descr);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_AM', to_char(l_atrn.doc_amount) || '/' || l_atrn.doc_currency);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_SC', l_atrn.anl_synthcode);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OWDRN', to_char(l_atrn.doc_drn));
     fill_operw_tbl(l_operw_tbl, p_ref, 'OWARN', l_atrn.anl_analyticrefn);

     forall i in 1 .. l_operw_tbl.count
        insert into operw values l_operw_tbl(i);

     irec_oic_atrn_to_arc(l_atrn, p_ref);

  elsif l_filetype = g_filetype_strn then

     -- если документ удаелен, восстанавливаем его
     if p_par = 0 then
        insert into ow_oic_stransfers_data (id, idn,
               synth_synthrefn, synth_synthcode, synth_trndescr,
               credit_syntaccount, credit_amount, credit_localamount, credit_currency,
               debit_syntaccount, debit_amount, debit_localamount, debit_currency,
               synth_postingdate)
        select id, idn,
               synth_synthrefn, synth_synthcode, synth_trndescr,
               credit_syntaccount, credit_amount, credit_localamount, credit_currency,
               debit_syntaccount, debit_amount, debit_localamount, debit_currency,
               synth_postingdate
          from ow_oic_stransfers_hist
         where id = p_fileid and idn = p_fileidn;
        delete from ow_oic_stransfers_hist where id = p_fileid and idn = p_fileidn;
     end if;

     begin
        select *
          into l_strn
          from ow_oic_stransfers_data
         where id = p_fileid
           and idn = p_fileidn;
     exception when no_data_found then
        bars_audit.info(h || 'Row not found p_fileid=>' || to_char(p_fileid) || ' p_fileidn=>' || to_char(p_fileidn));
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
     end;

     -- доп. реквизиты для файла синтетических проводок
     l_operw_tbl := t_operw();

     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_FL', l_filename);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_PD', to_char(l_strn.synth_postingdate, 'dd.MM.yyyy'));
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_DS', l_strn.synth_trndescr);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_SC', l_strn.synth_synthcode);

     forall i in 1 .. l_operw_tbl.count
        insert into operw values l_operw_tbl(i);

     -- удаление в архив
     irec_oic_strn_to_arc(l_strn, p_ref);

  elsif l_filetype = g_filetype_doc then

     -- если документ удаелен, восстанавливаем его
     if p_par = 0 then
        insert into ow_oic_documents_data (id, idn,
               doc_localdate, doc_descr, doc_drn, doc_socmnt, doc_trdetails,
               cnt_contractnumber, cnt_clientregnumber, cnt_clientname,
               org_cbsnumber, dest_institution,
               bill_phasedate, bill_amount, bill_currency, doc_data)
        select id, idn,
               doc_localdate, doc_descr, doc_drn, doc_socmnt, doc_trdetails,
               cnt_contractnumber, cnt_clientregnumber, cnt_clientname,
               org_cbsnumber, dest_institution,
               bill_phasedate, bill_amount, bill_currency, doc_data
          from ow_oic_documents_hist
         where id = p_fileid and idn = p_fileidn;
        delete from ow_oic_documents_hist where id = p_fileid and idn = p_fileidn;
     end if;

     begin
        select *
          into l_doc
          from ow_oic_documents_data
         where id = p_fileid
           and idn = p_fileidn;
     exception when no_data_found then
        bars_audit.info(h || 'Row not found p_fileid=>' || to_char(p_fileid) || ' p_fileidn=>' || to_char(p_fileidn));
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
     end;

     -- доп. реквизиты для файла документов
     l_operw_tbl := t_operw();

     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_FL', l_filename);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_LD', to_char(l_doc.doc_localdate, 'dd.MM.yyyy'));
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_DS', l_doc.doc_descr);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OW_AM', to_char(l_doc.bill_amount) || '/' || l_doc.bill_currency);
     fill_operw_tbl(l_operw_tbl, p_ref, 'OWDRN', to_char(l_doc.doc_drn));

     forall i in 1 .. l_operw_tbl.count
        insert into operw values l_operw_tbl(i);

     -- удаление в архив
     irec_oic_doc_to_arc(l_doc, p_ref);

  end if;

  bars_audit.info(h || 'Finish.');

end set_pay_flag;

-------------------------------------------------------------------------------
-- pay_oic_file
-- процедура оплаты файла
--
procedure pay_oic_file (p_id number)
is
  l_filetype ow_files.file_type%type;
  l_filename ow_files.file_name%type;
  l_filedate ow_files.file_date%type;
  h varchar2(100) := 'bars_ow.pay_oic_file. ';
begin

  bars_audit.info(h || 'Start.');

  begin
     select file_type, file_name, file_date
       into l_filetype, l_filename, l_filedate
       from ow_files
      where id = p_id;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_id=>' || to_char(p_id));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND', to_char(p_id));
  end;

  bars_audit.info(h || 'l_filetype=>' || l_filetype || ' l_filename=>' || l_filename);

  if l_filetype = g_filetype_atrn then

     update ow_oic_atransfers_data set err_text = null where id = p_id and nvl(state, 0) <> 99;
     ipay_oic_atransfers_file(p_id, l_filename, l_filedate);

  elsif l_filetype = g_filetype_ftrn then

     update ow_oic_atransfers_data set err_text = null where id = p_id and nvl(state, 0) <> 99;
     ipay_oic_ftransfers_file(p_id, l_filename);

  elsif l_filetype = g_filetype_strn then

     update ow_oic_stransfers_data set err_text = null where id = p_id  and nvl(state, 0) <> 99;
     ipay_oic_stransfers_file(p_id, l_filename);

  elsif l_filetype = g_filetype_doc then

     update ow_oic_documents_data set err_text = null where id = p_id  and nvl(state, 0) <> 99;
     ipay_oic_documents_file(p_id, l_filename);

  else
     raise_application_error(-20000, 'File with id ' || p_id || ' not OIC');
  end if;

  update ow_files set file_status = 2, err_text = null where id = p_id;
  if bars_login.is_long_session then
     bars_login.cleare_long_session;
  end if;
  bars_audit.info(h || 'Finish.');

end pay_oic_file;

-------------------------------------------------------------------------------
-- delete_file
-- процедура удаления файла (для возможности повторного импорта)
--
procedure delete_file (p_fileid number)
is
  l_filetype ow_files.file_type%type;
  l_filename ow_files.file_name%type;
  i number;
  h varchar2(100) := 'bars_ow.delete_file. ';
begin

  bars_audit.info(h || 'Start.');

  begin
     select file_type, file_name
       into l_filetype, l_filename
      from ow_files
     where id = p_fileid;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  -- если файл документов
  if l_filetype in (g_filetype_atrn, g_filetype_ftrn, g_filetype_strn, g_filetype_doc) then
     select count(*) into i from ow_oic_ref where id = p_fileid;
     if i > 0 then
        -- Невозможно удалить файл l_filename: есть оплаченные документы по файлу.
        bars_error.raise_nerror(g_modcode, 'IMPOSSIBLE_DELETE_FILE', l_filename);
     end if;
  end if;

  delete from ow_files where id = p_fileid;

  bars_audit.info(h || 'File ' || l_filename || ' deleted');

  bars_audit.info(h || 'Finish.');

end delete_file;

-------------------------------------------------------------------------------
function get_file_in_clob (p_par number) return clob
is
  l_b    blob;
  l_u    blob;
  l_clob clob;
begin
  select file_blob into l_b from ow_impfile where id = p_par;
  l_u := utl_compress.lz_uncompress(l_b);
  l_clob := blob_to_clob(l_u);
  update ow_impfile set file_data = l_clob where id = p_par;
  return l_clob;
end get_file_in_clob;

-------------------------------------------------------------------------------
-- load_file
-- процедура загрузки файла в БД
--
procedure load_file (
  p_filename  in varchar2,
  p_filebody  in blob,
  p_origin    in number,
  p_id       out number,
  p_msg      out varchar2 )
is
  l_filename   varchar2(100);
  l_filetype   varchar2(100);
  l_id         number := null;
  i            number;
  h varchar2(100) := 'bars_ow.load_file. ';
begin

  bars_audit.info(h || 'Start.');

  l_filename := upper(p_filename);

  -- определяем тип файла
  l_filetype := get_file_type(l_filename);
  bars_audit.info(h || 'l_filetype=>' || l_filetype);

  if l_filetype is null then
     p_msg := 'Невідомий тип файлу';
  else
     select count(*) into i
       from ow_files
      where substr(file_name, 1, instr(file_name, '.', -1)-1) = substr(l_filename, 1, instr(l_filename, '.', -1)-1);
     -- файл еще не принимался
     if i = 0 then
        begin
           select bars_sqnc.get_nextval('S_OWFILES') into l_id from dual;
           insert into ow_files (id, file_type, file_name, file_body, file_status, origin)
           values (l_id, l_filetype, l_filename, empty_blob(), 0, p_origin);
           update ow_files set file_body = p_filebody where id = l_id;
        exception when others then
           p_msg := sqlerrm;
        end;
     else
        p_msg := 'Файл вже імпортувався';
     end if;
  end if;

  p_id := l_id;

  bars_audit.info(h || 'Finish.' || 'p_msg=>' || p_msg);

end load_file;

-------------------------------------------------------------------------------
-- import_file
-- процедура импорта файла *.xml
--
procedure import_file (
  p_filename in     varchar2,
  p_fileid   in out number,
  p_msg         out varchar2 )
is
  l_filebody blob;
  l_id       number;
  l_msg      varchar2(2000) := null;
  h varchar2(100) := 'bars_ow.import_oic_file. ';
begin

  bars_audit.info(h || 'Start.');

  --l_filename := upper(p_filename);

  select file_blob into l_filebody from ow_impfile where id = p_fileid;

  load_file(
     p_filename => p_filename,
     p_filebody => l_filebody,
     p_origin   => 0,
     p_id       => l_id,
     p_msg      => l_msg );

  delete from ow_impfile where id = p_fileid;

  p_fileid := l_id;
  p_msg := l_msg;

  bars_audit.info(h || 'Finish.');

exception when no_data_found then
  raise_application_error(-20000,
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());
end import_file;

-------------------------------------------------------------------------------
-- процедура клиринга - межфилиальных расчетов между ГОУ и РУ
procedure cliring (p_par number)
is
  l_tt     oper.tt%type;
  l_vob    oper.vob%type;
  l_dk     oper.dk%type;
  l_nmsa   oper.nam_a%type;
  l_nlsa   oper.nlsa%type;
  l_mfoa   oper.mfoa%type;
  l_okpoa  oper.id_a%type;
  l_nmsb   oper.nam_b%type;
  l_nlsb   oper.nlsb%type;
  l_mfob   oper.mfob%type;
  l_okpob  oper.id_b%type;
  l_kv     oper.kv%type;
  l_s      oper.s%type;
  l_nazn   oper.nazn%type;
  l_ref    number;
  h varchar2(100) := 'bars_ow.cliring. ';

begin

  bars_audit.info(h || 'Start.');

  for z in ( select *
               from ow_filial
              where mfo  is not null
                and okpo is not null
                and nls  is not null
                and name is not null )
  loop

     for x in ( select acc, nls, kv, substr(nms,1,38) nms, ostc
                  from accounts
                 where nls = z.nls_gou
                   and ostc <> 0 )
     loop

        -- определяем операцию
        if x.ostc < 0 then

           if x.kv = 980 then
              -- W4C М_ЖФ_Л_ЙН_ розрах.(реальн.дебет) за операц. з використ.БПК(гривня)
              l_tt := 'W4C';
           else
              -- W4D М_ЖФ_Л_ЙН_ розрах.(реальн.дебет) за операц. з використ.БПК(валюта)
              l_tt := 'W4D';
           end if;

        else

           if x.kv = 980 then
              -- W4A М_ЖФ_Л_ЙН_ розрахунки за операц_ями з використанням БПК (гривня)
              l_tt := 'W4A';
           else
              -- W4B М_ЖФ_Л_ЙН_ розрахунки за операц_ями з використанням БПК (валюта)
              l_tt := 'W4B';
           end if;

        end if;

        begin
           select dk into l_dk from tts where tt = l_tt;
        exception when no_data_found then
            raise_application_error (-20000,
               dbms_utility.format_error_stack() || chr (10) ||
               dbms_utility.format_error_backtrace());
        end;
        begin
           select vob into l_vob from tts_vob where tt = l_tt and rownum = 1;
        exception when no_data_found then
            raise_application_error (-20000,
               dbms_utility.format_error_stack() || chr (10) ||
               dbms_utility.format_error_backtrace());
        end;

        l_nmsa  := x.nms;
        l_nlsa  := x.nls;
        l_mfoa  := gl.amfo;
        l_okpoa := f_ourokpo;
        l_nmsb  := z.name;
        l_nlsb  := z.nls;
        l_mfob  := z.mfo;
        l_okpob := z.okpo;

        l_s     := abs(x.ostc);
        l_kv    := x.kv;
        l_nazn  := 'Проведення розрахунків за операціями з використанням БПК за ' ||
                   to_char(dat_next_u(gl.bdate,-1), 'dd.MM.yyyy');

        l_ref := null;
        ipay_doc (
           p_tt    => l_tt,
           p_vob   => l_vob,
           p_dk    => l_dk,
           p_sk    => null,
           p_nam_a => l_nmsa,
           p_nlsa  => l_nlsa,
           p_mfoa  => l_mfoa,
           p_id_a  => l_okpoa,
           p_nam_b => l_nmsb,
           p_nlsb  => l_nlsb,
           p_mfob  => l_mfob,
           p_id_b  => l_okpob,
           p_kv    => l_kv,
           p_s     => l_s,
           p_kv2   => l_kv,
           p_s2    => l_s,
           p_nazn  => l_nazn,
           p_ref   => l_ref );

     end loop;

  end loop;

  bars_audit.info(h || 'Start.');

end cliring;

-------------------------------------------------------------------------------
-- found_client
-- функция поиска клиента по ОКПО и паспортным данным
--
function found_client (
  p_okpo    varchar2,
  p_paspser varchar2,
  p_paspnum varchar2,
  p_spd     number default 0 ) return number
is
  l_rnk         number := null;
  l_count_okpo  number;
  l_count_passp number;
  l_date_off    date;
begin

  if p_okpo is null
  or substr(p_okpo,1,5) = '99999'
  or substr(p_okpo,1,5) = '00000'
  or (p_paspser is null and length(p_paspnum)<>9)
  or p_paspnum is null then

     l_rnk := null;

  else

     -- ищем клиентов с ОКПО
     select count(*) into l_count_okpo
       from customer c
      where c.okpo = p_okpo
        and ( p_spd = 0 and nvl(trim(c.sed),'00') <> '91'
           or p_spd = 1 and nvl(trim(c.sed),'00') = '91' );

     -- ищем клиентов с паспортными данными
     select count(*) into l_count_passp
       from person p, customer c
      where nvl(p.ser,'0') = nvl(p_paspser,'0')
        and p.numdoc = p_paspnum
        and p.rnk = c.rnk
        and ( p_spd = 0 and nvl(trim(c.sed),'00') <> '91'
           or p_spd = 1 and nvl(trim(c.sed),'00') = '91' );

     -- есть клиенты с ОКПО и паспортными данными
     if l_count_okpo > 0 and l_count_passp > 0 then

        -- в банкке зарегистрирован один клиент с такими данными
        if l_count_okpo = 1 or l_count_passp = 1 then

           -- в customer и person это должен быть один клиент
           begin

              select c.rnk, c.date_off into l_rnk, l_date_off
                from customer c, person p
               where c.okpo   = p_okpo
                 and nvl(p.ser,'0') = nvl(p_paspser,'0')
                 and p.numdoc = p_paspnum
                 and c.rnk = p.rnk
                 and ( p_spd = 0 and nvl(trim(c.sed),'00') <> '91'
                    or p_spd = 1 and nvl(trim(c.sed),'00') = '91' );

              -- если клиент закрыт, реанимируем его
              if l_date_off is not null then
                 update customer set date_off = null where rnk = l_rnk;
              end if;

           exception when no_data_found then null;
           end;

        -- нашли нескольких клиентов с таким ОКПО
        elsif l_count_okpo > 1 then

           -- ищем среди открытых клиентов
           select max(c.rnk) into l_rnk
             from customer c, person p
            where c.okpo   = p_okpo
              and nvl(p.ser,'0') = nvl(p_paspser,'0')
              and p.numdoc = p_paspnum
              and c.rnk = p.rnk
              and c.date_off is null
              and ( p_spd = 0 and nvl(trim(c.sed),'00') <> '91'
                 or p_spd = 1 and nvl(trim(c.sed),'00') = '91' );

           -- среди открытых клиентов не нашли, ищем среди закрытых
           if l_rnk is null then

              select max(c.rnk) into l_rnk
                from customer c, person p
               where c.okpo   = p_okpo
                 and nvl(p.ser,'0') = nvl(p_paspser,'0')
                 and p.numdoc = p_paspnum
                 and c.rnk = p.rnk
                 and c.date_off is not null
                 and ( p_spd = 0 and nvl(trim(c.sed),'00') <> '91'
                    or p_spd = 1 and nvl(trim(c.sed),'00') = '91' );

              -- реанимируем клиента
              if l_rnk is not null then
                 update customer set date_off = null where rnk = l_rnk;
              end if;

           end if;

        end if;

     end if;

  end if;

  return l_rnk;

end found_client;

-------------------------------------------------------------------------------
-- alter_client
-- процедура обновления незаполненных реквизитов клиента
--
procedure alter_client (p_rnk number, p_clientdata ow_salary_data%rowtype)
is
  l_customer       customer%rowtype;
  l_person         person%rowtype;
  l_custadr1       customer_address%rowtype;
  l_custadr2       customer_address%rowtype;
  l_cust_fn        customerw.value%type;
  l_cust_ln        customerw.value%type;
  l_cust_mn        customerw.value%type;
  l_cust_mname     customerw.value%type;
  l_cust_phonemob  customerw.value%type;
  l_cust_email     customerw.value%type;
  l_cust_k013      customerw.value%type;
  l_cust_fgidx     customerw.value%type;
  l_cust_fgobl     customerw.value%type;
  l_cust_fgdst     customerw.value%type;
  l_cust_fgtwn     customerw.value%type;
  l_cust_fgadr     customerw.value%type;
  h varchar2(100) := 'bars_ow.alter_client. ';
begin

  bars_audit.info(h || 'Start. p_rnk=>' || p_rnk);

  if p_rnk is not null then

     -- данные клиента
     begin
        select * into l_customer from customer where rnk = p_rnk;
     exception when no_data_found then null;
     end;
     begin
        select * into l_person from person where rnk = p_rnk;
     exception when no_data_found then
        l_person.pdate  := null;
        l_person.organ  := null;
        l_person.bday   := null;
        l_person.sex    := null;
        l_person.teld   := null;
     end;
     begin
        select * into l_custadr1 from customer_address where rnk = p_rnk and type_id = 1;
     exception when no_data_found then
        l_custadr1.zip      := null;
        l_custadr1.domain   := null;
        l_custadr1.region   := null;
        l_custadr1.locality := null;
        l_custadr1.address  := null;
     end;
     begin
        select * into l_custadr2 from customer_address where rnk = p_rnk and type_id = 2;
     exception when no_data_found then
        l_custadr2.zip      := null;
        l_custadr2.domain   := null;
        l_custadr2.region   := null;
        l_custadr2.locality := null;
        l_custadr2.address  := null;
     end;
     begin
        select min(decode(tag,'SN_FN',value,null)),
               min(decode(tag,'SN_LN',value,null)),
               min(decode(tag,'SN_MN',value,null)),
               min(decode(tag,'PC_MF',value,null)),
               min(decode(tag,'MPNO ',value,null)),
               min(decode(tag,'EMAIL',value,null)),
               min(decode(tag,'K013 ',value,null)),
               min(decode(tag,'FGIDX',value,null)),
               min(decode(tag,'FGOBL',value,null)),
               min(decode(tag,'FGDST',value,null)),
               min(decode(tag,'FGTWN',value,null)),
               min(decode(tag,'FGADR',value,null))
          into l_cust_fn, l_cust_ln, l_cust_mn, l_cust_mname,
               l_cust_phonemob, l_cust_email, l_cust_k013,
               l_cust_fgidx, l_cust_fgobl, l_cust_fgdst, l_cust_fgtwn, l_cust_fgadr
          from customerw
         where rnk = p_rnk;
     exception when no_data_found then
        l_cust_phonemob := null;
        l_cust_email    := null;
     end;

     -- обновляем незаполненные данные
     if ( l_customer.nmkv is null and ( p_clientdata.eng_first_name is not null or p_clientdata.eng_last_name is not null ) )
     or ( l_customer.country is null and p_clientdata.country is not null )
     or l_customer.crisk is null then
        update customer
           set nmkv = nvl(nmkv, trim(p_clientdata.eng_last_name||' '||p_clientdata.eng_first_name)),
               country = nvl(country, p_clientdata.country),
               crisk   = nvl(crisk,1)
         where rnk = p_rnk;
     end if;

     if ( l_person.pdate is null
       or l_person.organ is null
       or l_person.bday  is null
       or l_person.sex   is null
       or l_person.teld  is null ) and
        ( p_clientdata.paspissuer is not null
       or p_clientdata.paspdate   is not null
       or p_clientdata.bday       is not null
       or p_clientdata.gender     is not null
       or p_clientdata.phone_home is not null ) then
        update person
           set pdate = nvl(pdate, p_clientdata.paspdate),
               organ = nvl(organ, substr(trim(p_clientdata.paspissuer),1,70)),
               bday  = nvl(bday,  p_clientdata.bday),
               sex   = nvl(sex,   p_clientdata.gender),
               teld  = nvl(teld,  p_clientdata.phone_home)
         where rnk = p_rnk;
     end if;
------------------address
     if ( l_custadr1.zip      is null
       or l_custadr1.domain   is null
       or l_custadr1.region   is null
       or l_custadr1.locality is null
       or l_custadr1.address  is null
       or l_custadr1.locality_type_n is null
       or l_custadr1.home            is null
       or l_custadr1.room            is null
       or l_custadr1.street_type_n   is null
       or l_custadr1.street          is null
        ) and
        ( p_clientdata.addr1_cityname is not null
       or p_clientdata.addr1_pcode    is not null
       or p_clientdata.addr1_domain   is not null
       or p_clientdata.addr1_region   is not null
       or p_clientdata.addr1_street   is not null
       or p_clientdata.addr1_city_type is not null
       or p_clientdata.addr1_bud       is not null
       or p_clientdata.addr1_flat      is not null
       or p_clientdata.addr1_streettype is not null
       or p_clientdata.addr1_streetname is not null
       ) then
        update customer_address
           set zip      = nvl(zip,      p_clientdata.addr1_pcode),
               domain   = nvl(domain,   p_clientdata.addr1_domain),
               region   = nvl(region,   p_clientdata.addr1_region),
               locality = nvl(locality, p_clientdata.addr1_cityname),
               address  = nvl(address,  p_clientdata.addr1_street),
               locality_type_n=nvl(locality_type_n,  p_clientdata.addr1_city_type),
               home=nvl(home,  p_clientdata.addr1_bud),
               room=nvl(room,  p_clientdata.addr1_flat),
               street_type_n=nvl(street_type_n,  p_clientdata.addr1_streettype),
               street=nvl(street,  p_clientdata.addr1_streetname)

         where rnk = p_rnk and type_id = 1;
        if sql%rowcount = 0 then
           insert into customer_address (rnk, type_id, country, zip, domain, region, locality, address,locality_type_n,home,room,street_type_n,street)
           values (p_rnk, 1, 804, p_clientdata.addr1_pcode, p_clientdata.addr1_domain, p_clientdata.addr1_region,p_clientdata.addr1_cityname ,p_clientdata.addr1_street,
                   p_clientdata.addr1_city_type,p_clientdata.addr1_bud,p_clientdata.addr1_flat,p_clientdata.addr1_streettype,p_clientdata.addr1_streetname
                   );
        end if;
     end if;

     if l_cust_fgidx is null and p_clientdata.addr1_pcode is not null then
        kl.setCustomerElement(
           Rnk_   => p_rnk,
           Tag_   => 'FGIDX',
           Val_   => trim(p_clientdata.addr1_pcode),
           Otd_   => 0
        );
     end if;

     if l_cust_fgobl is null and p_clientdata.addr1_domain is not null then
        kl.setCustomerElement(
           Rnk_   => p_rnk,
           Tag_   => 'FGOBL',
           Val_   => trim(p_clientdata.addr1_domain),
           Otd_   => 0
        );
     end if;

     if l_cust_fgdst is null and p_clientdata.addr1_region is not null then
        kl.setCustomerElement(
           Rnk_   => p_rnk,
           Tag_   => 'FGDST',
           Val_   => trim(p_clientdata.addr1_region),
           Otd_   => 0
        );
     end if;

     if l_cust_fgtwn is null and p_clientdata.addr1_cityname is not null then
        kl.setCustomerElement(
           Rnk_   => p_rnk,
           Tag_   => 'FGTWN',
           Val_   => trim(p_clientdata.addr1_cityname),
           Otd_   => 0
        );
     end if;

     if l_cust_fgadr is null and p_clientdata.addr1_street is not null then
        kl.setCustomerElement(
           Rnk_   => p_rnk,
           Tag_   => 'FGADR',
           Val_   => trim(p_clientdata.addr1_street),
           Otd_   => 0
        );
     end if;

     if ( l_custadr2.zip      is null
       or l_custadr2.domain   is null
       or l_custadr2.region   is null
       or l_custadr2.locality is null
       or l_custadr2.address  is null ) and
        ( p_clientdata.addr2_cityname is not null
       or p_clientdata.addr2_pcode    is not null
       or p_clientdata.addr2_domain   is not null
       or p_clientdata.addr2_region   is not null
       or p_clientdata.addr2_street   is not null ) then
        update customer_address
           set zip      = nvl(zip,      p_clientdata.addr2_pcode),
               domain   = nvl(domain,   p_clientdata.addr2_domain),
               region   = nvl(region,   p_clientdata.addr2_region),
               locality = nvl(locality, p_clientdata.addr2_cityname),
               address  = nvl(address,  p_clientdata.addr2_street)
         where rnk = p_rnk and type_id = 2;
        if sql%rowcount = 0 then
           insert into customer_address (rnk, type_id, country, zip, domain, region, locality, address)
           values (p_rnk, 2, 804, p_clientdata.addr2_pcode, p_clientdata.addr2_domain, p_clientdata.addr2_region, p_clientdata.addr2_cityname ,p_clientdata.addr2_street);
        end if;
     end if;

     if l_cust_fn is null then
        begin
           insert into customerw (rnk, tag, value, isp)
           values (p_rnk, 'SN_FN', p_clientdata.first_name, 0);
        exception when dup_val_on_index then
           update customerw
              set value = p_clientdata.first_name
            where rnk = p_rnk and tag = 'SN_FN';
        end;
     end if;

     if l_cust_ln is null then
        begin
           insert into customerw (rnk, tag, value, isp)
           values (p_rnk, 'SN_LN', p_clientdata.last_name, 0);
        exception when dup_val_on_index then
           update customerw
              set value = p_clientdata.last_name
            where rnk = p_rnk and tag = 'SN_LN';
        end;
     end if;

     if l_cust_mn is null then
        begin
           insert into customerw (rnk, tag, value, isp)
           values (p_rnk, 'SN_MN', p_clientdata.middle_name, 0);
        exception when dup_val_on_index then
           update customerw
              set value = p_clientdata.middle_name
            where rnk = p_rnk and tag = 'SN_MN';
        end;
     end if;

     if l_cust_mname is null then
        begin
           insert into customerw (rnk, tag, value, isp)
           values (p_rnk, 'PC_MF', p_clientdata.mname, 0);
        exception when dup_val_on_index then
           update customerw
              set value = p_clientdata.mname
            where rnk = p_rnk and tag = 'PC_MF';
        end;
     end if;

     if l_cust_phonemob is null then
        begin
           insert into customerw (rnk, tag, value, isp)
           values (p_rnk, 'MPNO ', p_clientdata.phone_mob, 0);
        exception when dup_val_on_index then
           update customerw
              set value = p_clientdata.phone_mob
            where rnk = p_rnk and tag = 'MPNO ';
        end;
     end if;

     if l_cust_email is null then
        begin
           insert into customerw (rnk, tag, value, isp)
           values (p_rnk, 'EMAIL', p_clientdata.email, 0);
        exception when dup_val_on_index then
           update customerw
              set value = p_clientdata.email
            where rnk = p_rnk and tag = 'EMAIL';
        end;
     end if;

     if l_cust_k013 is null then
        begin
           insert into customerw (rnk, tag, value, isp)
           values (p_rnk, 'K013', '5', 0);
        exception when dup_val_on_index then
           update customerw
              set value = '5'
            where rnk = p_rnk and tag = 'K013';
        end;
     end if;

  end if;

  bars_audit.info(h || 'Finish.');

exception when others then
  raise_application_error(-20000, 'Помилка поновлення реквізитів клієнта РНК ' || p_rnk || ' : ' || sqlerrm, true);
end alter_client;

-------------------------------------------------------------------------------
-- import_op_file
-- процедура импорта файла на обновление реквизитов клиентоа OpenPack.xml
--
procedure import_op_file (
  p_impid  in number,
  p_err   out number )
is
  l_clob      clob;
  l_xml_full  xmltype;
  l_xml       xmltype;
  c_rowset    varchar2(100) := '/ROWSET/';
  c_row       varchar2(100);
  i           number;
  l_rnk       number;
  l_filerow   ow_salary_data%rowtype;
  l_tmp       varchar2(254);
  l_clob_ticbody clob := null;
  l_clob_tic     clob := null;
  l_tic_row      number := 0;

  h varchar2(100) := 'bars_ow.import_op_file. ';
begin

  bars_audit.info(h || 'Start.');

  l_clob := get_file_in_clob(p_impid);

  l_xml_full := xmltype(l_clob);

  dbms_lob.createtemporary(l_clob_tic,FALSE);
  dbms_lob.createtemporary(l_clob_ticbody,FALSE);

  i := 0;

  loop

     -- счетчик клиентов
     i := i + 1;

     c_row := c_rowset || 'ROW[' || i || ']';

     -- выход при отсутствии транзакций
     if l_xml_full.existsnode(c_row) = 0 then
        exit;
     end if;

     l_xml := xmltype(extract(l_xml_full,c_row,null));

     l_tmp := extract(l_xml, '/ROW/OKPO/text()', null);
     l_filerow.okpo           := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,14);

     l_tmp := extract(l_xml, '/ROW/FIRST_NAME/text()', null);
     l_filerow.first_name     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);

     l_tmp := extract(l_xml, '/ROW/LAST_NAME/text()', null);
     l_filerow.last_name      := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);

     l_tmp := extract(l_xml, '/ROW/MIDDLE_NAME/text()', null);
     l_filerow.middle_name    := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);

     l_tmp := extract(l_xml, '/ROW/PASPSERIES/text()', null);
     l_filerow.paspseries     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,10);

     l_tmp := extract(l_xml, '/ROW/PASPNUM/text()', null);
     l_filerow.paspnum        := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,20);

     l_rnk := found_client(l_filerow.okpo, l_filerow.paspseries, l_filerow.paspnum);

     -- не нашли клиента, запоминаем его ФИО для формирования квитанции
     if l_rnk is null then

        l_tic_row := l_tic_row + 1;
        dbms_lob.append(l_clob_ticbody, chr(13) || chr(10) || trim(
           l_filerow.last_name || ' ' ||
           l_filerow.first_name || ' ' ||
           l_filerow.middle_name || ',' ||
           l_filerow.okpo));

     -- нашли клиента, разбираем строку дальше и обновляем реквизиты
     else

        l_tmp := extract(l_xml, '/ROW/PASPISSUER/text()', null);
        l_filerow.paspissuer     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);

        l_tmp := extract(l_xml, '/ROW/PASPDATE/text()', null);
        l_filerow.paspdate       := to_date(trim(dbms_xmlgen.convert(l_tmp,1)),'dd.mm.yyyy');

        l_tmp := extract(l_xml, '/ROW/BDAY/text()', null);
        l_filerow.bday           := to_date(trim(dbms_xmlgen.convert(l_tmp,1)),'dd.mm.yyyy');

        l_tmp := extract(l_xml, '/ROW/COUNTRY/text()', null);
        l_filerow.country        := to_number(trim(dbms_xmlgen.convert(l_tmp,1)));

        l_tmp := extract(l_xml, '/ROW/RESIDENT/text()', null);
        l_filerow.resident       := to_number(trim(dbms_xmlgen.convert(l_tmp,1)));

        l_tmp := extract(l_xml, '/ROW/GENDER/text()', null);
        l_filerow.gender         := to_number(trim(dbms_xmlgen.convert(l_tmp,1)));

        l_tmp := extract(l_xml, '/ROW/ENG_FIRST_NAME/text()', null);
        l_filerow.eng_first_name := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/ENG_LAST_NAME/text()', null);
        l_filerow.eng_last_name := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/MNAME/text()', null);
        l_filerow.mname         := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,20);

        l_tmp := extract(l_xml, '/ROW/ADDR1_CITYNAME/text()', null);
        l_filerow.addr1_cityname := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/ADDR1_PCODE/text()', null);
        l_filerow.addr1_pcode    := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,20);

        l_tmp := extract(l_xml, '/ROW/ADDR1_DOMAIN/text()', null);
        l_filerow.addr1_domain   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/ADDR1_REGION/text()', null);
        l_filerow.addr1_region   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/ADDR1_STREET/text()', null);
        l_filerow.addr1_street   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);

        l_tmp := extract(l_xml, '/ROW/ADDR2_CITYNAME/text()', null);
        l_filerow.addr2_cityname := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/ADDR2_PCODE/text()', null);
        l_filerow.addr2_pcode    := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,20);

        l_tmp := extract(l_xml, '/ROW/ADDR2_DOMAIN/text()', null);
        l_filerow.addr2_domain   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/ADDR2_REGION/text()', null);
        l_filerow.addr2_region   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,30);

        l_tmp := extract(l_xml, '/ROW/ADDR2_STREET/text()', null);
        l_filerow.addr2_street   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);

        l_tmp := extract(l_xml, '/ROW/PHONE_MOB/text()', null);
        l_filerow.phone_mob      := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,20);

        l_tmp := extract(l_xml, '/ROW/PHONE_HOME/text()', null);
        l_filerow.phone_home     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,12);

        l_tmp := extract(l_xml, '/ROW/EMAIL/text()', null);
        l_filerow.email          := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,32);

        alter_client(l_rnk, l_filerow);

     end if;

  end loop;

  if l_tic_row = 0 then
     dbms_lob.append(l_clob_tic, 'Реквізити клієнтів успішно поновлено');
  else
     dbms_lob.append(l_clob_tic, 'Не знайдено наступних клієнтів');
  end if;
  dbms_lob.append(l_clob_tic, l_clob_ticbody);

  update ow_impfile set file_data = l_clob_tic where id = p_impid;

  p_err := null;

  bars_audit.info(h || 'Finish.');

end import_op_file;


-------------------------------------------------------------------------------
-- import_files
-- импорт различных файлов (данные уже помещены в табл. imp_file)
--
procedure import_files (
  p_mode     number,
  p_filename varchar2 )
is
  l_clob clob;
begin
  begin
     select file_clob into l_clob from imp_file where file_name = p_filename;
  exception when no_data_found then
     raise_application_error(-20000, 'Дані файлу ' || p_filename || ' не знайдено');
  end;
  if p_mode = 1 then
     iparse_cm_mobile_file(l_clob, p_filename);
  end if;
end import_files;

-------------------------------------------------------------------------------
-- set_form_flag
-- процедура установки флага отбора документа в файл для Way4
--
procedure set_form_flag (
  p_ref       number,
  p_dk        number,
  p_acc       number,
  p_filename  ow_pkk_que.f_n%type,
  p_tt        varchar2,
  p_msgcode   varchar2 )
is
  h varchar2(100) := 'bars_ow.set_form_flag. ';
begin

  bars_audit.trace(h || 'Satrt.');

  -- документы
  if p_dk is not null then

     update ow_pkk_que
        set sos = 1,
            f_n = p_filename,
            unform_flag = null,
            unform_user = null,
            unform_date = null
      where ref = p_ref
        and dk  = p_dk
        and sos = 0;

     -- пополнение
     if p_dk = 1 then

        -- добавление доп. реквизита "Отправлен в файле"
        set_operw (p_ref, 'W4FN', p_filename);

     -- списание
     else

        -- добавление доп. реквизита "Отправлен в файле"
        set_operw (p_ref, 'W4FN2', p_filename);

     end if;

     -- добавление доп. реквизита "Код транзакции"
     set_operw (p_ref, 'W4MSG', p_msgcode);

     if p_tt = g_tt_asg then
        set_cck_sob (p_ref, p_dk, p_acc, 1, true);
     end if;

  -- счета
  else

     update ow_acc_que
        set sos = 1,
            f_n = p_filename
      where acc = p_acc
        and sos = 0;

  end if;

  bars_audit.trace(h || 'Finish.');

end set_form_flag;

-------------------------------------------------------------------------------
-- get_iicfile_num - возвращает
--
function get_iicfile_num return number
is
  l_filename ow_iicfiles.file_name%type;
  l_counter number;
begin

  begin
     select file_name into l_filename
       from ow_iicfiles
      where rownum = 1
        for update wait 5;
  exception when no_data_found then null;
  end;

  select nvl(max(to_number(substr(replace(lower(file_name),'.xml',''),instr(lower(file_name),'_',-1)+1))),0)+1
    into l_counter
    from ow_iicfiles
   where trunc(file_date) = trunc(sysdate);

  return l_counter;

end get_iicfile_num;

-------------------------------------------------------------------------------
-- get_iicfile_header - возвращает заголовок файла IIC*
--
function get_iicfile_header ( p_filename out varchar2 ) return xmltype
is
  l_counter number;
  l_header  xmltype;
begin

  l_counter := get_iicfile_num;

  select
     XmlElement("FileHeader",
        XmlForest(
           'PAYMENT' "FileLabel",
           '2.1' "FormatVersion",
           g_w4_branch "Sender",
           to_char(sysdate, 'yyyy-MM-dd') "CreationDate",
           to_char(sysdate, 'hh24:mi:ss') "CreationTime",
           l_counter "FileSeqNumber",
           g_w4_branch "Receiver"
         )
     )
  into l_header from dual;

  p_filename := 'IIC_Documents_' || rpad(g_w4_branch,4,'0') || '__' || to_char(sysdate,'yyyymmdd') || '_' || to_char(l_counter) || '.xml' ;

  return l_header;

end get_iicfile_header;

-------------------------------------------------------------------------------
-- get_oicfile_num - возвращает номер файла
--
function get_oicfilerev_num return number
is
  l_filename ow_iicfiles.file_name%type;
  l_counter number;
begin

  begin
     select file_name into l_filename
       from ow_oicrevfiles
      where rownum = 1
        for update wait 5;
  exception when no_data_found then null;
  end;

  select nvl(max(to_number(substr(replace(lower(file_name),'.xml',''),instr(lower(file_name),'_',-1)+1))),0)+1
    into l_counter
    from ow_oicrevfiles
   where trunc(file_date) = trunc(sysdate);

  return l_counter;

end get_oicfilerev_num;

-------------------------------------------------------------------------------
-- get_oicrevcfile_header - возвращает заголовок файла OIC*LOCPAYREV*
--
function get_oicrevcfile_header ( p_filename out varchar2 ) return xmltype
is
  l_counter number;
  l_header  xmltype;
begin

  l_counter := get_oicfilerev_num;

  select
     XmlElement("FileHeader",
        XmlForest(
           'DOCUMENT' "FileLabel",
           '2.1' "FormatVersion",
           g_w4_branch "Sender",
           to_char(sysdate, 'yyyy-MM-dd') "CreationDate",
           to_char(sysdate, 'hh24:mi:ss') "CreationTime",
           l_counter "FileSeqNumber",
           'LOCPAYREV' "Receiver"
         )
     )
  into l_header from dual;

  p_filename := 'OIC_Documents_' || rpad(g_w4_branch,4,'0') || '_LOCPAYREV_' || to_char(sysdate,'yyyymmdd') || '_' || to_char(l_counter) || '.xml' ;

  return l_header;

end get_oicrevcfile_header;
-------------------------------------------------------------------------------
-- get_iicfile_data
--
function get_iicfile_data (
  p_doc_tbl    in t_iicdoc_tbl,
  p_file_name  in varchar2,
  p_count     out number,
  p_summ      out number ) return xmltype
is
  l_count   number := 0;
  l_summ    number := 0;
  l_acc     number;
  l_nazn    varchar2(250);
  l_data    xmltype := null;
  l_xml_tmp xmltype := null;
begin

  for i in 1..p_doc_tbl.count loop

     begin
        l_nazn := null;
        if p_doc_tbl(i).dk is not null then
           select acc into l_acc from ow_pkk_que where ref = p_doc_tbl(i).ref and dk = p_doc_tbl(i).dk and sos = 0 for update skip locked;
           l_nazn := '#'||to_char(p_doc_tbl(i).ref)||'#'||p_doc_tbl(i).nazn;
        else
           select acc into l_acc from ow_acc_que where acc = p_doc_tbl(i).acc and sos = 0 for update skip locked;
           l_nazn := p_doc_tbl(i).nazn;
        end if;

        l_count := l_count + 1;
        l_summ  := l_summ  + p_doc_tbl(i).s;

        select
           XmlElement("Doc",
              XmlElement("TransType",
                 XmlElement("TransCode",
                    XmlElement("MsgCode", p_doc_tbl(i).msgcode)
                 ) -- TransCode
              ), -- TransType
              XmlElement("DocRefSet",
                 XmlElement("Parm",
                    XmlElement("ParmCode", 'SRN'),
                    XmlElement("Value", p_doc_tbl(i).ref)
                 ) -- Parm
              ), -- DocRefSet
              XmlElement("LocalDt", to_char(p_doc_tbl(i).vdat, 'yyyy-MM-dd hh24:mi:ss')),
              XmlElement("Description", Convert(l_nazn,'UTF8','CL8MSWIN1251')),
              XmlElement("Originator",
                 XmlElement("ContractNumber", 'NLS_TRANS'),
                 XmlElement("MemberId", 'PAY'||g_w4_branch)
              ), -- Originator
              XmlElement("Destination",
                 XmlElement("ContractNumber", g_w4_branch||'-'||p_doc_tbl(i).nls),
                 XmlElement("MemberId", 'PAY'||g_w4_branch)
              ), -- Destination
              XmlElement("Transaction",
                 XmlElement("Currency", p_doc_tbl(i).kv),
                 XmlElement("Amount", p_doc_tbl(i).s)
              ) -- Transaction
           ) -- Doc
        into l_xml_tmp
        from dual;

        select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

        set_form_flag(p_doc_tbl(i).ref, p_doc_tbl(i).dk, l_acc, p_file_name, p_doc_tbl(i).tt, p_doc_tbl(i).msgcode);

     exception when no_data_found then null;
     end get_line;

  end loop;

  if l_count > 0 then
     select XmlElement("DocList", l_data) into l_data from dual;
  end if;

  p_count := l_count;
  p_summ  := l_summ;

  return l_data;

end get_iicfile_data;

-------------------------------------------------------------------------------
-- get_iicfile_data - возвращает тело файла
--
function get_iicfile_data (
  p_mode       in number,
  p_file_name  in varchar2,
  p_count     out number,
  p_summ      out number ) return xmltype
is
  l_doc_tbl t_iicdoc_tbl := t_iicdoc_tbl();
  l_count   number := 0;
  l_summ    number := 0;
  l_data    xmltype := null;
  h varchar2(100) := 'bars_ow.get_iicfile_data. ';

begin

  bars_audit.info(h || 'Start.');

  -- документы по погашению КД с 2625
  if p_mode = 1 then
     select * bulk collect into l_doc_tbl from v_ow_iicfiles_form_kd where rownum <= g_iicnum;
  -- документы регулярных платежей по БПК
  elsif p_mode = 2 then
     select * bulk collect into l_doc_tbl from v_ow_iicfiles_form_sto where rownum <= g_iicnum;
  -- все документы
  else
     select * bulk collect into l_doc_tbl from v_ow_iicfiles_form where rownum <= g_iicnum;
  end if;

  l_data := get_iicfile_data(l_doc_tbl, p_file_name, l_count, l_summ);

  p_count := l_count;
  p_summ  := l_summ;

  bars_audit.info(h || 'p_count=>' || to_char(p_count) || ' p_summ=>' || to_char(p_summ));
  bars_audit.info(h || 'Finish.');

  return l_data;

end get_iicfile_data;

-------------------------------------------------------------------------------
-- get_oicrevcfile_data - возвращает тело файла
--
function get_oicrevfile_data(p_mode      in number,
                             p_file_name in varchar2,
                             p_count     out number,
                             p_summ      out number) return xmltype is
  l_count      number := 0;
  l_summ       number := 0;
  l_data       xmltype := null;
  h            varchar2(100) := 'bars_ow.get_oicrevcfile_data. ';
  l_indoc      clob := '<root>';
  l_xsldoc     varchar2(32000) := '<?xml version="1.0"?>
                                   <xsl:stylesheet version="1.0"
                                                   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                                     <xsl:output encoding="utf-8"/>
                                     <xsl:template match="/">
                                       <DocList>
                                         <xsl:for-each select="root/Doc">
                                           <Doc>
                                             <TransType>
                                               <TransCode>
                                                 <MsgCode>
                                                   <xsl:value-of select="concat(TransType/TransCode/MsgCode,''Rev'')"/>
                                                 </MsgCode>
                                               </TransCode>
                                             </TransType>
                                             <DocRefSet>
                                               <xsl:for-each select="DocRefSet/Parm">
                                                 <xsl:if test="ParmCode=''RRN'' or ParmCode=''AuthCode''">
                                                   <Parm>
                                                     <xsl:copy-of select="*"/>
                                                   </Parm>
                                                 </xsl:if>
                                               </xsl:for-each>
                                             </DocRefSet>
                                             <xsl:copy-of select="LocalDt"/>
                                             <xsl:copy-of select="Description"/>
                                             <SourceDtls></SourceDtls>
                                             <Originator>
                                                <xsl:copy-of select="Originator/ContractNumber"/>
                                                <Client>
                                                  <ClientInfo>
                                                    <xsl:copy-of select="Originator/Client/ClientInfo/ShortName"/>
                                                  </ClientInfo>
                                                </Client>
                                                <xsl:copy-of select="Originator/MemberId"/>
                                             </Originator>
                                             <Destination>
                                               <xsl:copy-of select="Destination/ContractNumber"/>
                                               <xsl:copy-of select="Destination/MemberId"/>
                                             </Destination>
                                             <Transaction>
                                               <xsl:copy-of select="Transaction/Currency"/>
                                               <xsl:copy-of select="Transaction/Amount"/>
                                             </Transaction>
                                           </Doc>
                                         </xsl:for-each>
                                       </DocList>
                                     </xsl:template>
                                    </xsl:stylesheet>';
  l_myparser   dbms_xmlparser.parser;
  l_indomdoc   dbms_xmldom.domdocument;
  l_xsltdomdoc dbms_xmldom.domdocument;
  l_xsl        dbms_xslprocessor.stylesheet;
  l_outdomdocf dbms_xmldom.domdocumentfragment;
  l_outnode    dbms_xmldom.domnode;
  l_proc       dbms_xslprocessor.processor;
  l_buf        clob;
  l_tmpdoc     xmltype;
begin
  bars_audit.info(h || 'Start.');

  select xmlagg(appendchildxml(xmltype(t.doc_data),
                                          '/Doc',
                                          xmltype('<Description>' ||
                                                  convert(substr('Відміна операції по причині: ' ||
                                                          t.err_text, 1, 254),
                                                          'UTF8',
                                                          'CL8MSWIN1251') ||
                                                  '</Description>'))), sum(t.bill_amount), count(*)
    into l_tmpdoc, l_summ, l_count
    from V_OW_OICREVFILES_FORM t;
  if l_count > 0 then
     l_myparser := dbms_xmlparser.newparser;
     dbms_lob.createtemporary(l_buf, false);
     l_indoc := l_indoc || l_tmpdoc.getclobval() || '</root>';
     dbms_xmlparser.parseclob(l_myparser, l_indoc);
     l_indomdoc := dbms_xmlparser.getdocument(l_myparser);
     dbms_xmlparser.parsebuffer(l_myparser, l_xsldoc);
     l_xsltdomdoc := dbms_xmlparser.getdocument(l_myparser);
     l_xsl        := dbms_xslprocessor.newstylesheet(l_xsltdomdoc, '');
     l_proc       := dbms_xslprocessor.newprocessor;

    --apply stylesheet to DOM document
     l_outdomdocf := dbms_xslprocessor.processxsl(l_proc, l_xsl, l_indomdoc);
     l_outnode    := dbms_xmldom.makenode(l_outdomdocf);

    -- PL/SQL DOM API for XMLType can be used here
     dbms_xmldom.writetoclob(l_outnode, l_buf);
     l_data := xmltype(l_buf);

     dbms_xmldom.freedocument(l_indomdoc);
     dbms_xmldom.freedocument(l_xsltdomdoc);
     dbms_xmldom.freedocfrag(l_outdomdocf);
     dbms_xmlparser.freeparser(l_myparser);
     dbms_xslprocessor.freeprocessor(l_proc);
  end if;
  p_count := l_count;
  p_summ  := l_summ;

  bars_audit.info(h || 'p_count=>' || to_char(p_count) || ' p_summ=>' ||
                  to_char(p_summ));
  bars_audit.info(h || 'Finish.');
  return l_data;

end get_oicrevfile_data;
-------------------------------------------------------------------------------
procedure get_iicfilebody (p_mode number, p_filename out varchar2, p_filebody out clob)
is
  l_file_name    varchar2(100);
  l_file_header  xmltype;
  l_file_data    xmltype;
  l_file_trailer xmltype;
  l_xml_data     xmltype;
  l_clob_data    clob;
  l_count        number;
  l_summ         number;
  h varchar2(100) := 'bars_ow.get_iicfilebody. ';
begin

  bars_audit.info(h || 'Start.');
  if p_mode = 3 then
    -- FileHeader
    l_file_header :=get_oicrevcfile_header(l_file_name);
    bars_audit.info(h || 'LOCPAYREV File header formed');

    -- резервируем имя файла, если будет работать несколько пользователей
    insert into ow_oicrevfiles (file_name, file_date)
    values (l_file_name, sysdate);
    commit;
    -- FileData
    l_file_data := get_oicrevfile_data(p_mode, l_file_name, l_count, l_summ);
    bars_audit.info(h || 'LOCPAYREV File data formed. l_count=>' || to_char(l_count));

    if l_count = 0 then

       delete from ow_oicrevfiles where file_name = l_file_name;
       l_file_name := null;
  --     l_clob_data := empty_clob();
       l_clob_data := ' ';

    else

       -- FileTrailer
       select
          XmlElement("FileTrailer",
             XmlElement("CheckSum",
                XmlElement("RecsCount", l_count),
                XmlElement("HashTotalAmount", l_summ)
             )
          )
       into l_file_trailer from dual;

       -- компоновка всего отчета
       select
         XmlElement("DocFile",
            XmlConcat(
               l_file_header,
               l_file_data,
               l_file_trailer
            )
         )
       into l_xml_data
       from dual;

       dbms_lob.createtemporary(l_clob_data,FALSE);
       dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="UTF-8"?>');
       dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

       update ow_oicrevfiles
          set file_n = l_count,
              file_s = l_summ
        where file_name = l_file_name;
      --отметим документы, которые попали в файл реверсала
       update ow_locpay_match t
          set t.state = 1,
              t.revfile_name = l_file_name
       where t.revflag in(1, 2) and (t.state = 0 or (t.state = 10 AND t.revfile_name IS NULL));

    end if;
  elsif p_mode in(0, 1, 2) or p_mode is null then
    -- FileHeader
    l_file_header := get_iicfile_header(l_file_name);
    bars_audit.info(h || 'File header formed');

    -- резервируем имя файла, если будет работать несколько пользователей
    insert into ow_iicfiles (file_name, file_date)
    values (l_file_name, sysdate);
    commit;

    -- FileData
    l_file_data := get_iicfile_data(p_mode, l_file_name, l_count, l_summ);
    bars_audit.info(h || 'File data formed. l_count=>' || to_char(l_count));

    if l_count = 0 then

       delete from ow_iicfiles where file_name = l_file_name;
       commit;
       l_file_name := null;
  --     l_clob_data := empty_clob();
       l_clob_data := ' ';

    else

       -- FileTrailer
       select
          XmlElement("FileTrailer",
             XmlElement("CheckSum",
                XmlElement("RecsCount", l_count),
                XmlElement("HashTotalAmount", l_summ)
             )
          )
       into l_file_trailer from dual;

       -- компоновка всего отчета
       select
         XmlElement("DocFile", XmlAttributes('http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi"),
            XmlConcat(
               l_file_header,
               l_file_data,
               l_file_trailer
            )
         )
       into l_xml_data
       from dual;

       dbms_lob.createtemporary(l_clob_data,FALSE);
       dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="UTF-8"?>');
       dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

       update ow_iicfiles
          set file_n = l_count,
              file_s = l_summ
        where file_name = l_file_name;

    end if;
  end if;
  l_file_header  := null;
  l_file_data    := null;
  l_file_trailer := null;
  l_xml_data     := null;

  p_filename := l_file_name;
  p_filebody := l_clob_data;

  bars_audit.info(h || 'Finish. p_filename=>' || p_filename || ' file_n=>' || l_count || ' file_s=>' || l_summ);

end get_iicfilebody;

-------------------------------------------------------------------------------
-- form_iic_file
--
procedure form_iic_file (p_mode in out number, p_filename out varchar2, p_impfileid out number)
is
  l_filename  varchar2(100);
  l_fileclob  clob;
  h varchar2(100) := 'bars_ow.form_iic_file. ';
begin

  bars_audit.info(h || 'Start.p_mode=>'||p_mode);

  get_iicfilebody (p_mode, l_filename, l_fileclob);

  if l_filename is not null then
     p_impfileid := get_impid;
     insert into ow_impfile (id, file_data) values (p_impfileid, l_fileclob);
  else
     p_mode := null;
  end if;

  p_filename := l_filename;

  bars_audit.info(h || 'Finish. p_filename=>' || p_filename);

end form_iic_file;

-------------------------------------------------------------------------------
-- unform_iic_doc
--
procedure unform_iic_doc (
  p_filename in varchar2,
  p_ref      in number,
  p_dk       in number )
is
  l_resp_code varchar2(100);
begin
begin
    select t.resp_code
      into l_resp_code
      from ow_pkk_que t
     where t.ref = p_ref and t.f_n = p_filename and t.dk = p_dk;

    if l_resp_code = '0' then
      raise_application_error(-20000,
                              'Документ Реф. ' || p_ref ||
                              ' успішно оброблений. Переформування заборонено.');
    end if;
  exception
    when no_data_found then
      begin
        select t.resp_code
          into l_resp_code
          from ow_pkk_history t
         where t.ref = p_ref and t.f_n = p_filename and t.dk = p_dk;
        if l_resp_code = '0' then
          raise_application_error(-20000,
                                  'Документ Реф. ' || p_ref ||
                                  ' успішно оброблений. Переформування заборонено.');
        end if;
      exception
        when no_data_found then
          raise_application_error(-20000,
                                  'Документ Реф. ' || p_ref ||
                                  ' Не відправлявся в файлі.');
      end;
  end;

  update ow_pkk_que
     set sos = 0,
         f_n = null,
         resp_class = null,
         resp_code = null,
         resp_text = null,
         unform_flag = 1,
         unform_user = user_id,
         unform_date = sysdate
   where f_n = p_filename
     and ref = p_ref
     and dk  = p_dk
     and sos = 1;

  delete from operw where ref = p_ref and tag = decode(p_dk,1,'W4FN ','W4FN2');
  delete from operw where ref = p_ref and tag = 'W4MSG';

end unform_iic_doc;

-------------------------------------------------------------------------------
-- unform_iic_acc
-- процедура снятия отметки об отправке счета
--
procedure unform_iic_acc (
  p_filename in varchar2,
  p_acc      in number )
is
begin

  update ow_acc_que
     set sos = 0,
         f_n = null
   where f_n = p_filename
     and acc = p_acc
     and sos = 1;

exception when dup_val_on_index then

  delete from ow_acc_que
   where f_n = p_filename
     and acc = p_acc
     and sos = 1;

end unform_iic_acc;

procedure unform_iic(p_file_name in varchar2,
                     p_ref       in number,
                     p_dk        in number,
                     p_acc       in number) is
begin
  bars_audit.info('unform_iic:'||p_file_name||to_char(p_ref));
  if p_ref is not null then
    unform_iic_doc(p_filename => p_file_name, p_ref => p_ref, p_dk => p_dk);
  else
    unform_iic_acc(p_filename => p_file_name, p_acc => p_acc);
  end if;
end;
-------------------------------------------------------------------------------
-- set_acc_rate
-- процедура установки % ставки
--
procedure set_acc_rate (
  p_mode  varchar2,
  p_acc   number,
  p_rate  number )
is
  l_ir    int_ratn.ir%type;
  l_bdat  int_ratn.bdat%type;
  l_id    number;
  l_flag  boolean := false;
  i number;
  h varchar2(100) := 'bars_ow.set_acc_rate. ';
begin

  bars_audit.trace(h || 'Start: p_mode=>' || to_char(p_mode) || ' p_acc=>' || to_char(p_acc) || ' p_rate=>' || to_char(p_rate));

  -- Процентная ставка по текущему счету
  if p_mode = 'PK' then
     l_id := 1;
  -- Процентная ставка по счету мобильных сбережений (депозитный)
  elsif p_mode = 'MOB' then
     l_id := 1;
  -- Процентная ставка по кредитному счету
  elsif p_mode = 'KRED' then
     l_id := 0;
  -- Процентная ставка по счету несанкционированного овердрафта
  elsif p_mode = 'OVR' then
     l_id := 0;
  else
     -- Неизвестный режим счета p_mode
     bars_error.raise_nerror(g_modcode, 'UNKNOWN_MODE', p_mode);
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
     if l_ir is null or l_ir <> p_rate then

        -- если дата старая, добавляем
        if l_bdat <> bankdate then

           insert into int_ratn (acc, id, bdat, ir, idu)
           values (p_acc, l_id, bankdate, p_rate, user_id);
           l_flag := true;

        -- если сегодняшняя, меняем
        else

           update int_ratn
              set ir = p_rate
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
     values (p_acc, l_id, l_bdat, p_rate, user_id);
     l_flag := true;

  end;

--  if l_flag then
--     commit;
--  end if;

  bars_audit.trace(h || 'Finish.');

exception when no_data_found then null;
end set_acc_rate;

-------------------------------------------------------------------------------
-- set_accounts_rate
-- процедура установки % ставок
--
procedure set_accounts_rate (
  -- p_par: =0-по всем счетам / =w4_acc.nd
  p_par number )
is
  h varchar2(100) := 'bars_ow.set_accounts_rate. ';
begin

  bars_audit.info(h || 'Start.');

  -- установка %% ставок по всем счетам БПК
  if p_par = 0 then

     -- установка % ставки по основному счета
     -- установка % ставки по счету несанкционированного овердрафта
     for z in ( select a.acc, p.percent_osn, p.percent_over
                  from w4_acc o, accounts a, w4_card c, cm_product p
                 where o.acc_pk = a.acc and a.dazs is null
                   and o.card_code = c.code
                   and c.product_code = p.product_code
                   and (p.percent_osn is not null or p.percent_over is not null) )
     loop
        if z.percent_osn is not null then
           set_acc_rate('PK',  z.acc, z.percent_osn);
        end if;
        if z.percent_over is not null then
           set_acc_rate('OVR', z.acc, z.percent_over);
        end if;
     end loop;
     bars_audit.info(h || 'Percent_osn set.');
     bars_audit.info(h || 'Percent_ovr set.');

     -- установка % ставки по счету мобильных сбережений
     for z in ( select a.acc, p.percent_mob
                  from w4_acc o, accounts a, w4_card c, cm_product p
                 where o.acc_2625D = a.acc and a.dazs is null
                   and o.card_code = c.code
                   and c.product_code = p.product_code
                   and p.percent_mob is not null )
     loop
        set_acc_rate('MOB', z.acc, z.percent_mob);
     end loop;
     bars_audit.info(h || 'Percent_mob set.');

     -- установка % ставки по кредитному счету
     for z in ( select a.acc, p.percent_cred
                  from w4_acc o, accounts a, w4_card c, cm_product p
                 where o.acc_ovr = a.acc and a.dazs is null
                   and o.card_code = c.code
                   and c.product_code = p.product_code
                   and p.percent_cred is not null )
     loop
        set_acc_rate('KRED', z.acc, z.percent_cred);
     end loop;
     bars_audit.info(h || 'Percent_cred set.');

     -- установка % ставки по счету просрочки как по кредитному
     for z in ( select a.acc, p.percent_cred
                  from w4_acc o, accounts a, w4_card c, cm_product p
                 where o.acc_2207 = a.acc and a.dazs is null
                   and o.card_code = c.code
                   and c.product_code = p.product_code
                   and p.percent_cred is not null )
     loop
        set_acc_rate('KRED', z.acc, z.percent_cred);
     end loop;
     bars_audit.info(h || 'Percent_cred for 2207 set.');

  -- установка %% ставок по договору p_par
  else

     -- установка % ставки по основному счета
     -- установка % ставки по счету несанкционированного овердрафта
     for z in ( select a.acc, p.percent_osn, p.percent_over
                  from w4_acc o, accounts a, w4_card c, cm_product p
                 where o.acc_pk = a.acc and a.dazs is null
                   and o.card_code = c.code
                   and c.product_code = p.product_code
                   and (p.percent_osn is not null or p.percent_over is not null)
                   and o.nd = p_par )
     loop
        if z.percent_osn is not null then
           set_acc_rate('PK',  z.acc, z.percent_osn);
        end if;
        if z.percent_over is not null then
           set_acc_rate('OVR', z.acc, z.percent_over);
        end if;
     end loop;
     bars_audit.info(h || 'Percent_osn set.');
     bars_audit.info(h || 'Percent_ovr set.');

     -- установка % ставки по счету мобильных сбережений
     for z in ( select a.acc, p.percent_mob
                  from w4_acc o, accounts a, w4_card c, cm_product p
                 where o.acc_2625D = a.acc and a.dazs is null
                   and o.card_code = c.code
                   and c.product_code = p.product_code
                   and p.percent_mob is not null
                   and o.nd = p_par )
     loop
        set_acc_rate('MOB', z.acc, z.percent_mob);
     end loop;
     bars_audit.info(h || 'Percent_mob set.');

     -- установка % ставки по кредитному счету
     for z in ( select a.acc, p.percent_cred
                  from w4_acc o, accounts a, w4_card c, cm_product p
                 where o.acc_ovr = a.acc and a.dazs is null
                   and o.card_code = c.code
                   and c.product_code = p.product_code
                   and p.percent_cred is not null
                   and o.nd = p_par )
     loop
        set_acc_rate('KRED', z.acc, z.percent_cred);
     end loop;
     bars_audit.info(h || 'Percent_cred set.');

  end if;

  bars_audit.info(h || 'Finish.');

end set_accounts_rate;

-------------------------------------------------------------------------------
procedure cm_get_adr (
  p_rnk            in number,
  p_typeid         in number,
  p_addr_cityname out cm_client.addr1_cityname%type,
  p_addr_pcode    out cm_client.addr1_pcode%type,
  p_addr_domain   out cm_client.addr1_domain%type,
  p_addr_region   out cm_client.addr1_region%type,
  p_addr_street   out cm_client.addr1_street%type )
is
  function cm_translate_adr (p_adr in out varchar2) return varchar2
  is
  begin
     -- № 14/2-01/ ID 3997 “03” вересня 2015 року
     -- здійснювати заміщення значень атрибутів адреси
     -- на «N/A», при виконанні умов, що значення відповідних атрибутів є:
     --   - 0 (нуль);
     --   - пропуск (незалежно від кількості пропусків та за умови відсутності інших символів);
     --   - відсутність будь-якого значення.
     p_adr := trim(p_adr);
     p_adr := replace(p_adr, '|', '/');
     p_adr := case when p_adr is null then 'N/A'
                   when p_adr = '0' then 'N/A'
                   else p_adr
              end;
     return p_adr;
  end cm_translate_adr;
begin
  begin
     select substr(s.locality,1,100),
            substr(s.zip,1,10),
            substr(s.domain,1,48),
            substr(s.region,1,48),
            substr(s.address,1,100)
       into p_addr_cityname, p_addr_pcode, p_addr_domain, p_addr_region, p_addr_street
       from customer_address s
      where s.rnk = p_rnk and s.type_id = p_typeid;
  exception when no_data_found then
     p_addr_cityname := null;
     p_addr_pcode    := null;
     p_addr_domain   := null;
     p_addr_region   := null;
     p_addr_street   := null;
  end;
  p_addr_cityname := cm_translate_adr(p_addr_cityname);
  p_addr_pcode    := cm_translate_adr(p_addr_pcode);
  p_addr_domain   := cm_translate_adr(p_addr_domain);
  p_addr_region   := cm_translate_adr(p_addr_region);
  p_addr_street   := cm_translate_adr(p_addr_street);
end cm_get_adr;


-------------------------------------------------------------------------------
-- iget_product
--
--
procedure iget_product (
  p_cardcode  in     w4_product.code%type,
  p_term      in out number,
  p_product      out t_product )
is
  l_prod_max_term cm_product.mm_max%type;
  l_term_min      w4_card.minterm%type;
  l_term_max      w4_card.maxterm%type;
begin

  begin
     select b.grp_code, b.code, c.code, c.sub_code,
            b.kv, b.nbs, b.ob22, b.tip,
            s.flag_instant, s.date_instant, s.flag_kk,
            a.client_type, a.scheme_id, m.percent_osn,
            m.mm_max, nvl(c.minterm,t.term_min), nvl(c.maxterm,t.term_max)
       into p_product.product_grp, p_product.product_code,
            p_product.card_code, p_product.sub_code,
            p_product.kv, p_product.nbs, p_product.ob22, p_product.tip,
            p_product.flag_instant, p_product.date_instant, p_product.flag_kk,
            p_product.custtype, p_product.schemeid, p_product.rate,
            l_prod_max_term, l_term_min, l_term_max
       from w4_product_groups a, w4_product b, w4_card c, w4_subproduct s, w4_tips t, cm_product m
      where c.code = p_cardcode
        and c.sub_code = s.code
        and c.product_code = b.code
        and b.grp_code = a.code
        and b.tip = t.tip
        and c.product_code = m.product_code(+);
  exception when no_data_found then
     -- Не найден продукт p_cardcode
     bars_error.raise_nerror(g_modcode, 'CARDCODE_NOT_FOUND', p_cardcode);
  end;

  -- проверка срока
  if p_term is not null then
     if p_term < l_term_min or p_term > l_term_max /*or p_term > nvl(l_prod_max_term, l_term_max)*/ then
        -- Указанный срок действия карты не соответствует типу карты или продукта
        bars_error.raise_nerror(g_modcode, 'TERM_ERROR');
     end if;
  else
     p_term := l_term_max;
  end if;

end iget_product;

-------------------------------------------------------------------------------
procedure add_deal_to_cmque (
  p_nd         in number,
  -- p_opertype - Тип операции
  --   1 - Новый клиент физ. лицо, контракт и карта
  --   2 - Доп.карта по КК
  --   3 - Изменение данных клиента физ. лица/держателя
  --   4 - Новый клиент юр. лицо, контракт и карта
  --   5 - Новый контракт и карта
  --   6 - Изменение данных клиента юр. лица
  --   7 - Новый клиент сотрудник ОБУ, контракт, корп. карта
  --   9 - Заміна основної картки
  --   12 - Персоналізація МКК
  p_opertype   in number,
  p_ad_rnk in number default null, -- RNK клиента на которого необходимо выпустить доп. карту.
  p_card_type in varchar2 default null, --
  p_cntm in integer default null,
  p_wait_confirm in integer default null, --если 1 то заявку не показываем для СМ пока не будет подтверждения.(operstatus = 99)
  p_cmclient out cm_client_que%rowtype
  )  -- срок действия карты
is
  l_cmclient      cm_client_que%rowtype;
  l_pk_tip        accounts.tip%type;
  l_pk_dazs       accounts.dazs%type;
  l_grpcode       w4_product_groups.code%type;
  l_grpclienttype w4_product_groups.client_type%type;
  l_w4lc          ow_params.val%type;
  l_datein        cm_client_que.datein%type;
  l_datemod       cm_client_que.datemod%type;
  l_operstatus    cm_client_que.oper_status%type;
  l_dat_end       w4_acc.dat_end%type;
  l_tmp1          varchar2(10);
  l_tmp2          varchar2(10);
  i               number;
  l_schoolid      number;
  l_rnk           customer.rnk%type;
  l_product       t_product;
  h varchar2(100) := 'bars_ow.add_deal_to_cmque. ';
  l_nmk           customer.nmk%type;
  l_nbs           accounts.nbs%type;
  l_pensn         varchar2(12);
  l_sms           varchar2(1);
  l_xml           xmltype;
  l_senddoc       varchar2(1);
  l_sendreq       number;
  l_sed           varchar2(4);
  l_ismmfo        varchar2(1) := nvl(getglobaloption('IS_MMFO'), '0');
  l_iscrm         varchar2(1) := nvl(sys_context('CLIENTCONTEXT', 'ISCRM'), '0');
  l_cm_err_msg    varchar2(1000);
begin

  bars_audit.info(h || 'Start: p_nd=>' || to_char(p_nd) || ', p_opertype=>' || to_char(p_opertype));

  begin
     select a.acc, a.nls, a.tip, nvl(g_cm_branch,a.branch), a.dazs,
            c.rnk, decode(c.custtype,3,decode(nvl(trim(c.sed),'00'),'91',1,2),1),
            d.code, p.code, g.code, g.client_type, s.flag_kk, w.dat_end, a.nbs, trim(c.sed),
            trim(regexp_replace(upper(c.nmk),'(ФОП)|(П-ЦЬ)|(ПП)|(ФІЗИЧНА ОСОБА ?-ПІДПРИЄМЕЦЬ)|(ФЕРМЕРСЬКЕ ГОСПОДАРСТВО)', ''))
       into l_cmclient.acc, l_cmclient.contractnumber, l_pk_tip, l_cmclient.branch, l_pk_dazs,
            l_cmclient.rnk, l_cmclient.clienttype,
            l_cmclient.card_type, l_cmclient.productcode, l_grpcode, l_grpclienttype, l_cmclient.kk_flag, l_dat_end, l_nbs, l_sed,
            l_nmk
       from w4_acc w, accounts a, customer c, w4_card d, w4_product p, w4_product_groups g, w4_subproduct s
      where w.nd = p_nd
        and w.acc_pk = a.acc
        and a.rnk = c.rnk
        and w.card_code = d.code
        and d.product_code = p.code
        and p.grp_code = g.code
        and d.sub_code = s.code;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_nd));
  end;

  if p_ad_rnk is not null and p_opertype <> 12 then
     l_rnk := l_cmclient.rnk;
     l_cmclient.rnk := p_ad_rnk;
     begin
        select decode(c.custtype, 3, decode(nvl(trim(c.sed), '00'), '91', 1, 2), 1)
          into l_cmclient.clienttype
          from customer c
         where c.rnk = l_cmclient.rnk;
     exception
       when no_data_found then
         bars_error.raise_nerror(g_modcode, 'CUSTOMER_NOT_FOUND', to_char(p_ad_rnk));
     end;
  end if;

  if p_card_type is not null then
     l_cmclient.card_type := p_card_type;
  end if;

  if p_opertype = 2 and p_ad_rnk is not null then
     l_cmclient.kk_flag := 2;
  end if;
  if p_cntm is not null then
     l_cmclient.cntm := p_cntm;
     iget_product (
     p_cardcode => p_card_type,
     p_term     => l_cmclient.cntm,
     p_product  => l_product );

  end if;
  -- проверка: запросы по НК можно отправлять только если W4_LC = 1
  if l_pk_tip = 'W4V' then
     select nvl(max(val),'0') into l_w4lc from ow_params where par = 'W4_LC';
     if l_w4lc = '0' then
        -- Налаштовано маршрут створення карток через Way4
        bars_error.raise_nerror(g_modcode, 'W4LC_0');
     end if;
  end if;

  --COBUMMFO-7787_1
  if l_pk_dazs is not null and  l_nbs is not null and p_opertype<>3 then
     -- Счет %s/%s закрыт
     bars_error.raise_nerror(g_modcode, 'ACC_CLOSED', l_cmclient.contractnumber);
  end if;

  -- контроль: если по договору есть заявки в статусе 2 "Операція в обробці",
  --   новые заявки создавать запрещено
  select count(*) into i from cm_client_que where rnk = l_cmclient.rnk and acc = l_cmclient.acc and oper_status = 2;
  if i > 0 then
     -- По рахунку %s є несквитовані заявки, для продовження рекомендуємо сквитувати раніше створені заявки
     bars_error.raise_nerror(g_modcode, 'REQUEST_STATUS2', l_cmclient.contractnumber);
  end if;

  -- № 14/2-01/ID-3466 від 04.06.2015р.
  -- проверяем, это карта Instant? (был ли запрос по счету с card_type like INSTANT%)
  select count(*) into i
    from cm_client_que_arc q, w4_product p
   where q.acc = l_cmclient.acc
     and q.productcode = p.code and p.grp_code = 'INSTANT';
  -- Instant
  if i > 0 then
     -- 1) для карт Instant можно формировать запросы
     --    6 - "Зміна клієнта по карті Інстант";
     --    1 - "Новий клієнт ФО, контракт, карта";
     --    3 - "Зміна даних клієнта ФО".
     if p_opertype not in (1, 3, 6, 9) then
        -- Запрещено формировать запрос с типом %s для карт %s
        bars_error.raise_nerror(g_modcode, 'REQUEST_TYPE_IMPOSSIBLE', p_opertype, 'Instant');
     end if;
  -- не Instant
  else
     -- 2) для ФО можно формировать запросы
     --    7 - «Новий клієнт співробітник ОБУ, контракт, корп.карта»
     --    1 - «Новий клієнт ФО, контракт, карта»
     --    3 - «Зміна даних клієнта ФО»
     --    5 - «Новий контракт, карта»;
     --    2 - "Доп.карта по КК"
     --    9 - Заміна основної картки
     if l_grpclienttype = 1 and p_opertype not in (1, 2, 3, 5, 7, 9) then
        -- Запрещено формировать запрос с типом %s для карт %s
        bars_error.raise_nerror(g_modcode, 'REQUEST_TYPE_IMPOSSIBLE', p_opertype, 'ФО');
     -- 3) для ЮО можно формировать запросы
     --    4 - «Новий клієнт ЮО, контракт, карта»
     --    8 - «Зміна даних клієнта ЮО»
     --    5 - «Новий контракт, карта».
     elsif l_grpclienttype = 2 and p_opertype not in (4, 5, 8, 11, 12) then
        -- Запрещено формировать запрос с типом %s для карт %s
        bars_error.raise_nerror(g_modcode, 'REQUEST_TYPE_IMPOSSIBLE', p_opertype, 'ЮО');
     end if;
  end if;

  -- контроль на недопустимость повторного формирования заявок типа 1 или типа 5 (по РНК клиента и счету),
  --   если такие заявки ранее были успешно обработаны или находятся в стадии обработки
  if p_opertype in (1, 2, 4, 5, 6, 7) then
     begin
        -- поиск в таблице запросов
        select datein, datemod, oper_status
          into l_datein, l_datemod, l_operstatus
          from cm_client_que
         where rnk = l_cmclient.rnk and acc = l_cmclient.acc
           and oper_type = p_opertype and oper_status <> 10;
        if l_operstatus = 1 then
           delete from cm_client_que t
            where rnk = l_cmclient.rnk and acc = l_cmclient.acc and
                  oper_type = p_opertype and oper_status = 1;
        elsif l_operstatus = 2 then
           bars_audit.info(h || 'Запит по рахунку ' || l_cmclient.contractnumber || ' з типом ' || to_char(p_opertype) || ' вже обробляэться в CardMake ' || to_char(l_datemod, 'dd.mm.yyyy hh24:mi'));
           bars_error.raise_nerror(g_modcode, 'REQUEST_OPERTYPE2', l_cmclient.contractnumber, to_char(p_opertype), to_char(l_datemod, 'dd.mm.yyyy hh24:mi'));
        end if;
     exception
        when no_data_found then
           begin
              -- поиск в архиве успешно обработанных запросов
              select datemod into l_datemod
                from cm_client_que_arc
               where rnk = l_cmclient.rnk and acc = l_cmclient.acc
                 and oper_type = p_opertype
                 and oper_status = 3;
              bars_audit.info(h || 'Запит по рахунку ' || l_cmclient.contractnumber || ' з типом ' || to_char(p_opertype) || ' вже успішно оброблено в CardMake ' || to_char(l_datemod, 'dd.mm.yyyy hh24:mi'));
              bars_error.raise_nerror(g_modcode, 'REQUEST_OPERTYPE3', l_cmclient.contractnumber, to_char(p_opertype), to_char(l_datemod, 'dd.mm.yyyy hh24:mi'));
           exception
              when no_data_found then null;
              when too_many_rows then
                 bars_audit.info(h || 'Запит по рахунку ' || l_cmclient.contractnumber || ' з типом ' || to_char(p_opertype) || ' вже успішно оброблено в CardMake');
                 bars_error.raise_nerror(g_modcode, 'REQUEST_OPERTYPE3', l_cmclient.contractnumber, to_char(p_opertype));
           end;
        when too_many_rows then
           bars_audit.info(h || 'Декілька запитів по рахунку ' || l_cmclient.contractnumber || ' з типом ' || to_char(p_opertype));
           raise_application_error(-20000, 'Декілька запитів по рахунку ' || l_cmclient.contractnumber || ' з типом ' || to_char(p_opertype));
     end;
  elsif p_opertype = 3 then
        delete from cm_client_que t
         where rnk = l_cmclient.rnk and acc = l_cmclient.acc and
               oper_type = p_opertype and oper_status = 1;
  end if;

  select min(decode(tag,'SN_FN',upper(substr(value,1,105)))),
         min(decode(tag,'SN_LN',upper(substr(value,1,105)))),
         min(decode(tag,'SN_MN',upper(substr(value,1,105))))
    into l_cmclient.firstname, l_cmclient.lastname, l_cmclient.middlename
    from customerw
   where rnk = l_cmclient.rnk
     and tag in ('SN_FN', 'SN_LN', 'SN_MN');
  if p_opertype = 12 then
    if l_cmclient.firstname is null then
       l_cmclient.firstname :=  substr(l_nmk, instr(l_nmk, ' ') + 1, case when instr(l_nmk, ' ', 1, 2) > 0 then instr(l_nmk, ' ', 1, 2) - instr(l_nmk, ' ') - 1 else length(l_nmk) - instr(l_nmk, ' ') end);
    end if;

    if l_cmclient.lastname is null then
       l_cmclient.lastname := substr(l_nmk, 1, instr(l_nmk, ' ') - 1);
    end if;

    if l_cmclient.middlename is null then
       l_cmclient.middlename := substr(l_nmk, instr(l_nmk, ' ', 1, 2) + 1);
    end if;

  end if;

  -- person
  if l_cmclient.clienttype = 2 or p_opertype = 12 then
     begin
        select p.bday, p.bplace, p.sex,
               trim(substr('            ' || p.teld,-12)),
               trim(substr('            ' || p.telw,-12)),
               decode(p.passp,1,1,15,3,3,4,7,10,13,5,11,9,null),
               substr(p.numdoc,1,16), substr(p.ser,1,16),
               p.pdate, substr(p.organ,1,100), ---было 128 обрезать до 100 --COBUSUPABS-5052
               p.actual_date, p.eddr_id
          into l_cmclient.birthdate, l_cmclient.birthplace, l_cmclient.gender,
               l_cmclient.phonenumber, l_cmclient.phonenumber_dod,
               l_cmclient.typedoc, l_cmclient.paspnum, l_cmclient.paspseries, l_cmclient.paspdate, l_cmclient.paspissuer,
               l_cmclient.idcardenddate, l_cmclient.eddr_id
          from person p
         where p.rnk = l_cmclient.rnk;
        if nvl(l_cmclient.typedoc,0) = 1 and l_cmclient.paspseries is not null and
           (l_cmclient.paspseries <> upper(l_cmclient.paspseries) or length(l_cmclient.paspseries) <> 2) then
           bars_error.raise_nerror(g_modcode, 'PASSP_SERIES_ERROR');
        end if;
        if nvl(l_cmclient.typedoc,0) = 1 and l_cmclient.paspnum is not null and
           (not check_digit(l_cmclient.paspnum) or length(l_cmclient.paspnum) <> 6) then
           bars_error.raise_nerror(g_modcode, 'PASSP_NUM_ERROR');
        end if;
        --Проверка серии свидетельства о рождении, первые 4 символа Римские цифры-2 укр. буквы
        if nvl(l_cmclient.typedoc,0) = 4 and l_cmclient.paspseries is not null and
           (l_cmclient.paspseries <> upper(l_cmclient.paspseries) or
           (not regexp_like(l_cmclient.paspseries,'^M{0,3}(D?C{0,3}|C[DM])(L?X{0,3}|X[LC])(V?I{0,3}|I[VX])-[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ]{2}+$'))) then
           bars_error.raise_nerror(g_modcode, 'PASSP_SERIES_ERROR');
        end if;
        if nvl(l_cmclient.typedoc,0) = 4 and l_cmclient.paspnum is not null and
           (not check_digit(l_cmclient.paspnum) or length(l_cmclient.paspnum) <> 6) then
           bars_error.raise_nerror(g_modcode, 'PASSP_NUM_ERROR');
        end if;
     exception when no_data_found then
        l_cmclient.birthdate       := null;
        l_cmclient.birthplace      := null;
        l_cmclient.gender          := null;
        l_cmclient.phonenumber     := null;
        l_cmclient.phonenumber_dod := null;
        l_cmclient.typedoc         := null;
        l_cmclient.paspnum         := null;
        l_cmclient.paspseries      := null;
        l_cmclient.paspdate        := null;
        l_cmclient.paspissuer      := null;
     end;
     l_cmclient.fax := null;
     l_cmclient.shortname := upper(substr(l_cmclient.firstname,1,1)||substr(l_cmclient.middlename,1,1)||l_cmclient.lastname);
  -- corps
  else
     begin
        select substr(telr,1,12), substr(tel_fax,1,12)
          into l_cmclient.phonenumber, l_cmclient.fax
          from corps
         where rnk = l_cmclient.rnk;
     exception when no_data_found then
        l_cmclient.phonenumber := null;
        l_cmclient.fax := null;
     end;
     if p_opertype <> 12 then
        l_cmclient.birthdate       := null;
        l_cmclient.birthplace      := null;
        l_cmclient.gender          := null;
        l_cmclient.phonenumber_dod := null;
        l_cmclient.typedoc         := null;
        l_cmclient.paspnum         := null;
        l_cmclient.paspseries      := null;
        l_cmclient.paspdate        := null;
        l_cmclient.paspissuer      := null;
        l_cmclient.shortname       := null;
     end if;
  end if;

  -- параметры клиента
  cm_get_adr(l_cmclient.rnk, 1, l_cmclient.addr1_cityname, l_cmclient.addr1_pcode, l_cmclient.addr1_domain, l_cmclient.addr1_region, l_cmclient.addr1_street);
  cm_get_adr(l_cmclient.rnk, 2, l_cmclient.addr2_cityname, l_cmclient.addr2_pcode, l_cmclient.addr2_domain, l_cmclient.addr2_region, l_cmclient.addr2_street);

  select min(decode(tag, 'PC_Z1', substr(value,1,16))),
         min(decode(tag, 'PC_Z2', substr(value,1,16))),
         min(decode(tag, 'PC_Z3', substr(value,1,128))),
         min(decode(tag, 'PC_Z4', substr(value,1,10))),
         min(decode(tag, 'PC_Z5', substr(value,1,10))),
         nvl(min(decode(tag, 'VIP_K', substr(value,1,1))),0)
    into l_cmclient.foreignpaspseries, l_cmclient.foreignpaspnum, l_cmclient.foreignpaspissuer, l_tmp1, l_tmp2, l_cmclient.isvip
    from customerw
   where rnk = l_cmclient.rnk
     and tag in ('PC_Z1', 'PC_Z2', 'PC_Z3', 'PC_Z4', 'PC_Z5', 'VIP_K');

  if l_tmp1 is not null then
     begin
        l_cmclient.foreignpaspenddate := to_date(l_tmp1,'dd.MM.yyyy');
     exception when others then
        -- Некорректный формат даты для поля <...> (РНК l_rnk)
        bars_error.raise_nerror(g_modcode, 'FORMAT_DATE_ERROR', 'БПК. Закордонний паспорт. Дійсний до', to_char(l_cmclient.rnk));
     end;
  end if;

  if l_tmp2 is not null then
     begin
         l_cmclient.foreignpaspdate:= to_date(l_tmp2,'dd.MM.yyyy');
     exception when others then
        -- Некорректный формат даты для поля <...> (РНК l_rnk)
        bars_error.raise_nerror(g_modcode, 'FORMAT_DATE_ERROR', 'БПК. Закордонний паспорт. Коли виданий', to_char(l_cmclient.rnk));
     end;
  end if;

  select min(decode(tag, 'EMAIL', substr(value,1,32))),
         min(decode(tag, 'MPNO ', substr(value,-iif_n(length(value),12,length(value),12,12))))
    into l_cmclient.email, l_cmclient.phonenumber_mob
    from customerw
   where rnk = l_cmclient.rnk
     and tag in ('EMAIL', 'MPNO ');

  -- параметры счета
  select min(decode(tag,'W4_EFN',  replace(substr(value,1,64), CHR(39),''))),
         min(decode(tag,'W4_ELN',  replace(substr(value,1,64), CHR(39),''))),
         min(decode(tag,'PK_WORK', substr(value,1,254))),
         min(decode(tag,'PK_OFFIC',substr(value,1,32))),
         min(decode(tag,'PK_ODAT', substr(value,1,10))),
         min(decode(tag,'W4_ECN',  substr(value,1,32))),
         min(decode(tag,'W4_CPN',  substr(value,1,105))),
         nvl(l_cmclient.cntm, min(decode(tag,'PK_TERM', substr(value,1,10)))),
         min(decode(tag,'W4_SEC',  substr(value,1,105))),
         min(decode(tag,'W4SMS',  substr(value,1,105)))
    into l_cmclient.engfirstname, l_cmclient.englastname, l_cmclient.work, l_cmclient.office, l_tmp1,
         l_cmclient.personalisationname, l_cmclient.contactperson, l_cmclient.cntm, l_cmclient.pind,
         l_sms
    from accountsw
   where acc = l_cmclient.acc
     and tag in ('W4_EFN', 'W4_ELN', 'PK_WORK', 'PK_OFFIC', 'PK_ODAT',
                 'W4_ECN', 'W4_CPN', 'PK_TERM',  'W4_SEC', 'W4SMS');

  -- Відправляємо признак відправки смс на СМ
  if p_opertype in (1, 2, 5, 6) then
     l_cmclient.add_info := '<SEND_SMS>'||nvl(l_sms, 'Y')||'</SEND_SMS>';
  end if;

  if l_cmclient.kk_flag = 2 and p_ad_rnk is not null then
     select nmk into l_nmk from customer where rnk = p_ad_rnk;

     l_cmclient.engfirstname := f_translate_kmu(' '||substr(l_nmk,1 , instr(l_nmk, ' ') - 1));
     l_cmclient.englastname :=  f_translate_kmu(' '||substr(l_nmk, instr(l_nmk, ' ') + 1, case when instr(l_nmk, ' ', 1, 2) > 0 then instr(l_nmk, ' ', 1, 2) - instr(l_nmk, ' ') - 1 else length(l_nmk) - instr(l_nmk, ' ') end));
  end if;
  --Срок действия доп. Карты КК не может быть больше основной
  if p_opertype = 2 then
     l_cmclient.cntm := months_between(trunc(l_dat_end,'mm'), trunc(sysdate,'mm'));
  end if;

  if l_tmp1 is not null then
     begin
        l_cmclient.date_w := to_date(l_tmp1,'dd.MM.yyyy');
     exception when others then
        -- Некорректный формат даты для поля <...> (РНК l_rnk)
        bars_error.raise_nerror(g_modcode, 'FORMAT_DATE_ERROR', 'БПК. Місце роботи: з якого часу працює', to_char(l_cmclient.rnk));
     end;
  end if;

  if l_cmclient.clienttype = 2 then
     if length(l_cmclient.engfirstname || l_cmclient.englastname) > 25 then
        raise_application_error(-20000, 'Загальна кількість символів в імені та прізвищі, що ембосуються, має бути 25');
     end if;
  else
     if length(l_cmclient.personalisationname) > 16 then
        raise_application_error(-20000, 'Загальна кількість символів в назві компанії що, що ембосуються, має бути 16');
     end if;
  end if;

  begin
select c.date_on, c.okpo, lpad(to_char(c.country), 3, '0'),
            d.rezid,
            decode(nvl(c.prinsider,0),0,'99',lpad(to_char(c.prinsider),2,'0')),
            decode(l_cmclient.clienttype,1,upper(substr(c.nmk,1,200)),null),
            decode(l_cmclient.clienttype,1,upper(substr(c.nmkk,1,32)),null),
            decode(l_cmclient.clienttype,1,decode(c.custtype,3,2,9),null)
       into l_cmclient.opendate, l_cmclient.taxpayeridentifier, l_cmclient.country,
            l_cmclient.resident, l_cmclient.k060,
            l_cmclient.companyname, l_cmclient.shortcompanyname, l_cmclient.klas_client_id
       from customer c, codcagent d
      where c.rnk = l_cmclient.rnk
        and c.codcagent = d.codcagent;
  end;

  if p_opertype = 2 and l_cmclient.kk_flag = 0 then
     l_cmclient.kk_flag := 1;
  end if;
  -- контроль: у клиента может быть только одна активная Карта киевлянина
  if l_cmclient.kk_flag = 1 and p_opertype <> 3 then
     select count(*) into i
       from cm_client_que_arc c, accounts a
      where c.rnk = l_cmclient.rnk and c.kk_flag = 1 and c.oper_status = 3
        and c.oper_type in (1, 2, 5)
        and c.acc = a.acc and a.dazs is null;
     if i > 0 then
        bars_audit.info(h || 'Клієнту РНК ' || to_char(l_cmclient.rnk) || ' вже відкрито Картку киянина');
        bars_error.raise_nerror(g_modcode, 'KK_ALREADY_OPEN', to_char(l_cmclient.rnk));
     end if;
     select count(*) into i
       from cm_client_que c, accounts a
      where c.rnk = l_cmclient.rnk and c.kk_flag = 1 and c.oper_status <> 10
        and c.oper_type in (1, 2, 5)
        and c.acc = a.acc and a.dazs is null;
     if i > 0 then
        bars_audit.info(h || 'По клієнту РНК ' || to_char(l_cmclient.rnk) || '  вже сформовано заявку на відкриття Картки киянина');
        raise_application_error(-20000, 'По клієнту РНК ' || to_char(l_cmclient.rnk) || '  вже сформовано заявку на відкриття Картки киянина' );
     end if;
  elsif l_cmclient.kk_flag = 2 and p_opertype <> 3 then
     select count(*) into i
       from cm_client_que_arc c, accounts a
      where c.rnk = l_cmclient.rnk and c.kk_flag = 2 and c.oper_status = 3
        and c.oper_type =2
        and c.acc = a.acc and a.dazs is null;
     if i > 0 then
        bars_audit.info(h || 'Клієнту РНК ' || to_char(l_cmclient.rnk) || ' вже відкрито Картку школяра');
        bars_error.raise_nerror(g_modcode, 'SK_ALREADY_OPEN', to_char(l_cmclient.rnk));
     end if;
     select count(*) into i
       from cm_client_que c, accounts a
      where c.rnk = l_cmclient.rnk and c.kk_flag = 2 and c.oper_status <> 10
        and c.oper_type = 2
        and c.acc = a.acc and a.dazs is null;
     if i > 0 then
        bars_audit.info(h || 'По клієнту РНК ' || to_char(l_cmclient.rnk) || '  вже сформовано заявку на відкриття Картки школяра');
        raise_application_error(-20000, 'По клієнту РНК ' || to_char(l_cmclient.rnk) || '  вже сформовано заявку на відкриття Картки школяра' );
     end if;
  end if;

  -- для Картки киянина
  if l_cmclient.kk_flag in(1, 2) then
     select min(decode(tag, 'W4KKW', substr(value,1,32))),
            min(decode(tag, 'W4KKR', substr(value,1,1))),
            min(decode(tag, 'W4KKA', substr(value,1,10))),
            min(decode(tag, 'W4KKT', substr(value,1,10))),
            min(decode(tag, 'W4KKS', substr(value,1,64))),
            min(decode(tag, 'W4KKB', substr(value,1,32))),
            min(decode(tag, 'W4KKZ', substr(value,1,5))),
            to_number(min(decode(tag, 'W4SKS', substr(value,1,32)))),
            min(decode(tag, 'W4KKC', substr(value,1,1)))
       into l_cmclient.kk_secret_word, l_cmclient.kk_regtype, l_cmclient.kk_cityareaid, l_cmclient.kk_streettypeid,
            l_cmclient.kk_streetname, l_cmclient.kk_apartment, l_cmclient.kk_postcode, l_schoolid, l_senddoc
       from customerw
      where rnk = l_cmclient.rnk
        and tag in ('W4KKW', 'W4KKR', 'W4KKA', 'W4KKT', 'W4KKS', 'W4KKB', 'W4KKZ', 'W4SKS', 'W4KKC');
     if l_cmclient.kk_flag = 2 then
     select min(decode(tag, 'W4KKW', substr(value,1,32))),
            min(decode(tag, 'W4KKR', substr(value,1,1))),
            min(decode(tag, 'W4KKA', substr(value,1,10))),
            min(decode(tag, 'W4KKT', substr(value,1,10))),
            min(decode(tag, 'W4KKS', substr(value,1,64))),
            min(decode(tag, 'W4KKB', substr(value,1,32))),
            min(decode(tag, 'W4KKZ', substr(value,1,5)))
       into l_cmclient.kk_secret_word, l_cmclient.kk_regtype, l_cmclient.kk_cityareaid, l_cmclient.kk_streettypeid,
            l_cmclient.kk_streetname, l_cmclient.kk_apartment, l_cmclient.kk_postcode
       from customerw
         where rnk = l_rnk
        and tag in ('W4KKW', 'W4KKR', 'W4KKA', 'W4KKT', 'W4KKS', 'W4KKB', 'W4KKZ');
     end if;
     if p_opertype in(1, 2, 5) and l_senddoc is not null then
        l_cmclient.add_info := l_cmclient.add_info||'<SOC_DOC>'||l_senddoc||'</SOC_DOC>';
     end if;
  else
     l_cmclient.kk_secret_word  := null;
     l_cmclient.kk_regtype      := null;
     l_cmclient.kk_cityareaid   := null;
     l_cmclient.kk_streettypeid := null;
     l_cmclient.kk_streetname   := null;
     l_cmclient.kk_apartment    := null;
     l_cmclient.kk_postcode     := null;
  end if;

  -- проверки для Картки киянина
  if l_cmclient.kk_flag in(1, 2) then

     l_cmclient.kk_postcode := nvl(trim(l_cmclient.kk_postcode), '01001');
     -- проверки на заполнение обязательных полей
     if l_cmclient.kk_secret_word is null then
        -- Не заполнены обязательные реквизиты клиента (РНК %s) / карточки:
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Таємне слово картки '||case l_cmclient.kk_flag when 1 then 'киянина' else 'школяра' end );
     end if;
     if l_cmclient.kk_regtype is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Тип реєстрації громадянина (для Картки '||case l_cmclient.kk_flag when 1 then 'киянина' else 'школяра' end||')');
     end if;
     if l_cmclient.kk_cityareaid is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Код району міста (для Картки '||case l_cmclient.kk_flag when 1 then 'киянина' else 'школяра' end||')');
     end if;
     if l_cmclient.kk_streettypeid is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Код типу вулиці (для Картки '||case l_cmclient.kk_flag when 1 then 'киянина' else 'школяра' end||')');
     end if;
     if length(l_cmclient.kk_postcode) <> 5 then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Поштовий індекс (для Картки '||case l_cmclient.kk_flag when 1 then 'киянина' else 'школяра' end||') має бути 5-ти символьним');
     end if;
     if l_cmclient.paspseries is null and l_cmclient.typedoc <> 10 then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Серія документу');
     end if;
     if l_cmclient.firstname is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Ім''я');
     end if;
     if l_cmclient.lastname is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Прізвище');
     end if;
     if l_cmclient.birthdate is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Дата народження');
     end if;
     if l_cmclient.paspdate is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Дата видачі документу');
     end if;
     if l_cmclient.paspissuer is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Ким виданий документ');
     end if;
if    not regexp_like(upper(l_cmclient.paspissuer),q'{^[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ' .,;0-9-]+$}') then   --COBUSUPABS-5052 Проверка на спецсимволы
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Ким виданий документ.Містить заборонені символи.');
     end if;
     if l_cmclient.taxpayeridentifier is null then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'ІПН');
     end if;
     if length(l_cmclient.taxpayeridentifier) <> 10 then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'ІПН має бути 10-ти символьний');
     end if;
     -- проверка на совпадение паролей
     if l_cmclient.kk_secret_word = l_cmclient.pind then
        -- Таємне слово для КК має відрізнятися від PIND
        bars_error.raise_nerror(g_modcode, 'KK_SECRET_WORD_PIND_ERROR');
     elsif not regexp_like(upper(l_cmclient.kk_secret_word),'^[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯA-Z0-9._-]+$') then
        bars_error.raise_nerror('BPK', 'KK_FORBIDDEN_CHARACTERS', 'Кодове слово для картки '||case l_cmclient.kk_flag when 1 then 'киянина' else 'школяра' end
                                || ' Клієнта РНК '|| to_char(l_cmclient.rnk), 'А-Я0-9._-');
     end if;
     -- фото
     begin
        select 1 into i from customer_images where rnk = l_cmclient.rnk and type_img = 'PHOTO_JPG';
     exception when no_data_found then
        bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Фото (для Картки киянина)');
     end;

     if l_cmclient.kk_flag = 2 then
        if l_schoolid is null then
           bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(l_cmclient.rnk), 'Ідентифікатор школи (для Картки школяра)');
        end if;
     end if;
     if not regexp_like(upper(l_cmclient.firstname||l_cmclient.middlename||l_cmclient.lastname),'^[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'||CHR(39)||'-]+$') then
          bars_error.raise_nerror('BPK', 'KK_FORBIDDEN_CHARACTERS', 'ПІБ клієнта РНК' || to_char(l_cmclient.rnk), 'укр. регістра');
     end if;

     l_cmclient.middlename := nvl(l_cmclient.middlename, '--');
  end if;
  -- формируем теги по учебному заведению
  if l_cmclient.kk_flag = 2 and p_opertype in (2, 3) then
     select xmlelement("EDU_ID", s.schoolid) ||
            xmlelement("EDU_TYPE", t.info) ||
            xmlelement("EDU_NAME", t.info || ' ' || s.shortname) ||
            xmlelement("EDU_PRINT",
                       'УЧЕНЬ ' || t.info || ' ' || case
                         when regexp_like(trim(s.name), '^[0-9]+$') then
                          '№' || trim(s.name)
                         else
                          trim(s.shortname)
                       end)||l_cmclient.add_info
       into l_cmclient.add_info
       from ow_schools s, ow_schooltypes t
      where s.schooltypeid = t.schooltypeid and s.schoolid = l_schoolid;
  elsif p_opertype = 6 then
     select min(t.respcode) keep(dense_rank last order by t.requestdate)
       into l_sendreq
       from ow_query_log t
      where t.nd = p_nd;
      if l_sendreq = 0 then
         l_cmclient.add_info := l_cmclient.add_info||'<SEND_INSTANT>N</SEND_INSTANT>';
      else
         l_cmclient.add_info := l_cmclient.add_info||'<SEND_INSTANT>Y</SEND_INSTANT>';
      end if;
  end if;
  -- контроль на допустимые типы карт для З/П проектов
  if l_grpcode = 'SALARY' then
     begin
        -- поиск З/П проекта
        select e.okpo, e.okpo_n into l_cmclient.okpo_sysorg, l_cmclient.kod_sysorg
          from accountsw w, bpk_proect e, w4_product p
         where w.acc = l_cmclient.acc
           and w.tag = 'PK_PRCT'
           and w.value = to_char(e.id)
           and e.product_code = p.code
           and p.grp_code = 'SALARY';
        -- проверка на допустимые карты
        begin
           select 1 into i
             from bpk_proect_card
            where okpo = l_cmclient.okpo_sysorg
              and okpo_n = nvl(l_cmclient.kod_sysorg,0)
              and card_code = l_cmclient.card_type;
        exception when no_data_found then
           -- среди доступных карту не нашли, возможна карта уже не выпускается для данного З/П проекта.
           -- для таких карт допускается запрос на изменение реквизитов клиента.
           if p_opertype not in ( 3,7) -- додано тип 7 для уникнення помилки пыд час пакетної зміни відділення, http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-6284
       then
              bars_audit.info(h || 'Недопустимый тип карты %s для З/П проекта %s/%s/%s');
              bars_error.raise_nerror(g_modcode, 'UNCURRECT_SALARY_CARD', l_cmclient.card_type, l_cmclient.okpo_sysorg, l_cmclient.kod_sysorg, l_cmclient.productcode);
           end if;
        end;
     exception when no_data_found then
        l_cmclient.okpo_sysorg := null;
        l_cmclient.kod_sysorg  := null;
     end;
  end if;

  -- параметры НК
  if l_pk_tip = 'W4V' then
     select min(decode(tag, 'RVRNK', substr(value,1,100))),
            min(decode(tag, 'RVIDT', substr(value,1,10))),
            min(decode(tag, 'RVIBR', substr(value,1,100))),
            min(decode(tag, 'RVIBA', substr(value,1,100))),
            min(decode(tag, 'RVIBB', substr(value,1,100)))
       into l_cmclient.cl_rnk, l_tmp1, l_cmclient.card_br_iss, l_cmclient.card_addr_iss, l_cmclient.delivery_br
       from customerw
      where rnk = l_cmclient.rnk
        and tag in ('RVRNK', 'RVIDT', 'RVIBR', 'RVIBA', 'RVIBB');
     if l_tmp1 is not null then
        begin
           l_cmclient.cl_dt_iss := to_date(l_tmp1,'dd/MM/yyyy');
        exception when others then
           -- Некорректный формат даты для поля <...> (РНК l_rnk)
           bars_error.raise_nerror(g_modcode, 'FORMAT_DATE_ERROR', 'ЦРВ. Дата видачі картки', to_char(l_cmclient.rnk));
        end;
     end if;
  else
     l_cmclient.cl_rnk := null;
     l_cmclient.cl_dt_iss := null;
     select min(substr(value, 1, 12))
       into l_pensn
       from customerw
      where rnk = l_cmclient.rnk and tag = 'PENSN';

     l_cmclient.card_br_iss := nvl(l_pensn, get_nd_param(p_nd, 'COBRANDID'));

     l_cmclient.card_addr_iss := get_nd_param(p_nd, 'BARCOD');
     select min(decode(tag,'PK_IBB', substr(value,1,30)))
       into l_cmclient.delivery_br
       from accountsw
      where acc = l_cmclient.acc
        and tag = 'PK_IBB';
  end if;

  -- ЮЛ
  if l_cmclient.clienttype = 1 then
     l_cmclient.shortname := l_cmclient.shortcompanyname;
     if p_opertype <> 12 then
        l_cmclient.card_type := null;
     end if;

     if l_sed = '91' and p_opertype = 12 then
        l_cmclient.engfirstname := f_translate_kmu(l_cmclient.firstname);
        l_cmclient.englastname  := f_translate_kmu(l_cmclient.lastname);
        l_cmclient.shortnameowner := substr(l_cmclient.firstname, 1, 1)||substr(l_cmclient.middlename, 1, 1)||l_cmclient.lastname;
     else
        l_cmclient.engfirstname := null;
        l_cmclient.englastname  := null;
        l_cmclient.cntm         := null;
        l_cmclient.pind         := null;
     end if;
  end if;
  if l_ismmfo = 1 then
    if l_cmclient.kk_flag = 2 then
       l_cmclient.regnumberclient := g_w4_branch || lpad(to_char(substr(l_rnk,1, length(l_rnk) -2)),8,'0');
    else
       l_cmclient.regnumberclient := g_w4_branch || lpad(to_char(substr(l_cmclient.rnk ,1, length(l_cmclient.rnk) -2)),8,'0');
    end if;
  else
    if l_cmclient.kk_flag = 2 then
       l_cmclient.regnumberclient := g_w4_branch || lpad(to_char(l_rnk),8,'0');
    else
       l_cmclient.regnumberclient := g_w4_branch || lpad(to_char(l_cmclient.rnk),8,'0');
    end if;
  end if;

  -- Корпоративная карта сотрудников ОБУ (счета ФЛ 3550/3551) CORPORATE
     -- карта открывается на ФО
  if l_cmclient.clienttype = 2 and
     substr(l_cmclient.contractnumber,1,3) = '355' and
     -- тип клиента по группе продуктов - ЮО
     l_grpclienttype = 2 then
     l_cmclient.regnumberclient := 'C' || substr(g_w4_branch,-3) || lpad(to_char(l_cmclient.rnk),8,'0');
     l_cmclient.clienttype := 1;
     begin
        -- Country, Resident, ISVIP, K060, CompanyName, ShortCompanyName, KLAS_CLIENT_id – заполняются для Регионального управления
        select to_char(c.country), d.rezid,
               decode(nvl(c.prinsider,0),0,'99',lpad(to_char(c.prinsider),2,'0')),
               decode(l_cmclient.clienttype,1,upper(substr(c.nmk,1,200)),null),
               decode(l_cmclient.clienttype,1,upper(substr(c.nmkk,1,32)),null),
               decode(l_cmclient.clienttype,1,decode(c.custtype,3,2,9),null)
          into l_cmclient.country, l_cmclient.resident, l_cmclient.k060,
               l_cmclient.companyname, l_cmclient.shortcompanyname, l_cmclient.klas_client_id
          from customer c, codcagent d
         where c.rnk = getglobaloption('OUR_RNK')
           and c.codcagent = d.codcagent;
     exception when no_data_found then
        l_cmclient.country := null;
        l_cmclient.resident := null;
        l_cmclient.k060 := null;
        l_cmclient.companyname := null;
        l_cmclient.shortcompanyname := null;
        l_cmclient.klas_client_id := null;
     end;
     l_cmclient.personalisationname := 'OSCHADBANK';
     l_cmclient.isvip := '0';
  end if;

  if l_cmclient.kk_flag = 2 then
     l_cmclient.regnumberowner := g_w4_branch || lpad(to_char(l_cmclient.rnk),8,'0');
  else
     if p_opertype = 12 then
        l_cmclient.regnumberowner := g_w4_branch ||'C'|| lpad(to_char(l_cmclient.rnk),8,'0');
     else
        l_cmclient.regnumberowner := l_cmclient.regnumberclient;
     end if;
  end if;
  l_cmclient.oper_type      := p_opertype;

  l_cmclient.datein      := sysdate;
  l_cmclient.datemod     := null;
  l_cmclient.oper_status := case when p_wait_confirm = 1 then 99 else 1 end;
  l_cmclient.resp_txt    := null;
  l_cmclient.kf := sys_context('bars_context','user_mfo');
  select bars_sqnc.get_nextval('S_CMCLIENT') into l_cmclient.id from dual;

-----#######add in new fields on COBUMMFO-5620 (COBUMMFO-7587)
    get_address_client(p_rnk => l_cmclient.rnk,p_type => 1,
    p_city_type   =>l_cmclient.addr1_city_type,
    p_house       =>l_cmclient.addr1_house,
    p_flat        =>l_cmclient.addr1_flat,
    p_street_type =>l_cmclient.addr1_street_type,
    p_street      =>l_cmclient.addr1_street );

    get_address_client(p_rnk => l_cmclient.rnk,p_type => 2,
    p_city_type   =>l_cmclient.addr2_city_type,
    p_house       =>l_cmclient.addr2_house,
    p_flat        =>l_cmclient.addr2_flat,
    p_street_type =>l_cmclient.addr2_street_type,
    p_street      =>l_cmclient.addr2_street );

---##############-----------------------------------------------------
     --перевірка заповнення обов"язкових полів (COBUMMFO-7587)
    if l_cmclient.clienttype=3 then
     check_address_client(p_rnk => l_cmclient.rnk,p_cm_err_msg=>l_cm_err_msg);
     if length(l_cm_err_msg)>0
       then raise_application_error(-20000, 'Помилка формування запиту :'||'</br>'||l_cm_err_msg);
     end if;
     l_cm_err_msg:='';
    end if;
   -----------

  insert into cm_client_que values l_cmclient;
  if l_iscrm = '1' then
     update cm_client t
        set t.oper_status = 3,
            t.resp_txt    = 'Емуляція обробки заявки по запитам від CRM'
      where t.id = l_cmclient.id;
  end if;
  p_cmclient := l_cmclient;
  bars_audit.info(h || 'Finish.');

end;

procedure add_deal_to_cmque (
  p_nd       in number,
  p_opertype in number,
  p_ad_rnk in number default null, -- RNK клиента на которого необходимо выпустить доп. карту.
  p_card_type in varchar2 default null, -- карточный субпродукт
  p_cntm in integer default null  -- срок действия карты
   )
is
l_cmclient cm_client_que%rowtype;
begin
   add_deal_to_cmque(p_nd, p_opertype, p_ad_rnk, p_card_type, p_cntm, null, l_cmclient);
end;

function f_add_deal_to_cmque (
  p_nd       in number,
  p_opertype in number,
  p_ad_rnk in number default null, -- RNK клиента на которого необходимо выпустить доп. карту.
  p_card_type in varchar2 default null, -- карточный субпродукт
  p_cntm in integer default null,  -- срок действия карты
  p_wait_confirm in integer default null
   ) return cm_client_que%rowtype
is
l_cmclient cm_client_que%rowtype;
begin
   add_deal_to_cmque(p_nd, p_opertype, p_ad_rnk, p_card_type, p_cntm, p_wait_confirm, l_cmclient);
   return l_cmclient;
end;
-------------------------------------------------------------------------------
-- add_deal
-- добавление договора в портфель БПК
--
procedure add_deal (
  p_acc        in number,
  p_cardcode   in varchar2,
  p_bdat       in date,
  p_edat       in date,
  p_nd        out number )
is
  l_nd number;
begin

  begin
     select nd into l_nd from w4_acc where acc_pk = p_acc;
  exception when no_data_found then
     select bars_sqnc.get_nextval('S_OBPCDEAL') into l_nd from dual;
     insert into w4_acc (nd, card_code, acc_pk, dat_begin, dat_end)
     values (l_nd, p_cardcode, p_acc, p_bdat, p_edat);
  end;

  p_nd := l_nd;

end add_deal;

-------------------------------------------------------------------------------
-- set_bpk_parameter
-- добавление договора в портфель БПК
--
procedure set_bpk_parameter(p_nd number, p_tag varchar2, p_value varchar2)
is
d_close w4_acc.dat_close%type;
begin
   begin
  select  distinct dat_close into d_close from (
  select a.dat_close  from  w4_acc a  where a.nd=p_nd
    union
    select a.dat_close from  bpk_acc a  where a.nd=p_nd);
   end;

   if (d_close is null) then
begin
  if p_value is null then
     delete from bpk_parameters where nd = p_nd and tag = p_tag;
  else
     begin
        insert into bpk_parameters (nd, tag, value)
        values (p_nd, p_tag, p_value);
     exception when dup_val_on_index then
        update bpk_parameters
           set value = p_value
         where nd = p_nd and tag = p_tag;
     end;
  end if;
  end;
  else
  raise_application_error(-20000, 'По клієнту ' || to_char(p_nd) || ' неможливо додати доп.параметр, бо він закритий');
   end if;
end set_bpk_parameter;

-------------------------------------------------------------------------------
-- check_opencard
-- функция проверки перед открытием карточки
--
function check_opencard (
  p_rnk       in number,
  p_cardcode  in varchar2 ) return varchar2
is
  l_msg varchar2(254) := null;
  i     number;
begin

  -- при відкритті другого рахунку для одного і того ж клієнта
  --   в рамках одного продукту, генерувати повідомлення типу
  --   „Клієнту вже відкрито рахунок. Відкрити ще один?”
  select count(*) into i
    from w4_acc o, accounts a, w4_card c
   where o.acc_pk = a.acc and a.rnk = p_rnk
     and o.card_code = c.code
     and c.product_code = (select product_code from w4_card where code = p_cardcode);

  if i > 0 then
     l_msg := 'Клієнту вже відкрито рахунок такого продукту.';
  end if;

  return l_msg;

end check_opencard;

-------------------------------------------------------------------------------
-- check_salary_opencard
-- процедура проверки перед открытием карточки по З/П файлу
--
procedure check_salary_opencard (
  p_id       number,
  p_cardcode varchar2 )
is
  l_flagopen number;
  l_msg      ow_salary_data.str_err%type;
begin

 update ow_salary_data
        set flag_open = null,
            str_err = null
      where id = p_id and nvl(flag_open,0) = 2;


  for z in ( select idn, rnk, str_err, flag_open
               from ow_salary_data
              where id = p_id )
  loop

     -- открываем счет
     l_flagopen := 1;
     l_msg      := null;

     -- если ошибка в данных, счет не открываем
     if z.rnk is null and z.str_err is not null then

        l_flagopen := 0;

     elsif z.rnk is not null then

        -- проверка для клиента
        l_msg := check_opencard(z.rnk, p_cardcode);

        -- если какое-то собщение, надо спросить, открывать счет или нет
        if l_msg is not null then
           l_flagopen := 2;
        end if;

     end if;

     update ow_salary_data
        set flag_open = l_flagopen,
            str_err = decode(z.flag_open,2,l_msg,nvl(str_err, l_msg))
      where id = p_id and idn = z.idn;

  end loop;

end check_salary_opencard;

-------------------------------------------------------------------------------
-- set_salary_flagopen
-- процедура установки флага открытия карточки
--
procedure set_salary_flagopen (
  p_id       number,
  p_idn      number,
  p_flagopen number )
is
begin
   update ow_salary_data
      set flag_open = p_flagopen
    where id = p_id and idn = p_idn;
end set_salary_flagopen;

-------------------------------------------------------------------------------
-- set_salary_accinstant
-- процедура установки acc счета Instant
--
procedure set_salary_accinstant (
  p_id         number,
  p_idn        number,
  p_accinstant number )
is
begin
   update ow_salary_data
      set acc_instant = p_accinstant
    where id = p_id and idn = p_idn;
end set_salary_accinstant;

-------------------------------------------------------------------------------
-- set_salary_photo
-- процедура сохранения фото клиента
--
procedure set_salary_photo (
  p_id    number,
  p_idn   number,
  p_photo blob )
is
begin
  if p_photo is null then
     update ow_salary_data
        set str_err = 'Відсутнє фото'
      where id = p_id and idn = p_idn;
  else
     update ow_salary_data
        set kk_photo_data = p_photo
      where id = p_id and idn = p_idn;
  end if;
end set_salary_photo;

-------------------------------------------------------------------------------
-- функция для определения типа операции заявки CM
-- iget_cm_opertype
--
function iget_cm_opertype (
  p_rnk      number,
  -- p_custtype - тип клиента по группе продуктов
  p_custtype number,
  p_nbs      varchar2,
  p_tip      varchar2 ) return number
is
  l_opertype number;
  i number;
begin

  -- определяем opertype
  select count(*) into i from v_cm_client where rnk = p_rnk and oper_status in (1, 2, 3);

  -- информация по клиенту не отправлялась в CardMake
  if i = 0 then

     -- если это не НК, проверяем, есть ли у этого клиента НК, отправленная в файле XA
     if p_tip <> 'W4V' then
        select count(*) into i
          from accounts a, customerw w
         where a.rnk = p_rnk
           and a.nbs IN( '2625','2620') and tip = 'W4V' and ob22 = '22'
           and a.rnk = w.rnk and w.tag = 'RV_XA' and w.value like 'XA%';
     end if;

     -- новый клиент и карта
     if i = 0 then
        if p_custtype = 1 then
           -- 1 - Новий клієнт ФО, контракт, карта
           l_opertype := 1;
        else
           if p_nbs like '355%' then
              -- 7 - Новый клиент сотрудник ОБУ, контракт, корп. карта
              l_opertype := 7;
           else
              -- 4 - Новий клієнт ЮО, контракт, карта
              l_opertype := 4;
           end if;
        end if;
     -- новая карта для существующего клиента
     else
        -- 5 - Новий контракт, карта
        l_opertype := 5;
     end if;

  -- информация по клиенту отправлялась в CardMake,
  -- новая карта для существующего клиента
  else

     -- 5 - Новий контракт, карта
     l_opertype := 5;

  end if;

  return l_opertype;

end iget_cm_opertype;

-------------------------------------------------------------------------------
-- iget_client
--
--
procedure iget_client (
  p_rnk       in number,
  p_customer out customer%rowtype,
  -- Тип клиента из customer: 1-ФЛ, 2-ЮЛ/ФЛ-СПД
  p_ctype    out number )
is
begin

  begin
     select c.* into p_customer from customer c where c.rnk = p_rnk;
  exception when no_data_found then
     -- Не найден клиент RNK=p_rnk
     bars_error.raise_nerror(g_modcode, 'CUSTOMER_NOT_FOUND', to_char(p_rnk));
  end;

  if p_customer.custtype = 3 then
     if nvl(trim(p_customer.sed),'00') = '91' then
        p_ctype := 2;
     else
        p_ctype := 1;
     end if;
  else
     p_ctype := 2;
  end if;

end iget_client;


-------------------------------------------------------------------------------
-- icheck_customer
-- процедура проверки заполнения обязательных реквизитов
--
procedure icheck_customer (
  p_customer     customer%rowtype,
  p_ctype        number,
  p_embfirstname varchar2,
  p_emblastname  varchar2,
  p_secname      varchar2,
  p_schemeid     number )
is
  l_err     varchar2(2000) := null;
  l_person  person%rowtype;
  l_value   customerw.value%type;

  function isnull (p_tag varchar2) return boolean
  is
     b_nullvalue boolean := false;
     l_value customerw.value%type;
  begin
     begin
        select value into l_value from customerw where rnk = p_customer.rnk and tag = p_tag;
     exception when no_data_found then
        b_nullvalue := true;
     end;
     if l_value is null then
        b_nullvalue := true;
     end if;
     return b_nullvalue;
  end;

begin

  if p_customer.okpo      is null then l_err := l_err || chr(10) || 'Ідентифікаційний код'; end if;
  if p_customer.nmk       is null then l_err := l_err || chr(10) || 'Найменування клієнта'; end if;
  if p_customer.country   is null then l_err := l_err || chr(10) || 'Громадянство'; end if;
  if p_customer.codcagent is null then l_err := l_err || chr(10) || 'Ознака резидента'; end if;
  if p_customer.prinsider is null then l_err := l_err || chr(10) || 'Ознака інсайдера'; end if;
  -- Для дебетно-кредитной схемы должен быть заполнен Фінансовий стан позичальника (клас)
  if p_schemeid = 2 then
     if p_customer.crisk is null then l_err := l_err || chr(10) || 'Фінансовий стан позичальника'; end if;
  end if;
  begin
     select value into l_value from customerw where rnk = p_customer.rnk and tag = 'K013';
  exception when no_data_found then
     l_err := l_err || chr(10) || 'Код виду клієнта (K013)';
  end;

  if p_ctype = 1 then

     -- firstname
     if isnull('SN_FN') then l_err := l_err || chr(10) || 'Ім’я'; end if;
     -- lastname,
     if isnull('SN_LN') then l_err := l_err || chr(10) || 'Прізвище'; end if;
     -- middlename
     -- if isnull('SN_MN') then l_err := l_err || chr(10) || 'По-батькові'; end if;
     -- engfirstname
     if p_embfirstname is null then l_err := l_err || chr(10) || 'Ім’я що ембосується';
     else
        if not check_eng(p_embfirstname) then l_err := l_err || chr(10) || 'Ім’я що ембосується - недопустимі символи'; end if;
     end if;
     -- englastname
     if p_emblastname is null then l_err := l_err || chr(10) || 'Прізвище що ембосується';
     else
        if not check_eng(p_emblastname) then l_err := l_err || chr(10) || 'Прізвище що ембосується - недопустимі символи'; end if;
     end if;

     if p_secname is null then l_err := l_err || chr(10) || 'Таємне слово'; end if;

     begin
        -- убрали из проверки person.sex, person.organ
        select *
          into l_person
          from person p
         where p.rnk = p_customer.rnk;
        if l_person.bday is null and l_person.bplace is null and l_person.passp is null and
           l_person.numdoc is null and l_person.ser is null and l_person.pdate is null then
           l_err := l_err || chr(10) || 'Дані паспорта';
        else
           if l_person.bday   is null then l_err := l_err || chr(10) || 'Дата народження'; end if;
           -- if l_person.sex    is null then l_err := l_err || chr(10) || 'Стать'; end if;
           if l_person.passp  is null then l_err := l_err || chr(10) || 'Тип документа'; end if;
           if l_person.numdoc is null then l_err := l_err || chr(10) || 'Номер документу що засвідчує особу'; end if;
           if l_person.ser    is null and l_person.passp <> 7 then l_err := l_err || chr(10) || 'Серія документу що засвідчує особу'; end if;
           if l_person.pdate  is null then l_err := l_err || chr(10) || 'Дата видачі документу що засвідчує особу'; end if;
           if l_person.actual_date is null and l_person.passp = 7 then l_err := l_err || chr(10) || 'Термін дії ID-картки'; end if;
           if l_person.eddr_id is null and l_person.passp = 7 then l_err := l_err || chr(10) || 'Унікальний номер запису в ЄДДР'; end if;

           -- if l_person.organ  is null then l_err := l_err || chr(10) || 'Ким виданий документ що засвідчує особу'; end if;
        end if;
        if nvl(l_person.passp,0) = 1 and l_person.ser is not null and
           (l_person.ser <> upper(l_person.ser) or length(l_person.ser) <> 2) then
           l_err := l_err || chr(10) || 'Некоректна серія паспорту';
        end if;
        if nvl(l_person.passp,0) = 1 and l_person.numdoc is not null and
           (not check_digit(l_person.numdoc) or length(l_person.numdoc) <> 6) then
           l_err := l_err || chr(10) || 'Некоректний номер паспорту';
        end if;
     exception when no_data_found then
        l_err := l_err || chr(10) || 'Дані паспорта';
     end;

  elsif p_ctype = 2 then

     -- shortcompanyname
     if p_customer.nmkk is null then l_err := l_err || chr(10) || 'Краткое наименование организации'; end if;
     -- personalisationname
     if p_embfirstname is null then l_err := l_err || chr(10) || 'Назва компанії що ембосується';
     else
        if not check_eng(p_embfirstname) then l_err := l_err || chr(10) || 'Назва компанії що ембосується - недопустимі символи'; end if;
     end if;
     -- contactperson
     -- if p_emblastname is null then l_err := l_err || chr(10) || 'Прізвище контактної особи'; end if;

  end if;

  -- addr1_cityname
  -- if isnull('FGTWN') then l_err := l_err || chr(10) || 'Місто (прописки/реєстрації)'; end if;

  -- pind
  if l_err is not null then
     bars_error.raise_nerror(g_modcode, 'CUSTOMERPARAMS_ERROR', to_char(p_customer.rnk), l_err);
  end if;

end icheck_customer;

-------------------------------------------------------------------------------
-- check_pkcustomer
-- процедура проверки заполнения обязательных реквизитов для перерегистрации карточки
--
procedure check_pkcustomer (p_pk_nd in number)
is
  l_w4_acc       number;
  l_pk_acc       number;
  l_pk_nls       accounts.nls%type;
  l_pk_kv        accounts.kv%type;
  l_pk_nbs       accounts.nbs%type;
  l_rnk          number;
  l_customer     customer%rowtype;
  l_embfirstname accountsw.value%type;
  l_emblastname  accountsw.value%type;
  l_secname      accountsw.value%type;
  l_ctype        number;    -- Тип клиента из customer: 1-ФЛ, 2-ЮЛ/ФЛ-СПД
begin

  -- старая карточка PK
  begin
     select o.acc_w4, a.acc, a.nls, a.kv, a.nbs, a.rnk
       into l_w4_acc, l_pk_acc, l_pk_nls, l_pk_kv, l_pk_nbs, l_rnk
       from bpk_acc o, accounts a
      where o.nd = p_pk_nd
        and o.acc_pk = a.acc;
  exception when no_data_found then
     -- Договор %s не найден
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_pk_nd));
  end;

  if l_w4_acc is not null then
     --bars_audit.info(h || 'Картку ' || l_pk_nls || '/' || l_pk_kv || ' вже перевипущено');
     bars_error.raise_nerror(g_modcode, 'CARD_ALREADY_REOPEN', l_pk_nls, to_char(l_pk_kv));
  end if;

  -- данные клиента
  begin
     select c.* into l_customer from customer c where c.rnk = l_rnk;
  exception when no_data_found then
     -- Не найден клиент RNK=p_rnk
     bars_error.raise_nerror(g_modcode, 'CUSTOMER_NOT_FOUND', to_char(l_rnk));
  end;

  begin
     select min(decode(tag,decode(l_pk_nbs,'2625','W4_EFN','2620','W4_EFN','W4_ECN'),value,null)) embfirstname,
            min(decode(tag,decode(l_pk_nbs,'2625','W4_ELN','2620','W4_ELN','W4_CPN'),value,null)) emblastname,
            min(decode(tag,'W4_SEC',  value,null)) secname
       into l_embfirstname, l_emblastname, l_secname
       from accountsw
      where acc = l_pk_acc;
  exception when no_data_found then
     l_embfirstname := null;
     l_emblastname := null;
     l_secname := null;
  end;

  if l_embfirstname is null then
     l_embfirstname := substr(fio(l_customer.nmkv,2),1,30);
  end if;
  if l_emblastname is null then
     l_emblastname := substr(fio(l_customer.nmkv,1),1,30);
  end if;

  -- если Таємне слово не заполнено, берем из старой карточки
  if l_secname is null then
     select min(substr(value,1,254)) into l_secname
       from customerw
      where rnk = l_customer.rnk and tag='PC_MF';
  end if;

  if l_customer.custtype = 3 then
     if nvl(trim(l_customer.sed),'00') = '91' then
        l_ctype := 2;
     else
        l_ctype := 1;
     end if;
  else
     l_ctype := 2;
  end if;

  icheck_customer(l_customer, l_ctype, l_embfirstname, l_emblastname, l_secname, 0);

end check_pkcustomer;

-------------------------------------------------------------------------------
-- iget_datend
-- функция получения дати закінчення кредитного договору
--
function iget_datend (p_datbegin date, p_term number, p_product_grp varchar2) return date
is
begin
  -- Дата закінчення кредитного договору
  --   Для довгострокових продуктів:
  --     Дата початку кредитного договору + кількість місяців дії БПК,
  --     або
  --     Дата початку кредитного договору + 12місяців + 1день, якщо карта преміум класу
  --   Для короткострокових продуктів:
  --     Дата початку кредитного договору + 12місяців - 1день.
  -- Если не указаны ни кількість місяців дії БПК, ни макс. кількість місяців дії Картки по продукту, то считаем продукт долгосрочным.
  return case when nvl(p_term,13) = 12       then add_months(p_datbegin, p_term) - 1
              when p_product_grp = 'PREMIUM' then add_months(p_datbegin, 12) + 1
              else                                add_months(p_datbegin, nvl(p_term,13))
         end;
end iget_datend;

-------------------------------------------------------------------------------
-- link_instant_card
-- процедура регистрации карточки Instant на клиента
--
procedure link_instant_card (
  p_nls       in varchar2,
  p_customer  in customer%rowtype,
  p_product   in t_product,
  p_branch    in varchar2,
  p_acc      out number )
is
  l_acc         number;
  l_acc_subcode w4_card.sub_code%type;
  l_acc_nbs     w4_product.nbs%type;
  l_acc_kv      w4_product.kv%type;
  l_vid         number;
  l_nls         accounts.nls%type;
begin

  -- проверка типов карт
  begin
     select a.acc, c.sub_code, p.nbs, p.kv, a.nls
       into l_acc, l_acc_subcode, l_acc_nbs, l_acc_kv, l_nls
       from accounts a, w4_acc_instant w, w4_card c, w4_product p
      where (a.nls = p_nls or a.nlsalt = p_nls)
        and a.acc = w.acc
        and w.card_code = c.code
        and c.product_code = p.code
        and nvl(w.state,0) = 0;
  exception
     when no_data_found then
        -- Счет не найден: p_nls
        bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', p_nls);
     when too_many_rows then
        begin
           select a.acc, c.sub_code, p.nbs, p.kv, a.nls
             into l_acc, l_acc_subcode, l_acc_nbs, l_acc_kv, l_nls
             from accounts a, w4_acc_instant w, w4_card c, w4_product p
            where (a.nls = p_nls or a.nlsalt = p_nls)
              and a.kv = p_product.kv
              and a.acc = w.acc
              and w.card_code = c.code
              and c.product_code = p.code
              and nvl(w.state, 0) = 0;
        exception when no_data_found then
           -- Счет не найден: p_nls
           bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', p_nls);
        end;
  end;

  if p_product.sub_code not like l_acc_subcode || '%' then
     -- Тип карты Instant не совпадает с типом карты
     bars_error.raise_nerror(g_modcode, 'SUBCARDACC_SUBCARDCARD_ERROR');
  end if;
  if p_product.nbs <> l_acc_nbs then
     -- БС не совпадает с БС карточки
     bars_error.raise_nerror(g_modcode, 'NBSACC_NBSCARD_ERROR');
  end if;
  if p_product.kv <> l_acc_kv then
     -- Валюта счета не совпадает с валютой карточки
     bars_error.raise_nerror(g_modcode, 'KVACC_KVCARD_ERROR');
  end if;

  -- физ. лицо
  if p_product.custtype = 1 then
     l_vid := 0;
  -- юр. лицо / физ. лицо-предприниматель
  else
     l_vid := 1;
  end if;

  if  p_product.custtype <> 1 then
    -- Переводимо рахунок в статус Підтвердження бек-офісом
     update w4_acc_instant t
     set t.state = 1,
         t.rnk = p_customer.rnk
     where t.acc =  l_acc;

     update accounts
        set rnk = p_customer.rnk,
            nms = p_customer.nmk,
            vid = l_vid,
            tobo = p_branch,
            daos = bankdate,
            dazs = bankdate
      where acc = l_acc;
  else
    -- привязываем счет к клиенту
     update accounts
        set rnk = p_customer.rnk,
            nms = substr('БПК ' || p_customer.nmk || ' ' || p_product.card_code,1,70),
            -- Костиль для карток інтстант випущенних до заміни плану рахунків
            nbs = case when p_product.nbs = substr(l_nls, 1, 4) then p_product.nbs else substr(p_nls, 1, 4) end,
            tip = p_product.tip,
            vid = l_vid,
            tobo = p_branch,
            daos = decode(dapp,null,bankdate, daos),
            dazs = null
      where acc = l_acc;

    -- доступ к счету
     p_after_open_acc(l_acc);

    -- удаляем счет из справочника счетов Instant после привязки
     delete from w4_acc_instant where acc = l_acc;
  end if;
  p_acc := l_acc;

end link_instant_card;

-------------------------------------------------------------------------------
-- open_new_card
-- процедура регистрации новой карточки
--
procedure open_new_card (
  p_customer  in customer%rowtype,
  p_product   in t_product,
  p_branch    in varchar2,
  p_acc      out number )
is
  l_nls accounts.nls%type;
  l_nms accounts.nms%type;
  l_grp number;
  l_vid number;
  l_acc number;
  l_tmp number;
begin

  -- карточный счет -------
  select f_newnls2(null, p_product.tip, p_product.nbs, p_customer.rnk, null, p_product.kv),
         substr(f_newnms (null, p_product.tip, p_product.nbs, p_customer.rnk, null),1,70)
    into l_nls, l_nms
    from dual;
  l_nms := substr(l_nms || ' ' || p_product.card_code, 1, 70);

  -- проверка: счет не занят
  -- на валюту не проверяем, т.к. ПЦ не работает с мультивалютными счетами
  select count(*) into l_tmp from accounts where nls = l_nls;

  if l_tmp > 0 then
     -- счет нашли, он занят, определяем свободный
     l_nls := get_newaccountnumber(p_customer.rnk, p_product.nbs);
  end if;

  -- физ. лицо
  if p_product.custtype = 1 then
     l_vid := 0;
  -- юр. лицо / физ. лицо-предприниматель
  else
     l_vid := 3;
  end if;

  -- открытие карточного счета
  op_reg_lock(99, 0, 0, l_grp, l_tmp, p_customer.rnk, l_nls, p_product.kv, l_nms,
     p_product.tip, user_id, l_acc, 1, null,
     l_vid, null, null, null, null, case when p_product.custtype = 1 then null else 26 end, null, null, null, null, p_branch);
  -- по ЮО закриваємо рахунок і ставимо його в чергу на підтвердження
  if p_product.custtype <> 1 then
     update accounts a set a.dazs = bankdate, a.nbs = null where a.acc = l_acc;
     insert into w4_acc_instant
       (acc, card_code, batchid, state, rnk)
     values
       (l_acc, p_product.card_code, null, 1, p_customer.rnk);
  end if;
  p_acc := l_acc;

end open_new_card;

function get_pers_xml(p_type     in integer,
                      p_cmclient in cm_client_que%rowtype,
                      p_reqid    in number) return xmltype is
    /***********************************************************
     * p_type  = 1 Персоналізація карти по існуючому клієнту   *
     *           2 Реєстрація клієнта                          *
     *           3 Персоналізація картки                       *
     ***********************************************************/
  l_k2 varchar2(2);
  l_k3 varchar2(3);
  l_xml xmltype;
begin
  begin
    select t.a2, t.kod_lit
      into l_k2, l_k3
      from kl_k040 t
     where t.k040 = p_cmclient.country;
  exception
    when no_data_found then
      l_k2 := 'UA';
      l_k3 := 'UKR';
  end;
  if p_type = 1 then
    select xmlelement("UFXMsg",
                        xmlattributes('2.0' as "version",
                                       'WAY4Appl' as "scheme",
                                       'Application' as "msg_type",
                                       'Rq' as "direction"),
                        xmlelement("MsgId", 'ABS'||g_w4_branch||'_'||p_reqid),
                        xmlelement("Source",
                                   xmlattributes('CARD_MAKE' as "app")),
                        xmlelement("MsgData",
                                   xmlelement("Application",
                                              xmlforest('ABS'||g_w4_branch||'_INST_'||p_reqid  as "RegNumber",
                                                        g_w4_branch as "Institution",
                                                        p_cmclient.branch as "OrderDprt",
                                                        'Client' as "ObjectType",
                                                        'AddOrUpdate' as "ActionType"),
                                              xmlelement("ObjectFor",
                                                         xmlelement("ClientIDT",
                                                                    xmlelement("ClientInfo",
                                                                               xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                         p_cmclient.shortname as "ShortName")))),
                                              xmlelement("Data",
                                                         xmlelement("Client",
                                                                    xmlforest(g_w4_branch as "Institution",
                                                                              p_cmclient.branch as "OrderDprt",
                                                                              'PR' as "ClientType"),
                                                                    xmlelement("ClientInfo",
                                                                               xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                         p_cmclient.paspseries||' '||p_cmclient.paspnum  as "RegNumber",
                                                                                         to_char(p_cmclient.paspdate, 'yyyymmdd')||' '||p_cmclient.paspissuer as "RegNumberDetails",
                                                                                         p_cmclient.shortname as "ShortName",
                                                                                         p_cmclient.firstname as "FirstName",
                                                                                         p_cmclient.lastname as "LastName",
                                                                                         p_cmclient.middlename as "MiddleName",
                                                                                         p_cmclient.pind as "SecurityName",
                                                                                         l_k3 as "Country",
                                                                                         l_k3 as "Language",
    /*                                                                                     '*ВЛАСНА КАРТКА' as "CompanyName",
    */                                                                                     p_cmclient.companyname as "CompanyName",
                                                                                         p_cmclient.birthdate as "BirthDate",
                                                                                         decode(p_cmclient.gender,1,'Male',2,'Female', null) as "Gender")),
                                                                    xmlelement("PlasticInfo",
                                                                               xmlforest(p_cmclient.engfirstname as "FirstName",
                                                                                         p_cmclient.englastname as "LastName")),
                                                                    case when p_cmclient.phonenumber_mob is not null /*or p_cmclient.phonenumber is not null
                                                                              or p_cmclient.phonenumber_dod is not null*/ then
                                                                              xmlelement("PhoneList",
                                                                                         xmlelement("Phone",
                                                                                                    xmlforest(decode(p_cmclient.phonenumber_mob, null, null,'Mobile') as "PhoneType",
                                                                                                              p_cmclient.phonenumber_mob as "PhoneNumber"/*,
                                                                                                              decode(p_cmclient.phonenumber, null, null,'Home') as "PhoneType",
                                                                                                              p_cmclient.phonenumber as "PhoneNumber",
                                                                                                              decode(p_cmclient.phonenumber_dod, null, null,'Work') as "PhoneType",
                                                                                                              p_cmclient.phonenumber_dod as "PhoneNumber"*/)))
                                                                         else null end,
                                                                    xmlelement("BaseAddress",
                                                                               xmlforest('STMT' as "AddressType",
                                                                                         p_cmclient.firstname as "FirstName",
                                                                                         p_cmclient.lastname as "LastName",
                                                                                         l_k3 as "Country",
                                                                                         l_k2 as "State",
                                                                                         p_cmclient.addr1_cityname as "City",
                                                                                         p_cmclient.addr1_pcode as "PostalCode",
                                                                                         p_cmclient.addr1_domain as "AddressLine1",
                                                                                         p_cmclient.addr1_street as "AddressLine2",
                                                                                         p_cmclient.addr1_region as "AddressLine4")),
                                                                    xmlelement("AddInfo",
                                                                               xmlforest(p_cmclient.taxpayeridentifier as "AddInfo01",
                                                                                         'INSIDER='||decode(p_cmclient.k060,'99','NO', 'YES')||';CNTR='||l_k3||';' as "AddInfo02")))),
                                              xmlelement("SubApplList",
                                                         case when  p_cmclient.phonenumber_mob is not null then
                                                                    xmlelement("Application",
                                                                               xmlforest('ABS'||g_w4_branch||'_SMS_'||p_reqid as "RegNumber",
                                                                                         'ClientAddress' as "ObjectType",
                                                                                         'AddOrUpdate' as "ActionType"),
                                                                               xmlelement("Data",
                                                                                          xmlelement("Address",
                                                                                                     xmlforest('SMS_ADDRESS' as "AddressType",
                                                                                                               p_cmclient.phonenumber_mob as "PostalCode",
                                                                                                               'SMS' as "AddressLine1")))
                                                                               )
                                                              else null end,
                                                         xmlelement("Application",
                                                                    xmlforest('ABS'||g_w4_branch||'_CN_'||p_reqid as "RegNumber",
                                                                              --g_w4_branch as "Institution",
                                                                              p_cmclient.branch as "OrderDprt",
                                                                              'Contract' as "ObjectType",
                                                                              'Update' as "ActionType"),
                                                                    xmlelement("ObjectFor",
                                                                               xmlelement("ContractIDT",
                                                                                          xmlelement("ContractNumber",g_w4_branch||'-'||p_cmclient.contractnumber),
                                                                                          xmlelement("Client",
                                                                                                     xmlelement("ClientInfo",
                                                                                                                xmlforest(g_w4_branch||'00000000' as "ClientNumber",
                                                                                                                          'ІІНСТАНТ' as "ShortName"))))),
                                                                    xmlelement("Data",
                                                                               xmlelement("Contract",
                                                                                          xmlelement("ContractIDT",
                                                                                                     xmlelement("Client",
                                                                                                                xmlelement("ClientInfo",
                                                                                                                           xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                                                                     p_cmclient.shortname as "ShortName")))),
                                                                                          xmlelement("ContractName", p_cmclient.shortname),
                                                                                          xmlelement("Product",
                                                                                                     xmlelement("ProductCode1", p_cmclient.productcode)),
                                                                                          xmlelement("AddContractInfo",
                                                                                                     xmlforest(p_cmclient.okpo_sysorg as "AddInfo01",
                                                                                                               p_cmclient.branch as "AddInfo03"
                                                                                                               ))
                                                                                                               )),
                                                                    xmlelement("SubApplList",
                                                                               xmlelement("Application",
                                                                                          xmlforest('ABS'||g_w4_branch||'_SCN_'||p_reqid as "RegNumber",
                                                                                                    p_cmclient.branch as "OrderDprt",
                                                                                                    'Contract' as "ObjectType",
                                                                                                    'Update' as "ActionType"),
                                                                                          xmlelement("ObjectFor",
                                                                                                     xmlelement("ContractIDT",
                                                                                                                xmlforest(p_cmclient.contractnumber||'_0001' as "CBSNumber",
                                                                                                                          g_w4_branch as "CBSCode"),
                                                                                                                xmlelement("Client",
                                                                                                                           xmlelement("ClientInfo",
                                                                                                                                      xmlforest(g_w4_branch||'00000000' as "ClientNumber",
                                                                                                                                                'ІІНСТАНТ' as "ShortName"))))),
                                                                                          xmlelement("Data",
                                                                                                     xmlelement("Contract",
                                                                                                                xmlelement("ContractIDT",
                                                                                                                           xmlelement("Client",
                                                                                                                                      xmlelement("ClientInfo",
                                                                                                                                                 xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                                                                                           p_cmclient.shortname as "ShortName")))),
                                                                                                                xmlelement("ContractName", p_cmclient.shortname),
                                                                                                                xmlelement("Product",
                                                                                                                           xmlelement("ProductCode1", p_cmclient.card_type)),
                                                                                                                xmlelement("PlasticInfo",
                                                                                                                           xmlforest(p_cmclient.engfirstname as "FirstName",
                                                                                                                                     p_cmclient.englastname as "LastName"))))))))))) as aa
        into l_xml
        from dual;

  elsif p_type = 2 then
    select xmlelement("UFXMsg",
                        xmlattributes('2.0' as "version",
                                       'WAY4Appl' as "scheme",
                                       'Application' as "msg_type",
                                       'Rq' as "direction"),
                        xmlelement("MsgId", 'ABS'||g_w4_branch||'_'||p_reqid),
                        xmlelement("Source",
                                   xmlattributes('CARD_MAKE' as "app")),
                        xmlelement("MsgData",
                                   xmlelement("Application",
                                              xmlforest('ABS'||g_w4_branch||'_INST_'||p_reqid  as "RegNumber",
                                                        g_w4_branch as "Institution",
                                                        p_cmclient.branch as "OrderDprt",
                                                        'Client' as "ObjectType",
                                                        'AddOrUpdate' as "ActionType"),
                                              xmlelement("ObjectFor",
                                                         xmlelement("ClientIDT",
                                                                    xmlelement("ClientInfo",
                                                                               xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                         p_cmclient.shortname as "ShortName")))),
                                              xmlelement("Data",
                                                         xmlelement("Client",
                                                                    xmlforest(g_w4_branch as "Institution",
                                                                              p_cmclient.branch as "OrderDprt",
                                                                              'PR' as "ClientType"),
                                                                    xmlelement("ClientInfo",
                                                                               xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                         p_cmclient.paspseries||' '||p_cmclient.paspnum  as "RegNumber",
                                                                                         to_char(p_cmclient.paspdate, 'yyyymmdd')||' '||p_cmclient.paspissuer as "RegNumberDetails",
                                                                                         p_cmclient.shortname as "ShortName",
                                                                                         p_cmclient.firstname as "FirstName",
                                                                                         p_cmclient.lastname as "LastName",
                                                                                         p_cmclient.middlename as "MiddleName",
                                                                                         p_cmclient.pind as "SecurityName",
                                                                                         l_k3 as "Country",
                                                                                         l_k3 as "Language",
    /*                                                                                     '*ВЛАСНА КАРТКА' as "CompanyName",
    */                                                                                     p_cmclient.companyname as "CompanyName",
                                                                                         p_cmclient.birthdate as "BirthDate",
                                                                                         decode(p_cmclient.gender,1,'Male',2,'Female', null) as "Gender")),
                                                                    xmlelement("PlasticInfo",
                                                                               xmlforest(p_cmclient.engfirstname as "FirstName",
                                                                                         p_cmclient.englastname as "LastName")),
                                                                    case when p_cmclient.phonenumber_mob is not null /*or p_cmclient.phonenumber is not null
                                                                              or p_cmclient.phonenumber_dod is not null*/ then
                                                                              xmlelement("PhoneList",
                                                                                         xmlelement("Phone",
                                                                                                    xmlforest(decode(p_cmclient.phonenumber_mob, null, null,'Mobile') as "PhoneType",
                                                                                                              p_cmclient.phonenumber_mob as "PhoneNumber"/*,
                                                                                                              decode(p_cmclient.phonenumber, null, null,'Home') as "PhoneType",
                                                                                                              p_cmclient.phonenumber as "PhoneNumber",
                                                                                                              decode(p_cmclient.phonenumber_dod, null, null,'Work') as "PhoneType",
                                                                                                              p_cmclient.phonenumber_dod as "PhoneNumber"*/)))
                                                                         else null end,
                                                                    xmlelement("BaseAddress",
                                                                               xmlforest('STMT' as "AddressType",
                                                                                         p_cmclient.firstname as "FirstName",
                                                                                         p_cmclient.lastname as "LastName",
                                                                                         l_k3 as "Country",
                                                                                         l_k2 as "State",
                                                                                         p_cmclient.addr1_cityname as "City",
                                                                                         p_cmclient.addr1_pcode as "PostalCode",
                                                                                         p_cmclient.addr1_domain as "AddressLine1",
                                                                                         p_cmclient.addr1_street as "AddressLine2",
                                                                                         p_cmclient.addr1_region as "AddressLine4")),
                                                                    xmlelement("AddInfo",
                                                                               xmlforest(p_cmclient.taxpayeridentifier as "AddInfo01",
                                                                                         'INSIDER='||decode(p_cmclient.k060,'99','NO', 'YES')||';CNTR='||l_k3||';' as "AddInfo02")))),
                                              xmlelement("SubApplList",
                                                         case when  p_cmclient.phonenumber_mob is not null then
                                                                    xmlelement("Application",
                                                                               xmlforest('ABS'||g_w4_branch||'_SMS_'||p_reqid as "RegNumber",
                                                                                         'ClientAddress' as "ObjectType",
                                                                                         'AddOrUpdate' as "ActionType"),
                                                                               xmlelement("Data",
                                                                                          xmlelement("Address",
                                                                                                     xmlforest('SMS_ADDRESS' as "AddressType",
                                                                                                               p_cmclient.phonenumber_mob as "PostalCode",
                                                                                                               'SMS' as "AddressLine1")))
                                                                               )
                                                              else null end
                                                              )))) as aa
        into l_xml
        from dual;
  elsif p_type = 3 then
    select xmlelement("UFXMsg",
                        xmlattributes('2.0' as "version",
                                       'WAY4Appl' as "scheme",
                                       'Application' as "msg_type",
                                       'Rq' as "direction"),
                        xmlelement("MsgId", 'ABS'||g_w4_branch||'_'||p_reqid),
                        xmlelement("Source",
                                   xmlattributes('CARD_MAKE' as "app")),
                        xmlelement("MsgData",
                                   xmlelement("Application",
                                              xmlforest('ABS'||g_w4_branch||'_CN_'||p_reqid as "RegNumber",
                                                        g_w4_branch as "Institution",
                                                        p_cmclient.branch as "OrderDprt",
                                                        'Contract' as "ObjectType",
                                                        'Update' as "ActionType"),
                                              xmlelement("ObjectFor",
                                                         xmlelement("ContractIDT",
                                                                    xmlelement("ContractNumber",g_w4_branch||'-'||p_cmclient.contractnumber),
                                                                    xmlelement("Client",
                                                                               xmlelement("ClientInfo",
                                                                                          xmlforest(g_w4_branch||'00000000' as "ClientNumber",
                                                                                                    'ІІНСТАНТ' as "ShortName"))))),
                                              xmlelement("Data",
                                                         xmlelement("Contract",
                                                                    xmlelement("ContractIDT",
                                                                               xmlelement("Client",
                                                                                          xmlelement("ClientInfo",
                                                                                                     xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                                               p_cmclient.shortname as "ShortName")))),
                                                                    xmlelement("ContractName", p_cmclient.shortname),
                                                                    xmlelement("Product",
                                                                               xmlelement("ProductCode1", p_cmclient.productcode)),
                                                                    xmlelement("AddContractInfo",
                                                                               xmlforest(p_cmclient.okpo_sysorg as "AddInfo01",
                                                                                         p_cmclient.branch as "AddInfo03"
                                                                                         ))
                                                                                         )),
                                              xmlelement("SubApplList",
                                                         xmlelement("Application",
                                                                    xmlforest('ABS'||g_w4_branch||'_SCN_'||p_reqid as "RegNumber",
                                                                              p_cmclient.branch as "OrderDprt",
                                                                              'Contract' as "ObjectType",
                                                                              'Update' as "ActionType"),
                                                                    xmlelement("ObjectFor",
                                                                               xmlelement("ContractIDT",
                                                                                          xmlforest(p_cmclient.contractnumber||'_0001' as "CBSNumber",
                                                                                                    g_w4_branch as "CBSCode"),
                                                                                          xmlelement("Client",
                                                                                                     xmlelement("ClientInfo",
                                                                                                                xmlforest(g_w4_branch||'00000000' as "ClientNumber",
                                                                                                                          'ІІНСТАНТ' as "ShortName"))))),
                                                                    xmlelement("Data",
                                                                               xmlelement("Contract",
                                                                                          xmlelement("ContractIDT",
                                                                                                     xmlelement("Client",
                                                                                                                xmlelement("ClientInfo",
                                                                                                                           xmlforest(p_cmclient.regnumberclient as "ClientNumber",
                                                                                                                                     p_cmclient.shortname as "ShortName")))),
                                                                                          xmlelement("ContractName", p_cmclient.shortname),
                                                                                          xmlelement("Product",
                                                                                                     xmlelement("ProductCode1", p_cmclient.card_type)),
                                                                                          xmlelement("PlasticInfo",
                                                                                                     xmlforest(p_cmclient.engfirstname as "FirstName",
                                                                                                               p_cmclient.englastname as "LastName"))))))))) as aa
        into l_xml
        from dual;
  end if;
  return l_xml;
end;

function add_query_to_log(p_rnk in number,
                          p_nd       in number,
                          p_respcode in number default null,
                          p_resptext in varchar2 default null,
                          p_reqbody  in clob default null,
                          p_respbody in clob default null,
                          p_reqid    in number default null,
                          p_err_text in varchar2 default null) return number is
  pragma autonomous_transaction;
  l_reqid number;
begin
if p_reqid is null then
  insert into ow_query_log
    (reqid, rnk, nd)
  values
    (bars_sqnc.get_nextval('S_OW_QUERY_LOG'), p_rnk, p_nd)
  returning reqid into l_reqid;
else
 update ow_query_log t
       set t.respcode = p_respcode,
           t.resptext = p_resptext,
           t.reqbody  = p_reqbody,
           t.respbody = p_respbody,
           t.err_text = p_err_text
     where t.reqid    = p_reqid;
l_reqid:=p_reqid;
end if;
 commit;
  return l_reqid;
end;

function send_request(p_body in clob) return wsm_mgr.t_response is
  l_url         params$global.val%type := getglobaloption('OWPERSURL');
  l_wallet_path varchar2(256) := getglobaloption('OWWALLETPATH');
  l_wallet_pwd  varchar2(256) := getglobaloption('OWWALETPWD');
  l_response    wsm_mgr.t_response;

begin
  wsm_mgr.g_transfer_timeout := 30;
  wsm_mgr.prepare_request(p_url         => l_url,
                          p_action      => null,
                          p_http_method => wsm_mgr.g_http_post,
                          p_wallet_path => l_wallet_path,
                          p_wallet_pwd  => l_wallet_pwd,
                          p_body        => p_body);

  wsm_mgr.add_header(p_name  => 'Content-Type',
                     p_value => 'text/plain; charset=utf-8');
  -- позвать метод веб-сервиса
  wsm_mgr.execute_api(l_response);

  l_response.cdoc := decodeclobfrombase64(dbms_lob.substr(l_response.cdoc,
                                                          length(l_response.cdoc) - 2,
                                                          2));
  return l_response;
end;

function pers_instant_card(p_nd in number, p_cmclient in cm_client_que%rowtype)
  return varchar2 is
  l_err varchar2(4000) := null;
  l_xml xmltype;
  l_body clob;
  l_reqid number;
  l_k2 varchar2(2);
  l_k3 varchar2(3);
  l_response wsm_mgr.t_response;
  l_respcode number;
  l_resptext varchar2(4000);
  l_url params$global.val%type := getglobaloption('OWPERSURL');
  l_wallet_path varchar2(256) :=  getglobaloption('OWWALLETPATH');
  l_wallet_pwd varchar2(256) := getglobaloption('OWWALETPWD');
  l_respxml xmltype;
  l_tmp pls_integer;
begin

  select count(*) into l_tmp from v_cm_client where rnk = p_cmclient.rnk and oper_status in (2, 3);


  l_reqid := add_query_to_log(p_cmclient.rnk, p_nd);

  if l_tmp > 0 then
    l_xml := get_pers_xml(1, p_cmclient, l_reqid);
    l_body := l_xml.getClobVal();

    l_response := send_request(l_body);
    l_respxml := xmltype(l_response.cdoc);
    l_respcode := to_number(extract(l_respxml,'UFXMsg/@resp_code', null));
    l_resptext := extract(l_respxml,'UFXMsg/@resp_text', null);

    l_reqid :=add_query_to_log(p_cmclient.rnk, p_nd, l_respcode, l_resptext, l_body, l_response.cdoc, l_reqid);
	
  else
    l_xml := get_pers_xml(2, p_cmclient, l_reqid);
    l_body := l_xml.getClobVal();

    l_response := send_request(l_body);

    l_respxml := xmltype(l_response.cdoc);
    l_respcode := to_number(extract(l_respxml,'UFXMsg/@resp_code', null));
    l_resptext := extract(l_respxml,'UFXMsg/@resp_text', null);

    l_reqid :=add_query_to_log(p_cmclient.rnk, p_nd, l_respcode, l_resptext, l_body, l_response.cdoc, l_reqid);
	
    if l_respcode = 0 then

      l_reqid := add_query_to_log(p_cmclient.rnk, p_nd);
      l_xml := get_pers_xml(3, p_cmclient, l_reqid);
      l_body := l_xml.getClobVal();

      l_response := send_request(l_body);
      l_respxml := xmltype(l_response.cdoc);
      l_respcode := to_number(extract(l_respxml,'UFXMsg/@resp_code', null));
      l_resptext := extract(l_respxml,'UFXMsg/@resp_text', null);

      l_reqid :=add_query_to_log(p_cmclient.rnk, p_nd, l_respcode, l_resptext, l_body, l_response.cdoc, l_reqid);

    end if;
  end if;
  if l_respcode = 0 then
     l_err:='OK';
  else
     l_err := l_resptext;
  end if;
  return l_err;
exception
  when others then
    l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
                  dbms_utility.format_error_backtrace(), 1, 4000);
    l_reqid :=add_query_to_log(null,null,null, null, l_body, l_response.cdoc, l_reqid, l_err);
  
    return l_err;
end;

-------------------------------------------------------------------------------
-- open_card
-- процедура регистрации нового договора БПК
--
procedure open_card (
  p_rnk           in number,
  p_nls           in varchar2,
  p_cardcode      in varchar2,
  p_branch        in varchar2,
  p_embfirstname  in varchar2,
  p_emblastname   in varchar2,
  p_secname       in varchar2,
  p_work          in varchar2,
  p_office        in varchar2,
  p_wdate         in date,
  p_salaryproect  in number,
  p_term          in number,
  p_branchissue   in varchar2,
  p_barcode       in varchar2 default null,
  p_cobrandid     in varchar2 default null,
  p_sendsms       in number default 1,
  p_nd            out number,
  p_reqid         out number)
is
  l_customer   customer%rowtype;
  l_product    t_product;
  l_ctype      number;        -- Тип клиента из customer: 1-ФЛ, 2-ЮЛ/ФЛ-СПД
  l_term       number;
  l_edat       date;
  l_acc        number;
  l_nd         number;
  l_opertype   number;
  i number;
  l_cmclient   cm_client_que%rowtype;
  l_pers_err       varchar2(4000);
  l_dkbo_deal  number;
  h varchar2(100) := 'bars_ow.open_card. ';
  l_sendsms    varchar2(3);
  l_iscrm      varchar2(1) := nvl(sys_context('CLIENTCONTEXT','ISCRM'), '0');
  l_salaryproect bpk_proect.id%type;
  l_cm_err_msg varchar2(1000);
  l_add_card integer;
  l_city_type    customer_address.locality_type%TYPE;
  l_house        customer_address.home%TYPE;
  l_flat         customer_address.room%TYPE;
  l_street_type  address_street_type.name%TYPE;
  l_street       customer_address.street%TYPE;

  --l_salaryproect bpk_proect.id%type;
  l_trmask t_trmask;
begin

  bars_audit.info(h || 'Start.');

  -- данные клиента
  iget_client (
     p_rnk      => p_rnk,
     p_customer => l_customer,
     p_ctype    => l_ctype );

  -- данные продукта
  l_term := p_term;
  iget_product (
     p_cardcode => p_cardcode,
     p_term     => l_term,
     p_product  => l_product );

  -- проверка соответствия продукта и типа клиента
  --   l_ctype    - Тип клиента из customer: 1-ФЛ, 2-ЮЛ/ФЛ-СПД
  --   l_custtype - Тип клиента из w4_product_groups
  if l_ctype <> l_product.custtype then
     -- разрешаем для ФЛ открывать CORPORATE 3550/3551
     if l_ctype = 1 and l_product.nbs like '355%' then
        null;
     else
        bars_error.raise_nerror(g_modcode, 'CTYPE_ERROR');
     end if;
  end if;

  -- проверка на возможность открытия именной карты
  if l_product.flag_instant = 1 and
     ( l_product.date_instant is null or l_product.date_instant <= bankdate ) and
     p_nls is null then
        -- Запрещен выпуск именных карт по субпродукту l_product.sub_code
        bars_error.raise_nerror(g_modcode, 'FLAGINSTANT_ERROR', l_product.sub_code);
  end if;

  -- проверка на наличие Картки киянина
  if l_product.flag_kk = 1 then
     select count(*) into i
       from w4_acc o, accounts a, w4_card d, w4_subproduct s
      where o.acc_pk = a.acc and a.rnk = p_rnk and a.dazs is null
        and o.card_code = d.code
        and d.sub_code = s.code
        and s.flag_kk = 1;
     if i > 0 then
        raise_application_error(-20000, 'Клієнту вже відкрито Картку киянина');
     end if;
  end if;

  icheck_customer(l_customer, l_ctype, p_embfirstname, p_emblastname, p_secname, l_product.schemeid);

  if p_branchissue is null then
     raise_application_error(-20000, 'Не заповнено: Адреса доставки Картки');
  end if;

  -- регистрация новой карточки
  if p_nls is null then

     open_new_card(l_customer, l_product, p_branch, l_acc);

     -- определяем тип заявки opertype
     l_opertype := iget_cm_opertype(p_rnk, l_product.custtype, l_product.nbs, l_product.tip);

  -- регистрации карточки Instant
  else

     link_instant_card(p_nls, l_customer, l_product, p_branch, l_acc);

     if l_ctype = 2  then
     -- тип заявки opertype = 12 - перепривязка счета Instant_MMSB
       l_opertype := 12;
       if p_secname is null then
          raise_application_error(-20000, 'Не заповнено: Таємне слово');
       end if;
     else
     -- тип заявки opertype = 6 - перепривязка счета Instant
       l_opertype := 6;
     end if;
  end if;

  -- дата закінчення кредитного договору
  l_edat := iget_datend(bankdate, l_term, l_product.product_grp);

  -- добавление в портфель БПК
  add_deal(l_acc, p_cardcode, bankdate, l_edat, l_nd);

  -- параметры договора
  -- Первинний ВКР --VNCRP
  set_bpk_parameter(l_nd, 'VNCRP', get_customer_vncrp(p_rnk, bankdate));

  -- устанавливаем такой же как VNCRP в поточний (VNCRR)
  -- поточний ВНКР   --VNCRR
  set_bpk_parameter(l_nd, 'VNCRR', get_customer_vncrp(p_rnk, bankdate));
 
 --устанавливаем доп.параметры BUS_MOD,IFRS,SPPI.
   set_bpk_parameter(l_nd, 'BUS_MOD', '13');
   set_bpk_parameter(l_nd, 'SPPI', 'Так');
   set_bpk_parameter(l_nd, 'IFRS', 'AC');
  
  -- ідентифікатор і штрих-код кобренду
  if p_cobrandid is not null and p_barcode is not null then
/*     if not regexp_like(p_cobrandid, '^[A-Z]{4}[A-Z0-9]{7}+$') then
        raise_application_error(-20000, 'Ідетнифікатор ко-бренду не відповідає шаблону: [A-Z]{4}[A-Z0-9]{7}');
     end if;*/
     if length(trim(p_cobrandid)) > 12 then
        raise_application_error(-20000, 'Ідетнифікатор ко-бренду більше 12 символів');
     end if;
     if length(trim(p_barcode)) > 15 then
        raise_application_error(-20000, 'Штрих-код більше 15 символів');
     end if;
     set_bpk_parameter(l_nd, 'COBRANDID', trim(p_cobrandid));
     set_bpk_parameter(l_nd, 'BARCOD', trim(p_barcode));
  end if;
  -- параметр NKD
  accreg.setAccountSParam(l_acc, 'NKD', 'БПК_' || l_nd);

  -- параметр OB22
  if l_product.ob22 is not null then
     accreg.setAccountSParam(l_acc, 'OB22', l_product.ob22);
  end if;

  l_trmask.a_w4_acc := 'ACC_PK';
  l_trmask.nbs := substr(account_utl.read_account(l_acc).nls,1,4);
  
  -- specparams:
  set_sparam('1', l_acc, l_trmask);

  -- rate
  if l_product.rate is not null then
     set_acc_rate('PK', l_acc, l_product.rate);
  end if;

  -- accountsw
  -- физ. лицо / Корпоративная карта сотрудников ОБУ
  if l_product.custtype = 1 or l_product.nbs like '355%' then
     if p_embfirstname is not null then
        accreg.setAccountwParam(l_acc, 'W4_EFN',  p_embfirstname);
     end if;
     if p_emblastname is not null then
        accreg.setAccountwParam(l_acc, 'W4_ELN',  p_emblastname);
     end if;
  -- юр. лицо / физ. лицо-предприниматель
  else
     if p_embfirstname is not null then
        accreg.setAccountwParam(l_acc, 'W4_ECN',  p_embfirstname);
     end if;
     if p_emblastname is not null then
        accreg.setAccountwParam(l_acc, 'W4_CPN',  p_emblastname);
     end if;
  end if;
  if p_secname is not null then
     accreg.setAccountwParam(l_acc, 'W4_SEC',  p_secname);
  end if;
  if p_work is not null then
     accreg.setAccountwParam(l_acc, 'PK_WORK', p_work);
  end if;
  if p_office is not null then
     accreg.setAccountwParam(l_acc, 'PK_OFFIC', p_office);
  end if;
  if p_wdate is not null then
     accreg.setAccountwParam(l_acc, 'PK_ODAT', to_char(p_wdate,'dd.MM.yyyy'));
  end if;
  -- p_salaryproect=-1 = власна картка (без З/П проекта)
  if l_iscrm=1 and p_salaryproect is not null and p_salaryproect <> -1 then
     begin
       select id
         into l_salaryproect
         from bpk_proect
        where id_cm = p_salaryproect and used_w4 = 1;
     exception
       when no_data_found then
         l_salaryproect := p_salaryproect;
     end;
     accreg.setAccountwParam(l_acc, 'PK_PRCT', l_salaryproect);
  elsif p_salaryproect is not null and p_salaryproect <> -1 then
     accreg.setAccountwParam(l_acc, 'PK_PRCT', p_salaryproect);
  end if;
  if l_term is not null then
     accreg.setAccountwParam(l_acc, 'PK_TERM', l_term);
  end if;
  if p_branchissue is not null then
     accreg.setAccountwParam(l_acc, 'PK_IBB', p_branchissue);
  end if;

  l_sendsms := case when p_sendsms = 1 or p_sendsms is null then 'Y' else 'N' END ;
  accreg.setAccountwParam(l_acc, 'W4SMS', l_sendsms);

  p_nd := l_nd;


  -- внесение данных в очередь для обработки в CardMake
    ---for subcard from w4_card_add (6327)
  begin
   select count('x') into l_add_card
   from w4_card_add a where a.card_code_add=p_cardcode;
  exception
   when no_data_found then
     null;
  end;
 ---

  add_deal_to_cmque(
     p_nd         => l_nd,
     p_opertype   => l_opertype,
     p_wait_confirm => case
                         when l_ctype = 2 then 1
                         when l_add_card >0 then 1  --якщо карта, що створюється є додатковою з w4_card_add (6327)
                        else null
                       end,

     p_cmclient   => l_cmclient);
  if l_ctype = 2 then
    update w4_acc_instant t
       set t.reqid = l_cmclient.id
     where t.acc = l_acc;
  end if;

  p_reqid := l_cmclient.id;

   -- Присоединение договора к ДКБО
  begin
    pkg_dkbo_utl.p_acc_map_to_dkbo(in_customer_id => l_customer.rnk,
                                   in_acc_list => number_list(l_acc),
                                   out_deal_id    => l_dkbo_deal);
    bars_audit.info(h || 'add_deal_to_dkbo.ND=' || l_nd || ' DKBO DEAL=' ||
                    l_dkbo_deal);
  exception
    when others then
      null;
  end;

  -- отправляем запрос на W4 по персонализации карты (без нерезидентов COBUMMFO-7787_2)
  if l_opertype = 6 and l_iscrm = '0' and l_cmclient.resident=1 then

     l_pers_err := pers_instant_card(l_nd, l_cmclient);
     if l_pers_err = 'OK' then
        update cm_client_que
  set add_info = replace(add_info, '<SEND_INSTANT>Y</SEND_INSTANT>', '<SEND_INSTANT>N</SEND_INSTANT>')
         where id = l_cmclient.id;
     else
		 raise_application_error(-20000, 'Помилка при персоналізації Instant карти: '||substr(l_pers_err,1,100));
/*       delete from cm_client_que where id = l_cmclient.id; */
     end if;
  end if;
  bars_audit.info(h || 'Finish.');

end open_card;

-------------------------------------------------------------------------------
-- cng_card
-- процедура изменения типа карточки
--
procedure cng_card ( p_nd number, p_card varchar2 )
is
  l_tip        varchar2(3);
  l_rnk        number;
  l_clienttype number;
  l_nbs        varchar2(4);
  l_opertype   number;
  h varchar2(100) := 'bars_ow.cng_card. ';
begin

  bars_audit.info(h || 'Start. p_nd=>' || p_nd || ' p_card=>' || p_card);

  begin
    select a.nbs, a.tip, a.rnk, g.client_type
      into l_nbs, l_tip, l_rnk, l_clienttype
      from w4_acc w, accounts a, w4_card c, w4_product p, w4_product_groups g
     where w.nd = p_nd
       and w.acc_pk = a.acc
       and w.card_code = c.code
       and c.product_code = p.code
       and p.grp_code = g.code;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_nd));
  end;

  update w4_acc set card_code = p_card where nd = p_nd;

  -- определяем opertype
  l_opertype := iget_cm_opertype(l_rnk, l_clienttype, l_nbs, l_tip);

  add_deal_to_cmque (
     p_nd        => p_nd,
     p_opertype  => l_opertype );

  bars_audit.info(h || 'Finish.');

end cng_card;

-------------------------------------------------------------------------------
-- form_request
-- процедура переформирования запроса в CardMake
--
procedure form_request (p_id number, p_opertype number)
is
  l_cmclient cm_client_que%rowtype;
  l_nd       number;
  l_id       number;
  l_opertype number;
  h varchar2(100) := 'bars_ow.form_request. ';
begin

  bars_audit.info(h || 'Start. p_id=>' || to_char(p_id) || ' p_opertype=>' || to_char(p_opertype));

  -- поиск заявки
  begin
     select * into l_cmclient
       from cm_client_que
      where id = p_id;
  exception when no_data_found then
--     bars_audit.info(h || 'Запит ' || to_char(p_id) || ' не знайдено');
--     bars_error.raise_nerror(g_modcode, 'REQUEST_NOT_FOUND', to_char(p_id));
    -- убрали ошибку из-за глюка в веб: при нажатии на кнопку процедура вызывается 2 раза
    return;
  end;
  bars_audit.trace(h || 'oper_status=>' || to_char(l_cmclient.oper_status) || ' rnk=>' || to_char(l_cmclient.rnk) || ' acc=>' || to_char(l_cmclient.acc));

  -- удалять/переформировывать можно только заявки со статусом 1-новый запрос или 10-ошибка обработки
  if l_cmclient.oper_status not in (1, 10) then
     -- удаление
     if p_opertype = -1 then
        bars_audit.info(h || 'Запит ' || to_char(p_id) || ' зі статусом ' || to_char(l_cmclient.oper_status) || ': видалення неможливе');
        bars_error.raise_nerror(g_modcode, 'REQUEST_DELETE_IMPOSSIBLE', to_char(p_id), to_char(l_cmclient.oper_status));
     -- переформирование
     else
        bars_audit.info(h || 'Запит ' || to_char(p_id) || ' зі статусом ' || to_char(l_cmclient.oper_status) || ': переформування неможливе');
        bars_error.raise_nerror(g_modcode, 'REQUEST_REFORM_IMPOSSIBLE', to_char(p_id), to_char(l_cmclient.oper_status));
     end if;
  end if;

  -- переформирование (p_opertype=-1 - удаление)
  if nvl(p_opertype,0) >= 0 then

     -- Заборонити по рахунку Instant переформування заявки на заявку іншого типу, якщо первинна заявка типа = 6
     if l_cmclient.oper_type = 6 and nvl(p_opertype,0) > 0 then
        bars_audit.info(h || 'Запит ' || to_char(p_id) || ' по рахунку Instant: формування запиту іншого типу неможливе');
        bars_error.raise_nerror(g_modcode, 'REQUEST_INSTREFORM_IMPOSSIBLE', to_char(p_id));
     end if;

     -- поиск договора БПК
     begin
        select nd into l_nd from w4_acc where acc_pk = l_cmclient.acc;
     exception when no_data_found then
        -- не нашли договор, поиск карты Instant
        begin
           select null into l_nd from w4_acc_instant where acc = l_cmclient.acc;
        exception when no_data_found then
           -- Счет ACC=p_pk_acc не найден в портфеле БПК-Way4
           bars_audit.info(h || 'Счет ACC=' || to_char(l_cmclient.acc) || ' не найден в портфеле БПК-Way4');
           bars_error.raise_nerror(g_modcode, 'W4ACC_NOT_FOUND', to_char(l_cmclient.acc));
        end;
     end;
     bars_audit.trace(h || 'l_nd=>' || to_char(l_nd));

     -- проверка: по этому клиенту/карте была заявка позже нашей?
     select max(id) into l_id
       from ( select id from cm_client_que
               where rnk = l_cmclient.rnk
                 and acc = l_cmclient.acc
                 and oper_status <> 10
               union
              select id from cm_client_que_arc
               where rnk = l_cmclient.rnk
                 and acc = l_cmclient.acc
                 and oper_status <> 10 );
     if p_id < l_id then
        bars_audit.info(h || 'На запит ' || to_char(p_id) || ' вже відправлено виправний запит' || to_char(l_id));
        bars_error.raise_nerror(g_modcode, 'REQUEST_YET_FORM', to_char(p_id), to_char(l_id));
     end if;

     -- Повторное формирование заявки
     if p_opertype is null then
        l_opertype := l_cmclient.oper_type;
     -- Новая заявка
     else
        l_opertype := p_opertype;
     end if;

     -- запрос по обычной карте
     if l_nd is not null then
        if l_opertype = 2 and l_cmclient.kk_flag = 2 then
           add_deal_to_cmque(
              p_nd         => l_nd,
              p_opertype   => l_opertype,
              p_ad_rnk => l_cmclient.rnk,
              p_card_type => l_cmclient.card_type,
              p_cntm => l_cmclient.cntm);
        else
        add_deal_to_cmque(
           p_nd         => l_nd,
           p_opertype   => l_opertype );
        end if;
        -- при переформировании заявки по КК берем
        if l_opertype = 2 and l_cmclient.kk_flag = 1 then
           update cm_client_que
              set card_type = replace(replace(case substr(l_cmclient.card_type,
                                                      -4)
                                                when '_DOP' then
                                                 l_cmclient.card_type
                                                else
                                                 l_cmclient.card_type ||
                                                 '_DOP'
                                              end,
                                              'VCUKK_0',
                                              'VCUKK'),
                                      'MDUKK_0',
                                      'MDUKK')
            where acc = (select acc_pk from w4_acc where nd = l_nd) and
                  oper_type = 2 and oper_status = 1;
        end if;

        if l_cmclient.card_br_iss is not null then
            -- Параметри <DOCUMENT_SERIA> + <DOCUMENT_NUM> передавати в Кардмейк в поле "Номер відділення, де буде видаватися картка"
           update cm_client_que
              set card_br_iss = l_cmclient.card_br_iss
            where acc = l_cmclient.acc
              and oper_status = 1;
        end if;
     -- запрос по карте Instant
     else
        select bars_sqnc.get_nextval('S_CMCLIENT') into l_cmclient.id from dual;
        l_cmclient.datein      := sysdate;
        l_cmclient.datemod     := null;
        l_cmclient.oper_type   := l_opertype;
        l_cmclient.oper_status := 1;
        l_cmclient.resp_txt    := null;
        insert into cm_client_que values l_cmclient;
     end if;

  -- удаление (p_opertype=-1)
  else

     -- Заборонити по рахунку Instant вилучення заявки типа = 6
     if l_cmclient.oper_type = 6 then
        bars_audit.info(h || 'Запит ' || to_char(p_id) || ' по рахунку Instant: видалення неможливе');
        bars_error.raise_nerror(g_modcode, 'REQUEST_INSTDELETE_IMPOSSIBLE', to_char(p_id));
     end if;

  end if;

  delete from cm_client_que where id = p_id;

  bars_audit.info(h || 'Finish.');

end form_request;

-------------------------------------------------------------------------------
-- w4_import_files
-- процедура импорта файлов от Way4
--
procedure w4_import_files (
  p_filename     varchar2,
  p_filebody     blob,
  p_msg      out varchar2,
  p_docs     out nocopy clob )
is
  l_id  number := null;
  l_msg varchar2(2000) := null;
  h varchar2(100) := 'bars_ow.w4_import_files. ';
begin

  bars_audit.info(h || 'Start.');

  load_file(
     p_filename => p_filename,
     p_filebody => p_filebody,
     p_origin   => 1,
     p_id       => l_id,
     p_msg      => l_msg );

  p_msg  := l_msg;
  p_docs := null;

  bars_audit.info(h || 'Finish.' || 'p_msg=>' || p_msg);

end w4_import_files;

-------------------------------------------------------------------------------
-- w4_form_files
-- процедура формирования файлов для Way4 - для вертушки
--
procedure w4_form_files (
  p_filename out varchar2,
  p_filebody out nocopy clob )
is
  l_filename varchar2(100) := null;
  l_clob     clob;
  h varchar2(100) := 'bars_ow.w4_form_files. ';
begin

  bars_audit.info(h || 'Start.');

  for z in ( select file_type from ow_file_type where io = 'O' order by priority )
  loop

     -- формирование файла IIC
     if l_filename is null and z.file_type = 'IIC_DOCUMENTS' then
        get_iicfilebody (0, l_filename, l_clob);
     end if;
/*
     -- формирование файла XADVAPL
     -- Настроен маршрут создания НК через Way4
     if l_filename is null and z.file_type = 'XADVAPL' and g_w4_lc = 0 then
        for x in ( select id from ow_crv_request order by id )
        loop
           bars_owcrv.get_xafilebody(x.id, l_filename, l_clob);
           if l_filename is not null then
              exit;
           end if;
        end loop;
     end if;
*/
     if l_filename is not null then
        exit;
     end if;
  end loop;

  p_filename := l_filename;
  p_filebody := l_clob;

  bars_audit.info(h || 'Finish. length=>' || dbms_lob.getlength(p_filebody));

end w4_form_files;

-------------------------------------------------------------------------------
-- icheck_project
-- процедура проверки корректности данных для открытия карт
--
procedure icheck_project (
  p_project in out ow_salary_data%rowtype,
  p_flag_kk in     number default 0)
is
  l_msg        varchar2(254) := null;
  procedure append_msg ( p_txt varchar2 )
  is
  begin
     if l_msg is not null then
        l_msg := substr(l_msg || ';' || p_txt, 1, 254);
     else
        l_msg := substr(p_txt, 1, 254);
     end if;
  end;
begin

  p_project.str_err := null;

  if p_project.eng_first_name is null then
     p_project.eng_first_name := substr(f_translate_kmu(p_project.first_name),1,30);
  else
     p_project.eng_first_name := upper(p_project.eng_first_name);
  end if;
  if p_project.eng_last_name is null then
     p_project.eng_last_name := substr(f_translate_kmu(p_project.last_name),1,30);
  else
     p_project.eng_last_name := upper(p_project.eng_last_name);
  end if;
  if p_project.paspseries is not null then
     p_project.paspseries := kl.recode_passport_serial(p_project.paspseries);
  end if;

  if p_project.okpo is null
  or p_project.first_name is null
  or p_project.last_name is null
  or p_project.type_doc is null
  or (p_project.paspseries is null and nvl(p_project.type_doc,0) = 1)
  or p_project.paspnum is null
  or p_project.paspissuer is null
  or p_project.paspdate is null
  or p_project.bday is null
  or p_project.country is null
  or p_project.resident is null
  or p_project.gender is null
  or p_project.mname is null
  or p_project.addr1_cityname is null
  or p_project.addr1_street is null
  or p_project.okpo_w is null then

     append_msg('Не заповнено обов''язкові поля');
  end if;
  if length(trim(p_project.eng_first_name||' '||p_project.eng_last_name)) > 24 then
     append_msg('Кількість знаків Прізвище та І''мя для ембосування перевищує 24 символи');
  end if;

  if not check_eng(p_project.eng_first_name) then
     append_msg('Ім''я що ембосується - недопустимі символи');
  end if;
  if not check_eng(p_project.eng_last_name) then
     append_msg('Прізвище що ембосується - недопустимі символи');
  end if;
  if months_between(bankdate,p_project.bday)/12 < 14 then
     append_msg('Клієнту менше 14 років');
  end if;
  if p_project.addr1_pcode is not null and length(p_project.addr1_pcode) <> 5 then
     append_msg('Довжина поля Індекс повинна бути 5 знаків');
  end if;
  if p_project.addr2_pcode is not null and length(p_project.addr2_pcode) <> 5 then
     append_msg('Довжина поля Індекс повинна бути 5 знаків');
  end if;
  if p_project.paspdate >= sysdate then
     append_msg('Дата видачі паспорту повинна бути менше поточної дати');
  end if;
  if p_project.paspdate < p_project.bday then
     append_msg('Дата видачі паспорту повинна бути більше дати народження');
  end if;
  if instr(p_project.paspseries,' ') > 0 then
     append_msg('Серія паспорту містить пробіли');
  end if;
  if nvl(p_project.type_doc,0) = 1 and
     (p_project.paspseries <> upper(p_project.paspseries) or length(p_project.paspseries) <> 2) then
     append_msg('Невірно заповнено серію паспорту');
  end if;
  if (nvl(p_project.type_doc,0) = 1 and
     (not check_digit(p_project.paspnum) or length(p_project.paspnum) <> 6)) or
     (nvl(p_project.type_doc,0) = 7 and
     (not check_digit(p_project.paspnum) or length(p_project.paspnum) <> 9)) then
     append_msg('Невірно заповнено номер паспорту');
  end if;
  if p_project.email is not null and not check_email(upper(p_project.email)) then
     append_msg('Невірний e-mail');
  end if;
  if p_project.phone_home is not null then
     if length(p_project.phone_home) <> 13 then
        append_msg('Довжина номеру телефону повинна дорівнювати 13 символів');
     elsif substr(p_project.phone_home, 1, 3) <> '+38' then
        append_msg('Номер телефону повинен починатись з +38');
     elsif not check_digit(substr(p_project.phone_home, 2)) then
        append_msg('Нецифри в номері телефону');
     end if;
  end if;
  if p_project.phone_mob is not null then
     if length(p_project.phone_mob) <> 13 then
        append_msg('Довжина номеру телефону повинна дорівнювати 13 символів');
     elsif substr(p_project.phone_mob, 1, 3) <> '+38' then
        append_msg('Номер телефону повинен починатись з +38');
     elsif not check_digit(substr(p_project.phone_mob, 2)) then
        append_msg('Нецифри в номері телефону');
     end if;
  end if;
  if not check_fio(upper(p_project.first_name)) then
     append_msg('Ім''я повинно містити тільки українські/російські літери');
  end if;
  if not check_fio(upper(p_project.last_name)) then
     append_msg('Прізвище повинно містити тільки українські/російські літери');
  end if;
  if p_project.middle_name is not null and not check_fio(upper(p_project.middle_name)) then
     append_msg('По-батькові повинно містити тільки українські/російські літери');
  end if;
  if p_flag_kk = 1 then
     if p_project.kk_secret_word is null
     or p_project.kk_regtype is null
     or p_project.kk_cityareaid is null
     or p_project.kk_streettypeid is null
     or p_project.kk_streetname is null
     or p_project.kk_apartment is null
     or p_project.kk_postcode is null then
        append_msg('Не заповнено обов''язкові поля КК');
     end if;
     if p_project.kk_streetname is not null and not check_permitted_char(p_project.kk_streetname, g_w4_fio_char || lower(g_w4_fio_char) || g_digit || '/-., ') then
        append_msg('Назва вулиці для КК повинна містити тільки українські/російські літери');
     end if;
  end if;
  p_project.str_err := l_msg;

end icheck_project;

-------------------------------------------------------------------------------
-- iparse_salary_file
-- процедура разбора файла зарплатных проектов
--
procedure iparse_salary_file (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_id       out number,
  p_flag_kk   in number default 0 )
is

  l_id      number;
  l_project ow_salary_data%rowtype;

  i number;
  l_tmp varchar2(2000);

  h varchar2(100) := 'bars_ow.iparse_salary_file. ';

  function check_phone (p_phone varchar2) return varchar2
  is
    l_ret varchar2(100) := null;
  begin
    if p_phone is not null then
       for j in 1..length(p_phone)
       loop
          if substr(p_phone,j,1) in ('+','0','1','2','3','4','5','6','7','8','9') then
             l_ret := l_ret || substr(p_phone,j,1);
          end if;
       end loop;
       l_ret := substr(l_ret,1,13);
    end if;
    return l_ret;
  end check_phone;

  function check_pcode (p_pcode varchar2) return varchar2
  is
    l_ret varchar2(100) := null;
  begin
    l_ret := substr(trim(p_pcode),1,10);
    if l_ret is not null then
       if length(l_ret) < 5 then
          l_ret := substr('0000'||l_ret,-5);
       end if;
    end if;
    return l_ret;
  end check_pcode;

begin

  bars_audit.info(h || 'Start.');

  select bars_sqnc.get_nextval('S_OWFILES') into l_id from dual;

  insert into ow_salary_files (id, file_name)
  values (l_id, upper(p_filename));

  i := 0;

  loop

     -- счетчик карт
     i := i + 1;

     -- выход при отсутствии карт
     if p_xml.existsnode('/ROWSET/ROW['||i||']') = 0 then
        exit;
     end if;

     l_project.okpo           := extract(p_xml, '/ROWSET/ROW['||i||']/OKPO/text()', null);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/FIRST_NAME/text()', null);
     l_project.first_name     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/LAST_NAME/text()', null);
     l_project.last_name      := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/MIDDLE_NAME/text()', null);
     l_project.middle_name    := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);
     l_project.type_doc       := extract(p_xml, '/ROWSET/ROW['||i||']/TYPE_DOC/text()', null);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PASPSERIES/text()', null);
     l_project.paspseries     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,16);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PASPNUM/text()', null);
     l_project.paspnum        := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,16);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PASPISSUER/text()', null);
     l_project.paspissuer     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,128);
     l_project.paspdate       := to_date(extract(p_xml, '/ROWSET/ROW['||i||']/PASPDATE/text()', null),'dd/mm/yyyy');
     l_project.bday           := to_date(extract(p_xml, '/ROWSET/ROW['||i||']/BDAY/text()', null),'dd/mm/yyyy');
     l_project.country        := extract(p_xml, '/ROWSET/ROW['||i||']/COUNTRY/text()', null);
     l_project.resident       := extract(p_xml, '/ROWSET/ROW['||i||']/RESIDENT/text()', null);
     l_project.gender         := extract(p_xml, '/ROWSET/ROW['||i||']/GENDER/text()', null);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PHONE_HOME/text()', null);
     l_project.phone_home     := check_phone(l_tmp);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PHONE_MOB/text()', null);
     l_project.phone_mob      := check_phone(l_tmp);
     l_project.email          := extract(p_xml, '/ROWSET/ROW['||i||']/EMAIL/text()', null);
     l_project.eng_first_name := extract(p_xml, '/ROWSET/ROW['||i||']/ENG_FIRST_NAME/text()', null);
     l_project.eng_last_name  := extract(p_xml, '/ROWSET/ROW['||i||']/ENG_LAST_NAME/text()', null);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/MNAME/text()', null);
     l_project.mname          := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,20);
  --address
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_CITY_TYPE/text()', null);
     l_project.addr1_city_type:= substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_CITYNAME/text()', null);
     l_project.addr1_cityname := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_PCODE/text()', null);
     l_project.addr1_pcode    := check_pcode(l_tmp);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_DOMAIN/text()', null);
     l_project.addr1_domain   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,48);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_REGION/text()', null);
     l_project.addr1_region   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,48);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_STREET/text()', null);
     l_project.addr1_street   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_STREET_TYPE/text()', null);
     l_project.addr1_streettype := convert_to_number(trim(dbms_xmlgen.convert(l_tmp,1)));

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_STREET/text()', null);
     l_project.addr1_streetname  := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_HOUSE/text()', null);
     l_project.addr1_bud      := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,50);

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR1_FLAT/text()', null);
     l_project.addr1_flat     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,50);

     if l_project.addr1_bud is not null then
        l_project.addr1_street := l_project.addr1_street || ', ' || l_project.addr1_bud ||', '||l_project.addr1_flat;
     end if;
  -----------
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_CITYNAME/text()', null);
     l_project.addr2_cityname := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_CITY_TYPE/text()', null);
     l_project.addr2_city_type:= substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_PCODE/text()', null);
     l_project.addr2_pcode    := check_pcode(l_tmp);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_DOMAIN/text()', null);
     l_project.addr2_domain   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,48);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_REGION/text()', null);
     l_project.addr2_region   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,48);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_STREET/text()', null);
     l_project.addr2_street   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_STREET/text()', null);
     l_project.addr2_streetname  := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_STREET_TYPE/text()', null);
     l_project.addr2_streettype := convert_to_number(trim(dbms_xmlgen.convert(l_tmp,1)));
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_HOUSE/text()', null);
     l_project.addr2_bud      := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,50);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_FLAT/text()', null);
     l_project.addr2_flat     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,50);

     if l_project.addr2_bud is not null then
        l_project.addr2_street := l_project.addr2_street || ', ' || l_project.addr2_bud ||', '||l_project.addr2_flat;
     end if;
  ---------------
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/WORK/text()', null);
     l_project.work           := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,254);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/OFFICE/text()', null);
     l_project.office         := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,32);
     l_project.date_w         := to_date(extract(p_xml, '/ROWSET/ROW['||i||']/DATE_W/text()', null),'dd/mm/yyyy');
     l_project.okpo_w         := extract(p_xml, '/ROWSET/ROW['||i||']/OKPO_W/text()', null);
     l_project.pers_cat       := extract(p_xml, '/ROWSET/ROW['||i||']/PERS_CAT/text()', null);
     l_project.aver_sum       := convert_to_number(extract(p_xml, '/ROWSET/ROW['||i||']/AVER_SUM/text()', null));
     l_project.tabn           := extract(p_xml, '/ROWSET/ROW['||i||']/TABN/text()', null);
     l_project.max_term       := convert_to_number(extract(p_xml, '/ROWSET/ROW['||i||']/MAX_TERM/text()', null));
     if p_flag_kk = 1 then
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/SECRET_WORD/text()', null);
     l_project.kk_secret_word := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,32);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/REG_CLIENT_TYPE/text()', null);
     l_project.kk_regtype     := convert_to_number(trim(dbms_xmlgen.convert(l_tmp,1)));
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR3_CITYREGION/text()', null);
     l_project.kk_cityareaid  := convert_to_number(trim(dbms_xmlgen.convert(l_tmp,1)));
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR3_STREETTYPE/text()', null);
     l_project.kk_streettypeid:= convert_to_number(trim(dbms_xmlgen.convert(l_tmp,1)));
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR3_STREETNAME/text()', null);
     l_project.kk_streetname  := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,64);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR3_BUD/text()', null);
     l_project.kk_apartment   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,32);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR3_PCODE/text()', null);
     l_project.kk_postcode    := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,5);
     end if;
     l_project.kk_photo_data  := empty_blob();

     icheck_project(l_project, p_flag_kk);

     if l_project.str_err is null and
        l_project.okpo is not null and
        l_project.okpo <> '000000000' and
        l_project.okpo <> '0000000000' then
        l_project.rnk := found_client(l_project.okpo, l_project.paspseries, l_project.paspnum);
    --Проверка на терористов і публічних діячів
    if l_project.rnk is not null and finmon_is_public(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name,null)<>0 then
        l_project.str_err:= substr('Публічний діяч, клієнт', 1, 254);
        l_project.flag_open:=2;
        elsif l_project.rnk is null and finmon_is_public(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name,null)<>0 then
        l_project.str_err:= substr('Публічний діяч, не клієнт', 1, 254);
        l_project.flag_open:=null;
    end if;
        if l_project.str_err is null and f_istr(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name)<>0 then
        l_project.str_err:= substr('Увага! Виявлено збіг з переліком осіб, пов''язаних із здійсненням терористичної діяльності або стосовно яких застосовано міжнародні санкції. Зверніться до підрозділу фінансового моніторингу!', 1, 254);
        l_project.flag_open:=2;
    elsif l_project.str_err is not null and f_istr(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name)<>0 then
    l_project.str_err:= substr(l_project.str_err || '; Увага! Виявлено збіг з переліком осіб, пов''язаних із здійсненням терористичної діяльності або стосовно яких застосовано міжнародні санкції. Зверніться до підрозділу фінансового моніторингу!', 1, 254);
        l_project.flag_open:=2;
        else
        l_project.flag_open:=null;
        end if;
    ------
     else
        l_project.rnk := null;
    l_project.flag_open:=null;
    --Проверка на терористов і публічних діячів
        if l_project.str_err is not null and finmon_is_public(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name,null)<>0 then
        l_project.str_err:= substr(l_project.str_err || ';Публічний діяч', 1, 254);
    elsif l_project.str_err is null and finmon_is_public(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name,null)<>0 then
    l_project.str_err:= substr('Публічний діяч', 1, 254);
        end if;
        if l_project.str_err is not null and f_istr(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name)<>0 then
        l_project.str_err:= substr(l_project.str_err || ';Терорист', 1, 254);
    elsif l_project.str_err is null and f_istr(l_project.last_name||' '||l_project.first_name||' '||l_project.middle_name)<>0 then
    l_project.str_err:= substr('Терорист', 1, 254);
        end if;
    ------
     end if;
     l_project.nd  := null;
     l_project.id  := l_id;
     l_project.idn := i;
     l_project.kf  := sys_context('bars_context','user_mfo');
     -- вставка в таблицу
     insert into ow_salary_data values l_project;

  end loop;

  bars_audit.info(h || to_char(i) || ' rows parsed.');

  update ow_salary_files set file_n = i - 1 where id = l_id;

  p_id := l_id;

  bars_audit.info(h || 'p_id=>' || to_char(p_id));
  bars_audit.info(h || 'Finish.');

exception when others then
   if ( sqlcode = -19202 or sqlcode = -31011 ) then
      p_id := -1;
      bars_audit.info(h || 'p_id=>' || to_char(p_id));
   else
      raise_application_error(-20000,
         dbms_utility.format_error_stack() || chr(10) ||
         dbms_utility.format_error_backtrace());
   end if;
end iparse_salary_file;

-------------------------------------------------------------------------------
-- w4_import_salary_file
-- процедура импорта файла зарплатных проектов
--
procedure w4_import_salary_file (
  p_filename  in varchar2,
  p_filebody  in clob,
  p_fileid   out number,
  p_flag_kk   in number default 0 )
is
  l_clob     clob;
  l_xml_full xmltype;
  l_id       number;
  h varchar2(100) := 'bars_ow.w4_import_salary_file. ';
begin

  bars_audit.info(h || 'Start.');

  delete from ow_salary_data where id in ( select id from ow_salary_files where trunc(file_date) < trunc(sysdate)-30);

  l_clob := p_filebody;

  l_xml_full := xmltype(l_clob);

  iparse_salary_file(p_filename, l_xml_full, l_id, p_flag_kk);

  p_fileid := l_id;

  bars_audit.info(h || 'p_fileid=>' || to_char(p_fileid));
  bars_audit.info(h || 'Finish.');

end w4_import_salary_file;

-------------------------------------------------------------------------------
-- import_salary_file
-- процедура импорта файла зарплатных проектов
--
procedure import_salary_file (
  p_filename in     varchar2,
  p_fileid   in out number )
is
  l_clob     clob;
  l_xml_full xmltype;
  l_id       number;
  h varchar2(100) := 'bars_ow.import_salary_file. ';
begin

  bars_audit.info(h || 'Start.');

  delete from ow_salary_data where id in ( select id from ow_salary_files where trunc(file_date) < trunc(sysdate)-30 );

  select file_data into l_clob from ow_impfile where id = p_fileid;

  l_xml_full := xmltype(l_clob);

  iparse_salary_file(p_filename, l_xml_full, l_id);

  p_fileid := l_id;

  bars_audit.info(h || 'p_fileid=>' || to_char(p_fileid));
  bars_audit.info(h || 'Finish.');

exception when no_data_found then
  raise_application_error(-20000,
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());
end import_salary_file;

-------------------------------------------------------------------------------
-- form_salary_ticket
--
procedure form_salary_ticket_ex(
  p_fileid     in out number,
  p_ticketname    out varchar2 )
is
  l_count     number  := 0;
  l_data      xmltype := null;
  l_xml_tmp   xmltype := null;
  l_clob_data clob;
    p_result clob;
    l_domdoc        dbms_xmldom.domdocument;
    l_root_node     dbms_xmldom.domnode;
    l_rows_node     dbms_xmldom.domnode;
    l_row_node      dbms_xmldom.domnode;
    l_customer_node dbms_xmldom.domnode;
    l_deals_node    dbms_xmldom.domnode;
    l_deal_node     dbms_xmldom.domnode;
    l_node          dbms_xmldom.DOMNode;
  h varchar2(100) := 'bars_ow.form_salary_ticket_ex.';
begin
   bars_audit.info(h || 'Start.');

  begin
     select 'R_' || file_name into p_ticketname from ow_salary_files where id = p_fileid;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;
    l_domDoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domDoc);
    l_rows_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'ROWS')));

 for v in ( select  p.okpo, p.first_name, p.last_name, p.middle_name, p.paspseries,
                    p.paspnum, to_char(p.bday,'dd/mm/yyyy') bday, p.tabn,  p.str_err,p.rnk
               from ow_salary_data p  where p.id = p_fileid
          )
  loop
    l_count := l_count + 1;
    l_row_node  := dbms_xmldom.appendchild(l_rows_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'ROW')));

      l_customer_node := dbms_xmldom.appendChild(l_row_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'CUSTOMER')));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'OKPO')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.okpo )));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'FIRST_NAME')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.first_name )));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'LAST_NAME')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.last_name )));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'MIDDLE_NAME')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.middle_name )));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'PASPSERIES')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.paspseries )));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement( l_domdoc, 'PASPNUM')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.paspnum )));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'BDAY')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,  v.bday)));

        l_node := dbms_xmldom.appendChild(l_customer_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'TABN')));
        l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.tabn  )));

        l_deals_node := dbms_xmldom.appendChild(l_row_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'DEALS')));

        if v.str_err is null then
          for d in ( select q.*  from cm_client_que q
                       where q.rnk =v.rnk
                   )
          loop
            l_deal_node := dbms_xmldom.appendChild(l_deals_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'DEAL')));
                l_node := dbms_xmldom.appendChild(l_deal_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc,'ND')));
                l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,d.id)));

                l_node := dbms_xmldom.appendChild(l_deal_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'DD')));
                l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,to_char(d.datein,'dd.mm.yyyy'))));

                l_node := dbms_xmldom.appendChild(l_deal_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'ACC')));
                l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,d.contractnumber )));

                l_node := dbms_xmldom.appendChild(l_deal_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'CARD_TYPE')));
                l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,d.card_type )));
          end loop;
          l_node := dbms_xmldom.appendChild(l_row_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'ERR')));
          l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,'No errors' )));
        else
          l_node := dbms_xmldom.appendChild(l_row_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'ERR')));
          l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc,v.str_err )));
        end if;
  end loop;
---
    dbms_lob.createtemporary(p_result, true, 12);
    dbms_xmldom.writetoclob(l_domdoc, p_result);
   --отпускаем объекты ...
    dbms_xmldom.freeDocument(l_domdoc);


     if l_count > 0 then
      p_fileid := get_impid;
      insert into ow_impfile (id, file_data) values (p_fileid, p_result);
     else
      p_fileid := null;
      p_ticketname := null;
     end if;
  bars_audit.info(h || 'p_ticketname=>' || p_ticketname);
  bars_audit.info(h || 'Finish.');

end form_salary_ticket_ex;

-------------------------------------------------------------------------------
-- form_salary_ticket
--
procedure form_salary_ticket (
  p_fileid     in out number,
  p_ticketname    out varchar2 )
is
  l_count     number  := 0;
  l_data      xmltype := null;
  l_xml_tmp   xmltype := null;
  l_clob_data clob;
  h varchar2(100) := 'bars_ow.form_salary_ticket. ';
begin

  bars_audit.info(h || 'Start.');

  begin
     select 'R_' || file_name into p_ticketname from ow_salary_files where id = p_fileid;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  for v in ( select p.okpo, p.first_name,
                    p.last_name, p.middle_name, p.paspseries,
                    p.paspnum, to_char(p.bday,'dd/mm/yyyy') bday,
                    p.tabn, a.nls, p.str_err
               from ow_salary_data p, w4_acc w, accounts a
              where p.id = p_fileid and p.nd = w.nd(+) and w.acc_pk = a.acc(+) )
  loop

     l_count := l_count + 1;

     select
        XmlElement("ROW",
           XmlElement("OKPO", v.okpo),
           XmlElement("FIRST_NAME", v.first_name),
           XmlElement("LAST_NAME", v.last_name),
           XmlElement("MIDDLE_NAME", v.middle_name),
           XmlElement("PASPSERIES", v.paspseries),
           XmlElement("PASPNUM", v.paspnum),
           XmlElement("BDAY", v.bday),
           XmlElement("TABN", v.tabn),
           XmlElement("ACC", v.nls),
           XmlElement("ERR", v.str_err)
        )
     into l_xml_tmp
     from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

  end loop;

  if l_count > 0 then

     select XmlElement("ROWSET", l_data) into l_data from dual;

     dbms_lob.createtemporary(l_clob_data,FALSE);
     dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251"?>');
     dbms_lob.append(l_clob_data, l_data.getClobVal());

     p_fileid := get_impid;
     insert into ow_impfile (id, file_data) values (p_fileid, l_clob_data);

  else

     p_fileid := null;
     p_ticketname := null;

  end if;

  bars_audit.info(h || 'p_ticketname=>' || p_ticketname);
  bars_audit.info(h || 'Finish.');

end form_salary_ticket;

-------------------------------------------------------------------------------
-- create_customer
-- Процедура регистрации клиента по файлу
--
procedure create_customer (
  p_client in out ow_salary_data%rowtype,
  p_branch        varchar2 )
is
  l_rnk  number := null;
  l_nmk  varchar2(70);
  l_nmkv varchar2(70);
  l_nmkk varchar2(38);
  l_adr  varchar2(70);
  l_codcagent customer.codcagent%type;
  l_ise customer.ise%type;

begin

  -- LastName - фамилия, FirstName - имя
  l_nmk  := substr(trim(p_client.last_name || ' ' || p_client.first_name || ' ' || p_client.middle_name), 1, 70);
  l_nmkv := substr(f_translate_kmu(trim(l_nmk)),1,70);
  l_nmkk := substr(p_client.last_name || ' ' || p_client.first_name, 1, 38);

  select substr(trim(p_client.addr1_domain) ||
           nvl2(trim(p_client.addr1_region),   ' ' || trim(p_client.addr1_region), '') ||
           nvl2(trim(p_client.addr1_cityname), ' ' || trim(p_client.addr1_cityname), '') ||
           nvl2(trim(p_client.addr1_street),   ' ' || trim(p_client.addr1_street), ''), 1, 70)
    into l_adr from dual;

  if p_client.resident = '1' then
    l_codcagent := 5;
    l_ise := '14300';
  else
    l_codcagent := 6;
    l_ise := '00000';
  end if;
  kl.setCustomerAttr (
     Rnk_         => l_rnk,         -- Customer number
     Custtype_    => 3,             -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
     Nd_          => null,          -- № договора
     Nmk_         => l_nmk,         -- Наименование клиента
     Nmkv_        => l_nmkv,        -- Наименование клиента международное
     Nmkk_        => l_nmkk,        -- Наименование клиента краткое
     Adr_         => l_adr,                     -- Адрес клиента
     Codcagent_   => l_codcagent,               -- Характеристика
     Country_     => p_client.country,          -- Страна
     Prinsider_   => 99,                        -- Признак инсайдера
     Tgr_         => 2,                         -- Тип гос.реестра
     Okpo_        => trim(p_client.okpo),       -- ОКПО
     Stmt_        => 0,                         -- Формат выписки
     Sab_         => null,                      -- Эл.код
     DateOn_      => bankdate,                  -- Дата регистрации
     Taxf_        => null,                      -- Налоговый код
     CReg_        => -1,                        -- Код обл.НИ
     CDst_        => -1,                        -- Код район.НИ
     Adm_         => null,                      -- Админ.орган
     RgTax_       => null,                      -- Рег номер в НИ
     RgAdm_       => null,                      -- Рег номер в Адм.
     DateT_       => null,                      -- Дата рег в НИ
     DateA_       => null,                      -- Дата рег. в администрации
     Ise_         => l_ise,                     -- Инст. сек. экономики
     Fs_          => null,                      -- Форма собственности
     Oe_          => null,                      -- Отрасль экономики
     Ved_         => null,                      -- Вид эк. деятельности
     Sed_         => null,                      -- Форма хозяйствования
     Notes_       => null,                      -- Примечание
     Notesec_     => null,                      -- Примечание для службы безопасности
     CRisk_       => 1,                         -- Категория риска
     Pincode_     => null,                      --
     RnkP_        => null,                      -- Рег. номер холдинга
     Lim_         => null,                      -- Лимит кассы
     NomPDV_      => null,                      -- № в реестре плат. ПДВ
     MB_          => 9,                         -- Принадл. малому бизнесу
     BC_          => 0,                         -- Признак НЕклиента банка
     Tobo_        => p_branch,                  -- Код безбалансового отделения
     Isp_         => null                       -- Менеджер клиента (ответ. исполнитель)
  );

  kl.setCustomerEN (
     p_rnk    => l_rnk,
     p_k070   => nvl(getglobaloption('CUSTK070'), '00000'),  -- ise
     p_k080   => nvl(getglobaloption('CUSTK080'), '00'),     -- fs
     p_k110   => '00000',                                    -- ved
     p_k090   => '00000',                                    -- oe
     p_k050   => '000',                                      -- k050
     p_k051   => '00'                                        -- sed
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'FGIDX',
     Val_   => trim(p_client.addr1_pcode),
     Otd_   => 0
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'FGOBL',
     Val_   => trim(p_client.addr1_domain),
     Otd_   => 0
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'FGDST',
     Val_   => trim(p_client.addr1_region),
     Otd_   => 0
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'FGTWN',
     Val_   => trim(p_client.addr1_cityname),
     Otd_   => 0
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'FGADR',
     Val_   => trim(p_client.addr1_street),
     Otd_   => 0
  );

  kl.setCustomerAddressByTerritory (
     Rnk_           => l_rnk,
     TypeId_        => 1,
     Country_       => p_client.country,
     Zip_           => substr(trim(p_client.addr1_pcode),1,20),
     Domain_        => substr(trim(p_client.addr1_domain),1,30),
     Region_        => substr(trim(p_client.addr1_region),1,30),
     Locality_      => substr(trim(p_client.addr1_cityname),1,30),
     Address_       => substr(trim(p_client.addr1_street),1,100),
     TerritoryId_   => null
  );

  if p_client.addr2_pcode is not null
  or p_client.addr2_domain is not null
  or p_client.addr2_region is not null
  or p_client.addr2_cityname is not null
  or p_client.addr2_street is not null then
     kl.setCustomerAddressByTerritory (
        Rnk_           => l_rnk,
        TypeId_        => 2,
        Country_       => p_client.country,
        Zip_           => substr(trim(p_client.addr2_pcode),1,20),
        Domain_        => substr(trim(p_client.addr2_domain),1,30),
        Region_        => substr(trim(p_client.addr2_region),1,30),
        Locality_      => substr(trim(p_client.addr2_cityname),1,30),
        Address_       => substr(trim(p_client.addr2_street),1,100),
        TerritoryId_   => null
     );
  end if;

  kl.setPersonAttr (
     Rnk_      => l_rnk,
     Sex_      => p_client.gender,
     Passp_    => nvl(p_client.type_doc, 1),
     Ser_      => trim(p_client.paspseries),
     Numdoc_   => trim(p_client.paspnum),
     Pdate_    => trim(p_client.paspdate),
     Organ_    => substr(trim(p_client.paspissuer),1,70),
     Bday_     => p_client.bday,
     Bplace_   => null,
     Teld_     => p_client.phone_home,
     Telw_        => null,
     actual_date_ => p_client.pasp_end_date,
     eddr_id_     => p_client.pasp_eddrid_id
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'SN_FN',
     Val_   => p_client.first_name,
     Otd_   => 0
  );

  kl.setCustomerElement(
     Rnk_   => l_rnk,
     Tag_   => 'SN_LN',
     Val_   => p_client.last_name,
     Otd_   => 0
  );

  if p_client.middle_name is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'SN_MN',
        Val_   => p_client.middle_name,
        Otd_   => 0
     );
  end if;

  if p_client.phone_mob is not null then
     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'MPNO ',
        Val_   => p_client.phone_mob,
        Otd_   => 0
     );
  end if;

  kl.setCustomerElement(
    Rnk_   => l_rnk,
    Tag_   => 'K013',
    Val_   => '5',
    Otd_   => 0
  );

  p_client.rnk := l_rnk;

end create_customer;

-------------------------------------------------------------------------------
-- create_salary_deal
-- Процедура регистрации клиента и карты по файлу
--
procedure create_salary_deal (
  p_fileid    in number,
  -- p_proect_id is not null - SALARY
  -- p_proect_id is null - PENSION, SOCIAL
  p_proect_id in number,
  p_card_code in varchar2,
  p_branch    in varchar2,
  p_isp       in number )
is
  l_proect_okpo   bpk_proect.okpo%type;
  l_client_array  t_salp;
  l_instant_nls   accounts.nls%type;
  l_rnk           number;
  l_nd            number;
  l_reqid         number;
  l_open          boolean;
  l_flag_kk       number;
  h varchar2(100) := 'bars_ow.create_salary_deal. ';
begin

  bars_audit.info(h || 'Start: p_fileid=>' || to_char(p_fileid) || ' p_proect_id=>' || to_char(p_proect_id) ||
     ' p_card_code=>' || p_card_code || ' p_branch=>' || p_branch || ' p_isp=>' || to_char(p_isp));

  if p_proect_id is not null then
     begin
        select okpo into l_proect_okpo from bpk_proect where id = p_proect_id;
     exception when no_data_found then
        bars_audit.info(h || 'Не найден З/П проект с кодом '||to_char(p_proect_id));
        bars_error.raise_nerror(g_modcode, 'PROECT_NOT_FOUND', to_char(p_proect_id));
     end;
  end if;

  if p_proect_id is not null then
     for z in ( select okpo
                  from ow_salary_data
                 where id = p_fileid and nd is null and str_err is null
                   and nvl(okpo,'000000000') <> '000000000'
                having count(*) > 1
                 group by okpo )
     loop
        update ow_salary_data
           set str_err = 'Повторюється ЗКПО у межах файлу'
         where id = p_fileid and nd is null and str_err is null
           and okpo = z.okpo;
     end loop;
  end if;

  -- Картка
  begin
     select s.flag_kk into l_flag_kk
       from w4_card c, w4_subproduct s
      where c.code = p_card_code
        and c.sub_code = s.code;
  exception when no_data_found then
     -- Не найден продукт p_cardcode
     bars_error.raise_nerror(g_modcode, 'CARDCODE_NOT_FOUND', p_card_code);
  end;

  select *
    bulk collect
    into l_client_array
    from ow_salary_data
   where id = p_fileid and nd is null and nvl(flag_open,0) = 1;

  for i in 1..l_client_array.count loop

     l_open := true;

     if p_proect_id is not null then
        -- проверка ОКПО:
        --   то, что заявлено в файле и то, что выбрали в приложении,
        --   должны совпадать
        if l_client_array(i).okpo_w is not null and l_proect_okpo is not null and
           l_client_array(i).okpo_w <> l_proect_okpo then
           update ow_salary_data
              set str_err = 'ЗКПО організації в файлі не співпадає з ЗКПО З/П проекту'
            where id = p_fileid and idn = l_client_array(i).idn;
           l_open := false;
        end if;
     end if;

     if l_open = true then

        if l_client_array(i).acc_instant is not null then
           begin
              select a.nls into l_instant_nls
                from w4_acc_instant w, accounts a
               where w.acc = l_client_array(i).acc_instant
                 and w.acc = a.acc;
           exception when no_data_found then
              bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', l_client_array(i).acc_instant);
           end;
        else
           l_instant_nls := null;
        end if;

        l_rnk := l_client_array(i).rnk;

        if l_rnk is null then
           -- регистрация клиента
           create_customer(l_client_array(i), p_branch);
           l_rnk := l_client_array(i).rnk;
        else
           -- обновление реквизитов клиента
           alter_client(l_rnk, l_client_array(i));
        end if;

        if l_flag_kk = 1 then
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKW',
              Val_   => l_client_array(i).kk_secret_word,
              Otd_   => 0 );
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKR',
              Val_   => l_client_array(i).kk_regtype,
              Otd_   => 0 );
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKA',
              Val_   => l_client_array(i).kk_cityareaid,
              Otd_   => 0 );
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKT',
              Val_   => l_client_array(i).kk_streettypeid,
              Otd_   => 0 );
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKS',
              Val_   => l_client_array(i).kk_streetname,
              Otd_   => 0 );
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKB',
              Val_   => l_client_array(i).kk_apartment,
              Otd_   => 0 );
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKZ',
              Val_   => l_client_array(i).kk_postcode,
              Otd_   => 0 );
           kl.setCustomerElement(
              Rnk_   => l_rnk,
              Tag_   => 'W4KKC',
              Val_   => '2',
              Otd_   => 0 );
           begin
              insert into customer_images (rnk, type_img, image)
              values (l_rnk, 'PHOTO_JPG', empty_blob());
           exception when dup_val_on_index then null;
           end;
           update customer_images set image = l_client_array(i).kk_photo_data where rnk = l_rnk and type_img = 'PHOTO_JPG';
        end if;

        -- регистрация БПК
        open_card (
          p_rnk           => l_rnk,
          p_nls           => l_instant_nls,
          p_cardcode      => p_card_code,
          p_branch        => p_branch,
          p_embfirstname  => l_client_array(i).eng_first_name,
          p_emblastname   => l_client_array(i).eng_last_name,
          p_secname       => l_client_array(i).mname,
          p_work          => l_client_array(i).work,
          p_office        => l_client_array(i).office,
          p_wdate         => l_client_array(i).date_w,
          p_salaryproect  => p_proect_id,
          p_term          => l_client_array(i).max_term,
          p_branchissue   => p_branch,
          p_nd            => l_nd,
          p_reqid         => l_reqid );

       --open subcard from W4_CARD_ADD (6327)
       for card_add in (select cad.card_code_add
                          from W4_CARD_ADD cad where cad.card_code=p_card_code and cad.en=1)
       loop
        if check_cust_dk(l_rnk, null )=0 then     --перевірка умов по клієнту
         open_card (
          p_rnk           => l_rnk,
          p_nls           => l_instant_nls,
          p_cardcode      => card_add.card_code_add,
          p_branch        => p_branch,
          p_embfirstname  => l_client_array(i).eng_first_name,
          p_emblastname   => l_client_array(i).eng_last_name,
          p_secname       => l_client_array(i).mname,
          p_work          => l_client_array(i).work,
          p_office        => l_client_array(i).office,
          p_wdate         => l_client_array(i).date_w,
          p_salaryproect  => p_proect_id,
          p_term          => l_client_array(i).max_term,
          p_branchissue   => p_branch,
          p_nd            => l_nd,
          p_reqid         => l_reqid );
        else logger.info (h||'Помилка перевірки клієнта (РНК '||l_rnk||') для відкриття додаткової картки');
        end if;
       end loop;
---------------
        update accounts set isp = p_isp where acc = (select acc_pk from w4_acc where nd = l_nd);

        -- сохранение данных по новому клиенту
        update ow_salary_data
           set rnk = l_rnk,
               nd = l_nd
         where id = p_fileid and idn = l_client_array(i).idn;

     end if;

  end loop;

  update ow_salary_files
     set card_code = p_card_code,
         branch = p_branch,
         isp = p_isp,
         proect_id = p_proect_id
   where id = p_fileid;

  bars_audit.info(h || 'Finish.');

end create_salary_deal;

-------------------------------------------------------------------------------
-- w4_create_salary_deal
-- процедура создания БПК по файлу З/П проекта - для WEB
--
procedure w4_create_salary_deal (
  p_fileid      in number,
  p_proect_id   in number,
  p_card_code   in varchar2,
  p_branch      in varchar2,
  p_isp         in number,
  p_ticketname out varchar2,
  p_ticketbody out nocopy clob )
is
  l_fileid     number;
  l_ticketname varchar2(100);
  l_clob       clob;
  h varchar2(100) := 'bars_ow.w4_create_salary_deal. ';
begin

  bars_audit.trace(h || 'Start.');

  create_salary_deal (
     p_fileid    => p_fileid,
     p_proect_id => p_proect_id,
     p_card_code => p_card_code,
     p_branch    => p_branch,
     p_isp       => p_isp );

  l_fileid := p_fileid;
  form_salary_ticket_ex  (
     p_fileid     => l_fileid,
     p_ticketname => l_ticketname );

  if l_ticketname is not null then
     begin
        select file_data into l_clob from ow_impfile where id = l_fileid;
     exception when no_data_found then
        l_clob := null;
     end;
  else
     l_clob := null;
  end if;

  p_ticketname := l_ticketname;
  p_ticketbody := l_clob;

  bars_audit.trace(h || 'Finish.');

end w4_create_salary_deal;

-------------------------------------------------------------------------------
-- pk_reopen_card
-- процедура перевыпуска счета PK для Way4
--
procedure pk_reopen_card (
  p_pk_nd         in number,
  p_cardcode      in varchar2,
  p_salaryproect  in number,
  p_w4_nd        out number )
is
  l_w4_nd    number;
  l_w4_acc   number;
  l_pk_acc   number;
  l_reqid    number;
  l_pk_nls   accounts.nls%type;
  l_pk_nbs   accounts.nbs%type;
  l_pk_kv    accounts.kv%type;
  l_pk_isp   accounts.isp%type;
  l_branch   accounts.branch%type;
  l_rnk      customer.rnk%type;
  l_nmk      customer.nmk%type;
  l_nmkv     customer.nmkv%type;
  l_card_kv  w4_product.kv%type;
  l_card_nbs w4_product.nbs%type;
  l_embfirstname accountsw.value%type;
  l_emblastname  accountsw.value%type;
  l_secname      accountsw.value%type;
  l_work         accountsw.value%type;
  l_office       accountsw.value%type;
  l_wdate        accountsw.value%type;
  l_pkstr        accountsw.value%type;
  h varchar2(100) := 'bars_ow.reopen_card. ';
begin
  bars_audit.info(h || 'Start. p_pk_nd=>' || to_char(p_pk_nd) || ' p_cardcode=>' || p_cardcode ||
     ' p_salaryproect=>' || to_char(p_salaryproect));

  begin
     select o.acc_w4, a.acc, a.nbs, a.nls, a.kv, a.isp, a.branch,
            c.rnk, c.nmk, c.nmkv
       into l_w4_acc, l_pk_acc, l_pk_nbs, l_pk_nls, l_pk_kv, l_pk_isp, l_branch,
            l_rnk, l_nmk, l_nmkv
       from bpk_acc o, accounts a, customer c
      where o.nd = p_pk_nd
        and o.acc_pk = a.acc
        and a.rnk = c.rnk;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_pk_nd));
  end;

  if l_w4_acc is not null then
     bars_audit.info(h || 'Картку ' || l_pk_nbs || '/' || l_pk_kv || ' вже перевипущено');
     bars_error.raise_nerror(g_modcode, 'CARD_ALREADY_REOPEN', l_pk_nls, to_char(l_pk_kv));
  end if;

  -- проверка на валюту
  begin
     select p.kv, p.nbs into l_card_kv, l_card_nbs
       from w4_card c, w4_product p
      where c.code = p_cardcode
        and c.product_code = p.code;
  exception when no_data_found then
     raise_application_error(-20000, 'Не найдена карточка ' || p_cardcode);
  end;

  if l_pk_kv <> l_card_kv then
     -- валюта счета не совпадает с валютой карточки
     bars_error.raise_nerror(g_modcode, 'KVACC_KVCARD_ERROR');
  end if;
  if l_pk_nbs <> l_card_nbs then
     -- БС не совпадает с БС карточки
     bars_error.raise_nerror(g_modcode, 'NBSACC_NBSCARD_ERROR');
  end if;

  begin
     select min(decode(tag,decode(l_card_nbs,'2625','W4_EFN','2620','W4_EFN','W4_ECN'),value,null)) embfirstname,
            min(decode(tag,decode(l_card_nbs,'2625','W4_ELN','2620','W4_ELN','W4_CPN'),value,null)) emblastname,
            min(decode(tag,'W4_SEC',  value,null)) secname,
            min(decode(tag,'PK_WORK', value,null)) work,
            min(decode(tag,'PK_OFFIC',value,null)) office,
            min(decode(tag,'PK_ODAT', value,null)) wdate,
            min(decode(tag,'PK_STR',  value,null)) pk_str
       into l_embfirstname, l_emblastname, l_secname, l_work, l_office, l_wdate, l_pkstr
       from accountsw
      where acc = l_pk_acc;
  exception when no_data_found then
     l_embfirstname := null;
     l_emblastname := null;
     l_secname := null;
     l_work := null;
     l_office := null;
     l_wdate := null;
  end;

  if l_embfirstname is null then
     l_embfirstname := substr(fio(l_nmkv,2),1,30);
  end if;
  if l_emblastname is null then
     l_emblastname := substr(fio(l_nmkv,1),1,30);
  end if;

  -- если Таємне слово не заполнено, берем из старой карточки
  if l_secname is null then
     select min(substr(value,1,254)) into l_secname
       from customerw
      where rnk = l_rnk and tag='PC_MF';
  end if;

  open_card (
     p_rnk          => l_rnk,
     p_nls          => null,
     p_cardcode     => p_cardcode,
     p_branch       => l_branch,
     p_embfirstname => l_embfirstname,
     p_emblastname  => l_emblastname,
     p_secname      => l_secname,
     p_work         => l_work,
     p_office       => l_office,
     p_wdate        => null,
     p_salaryproect => p_salaryproect,
     p_term         => null,
     p_branchissue  => l_branch,
     p_nd           => l_w4_nd,
     p_reqid        => l_reqid);

  begin
     select acc_pk into l_w4_acc from w4_acc where nd = l_w4_nd;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(l_w4_nd));
  end;

  -- меняем исполнителя
  update accounts
     set isp = l_pk_isp,
         nlsalt = l_pk_nls
   where acc = l_w4_acc;
  -- дату просто переносим из старой карточки, чтоб не перекодировать туда-сюда
  if l_wdate is not null then
     accreg.setAccountwParam(l_w4_acc, 'PK_ODAT', l_wdate);
  end if;
  -- устанавливаем код страховой компании
  if l_pkstr is not null then
     accreg.setAccountwParam(l_w4_acc, 'PK_STR', l_pkstr);
  end if;

  update bpk_acc set acc_w4 = l_w4_acc where nd = p_pk_nd;

  p_w4_nd := l_w4_nd;

  bars_audit.info(h || 'Finish.  New deal with id ' || p_w4_nd || ' opened.');

end pk_reopen_card;

-------------------------------------------------------------------------------
-- pk_reopen_card
-- процедура перевыпуска счета PK для Way4
--
procedure pk_reopen_card (
  p_cardcode      in varchar2,
  p_salaryproect  in number )
is
  l_nd number;
  h varchar2(100) := 'bars_ow.pk_reopen_card. ';
begin
  bars_audit.info(h || 'Start,');
  for z in ( select nd from bpk_pktow4 where id = user_id )
  loop
     pk_reopen_card (
        p_pk_nd        => z.nd,
        p_cardcode     => p_cardcode,
        p_salaryproect => p_salaryproect,
        p_w4_nd        => l_nd );
  end loop;
  bars_audit.info(h || 'Finish');
end pk_reopen_card;

-------------------------------------------------------------------------------
-- pk_repay_card
-- процедура переноса остатка со счета PK на счет Way4
--
procedure pk_repay_card (p_pk_nd number)
is

  l_bdate  date;
  l_mfo    varchar2(6);

  l_pk_acc   number;
  l_pk_nls   varchar2(14);
  l_pk_kv    number;
  l_pk_dazs  date;
  l_pk_name  varchar2(38);
  l_pk_okpo  varchar2(14);
  l_pk_ost   number;
  l_ovr_acc  number;
  l_k_acc    number;
  l_d_acc    number;
  l_ovrp_acc number;
  l_kp_acc   number;
  l_dp_acc   number;
  l_ost      number;
  l_pk_count number;

  l_w4_acc   number;
  l_w4_nls   varchar2(14);
  l_w4_kv    number;
  l_w4_dazs  date;
  l_w4_ostc  number;
  l_w4_ostb  number;
  l_w4_name  varchar2(38);
  l_w4_okpo  varchar2(14);
  l_flag_idat number;

  l_pktr_nls   varchar2(14);
  l_pktr_name  varchar2(38);

  l_w4tr_nls   varchar2(14);
  l_w4tr_name  varchar2(38);

  l_ref     number;
  l_kv      number;
  l_tt_d    varchar2(3) := 'PKD';
  l_tt_k    varchar2(3) := 'PKR';
  l_tt      varchar2(3);
  l_vob     number;
  l_dk      number;
  l_s       number;
  l_nlsa    oper.nlsa%type;
  l_nam_a   oper.nam_a%type;
  l_id_a    oper.id_a%type;
  l_nlsb    oper.nlsb%type;
  l_nam_b   oper.nam_b%type;
  l_id_b    oper.id_b%type;
  l_nazn    varchar2(160);
  l_tr_type varchar2(2);

  h varchar2(100) := 'bars_ow.repay_card. ';

  procedure pay_ovr (
     p_ovracc  number,
     p_ovrnazn oper.nazn%type )
  is
     l_nlsb  oper.nlsb%type;
     l_namb  oper.nam_b%type;
  begin

     l_tt  := 'OVR';
     l_vob := 6;
     l_dk  := 1;

     if p_ovracc is not null then

        -- остаток на счете
        l_ost := fost(p_ovracc, l_bdate);

        if l_ost < 0 then

           begin

              select nls, substr(nms,1,38)
                into l_nlsb, l_namb
                from accounts
               where acc = p_ovracc and dazs is null;

              l_s := abs(l_ost);

              gl.ref (l_ref);

/*              insert into oper (ref, tt, vob, nd, dk, pdat, vdat, datd,
                 nam_a, nlsa, mfoa, id_a,
                 nam_b, nlsb, mfob, id_b, kv, s, kv2, s2, nazn, userid)
              values (l_ref, l_tt, l_vob, l_ref, l_dk, sysdate, l_bdate, l_bdate,
                 l_pk_name, l_pk_nls, l_mfo, l_pk_okpo,
                 l_namb, l_nlsb, l_mfo, l_pk_okpo, l_pk_kv, l_s, l_pk_kv, l_s, p_ovrnazn, user_id);*/

              gl.in_doc3 (ref_    => l_ref,
                          tt_     => l_tt,
                          vob_    => l_vob,
                          nd_     => to_char(l_ref),
                          pdat_   => sysdate,
                          vdat_   => l_bdate,
                          dk_     => l_dk,
                          kv_     => l_pk_kv,
                          s_      => l_s,
                          kv2_    => l_pk_kv,
                          s2_     => l_s,
                          sk_     => null,
                          data_   => l_bdate,
                          datp_   => l_bdate,
                          nam_a_  => l_pk_name,
                          nlsa_   => l_pk_nls,
                          mfoa_   => l_mfo,
                          nam_b_  => l_namb,
                          nlsb_   => l_nlsb,
                          mfob_   => l_mfo,
                          nazn_   => p_ovrnazn,
                          d_rec_  => null,
                          id_a_   => l_pk_okpo,
                          id_b_   => l_pk_okpo,
                          id_o_   => null,
                          sign_   => null,
                          sos_    => 0,
                          prty_   => 0,
                          uid_    => user_id);

              gl.payv(0, l_ref, l_bdate, l_tt, l_dk, l_pk_kv, l_pk_nls, l_s, l_pk_kv, l_nlsb, l_s);

              gl.pay(2, l_ref, l_bdate);

           exception when no_data_found then null;
           end;

        end if;

     end if;

  end pay_ovr;

begin

  bars_audit.info(h || 'Start. p_pk_nd=>' || to_char(p_pk_nd));

  l_bdate := gl.bdate;
  l_mfo   := gl.amfo;

  -- Договор PK
  begin
     select o.acc_w4, a.acc, a.nls, a.kv, a.dazs,
            substr(c.nmk,1,38), c.okpo,
            acc_ovr, acc_3570, acc_2208,
            acc_2207, acc_3579, acc_2209
       into l_w4_acc, l_pk_acc, l_pk_nls, l_pk_kv, l_pk_dazs,
            l_pk_name, l_pk_okpo,
            l_ovr_acc, l_k_acc, l_d_acc, l_ovrp_acc, l_kp_acc, l_dp_acc
       from bpk_acc o, accounts a, customer c
      where o.nd = p_pk_nd
        and o.acc_pk = a.acc
        and a.rnk = c.rnk;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_pk_nd));
  end;

  if l_pk_dazs is not null then
     bars_audit.info(h || 'Счет ' || l_pk_nls || '/' || l_pk_kv || ' закрыт');
     bars_error.raise_nerror(g_modcode, 'ACC_CLOSED', l_pk_nls, to_char(l_pk_kv));
  end if;

  if l_w4_acc is null then
     bars_audit.info(h || 'Карточка еще не перевыпущена');
     bars_error.raise_nerror(g_modcode, 'CARD_NOT_REOPEN_YET');
  end if;

  -- проверяем: если на счете PK есть несквитованные операции, остаток не переносим
  select count(*) into l_pk_count from pkk_que where acc = l_pk_acc;

  -- несквитованных операций нет, можно переносить остаток
  if l_pk_count = 0 then

     -- Договор W4
     begin
        select a.nls, a.kv, a.dazs, a.ostc, a.ostb,
               substr(c.nmk,1,38), c.okpo
          into l_w4_nls, l_w4_kv, l_w4_dazs, l_w4_ostc, l_w4_ostb,
               l_w4_name, l_w4_okpo
          from w4_acc o, accounts a, customer c
         where o.acc_pk = l_w4_acc
           and o.acc_pk = a.acc
           and a.rnk = c.rnk;
     exception when no_data_found then
        bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND');
     end;

     if l_w4_dazs is not null then
        bars_audit.info(h || 'Счет ' || l_w4_nls || '/' || l_w4_kv || ' закрит');
        bars_error.raise_nerror(g_modcode, 'ACC_CLOSED', l_w4_nls, to_char(l_w4_kv));
     end if;

     if l_pk_kv <> l_w4_kv then
        bars_audit.info(h || 'Не совпадают валюты счетов старого и нового ПЦ');
        bars_error.raise_nerror(g_modcode, 'KV_PKW4_ERROR');
     end if;

     if g_check_idat = 1 then
        begin
           select nvl2(value,1,0) into l_flag_idat
             from accountsw
            where acc = l_w4_acc and tag = 'PK_IDAT';
        exception when no_data_found then
           l_flag_idat := 0;
        end;
        if l_flag_idat = 0 then
           bars_audit.info(h || 'Відсутня дата видачі карт держателю по рахунку ' || l_w4_nls);
           bars_error.raise_nerror(g_modcode, 'IDAT_NOT_FOUND', l_pk_nls);
        end if;
     end if;

     -- проверка: если на счетах просрочки есть остатки, остатки не сворачиваем
     if l_ovrp_acc is not null then
        if fost(l_ovrp_acc, l_bdate) <> 0 then
           bars_audit.info(h || 'На счете просрочки есть остаток, миграция карточки ' || l_pk_nls || '/' || l_pk_kv || ' невозможна');
           bars_error.raise_nerror(g_modcode, 'DEBTACC_OST', l_pk_nls, to_char(l_pk_kv));
        end if;
     elsif l_kp_acc is not null then
        if fost(l_kp_acc, l_bdate) <> 0 then
           bars_audit.info(h || 'На счете просрочки есть остаток, миграция карточки ' || l_pk_nls || '/' || l_pk_kv || ' невозможна');
           bars_error.raise_nerror(g_modcode, 'DEBTACC_OST', l_pk_nls, to_char(l_pk_kv));
        end if;
     elsif l_dp_acc is not null then
        if fost(l_dp_acc, l_bdate) <> 0 then
           bars_audit.info(h || 'На счете просрочки есть остаток, миграция карточки ' || l_pk_nls || '/' || l_pk_kv || ' невозможна');
           bars_error.raise_nerror(g_modcode, 'DEBTACC_OST', l_pk_nls, to_char(l_pk_kv));
        end if;
     end if;

     -- сворачиваем остатки по счетам договора на карточный счет
     update accounts set pap = 3 where acc = l_pk_acc;
     -- гашение 2208
     if l_d_acc is not null then
        l_nazn := 'Погашення процентів за користування кредитом';
        pay_ovr(l_d_acc, l_nazn);
     end if;
     -- гашение 3570
     if l_k_acc is not null then
        l_nazn := 'Погашення нарахованих комісій';
        pay_ovr(l_k_acc, l_nazn);
     end if;
     -- гашение кредита 2202
     if l_ovr_acc is not null then
        l_nazn := 'Погашення кредиту';
        pay_ovr(l_ovr_acc, l_nazn);
     end if;
     update accounts set pap = 2 where acc = l_pk_acc;

     -- остаток на карт. счете
     l_pk_ost := fost(l_pk_acc, l_bdate);

     if nvl(l_pk_ost,0) <> 0 then

        l_dk := 1;
        l_kv := l_pk_kv;
        l_s  := abs(l_pk_ost);
        l_nazn := 'Перенесення залишку коштів у звязку з перевипуском платіжної картки у ПЦ Way4';

        if l_pk_ost > 0 then
           l_tr_type := '20';
        else
           l_tr_type := '10';
        end if;

        -- Транзит PK
--        l_pktr_nls := bpk_get_transit(l_tr_type,null,l_pk_nls,l_pk_kv);
        l_pktr_nls := obpc.get_transit(l_tr_type, l_pk_acc);
        if l_pktr_nls is null then
           bars_error.raise_nerror(g_modcode, 'TRANSITACC_NOT_FOUND', l_tt);
        end if;
        begin
           select substr(nms,1,38) into l_pktr_name
             from accounts
            where nls = l_pktr_nls and kv = l_pk_kv;
        exception when no_data_found then
           bars_error.raise_nerror(g_modcode, 'TRANSITACC_NOT_FOUND', l_tt);
        end;

        -- Транзит W4
        l_w4tr_nls := get_transit(l_w4_acc);
        if l_w4tr_nls is null then
           bars_error.raise_nerror(g_modcode, 'TRANSITACC_NOT_FOUND', l_tt);
        end if;
        begin
           select substr(nms,1,38) into l_w4tr_name
             from accounts
            where nls = l_w4tr_nls and kv = l_w4_kv;
        exception when no_data_found then
           bars_error.raise_nerror(g_modcode, 'TRANSITACC_NOT_FOUND', l_tt);
        end;

        if l_pk_ost > 0 then
           l_tt    := l_tt_d;
           l_nlsa  := l_pk_nls;
           l_nam_a := l_pk_name;
           l_id_a  := l_pk_okpo;
           l_nlsb  := l_pktr_nls;
           l_nam_b := l_pktr_name;
           l_id_b  := f_ourokpo;
        else
           l_tt    := l_tt_k;
           l_nlsa  := l_pktr_nls;
           l_nam_a := l_pktr_name;
           l_id_a  := f_ourokpo;
           l_nlsb  := l_pk_nls;
           l_nam_b := l_pk_name;
           l_id_b  := l_pk_okpo;
        end if;

        -- списание со счета старого ПЦ
        select nvl(min(vob),6) into l_vob from tts_vob where tt = l_tt;

        gl.ref (l_ref);

/*        insert into oper (ref, tt, vob, nd, dk, pdat, vdat, datd,
           nam_a, nlsa, mfoa, id_a,
           nam_b, nlsb, mfob, id_b, kv, s, kv2, s2, nazn, userid)
        values (l_ref, l_tt, l_vob, l_ref, l_dk, sysdate, l_bdate, l_bdate,
           l_nam_a, l_nlsa, l_mfo, l_id_a,
           l_nam_b, l_nlsb, l_mfo, l_id_b, l_kv, l_s, l_kv, l_s, l_nazn, user_id);*/

        gl.in_doc3 (ref_    => l_ref,
                    tt_     => l_tt,
                    vob_    => l_vob,
                    nd_     => to_char(l_ref),
                    pdat_   => sysdate,
                    vdat_   => l_bdate,
                    dk_     => l_dk,
                    kv_     => l_kv,
                    s_      => l_s,
                    kv2_    => l_kv,
                    s2_     => l_s,
                    sk_     => null,
                    data_   => l_bdate,
                    datp_   => l_bdate,
                    nam_a_  => l_nam_a,
                    nlsa_   => l_nlsa,
                    mfoa_   => l_mfo,
                    nam_b_  => l_nam_b,
                    nlsb_   => l_nlsb,
                    mfob_   => l_mfo,
                    nazn_   => l_nazn,
                    d_rec_  => null,
                    id_a_   => l_id_a,
                    id_b_   => l_id_b,
                    id_o_   => null,
                    sign_   => null,
                    sos_    => 0,
                    prty_   => 0,
                    uid_    => user_id);

        -- списываем с картсчета на транзит
        gl.payv(0, l_ref, l_bdate, l_tt, l_dk, l_kv, l_nlsa, l_s, l_kv, l_nlsb, l_s);

        -- дописываем переброску с транзита старого ПЦ на транзит нового ПЦ
        if l_pk_ost > 0 then
           gl.payv(0, l_ref, l_bdate, l_tt, l_dk,
              l_kv, l_pktr_nls, l_s,
              l_kv, l_w4tr_nls, l_s);
        else
           gl.payv(0, l_ref, l_bdate, l_tt, l_dk,
              l_kv, l_w4tr_nls, l_s,
              l_kv, l_pktr_nls, l_s);
        end if;

        if l_pk_ost > 0 then
           l_tt := l_tt_k;
           l_nlsa  := l_w4tr_nls;
           l_nam_a := l_w4tr_name;
           l_id_a  := f_ourokpo;
           l_nlsb  := l_w4_nls;
           l_nam_b := l_w4_name;
           l_id_b  := l_w4_okpo;
        else
           l_tt := l_tt_d;
           l_nlsa  := l_w4_nls;
           l_nam_a := l_w4_name;
           l_id_a  := l_w4_okpo;
           l_nlsb  := l_w4tr_nls;
           l_nam_b := l_w4tr_name;
           l_id_b  := f_ourokpo;
        end if;

        -- зачисление на счет нового ПЦ
        select nvl(min(vob),6) into l_vob from tts_vob where tt = l_tt;

        gl.ref (l_ref);

/*        insert into oper (ref, tt, vob, nd, dk, pdat, vdat, datd,
           nam_a, nlsa, mfoa, id_a,
           nam_b, nlsb, mfob, id_b, kv, s, kv2, s2, nazn, userid)
        values (l_ref, l_tt, l_vob, l_ref, l_dk, sysdate, l_bdate, l_bdate,
           l_nam_a, l_nlsa, l_mfo, l_id_a,
           l_nam_b, l_nlsb, l_mfo, l_id_b, l_kv, l_s, l_kv, l_s, l_nazn, user_id);*/

        gl.in_doc3 (ref_    => l_ref,
                    tt_     => l_tt,
                    vob_    => l_vob,
                    nd_     => to_char(l_ref),
                    pdat_   => sysdate,
                    vdat_   => l_bdate,
                    dk_     => l_dk,
                    kv_     => l_kv,
                    s_      => l_s,
                    kv2_    => l_kv,
                    s2_     => l_s,
                    sk_     => null,
                    data_   => l_bdate,
                    datp_   => l_bdate,
                    nam_a_  => l_nam_a,
                    nlsa_   => l_nlsa,
                    mfoa_   => l_mfo,
                    nam_b_  => l_nam_b,
                    nlsb_   => l_nlsb,
                    mfob_   => l_mfo,
                    nazn_   => l_nazn,
                    d_rec_  => null,
                    id_a_   => l_id_a,
                    id_b_   => l_id_b,
                    id_o_   => null,
                    sign_   => null,
                    sos_    => 0,
                    prty_   => 0,
                    uid_    => user_id);
        -- списываем с транзита на картсчет
        gl.payv(0, l_ref, l_bdate, l_tt, l_dk, l_kv, l_nlsa, l_s, l_kv, l_nlsb, l_s);

     end if;

  end if;

  bars_audit.info(h || 'Finish.');

end pk_repay_card;

-------------------------------------------------------------------------------
-- pk_close_card
-- процедура закрытия счетов PK
--
procedure pk_close_card (p_pk_nd number)
is
  l_msg  varchar2(2000);
  h varchar2(100) := 'bars_ow.pk_close_card. ';
begin

  bars_audit.info(h || 'Start.');

  -- проверка: можно закрывать договор?
  bars_bpk.can_close_deal(p_pk_nd, l_msg);

  -- l_msg пусто, закрывать можно
  if l_msg is null then
     bars_bpk.close_deal(p_pk_nd, l_msg);
     bars_audit.info(h || 'Договор БПК ' || p_pk_nd || ' закрыт');
  else
     bars_audit.info(h || 'Договор БПК ' || p_pk_nd || ' не закрывается');
  end if;

  bars_audit.info(h || 'Finish.');

end pk_close_card;

-------------------------------------------------------------------------------
-- can_close_deal
-- процедура проверки: можно закрыть договор?
--
procedure can_close_deal (
  p_nd   in number,
  p_msg out varchar2 )
is
  l_nls  varchar2(14);
  l_kv   number;
  l_dapp date;
  l_ostc number;
  l_ostb number;

  procedure append_msg ( p_txt varchar2 )
  is
  begin
     if p_msg is not null then
        p_msg := p_msg || chr(10) || p_txt;
     else
        p_msg := p_txt;
     end if;
  end;

begin

  for z in ( select acc from v_w4_nd_acc where nd = p_nd and acc is not null )
  loop

     begin

        select nls, kv, dapp, ostc/100, ostb/100
          into l_nls, l_kv, l_dapp, l_ostc, l_ostb
          from accounts
         where acc = z.acc
           and dazs is null;

        if l_dapp >= bankdate then
           append_msg('Рахунок ' || l_nls || '/' || to_char(l_kv) || ': дата останнього руху >= банк.дати, закриття рахунку неможливе.');
        end if;

        if l_ostc <> 0 or l_ostb <> 0 then
           append_msg('Рахунок ' || l_nls || '/' || to_char(l_kv) || ': фактичний залишок=' || to_char(l_ostc) ||', плановий залишок=' || to_char(l_ostb) || ', закриття рахунку неможливе.');
        end if;

     exception when no_data_found then null;
     end;

  end loop;

  if p_msg is not null then
     append_msg('Продовжити закриття угоди?');
     append_msg('Будуть закриті всі рахунки з нульовим залишком.');
  end if;

end can_close_deal;

-------------------------------------------------------------------------------
-- close_deal
-- процедура закрытия счетов договора
--
procedure close_deal (
  p_nd   in number,
  p_msg out varchar2 )
is
  i number;
  h varchar2(100) := 'bars_ow.close_deal. ';

  procedure append_msg ( p_txt varchar2 )
  is
  begin
     if p_msg is not null then
        p_msg := p_msg || chr(10) || p_txt;
     else
        p_msg := p_txt;
     end if;
  end;

begin

  bars_audit.info(h || 'Start. p_nd=>' || p_nd);

  for z in ( select v.acc, a.nls, a.kv
               from v_w4_nd_acc v, accounts a
              where v.nd  = p_nd
                and v.acc = a.acc
                and a.dazs is null
        and v.name != 'ACC_3570')
  loop

     begin

        select 1 into i
          from accounts
         where acc = z.acc
           and ostc = 0
           and ostb = 0
           and ostf = 0
           and (dapp is null or dapp < bankdate)
           and daos <= bankdate
        for update nowait;

        update accounts set dazs = bankdate where acc = z.acc;

        append_msg('Рахунок ' || z.nls || '/' || to_char(z.kv) || ' - закрито.');

     exception when no_data_found then
        append_msg('Рахунок ' || z.nls || '/' || to_char(z.kv) || ' - не закривається.');
     end;

  end loop;

  bars_audit.info(h || 'Finish. ' || p_msg);

end close_deal;

-------------------------------------------------------------------------------
-- can_closeacc
--
--
function can_closeacc (p_acc in number) return number
is
  l_cnt  number;  -- признак возможности закрытия счета
begin
    begin
       select 1 into l_cnt
         from accounts b
        where b.acc = p_acc
          and b.ostc = 0
          and b.ostb = 0
          and b.ostf = 0
--          and b.dazs is null
          and b.dapp < bankdate
          and b.daos <= bankdate
       for update nowait;
    exception
       when NO_DATA_FOUND then l_cnt := 0;
    end;

    return l_cnt;
end can_closeacc;

-------------------------------------------------------------------------------
-- cm_close_acc
-- процедура закрытия счетов по информации из CardMake
--
procedure cm_close_acc
is
  l_msg       cm_acc_request.abs_msg%type;
  l_acc       accounts.acc%type;
  l_nls       accounts.nls%type;
  l_kv        accounts.kv%type;
  l_ostc      accounts.ostc%type;
  l_ostb      accounts.ostb%type;
  l_ostf      accounts.ostf%type;
  l_dapp      accounts.dapp%type;
  l_acc_ovr   number;
  l_acc_3570  number;
  l_acc_2208  number;
  l_acc_9129  number;
  l_acc_2627  number;
  l_acc_2207  number;
  l_acc_3579  number;
  l_acc_2209  number;
  l_acc_2625x number;
  l_acc_2627x number;
  l_acc_2625d number;
  l_acc_2628  number;
  l_close     number;   -- Признак: счет закрывать
  l_cnt       number;
  l_iserr     boolean := false;
  ora_lock    exception;
  pragma      exception_init(ora_lock, -54);
  h varchar2(100) := 'bars_ow.cm_close_acc. ';

  function can_close_acc (p_close number, p_acc number, p_msg in out varchar2) return number
  is
     l_ret number := 0;
     l_tmp varchar2(14);
  begin
     if p_close = 1 then
        if p_acc is not null then
           l_ret := can_closeacc(p_acc);
           if l_ret = 0 then
              begin
                 select nls into l_tmp from accounts where acc = p_acc;
                 p_msg := 'Рахунок ' || l_tmp || ' - неможливо закрити';
              exception when no_data_found then null;
              end;
           end if;
        else
           l_ret := 1;
        end if;
     end if;
     return l_ret;
  end;

  procedure close_acc (p_acc number)
  is
  begin
     if p_acc is not null then
        update accounts set dazs = decode(dazs,null,bankdate,dazs) where acc = p_acc;
     end if;
  end;

begin

  bars_audit.info(h || 'Start.');

  -- отбираем счета для закрытия
  for k in ( select c.contract_number, c.oper_type, c.oper_date, c.date_in
               from cm_acc_request c
              where c.oper_type  = g_cmaccrequest_closeacc
                and c.oper_date <= bankdate )
  loop

     l_close := 1;
     l_msg := null;

     begin
        select a.acc, a.nls, a.kv, a.ostc, a.ostb, a.ostf, a.dapp,
               o.acc_ovr, o.acc_3570, o.acc_2208, o.acc_9129,
               o.acc_2627, o.acc_2207, o.acc_3579, o.acc_2209,
               o.acc_2625x, o.acc_2627x, o.acc_2625d, o.acc_2628
          into l_acc, l_nls, l_kv, l_ostc, l_ostb, l_ostf, l_dapp,
               l_acc_ovr, l_acc_3570, l_acc_2208, l_acc_9129,
               l_acc_2627, l_acc_2207, l_acc_3579, l_acc_2209,
               l_acc_2625x, l_acc_2627x, l_acc_2625d, l_acc_2628
          from accounts a, w4_acc o
         where a.acc = o.acc_pk
           and a.nls = k.contract_number
           and a.dazs is null;
        -- счета с остатком
        if l_ostc <> 0 or l_ostb <> 0 or l_ostf <> 0 then
           l_msg := 'Ненульовий залишок';
        end if;
         -- были обороты сегодня
        if l_dapp is not null and l_dapp >= bankdate then
           l_msg := 'Є обороти';
        end if;
      exception when no_data_found then
        l_msg := 'Рахунок не знайдено або закрито';
     end;

     if l_msg is not null then

        -- запоминаем сообщение
        update cm_acc_request
           set abs_status = 1,
               abs_msg = l_msg
         where contract_number = k.contract_number
           and oper_type = k.oper_type
           and oper_date = k.oper_date
           and date_in   = k.date_in;

     else

        begin
           savepoint sp_before;
           l_close := 1;

           -- блокируем карточный счет
           select 1 into l_cnt
             from accounts
            where acc = l_acc
           for update nowait;

           -- дополнительные проверки:
           l_close := can_close_acc(l_close, l_acc_ovr, l_msg);
           l_close := can_close_acc(l_close, l_acc_3570, l_msg);
           l_close := can_close_acc(l_close, l_acc_2208, l_msg);
           l_close := can_close_acc(l_close, l_acc_9129, l_msg);
           l_close := can_close_acc(l_close, l_acc_2627, l_msg);
           l_close := can_close_acc(l_close, l_acc_2207, l_msg);
           l_close := can_close_acc(l_close, l_acc_3579, l_msg);
           l_close := can_close_acc(l_close, l_acc_2209, l_msg);
           l_close := can_close_acc(l_close, l_acc_2625x, l_msg);
           l_close := can_close_acc(l_close, l_acc_2627x, l_msg);
           l_close := can_close_acc(l_close, l_acc_2625d, l_msg);
           l_close := can_close_acc(l_close, l_acc_2628, l_msg);

           if l_close = 1 then

              -- запоминаем сообщение
              update cm_acc_request
                 set abs_status = 2,
                     abs_msg = null
               where contract_number = k.contract_number
                 and oper_type = k.oper_type
                 and oper_date = k.oper_date
                 and date_in = k.date_in;

              -- закрываем счет
              update accounts set dazs = bankdate where acc = l_acc;

              -- удаляем запрос из обработки
              delete from cm_acc_request
               where contract_number = k.contract_number
                 and oper_type = k.oper_type
                 and oper_date = k.oper_date
                 and date_in = k.date_in;

              -- закрываем все привязанные счета
              close_acc(l_acc_ovr);
              close_acc(l_acc_3570);
              close_acc(l_acc_2208);
              close_acc(l_acc_9129);
              close_acc(l_acc_2627);
              close_acc(l_acc_2207);
              close_acc(l_acc_3579);
              close_acc(l_acc_2209);
              close_acc(l_acc_2625x);
              close_acc(l_acc_2627x);
              close_acc(l_acc_2625d);
              close_acc(l_acc_2628);

              begin
                 insert into accountsw(acc, tag, value)
                 values (l_acc, 'RCLOS', 'Закрито по інформації з CardMake');
              exception when dup_val_on_index then null;
              end;

              bars_audit.info(h || 'Account ' || l_nls || '/' || l_kv || ' closed.');

              EXECUTE IMMEDIATE
                     'BEGIN DPT_WEB.CLOSE_STO_ARGMNT(P_DPTID    => NULL,
                                                     P_ACCID    => :L_ACC,
                                                     P_ARGMNTID => NULL); END;'
                using l_acc;

              EXECUTE IMMEDIATE
                     'BEGIN DPT_WEB.CLOSE_STO_ARGMNT(P_DPTID    => NULL,
                                                     P_ACCID    => :L_ACC_2625D,
                                                     P_ARGMNTID => NULL); END;'
                USING L_ACC_2625D;

           else

              -- запоминаем сообщение
              update cm_acc_request
                 set abs_status = 1,
                     abs_msg = l_msg
               where contract_number = k.contract_number
                 and oper_type = k.oper_type
                 and oper_date = k.oper_date
                 and date_in = k.date_in;

           end if;

           commit;

        exception
           when ORA_LOCK then
                rollback to sp_before;
                l_iserr := true;
        end;

     end if;

  end loop;

  if (l_iserr) then
     bars_error.raise_nerror(g_modcode, 'LOCKED_ACCOUNT_FOUND');
  end if;

  bars_audit.info(h || 'Finish.');

end cm_close_acc;

procedure open_2203 (
   p_pk_acc  in number,
   p_oldacc  in number,
   p_oldnls  in varchar2,
   p_oldnms  in varchar2,
   p_newnbs  in varchar2,
   p_newacc out number)
is
 l_bdate         date;
 l_mfo           varchar2(6);
   l_acc     number := null;
   l_ost     number;
   l_newnls  accounts.nls%type;
   l_newnms  accounts.nms%type;
   l_okpo    customer.okpo%type;
   l_ref     number;
   l_kv      number;
   l_tt      varchar2(3) := 'OW1';
   l_vob     number := 6;
   l_dk      number := 1;
   l_s       number;
   l_nazn    varchar2(160) := 'Перенесення залишків коштів, в зв''язку зі зміною банківського продукту';
   l_trmask t_trmask;
begin
   select * into l_trmask from ow_transnlsmask t where t.nbs = p_newnbs and t.tip = 'KSS' and rownum = 1;
   -- открываем счет
   open_acc(p_pk_acc, l_trmask, l_acc);

   -- остаток на счете
   l_ost := fost(p_oldacc, l_bdate);

   -- переносим остаток
   if l_ost < 0 then

      begin

         select a.nls, substr(a.nms,1,38), a.kv, c.okpo
           into l_newnls, l_newnms, l_kv, l_okpo
           from accounts a, customer c
          where a.acc = l_acc
            and a.rnk = c.rnk;

         l_s := abs(l_ost);

         gl.ref (l_ref);

         gl.in_doc3 (ref_    => l_ref,
                     tt_     => l_tt,
                     vob_    => l_vob,
                     nd_     => to_char(l_ref),
                     pdat_   => sysdate,
                     vdat_   => l_bdate,
                     dk_     => l_dk,
                     kv_     => l_kv,
                     s_      => l_s,
                     kv2_    => l_kv,
                     s2_     => l_s,
                     sk_     => null,
                     data_   => l_bdate,
                     datp_   => l_bdate,
                     nam_a_  => l_newnms,
                     nlsa_   => l_newnls,
                     mfoa_   => l_mfo,
                     nam_b_  => p_oldnms,
                     nlsb_   => p_oldnls,
                     mfob_   => l_mfo,
                     nazn_   => l_nazn,
                     d_rec_  => null,
                     id_a_   => l_okpo,
                     id_b_   => l_okpo,
                     id_o_   => null,
                     sign_   => null,
                     sos_    => null,
                     prty_   => 0,
                     uid_    => user_id);

         gl.payv(0, l_ref, l_bdate, l_tt, l_dk, l_kv, l_newnls, l_s, l_kv, p_oldnls, l_s);

         gl.pay(2, l_ref, l_bdate);

      exception when no_data_found then null;
      end;

   end if;

   -- закрываем старый счет
   update accounts set dazs = case when dapp < l_bdate then l_bdate else l_bdate+1 end where acc = p_oldacc;

   p_newacc := l_acc;

end open_2203;

-------------------------------------------------------------------------------
-- cm_alter_acc
-- процедура модификации параметров договора по информации из CardMake
--
procedure cm_alter_acc(p_mode number default 0, p_cm_acc_req cm_acc_request%rowtype, p_msg out varchar2)
is
  l_bdate         date;
  l_mfo           varchar2(6);
  l_msg           cm_acc_request.abs_msg%type;
  l_nd            number;
  l_acc           number;
  l_acc_ovr       number;
  l_card_code     w4_acc.card_code%type;
  l_old_nbs       w4_product.nbs%type;
  l_old_kv        w4_product.kv%type;
  l_old_ob22      w4_product.ob22%type;
  l_old_tip       w4_product.tip%type;
  l_new_nbs       w4_product.nbs%type;
  l_new_kv        w4_product.kv%type;
  l_new_ob22      w4_product.ob22%type;
  l_new_tip       w4_product.tip%type;
  l_ovr_old_nbs   accounts.nbs%type;
  l_ovr_old_nls   accounts.nls%type;
  l_ovr_old_nms   accounts.nms%type;
  l_ovr_old_dazs  date;
  l_ovr_old_ob22  accounts.ob22%type;
  l_ovr_new_nbs   accounts.nbs%type;
  l_ovr_new_acc   number;
  l_ovr_new_ob22  accounts.ob22%type;
  l_bpk_proect_id_new    number;
  l_name_new             bpk_proect.name%type;
  l_bpk_proect_id_old    number;
  l_name_old             bpk_proect.name%type;
  l_trmask               t_trmask;

  h varchar2(100) := 'bars_ow.cm_alter_acc. ';


begin

  bars_audit.info(h || 'Start.');

  l_bdate := gl.bdate;
  l_mfo   := gl.amfo;

  -- отбираем счета для изменения типа карты
  for z in ( select c.contract_number, c.product_code, c.card_type, c.oper_type, c.oper_date, c.date_in,
                    c.okpo, c.okpo_n
               from cm_acc_request c
              where c.oper_type  = g_cmaccrequest_altersub
                and c.oper_date <= bankdate
                and p_mode = 0
             union all
             select p_cm_acc_req.contract_number, p_cm_acc_req.product_code, p_cm_acc_req.card_type, p_cm_acc_req.oper_type, p_cm_acc_req.oper_date, p_cm_acc_req.date_in,
                    p_cm_acc_req.okpo, p_cm_acc_req.okpo_n
               from dual c
              where p_mode = 1
                )
  loop

     l_msg := null;

     -- проверка новой карты
     begin
        select p.nbs, p.kv, p.ob22, p.tip
          into l_new_nbs, l_new_kv, l_new_ob22, l_new_tip
          from w4_card c, w4_product p
         where c.code = z.card_type
           and c.product_code = p.code;
     exception when no_data_found then
        l_msg := 'Не знайдено картку ' || z.card_type;
     end;

     -- поиск счета
     if l_msg is null then
        begin
           select o.nd, a.acc, o.acc_ovr, o.card_code
             into l_nd, l_acc, l_acc_ovr, l_card_code
             from accounts a, w4_acc o
            where a.acc = o.acc_pk
              and a.nls = z.contract_number
              and (a.dazs is null or (a.nbs is null and a.dazs is not null));
        exception when no_data_found then
           l_msg := 'Рахунок не знайдено або закрито';
        end;
     end if;

     -- проверка старой карты
     if l_msg is null then
        begin
           select p.nbs, p.kv, p.ob22, p.tip
             into l_old_nbs, l_old_kv, l_old_ob22, l_old_tip
             from w4_card c, w4_product p
            where c.code = l_card_code
              and c.product_code = p.code;
           if l_old_nbs <> l_new_nbs
           or l_old_kv  <> l_new_kv then
              l_msg := 'Параметри старого продукту не відповідають параметрам нового продукту (НБС, валюта)';
           end if;
        exception when no_data_found then
           l_msg := 'Не знайдено картку ' || l_card_code;
        end;
     end if;

     -- Поиск нового идетнификатора зп проекта

     if l_msg is not null then
        begin
          select e.id, e.name
            into l_bpk_proect_id_old, l_name_old
            from accountsw w, bpk_proect e, w4_product p
           where w.acc = l_acc
             and w.tag = 'PK_PRCT'
             and w.value = to_char(e.id)
             and e.product_code = p.code
             and p.grp_code = 'SALARY';
         exception
           when no_data_found then
             l_bpk_proect_id_old := null;
             l_name_old := null;
         end;
     end if;

     if z.okpo is not null and z.okpo_n is not null and l_msg is null then
        begin
          select distinct t.id, t.name --COBUMMFO-8964 ("distinct")
            into l_bpk_proect_id_new, l_name_new
           from bpk_proect t, w4_card  w
           where t.product_code = w.product_code and t.okpo = z.okpo and w.code = z.card_type and
                 t.used_w4 = 1 and t.okpo_n = z.okpo_n;
        exception
          when no_data_found then
           l_msg := 'Не знайдено зп проект по параметрам OKPO=' || z.okpo || ' OKPO_N=' || z.okpo_n||' CARD_TYPE ='||z.card_type;
          when too_many_rows then
           l_msg := 'Більше одного проекта за такими даними :OKPO=' || z.okpo || ' OKPO_N=' || z.okpo_n||' CARD_TYPE ='||z.card_type;
        end;

     end if;


     if l_msg is null and nvl(l_bpk_proect_id_old,0) <> nvl(l_bpk_proect_id_new,0) then
      -- меняем идентификатор зп проекта
        accreg.setAccountwParam(l_acc, 'PK_PRCT', l_bpk_proect_id_new);
     end if;
     if l_msg is null and nvl(l_name_old,'0') <> nvl(l_name_new,'0') then
      -- меняем название зп проекта
        accreg.setAccountwParam(l_acc, 'PK_WORK', l_name_new);
     end if;
     -- изменение параметров договора
     if l_msg is null and z.card_type <> l_card_code then

        -- меняем тип карточного счета
        if l_old_tip <> l_new_tip then
           -- меняем тип карточного счета
           update accounts set tip = l_new_tip where acc = l_acc;
           l_trmask.a_w4_acc := 'ACC_PK';
           l_trmask.nbs := substr(z.contract_number,1,4);
           -- меняем спецпараметры карточного счета
           set_sparam('1', l_acc, l_trmask);
        end if;

        -- меняем ОБ22 карточного счета
        if l_old_ob22 <> l_new_ob22 then
           accreg.setAccountSParam(l_acc, 'OB22', l_new_ob22);
        end if;

        -- если поменялся срок (краткосрочн./долгосрочн.), открываем новый счет, переносим остатки
        l_ovr_new_acc := l_acc_ovr;
        if l_old_tip <> l_new_tip and l_acc_ovr is not null then
           begin
              select nbs, dazs, nls, substr(nms,1,38), ob22
                into l_ovr_old_nbs, l_ovr_old_dazs, l_ovr_old_nls, l_ovr_old_nms, l_ovr_old_ob22
                from accounts
               where acc = l_acc_ovr;
              -- кредитный счет закрыт, отвяжем его от договора
              if l_ovr_old_dazs is not null then
                 l_ovr_new_acc := null;
              else
                 if newnbs.g_state = 1 then
                    begin
                      select t.ob_ovr
                        into l_ovr_new_ob22
                        from w4_nbs_ob22 t
                       where t.nbs = l_new_nbs
                         and t.ob22 = l_new_ob22
                         and t.tip = l_new_tip;
                     exception when no_data_found then
                        l_ovr_new_ob22 := null;
                     end;
                    -- новый долгоср. 2203
                    if l_old_tip = 'W4C' and l_ovr_new_ob22 <> l_ovr_old_ob22 then
                       l_ovr_new_nbs := case when l_ovr_old_nbs = '2203' then '2203' else '2063' end;
                    -- новый краткоср. 2203
                    elsif l_new_tip = 'W4C'  and l_ovr_new_ob22 <> l_ovr_old_ob22 then
                       l_ovr_new_nbs := case when l_ovr_old_nbs = '2203' then '2203' else '2063' end;
                    -- БС не меняется
                    else
                       l_ovr_new_nbs := null;
                    end if;
                 else
                    -- новый долгоср. 2203
                    if l_new_tip = 'W4B' and l_ovr_old_nbs in ('2202', '2062') then
                       l_ovr_new_nbs := case when l_ovr_old_nbs = '2202' then '2203' else '2063' end;
                    -- новый краткоср. 2202
                    elsif l_new_tip = 'W4C' and l_ovr_old_nbs in ('2203', '2063') then
                       l_ovr_new_nbs := case when l_ovr_old_nbs = '2203' then '2202' else '2062' end;
                    -- БС не меняется
                    else
                       l_ovr_new_nbs := null;
                    end if;

                 end if;
                 -- если БС меняется, открываем новый счет
                 if l_ovr_new_nbs is not null then
                    open_2203(l_acc, l_acc_ovr, l_ovr_old_nls, l_ovr_old_nms, l_ovr_new_nbs, l_ovr_new_acc);
                 end if;
              end if;
           exception when no_data_found then null;
           end;
        end if;

        -- меняем тип карты
        update w4_acc set card_code = z.card_type, acc_ovr = l_ovr_new_acc where nd = l_nd;

        -- спецпараметры по счетам договора
        if l_old_ob22 <> l_new_ob22
        or l_old_tip  <> l_new_tip then
           for x in ( select substr(w.name,5) name, w.acc, a.tip, a.nbs
                        from v_w4_nd_acc w, accounts a
                       where w.nd = l_nd
                          -- для acc_pk и acc_ovr уже все поменяли
                         and w.name not in ('ACC_PK', 'ACC_OVR')
                         and w.acc = a.acc
                         and a.dazs is null )
           loop
             begin
               select * into l_trmask from ow_transnlsmask t where t.nbs = x.nbs and t.tip = x.tip and rownum = 1;
             exception
               when no_data_found then 
                 l_trmask := null;
             end;
              -- меняем спецпараметры
              set_sparam('0', x.acc, l_trmask);
           end loop;
        end if;

        -- обновление %% ставок по счетам договра
        set_accounts_rate(l_nd);

     end if;

  p_msg := l_msg;

     -- запоминаем сообщение
     if p_mode = 0 then
     update cm_acc_request
        set abs_status = decode(l_msg,null,2,1),
            abs_msg = l_msg
      where contract_number = z.contract_number
        and oper_type = z.oper_type
        and date_in = z.date_in;
end if;

     -- удаляем обработанный запрос
     if l_msg is null and p_mode = 0 then
        delete from cm_acc_request
         where contract_number = z.contract_number
           and oper_type = z.oper_type
           and oper_date = z.oper_date
           and date_in = z.date_in;
     end if;

  end loop;

  bars_audit.info(h || 'Finish.');

end cm_alter_acc;

-------------------------------------------------------------------------------
-- set_term
-- процедура устаноки спецпараметра БПК. Кількість місяців дії картки
-- + внесення змін по параметрах статзвітності НБУ (Дата початку кредитного договору,
-- Дата закінчення кредитного договору, S180, MDATE, кількість місяців дії БПК)
--
procedure set_term (
  p_nd   number,
  p_bdat date,
  p_term number)
is
  l_term        number;
  l_acc_pk      number;
  l_acc_ovr     number;
  l_acc_2208    number;
  l_acc_2207    number;
  l_acc_2209    number;
  l_acc_9129    number;
  l_product_grp w4_product_groups.code%type;
  l_bdat        date;
  l_edat        date;
  l_s180        varchar2(1);
begin

  begin
     select o.acc_pk, o.dat_begin, o.acc_ovr, o.acc_2208, o.acc_2207, o.acc_2209, o.acc_9129, p.grp_code
       into l_acc_pk, l_bdat, l_acc_ovr, l_acc_2208, l_acc_2207, l_acc_2209, l_acc_9129, l_product_grp
       from w4_acc o, w4_card c, w4_product p
      where o.nd = p_nd
        and o.card_code = c.code
        and c.product_code = p.code;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_nd));
  end;

  l_term := case when nvl(p_term,0) <= 0 then 13
                 else p_term
            end;

  -- установка спецпараметра Кількість місяців дії картки
  accreg.setAccountwParam(l_acc_pk, 'PK_TERM', l_term);

  -- Дата початку кредитного договору
  l_bdat := nvl(p_bdat, l_bdat);

  -- установка Дата закінчення строку дії кредитного договору
  l_edat := iget_datend(l_bdat, l_term, l_product_grp);
  update w4_acc set dat_end = l_edat where nd = p_nd;

  -- установка mdate
  if l_acc_ovr is not null then
     update accounts set mdate = l_edat where acc = l_acc_ovr;
  end if;
  if l_acc_2208 is not null then
     update accounts set mdate = l_edat where acc = l_acc_2208;
  end if;
  if l_acc_2207 is not null then
     update accounts set mdate = l_edat where acc = l_acc_2207;
  end if;
  if l_acc_2209 is not null then
     update accounts set mdate = l_edat where acc = l_acc_2209;
  end if;
  if l_acc_9129 is not null then
     update accounts set mdate = l_edat where acc = l_acc_9129;
  end if;

  -- установка спецпараметров S180
  l_s180 := case when l_edat - l_bdat <= 31 then '5'
                 when l_edat - l_bdat between 32 and 92 then '6'
                 when l_edat - l_bdat between 93 and 183 then '7'
                 when l_edat - l_bdat between 184 and 274 then 'A'
                 when l_edat - l_bdat between 275 and 365 then 'B'
                 when l_edat - l_bdat between 366 and 548 then 'C'
                 when months_between(l_edat, l_bdat) <= 12*2 then 'D'
                 when months_between(l_edat, l_bdat) <= 12*3 then 'E'
                 when months_between(l_edat, l_bdat) <= 12*5 then 'F'
                 when months_between(l_edat, l_bdat) <= 12*10 then 'G'
                 else 'H'
            end;

  if l_acc_ovr is not null then
     update specparam set s180 = l_s180 where acc = l_acc_ovr;
  end if;
  if l_acc_2208 is not null then
     update specparam set s180 = l_s180 where acc = l_acc_2208;
  end if;
  if l_acc_2207 is not null then
     update specparam set s180 = l_s180 where acc = l_acc_2207;
  end if;
  if l_acc_2209 is not null then
     update specparam set s180 = l_s180 where acc = l_acc_2209;
  end if;
  if l_acc_9129 is not null then
     update specparam set s180 = l_s180 where acc = l_acc_9129;
  end if;

end set_term;

-------------------------------------------------------------------------------
-- cm_alter_expire
-- процедура изменения терміну дії основної картки
--
procedure cm_alter_expire
is
  l_msg   cm_acc_request.abs_msg%type := null;
  l_nd    number;
  l_date  date;
 l_endd  date;
  l_bdat  date;
  l_term  number;
  l_insurance t_insurance;
  l_cm_acc cm_acc_request%rowtype;
  l_code  w4_card.code%type;
  l_err   varchar2(4000);
  h varchar2(100) := 'bars_ow.cm_alter_expire. ';
begin

  bars_audit.info(h || 'Start.');

  -- отбираем счета для изменения терміну дії основної картки
  for z in ( select c.oper_type, c.date_in, c.contract_number, c.product_code, c.card_type,
                    c.oper_date, c.abs_status, c.abs_msg, c.okpo, c.okpo_n, trim(c.card_expire) card_expire
               from cm_acc_request c
              where c.oper_type  = g_cmaccrequest_alterexpire
                and c.oper_date <= bankdate )
  loop

     l_msg := null;

     -- проверка правильности заполнения терміну дії основної картки
     if z.card_expire is null then
        l_msg := 'Некоректно задано термін дії основної картки';
     else
        begin
           l_date := to_date('01' || substr(z.card_expire,-2) || '20' || substr(z.card_expire,1,2),'ddmmyyyy');
        exception when others then
           l_msg := 'Некоректно задано термін дії основної картки';
        end;
     end if;

     -- поиск счета и установка терміну дії основної картки
     if l_msg is null then
        begin
           select o.nd, o.card_code, o.dat_end into l_nd, l_code, l_endd
             from accounts a, w4_acc o
            where a.acc = o.acc_pk
              and a.nls = z.contract_number
              and a.dazs is null;
           -- меняем спецпараметр Кількість місяців дії картки
           l_term := months_between(to_date('01' || substr(z.card_expire,-2) || '20' || substr(z.card_expire,1,2),'ddmmyyyy'), trunc(z.oper_date,'mm'));
          if l_term < 0 then
              l_msg := 'Некоректно задано термін дії основної картки';
           else
              if l_term <> 0 then
              set_term(l_nd, z.oper_date, l_term);
           end if;
              if z.card_type is not null then
                 l_cm_acc.oper_type := z.oper_type;
                 l_cm_acc.date_in := z.date_in;
                 l_cm_acc.contract_number := z.contract_number;
                 l_cm_acc.product_code := z.product_code;
                 l_cm_acc.card_type := z.card_type;
                 l_cm_acc.oper_date := z.oper_date;
                 l_cm_acc.abs_status := z.abs_status;
                 l_cm_acc.abs_msg := z.abs_msg;
                 l_cm_acc.okpo := z.okpo;
                 l_cm_acc.okpo_n := z.okpo_n;
                 l_cm_acc.card_expire := z.card_expire;
                 cm_alter_acc(1, l_cm_acc, l_msg);
              end if;
              begin
                if l_msg is null and (months_between(add_months(trunc(sysdate, 'mm'), l_term), trunc(l_endd, 'mm')) >=1 or l_code <> z.card_type)  then
                   l_insurance := get_ins_data(z.contract_number);
                   if l_insurance.ins_ukr_id is not null and l_insurance.haveoldins = 1 then
                      l_insurance.datefrom := trunc(sysdate);
                      l_insurance.dateto := to_date(lpad(EXTRACT(day FROM sysdate), 2, '0' )|| substr(z.card_expire,-2) || '20' || substr(z.card_expire,1,2),'ddmmyyyy') - 1;
                      if months_between(l_insurance.dateto, trunc(sysdate)) > 36 then
                         l_insurance.dateto := add_months(trunc(sysdate), 36) -1;
                      end if;
                      create_insurance_deal(l_insurance);
                   end if;
                end if;
              exception
                when others then
                  l_err := dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace();
                  bars_audit.info(h || 'Error: ' || l_err);
                end;
           end if;
        exception when no_data_found then
           l_msg := 'Рахунок не знайдено або закрито';
        end;
     end if;

     -- запоминаем сообщение
     update cm_acc_request
        set abs_status = decode(l_msg,null,2,1),
            abs_msg = l_msg
      where contract_number = z.contract_number
        and oper_type = z.oper_type
        and date_in = z.date_in;

     -- удаляем обработанный запрос
     if l_msg is null then
        delete from cm_acc_request
         where contract_number = z.contract_number
           and oper_type = z.oper_type
           and oper_date = z.oper_date
           and date_in = z.date_in;
     end if;

  end loop;

  -- отбираем счета для изменения терміну дії основної картки, если данных о перевыпуске нет, а срок прошел
  for z in ( select o.nd, a.acc, o.dat_begin, o.dat_end, o.card_code, p.grp_code
               from w4_acc o, accounts a, w4_card c, w4_product p
              where o.acc_pk = a.acc
                and a.dazs is null
                and o.card_code = c.code
                and c.product_code = p.code
                and o.dat_end < bankdate )
  loop

     l_bdat := z.dat_end + 1;

     begin
        select to_number(value) into l_term from accountsw where acc = z.acc and tag = 'PK_TERM';
     exception when no_data_found then
        begin
           select c.maxterm into l_term
             from w4_card c, cm_product m
            where c.code = z.card_code
              and c.product_code = m.product_code;
        exception when no_data_found then
           l_term := null;
        end;
     end;
     set_term(z.nd, l_bdat, nvl(l_term,13));

  end loop;

  bars_audit.info(h || 'Finish.');

end cm_alter_expire;

-------------------------------------------------------------------------------
-- cm_process_request
-- процедура обработки запросов CardMake
--
procedure cm_process_request ( p_mode in number )
is
  h varchar2(100) := 'bars_ow.cm_process_request. ';
  l_msg varchar2(4000);
begin

  bars_audit.info(h || 'Start.');

  cm_close_acc;

  cm_alter_acc(0, null, l_msg);

  cm_alter_expire;
/*
  for z in ( select c.contract_number, c.oper_type, c.date_in
               from cm_acc_request c
              where not exists (select 1 from accounts where nls = c.contract_number) )
  loop
     -- запоминаем сообщение
     update cm_acc_request
        set abs_status = 1,
            abs_msg = 'Рахунок не знайдено'
      where contract_number = z.contract_number
        and oper_type = z.oper_type
        and date_in = z.date_in;
  end loop;
*/
     -- запоминаем сообщение
  update cm_acc_request set abs_status = 1,  abs_msg = 'Рахунок не знайдено'
  where contract_number in
  (
   select contract_number
    from 
      (
      select c.contract_number,
      (select count('x') from accounts acc where acc.nls = c.contract_number) cr 
      from cm_acc_request c
      ) cm
      where cm.cr=0
  );
/*
  for z in ( select c.contract_number, c.oper_type, c.date_in
               from cm_acc_request c
              where exists (select 1 from accounts where nls = c.contract_number and dazs is not null) )
  loop
     -- запоминаем сообщение
     update cm_acc_request
        set abs_status = 1,
            abs_msg = 'Рахунок закрито'
      where contract_number = z.contract_number
        and oper_type = z.oper_type
        and date_in = z.date_in;
  end loop;
*/
     -- запоминаем сообщение
     update cm_acc_request   set abs_status = 1,  abs_msg = 'Рахунок закрито'
     where contract_number in
  (
   select contract_number
    from 
      (
      select c.contract_number,
      (select count('x') from accounts acc where acc.nls = c.contract_number and acc.dazs is not null ) cr 
      from cm_acc_request c
      ) cm
      where cm.cr>0
  );
  bars_audit.info(h || 'Finish.');

end cm_process_request;

-------------------------------------------------------------------------------
-- cm_delete_request
-- процедура удаления запросов CardMake
--
procedure cm_delete_request ( p_opertype number, p_datein date, p_nls varchar2 )
is
  h varchar2(100) := 'bars_ow.cm_delete_request. ';
begin

  bars_audit.info(h || 'Start. p_opertype=>' || p_opertype || ' p_datein=>' || to_char(p_datein, 'dd.mm.yyyy hh24:mi:ss') || ' p_nls=>' || p_nls);

  -- меняем статус на "Видалено"
  update cm_acc_request
     set abs_status = 3
   where contract_number = p_nls
     and oper_type = p_opertype
     and date_in = p_datein;

  delete from cm_acc_request
   where contract_number = p_nls
     and oper_type = p_opertype
     and date_in = p_datein;

  bars_audit.info(h || 'Finish.');

end cm_delete_request;

-------------------------------------------------------------------------------
-- cm_salary_sync
-- процедура синхронизации З/П проектов CardMake
--
procedure cm_salary_sync (p_par number)
is
  type t_sender is record (mfo varchar2(6), nls varchar2(14));
  type t_sander_tab is table of t_sender;
  l_sender_tab   t_sander_tab;
  l_id           number;
  l_base_subcode w4_subproduct.code%type;
  l_base_subname w4_subproduct.name%type;
  l_subcode      w4_subproduct.code%type;
  l_subname      w4_subproduct.name%type;
  h varchar2(100) := 'bars_ow.cm_salary_sync. ';
begin

  bars_audit.info(h || 'Start.');

  -- 1. Добавление новых продуктов
  for z in ( select unique trim(replace(s.product_code, chr(9), '')) product_code, m.*
               from v_cm_salary s, w4_product_mask m
              where s.product_code like m.code
                and not exists ( select 1 from w4_product where code = trim(replace(s.product_code, chr(9), '')) ) )
  loop

     -- добавление в справочник w4_nbs_ob22
     begin
       insert into w4_nbs_ob22 (nbs, ob22, tip)
       values (z.nbs, z.ob22, z.tip);
     exception when dup_val_on_index then null;
     end;

     -- добавление в справчоник продуктов
     insert into w4_product (code, name, grp_code, kv, nbs, ob22, tip)
     values (z.product_code, replace(z.name, 'XXXXXXXX', z.product_code), z.grp_code, z.kv, z.nbs, z.ob22, z.tip);

  end loop;

  -- 2. Добавление новых карт
  for z in ( select unique trim(replace(c.card_code, chr(9), '')) card_code, trim(replace(s.product_code, chr(9), '')) product_code,
                    replace(trim(replace(c.card_code, chr(9), '')), trim(replace(s.product_code, chr(9), ''))||'_', '') sub_code
               from v_cm_salary s, cm_salary_card c
              where s.id = c.id
                and not exists ( select 1 from w4_card where code = trim(replace(c.card_code, chr(9), '')) ) )
  loop

     -- проверка: есть указанный субпродукт?
     begin

        select code into l_subcode from w4_subproduct where upper(code) = upper(z.sub_code);

     -- добавляем новый субпродукт
     -- пример:
     --   для продукта SAL_UAH_2_2_MGOLDDEB_15_3
     --   код субпродукта          MGOLDDEB_15_3
     --   код базового субпродукта MGoldDeb         Mastercard Debit Gold
     --   добавляем субпродукт     MGoldDeb_15_3     Mastercard Debit Gold 15,3 грн.
     exception when no_data_found then

        -- ищем базовый код субпродукта
        begin

           select code, name into l_base_subcode, l_base_subname
             from w4_subproduct
            where upper(substr(z.sub_code,1,instr(z.sub_code,'_')-1)) = upper(code);

           l_subcode := l_base_subcode || substr(z.sub_code,instr(z.sub_code,'_'));
           l_subname := l_base_subname || ' ' || replace(substr(z.sub_code,instr(z.sub_code,'_')+1),'_',',') || ' грн.';

           insert into w4_subproduct(code, name)
           values (l_subcode, l_subname);

        exception when no_data_found then

           l_subcode := null;

        end;

     end;

     -- добавляем новую карту
     if l_subcode is not null then

        insert into w4_card (code, product_code, sub_code)
        values (z.card_code, z.product_code, l_subcode);

     end if;

  end loop;

  -- 3. cm_salary
  -- изменение
  for z in ( select c.okpo, c.okpo_n, trim(replace(c.product_code, chr(9), '')) product_code
               from v_cm_salary c
              where exists ( select 1 from bpk_proect
                              where okpo = c.okpo and nvl(okpo_n,0) = nvl(c.okpo_n,0)
                                and ( product_code <> trim(replace(c.product_code, chr(9), '')) or nvl(used_w4,0) = 0 ) )
                 -- существующие продукты
                and exists ( select 1 from w4_product where code = trim(replace(c.product_code, chr(9), '')) ) )
  loop
     update bpk_proect
        set product_code = z.product_code,
            used_w4 = 1
      where okpo = z.okpo and nvl(okpo_n,0) = nvl(z.okpo_n,0);
  end loop;

  -- добавление
  for z in ( select c.okpo, c.okpo_n, trim(c.org_name) org_name, trim(replace(c.product_code, chr(9), '')) product_code, id id_cm
               from v_cm_salary c
              where not exists (select 1 from bpk_proect where okpo = c.okpo and nvl(okpo_n,0) = nvl(c.okpo_n,0) )
                 -- существующие продукты
                and exists ( select 1 from w4_product where code = trim(replace(c.product_code, chr(9), '')) ) )
  loop
     select min(id + 100) into l_id
       from bpk_proect b
      where not exists ( select id from bpk_proect where id = b.id + 100);
     insert into bpk_proect (id, name, okpo, okpo_n, product_code, used_w4,id_cm)
   values (l_id, z.org_name, z.okpo, z.okpo_n, z.product_code, 1,z.id_cm);
  end loop;

  -- удаление
  for z in ( select id from bpk_proect b
              where nvl(used_w4,0) = 1
                and not exists ( select 1 from v_cm_salary where okpo = b.okpo and nvl(okpo_n,0) = nvl(b.okpo_n,0) ) )
  loop
     update bpk_proect set used_w4 = 0 where id = z.id;
  end loop;

  -- 4. cm_salary_card
  delete from bpk_proect_card;
  insert into bpk_proect_card (okpo, okpo_n, card_code)
  select unique s.okpo, nvl(s.okpo_n,0), trim(replace(c.card_code, chr(9), ''))
    from v_cm_salary s, cm_salary_card c
   where s.id = c.id
      -- существующие карты
     and exists ( select 1 from w4_card where code = trim(replace(c.card_code, chr(9), '')) );

  -- 5. ow_iic_msgcode
  select unique s.org_mfo, s.org_nls
    bulk collect
    into l_sender_tab
    from cm_salary s
   where nvl(s.org_mfo, f_ourmfo) <> f_ourmfo
     and not exists ( select 1 from ow_iic_msgcode where mfoa = s.org_mfo and nlsa = s.org_nls );
  begin
     -- полный доступ
     bc.set_policy_group('WHOLE');
     for i in 1..l_sender_tab.count loop
      if ( l_sender_tab(i).mfo is not null and l_sender_tab(i).nls is not null) then --COBUMMFO-8964
        begin
           insert into ow_iic_msgcode (tt, mfoa, nlsa, msgcode)
           values ('R01', l_sender_tab(i).mfo, l_sender_tab(i).nls, 'PAYSAL');
        exception when dup_val_on_index then null;
        end;
       end if; 
     end loop;
     -- вернуться в свою область видимости
     bc.set_context();
  exception when others then
     -- вернуться в свою область видимости
     bc.set_context();
     raise_application_error(-20000,
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());
  end;

  bars_audit.info(h || 'Finish.');

end cm_salary_sync;

--W4_INSTANT_BATCHES
function create_instant_cards_batch(p_name        in varchar2,
                                    p_card_code   in varchar2,
                                    p_numbercards in number) return number is
  l_id number;
begin
  l_id := s_w4_instant_batches.nextval;
  insert into w4_instant_batches
    (id, name, card_code, numbercards, user_id)
  values
    (l_id, p_name, p_card_code, p_numbercards, user_id);
  return l_id;
end;

-------------------------------------------------------------------------------
-- create_instant_cards
-- процедура открытия карт Instant
--
procedure create_instant_cards (
  p_cardcode varchar2,
  p_branch   varchar2,
  p_cardnum  number )
is
  l_cmclient    cm_client_que%rowtype;
  l_rnk         number;
  l_nbs         varchar2(4);
  l_kv          number;
  l_tip         varchar2(3);
  l_clienttype  number;
  l_productcode w4_product.code%type;
  l_nls         accounts.nls%type;
  l_nms         accounts.nms%type;
  l_p4          number;
  l_acc         number;
  i number;
  l_batch       number;
  l_iscrm      varchar2(1) := nvl(sys_context('CLIENTCONTEXT','ISCRM'), '0');  
  h varchar2(100) := 'bars_ow.create_instant_cards. ';
begin

  bars_audit.info(h || 'Start. p_cardcode=>' || p_cardcode || ' p_branch=>' || p_branch || ' p_cardnum=>' || p_cardnum);

  begin
     select 1 into i from ow_params where par = 'RIICFDIR' for update skip locked;
  exception when no_data_found then
     bars_audit.info(h || 'Процедура виконується іншим користувачем');
     raise_application_error(-20000, 'Процедура виконується іншим користувачем!');
  end;

  l_rnk := getglobaloption('OUR_RNK');
  if l_rnk is null then
     bars_error.raise_nerror(g_modcode, 'PAR_RNK_NOT_FOUND');
  end if;

  begin
     select c.product_code, p.nbs, p.kv, p.tip, g.client_type
       into l_productcode, l_nbs, l_kv, l_tip, l_clienttype
       from w4_card c, w4_product p, w4_product_groups g
      where c.code = p_cardcode
        and c.product_code = p.code
        and p.grp_code = g.code;
  exception when no_data_found then
     -- Неизвестный тип карточки p_cardcode
     bars_error.raise_nerror(g_modcode, 'CARDCODE_NOT_FOUND', p_cardcode);
  end;

  l_batch := create_instant_cards_batch('INSTANT'||to_CHAR(sysdate,'hh24miss'),p_cardcode, p_cardnum);

  for z in ( select nls
               from ( select vkrzn(substr(gl.amfo,1,5), l_nbs || '0' || lpad(to_char(level), 9, '0')) nls
                        from dual
                     connect by level < 999999999
                    ) a
              where not exists (select 1 from accounts where nls=a.nls) and rownum <= p_cardnum )
  loop

     -- номер счета
     l_nls := z.nls;

     -- наименование счета
     l_nms := p_cardcode;

     -- открываем счет с пустым nbs
     op_reg_ex(99, 0, 0, null, l_p4, l_rnk,
        l_nls, l_kv, l_nms, l_tip, user_id, l_acc,
        null, 2, null, null, null, null, null, null, null, null, null, null,
        p_branch);

     -- закрываем счет, чтобы по нему ничего не платили (на всякий случай)
     update accounts set dazs = bankdate where acc = l_acc;

     -- добавляем счет в справочник карт Instant
     insert into w4_acc_instant (acc, card_code,batchid)
     values (l_acc, p_cardcode, l_batch);

     -- создаем запрос в CardMake

     l_cmclient.shortname       := null;
     l_cmclient.firstname       := null;
     l_cmclient.lastname        := null;
     l_cmclient.middlename      := null;
     l_cmclient.engfirstname    := l_nls;
     l_cmclient.englastname     := case when l_kv = 980 then 'UAH' when l_kv = 840 then 'USD' when l_kv = 978 then 'EUR' else '---' end;
     l_cmclient.country         := null;
     l_cmclient.resident        := null;
     l_cmclient.work            := null;
     l_cmclient.office          := null;
     l_cmclient.date_w          := null;
     l_cmclient.isvip           := null;
     l_cmclient.k060            := null;
     l_cmclient.companyname     := null;
     l_cmclient.shortcompanyname := null;
     l_cmclient.personalisationname := null;
     l_cmclient.klas_client_id  := null;
     l_cmclient.contactperson   := null;
     l_cmclient.birthdate       := null;
     l_cmclient.birthplace      := null;
     l_cmclient.gender          := null;
     l_cmclient.addr1_cityname  := null;
     l_cmclient.addr1_pcode     := null;
     l_cmclient.addr1_domain    := null;
     l_cmclient.addr1_region    := null;
     l_cmclient.addr1_street    := null;
     l_cmclient.addr2_cityname  := null;
     l_cmclient.addr2_pcode     := null;
     l_cmclient.addr2_domain    := null;
     l_cmclient.addr2_region    := null;
     l_cmclient.addr2_street    := null;
     l_cmclient.email           := null;
     l_cmclient.phonenumber     := null;
     l_cmclient.phonenumber_mob := null;
     l_cmclient.phonenumber_dod := null;
     l_cmclient.fax             := null;
     l_cmclient.typedoc         := null;
     l_cmclient.paspnum         := null;
     l_cmclient.paspseries      := null;
     l_cmclient.paspdate        := null;
     l_cmclient.paspissuer      := null;
     l_cmclient.foreignpaspnum     := null;
     l_cmclient.foreignpaspseries  := null;
     l_cmclient.foreignpaspdate    := null;
     l_cmclient.foreignpaspenddate := null;
     l_cmclient.foreignpaspissuer  := null;
     l_cmclient.cntm          := null;
     l_cmclient.pind          := null;
     l_cmclient.okpo_sysorg   := null;
     l_cmclient.kod_sysorg    := null;
     l_cmclient.cl_rnk        := null;
     l_cmclient.cl_dt_iss     := null;
     l_cmclient.card_br_iss   := null;
     l_cmclient.card_addr_iss := null;
     l_cmclient.delivery_br   := null;

     -- РНК «Instant» клиента в СМ ХХХХ00000000
     l_cmclient.regnumberclient := g_w4_branch || lpad('0',8,'0');
     l_cmclient.regnumberowner  := l_cmclient.regnumberclient;
     l_cmclient.rnk             := l_rnk;
     l_cmclient.acc             := l_acc;
     l_cmclient.contractnumber  := l_nls;
     l_cmclient.productcode     := l_productcode;
     l_cmclient.card_type       := p_cardcode;
     l_cmclient.datein          := sysdate;
     l_cmclient.datemod         := null;
     l_cmclient.oper_type       := 5;
     l_cmclient.oper_status     := 1;
     l_cmclient.resp_txt        := null;
     l_cmclient.branch          := nvl(g_cm_branch,p_branch);
     l_cmclient.opendate        := null;
     l_cmclient.clienttype      := 2;
     l_cmclient.taxpayeridentifier := null;
     l_cmclient.kf              := sys_context('bars_context','user_mfo');

     select bars_sqnc.get_nextval('S_CMCLIENT') into l_cmclient.id from dual;

     insert into cm_client_que values l_cmclient;
     if l_iscrm = '1' then
        update cm_client t
           set t.oper_status = 3,
               t.resp_txt    = 'Емуляція обробки заявки по запитам від CRM'
         where t.id = l_cmclient.id;
     end if;

  end loop;

  bars_audit.info(h || 'Finish.');

end create_instant_cards;

procedure create_instant_cards_m (
  p_cardcode    varchar2,
  p_delivery_br varchar2,
  p_cardnum     number )
is
  l_cmclient    cm_client_que%rowtype;
  l_rnk         number;
  l_nbs         varchar2(4);
  l_kv          number;
  l_tip         varchar2(3);
  l_clienttype  number;
  l_productcode w4_product.code%type;
  l_nls         accounts.nls%type;
  l_nms         accounts.nms%type;
  l_p4          number;
  l_acc         number;
  i             number;
  l_batch       number;
  l_opendate    date;
  l_iscrm      varchar2(1) := nvl(sys_context('CLIENTCONTEXT','ISCRM'), '0');  
  h varchar2(100) := 'bars_ow.create_instant_cards. ';
begin

  bars_audit.info(h || 'Start. p_cardcode=>' || p_cardcode || ' p_delivery_br=>' || p_delivery_br || ' p_cardnum=>' || p_cardnum);

  begin
     select 1 into i from ow_params where par = 'IICNUM' for update skip locked;
  exception when no_data_found then
     bars_audit.info(h || 'Процедура виконується іншим користувачем');
     raise_application_error(-20000, 'Процедура виконується іншим користувачем!');
  end;

  l_rnk := getglobaloption('OUR_RNK');
  if l_rnk is null then
     bars_error.raise_nerror(g_modcode, 'PAR_RNK_NOT_FOUND');
  end if;
  begin
    select t.date_on into l_opendate from customer t where t.rnk = l_rnk;
  exception
    when no_data_found then
      bars_audit.info(h || 'Не знайдено технічного клієнта з РНК '|| l_rnk);
      raise_application_error(-20000,
                              'Не знайдено технічного клієнта з РНК '|| l_rnk);
  end;
  begin
     select c.product_code, p.nbs, p.kv, p.tip, g.client_type
       into l_productcode, l_nbs, l_kv, l_tip, l_clienttype
       from w4_card c, w4_product p, w4_product_groups g
      where c.code = p_cardcode
        and c.product_code = p.code
        and p.grp_code = g.code;
  exception when no_data_found then
     -- Неизвестный тип карточки p_cardcode
     bars_error.raise_nerror(g_modcode, 'CARDCODE_NOT_FOUND', p_cardcode);
  end;


  l_batch := create_instant_cards_batch('INSTANT_MMSB'||to_CHAR(sysdate,'hh24miss'),p_cardcode, p_cardnum);

  for z in ( select nls
               from ( select vkrzn(substr(gl.amfo,1,5), l_nbs || '0' || lpad(to_char(level), 9, '0')) nls
                        from dual
                     connect by level < 999999999
                    ) a
              where not exists (select 1 from accounts where nls=a.nls) and rownum <= p_cardnum )
  loop

     -- номер счета
     l_nls := z.nls;

     -- наименование счета
     l_nms := p_cardcode;

     -- открываем счет с пустым nbs
     op_reg_ex(99, 0, 0, null, l_p4, l_rnk,
        l_nls, l_kv, l_nms, l_tip, user_id, l_acc,
        null, 2, null, null, null, null, null, 26, null, null, null, null,
        '/'||f_ourmfo||'/');

     -- закрываем счет, чтобы по нему ничего не платили (на всякий случай)
     update accounts set dazs = bankdate where acc = l_acc;

     -- добавляем счет в справочник карт Instant
     insert into w4_acc_instant (acc, card_code,batchid)
     values (l_acc, p_cardcode, l_batch);

     -- создаем запрос в CardMake

     l_cmclient.shortname       := 'CORPINSTANT';
     l_cmclient.firstname       := null;
     l_cmclient.lastname        := null;
     l_cmclient.middlename      := null;
     l_cmclient.engfirstname    := l_nls;
     l_cmclient.englastname     := case when l_kv = 980 then 'UAH' when l_kv = 840 then 'USD' when l_kv = 978 then 'EUR' else '---' end;
     l_cmclient.country         := null;
     l_cmclient.resident        := null;
     l_cmclient.work            := null;
     l_cmclient.office          := null;
     l_cmclient.date_w          := null;
     l_cmclient.isvip           := null;
     l_cmclient.k060            := null;
     l_cmclient.companyname     := null;
     l_cmclient.shortcompanyname := null;
     l_cmclient.personalisationname := null;
     l_cmclient.klas_client_id  := null;
     l_cmclient.contactperson   := null;
     l_cmclient.birthdate       := null;
     l_cmclient.birthplace      := null;
     l_cmclient.gender          := null;
     l_cmclient.addr1_cityname  := null;
     l_cmclient.addr1_pcode     := null;
     l_cmclient.addr1_domain    := null;
     l_cmclient.addr1_region    := null;
     l_cmclient.addr1_street    := null;
     l_cmclient.addr2_cityname  := null;
     l_cmclient.addr2_pcode     := null;
     l_cmclient.addr2_domain    := null;
     l_cmclient.addr2_region    := null;
     l_cmclient.addr2_street    := null;
     l_cmclient.email           := null;
     l_cmclient.phonenumber     := null;
     l_cmclient.phonenumber_mob := null;
     l_cmclient.phonenumber_dod := null;
     l_cmclient.fax             := null;
     l_cmclient.typedoc         := null;
     l_cmclient.paspnum         := null;
     l_cmclient.paspseries      := null;
     l_cmclient.paspdate        := null;
     l_cmclient.paspissuer      := null;
     l_cmclient.foreignpaspnum     := null;
     l_cmclient.foreignpaspseries  := null;
     l_cmclient.foreignpaspdate    := null;
     l_cmclient.foreignpaspenddate := null;
     l_cmclient.foreignpaspissuer  := null;
     l_cmclient.pind          := null;
     l_cmclient.okpo_sysorg   := null;
     l_cmclient.kod_sysorg    := null;
     l_cmclient.cl_rnk        := null;
     l_cmclient.cl_dt_iss     := null;
     l_cmclient.card_br_iss   := null;
     l_cmclient.card_addr_iss := null;
     l_cmclient.delivery_br   :=nvl(p_delivery_br, '/'||f_ourmfo||'/');

     -- РНК «Instant» клиента в СМ ХХХХC0000000
     l_cmclient.regnumberclient := g_w4_branch || 'C' ||lpad('0',7,'0');
     l_cmclient.regnumberowner  := l_cmclient.regnumberclient;
     l_cmclient.rnk             := l_rnk;
     l_cmclient.acc             := l_acc;
     l_cmclient.contractnumber  := l_nls;
     l_cmclient.productcode     := l_productcode;
     l_cmclient.card_type       := p_cardcode;
     l_cmclient.datein          := sysdate;
     l_cmclient.datemod         := null;
     l_cmclient.oper_type       := 11;
     l_cmclient.oper_status     := 1;
     l_cmclient.resp_txt        := null;
     l_cmclient.branch          := '/'||f_ourmfo||'/';
     l_cmclient.opendate        := l_opendate;
     l_cmclient.clienttype      := 1;
     l_cmclient.taxpayeridentifier := null;
     l_cmclient.kf              := sys_context('bars_context','user_mfo');
     l_cmclient.cntm            := 24;

     select bars_sqnc.get_nextval('S_CMCLIENT') into l_cmclient.id from dual;

     insert into cm_client_que values l_cmclient;

     if l_iscrm = '1' then
        update cm_client t
           set t.oper_status = 3,
               t.resp_txt    = 'Емуляція обробки заявки по запитам від CRM'
         where t.id = l_cmclient.id;
     end if;
     
  end loop;

  bars_audit.info(h || 'Finish.');

end;
-------------------------------------------------------------------------------
-- set_idat
-- процедура установки параметра "Дата выдачи карты"
--
procedure set_idat ( p_nd number, p_dat date )
is
  l_tag varchar2(8) := 'PK_IDAT';
  l_acc number;
  i     number;
begin
  -- ищем договор
  begin
     select acc_pk into l_acc from w4_acc where nd = p_nd;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_nd));
  end;
  -- проверка: дата установлена?
  begin
     select 1 into i from accountsw where acc = l_acc and tag = l_tag;
     -- дата установлена, ничего не делаем - менять ее запрещено
  exception when no_data_found then
     -- дата не установлена, устанавливаем
     accreg.setAccountwParam(l_acc, l_tag, to_char(p_dat,'dd.mm.yyyy'));
  end;
end set_idat;

-------------------------------------------------------------------------------
-- search_acc
-- Функция поиска счета
--
function search_acc (
  p_mode varchar2,
  p_rnk  accounts.rnk%type,
  p_nls  accounts.nls%type,
  p_kv   accounts.kv%type ) return number
is
  l_acc  accounts.acc%type;
  l_nbs  accounts.nbs%type;
  l_rnk  accounts.rnk%type;
begin

  if p_rnk is not null and p_nls is not null and p_kv is not null then

     -- поиск счета
     begin
        select acc, nbs, rnk into l_acc, l_nbs, l_rnk
          from accounts
         where nls = p_nls and kv = p_kv;
     exception when no_data_found then
        -- Счет не найден
        bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', p_nls, p_kv);
     end;

     -- проверка на БС
     if p_mode = 'OVR' and l_nbs not like '2%' then
        -- Неверно указан БС для кредитного счета
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_OVR', p_nls);
     elsif p_mode = '9129' and l_nbs <> '9129' then
        -- Неверно указан БС для счета неисп. лимита
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_9129', p_nls);
     elsif p_mode = '3570' and l_nbs <> '3570' then
        -- Неверно указан БС для счета комиссии
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_3570', p_nls);
     elsif p_mode = '2208' and l_nbs not like '2__8' then
        -- Неверно указан БС для счета
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_2208', p_nls);
     elsif p_mode = '2207' and l_nbs not like '2__7' then
        -- Неверно указан БС для счета
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_DEBT', p_nls);
     elsif p_mode = '3579' and l_nbs <> '3579' then
        -- Неверно указан БС для счета
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_DEBT', p_nls);
     elsif p_mode = '2209' and l_nbs not like '2__9' then
        -- Неверно указан БС для счета
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_DEBT', p_nls);
     end if;

     -- проверка, на какого клиента зарегистрирован счет
     if p_rnk <> l_rnk then
        -- Счет зарегистрирован на другого клиента
        bars_error.raise_nerror(g_modcode, 'ACC_REG_RNK', p_nls, p_kv, l_rnk);
     end if;

  else

     l_acc := null;

  end if;

  return l_acc;

end search_acc;

-------------------------------------------------------------------------------
-- set_w4_acc
-- процедура привязки счетов БПК
--
procedure set_w4_acc (
  p_acc_pk    accounts.acc%type,
  p_nls_ovr   accounts.nls%type,
  p_nls_9129  accounts.nls%type,
  p_nls_2208  accounts.nls%type,
  p_nls_3570  accounts.nls%type,
  p_nls_2207  accounts.nls%type,
  p_nls_2209  accounts.nls%type,
  p_nls_3579  accounts.nls%type )
is
  l_kv        accounts.kv%type;
  l_rnk       accounts.rnk%type;
  l_acc_ovr   accounts.acc%type;
  l_acc_9129  accounts.acc%type;
  l_acc_2208  accounts.acc%type;
  l_acc_3570  accounts.acc%type;
  l_acc_2207  accounts.acc%type;
  l_acc_2209  accounts.acc%type;
  l_acc_3579  accounts.acc%type;
begin

  if p_acc_pk is not null then

     begin

        select kv, rnk into l_kv, l_rnk
          from accounts
         where acc = p_acc_pk;

        l_acc_ovr  := search_acc('OVR',  l_rnk, p_nls_ovr,  l_kv);
        l_acc_9129 := search_acc('9129', l_rnk, p_nls_9129, l_kv);
        l_acc_2208 := search_acc('2208', l_rnk, p_nls_2208, l_kv);
        l_acc_3570 := search_acc('3570', l_rnk, p_nls_3570, l_kv);
        l_acc_2207 := search_acc('2207', l_rnk, p_nls_2207, l_kv);
        l_acc_2209 := search_acc('2209', l_rnk, p_nls_2209, l_kv);
        l_acc_3579 := search_acc('3579', l_rnk, p_nls_3579, l_kv);

        update w4_acc
           set acc_ovr  = l_acc_ovr,
               acc_9129 = l_acc_9129,
               acc_2208 = l_acc_2208,
               acc_3570 = l_acc_3570,
               acc_2207 = l_acc_2207,
               acc_2209 = l_acc_2209,
               acc_3579 = l_acc_3579
         where acc_pk = p_acc_pk;

     exception when no_data_found then null;
     end;

  end if;

end set_w4_acc;

-------------------------------------------------------------------------------
-- get_nd_param
-- функция возвращает значение параметра договора
--
function get_nd_param (p_nd number, p_tag varchar2) return varchar2
is
  l_value bpk_parameters.value%type;
begin
  begin
     select trim(value) into l_value
       from bpk_parameters
      where nd  = p_nd
        and tag = p_tag;
  exception when no_data_found then l_value := null;
  end;
  return l_value;
end get_nd_param;

-------------------------------------------------------------------------------
-- get_nd_param_indate
-- функция возвращает значение параметра договора (дата)
--
function get_nd_param_indate (p_nd number, p_tag varchar2) return date
is
  l_value date := null;
begin
  begin
     l_value := to_date(get_nd_param(p_nd, p_tag), 'dd/mm/yyyy');
  exception when others then
     l_value := null;
  end;
  return l_value;
end get_nd_param_indate;

-------------------------------------------------------------------------------
-- get_nd_param_innumber
-- функция возвращает значение параметра договора (число)
--
function get_nd_param_innumber (p_nd number, p_tag varchar2) return number
is
  l_value number := null;
begin
  begin
     l_value := to_number(get_nd_param(p_nd, p_tag));
  exception when others then
     l_value := null;
  end;
  return l_value;
end get_nd_param_innumber;

-------------------------------------------------------------------------------
-- set_nd_param
-- Процедура установки параметра договора
--
procedure set_nd_param (p_nd number, p_tag varchar2, p_value varchar2)
is
begin
  insert into bpk_parameters (nd, tag, value)
  values (p_nd, p_tag, p_value);
exception when dup_val_on_index then
  update bpk_parameters
     set value = p_value
   where nd  = p_nd
     and tag = p_tag;
end set_nd_param;

-------------------------------------------------------------------------------
-- set_nd_param_indate
-- Процедура установки параметра договора (дата)
--
procedure set_nd_param_indate (p_nd number, p_tag varchar2, p_value date)is
begin
  set_nd_param(p_nd, p_tag, to_char(p_value, 'dd/mm/yyyy'));
end set_nd_param_indate;

-------------------------------------------------------------------------------
-- set_nd_param_innumber
-- Процедура установки параметра договора (число)
--
procedure set_nd_param_innumber (p_nd number, p_tag varchar2, p_value number)is
begin
  set_nd_param(p_nd, p_tag, to_char(p_value));
end set_nd_param_innumber;

-------------------------------------------------------------------------------
-- set_msgcode_payaccad
-- Процедура установки/снятия флага "Ознака адресноі виплати" для документов, пришедших по системе "Клиент банк".
-- Устанавливается/удаляется доп.реквизит документа W4MSG "Way4. Код транзакції"
--
procedure set_msgcode_payaccad (p_ref number, p_flag number)
is
begin
  set_operw(p_ref, 'W4MSG', case when p_flag=1 then 'PAYACCAD' else null end);
end set_msgcode_payaccad;

-------------------------------------------------------------------------------
-- set_pass_date
--
procedure set_pass_date (
  p_nd         number,
  p_pass_date  date,
  p_pass_state number )
is
begin
  update w4_acc
     set pass_date  = p_pass_date,
         pass_state = p_pass_state
   where nd = p_nd;
end set_pass_date;
procedure create_dop_kk (p_nd number, p_cardcode varchar2)
is
begin
  add_deal_to_cmque(p_nd, 2);
  update cm_client_que
     set card_type = replace(replace(case substr(p_cardcode, -4)
                                       when '_DOP' then
                                        p_cardcode
                                       else
                                        p_cardcode || '_DOP'
                                     end,
                                     'VCUKK_0',
                                     'VCUKK'),
                             'MDUKK_0',
                             'MDUKK')
   where acc = (select acc_pk from w4_acc where nd = p_nd) and
         oper_type = 2 and oper_status = 1;
end create_dop_kk;

procedure check_dop_kk (p_nd in number, p_msg out varchar2)
is
  l_acc_pk       number;
  l_dat_end      date;
  l_product_code w4_product.code%type;
  l_grp_code     w4_product_groups.code%type;
  l_grp_name     w4_product_groups.name%type;
  l_sub_name     w4_subproduct.name%type;
  l_cardcode     w4_card.code%type;
  l_rnk          number;
  l_kv           accounts.kv%type;
  i number;
begin
  begin
     select o.acc_pk, o.dat_end, p.code, g.code, g.name, s.name, a.rnk, c.code, a.kv
       into l_acc_pk, l_dat_end, l_product_code, l_grp_code, l_grp_name, l_sub_name, l_rnk, l_cardcode, l_kv
       from w4_acc o, w4_card c, w4_product p, w4_product_groups g, w4_subproduct s, accounts a
      where o.nd = p_nd
        and o.card_code = c.code
        and c.product_code = p.code
        and p.grp_code = g.code
        and c.sub_code = s.code
        and o.acc_pk = a.acc;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_nd));
  end;

  p_msg := null;

  select count(*) into i
    from cm_client_que_arc c, accounts a
   where c.rnk = l_rnk and c.kk_flag = 1 and c.oper_status in (3)
     and c.acc = a.acc and c.oper_type in(1, 2, 5) and a.dazs is null;
  if i > 0 then
     p_msg := 'Клієнту РНК ' || to_char(l_rnk) || ' вже відкрито Картку киянина';
  end if;

  if p_msg is null then
     select count(*) into i
       from cm_client_que c, accounts a
      where c.rnk = l_rnk and c.kk_flag = 1 and c.oper_status <> 10
        and c.acc = a.acc and c.oper_type in(1, 2, 5) and a.dazs is null;
     if i > 0 then
        p_msg := 'По клієнту РНК ' || to_char(l_rnk) || ' вже сформовано заявку на відкриття Картки киянина';
     end if;
  end if;

  if l_kv <> 980 then
   p_msg := 'Заборонено відкриття додаткової картки КК для Картки в валюті "' || l_kv || '"';
  end if;

  if p_msg is null then
     if l_grp_code not in ('SALARY'/*, 'STANDARD'*/) then -- Гуренко Володимир added a comment - 18/Sep/15 10:30 AM
                                                         -- Картка Киянина в пакеті «Стандартний» може випускатись лише, як основна БПК.
                                                         -- Додаткова БПК до Картки Киянина в пакеті «Стандартний» не випускається.
        p_msg := 'Заборонено відкриття додаткової Картки КК за тарифним пакетом "' || l_grp_name || '"';
     end if;
  end if;

  if p_msg is null then
     if    (lower(l_sub_name) not like lower('%Gold%')
        and lower(l_sub_name) not like lower('%World%')
        and lower(l_sub_name) not like lower('%Platinum%')
        and lower(l_sub_name) not like lower('%World Elite%')
        and lower(l_sub_name) not like lower('%Infinite%')
        and lower(l_sub_name) not like lower('%Visa Classic%')
        and lower(l_sub_name) not like lower('%MasterCard Debit Standard%')
        )
     then
        p_msg := 'Заборонено відкриття додаткової Картки КК до рахунку з основною карткою класом нижче, ніж Visa Classic та MasterCard Debit Standard';
     end if;
  end if;

  if p_msg is null then
     if ( lower(l_sub_name) like lower('%Gold%')
       or lower(l_sub_name) like lower('%World%')
       or lower(l_sub_name) like lower('%Platinum%')
       or lower(l_sub_name) like lower('%World Elite%')
       or lower(l_sub_name) like lower('%Infinite%') ) then
        if months_between(l_dat_end, bankdate) < 2 then
           p_msg := 'Строк дії основної картки менший ніж 2 міс. Необхідно перевипустити основну картку!';
        end if;
     elsif months_between(l_dat_end, bankdate) < 12 then
        p_msg := 'Строк дії основної Картки менший ніж 1 рік. Необхідно перевипустити основну картку!';
     end if;
  end if;

end check_dop_kk;

-- Проверяем возможность выпуска карты школьника
procedure check_ad_pupil_card(p_nd        in number,
                               p_pupil_rnk in number,
                               p_msg       out varchar2) is
  l_acc_pk       number;
  l_dat_end      date;
  l_product_code w4_product.code%type;
  l_grp_code     w4_product_groups.code%type;
  l_grp_name     w4_product_groups.name%type;
  l_sub_name     w4_subproduct.name%type;
  l_cardcode     w4_card.code%type;
  l_rnk          number;
  l_kv           accounts.kv%type;
  l_flag_kk      w4_subproduct.flag_kk%type;
  l_tmp          number;
  l_tmp1         number;
begin
  begin
    select o.acc_pk, o.dat_end, p.code, g.code, g.name, s.name, a.rnk,
           c.code, a.kv, s.flag_kk
      into l_acc_pk, l_dat_end, l_product_code, l_grp_code, l_grp_name,
           l_sub_name, l_rnk, l_cardcode, l_kv, l_flag_kk
      from w4_acc o, w4_card c, w4_product p, w4_product_groups g,
           w4_subproduct s, accounts a
     where o.nd = p_nd and o.card_code = c.code and c.product_code = p.code and
           p.grp_code = g.code and c.sub_code = s.code and o.acc_pk = a.acc;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_nd));
  end;

  p_msg := null;

  if l_flag_kk <> 1 then
    p_msg := 'Основна картка не являється Картою киянина';
  end if;

  if p_msg is null then
    select nvl(sum(decode(c.oper_type, 1, 1, 5, 1, 0)), 0) c_main,
           nvl(sum(decode(c.oper_type, 2, 1, 0)), 0) c_add
      into l_tmp, l_tmp1
      from cm_client_que_arc c, accounts a
     where c.rnk = l_rnk and c.kk_flag = 1 and c.oper_status in (3) and
           c.acc = a.acc and c.oper_type in (1, 2, 5) and a.dazs is null;
    if l_tmp = 0 then
      p_msg := 'Для відкриття картки школяра клієнту ' || to_char(l_rnk) || case
                 when l_tmp1 = 0 then
                  ' необхідно відкрити Картку киянина'
                 else
                  ' необхідно відкрити Картку киянина, як основну'
               end;
    end if;
  end if;

  if p_msg is null then
    select count(*)
      into l_tmp
      from cm_client_que_arc c, accounts a
     where c.rnk = p_pupil_rnk and c.kk_flag = 2 and c.oper_status in (3) and
           c.acc = a.acc and c.oper_type = 2 and a.dazs is null;
    if l_tmp > 0 then
      p_msg := 'По клієнту РНК ' || to_char(p_pupil_rnk) ||' вже відкрито Картку школяра';
    end if;
  end if;

  if p_msg is null then
    select count(*)
      into l_tmp
      from cm_client_que c, accounts a
     where c.rnk = p_pupil_rnk and c.kk_flag = 2 and c.oper_status <> 10 and
           c.acc = a.acc and c.oper_type = 2 and a.dazs is null;
    if l_tmp > 0 then
      p_msg := 'По клієнту РНК ' || to_char(p_pupil_rnk) || ' вже сформовано заявку на відкриття Картки школяра';
    end if;
  end if;

  if p_msg is null then
    if (lower(l_sub_name) like lower('%Gold%') or
       lower(l_sub_name) like lower('%World%') or
       lower(l_sub_name) like lower('%Platinum%') or
       lower(l_sub_name) like lower('%World Elite%') or
       lower(l_sub_name) like lower('%Infinite%')) then
      if months_between(l_dat_end, bankdate) < 2 then
        p_msg := 'Строк дії основної картки менший ніж 2 міс. Необхідно перевипустити основну картку!';
      end if;
    elsif months_between(l_dat_end, bankdate) < 12 then
      p_msg := 'Строк дії основної картки менший ніж 1 рік. Необхідно перевипустити основну картку!';
    end if;
  end if;

end check_ad_pupil_card;

procedure create_ad_pupil_card(p_nd        in number,
                               p_pupil_rnk in number,
                               p_cardcode  in varchar2,
                               p_term      in number) is
begin
  add_deal_to_cmque(p_nd        => p_nd,
                    p_opertype  => 2,
                    p_ad_rnk    => p_pupil_rnk,
                    p_card_type => p_cardcode,
                    p_cntm      => p_term);
end create_ad_pupil_card;

procedure create_key(p_key_value  in varchar2,
                      p_start_date in date,
                     p_end_date   in date) is
  l_h varchar2(100) := 'bars_ow.create_sign. ';
  l_start_date date := p_start_date;
  l_key_id number;
  l_count pls_integer;
begin
  crypto_utl.create_key(p_key_value  => p_key_value,
                        p_start_date => p_start_date,
                        p_end_date   => p_end_date,
                        p_code       => g_keytype);
end;

procedure edit_key (p_key_id in number, p_end_date in date)
is
begin
  crypto_utl.edit_key(p_key_id => p_key_id, p_end_date => p_end_date);
end;

procedure disable_key(p_key_id in number) is
begin
  crypto_utl.disable_key(p_key_id => p_key_id);

end;

procedure reverse_locpay(p_ref in number)

is
  l_p1 number;
  l_p2 varchar2(4000);
  l_operw_tbl_old t_operw := t_operw();
  l_operw_tbl_new t_operw := t_operw();
  l_oper oper%rowtype;
  l_nlsb accounts.nls%type;
  l_nazn varchar2(160);
  l_ref oper.ref%type;
  l_newnb t_newnb;
begin
 -- запоминаем реквизиты по старой операции
  select *
    bulk collect into l_operw_tbl_old
    from operw tt
   where tt.ref = p_ref;
 --запоминаем
  select * into l_oper from oper where ref = p_ref;

  savepoint sp_op;
  p_back_dok(p_ref, 5, null, l_p1, l_p2);
            l_nazn := substr('Перевищено ліміт', 1, 160);
  if newnbs.g_state = 1 then
     l_newnb :=  get_new_nbs_ob22('2909', '80');
     l_nlsb := nbs_ob22 (l_newnb.nbs, l_newnb.ob22);
  else
     l_nlsb := nbs_ob22 ('2909','80');
  end if;
  ipay_doc ('OW7', l_oper.vob, 1, l_oper.sk,
     l_oper.nam_a, l_oper.nlsa, null, l_oper.id_a,
     l_oper.nam_b, l_nlsb, null, l_oper.id_b,
     l_oper.kv, l_oper.s, l_oper.kv, l_oper.s, l_nazn, l_ref, 2);
  for i in l_operw_tbl_old.first .. l_operw_tbl_old.last
  loop
     fill_operw_tbl(l_operw_tbl_new, l_ref, l_operw_tbl_old(i).tag,l_operw_tbl_old(i).value);
  end loop;

  forall i in 1 .. l_operw_tbl_new.count
     insert into operw values l_operw_tbl_new(i);

  update ow_locpay_match t
     set t.ref         = l_ref,
         t.state       = 0,
         t.revflag     = 1,
         t.rev_message = l_nazn
   where t.ref = p_ref;

exception
  when others then
    rollback to sp_op;
    raise_application_error(-20000, 'Помилка при добавленні платежа в файл реверсала: ' || sqlerrm);
end;

procedure add_sep_rev_to_queue is
  l_reflist       number_list;
  l_operw_tbl_old t_operw := t_operw();
  l_operw_tbl_new t_operw := t_operw();
  l_oper          oper%rowtype;
  l_nlsb          accounts.nls%type;
  l_nazn          varchar2(160);
  l_ref           oper.ref%type;
  l_newnb         t_newnb;
  h               varchar2(100) := 'bars_ow.add_sep_rev_to_queue';
begin
  bars_audit.info(h || 'Start.');

  for idx in (select o.ref
                from oper o
                join ow_locpay_match om
                  on o.ref = om.ref and om.state = 0 and om.revflag = 0
               where o.tt in ('OW6', 'WO6', 'OW5', 'WO5') and
                     o.sos in (-1, -2) and o.pdat >= trunc(sysdate))
  loop
    begin
      -- запоминаем реквизиты по старой операции
      select *
        bulk collect
        into l_operw_tbl_old
        from operw tt
       where tt.ref = idx.ref;
      --запоминаем
      select * into l_oper from oper where ref = idx.ref;
      savepoint sp_op;
      l_nazn := substr('Сторно платежу', 1, 160);
      if newnbs.g_state = 1 then
         l_newnb :=  get_new_nbs_ob22('2909', '80');
         l_nlsb := nbs_ob22 (l_newnb.nbs, l_newnb.ob22);
      else
         l_nlsb := nbs_ob22 ('2909','80');
      end if;

      ipay_doc('OW7', l_oper.vob, 1, l_oper.sk, l_oper.nam_a, l_oper.nlsa,
               null, l_oper.id_a, l_oper.nam_b, l_nlsb, null, l_oper.id_b,
               l_oper.kv, l_oper.s, l_oper.kv, l_oper.s, l_nazn, l_ref,
               2);

      for i in l_operw_tbl_old.first .. l_operw_tbl_old.last
      loop
        fill_operw_tbl(l_operw_tbl_new,
                       l_ref,
                       l_operw_tbl_old(i).tag,
                       l_operw_tbl_old(i).value);
      end loop;

      forall i in 1 .. l_operw_tbl_new.count
        insert into operw values l_operw_tbl_new (i);

      update ow_locpay_match t
         set t.ref         = l_ref,
             t.state       = 0,
             t.revflag     = 2,
             t.rev_message = l_nazn
       where t.ref = idx.ref;
    exception
      when others then
        rollback to sp_op;
        bars_audit.info(h || 'Err: Ref =' || idx.ref || ' ' ||
                        dbms_utility.format_error_stack() || chr(10) ||
                        dbms_utility.format_error_backtrace());
    end;
  end loop;
    bars_audit.info(h || 'Finish.');
end;

procedure web_import_files(p_filename varchar2,
                           p_filebody blob,
                           p_fileid   out number,
                                 p_msg out varchar2) is
  l_id number := null;
  l_msg varchar2(4000);
  h    varchar2(100) := 'bars_ow.web_import_files. ';
begin

  bars_audit.info(h || 'Start.');

  load_file(p_filename => p_filename,
            p_filebody => p_filebody,
            p_origin   => 1,
            p_id       => l_id,
            p_msg      => l_msg);

  p_fileid := l_id;
  p_msg := l_msg;
  bars_audit.info(h || 'Finish.' || 'p_msg=>' || l_msg);

end;

-- Підтвердження активації рахунку ЮО
procedure confirm_acc(p_acc     in number_list,
                      p_confirm in number) is

  l_row w4_acc_instant%rowtype;
  l_nd  w4_acc.nd%type;
  l_rnk customer.rnk%type;
  l_cardcode w4_acc.card_code%type;
  l_product t_product;
  l_term number;
  ora_lock exception;
  pragma exception_init(ora_lock, -54);
begin
  if p_acc.count > 0 then
    for i in p_acc.first .. p_acc.last
    loop
      l_row := null;
      begin
        select *
          into l_row
          from w4_acc_instant t
         where t.acc = p_acc(i)
           for update nowait;
      exception
        when ora_lock then
          raise_application_error(-20000,
                                  'Рахунок ACC: ' || p_acc(i) ||
                                  ' заблоковано іншим користувачем ' ||
                                  sqlerrm);
      end;

      select w.nd, w.card_code into l_nd, l_cardcode from w4_acc w where w.acc_pk = p_acc(i);

      -- Відхилення підтвердження
      if p_confirm = 0 then
        l_rnk := getglobaloption('OUR_RNK');
        if l_rnk is null then
          bars_error.raise_nerror(g_modcode, 'PAR_RNK_NOT_FOUND');
        end if;
        delete from cm_client_que t where t.id = l_row.reqid;
        delete from bpk_parameters b where b.nd = l_nd;
        delete from w4_acc w where w.nd = l_nd;
        delete from w4_acc_instant wa where wa.acc = p_acc(i);

        update accounts t set t.rnk = l_rnk where t.acc = p_acc(i);
        --Підтвердження
      elsif p_confirm = 1 then
        iget_product(l_cardcode, l_term, l_product);
            -- привязываем счет к клиенту
        update accounts
           set nbs = case when l_product.nbs = substr(nls, 1, 4) then l_product.nbs else substr(nls, 1, 4) end,
               tip = l_product.tip,
               daos = decode(dapp,null,bankdate, daos),
               dazs = null
         where acc = p_acc(i);

        -- доступ к счету
        p_after_open_acc(p_acc(i));

        -- удаляем счет из справочника счетов Instant после привязки
        update w4_acc_instant
           set state  = 2
         where acc = p_acc(i);

      end if;
      insert into w4_conf_acc_stat
        (acc, state)
      values
        (p_acc(i), p_confirm);
    end loop;
  end if;
end;

procedure web_out_files(p_mode in number,
                        p_filename out varchar2,
                        p_filebody out clob,
                        p_msg out varchar2
                        ) is
  l_id number := null;
  l_msg varchar2(4000);
  h    varchar2(100) := 'bars_ow.web_out_files. ';
begin

  bars_audit.info(h || 'Start.');

  execute immediate 'alter session set  NLS_NUMERIC_CHARACTERS=''.,''';
  get_iicfilebody (p_mode, p_filename, p_filebody);

  bars_audit.info(h || 'Finish.' || 'p_msg=>' || l_msg);

end;

begin
  ow_init;
end;
/
 show err;
 
PROMPT *** Create  grants  BARS_OW ***
grant EXECUTE                                                                on BARS_OW         to ABS_ADMIN;
grant EXECUTE                                                                on BARS_OW         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_OW         to OW;
grant EXECUTE                                                                on BARS_OW         to TECH005;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_ow.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 
