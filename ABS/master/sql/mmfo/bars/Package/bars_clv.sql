
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_clv.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_CLV 
is

g_header_version  constant varchar2(64)  := 'version 1.0 11/12/2014';
g_header_defs     constant varchar2(512) := '';

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

-------------------------------------------------------------------------------
--procedure new_request ( p_clv in out clv_customer%rowtype );
procedure new_request (p_rnk in out number);

procedure set_req_customer (p_clv in clv_customer%rowtype);

procedure set_req_customeren (p_clv in clv_customer%rowtype);

procedure set_req_customeraddress (p_clv in clv_customer_address%rowtype);

procedure set_req_customerw (p_clv in clv_customerw%rowtype);

procedure set_req_customercorp (p_clv in clv_corps%rowtype);

procedure set_req_customercorpacc (p_clv in clv_corps_acc%rowtype);

procedure set_req_customerperson (p_clv in clv_person%rowtype);

procedure set_req_customerrel (p_clv in clv_customer_rel%rowtype);

procedure set_req_customerrisk (p_clv in clv_customer_risk%rowtype);

procedure set_customer_visa (p_rnk number, p_status number);

function found_request (p_rnk in number, p_request out clv_request%rowtype) return boolean;

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_CLV 
is

--
-- constants
--
g_body_version    constant varchar2(64)  := 'version 1.0 11/12/2014';
g_body_defs       constant varchar2(512) := '';

g_modcode         constant varchar2(3)   := 'CLV';
g_pkbcode         constant varchar2(100) := 'bars_clv';

-- типы запросов
g_reqtype_new     constant number(1) := 0;  -- создание нового клиента
g_reqtype_change  constant number(1) := 1;  -- изменение параметров существующего клиента
g_reqtype_reject  constant number(1) := 2;  -- создание нового клиента отклюнено

-- статусы запросов
g_status_reject   constant number(1) := 0;  -- запрос отклонен
g_status_approve  constant number(1) := 1;  -- запрос подтвержден
g_status_change   constant number(1) := 2;  -- запрос отредактирован

-------------------------------------------------------------------------------
-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header ' || g_pkbcode || ' ' || g_header_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      ||  g_header_defs;
end header_version;

-------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body ' || g_pkbcode || ' ' || g_body_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      || g_body_defs;
end body_version;


-------------------------------------------------------------------------------
procedure set_req_customer (p_clv in clv_customer%rowtype)
is
  i number;
begin
  begin
     select 1 into i from clv_customer where rnk = p_clv.rnk;
     update clv_customer
        set custtype  = p_clv.custtype,
            codcagent = p_clv.codcagent,
            country   = p_clv.country,
            tgr       = p_clv.tgr,
            nmk       = p_clv.nmk,
            nmkv      = p_clv.nmkv,
            nmkk      = p_clv.nmkk,
            okpo      = p_clv.okpo,
            adr       = p_clv.adr,
            prinsider = p_clv.prinsider,
            sab       = p_clv.sab,
            c_reg     = p_clv.c_reg,
            c_dst     = p_clv.c_dst,
            adm       = p_clv.adm,
            rgadm     = p_clv.rgadm,
            datea     = p_clv.datea,
            rgtax     = p_clv.rgtax,
            datet     = p_clv.datet,
            stmt      = p_clv.stmt,
            notes     = p_clv.notes,
            notesec   = p_clv.notesec,
            crisk     = p_clv.crisk,
            nd        = p_clv.nd,
            rnkp      = p_clv.rnkp,
            ise       = p_clv.ise,
            fs        = p_clv.fs,
            oe        = p_clv.oe,
            ved       = p_clv.ved,
            sed       = p_clv.sed,
            k050      = p_clv.k050,
            branch    = p_clv.branch,
            isp       = p_clv.isp,
            taxf      = p_clv.taxf,
            nompdv    = p_clv.nompdv,
            nrezid_code = p_clv.nrezid_code
      where rnk = p_clv.rnk;
  exception when no_data_found then
     insert into clv_customer values p_clv;
  end;
end set_req_customer;


-------------------------------------------------------------------------------
procedure set_req_customeren (p_clv in clv_customer%rowtype)
is
begin
  update clv_customer
     set ise  = p_clv.ise,
         fs   = p_clv.fs,
         ved  = p_clv.ved,
         oe   = p_clv.oe,
         k050 = p_clv.k050,
         sed  = p_clv.sed
   where rnk = p_clv.rnk;
end set_req_customeren;

