CREATE OR REPLACE package BARS.PAC_UZ_SPLITTING is

g_header_version  constant varchar2(64)  := 'version 1.0 09/10/2017';
g_header_defs     constant varchar2(512) := '';

function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

procedure upd_dict(p_id number, p_nls varchar2, p_mfo varchar2,  p_type number, p_sp_koef number);

procedure ins_dict(p_nls varchar2, p_mfo varchar2, p_type number, p_sp_koef number);

procedure tr_sum(p_b_dat date);

pac_kv  constant number:=980;
pac_oper constant varchar2(3):='PS1';
end;
/
CREATE OR REPLACE package body BARS.PAC_UZ_SPLITTING is

g_body_version    constant varchar2(64)  := 'version 1.0 09/10/2017';
g_body_defs       constant varchar2(512) := '';



/*
authour:  Ivanenko O.A.


Розщеплення коштів по рахунку ПАТ «Укрзалізниця»
COBUMMFO-4726
12/10/2017
*/

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header PAC_UZ_SPLITTING ' || g_header_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      ||  g_header_defs;
end header_version;

-------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body PAC_UZ_SPLITTING ' || g_body_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      || g_body_defs;
end body_version;

function f_nls_tp(l_type number) return varchar2
is
l_retval varchar2(255);
begin

case when l_type = 1 then 
l_retval:= 'Рахунок з якого відбувається списання';
     when l_type = 2 then  
l_retval:= 'Рахунок на який відбувається списання';
     when l_type = 3 then 
l_retval:= 'Рахунок з яких перераховують';
     else l_retval:= null; 
end case;

return l_retval;

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
                 nd_   => substr(p_oper.ref,1,10),
                 pdat_ => p_oper.pdat,
                 vdat_ => p_oper.vdat,
                 dk_   => p_oper.dk,
                 kv_   => p_oper.kv,  
                 s_    => p_oper.s, 
                 kv2_  => p_oper.kv2,
                 s2_   => p_oper.s2,
                 sk_   => p_oper.sk, 
                 data_ => gl.bdate,
                 datp_ => p_oper.datp,
                 nam_a_=> p_oper.nam_a, 
                 nlsa_ => p_oper.nlsa,
                 mfoa_ => p_oper.mfoa,
                 nam_b_=> p_oper.nam_b, 
                 nlsb_ => p_oper.nlsb, 
                 mfob_ => p_oper.mfob,
                 nazn_ => p_oper.nazn,
                 d_rec_=> p_oper.d_rec,
                 id_a_ => p_oper.id_a,
                 id_b_ => p_oper.id_b,
                 id_o_ => p_oper.id_o, 
                 sign_ => p_oper.sign, 
                 sos_  => p_oper.sos, 
                 prty_ => p_oper.prty, 
                 uid_  => null );
                   
           gl.payv(0, p_oper.ref, p_oper.vdat, p_oper.tt, p_oper.dk,
            p_oper.kv, p_oper.nlsa, p_oper.s,
            p_oper.kv, p_oper.nlsb, p_oper.s);

end;

function get_okpo(p_rnk customer.rnk%type)
return varchar2
is
l_okpo customer.okpo%type;
begin 

    
    begin
    select okpo into l_okpo from customer where rnk=p_rnk;
    exception when no_data_found 
         then raise_application_error(-20000, 'Не знайдено клієта для данного RNK - '||to_char(p_rnk));     
    end;
    
return l_okpo;
end;


procedure upd_dict(p_id number, p_nls varchar2, p_mfo varchar2,  p_type number, p_sp_koef number)
is
l_acc_ex number;
l_nls1_ex number;
l_sp_koef number;
l_nls_tp varchar2(255);

begin

--Перевірка типу запису.
if p_type not in (1,2,3) then
 RAISE_APPLICATION_ERROR(-20002,'Невірний тип запису');
end if;

--Перевірка типу рахунку належності рахунку до RNK.
if p_type = 1 then
begin
select rnk into l_acc_ex from accounts where nls = p_nls and kv = pac_kv and kf = p_mfo;
exception when no_data_found then
 RAISE_APPLICATION_ERROR(-20002,'Рахунок не існує');
end;
else 
l_acc_ex:=1;
end if;


begin
select id into l_nls1_ex from DICT_UZ_SPLITTING a where A.ACC_TYPE = 1;
exception when no_data_found then l_nls1_ex:=null;
end;
if nvl(l_nls1_ex,p_id) <> p_id and p_type in (1) then 
 RAISE_APPLICATION_ERROR(-20003,'Рахунок для списання вже існує');
