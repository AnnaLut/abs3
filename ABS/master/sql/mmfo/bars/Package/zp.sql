PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/package/zp.sql =========*** Run *** 
PROMPT ===================================================================================== 

create or replace package bars.zp is
  g_head_version  constant varchar2(64)  := 'version 1.21 01.08.2018';

  --
  -- определение версии заголовка пакета
  --
  function header_version return varchar2;
  --
  -- определение версии тела пакета
  --
  function body_version   return varchar2;

  procedure send_central ;
  procedure create_deal(p_rnk            customer.rnk%type,
                      p_deal_name      zp_deals.deal_name%type,
                      p_start_date     date,
                      p_deal_premium   zp_deals.deal_premium%type,
                      p_central        zp_deals.central%type,
                      p_kod_tarif      zp_deals.kod_tarif%type,
                      p_acc            number   default null,
                      p_fs             zp_deals.fs%type default 2,
                      p_branch         branch.branch%type default null
                      );

  procedure approve_deal(p_id zp_deals.id%type, p_comm_reject zp_deals.comm_reject%type);

  procedure update_deal(p_id             zp_deals.id%type,
                      p_deal_name      zp_deals.deal_name%type,
                      p_start_date     date,
                      p_deal_premium   zp_deals.deal_premium%type,
                      p_central        zp_deals.central%type,
                      p_kod_tarif      zp_deals.kod_tarif%type,
                      p_fs             zp_deals.fs%type default 1,
                      p_acc_3570       zp_deals.acc_3570%type default null,
                      p_branch         branch.branch%type default null
                      );
  procedure del_deal(p_id  zp_deals.id%type );
  procedure authorize_deal(p_id  zp_deals.id%type );
  procedure reject_deal(p_id  zp_deals.id%type, p_comm_reject zp_deals.comm_reject%type );
  procedure zp_acc_migr(p_id zp_deals.id%type) ;
  procedure set_acc_sos (p_acc accounts.acc%type, p_sost number);
  procedure close_deal(p_id  zp_deals.id%type , p_comm zp_deals.comm_reject%type );
  procedure change_ref_zp_tarif(p_kod zp_tarif.kod%type, p_kv zp_tarif.kv%type, p_type number);
  procedure additional_change_deal(p_id  zp_deals.id%type , p_comm zp_deals.comm_reject%type );
  procedure create_payroll_draft ( p_zp_id zp_deals.id%type, p_id out zp_payroll.id%type);
  procedure del_zp_payroll(p_id zp_payroll.id%type);
procedure approve_payroll(p_sign_doc_set t_sign_doc_set,p_id zp_payroll.id%type);
procedure add_payroll_doc(p_id_pr        zp_payroll.id%type,
                          p_okpob        zp_payroll_doc.okpob%type,
                          p_namb         zp_payroll_doc.namb%type,
                          p_mfob         zp_payroll_doc.mfob%type,
                          p_nlsb         zp_payroll_doc.nlsb%type,
                          p_source       zp_payroll_doc.source%type,
                          p_nazn         zp_payroll_doc.nazn%type,
                          p_s            zp_payroll_doc.s%type,
                          p_id           zp_payroll_doc.id%type           default null,
                          p_id_file      zp_payroll_doc.id_file%type      default null,
                          p_passp_serial zp_payroll_doc.passp_serial%type default null,
                          p_passp_num    zp_payroll_doc.passp_num%type    default null,
                          p_id_card_num  varchar2                         default null -- Паспорт гр.України у вигляді картки (поки не використовується)
                          );
 procedure del_payroll_doc(p_id  zp_payroll_doc.id%type);
 procedure create_payroll (p_id          zp_payroll.id%type,
                          p_pr_date     zp_payroll.pr_date%type,
                          p_payroll_num zp_payroll.payroll_num%type,
                          p_nazn        zp_payroll.nazn%type
                          );
procedure payroll_doc_clone(p_old_id number,p_new_id number);
procedure reject_payroll(p_id zp_payroll.id%type, p_comm  zp_payroll.comm_reject%type);
procedure pay3570 (p_acc accounts.acc%type);
procedure pay_payroll(p_id       zp_payroll.id%type,
                      p_sign     zp_payroll.sign%type,
                      p_key_id   zp_payroll.key_id%type,
                      p_docbufer varchar2);
procedure payroll_imp(p_id_pr            zp_payroll.id%type,
                      p_file_name        zp_payroll_imp_files.file_name%type,
                      p_clob             blob,
                      p_encoding         varchar2 ,
                      p_nazn             varchar2,
                      p_id_dbf_type      number,
                      p_file_type        varchar2,
                      p_nlsb_map         varchar2 default null,
                      p_s_map            varchar2 default null,
                      p_okpob_map        varchar2 default null,
                      p_mfob_map         varchar2 default null,
                      p_namb_map         varchar2 default null,
                      p_nazn_map         varchar2 default null,
                      p_save_draft       varchar2 default null,
                      p_sum_delimiter    number   default 1 ,
                      p_err          out varchar2);
procedure payroll_imp_del(p_id zp_payroll_imp_files.id%type);
procedure del_deals_fs(p_id number);
procedure prev_dbf_load(  p_blob             blob,
                          p_encoding         varchar2
);
type docs_buffer_rec is record
   (
      id               zp_payroll_doc.id%type,
      doc_buffer       varchar2(730)
   );
type docs_buffer_set is table of docs_buffer_rec;
function get_docs_buffer (p_id zp_payroll.id%type)
   return docs_buffer_set
   pipelined;
function get_payroll_buffer (p_id zp_payroll.id%type)
   return varchar2;
function get_user_key_id
   return varchar2;
procedure set_central(p_mfo varchar2,p_nls varchar2, p_central number);

  -----------------------------------------------------------------------------------------
  --  get_doc_person
  --
  --    Метод повертає паспортні дані клієнта по рахунку
  --
  --      p_nls - Вхідний параметр рахунок клієнта (2625)
  --      p_okpo        - ІПН клієнта (out)
  --      p_nmk         - ПІБ клієнта (out)
  --      p_pass_serial - Серія паспорта (out)
  --      p_pass_num    - Номер паспорта (out)
  --      p_pass_card   - Номер паспорта у вигляді картки (out)
  --      p_actual_date - Дата актуальності паспорта у вигляді картки (out)
  --
  procedure get_doc_person(p_nls in accounts.nls%type,
                           p_okpo        out customer.okpo%type,
                           p_nmk         out customer.nmk%type,
                           p_pass_serial out person.ser%type,
                           p_pass_num    out person.numdoc%type,
                           p_pass_card   out person.numdoc%type,
                           p_actual_date out person.actual_date%type);
end;
/

create or replace package body bars.zp
is

g_body_version   constant varchar2(64)   := 'version 1.26 19.10.2018';

g_modcode        constant varchar2(3)   := 'ZP';
g_aac_tip        constant varchar2(3)   := 'ZRP';

-- таблица кодировки непечатаемых символов
g_notprint constant varchar2(32)   :=    chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||chr(08)||chr(09)||chr(10)||
                                        chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||
                                        chr(22)||chr(23)||chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31);

g_fiocheck constant varchar2(128)   := 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'||'АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'||chr(39)||'-'||' '||'ABCDEFGHIJKLMNOPQRSTUVWXYZ''"`';

type t_operw is table of operw%rowtype;

-- определение версии заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header: '||g_head_version;
end header_version;
--
-- определение версии тела пакета
--
function body_version return varchar2 is
begin
  return 'Package body  : '||g_body_version;
end body_version;

procedure init
is
begin
null;
end;

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
--==============================
--закрытие счета
--==============================
procedure close_acc (p_acc accounts.acc%type)
is
n number;
l_nls accounts.nls%type;
l_kv accounts.nls%type;
begin

select nls, kv into l_nls, l_kv from accounts where acc=p_acc;

select 1 into n  from accounts
     where ostc = 0
       and ostb = 0
       and ostf = 0
       and (dapp is null or dapp < bankdate)
       and daos <= bankdate
       and acc = p_acc;

update accounts set dazs = bankdate where acc = p_acc;

exception when no_data_found then
        raise_application_error(-20000, 'Неможливо закрити рахунок - '||l_nls||'('||l_kv||').');
end ;
--==============================
--апдейт состояния зп договора
--==============================
procedure set_sos(p_id  zp_deals.id%type, p_sos number)
is
begin

   update zp_deals
         set  sos = p_sos
   where id= p_id;

end ;

--===================================
--привязка счета 2625/2620 к договору
--===================================

procedure set_acc_pk(p_acc accounts.acc%type, p_id zp_deals.id%type, p_id_bpk zp_acc_pk.id_bpk_proect%type default null )
is
begin
    update zp_acc_pk
    set        id = p_id,
    id_bpk_proect = p_id_bpk,
           status = 1
    where acc_pk=p_acc;

    if SQL%rowcount = 0 then
    insert into zp_acc_pk(id,acc_pk,kf,status,id_bpk_proect) values (p_id,p_acc,f_ourmfo(),1,p_id_bpk);
    end if;
end;
--==============================
--проставляем дату закрытия
--==============================
procedure set_close_date(p_id  zp_deals.id%type)
is
begin
update zp_deals
set close_date= trunc(sysdate)
where id=p_id;
end;
--==============================
--закрытие договора(подтверждение БО)
--==============================
procedure close_deal_author(p_id  zp_deals.id%type)
is

l_zp_deals    zp_deals%rowtype;
l_sync_id     ead_sync_queue.id%type;

begin

   select * into l_zp_deals from zp_deals where id=p_id;

   if  l_zp_deals.sos not in (6)
       then
        raise_application_error(-20000, 'Можливо закрити тільки діючий договір');
   end if ;

   set_sos(p_id,-1);

   for z in (select acc from zp_acc where id=p_id)
    loop
      close_acc(z.acc);
    end loop;

   set_close_date(p_id);

     --если надо, можем передавать клиента(во всех передачах в ЕА сначала кидают клиента в очередь, на всякий случай)
     ead_pack.msg_create ('UCLIENT', TO_CHAR (l_zp_deals.rnk), l_zp_deals.rnk, l_zp_deals.kf);

     --наполняем очередь для передачи в ЕА

  ead_pack.msg_create ('UAGR', 'SALARY;'||l_zp_deals.id||';0', l_zp_deals.rnk,  l_zp_deals.kf);
  ead_pack.msg_create('UACC', 'SALARY_CLOSE/'||l_zp_deals.id||';'|| to_char(l_zp_deals.acc_2909), l_zp_deals.rnk, l_zp_deals.kf);


end close_deal_author;
--==============================
--апдейт состояния ведомости
--==============================
procedure set_pr_sos(p_id  zp_payroll.id%type, p_sos number)
is
begin

   update zp_payroll
         set  sos = p_sos
   where id= p_id;

end ;

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

function check_name (p_str varchar2) return boolean
is
begin
  return check_permitted_char(p_str, g_fiocheck);
end check_name;

procedure check_payroll_doc_add(p_id number)
is
l_sos zp_payroll.sos%type;
begin

     begin
       select sos into l_sos from zp_payroll where sos in (1,3,-1) and id=p_id;
     exception when no_data_found then
        raise_application_error(-20000, 'Відомість має бути в статусі - Чернетка/Прийнята/Відхилена');
     end;
end;
procedure get_okpob_namb(p_nlsb varchar2,p_mode number,p_par out varchar2 ) --1 okpo,2 namb
is
l_okpo customer.okpo%type;
l_namb customer.nmk%type;
begin
select c.okpo,c.nmk into l_okpo,l_namb from accounts a , customer c
                          where a.rnk=c.rnk
                          and a.kv='980'
                          and a.nls=p_nlsb
                          and a.dazs is null;