-------------------------------------------------------------------------------
procedure set_req_customeraddress (p_clv in clv_customer_address%rowtype)
is
  i number;
begin
  if     p_clv.country is null
     and p_clv.zip     is null
     and p_clv.domain  is null
     and p_clv.region  is null
     and p_clv.locality is null
     and p_clv.address  is null
     and p_clv.territory_id is null
  then
     delete from clv_customer_address where rnk = p_clv.rnk and type_id = p_clv.type_id;
  else
     begin
        select 1 into i from clv_customer_address where rnk = p_clv.rnk and type_id = p_clv.type_id;
        update clv_customer_address
           set country 		= p_clv.country,
               zip     		= p_clv.zip,
               domain  		= p_clv.domain,
               region  		= p_clv.region,
               locality 	= p_clv.locality,
               address  	= p_clv.address,
               territory_id = p_clv.territory_id,
			   locality_type = p_clv.locality_type,
			   street_type   = p_clv.street_type,
			   street        = p_clv.street,
			   home_type     = p_clv.home_type,
			   home          = p_clv.home,
			   homepart_type = p_clv.homepart_type,
			   homepart      = p_clv.homepart,
			   room_type     = p_clv.room_type,
			   room          = p_clv.room,
			   comm			 = p_clv.comm
		where rnk = p_clv.rnk
           and type_id = p_clv.type_id;
     exception when no_data_found then
        insert into clv_customer_address values p_clv;
     end;
  end if;
end set_req_customeraddress;


-------------------------------------------------------------------------------
procedure set_req_customerw (p_clv in clv_customerw%rowtype)
is
  i number;
begin
  if p_clv.value is null then
     delete from clv_customerw where rnk = p_clv.rnk and tag = p_clv.tag;
  else
     begin
        select 1 into i from clv_customerw where rnk = p_clv.rnk and tag = p_clv.tag;
        update clv_customerw
           set value  = p_clv.value
         where rnk = p_clv.rnk
           and tag = p_clv.tag;
     exception when no_data_found then
        insert into clv_customerw values p_clv;
     end;
  end if;
end set_req_customerw;


-------------------------------------------------------------------------------
procedure set_req_customercorp (p_clv in clv_corps%rowtype)
is
  i number;
begin
  begin
     select 1 into i from clv_corps where rnk = p_clv.rnk;
     update clv_corps
        set nmku = p_clv.nmku,
            ruk  = p_clv.ruk,
            telr = p_clv.telr,
            buh  = p_clv.buh,
            telb = p_clv.telb,
            tel_fax = p_clv.tel_fax,
            e_mail  = p_clv.e_mail,
            seal_id = p_clv.seal_id
      where rnk = p_clv.rnk;
  exception when no_data_found then
     insert into clv_corps values p_clv;
  end;
end set_req_customercorp;


-------------------------------------------------------------------------------
procedure set_req_customercorpacc (p_clv in clv_corps_acc%rowtype)
is
  l_id number;
begin
  if p_clv.rnk is null then
     delete from clv_corps_acc where id = p_clv.id;
  else
     l_id := case when p_clv.id is null then s_corps_acc.nextval else p_clv.id end;
     begin
        insert into clv_corps_acc (rnk, id, mfo, nls, kv, comments)
        values (p_clv.rnk, l_id, p_clv.mfo, p_clv.nls, p_clv.kv, p_clv.comments);
     exception when dup_val_on_index then
        update clv_corps_acc
           set mfo = p_clv.mfo,
               nls = p_clv.nls,
               kv  = p_clv.kv,
               comments = p_clv.comments
         where id = l_id;
     end;
  end if;
end set_req_customercorpacc;


-------------------------------------------------------------------------------
procedure set_req_customerperson (p_clv in clv_person%rowtype)
is
  i number;
begin
  begin
     select 1 into i from clv_person where rnk = p_clv.rnk;
     update clv_person
        set sex    = p_clv.sex,
            passp  = p_clv.passp,
            ser    = p_clv.ser,
            numdoc = p_clv.numdoc,
            pdate  = p_clv.pdate,
            organ  = p_clv.organ,
            bday   = p_clv.bday,
            bplace = p_clv.bplace,
            teld   = p_clv.teld,
            telw   = p_clv.telw
      where rnk = p_clv.rnk;
  exception when no_data_found then
     insert into clv_person values p_clv;
  end;
end set_req_customerperson;


-------------------------------------------------------------------------------
procedure set_req_customerrel (p_clv in clv_customer_rel%rowtype)
is
  i number;