end if; 

begin
select id into l_nls1_ex from DICT_UZ_SPLITTING a where A.ACC_TYPE = 2;
exception when no_data_found then l_nls1_ex:=null;
end;
if nvl(l_nls1_ex,p_id) <> p_id and p_type in (2) then 
 RAISE_APPLICATION_ERROR(-20003,'Рахунок для нарахування вже існує');
end if;



--Дозволяємо встановлювати коефіціент тільки рахунку типу 1 та коефіціент менше рівне 1.
if p_type = 1 and p_sp_koef <=1 and p_sp_koef >= 0 then 
l_sp_koef:=p_sp_koef;
elsif p_type = 1 and p_sp_koef > 1 then
RAISE_APPLICATION_ERROR(-20001,'Коефіціент повинен бути менше одиниці');
elsif p_type = 1 and p_sp_koef <0 then
RAISE_APPLICATION_ERROR(-20001,'Коефіціент повинен бути більше нуля');
else
l_sp_koef:=null;
end if;

l_nls_tp:=f_nls_tp(p_type);
if l_acc_ex is not null then
update DICT_UZ_SPLITTING a
set A.NLS = trim(p_nls),
A.MFO = trim(p_mfo),
A.KV = pac_kv,
a.ACC_TYPE = p_type,
A.ACC_TYPE_N = l_nls_tp,
A.SP_KOEF = l_sp_koef
where a.id = p_id;
end if;
end;


procedure ins_dict(p_nls varchar2, p_mfo varchar2, p_type number, p_sp_koef number)
is
l_acc_ex number;
l_nls1_ex pls_integer;
l_sp_koef number;
l_nls_tp varchar2(255);
l_id number;
begin

if p_type not in (1,2,3) then
 RAISE_APPLICATION_ERROR(-20002,'Невірний тип запису');
end if;

--Перевірка типу рахунку належності рахунку до RNK.
if p_type = 1 then
begin
select rnk into l_acc_ex from accounts where nls = p_nls and kv = pac_kv and kf = p_mfo;
exception when no_data_found then
 RAISE_APPLICATION_ERROR(-20002,'Рахунок не існує');
end;
else 
l_acc_ex:=1;
end if;

begin
select id into l_nls1_ex from DICT_UZ_SPLITTING a where A.ACC_TYPE = 1;
exception when no_data_found then l_nls1_ex:=null;
end;
if l_nls1_ex is not null and p_type in (1) then 
 RAISE_APPLICATION_ERROR(-20003,'Рахунок для списання вже існує');
end if; 

begin
select id into l_nls1_ex from DICT_UZ_SPLITTING a where A.ACC_TYPE = 2;
exception when no_data_found then l_nls1_ex:=null;
end;
if  l_nls1_ex is not null  and p_type in (2) then 
 RAISE_APPLICATION_ERROR(-20003,'Рахунок для нарахування вже існує');
end if;
 
--Дозволяємо встановлювати коефіціент тільки рахунку типу 1 та коефіціент менше 1.
if p_type = 1 and p_sp_koef <=1 and p_sp_koef >= 0 then 
l_sp_koef:=p_sp_koef;
elsif p_type = 1 and p_sp_koef > 1 then
RAISE_APPLICATION_ERROR(-20001,'Коефіціент повинен бути менше одиниці');
elsif p_type = 1 and p_sp_koef <0 then
RAISE_APPLICATION_ERROR(-20001,'Коефіціент повинен бути більше нуля');
else
l_sp_koef:=null;
end if;

l_nls_tp:=f_nls_tp(p_type);
if l_acc_ex is not null then
begin
select max(id)+1 into l_id from DICT_UZ_SPLITTING;
if l_id is null then
l_id:=1;
end if;
exception when no_data_found then
l_id:=1;
end;
insert into DICT_UZ_SPLITTING(id,nls,mfo,kv,ACC_TYPE,ACC_TYPE_N,SP_KOEF) values (l_id,trim(p_nls),trim(p_mfo),pac_kv,p_type,l_nls_tp, l_sp_koef);
end if;
end;


procedure tr_sum(p_b_dat date) is

l_suma                number;
l_sp_koef             number;
l_tr_sum              number;
l_wiz_flag            varchar2(1);
l_okpo                customer.okpo%type;
l_okpo2               customer.okpo%type;
l_oper                oper%rowtype;
l_accounts2603        accounts%rowtype;
l_accounts2600        accounts%rowtype;

begin