if     p_mode=1 then
  p_par:=l_okpo;
elsif  p_mode=2 then
  p_par:=l_namb;
end if;

exception
when no_data_found
 then
    raise_application_error(-20000, 'По рахунок - '||p_nlsb||' не знайдено клієнта/або рахунок закритий');
end;
procedure pay_approve (p_premium        zp_deals.deal_premium%type,
                       p_cms            number,
                       p_sum            number,
                       p_3570_ost       number,
                       p_2909_ost       number,
                       p_mode       out number)
is
begin

if p_premium in( 0,1)     and p_cms+p_sum+case when sign(p_3570_ost)=-1 then -p_3570_ost else 0 end<=p_2909_ost
    then p_mode:= 1;
elsif p_premium= 1  and             p_sum+case when sign(p_3570_ost)=-1 then -p_3570_ost else 0 end<=p_2909_ost
    then p_mode:= 2;
else
         p_mode:= 0;
end if;
end;

procedure pay_doc(p_oper in out oper%rowtype)
is
l_sos    number := null;

l_tt     varchar2(3);
begin

     gl.ref     (p_oper.ref);

     gl.in_doc3 (ref_  => p_oper.ref,
                 tt_   => p_oper.tt,
                 vob_  => p_oper.vob,
                 nd_   => p_oper.nd,
                 pdat_ => p_oper.pdat,
                 vdat_ => p_oper.vdat ,
                 dk_   => p_oper.dk,
                 kv_   => p_oper.kv,
                 s_    => p_oper.s,
                 kv2_  => p_oper.kv2,
                 s2_   => p_oper.s2,
                 sk_   => p_oper.sk  ,
                 data_ => gl.bdate,
                 datp_ => p_oper.datp,
                 nam_a_=> p_oper.nam_a,
                 nlsa_ => p_oper.nlsa,
                 mfoa_ => p_oper.mfoa,
                 nam_b_=> p_oper.nam_b,
                 nlsb_ => p_oper.nlsb,
                 mfob_ => p_oper.mfob,
                 nazn_ => p_oper.nazn,
                 d_rec_=> p_oper.d_rec   ,
                 id_a_ => p_oper.id_a,
                 id_b_ => p_oper.id_b,
                 id_o_ => p_oper.id_o   ,
                 sign_ => p_oper.sign,
                 sos_  => p_oper.sos,
                 prty_ => p_oper.prty,
                 uid_  => null );
        gl.dyntt2(     l_sos,
                   0,  -- ?
                   null,
                   p_oper.ref,
                   p_oper.vdat,
                   p_oper.vdat,
                   p_oper.tt,
                   p_oper.dk,
                   p_oper.kv,
                   p_oper.mfoa,
                   p_oper.nlsa,
                   p_oper.s,
                   p_oper.kv,
                   p_oper.mfob,
                   p_oper.nlsb,
                   p_oper.s2,
                   null,
                   null);

end;

function get_okpo(p_rnk customer.rnk%type)
return varchar2
is
l_okpo customer.okpo%type;
begin


    begin
    select okpo into l_okpo from customer where rnk=p_rnk;
    exception when no_data_found
         then raise_application_error(-20000, 'Не знайдено RNK для данного ЗП договору');
    end;

return l_okpo;
end;
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

function get_6510_ob22(p_fs zp_deals.fs%type)
return varchar2
is
l_ob22 varchar2(2);
begin

    select ob22 into l_ob22 from  v_zp_deals_fs where id=p_fs;
    return l_ob22;

exception when no_data_found
    then  raise_application_error(-20000, 'По данному ЗП договору не знайдено OB22 для вказаної форми власності');
end;

--==============================
--Запрос  буферa документа
--==============================

function get_doc_buffer (p_id zp_payroll_doc.id%type)
      return varchar2
is
l_docs_buffer  varchar2(730);
begin
     select      nvl(rpad(substr(z.zp_deal_id,1,30),30),rpad(' ',30))
                    ||nvl(rpad(substr(z.id,1,30),30),rpad(' ',30))
                    ||nvl(to_char(trunc(sysdate),'YYMMDD'),rpad(' ',6))
                    ||nvl(lpad(z.kf,9),rpad(' ',9))
                    ||nvl(lpad('980',3),rpad(' ',3))
                    ||nvl(lpad(to_char(s),16),rpad(' ',16))
                    ||nvl(rpad(d.namb,38),rpad(' ',38))
                    ||nvl(lpad(d.mfob,9),rpad(' ',9))
                    ||nvl(lpad(d.nlsb,14),rpad(' ',14))
                    ||nvl(rpad(d.nazn,160),rpad(' ',160))
                    ||nvl(rpad(substr(z.payroll_num,1,50),50),rpad(' ',50)) buf
                    into l_docs_buffer
                    from zp_payroll_doc d ,zp_payroll z
                    where d.id_pr=z.id
                    and d.id=p_id
                    and d.signed is null;

l_docs_buffer  := rawtohex(utl_raw.cast_to_raw(l_docs_buffer));

return l_docs_buffer;

end get_doc_buffer;
--==============================
--Подписание доков ведомости
--==============================

procedure set_docs_sign(p_sign_doc_set in t_sign_doc_set,p_id zp_payroll.id%type)
is
doc_cnt number;
l_buf   varchar2(730);
l_zp_payroll_doc zp_payroll_doc%rowtype;
begin

   --bars_audit.info('zp.set_docs_sign.start_sign'||to_char(sysdate,'DD.MM.YYYY HH24:MI:SS') );



   select count(*) into doc_cnt from zp_payroll_doc where id_pr=p_id and signed is null;

   if doc_cnt=0 then
       raise_application_error(-20000, 'Документи вже підписані іншим користувачем');

   elsif p_sign_doc_set.count<>doc_cnt
   then
       raise_application_error(-20000, 'Невірна кількість документів для підпису');
   end if;

   for i in 1 .. p_sign_doc_set.count
   loop

      select * into l_zp_payroll_doc from zp_payroll_doc where id=p_sign_doc_set(i).id for update nowait ;


       if p_sign_doc_set(i).id is null or p_sign_doc_set(i).sign is null or p_sign_doc_set(i).key_id is null or p_sign_doc_set(i).doc_buffer is null then

         raise_application_error(-20000, 'Відсутні значення для підпису документів');

       end if;

       l_buf:=get_doc_buffer(p_sign_doc_set(i).id);

       if l_buf<>p_sign_doc_set(i).doc_buffer
       then
       raise_application_error(-20000, 'Буфер документу -'||p_sign_doc_set(i).id||'не співпадає зі старим значенням');
       end if;


   end loop;


   forall  j in p_sign_doc_set.first .. p_sign_doc_set.last

   update zp_payroll_doc
   set key_id=p_sign_doc_set(j).key_id,
       sign=p_sign_doc_set(j).sign,
       signed='Y',
       signed_user = user_id
   where id=p_sign_doc_set(j).id;


  --DBMS_PROFILER.STOP_PROFILER;

   --bars_audit.info('zp.set_docs_sign.finish'||to_char(sysdate,'DD.MM.YYYY HH24:MI:SS') );

end set_docs_sign;


--==============================
--Подписание  ведомости
--==============================
procedure set_payroll_sign(p_id       zp_payroll.id%type,
                           p_sign     zp_payroll.sign%type,
                           p_key_id   zp_payroll.key_id%type,
                           p_docbufer varchar2)
is
doc_cnt number;
begin

 --- проверяем что все доки подписаны
    select count(*) into doc_cnt from zp_payroll_doc where id_pr=p_id and signed is null;

    if doc_cnt>0
    then
        raise_application_error(-20000, 'По відомості присутні не підписані документи');
    end if;
 --- сравниваем буфер
    if zp.get_payroll_buffer(p_id)<>p_docbufer
    then
        raise_application_error(-20000, 'Буфер відомості -'||p_id||'не співпадає зі старим значення');
    end if;

    update zp_payroll
    set key_id=p_key_id,
       sign=p_sign,
       signed='Y',
       signed_user = user_id
    where id=p_id;


end set_payroll_sign;


procedure add_central_queue(p_nls varchar2, p_central number)
is
begin

    insert into zp_central_queue (mfo,nls,central) values (f_ourmfo,p_nls,p_central);
exception
        when dup_val_on_index then null;
end;
--==============================
--Отправка признака централизовонго договора
--==============================
procedure send_central (p_mfo varchar2 ,p_nls varchar2, p_central number)
is
 l_request         soap_rpc.t_request;
 l_response        soap_rpc.t_response;
 l_url             params$global.val%type := getglobaloption('ABSBARS_WEBSERVER_PROTOCOL')||'://'||getglobaloption('ABSBARS_WEBSERVER_IP_ADRESS')||getglobaloption('ZPCENTRAL');
 l_dir             varchar2(256)          := getglobaloption('PATH_FOR_ABSBARS_WALLET');
 l_pass            varchar2(256)          := getglobaloption('PASS_FOR_ABSBARS_WALLET');

 l_clob            clob;
 l_error           varchar2(4000);
 l_parser          dbms_xmlparser.parser;
 l_doc             dbms_xmldom.domdocument;
 l_reslist         dbms_xmldom.DOMNodeList;
 l_res             dbms_xmldom.DOMNode;
 l_str             varchar2(4000);
 l_status          varchar2(4000);
 l_tmp             xmltype;

begin

   l_request := soap_rpc.new_request  (p_url       => l_url,
                                    p_namespace => 'http://ws.unity-bars-utl.com.ua/',
                                    p_method    => 'SendCentralToAll',
                                    p_wallet_dir =>  l_dir,

                                    p_wallet_pass => l_pass);

    soap_rpc.add_parameter(l_request, 'mfo',    p_mfo);

    soap_rpc.add_parameter(l_request, 'nls',    p_nls);

    soap_rpc.add_parameter(l_request, 'central', to_char(p_central));

    soap_rpc.add_parameter(l_request, 'sessionId', to_char(' '));

    l_response := soap_rpc.invoke(l_request);

    l_clob := l_response.doc.getClobVal();
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);
    l_reslist := dbms_xmldom.getelementsbytagname(l_doc,
                                                  'SendCentralToAllResult');
    l_res     := dbms_xmldom.item(l_reslist, 0);
    dbms_xslprocessor.valueof(l_res, 'status/text()', l_str);
    l_status := substr(l_str, 1, 200);

    if lower(trim(l_status)) = 'ok' then

        delete zp_central_queue where nls=p_nls and central=p_central;

    else

        dbms_xslprocessor.valueof(l_res, 'message/text()', l_str);
        l_status := substr(l_str, 1, 4000);

        update zp_central_queue
        set error=l_status
        where nls=p_nls and central=p_central and mfo=p_mfo;

    end if;


    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);



exception when others then

  dbms_xmlparser.freeparser(l_parser);
  DBMS_XMLDOM.freeDocument(l_doc);

  l_error := substr(sqlerrm, 1, 4000);

     update zp_central_queue
        set error=l_error
       where nls=p_nls and central=p_central and mfo=p_mfo;

end;


procedure send_central
is
begin

    for c in (select * from zp_central_queue)
    loop
        send_central (c.mfo ,c.nls, c.central);
    end loop;

end;

--==============================
--Заведення договору
--==============================
procedure create_deal(p_rnk            customer.rnk%type,
                      p_deal_name      zp_deals.deal_name%type,
                      p_start_date     date,
                      p_deal_premium   zp_deals.deal_premium%type,
                      p_central        zp_deals.central%type,
                      p_kod_tarif      zp_deals.kod_tarif%type,
                      p_acc            number,
                      p_fs             zp_deals.fs%type,
                      p_branch         branch.branch%type default null
                      )