begin
  if p_clv.rel_intext is null then
     delete from clv_customer_rel where rnk = p_clv.rnk and rel_id = p_clv.rel_id and rel_rnk = p_clv.rel_rnk;
  else
     begin
        select 1 into i from clv_customer_rel where rnk = p_clv.rnk and rel_id = p_clv.rel_id and rel_rnk = p_clv.rel_rnk;
        update clv_customer_rel
           set vaga1 = p_clv.vaga1,
               vaga2 = p_clv.vaga2,
               type_id  = p_clv.type_id,
               position = p_clv.position,
               first_name  = p_clv.first_name,
               middle_name = p_clv.middle_name,
               last_name   = p_clv.last_name,
               document_type_id = p_clv.document_type_id,
               document = p_clv.document,
               trust_regnum = p_clv.trust_regnum,
               trust_regdat = p_clv.trust_regdat,
               bdate = p_clv.bdate,
               edate = p_clv.edate,
               notary_name   = p_clv.notary_name,
               notary_region = p_clv.notary_region,
               sign_privs = p_clv.sign_privs,
               sign_id = p_clv.sign_id,
               name_r = p_clv.name_r
         where rnk     = p_clv.rnk
           and rel_id  = p_clv.rel_id
           and rel_rnk = p_clv.rel_rnk;
     exception when no_data_found then
        insert into clv_customer_rel values p_clv;
     end;
  end if;
end set_req_customerrel;


-------------------------------------------------------------------------------
procedure set_req_customerrisk (p_clv in clv_customer_risk%rowtype)
is
  i number;
begin
  if p_clv.user_id is null then
     delete from clv_customer_risk where rnk = p_clv.rnk and risk_id = p_clv.risk_id;
  else
     begin
        insert into clv_customer_risk values p_clv;
     exception when dup_val_on_index then null;
     end;
  end if;
end set_req_customerrisk;


-------------------------------------------------------------------------------
procedure del_req_customer (p_rnk number)
is
begin
  delete from clv_customer where rnk = p_rnk;
end del_req_customer;

-------------------------------------------------------------------------------
procedure del_req_customeraddress (p_rnk number)
is
begin
  delete from clv_customer_address where rnk = p_rnk;
end del_req_customeraddress;

-------------------------------------------------------------------------------
procedure del_req_customerw (p_rnk number)
is
begin
  delete from clv_customerw where rnk = p_rnk;
end del_req_customerw;

-------------------------------------------------------------------------------
procedure del_req_customercorp (p_rnk number)
is
begin
  delete from clv_corps where rnk = p_rnk;
end del_req_customercorp;

-------------------------------------------------------------------------------
procedure del_req_customercorpacc (p_rnk number)
is
begin
  delete from clv_corps_acc where rnk = p_rnk;
end del_req_customercorpacc;

-------------------------------------------------------------------------------
procedure del_req_customerperson (p_rnk number)
is
begin
  delete from clv_person where rnk = p_rnk;
end del_req_customerperson;

-------------------------------------------------------------------------------
procedure del_req_customerrel (p_rnk number)
is
begin
  delete from clv_customer_rel where rnk = p_rnk;
end del_req_customerrel;

-------------------------------------------------------------------------------
procedure del_req_customerrisk (p_rnk number)
is
begin
  delete from clv_customer_risk where rnk = p_rnk;
end del_req_customerrisk;


-------------------------------------------------------------------------------
function found_request (p_rnk in number, p_request out clv_request%rowtype) return boolean
is
  b_found boolean := true;
begin
  begin
     select * into p_request from clv_request where rnk = p_rnk;
  exception when no_data_found then
     b_found := false;
  end;
  return b_found;
end found_request;

-------------------------------------------------------------------------------
procedure add_request_to_arc (p_request clv_request%rowtype, p_status number)
is
begin
  insert into clv_request_arc (rnk, req_date, req_userid, req_type, apr_date, apr_userid, apr_status)
  values (p_request.rnk, p_request.req_date, p_request.req_userid, p_request.req_type, sysdate, user_id, p_status);
end add_request_to_arc;