--заповнюємо колекцію l_accounts2603 значеннями рахунку 2603ХХХХХХХ
begin
select * into l_accounts2603 from accounts where nls = (select a.nls from DICT_UZ_SPLITTING a where A.ACC_TYPE = 1) and kv = pac_kv
and kf = (select a.mfo from DICT_UZ_SPLITTING a where A.ACC_TYPE = 1);
exception when no_data_found then
 RAISE_APPLICATION_ERROR(-20002,'Рахунок типу 1 відсутній у клієнта ПАТ «Укрзалізниця»');
end;

--заповнюємо колекцію l_accounts2600 значеннями рахунку 2600ХХХХХХХ
begin
select * into l_accounts2600 from accounts where nls = (select a.nls from DICT_UZ_SPLITTING a where A.ACC_TYPE = 2) and kv = pac_kv
and kf = (select a.mfo from DICT_UZ_SPLITTING a where A.ACC_TYPE = 2);
exception when no_data_found then
 RAISE_APPLICATION_ERROR(-20002,'Рахунок для перерахування відсутній.');
end;

--вибираємо значення коефіціента в переменую l_sp_koef
select A.SP_KOEF into l_sp_koef from DICT_UZ_SPLITTING a where A.ACC_TYPE = 1;

--перевіряємо значення коефіціента
if l_sp_koef<=0 or l_sp_koef>1 then
RAISE_APPLICATION_ERROR(-20001,'Коефіціент повинен бути більше 0 та більше рівно 1');
end if;

--вибираємо суму надходжень за день p_b_dat від структурних педрозділів з vob = 6
select sum(s) into l_suma 
from oper 
where (ref, tt) in (select ref, tt from opldok where acc = l_accounts2603.acc and fdat = p_b_dat and dk = 1 and sos = 5)
and nlsb = (select a.nls from DICT_UZ_SPLITTING a where A.ACC_TYPE = 1)
and mfob = (select a.mfo from DICT_UZ_SPLITTING a where A.ACC_TYPE = 1)
and (nlsa, mfoa) in (select a.nls, a.mfo from DICT_UZ_SPLITTING a where A.ACC_TYPE = 3)
and kv = pac_kv  and vob = 6;

--вираховуємо суму операції
l_tr_sum:= round(l_suma*l_sp_koef);

--перевіряємо наявність коштів на рахунку
if l_accounts2603.ostc <= l_tr_sum then 
RAISE_APPLICATION_ERROR(-20001,'Недостатньо коштів на рахунку.');
end if;


--знаходимо ОКПО власників рахунку
    l_okpo:= get_okpo(l_accounts2603.rnk);
    l_okpo2:= get_okpo(l_accounts2600.rnk);

--заповнюємо колекцію даними для виконання операції
    l_oper.tt   := pac_oper;--+
    l_oper.vob  := 6;--+?
    l_oper.nd   := null;--??
    l_oper.pdat := sysdate;--+
    l_oper.vdat := gl.bdate;--+
    l_oper.dk   := 1;--+
    l_oper.kv   := l_accounts2603.kv;--?
    l_oper.s    := l_tr_sum;--?
    l_oper.kv2  := l_accounts2603.kv;--?
    l_oper.s2   := l_tr_sum;--??
    l_oper.sk   := null;
    l_oper.datp := gl.bdate;--+

    l_oper.nam_a := substr(l_accounts2603.nms,1,38);--+
    l_oper.nlsa  := l_accounts2603.nls;--+
    l_oper.mfoa  := gl.amfo;--+

    l_oper.nam_b := substr(l_accounts2600.nms,1,38);--+
    l_oper.nlsb  := l_accounts2600.nls;--+
    l_oper.mfob  := gl.amfo;--+

    l_oper.nazn  := substr ( 'Договірне списання коштів згідно п.2.9 Договору банківського рахунку №1026 від 24.11.2015р. Без ПДВ',1,160);--+
    l_oper.d_rec := null;--+  
    l_oper.id_a  := l_okpo;--??
    l_oper.id_b  := l_okpo2;--??
    l_oper.id_o  := null;--+
    l_oper.sign  := null;--+
    l_oper.sos   := 0;--+
    l_oper.prty  := 0;--+
    
    savepoint sp_pay;
begin 
--викликаємо процедуру створення платежу    
      pay_doc (l_oper);  
      
          
    exception when others
      then  rollback to sp_pay;
       raise; 
    end;  


end;
end;
/
grant execute on PAC_UZ_SPLITTING to BARS_ACCESS_DEFROLE;
/