is
l_zp_deals   zp_deals%rowtype;
l_accounts   accounts%rowtype;
l_okpo       customer.okpo%type;
l_nmkk       customer.nmkv%type;
l_tmp        number;
n            number;
l_nls_2909   accounts.nls%type;

l_sync_id    ead_sync_queue.id%TYPE;

begin

    -- перевірка чи відкрито договір клієнта з таким рахунком 2909
    -- перевірка тільки якщо рахунок передано в параметрі, інакше рахунок буде відкрито новий
    if p_acc is not null then
      begin
        select 1.0 into n from zp_deals where rnk=p_rnk and sos>=0 and acc_2909 = p_acc;
        exception
          when no_data_found then
            null;
          when others then
            raise;
      end;
    end if;

    if n=1.0 then
      select nls into l_nls_2909 from accounts where acc = p_acc;
      raise_application_error(-20000, 'У данного клієнта(РНК-'||p_rnk||') вже є ЗП договір з таким рахунком '||l_nls_2909);
    end if;

    begin
    select okpo, nmkk into l_okpo,l_nmkk from customer where rnk=p_rnk;
    exception when no_data_found then
             raise_application_error(-20000, 'Вказаного РНК - '||p_rnk||',  не існує.');
    end;

    begin
    select 1.0 into n from customer where date_off is null
    and rnk=p_rnk;
    exception when no_data_found then
             raise_application_error(-20000, 'Вказаний клієнт - закритий.');
    end;

    begin
    select 1.0 into n from customer where (custtype<>3 or sed='91')
    and rnk=p_rnk;
    exception when no_data_found then
             raise_application_error(-20000, 'Вказаний клієнт - не ЮО/ФОП.');
    end;

    if p_start_date>trunc(sysdate)
      then
        raise_application_error(-20000, 'Дата договору не може бути більше поточної.');
    end if;

    begin
             select 1 into n from zp_tarif where kod=p_kod_tarif;
    exception when no_data_found then
             raise_application_error(-20000, 'Код тарифу - '||p_kod_tarif||', не можливий для зарплатних догворів.');
    end;


    l_zp_deals.id           := bars_sqnc.get_nextval('s_zp_deals');
    l_zp_deals.deal_id      := l_zp_deals.id||'.'||l_okpo;
    l_zp_deals.start_date   := p_start_date;
    l_zp_deals.deal_name    := p_deal_name;
    l_zp_deals.rnk          := p_rnk;
    l_zp_deals.sos          := 0;
    l_zp_deals.deal_premium := p_deal_premium;
    l_zp_deals.central      := p_central;
    l_zp_deals.kod_tarif    := p_kod_tarif;
    l_zp_deals.branch       := sys_context('bars_context','user_branch');
    l_zp_deals.kf           := sys_context('bars_context','user_mfo');
    l_zp_deals.user_id      := gl.auid ;
    l_zp_deals.crt_date     := sysdate;
    l_zp_deals.upd_date     := sysdate;
    l_zp_deals.fs           := p_fs;

    if p_branch is not null then
      l_zp_deals.branch := p_branch;
    end if;
    --"резервирование" счета 2909

     if nvl(p_acc,0)=0
      then

      while 1<5    loop
         l_tmp := trunc(dbms_random.value(1, 999999999));
         begin select 1 into l_tmp from accounts where nls like '2909_'||l_tmp and kv=980;
         exception when no_data_found then exit ;
         end;
      end loop;

     l_accounts.nls := vkrzn ( substr(gl.amfo,1,5) ,'29090'||l_tmp );
     l_accounts.kv  := gl.baseval;
     l_accounts.nms :=substr(l_nmkk,1,70);

     l_accounts.grp := 39 ;

     op_reg_ex(  mod_  => 9,
                 p1_   => null,
                 p2_   => 0,
                 p3_   => l_accounts.grp,
                 p4_   => l_tmp,
                 rnk_  => l_zp_deals.rnk,
                 nls_  => l_accounts.nls,
                 kv_   => l_accounts.kv,
                 nms_  => l_accounts.nms,
                 tip_  => g_aac_tip,
                 isp_  => l_zp_deals.user_id,
                 accr_ => l_accounts.acc,
                 pap_  => 2     ,
                 tobo_ => l_zp_deals.branch);

      accreg.setaccountsparam(l_accounts.acc, 'OB22', '11');
      accreg.setaccountsparam(l_accounts.acc, 'R011', '2');
      accreg.setaccountsparam(l_accounts.acc, 'S120', '3');
      accreg.setaccountsparam(l_accounts.acc, 'S181', '1');
      accreg.setaccountsparam(l_accounts.acc, 'S240', '3');

      close_acc(l_accounts.acc);


      l_zp_deals.acc_2909:=l_accounts.acc;

     else
      l_zp_deals.acc_2909:=p_acc;
     end if;

     insert into zp_deals values l_zp_deals;

     --если надо, можем передавать клиента(во всех передачах в ЕА сначала кидают клиента в очередь, на всякий случай)
     ead_pack.msg_create ('UCLIENT', TO_CHAR (l_zp_deals.rnk), l_zp_deals.rnk, l_zp_deals.kf);

     --наполняем очередь для передачи в ЕА

     ead_pack.msg_create ('UAGR', 'SALARY;'||l_zp_deals.id||';10', l_zp_deals.rnk,  l_zp_deals.kf);
    ead_pack.msg_create('UACC', 'SALARY_RESERVED/'||l_zp_deals.id||';' || to_char(l_zp_deals.acc_2909), l_zp_deals.rnk, l_zp_deals.kf);


     insert into zp_acc(id,acc,kf) values (l_zp_deals.id,l_zp_deals.acc_2909, l_zp_deals.kf );
end create_deal;

--==============================
--Підтвердження договору
--==============================
procedure approve_deal(p_id zp_deals.id%type, p_comm_reject zp_deals.comm_reject%type)
is
l_zp_deals zp_deals%rowtype;

l_name     zp_deals_sos.name%type;

begin

    select * into l_zp_deals from zp_deals where id=p_id;


    if l_zp_deals.sos in (0,2) then
         update zp_deals
         set   sos = 1,
               comm_reject =nvl(p_comm_reject,l_zp_deals.comm_reject)
         where id= p_id;



    elsif l_zp_deals.sos=4
        then
         update zp_deals
         set   sos = 3  ,
               comm_reject =nvl(p_comm_reject,l_zp_deals.comm_reject)
         where id= p_id;
    elsif l_zp_deals.sos=7
        then
         update zp_deals
         set   sos = 6  ,
               comm_reject =nvl(p_comm_reject,l_zp_deals.comm_reject)
         where id= p_id;

    elsif l_zp_deals.sos=1 then
         select name into l_name from zp_deals_sos where sos=l_zp_deals.sos;
         raise_application_error(-20000, 'Договір вже підтверджено. Поточний статус -  '||l_name);
    else
         select name into l_name from zp_deals_sos where sos=l_zp_deals.sos;
         raise_application_error(-20000, 'Для підтвердження договір має бути в статусі "Новий","Відхилений БО","Внесені зміни відхилені БО". Поточний статус - '||l_name);

    end if;
end approve_deal;

--- переписать на апдейт в конце

--==============================
--Редагування договору
--==============================
procedure update_deal(p_id             zp_deals.id%type,
                      p_deal_name      zp_deals.deal_name%type,
                      p_start_date     date,
                      p_deal_premium   zp_deals.deal_premium%type,
                      p_central        zp_deals.central%type,
                      p_kod_tarif      zp_deals.kod_tarif%type,
                      p_fs             zp_deals.fs%type default 1,
                      p_acc_3570       zp_deals.acc_3570%type default null,
                      p_branch         branch.branch%type default null
                      )
is

l_zp_deals zp_deals%rowtype;
n number;

l_comm     zp_deals.comm_reject%type:=null;

begin

   select * into l_zp_deals from zp_deals where id=p_id;

   if  l_zp_deals.sos not in (0,2,4,5,7)
       then
        raise_application_error(-20000, 'Можливо редагувати тільки договір в статусі "Новий"/"Відхилений БО", або "Діючий"/"Внесені зміни відхилені БО"/"Закриття відхилене БО"');
   end if ;

   if p_start_date>trunc(sysdate)
      then
        raise_application_error(-20000, 'Дата договору не може бути більше поточної.');
   end if;

   begin
             select 1 into n from zp_tarif where kod=p_kod_tarif;
   exception when no_data_found then
             raise_application_error(-20000, 'Код тарифу - '||p_kod_tarif||', не можливий для зарплатних догворів.');
   end;

   if p_branch is not null then
     if l_zp_deals.sos not in (0,5) then -- COBUMMFO-7001 -- можливо редагувати відділення тільки в статусі (0,5)
       raise_application_error(-20000, 'Можливо редагувати відділення тільки в статусі "Новий" або "Діючий"');
     else
       update zp_deals
          set branch = p_branch
        where id= p_id;
     end if;
   end if;

   if l_zp_deals.sos in (0,2,7)  then

         update zp_deals
         set   deal_name    = p_deal_name,
               start_date   = p_start_date,
               deal_premium = p_deal_premium,
               central      = p_central,
               kod_tarif    = p_kod_tarif,
               fs           = p_fs
         where id= p_id;



   elsif l_zp_deals.sos=5  then

        if l_zp_deals.kod_tarif<> p_kod_tarif
        then
            l_comm:=l_comm||'Cтарий код тарифу - '||l_zp_deals.kod_tarif||', новий код тарифу - '||p_kod_tarif||'. ';
        end if;

        if l_zp_deals.deal_premium<> p_deal_premium
        then
            l_comm:=l_comm||'Старе значення преміальності - '||case when l_zp_deals.deal_premium = 1 then 'Преміальний' when l_zp_deals.deal_premium = 0 then 'Звичайний' end ||',нове значення преміальності - '||case when p_deal_premium = 1 then 'Преміальний' when p_deal_premium = 0 then 'Звичайний' end ||'. ';
        end if;

        if l_zp_deals.central<> p_central
        then
            l_comm:=l_comm||'Старе значення централізованості - '||case when l_zp_deals.central = 1 then 'ТАК' when l_zp_deals.central = 0 then 'НІ' end||', нове значення централізованості - '||case when p_central = 1 then 'ТАК' when p_central = 0 then 'НІ' end||'. ';
        end if;

        if l_zp_deals.fs<> p_fs
        then
            l_comm:=l_comm||'Старе значення форми властності - '||l_zp_deals.fs||', нове значення форми властності - '||p_fs||'. ';
        end if;

        if l_zp_deals.acc_3570<> nvl(p_acc_3570,l_zp_deals.acc_3570)
        then
            l_comm:=l_comm||'Старий рахунок  - '||l_zp_deals.acc_3570||', новий рахунок - '||p_acc_3570||'. ';
        end if;



        if length(l_comm)>0
          then
            update zp_deals
             set  deal_premium = p_deal_premium,
                  central      = p_central,
                  kod_tarif    = p_kod_tarif,
                  sos          = 3 ,
                  comm_reject  = l_comm,
                  fs           = p_fs,
                  acc_3570     = nvl(p_acc_3570,l_zp_deals.acc_3570)
                  where id= p_id;

                  update zp_acc set acc=nvl(p_acc_3570,l_zp_deals.acc_3570) where id =l_zp_deals.id and acc=l_zp_deals.acc_3570;

         end if;

   elsif  l_zp_deals.sos=4
        then

           update zp_deals
             set  deal_premium = p_deal_premium,
                  central      = p_central,
                  kod_tarif    = p_kod_tarif,
                  fs           = p_fs,
                  acc_3570     = nvl(p_acc_3570,l_zp_deals.acc_3570)

                  where id= p_id;

           update zp_acc set acc=nvl(p_acc_3570,l_zp_deals.acc_3570) where id =l_zp_deals.id and acc=l_zp_deals.acc_3570;



   end if;