-------------------------------------------------------------------------------
procedure create_request (p_reqtype number, p_rnk number)
is
begin

  insert into clv_request (rnk, req_userid, req_type)
  values (p_rnk, user_id, p_reqtype);

  -- переносим реквизиты клиента
  if p_reqtype = g_reqtype_change then
     -- customer
     for c in ( select * from customer where rnk = p_rnk )
     loop
        declare
           l_clv clv_customer%rowtype;
        begin
           l_clv.rnk       := c.rnk;
           l_clv.date_on   := c.date_on;
           l_clv.custtype  := c.custtype;
           l_clv.codcagent := c.codcagent;
           l_clv.country   := c.country;
           l_clv.tgr       := c.tgr;
           l_clv.nmk       := c.nmk;
           l_clv.nmkv      := c.nmkv;
           l_clv.nmkk      := c.nmkk;
           l_clv.okpo      := c.okpo;
           l_clv.adr       := c.adr;
           l_clv.prinsider := c.prinsider;
           l_clv.sab       := c.sab;
           l_clv.c_reg     := c.c_reg;
           l_clv.c_dst     := c.c_dst;
           l_clv.adm       := c.adm;
           l_clv.rgadm     := c.rgadm;
           l_clv.datea     := c.datea;
           l_clv.rgtax     := c.rgtax;
           l_clv.datet     := c.datet;
           l_clv.stmt      := c.stmt;
           l_clv.notes     := c.notes;
           l_clv.notesec   := c.notesec;
           l_clv.crisk     := c.crisk;
           l_clv.nd        := c.nd;
           l_clv.rnkp      := c.rnkp;
           l_clv.ise       := c.ise;
           l_clv.fs        := c.fs;
           l_clv.oe        := c.oe;
           l_clv.ved       := c.ved;
           l_clv.sed       := c.sed;
           l_clv.k050      := c.k050;
           l_clv.branch    := c.branch;
           l_clv.isp       := c.isp;
           l_clv.taxf      := c.taxf;
           l_clv.nompdv    := c.nompdv;
           l_clv.nrezid_code := c.nrezid_code;
           set_req_customer(l_clv);
        end;
     end loop;

     -- customer_address
     for c in ( select * from customer_address where rnk = p_rnk )
     loop
        declare
           l_clv clv_customer_address%rowtype;
        begin
           l_clv.rnk      := c.rnk;
           l_clv.type_id  := c.type_id;
           l_clv.country  := c.country;
           l_clv.zip      := c.zip;
           l_clv.domain   := c.domain;
           l_clv.region   := c.region;
           l_clv.locality := c.locality;
           l_clv.address  := c.address;
           l_clv.territory_id := c.territory_id;
           set_req_customeraddress(l_clv);
        end;
     end loop;

     -- customerw
     for c in ( select * from customerw where rnk = p_rnk )
     loop
        declare
           l_clv clv_customerw%rowtype;
        begin
           l_clv.rnk   := c.rnk;
           l_clv.tag   := c.tag;
           l_clv.value := c.value;
           set_req_customerw(l_clv);
        end;
     end loop;

     -- customer_rel
     for c in ( select * from customer_rel where rnk = p_rnk )
     loop
        declare
           l_clv clv_customer_rel%rowtype;
        begin
           l_clv.rnk              := c.rnk;
           l_clv.rel_id           := c.rel_id;
           l_clv.rel_rnk          := c.rel_rnk;
           l_clv.rel_intext       := c.rel_intext;
           l_clv.vaga1            := c.vaga1;
           l_clv.vaga2            := c.vaga2;
           l_clv.type_id          := c.type_id;
           l_clv.position         := c.position;
           l_clv.first_name       := c.first_name;
           l_clv.middle_name      := c.middle_name;
           l_clv.last_name        := c.last_name;
           l_clv.document_type_id := c.document_type_id;
           l_clv.document         := c.document;
           l_clv.trust_regnum     := c.trust_regnum;
           l_clv.trust_regdat     := c.trust_regdat;
           l_clv.bdate            := c.bdate;
           l_clv.edate            := c.edate;
           l_clv.notary_name      := c.notary_name;
           l_clv.notary_region    := c.notary_region;
           l_clv.sign_privs       := c.sign_privs;
           l_clv.sign_id          := c.sign_id;
           l_clv.name_r           := c.name_r;
           set_req_customerrel(l_clv);
        end;
     end loop;

     -- corps
     for c in ( select * from corps where rnk = p_rnk )
     loop
        declare
           l_clv clv_corps%rowtype;
        begin
           l_clv.rnk     := c.rnk;
           l_clv.nmku    := c.nmku;
           l_clv.ruk     := c.ruk;
           l_clv.telr    := c.telr;
           l_clv.buh     := c.buh;
           l_clv.telb    := c.telb;
           l_clv.tel_fax := c.tel_fax;
           l_clv.e_mail  := c.e_mail;
           l_clv.seal_id := c.seal_id;
           set_req_customercorp(l_clv);
        end;
     end loop;

     -- corps_acc
     for c in ( select * from corps_acc where rnk = p_rnk )
     loop
        declare
           l_clv clv_corps_acc%rowtype;
        begin
           l_clv.rnk := c.rnk;
           l_clv.id  := c.id;
           l_clv.mfo := c.mfo;
           l_clv.nls := c.nls;
           l_clv.kv  := c.kv;
           l_clv.comments := c.comments;
           set_req_customercorpacc(l_clv);
        end;
     end loop;

     -- person
     for c in ( select * from person where rnk = p_rnk )
     loop
        declare
           l_clv clv_person%rowtype;
        begin
           l_clv.rnk    := c.rnk;
           l_clv.sex    := c.sex;
           l_clv.passp  := c.passp;
           l_clv.ser    := c.ser;
           l_clv.numdoc := c.numdoc;
           l_clv.pdate  := c.pdate;
           l_clv.organ  := c.organ;
           l_clv.bday   := c.bday;
           l_clv.bplace := c.bplace;
           l_clv.teld   := c.teld;
           l_clv.telw   := c.telw;
           set_req_customerperson(l_clv);
        end;
     end loop;

     -- customer_risk
     for c in ( select * from customer_risk where rnk = p_rnk )
     loop
        declare
           l_clv clv_customer_risk%rowtype;
        begin
           l_clv.rnk     := c.rnk;
           l_clv.risk_id := c.risk_id;
           l_clv.user_id := c.user_id;
           set_req_customerrisk(l_clv);
        end;
     end loop;

  end if;