end update_deal;

--==============================
--Видалення договору
--==============================
procedure del_deal(p_id  zp_deals.id%type)
is

l_zp_deals zp_deals%rowtype;
l_sync_id     ead_sync_queue.id%type;


begin

   select * into l_zp_deals from zp_deals where id=p_id;

   if  l_zp_deals.sos<>0
       then
        raise_application_error(-20000, 'Можливо видалити тільки договір в статусі "Новий".');
   end if ;

   set_sos(p_id,-2);

   set_close_date(p_id);


     --если надо, можем передавать клиента(во всех передачах в ЕА сначала кидают клиента в очередь, на всякий случай Оо)
     ead_pack.msg_create ('UCLIENT', TO_CHAR (l_zp_deals.rnk), l_zp_deals.rnk, l_zp_deals.kf);

     --наполняем очередь для передачи в ЕА
  ead_pack.msg_create ('UAGR', 'SALARY;'||l_zp_deals.id||';0', l_zp_deals.rnk,  l_zp_deals.kf);
  ead_pack.msg_create('UACC', 'SALARY_CLOSE/'||l_zp_deals.id||';' || to_char(l_zp_deals.acc_2909), l_zp_deals.rnk, l_zp_deals.kf);



end del_deal;
--==============================
--Авторизація договору
--==============================
procedure authorize_deal(p_id  zp_deals.id%type )
is

l_v_zp_deals v_zp_deals%rowtype;

l_accounts accounts%rowtype;

l_tmp number;

l_sync_id     ead_sync_queue.id%type;

begin

   select * into l_v_zp_deals from v_zp_deals where id=p_id;

  if l_v_zp_deals.sos = 1
  then

      begin

       /*
       select * into l_accounts from accounts a
       where nbs_ob22_rnk('3570','29',l_v_zp_deals.nls_2909,980)=a.nls
       and kv=980;
              
       exception when others  then
           if sqlcode = -20203
           then
       */
       -- COBUMMFO-7442
       -- відкриття 3570 на кожен 2909
       select * into l_accounts from accounts a
       where acc = l_v_zp_deals.acc_3570;
       
      exception
        when no_data_found then
          -- відкриття 3570
          begin
            while 1<5    loop
               l_tmp := trunc(dbms_random.value(1, 999999999));
               begin select 1 into l_tmp from accounts where nls like '3570_'||l_tmp and kv=980;
               exception when no_data_found then exit ;
               end;
            end loop;

            l_accounts.nls := vkrzn ( substr(gl.amfo,1,5) ,'35700'||l_tmp );
            l_accounts.kv  := gl.baseval;
            l_accounts.nms :=l_v_zp_deals.nmkv;

            l_accounts.grp := 39 ;

            op_reg_ex(  mod_  => 9,
                       p1_   => null,
                       p2_   => 0,
                       p3_   => l_accounts.grp,
                       p4_   => l_tmp,
                       rnk_  => l_v_zp_deals.rnk,
                       nls_  => l_accounts.nls,
                       kv_   => l_accounts.kv,
                       nms_  => l_accounts.nms,
                       tip_  => 'ODB',
                       isp_  => user_id,
                       accr_ => l_accounts.acc,
                       pap_  => 1     ,
                       tobo_ => l_v_zp_deals.branch);

            accreg.setaccountsparam(l_accounts.acc, 'OB22', '29');
            accreg.setaccountsparam(l_accounts.acc, 'R013', '3');
            accreg.setaccountsparam(l_accounts.acc, 'S180', '5');
            accreg.setaccountsparam(l_accounts.acc, 'S240', '4');
           end;
         when others then
           raise_application_error(-20001, 'Помилка відкриття рахунка 3570 '||substr (dbms_utility.format_error_backtrace || ' ' || sqlerrm, 1, 3000));
       end;

       update  zp_deals set acc_3570=l_accounts.acc where id =p_id;

       insert into zp_acc(id,acc,kf) values (l_v_zp_deals.id,l_accounts.acc, l_v_zp_deals.kf );

       update accounts set dazs = null where acc = l_v_zp_deals.acc_2909;

       set_sos(p_id,5);

      ead_pack.msg_create ('UAGR', 'SALARY;'||l_v_zp_deals.id||';1', l_v_zp_deals.rnk,  l_v_zp_deals.kf);
      ead_pack.msg_create('UACC', 'SALARY_OPEN/'||l_v_zp_deals.id||';' || to_char(l_v_zp_deals.acc_2909), l_v_zp_deals.rnk, l_v_zp_deals.kf);

       if l_v_zp_deals.central=1
       then
            add_central_queue (l_v_zp_deals.nls_2909, 1);
       end if;

  elsif l_v_zp_deals.sos = 3
  then

       set_sos(p_id,5);

       --если были изменения признака централизации

       if instr(l_v_zp_deals.comm_reject,'централізованості')>0
         then add_central_queue (l_v_zp_deals.nls_2909, l_v_zp_deals.central);
       end if;

  elsif l_v_zp_deals.sos = 6
  then

       close_deal_author(p_id);
       add_central_queue (l_v_zp_deals.nls_2909, 0); --удаляем на регионах из OW_IIC_MSGCODE

  end if;


end authorize_deal;
--==============================
--Відмова авторизації
--==============================
procedure reject_deal(p_id  zp_deals.id%type, p_comm_reject zp_deals.comm_reject%type )
is

l_zp_deals zp_deals%rowtype;

begin


   if  p_comm_reject is null
       then
        raise_application_error(-20000, 'Необхідно заповнити причину відмови.');
   end if ;



   select * into l_zp_deals from zp_deals where id=p_id;

--переписать на апдейт в конце

    if   l_zp_deals.sos =1
    then
       update zp_deals
             set  sos = 2,
                  comm_reject=p_comm_reject
       where id= p_id;

    elsif   l_zp_deals.sos=3
    then
       update zp_deals
             set  sos = 4,
                  comm_reject=p_comm_reject
       where id= p_id;

    elsif   l_zp_deals.sos=6
    then
       update zp_deals
             set  sos = 7,
                  comm_reject=p_comm_reject
       where id= p_id;

    end if;

end reject_deal;

--==============================
--Привязка счетов к зп договору
--==============================
procedure zp_acc_migr(p_id zp_deals.id%type)
is

l_okpo customer.okpo%type;

begin

   select okpo into l_okpo from v_zp_deals
   where id=p_id;

   delete zp_acc_pk where id=p_id;

   for c in (select w.acc,w.value from
                accountsw w, accounts a ,bpk_proect b
                where w.tag = 'PK_PRCT'
                and a.acc=w.acc
                and regexp_replace(w.value,'\D','')=b.id
                and b.okpo=l_okpo
                and dazs is null)
   loop
     set_acc_pk(c.acc, p_id, c.value);
   end loop;


        -- доп привязка к зп проекту счетов нашего РУ из ведомости
  for j in (select r.zp_id, a.acc from zp_payroll_doc z, accounts a ,zp_acc_pk p, zp_payroll r
                                         where z.id_pr=r.id
                                         and r.zp_id=p_id
                                         and mfob=f_ourmfo
                                         and z.nlsb=a.nls
                                         and a.kv=980
                                         and a.acc=p.acc_pk(+)
                                         and p.acc_pk is null)
   loop
           set_acc_pk(j.acc, j.zp_id);
   end loop;


end;

--==============================
--блокировка/разблокировка/удаление счета
--==============================
procedure set_acc_sos (p_acc accounts.acc%type, p_sost number)
is
begin

    if  p_sost not in( -1,0,1)
           then
            raise_application_error(-20000, 'Невідомий статус для рахунку');
    end if ;

    if p_sost= -1
    then
      delete zp_acc_pk where  acc_pk=p_acc;
    else
      update zp_acc_pk set status=p_sost
      where acc_pk=p_acc;
    end if;

end;

--==============================
--закрытие договора
--==============================

procedure close_deal(p_id  zp_deals.id%type , p_comm zp_deals.comm_reject%type )
is

l_zp_deals zp_deals%rowtype;

begin

   select * into l_zp_deals from zp_deals where id=p_id;

   if  l_zp_deals.sos not in (5)
       then
        raise_application_error(-20000, 'Можливо закрити тільки діючий договір');
   end if ;

   set_sos(p_id,6);

   update zp_deals
      set   comm_reject=nvl(p_comm,l_zp_deals.comm_reject)
   where id= p_id;

end close_deal;

--для бмд(справочник зп тарифов)
procedure change_ref_zp_tarif(p_kod zp_tarif.kod%type, p_kv zp_tarif.kv%type, p_type number)
is
begin
    if p_type=0 then

    insert into zp_tarif(kod,kv,kf) values (p_kod,p_kv,f_ourmfo());

    elsif p_type=1 then

    delete zp_tarif
    where kod=p_kod;

    end if;
end;
--==============================
--отправить на бэк для согласования изменений в допке
--==============================
procedure additional_change_deal(p_id  zp_deals.id%type , p_comm zp_deals.comm_reject%type )
is

l_zp_deals zp_deals%rowtype;

begin

   select * into l_zp_deals from zp_deals where id=p_id;

   if  l_zp_deals.sos not in (5)
       then
        raise_application_error(-20000, 'Можливо закрити тільки діючий договір');
   end if ;

   set_sos(p_id,3);

   update zp_deals
      set   comm_reject=p_comm
   where id= p_id;

end additional_change_deal;
--==============================
--Создание ЗП ведомости_черновика
--==============================
procedure create_payroll_draft ( p_zp_id zp_deals.id%type, p_id out zp_payroll.id%type)
is
l_zp_payroll zp_payroll%rowtype;
l_zp_deals   zp_deals%rowtype;

begin

select z.* into l_zp_deals from zp_deals z where id =p_zp_id ;

l_zp_payroll.id          := bars_sqnc.get_nextval('s_zp_payroll');
l_zp_payroll.rnk         := l_zp_deals.rnk;
l_zp_payroll.zp_id       := l_zp_deals.id;
l_zp_payroll.zp_deal_id  := l_zp_deals.deal_id;
l_zp_payroll.sos         := 3;
l_zp_payroll.source      := 1;
l_zp_payroll.crt_date    := sysdate;
l_zp_payroll.branch      := sys_context('bars_context','user_branch');
l_zp_payroll.kf          := sys_context('bars_context','user_mfo');
l_zp_payroll.user_id     := gl.auid ;
l_zp_payroll.upd_date    := sysdate;

insert into zp_payroll values l_zp_payroll;

p_id:=l_zp_payroll.id;
end;

--==============================
--Удаление ЗП ведомости
--==============================
procedure del_zp_payroll(p_id zp_payroll.id%type)
is
n number;

begin

   check_payroll_doc_add(p_id);

   set_pr_sos(p_id,-2);

end;
--==============================
--Підтвердження відомості
--==============================
procedure approve_payroll(p_sign_doc_set t_sign_doc_set,p_id zp_payroll.id%type)
is
l_zp_payroll     zp_payroll%rowtype;
l_zp_payroll_doc zp_payroll_doc%rowtype;
begin

   --bars_audit.info('zp.approve_payroll.start'||to_char(sysdate,'DD.MM.YYYY HH24:MI:SS') );

  --DBMS_PROFILER.START_PROFILER('ZP DOCS SIGN. '||sysdate);

    select * into l_zp_payroll from zp_payroll where id=p_id;

    if l_zp_payroll.sos in (-1,1) then

        set_pr_sos(p_id,2);


        -- доп привязка к зп проекту счетов нашего РУ из ведомости
        for c in (select z.id_pr, a.acc from zp_payroll_doc z, accounts a ,zp_acc_pk p
                                         where z.id_pr=p_id and mfob=f_ourmfo
                                         and z.nlsb=a.nls
                                         and a.kv=980
                                         and a.acc=p.acc_pk(+)
                                         and p.acc_pk is null)
        loop
           set_acc_pk(c.acc, c.id_pr);
        end loop;


    else
        raise_application_error(-20000, 'Для підтвердження відомість має бути в статусі "Прийнята"/"Відхилена"');

    end if;

    set_docs_sign(p_sign_doc_set,p_id) ;

end ;
--==============================
--Додавання/апдейт документу у відомість
--==============================
procedure add_payroll_doc(p_id_pr        zp_payroll.id%type,
                          p_okpob        zp_payroll_doc.okpob%type,
                          p_namb         zp_payroll_doc.namb%type,
                          p_mfob         zp_payroll_doc.mfob%type,
                          p_nlsb         zp_payroll_doc.nlsb%type,
                          p_source       zp_payroll_doc.source%type,
                          p_nazn         zp_payroll_doc.nazn%type,
                          p_s            zp_payroll_doc.s%type,
                          p_id           zp_payroll_doc.id%type           default null,
                          p_id_file      zp_payroll_doc.id_file%type      default null,
                          p_passp_serial zp_payroll_doc.passp_serial%type default null,
                          p_passp_num    zp_payroll_doc.passp_num%type    default null,
                          p_id_card_num  varchar2                         default null -- Паспорт гр.України у вигляді картки (поки не використовується)
                          )
is

l_zp_payroll_doc zp_payroll_doc%rowtype;
n number;

l_rnk customer.rnk%type;

begin

    check_payroll_doc_add(p_id_pr);

    begin
        select 1 into n
        from banks_ru
        where mfo=p_mfob;
    exception when no_data_found then
        raise_application_error(-20000, 'МФО отримувача має бути в Ощадбанку');
    end;

    if length(p_nlsb) > 15 or p_nlsb <> vkrzn( substr(p_mfob,1,5),p_nlsb ) then
          raise_application_error(-20000, 'Невірний контрольний розряд рахунку');
    end if;

    if p_okpob is null and p_mfob=f_ourmfo then
        get_okpob_namb(p_nlsb,1,l_zp_payroll_doc.okpob);
    else
        if f_validokpo(p_okpob) = -1  or  f_validokpo(p_okpob) is null then
             raise_application_error(-20000, 'Невірний контрольний розряд ІПН');
        end if;
    end if;

    if p_namb is null and  p_mfob=f_ourmfo  then
        get_okpob_namb(p_nlsb,2,l_zp_payroll_doc.namb);
    else
        if not check_name(upper(p_namb))
        then
           raise_application_error(-20000, 'ФІО повинно містити тільки українські/російські/англійські літери');
        end if;
    end if;

    if translate(p_nazn, g_notprint, rpad(' ',32))<>p_nazn
    then
       raise_application_error(-20000, 'В призначенні платежу є недрукованi символи(напр.перехiд каретки)');
    end if;

    if p_s<=0 then
        raise_application_error(-20000, 'Сума повинна бути більше 0');
    end if;

    if p_mfob=f_ourmfo and p_okpob is not null
    then
      begin
       select rnk into l_rnk
        from accounts
        where nls=p_nlsb
        and kv=980
        and dazs is null;
      exception when no_data_found then
        raise_application_error(-20000, 'Рахунок - '||p_nlsb||' не знайдено, або рахунок закритий.');
      end ;

      begin
       select 1 into n
        from customer
        where rnk=l_rnk
        and   okpo=p_okpob;
      exception when no_data_found then
        if p_source = 1 then
          if coalesce(p_okpob,'0000000000') <> '0000000000' then
            raise_application_error(-20000, 'ОКПО клієнта - '||p_okpob||' не відповідає рахунку - '||p_nlsb);
          else
            null;
          end if;
        else
          raise_application_error(-20000, 'ОКПО клієнта - '||p_okpob||' не відповідає рахунку - '||p_nlsb);
        end if;
      end;
    end if;

  -- перевірка паспортних даних тільки для ручного введення
  begin
    if p_source = 1 then
      if coalesce(p_okpob,'0000000000') = '0000000000' and ((p_passp_serial is null or p_passp_num is null) and p_id_card_num is null) then
        raise_application_error(-20000, 'Не вказані ІПН або серія та (або) номер паспорту');
      end if;

      if coalesce(p_id_card_num,'000000000') <> '000000000' and not regexp_like(p_id_card_num,'^\d{9}$') then
        raise_application_error(-20000, 'Номер паспорта нового зразка має містити 9 цифр');
      end if;
    end if;
  end;

  if p_id is null then

         l_zp_payroll_doc.s        := p_s*100;
         l_zp_payroll_doc.nlsb     := p_nlsb;
         l_zp_payroll_doc.okpob    := nvl(p_okpob,l_zp_payroll_doc.okpob);
         l_zp_payroll_doc.namb     := nvl(p_namb,l_zp_payroll_doc.namb );
         l_zp_payroll_doc.mfob     := p_mfob;
         l_zp_payroll_doc.nazn     := p_nazn;
         l_zp_payroll_doc.id       := bars_sqnc.get_nextval('s_zp_payroll_doc');
         l_zp_payroll_doc.id_pr    := p_id_pr;
         l_zp_payroll_doc.ref      := null;
         l_zp_payroll_doc.source   := p_source;
         l_zp_payroll_doc.crt_date := sysdate;
         l_zp_payroll_doc.id_file  := p_id_file;
         l_zp_payroll_doc.passp_serial := p_passp_serial;
         l_zp_payroll_doc.passp_num    := p_passp_num;
         l_zp_payroll_doc.idcard_num   := p_id_card_num;

         insert into zp_payroll_doc values l_zp_payroll_doc;

  else
         update zp_payroll_doc
         set  s   = p_s*100,
           nlsb   = p_nlsb,
          okpob   = nvl(p_okpob,l_zp_payroll_doc.okpob),
           namb   = nvl(p_namb,l_zp_payroll_doc.namb ),
           mfob   = p_mfob,
           nazn   = p_nazn,
           signed = null,
           passp_serial = p_passp_serial,
           passp_num    = p_passp_num,
           idcard_num   = p_id_card_num
       where id = p_id;

  end if;
end;

--==============================
--видалення документа із відомості
--==============================
procedure del_payroll_doc(p_id  zp_payroll_doc.id%type)
is
l_id zp_payroll.id%type;
begin

    select id_pr into l_id from zp_payroll_doc where id=p_id;

    check_payroll_doc_add(l_id);

    delete zp_payroll_doc
    where id=p_id;

end;

--==============================
--прийняття відомості
--==============================
procedure create_payroll (p_id          zp_payroll.id%type,
                          p_pr_date     zp_payroll.pr_date%type,
                          p_payroll_num zp_payroll.payroll_num%type,
                          p_nazn        zp_payroll.nazn%type
                          )
is

l_zp_payroll zp_payroll%rowtype;

l_cnt number;
l_sos number:=1;

begin

   select * into l_zp_payroll from zp_payroll where id=p_id;

   if l_zp_payroll.sos not in (-1,3,1) then
           raise_application_error(-20000, 'Для підтвердження відомість має бути в статусі "Чернетка"/"Відхилена/Підтверджена"');
   end if;

   select count(distinct source) into l_cnt from zp_payroll_doc
   where id_pr=p_id;

   if l_cnt=0
   then
      l_sos:=3; --відсутні документи - залишаємо статус чернетк
   else

       select source into l_zp_payroll.source from zp_payroll_doc
       where id_pr=p_id
       and id=(select min(id) from zp_payroll_doc where id_pr=p_id);

   end if;

   l_zp_payroll.pr_date     := p_pr_date;
   l_zp_payroll.payroll_num := p_payroll_num;
   l_zp_payroll.nazn        := p_nazn;

   update zp_payroll
   set row = l_zp_payroll
   where id=p_id;



   set_pr_sos(p_id,l_sos);

end;

--==============================
--Копіювання доків з  відомості проплаченої відомості в нову
--==============================
procedure payroll_doc_clone(p_old_id number,p_new_id number)
is
begin

     check_payroll_doc_add(p_new_id);

     for c in (select z.* from zp_payroll_doc z , oper o
                where o.ref=z.ref
                and o.sos=5
                and id_pr=p_old_id)
     loop
          begin
              add_payroll_doc(p_new_id,
                              c.okpob,
                              c.namb,
                              c.mfob,
                              c.nlsb,
                              3,
                              c.nazn,
                              c.s/100,
                              c.passp_serial,
                              c.passp_num);
          exception
           when others then  if sqlcode =-20000 then null; else raise; end if;
          end;
     end loop;
end;
--==============================
--Відмова підтверджувати відомість
--==============================
procedure reject_payroll(p_id zp_payroll.id%type, p_comm  zp_payroll.comm_reject%type)
is
l_zp_payroll zp_payroll%rowtype;
begin

    begin
        select * into l_zp_payroll from zp_payroll
        where id=p_id and sos=2;
    exception when no_data_found
        then raise_application_error(-20000, 'Статус відомості повинен бути - Очікує підтвердження БО ');
    end;

    set_pr_sos(p_id,-1);

    update zp_payroll
    set comm_reject=p_comm,
        reject_user=user_id
    where id=p_id;

    if l_zp_payroll.corp2_id is not null
       then
        insert into zp_payroll_log  values (l_zp_payroll.corp2_id, l_zp_payroll.id, -1,p_comm,sysdate,0);
    end if;

end;


--==============================
--Погашення деб.заборгованості попереднього періоду 3570
--==============================


procedure pay3570 (p_acc accounts.acc%type)
is
l_accounts3570        accounts%rowtype;
l_accounts2909        accounts%rowtype;
l_oper                oper%rowtype;
l_zp_deals            zp_deals%rowtype;

l_ref number;
l_sos number:=null;

l_okpo   customer.okpo%type;