end create_request;

-------------------------------------------------------------------------------
procedure change_request (p_request clv_request%rowtype, p_rnk number)
is
begin

  add_request_to_arc(p_request, g_status_change);

  update clv_request
     set req_date   = sysdate,
         req_userid = user_id,
         req_type   = case when req_type = 2 then 0 else req_type end,
         rej_date   = null,
         rej_userid = null
   where rnk = p_request.rnk;

end change_request;

-------------------------------------------------------------------------------
procedure new_request (p_rnk in out number)
is
  l_request clv_request%rowtype;
begin

  if p_rnk is null then
     p_rnk := bars_sqnc.get_nextval('s_customer');
     create_request(g_reqtype_new, p_rnk);
  else
     begin
        select * into l_request from clv_request where rnk = p_rnk;
        change_request(l_request, p_rnk);
     exception when no_data_found then
        create_request(g_reqtype_change, p_rnk);
     end;
  end if;

end new_request;

-------------------------------------------------------------------------------
procedure del_request (p_request clv_request%rowtype)
is
begin
  del_req_customerrisk(p_request.rnk);
  del_req_customerrel(p_request.rnk);
  del_req_customerperson(p_request.rnk);
  del_req_customercorpacc(p_request.rnk);
  del_req_customercorp(p_request.rnk);
  del_req_customerw(p_request.rnk);
  del_req_customeraddress(p_request.rnk);
  del_req_customer(p_request.rnk);
  delete from clv_request where rnk = p_request.rnk;
end del_request;

-------------------------------------------------------------------------------
procedure reject_request (p_request clv_request%rowtype)
is
begin
  if p_request.req_type = g_reqtype_new then
     update clv_request
        set req_type   = g_reqtype_reject,
            rej_date   = sysdate,
            rej_userid = user_id
      where rnk = p_request.rnk;
  elsif p_request.req_type = g_reqtype_change then
     del_request(p_request);
  end if;
end reject_request;

-------------------------------------------------------------------------------
procedure approve_request (p_request clv_request%rowtype)
is
begin
  execute immediate 'begin kl.approve_client_request(' || p_request.rnk || '); end;';
  del_request(p_request);
end approve_request;

-------------------------------------------------------------------------------
procedure set_customer_visa (
  p_rnk    number,
  p_status number )
is
  l_request clv_request%rowtype;
begin
  if found_request(p_rnk, l_request) = true then
     if p_status = g_status_reject then
        reject_request(l_request);
     elsif p_status = g_status_approve then
        approve_request(l_request);
     end if;
     add_request_to_arc(l_request, p_status);
  else
     raise_application_error(-20000, 'Запит по клієнту № ' || p_rnk || ' не знайдено');
  end if;
end set_customer_visa;

end;
/
 show err;
 
PROMPT *** Create  grants  BARS_CLV ***
grant EXECUTE                                                                on BARS_CLV        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_CLV        to CUST001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_clv.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 