begin

    begin
        select * into l_zp_deals from zp_deals where acc_3570=p_acc and sos>=3;
    exception when no_data_found
        then raise_application_error(-20000, 'Не знайдено діючий зарплатний договір по рахунку 3570');
    end;

    begin
         select * into l_accounts2909 from accounts where acc=l_zp_deals.acc_2909 and dazs is null;
    exception when no_data_found
         then raise_application_error(-20000, 'Не знайдено рахунок 2909 для ЗП договору - '|| l_zp_deals.deal_id||', або рахунок закрито.');
    end;

    begin
         select * into l_accounts3570 from accounts where acc=p_acc and dazs is null;
    exception when no_data_found
         then raise_application_error(-20000, 'Не знайдено рахунок 3570 для ЗП договору - '|| l_zp_deals.deal_id||', або рахунок закрито.');
    end;

    if l_accounts3570.ostc>=0
        then raise_application_error(-20000, 'Відсутня заборгованість по рахунку - '||l_accounts3570.nls);
    end if;

    if l_accounts2909.ostc<-l_accounts3570.ostc
        then raise_application_error(-20000, 'Не достатньо коштів на рахунку - '||l_accounts2909.nls||' для погашення заборгованості на 3570');
    end if;


    l_okpo:= get_okpo(l_zp_deals.rnk);

    l_oper.tt   := 'D66';
    l_oper.vob  := 6;
    l_oper.nd   := l_zp_deals.id;
    l_oper.pdat := sysdate;
    l_oper.vdat := gl.bdate;
    l_oper.dk   := 1;
    l_oper.kv   := l_accounts3570.kv;
    l_oper.s    := -l_accounts3570.ostc;
    l_oper.kv2  := l_accounts3570.kv;
    l_oper.s2   := -l_accounts3570.ostc;
    l_oper.sk   := null;
    l_oper.datp := gl.bdate;

    l_oper.nam_a := substr(l_accounts2909.nms,1,38);
    l_oper.nlsa  := l_accounts2909.nls;
    l_oper.mfoa  := gl.amfo;

    l_oper.nam_b := substr(l_accounts3570.nms,1,38);
    l_oper.nlsb  := l_accounts3570.nls;
    l_oper.mfob  := gl.amfo;

    l_oper.nazn  := substr ( 'Погашення деб.заборгованості попереднього періоду по ЗП проекту - '||l_zp_deals.deal_id,1,160);
    l_oper.d_rec := null;
    l_oper.id_a  := l_okpo;
    l_oper.id_b  := l_okpo;
    l_oper.id_o  := null;
    l_oper.sign  := null;
    l_oper.sos   := 1;
    l_oper.prty  := 0;

    savepoint sp_pay;

    begin

      pay_doc (l_oper);

      gl.pay(2,l_oper.ref,gl.bdate);

    exception when others
      then  rollback to sp_pay;
       raise; -- ловить ерркод и райзе через барсерор
    end;



end;

procedure set_doc_comment_async(p_doc_id      in zp_payroll_doc.id%type,
                                p_doc_comment in zp_payroll_doc.doc_comment%type)
is
  pragma autonomous_transaction;
begin
  update zp_payroll_doc set doc_comment = p_doc_comment where id = p_doc_id;
  commit;
end set_doc_comment_async;

function format_errmsg(p_sqlerrm in varchar2) return varchar2
is
begin
  return regexp_replace(p_sqlerrm, 'ORA-\d{1,}: *','');
end format_errmsg;

--==============================
-- Підтвердження відомості(формування доків та оплата)
--==============================
procedure pay_payroll(p_id       zp_payroll.id%type,
                      p_sign     zp_payroll.sign%type,
                      p_key_id   zp_payroll.key_id%type,
                      p_docbufer varchar2)
is

  l_zp_payroll      zp_payroll%rowtype;
  l_zp_deals        zp_deals%rowtype;
  l_accounts_3570   accounts%rowtype;
  l_accounts_2909   accounts%rowtype;
  l_oper_cms        oper%rowtype;
  l_oper_zp         oper%rowtype;

  l_okpoa           customer.okpo%type;
  l_okpob           customer.okpo%type;

  l_sum_payroll     number;
  l_cms             number;
  l_ob22_6510       accounts.ob22%type;

  l_rnk             customer.rnk%type;

  l_mode            number;

  l_operw_tbl t_operw := t_operw();

  type t_payroll_doc_ref is record (id zp_payroll_doc.id%type, ref zp_payroll_doc.ref%type );
  type t_doc_ref is table of t_payroll_doc_ref;

  l_docref t_doc_ref:=t_doc_ref();

  n                 number;
  l_doc_is_error    boolean := false;
  l_acc_b_rec       accounts%rowtype;
  ex_payroll_locked exception;
  pragma exception_init(ex_payroll_locked, -54);
begin


  -- DBMS_PROFILER.START_PROFILER('ZP DOCS PAY. '||sysdate);


  -- bars_audit.info('zp.pay_payroll.start_pay'||to_char(sysdate,'DD.MM.YYYY HH24:MI:SS') );

    begin
        select * into l_zp_payroll from zp_payroll
        where id=p_id and sos=2
        for update nowait;
    exception 
      when no_data_found then 
        raise_application_error(-20000, 'Статус відомості повинен бути - Очікує підтвердження БО ');
      when ex_payroll_locked then
        raise_application_error(-20000, 'Відомість зараховується іншим користувачем. Оновіть сторінку для актуалізації її статусу.');
    end;

    begin
        select * into l_zp_deals from zp_deals where id=l_zp_payroll.zp_id and sos=5;
    exception when no_data_found
        then raise_application_error(-20000, 'Не знайдено діючий зарплатний договір.');
    end;

    begin
        select * into  l_accounts_3570 from accounts
        where acc= l_zp_deals.acc_3570 and dazs is null;
    exception
        when no_data_found
         then raise_application_error(-20000, 'Не знайдено рахунок 3570 для ЗП договору - '|| l_zp_deals.deal_id||', або рахунок закрито.') ;
    end;

    begin
         select * into l_accounts_2909 from accounts
         where acc=l_zp_deals.acc_2909 and dazs is null;
    exception when no_data_found
         then raise_application_error(-20000, 'Не знайдено рахунок 2909 для ЗП договору - '|| l_zp_deals.deal_id||', або рахунок закрито.');
    end;

    if nbs_ob22_rnk('3570','29',l_accounts_2909.nls,980)<>l_accounts_3570.nls
           then raise_application_error(-20000, 'Для операції 01E не корректно підбираеться рахунок 3570 - '||nbs_ob22_rnk('3570','29',l_accounts_2909.nls,980)||', повинен бути - '||l_accounts_3570.nls);
    end if;


    begin
    select sum(s) into l_sum_payroll from zp_payroll_doc where  id_pr=p_id;
    exception
        when no_data_found
         then raise_application_error(-20000, 'Відсутні документи відомості') ;
    end;


    l_cms:= f_tarif (l_zp_deals.kod_tarif, 980, l_accounts_2909.nls, l_sum_payroll);

    pay_approve (l_zp_deals.deal_premium,l_cms,l_sum_payroll, l_accounts_3570.ostc, l_accounts_2909.ostc, l_mode);

    if l_mode = 0
        then raise_application_error(-20000, 'Недостатньо коштів для оплати відомості');
    end if;

   l_ob22_6510:=get_6510_ob22(l_zp_deals.fs);

   ---подписываем ведомость

    set_payroll_sign(p_id, p_sign ,p_key_id ,p_docbufer);


    begin

       savepoint sp_payroll;


        l_okpoa:= get_okpo(l_zp_deals.rnk);

        l_oper_cms.tt    := case when l_mode=2 then 'D66' when l_mode=1 then '01E' end;
        l_oper_cms.vob   := 6;
        l_oper_cms.nd    := substr(l_zp_deals.id,1,10);
        l_oper_cms.pdat  := sysdate;
        l_oper_cms.vdat  := gl.bdate;
        l_oper_cms.dk    := 1;
        l_oper_cms.kv    := case when l_mode=2 then l_accounts_3570.kv when l_mode=1 then l_accounts_2909.kv end ;
        l_oper_cms.s     := l_cms;
        l_oper_cms.kv2   := case when l_mode=2 then l_accounts_3570.kv when l_mode=1 then l_accounts_2909.kv end ;
        l_oper_cms.s2    := l_cms;
        l_oper_cms.sk    := null;
        l_oper_cms.datp  := gl.bdate;

        l_oper_cms.nam_a := case when l_mode=2 then  substr(l_accounts_3570.nms,1,38) when l_mode=1 then  substr(l_accounts_2909.nms,1,38) end ;
        l_oper_cms.nlsa  := case when l_mode=2 then  l_accounts_3570.nls when l_mode=1 then  l_accounts_2909.nls end ;
        l_oper_cms.mfoa  := gl.amfo;

        l_oper_cms.nlsb  := nbs_ob22 ('6510',l_ob22_6510);

           begin
              select substr(nms,1,38),rnk into l_oper_cms.nam_b,l_rnk  from accounts where nls=l_oper_cms.nlsb and kv=980 and dazs is null;
           exception
              when no_data_found
               then rollback to sp_payroll;
               raise_application_error(-20000, 'Не знайдено рахунок 6510  - '|| l_oper_cms.nlsb||', або рахунок закрито.') ;
            end;

        l_okpob:=get_okpo(l_rnk);

        l_oper_cms.mfob  := gl.amfo;


        l_oper_cms.nazn  := substr ('Оплата комісії за зарахування заробітної плати по ЗП проекту - '||l_zp_deals.deal_id||', в рамках відомості - '||l_zp_payroll.payroll_num,1,160);
        l_oper_cms.d_rec := null;
        l_oper_cms.id_a  := l_okpoa;
        l_oper_cms.id_b  := l_okpob;
        l_oper_cms.id_o  := null;
        l_oper_cms.sign  := null;
        l_oper_cms.sos   := 1;
        l_oper_cms.prty  := 0;



        if l_accounts_3570.ostc<0
         then
            pay3570 (l_accounts_3570.acc);
        end if;

        pay_doc (l_oper_cms);

        gl.pay(2,l_oper_cms.ref,gl.bdate);


        update zp_payroll
        set ref_cms=l_oper_cms.ref
        where id=p_id;

        for c in  (select * from zp_payroll_doc where id_pr = p_id) loop
          begin

            if l_zp_payroll.corp2_id is null
              then
                begin
                    select 1 into n
                    from banks_ru
                    where mfo=c.mfob;
                exception when no_data_found then
                    raise_application_error(-20000, 'МФО отримувача має бути в Ощадбанку');
                end;
            end if;

           l_oper_zp.nlsb := c.nlsb;

            if   c.mfob=gl.amfo then
              l_rnk := null;
              begin
                select substr(nms,1,38), rnk into l_oper_zp.nam_b, l_rnk from accounts where nls=l_oper_zp.nlsb and kv=980 and dazs is null;
              exception
                when no_data_found then
                  rollback to sp_payroll;
                  raise_application_error(-20000, 'Не знайдено рахунок  - '|| c.nlsb||', або рахунок закрито.') ;
              end;

              begin
                select 1 into n
                from customer
                where rnk=l_rnk and okpo=c.okpob;
              exception when no_data_found then
                raise_application_error(-20000, 'ОКПО клієнта - '||c.okpob||' не відповідає рахунку - '||l_oper_zp.nlsb);
              end ;
            else
                l_oper_zp.nam_b:=substr(c.namb,1,38);
            end if;

            if c.mfob=gl.amfo then

                  select *
                    into l_acc_b_rec
                    from bars.accounts
                   where nls = l_oper_zp.nlsb
                     and kv = l_accounts_2909.kv;

              if l_acc_b_rec.tip like 'W4%' and  l_zp_payroll.corp2_id is null
                then
                  l_oper_zp.tt    := 'PKS';
              elsif l_acc_b_rec.tip not like 'W4%' and l_zp_payroll.corp2_id is null
                then
                 l_oper_zp.tt    := 'DBF';

              elsif l_acc_b_rec.tip like 'W4%' and  l_zp_payroll.corp2_id is not null
                then
                 l_oper_zp.tt    := 'IB5';

              elsif l_acc_b_rec.tip not like 'W4%' and l_zp_payroll.corp2_id is  not null
                then
                 l_oper_zp.tt    := 'IB1';
              else
                 rollback to sp_payroll;
                 raise_application_error(-20000, 'Номер рахунку отримувача не 2625/20') ;
              end if;
            else
              if substr(c.nlsb,1,4) in ('2620','2625') and l_zp_payroll.corp2_id is null
                then
                 l_oper_zp.tt    := '310';
              elsif substr(c.nlsb,1,4) in ('2620','2625') and l_zp_payroll.corp2_id is  not null
                then
                 l_oper_zp.tt    := 'IB2';
              else
                 rollback to sp_payroll;
                 raise_application_error(-20000, 'Номер рахунку отримувача не 2625/20') ;
              end if;
            end if;


            l_oper_zp.vob   := 6;
            l_oper_zp.nd    := l_zp_deals.id;
            l_oper_zp.pdat  := sysdate;
            l_oper_zp.vdat  := gl.bdate;
            l_oper_zp.dk    := 1;
            l_oper_zp.kv    := l_accounts_2909.kv;
            l_oper_zp.s     := c.s;
            l_oper_zp.kv2   := l_accounts_2909.kv;
            l_oper_zp.s2    := c.s;
            l_oper_zp.sk    := null;
            l_oper_zp.datp  := gl.bdate;

            l_oper_zp.nam_a := substr(l_accounts_2909.nms,1,38);
            l_oper_zp.nlsa  := l_accounts_2909.nls;
            l_oper_zp.mfoa  := gl.amfo;
            l_oper_zp.mfob  := c.mfob;

            l_oper_zp.nazn  := substr (c.nazn,1,160);
            l_oper_zp.id_a  := l_okpoa;
            l_oper_zp.id_b  := c.okpob;

            if l_oper_zp.id_b = '0000000000' then
              l_oper_zp.d_rec := '#ф'||c.passp_serial||c.passp_num||'#';
            end if;

            l_oper_zp.id_o  := null;
            l_oper_zp.sign  := null;
            l_oper_zp.sos   := 1;
            l_oper_zp.prty  := 0;

            pay_doc (l_oper_zp);

                if  c.mfob=gl.amfo and substr(c.nlsb,1,4)='2620'
                then
                    fill_operw_tbl(l_operw_tbl, l_oper_zp.ref, 'SK_ZB', '84');
                end if;

            l_docref.extend;
            l_docref(l_docref.count).id  := c.id;
            l_docref(l_docref.count).ref := l_oper_zp.ref;

            if   c.mfob=gl.amfo
              then
                    gl.pay(2,l_oper_zp.ref,gl.bdate);
            end if;
          exception
            when others then
              set_doc_comment_async(p_doc_id      => c.id,
                                    p_doc_comment => format_errmsg(sqlerrm));
              l_doc_is_error := true;
              --raise;
          end;
        end loop;

        if l_doc_is_error then
          raise_application_error(-20000, 'Відомість не зараховано. Виникли помилки оплати документів');
        end if;

        forall i in 1 .. l_operw_tbl.count
        insert into operw values l_operw_tbl(i);

        forall i in 1 .. l_docref.count

        update zp_payroll_doc
        set   ref= l_docref(i).ref
        where  id= l_docref(i).id;

        set_pr_sos(p_id,5);



    exception when others
      then  rollback to sp_payroll;
          raise_application_error(-20000, sqlerrm); -- ловить ерркод и райзе через барсерор
    end;

     l_operw_tbl.delete();
     l_operw_tbl := null;
     l_docref.delete();
     l_docref := null;

     --для ведомостей корпа пишем лог для ответа

     if l_zp_payroll.corp2_id is not null
       then
        insert into zp_payroll_log  values (l_zp_payroll.corp2_id, l_zp_payroll.id, 1,null,sysdate,0);
     end if;

   -- bars_audit.info('zp.pay_payroll.finish_pay'||to_char(sysdate,'DD.MM.YYYY HH24:MI:SS') );

   -- DBMS_PROFILER.STOP_PROFILER;

end pay_payroll;

--==============================
--імпорт файлу відомості
--==============================
procedure payroll_imp(p_id_pr            zp_payroll.id%type,
                      p_file_name        zp_payroll_imp_files.file_name%type,
                      p_clob             blob,
                      p_encoding         varchar2 ,
                      p_nazn             varchar2,
                      p_id_dbf_type      number   ,
                      p_file_type        varchar2,
                      p_nlsb_map         varchar2 default null,
                      p_s_map            varchar2 default null,
                      p_okpob_map        varchar2 default null,
                      p_mfob_map         varchar2 default null,
                      p_namb_map         varchar2 default null,
                      p_nazn_map         varchar2 default null,
                      p_save_draft       varchar2 default null,
                      p_sum_delimiter    number   default 1,
                      p_err          out varchar2 ) --в грн 1 , копейки - 100
is

l_zp_pr_imp            zp_payroll_imp_files%rowtype;
l_zp_payroll_imp_dbf   zp_payroll_imp_dbf%rowtype;
n                      number;
l_rcnt                 number;
l_sql                  varchar2(4000):='select :id,s_for_replace ,okpob_for_replace ,namb_for_replace ,mfob_for_replace ,nlsb_for_replace ,null ,nazn_for_replace  from TMP_ZP_DBF_IMP';
l_tab_name             varchar2(4000) :='TMP_ZP_DBF_IMP';
type l_zp_payroll_imp_doc_err is table of zp_payroll_imp_doc_err%rowtype;
l_tab                  l_zp_payroll_imp_doc_err :=l_zp_payroll_imp_doc_err();

p_blob blob;

l_id_dbf_type number;

l_name varchar2(400);
l_id number;

l_encoding varchar2(6);

ex_u    exception;
pragma exception_init(ex_u, -00001);

begin

p_blob:=p_clob;

 if p_save_draft is not null
 then
    begin
        select 1 into n from bars.v_zp_payroll_imp_dbf
        where name=p_save_draft;

        if n=1
          then
             raise_application_error(-20000, 'Неможливо зберегти шаблон. Шаблон з такою назвою вже існує.');
        end if;

    exception
      when no_data_found then null;

      when too_many_rows then

             raise_application_error(-20000, 'Неможливо зберегти шаблон. Шаблон з такою назвою вже існує.');

    end ;

  end if;

    begin
        select 1 into n from zp_payroll_imp_files
        where id_pr=p_id_pr
        and file_name=p_file_name
        and sos not in (2,3);

        if n=1
          then
             raise_application_error(-20000, 'Неможливо  імпортувати файл. Файл з такою назвою вже імпортовано.');
        end if;

    exception
      when no_data_found then null;
    end ;

   l_zp_pr_imp.id         := bars_sqnc.get_nextval('s_zp_pr_imp_files');
   l_zp_pr_imp.id_pr      := p_id_pr;
   l_zp_pr_imp.imp_date   := sysdate;
   l_zp_pr_imp.file_name  := p_file_name;
   l_zp_pr_imp.sos        := 0;--"Loading"
   l_zp_pr_imp.file_blob  := p_blob;
   l_zp_pr_imp.file_clob  := blob_to_clob(p_blob);
   l_zp_pr_imp.file_type  := p_file_type;


   insert into zp_payroll_imp_files values l_zp_pr_imp;

   l_zp_pr_imp.cnt_doc_reject:=0;
    l_zp_pr_imp.cnt_doc:=0;

  begin



        if p_file_type in ('DBF','DBFPREV') then

                if nvl(p_id_dbf_type,0)=0
                 then
                  l_encoding:=p_encoding;
                else
                  select  encoding into l_encoding from  zp_payroll_imp_dbf where doc_col_name='S' and id=p_id_dbf_type;
                end if;

               bars_dbf.load_dbf(
                                p_dbfblob    =>  p_blob,
                                p_tabname    =>  l_tab_name,
                                p_createmode =>  1,
                                p_srcencode  =>  l_encoding,
                                p_destencode => 'WIN');


               if p_file_type='DBFPREV'
                  then

                  if p_nlsb_map is null or p_s_map is null
                     then
                             raise_application_error(-20000, 'Не задано маппінг для рахунку отримувача/суми');
                  end if;

                  if p_save_draft is null then

                      delete zp_payroll_imp_dbf
                      where  id=-99999;

                      l_name:='Базовий шаблон';
                      l_id:=-99999;

                  else
                      l_name:=p_save_draft;
                      select max(id) +1 into l_id from zp_payroll_imp_dbf;

                  end if;

                  begin

                       insert into zp_payroll_imp_dbf(id,name,file_col_name,doc_col_name,sum,branch) values (l_id,l_name,p_nlsb_map,'NLSB',0,sys_context('bars_context','user_branch'));
                       insert into zp_payroll_imp_dbf(id,name,file_col_name,doc_col_name,sum,branch,encoding) values (l_id,l_name,p_s_map,'S',p_sum_delimiter,sys_context('bars_context','user_branch'),p_encoding);

                       if p_okpob_map     is not null
                         then
                       insert into zp_payroll_imp_dbf(id,name,file_col_name,doc_col_name,sum,branch) values (l_id,l_name,p_okpob_map,'OKPOB',0,sys_context('bars_context','user_branch'));
                       end if;
                       if p_mfob_map     is not null
                         then
                       insert into zp_payroll_imp_dbf(id,name,file_col_name,doc_col_name,sum,branch) values (l_id,l_name,p_mfob_map,'MFOB',0,sys_context('bars_context','user_branch'));
                       end if;
                       if p_namb_map     is not null
                         then
                       insert into zp_payroll_imp_dbf(id,name,file_col_name,doc_col_name,sum,branch) values (l_id,l_name,p_namb_map,'NAMB',0,sys_context('bars_context','user_branch'));
                       end if;
                       if p_nazn_map     is not null
                         then
                       insert into zp_payroll_imp_dbf(id,name,file_col_name,doc_col_name,sum,branch) values (l_id,l_name,p_nazn_map,'NAZN',0,sys_context('bars_context','user_branch'));
                       end if;
                  exception when ex_u then
                      raise_application_error(-20000, 'Одне поле файлу не може одночасно відноситись до декількох полів ЗП відомості');
                  end;

               end if;

              l_id_dbf_type:=nvl(p_id_dbf_type,l_id);


                for c in (select column_name, column_id from all_tab_columns
                  where table_name='TMP_ZP_DBF_IMP'
                  order by column_id)
                loop


                      begin
                          select id,doc_col_name,sum into l_zp_payroll_imp_dbf.id, l_zp_payroll_imp_dbf.doc_col_name ,l_zp_payroll_imp_dbf.sum
                          from  zp_payroll_imp_dbf
                          where file_col_name =c.column_name
                          and id=l_id_dbf_type;

                              if    l_zp_payroll_imp_dbf.doc_col_name='S'
                                then
                                l_sql:= replace(l_sql,'s_for_replace',c.column_name||'/'||l_zp_payroll_imp_dbf.sum);
                              elsif l_zp_payroll_imp_dbf.doc_col_name='NAMB'
                                then
                                l_sql:= replace(l_sql,'namb_for_replace',c.column_name);
                              elsif l_zp_payroll_imp_dbf.doc_col_name='OKPOB'
                                then
                                l_sql:= replace(l_sql,'okpob_for_replace',c.column_name);
                              elsif l_zp_payroll_imp_dbf.doc_col_name='MFOB'
                                then
                                l_sql:= replace(l_sql,'mfob_for_replace',c.column_name);
                              elsif l_zp_payroll_imp_dbf.doc_col_name='NLSB'
                                then
                                l_sql:= replace(l_sql,'nlsb_for_replace',c.column_name);
                              elsif l_zp_payroll_imp_dbf.doc_col_name='NAZN'
                                then
                                l_sql:= replace(l_sql,'nazn_for_replace',c.column_name);
                              end if;
                      exception
                              when no_data_found
                              then null;
                      end;
                end loop;

                l_sql:=replace (l_sql,'namb_for_replace', 'null');
                l_sql:=replace (l_sql,'okpob_for_replace','null');
                l_sql:=replace (l_sql,'mfob_for_replace', 'null');
                l_sql:=replace (l_sql,'nazn_for_replace', 'null');

                bars_audit.info('zp.payroll_imp.sql-'||l_sql);

                if instr(l_sql,'s_for_replace')>0 or instr(l_sql,'nlsb_for_replace')>0
                 then   l_zp_pr_imp.err_text:='В довіднику некоректно описана струткутура файлу(відсутні сума/номер рахунку) або файл не відповідає шаблону';
                        l_zp_pr_imp.sos:= 2;
                        p_err:=l_zp_pr_imp.err_text;
                end if;


                if l_zp_pr_imp.err_text is null then
                    execute immediate l_sql  bulk collect into l_tab using l_zp_pr_imp.id;
                end if;


       elsif p_file_type='EXCEL' then

            select max(row_nr)-1 into l_rcnt from table( as_read_xlsx.read(p_blob)) ;

            l_tab.extend(l_rcnt);


            begin
                select count(*) into n from table( as_read_xlsx.read(p_blob))
                where row_nr=1
                and   col_nr=1 and string_val='Ідентифікаційний код'
                or(   col_nr=2 and string_val='ПІБ')
                or(    col_nr=3 and string_val='Картковий рахунок')
                or(    col_nr=4 and string_val='Сума(в грн.)')
                or(    col_nr=5 and string_val='МФО')
                or(    col_nr=6 and string_val='Призначення' );

                if n<>6 then
                        l_zp_pr_imp.err_text:='Невірний формат файлу, або невідповідна структура файлу';
                        l_zp_pr_imp.sos:= 2;
                        p_err:=l_zp_pr_imp.err_text;
                end if;


            exception when no_data_found
                 then   l_zp_pr_imp.err_text:='Невірний формат файлу, або невідповідна структура файлу';
                        l_zp_pr_imp.sos:= 2;
                        p_err:=l_zp_pr_imp.err_text;
            end;

            for c in (select * from table( as_read_xlsx.read(p_blob)) where row_nr>1 order by row_nr )
            loop

                if    c.col_nr=1 then l_tab(c.row_nr-1).okpob :=c.number_val;
                elsif c.col_nr=2 then l_tab(c.row_nr-1).namb  :=c.string_val;
                elsif c.col_nr=3 then l_tab(c.row_nr-1).nlsb  :=c.number_val;
                elsif c.col_nr=4 then l_tab(c.row_nr-1).s     :=c.number_val;
                elsif c.col_nr=5 then l_tab(c.row_nr-1).mfob  :=coalesce(c.number_val,c.string_val);
                                      --bars_audit.info('zp.imp_test c.number_val='||to_char(c.number_val)||', c.string_val'||c.string_val);
                elsif c.col_nr=6 then l_tab(c.row_nr-1).nazn  :=c.string_val;
                end if;

                l_tab(c.row_nr-1).id_file:=l_zp_pr_imp.id;

            end loop;

       end if;

       if l_zp_pr_imp.err_text is null then
              for    i in l_tab.first .. l_tab.last
              loop

                  if l_tab(i).s is null or l_tab(i).nlsb is null
                  then
                      l_tab(i).err_text:='Значення суми та номер рахунку не можуть бути пустими або містити недопустимі символи';
                  else
                      if l_tab(i).mfob is null
                      then
                         l_tab(i).mfob:=f_ourmfo();
                      end if;

                      if l_tab(i).nazn is null
                       then
                           l_tab(i).nazn:=p_nazn;
                      end if;

                      begin
                          zp.add_payroll_doc(p_id_pr,
                                          l_tab(i).okpob,
                                          l_tab(i).namb,
                                          l_tab(i).mfob,
                                          l_tab(i).nlsb,
                                          2,
                                          l_tab(i).nazn,
                                          l_tab(i).s,
                                          null,
                                          l_zp_pr_imp.id);
                      exception
                       when others then
                           if sqlcode =-20000
                             then l_tab(i).err_text:=replace(sqlerrm,'ORA-20000: ','');
                           else
                              raise;
                           end if;
                      end;

                  end if;

                  if l_tab(i).err_text is null
                   then
                     l_tab.delete(i);

                     l_zp_pr_imp.cnt_doc:=l_zp_pr_imp.cnt_doc+1;
                  end if;

              end loop;

             l_zp_pr_imp.cnt_doc_reject:=l_tab.count;

             forall j in indices of l_tab

             insert into zp_payroll_imp_doc_err values l_tab(j) ;

             l_tab.delete();
             l_tab := null;

             l_zp_pr_imp.sos:= 1;


       end if;

  exception when others
      then
         l_zp_pr_imp.sos:= 2;
         l_zp_pr_imp.err_text:=substr( sqlerrm,1,2000);

         p_err:=l_zp_pr_imp.err_text;
  end;


     update zp_payroll_imp_files
     set row = l_zp_pr_imp
     where id=l_zp_pr_imp.id;


end;
--==============================
--Видалення імпортованого файла відомості
--==============================
procedure payroll_imp_del(p_id zp_payroll_imp_files.id%type)
 is

 n    number;
 l_id number;
begin

    select id_pr into l_id from zp_payroll_imp_files where id=p_id;
    check_payroll_doc_add(l_id);

    select count(*) into n from zp_payroll_doc
    where  ref is not null
    and id_file=p_id;

    if n>0 then

    raise_application_error(-20000, 'Неможливо видалити імпортований файл. Є введені документи.');

    end if;

    update zp_payroll_imp_files
    set sos=3
    where id=p_id;

    delete zp_payroll_imp_doc_err
    where id_file=p_id;

    for c in (select * from  zp_payroll_doc
             where id_file=p_id)
        loop
            del_payroll_doc(c.id);
        end loop;
end;

--удаление записи из справочника
procedure del_deals_fs(p_id number)
is
begin
update zp_deals_fs set date_close=trunc(sysdate) where id=p_id;
end;

procedure prev_dbf_load(  p_blob             blob,
                          p_encoding         varchar2
)
is
l_tab_name             varchar2(4000) :='TMP_ZP_DBF_IMP_PREV';
begin
                      bars_dbf.load_dbf(
                                        p_dbfblob    =>  p_blob,
                                        p_tabname    =>  l_tab_name,
                                        p_createmode =>  1,
                                        p_srcencode  =>  p_encoding,
                                        p_destencode => 'WIN');
end prev_dbf_load;

--==============================
--Запрос на буфер документов по ведомости
--==============================

function get_docs_buffer (p_id zp_payroll.id%type)
      return docs_buffer_set
      pipelined
     is
        l_docs_buffer_rec  docs_buffer_rec;
    begin

        for c in (  select d.id ,
                      nvl(rpad(substr(z.zp_deal_id,1,30),30),rpad(' ',30))
                    ||nvl(rpad(substr(z.id,1,30),30),rpad(' ',30))
                    ||nvl(to_char(trunc(sysdate),'YYMMDD'),rpad(' ',6))
                    ||nvl(lpad(z.kf,9),rpad(' ',9))
                    ||nvl(lpad('980',3),rpad(' ',3))
                    ||nvl(lpad(to_char(s),16),rpad(' ',16))
                    ||nvl(rpad(d.namb,38),rpad(' ',38))
                    ||nvl(lpad(d.mfob,9),rpad(' ',9))
                    ||nvl(lpad(d.nlsb,14),rpad(' ',14))
                    ||nvl(rpad(d.nazn,160),rpad(' ',160))
                    ||nvl(rpad(substr(z.payroll_num,1,50),50),rpad(' ',50)) buf
                    from zp_payroll_doc d ,zp_payroll z
                    where d.id_pr=z.id
                    and z.id=p_id
                    and d.signed is null
                 )
        loop
            l_docs_buffer_rec.id          := c.id;
            l_docs_buffer_rec.doc_buffer  := rawtohex(utl_raw.cast_to_raw(c.buf));
            pipe row (l_docs_buffer_rec);
        end loop;

end get_docs_buffer;

--==============================
--Запрос на буфер ведомости
--==============================


function get_payroll_buffer (p_id zp_payroll.id%type)
     return varchar2
is
     l_buf varchar2(730);
begin

     select
      nvl(rpad(substr(z.zp_deal_id,1,30),30),rpad(' ',30))
    ||nvl(rpad(substr(z.deal_name,1,50),50),rpad(' ',50))
    ||nvl(rpad(substr(z.id,1,30),30),rpad(' ',30))
    ||nvl(to_char(trunc(sysdate),'YYMMDD'),rpad(' ',6))
    ||nvl(rpad(substr(z.payroll_num,1,50),50),rpad(' ',50))
    ||nvl(rpad(to_char(z.cnt),16),rpad(' ',16))
    ||nvl(rpad(to_char(z.s*100),16),rpad(' ',16))
    ||nvl(rpad(to_char(z.cms*100),16),rpad(' ',16))
    ||nvl(rpad(substr(z.nmk,1,151),151),rpad(' ',151))
    into l_buf
    from v_zp_payroll z
    where z.id=p_id;

    l_buf  := rawtohex(utl_raw.cast_to_raw(l_buf));
    return l_buf;

end get_payroll_buffer;

function get_user_key_id
   return varchar2
is
   l_key_id  staff$base.tabn%type;
begin

    select tabn into l_key_id  from staff$base
    where tabn is not null
    and id=user_id;

    return l_key_id;

exception
when no_data_found
    then   raise_application_error(-20000, 'По користувачу не знайдено ключ для підпису');
end get_user_key_id;

procedure set_central(p_mfo varchar2,p_nls varchar2, p_central number)
is
begin


    if     p_central=1
      then
      begin
        insert into  OW_IIC_MSGCODE (tt,mfoa,nlsa,msgcode) values ('R01',p_mfo,p_nls,'PAYSAL');
      exception when dup_val_on_index
        then null;
      end;
    elsif  p_central=0
      then
        delete OW_IIC_MSGCODE
        where nlsa=p_nls and mfoa=p_mfo and msgcode='PAYSAL' and tt='R01';
    end if;

end;

  -----------------------------------------------------------------------------------------
  --  get_doc_person
  --
  --    Метод повертає паспортні дані клієнта по рахунку
  --
  --      p_nls - Вхідний параметр рахунок клієнта (2625)
  --      p_okpo        - ІПН клієнта (out)
  --      p_nmk         - ПІБ клієнта (out)
  --      p_pass_serial - Серія паспорта (out)
  --      p_pass_num    - Номер паспорта (out)
  --      p_pass_card   - Номер паспорта у вигляді картки (out)
  --      p_actual_date - Дата актуальності паспорта у вигляді картки (out)
  --
  procedure get_doc_person(p_nls in accounts.nls%type,
                           p_okpo        out customer.okpo%type,
                           p_nmk         out customer.nmk%type,
                           p_pass_serial out person.ser%type,
                           p_pass_num    out person.numdoc%type,
                           p_pass_card   out person.numdoc%type,
                           p_actual_date out person.actual_date%type)
  is 
  begin
    for i in (select c.okpo, 
                     c.nmk,
                     p.ser,
                     p.numdoc,
                     p.actual_date,
                     p.passp
              from accounts a
                   inner join customer c on c.rnk = a.rnk 
                   left join person p on p.rnk = c.rnk
              where a.nls = p_nls
                    and a.kv = 980)
    loop
      -- якщо паспорт старого зразка
      if i.passp in (1) then
        p_pass_serial := i.ser;
        p_pass_num    := i.numdoc;
      -- якщо паспорт нового зразка
      elsif i.passp in (7) then
        p_pass_card   := i.numdoc;
        p_actual_date := i.actual_date;
      else
        null;
      end if;
      -- ОКПО і назву заповнюю в любому випадку, якщо є
      p_okpo := i.okpo;
      p_nmk  := i.nmk;

      exit;
    end loop;
  end get_doc_person;

begin
  init;
end zp;
/
show err;

grant execute on bars.zp to  bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/package/zp.sql =========*** End *** 
PROMPT ===================================================================================== 
