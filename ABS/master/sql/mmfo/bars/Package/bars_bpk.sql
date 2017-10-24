
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_bpk.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_BPK is

g_head_version constant varchar2(64)  := 'Version 1.6 11/11/2011';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

-------------------------------------------------------------------------------
-- set_bpk_acc
-- Процедура привязки счетов
--
procedure set_bpk_acc (
  p_acc_pk    accounts.acc%type,
  p_nls_ovr   accounts.nls%type,
  p_nls_9129  accounts.nls%type,
  p_nls_tovr  accounts.nls%type,
  p_nls_3570  accounts.nls%type,
  p_nls_2208  accounts.nls%type,
  p_nls_2207  accounts.nls%type,
  p_nls_3579  accounts.nls%type,
  p_nls_2209  accounts.nls%type );

-------------------------------------------------------------------------------
-- product_add
-- Процедура добавления продукта БПК
--
procedure product_add (
  p_id        bpk_product.id%type, 
  p_name      bpk_product.name%type,
  p_type      bpk_product.type%type,
  p_kv        bpk_product.kv%type,
  p_kk        bpk_product.kk%type,
  p_condset   bpk_product.cond_set%type,
  p_limit     bpk_product.limit%type,
  p_nbs       bpk_product.nbs%type,
  p_ob22      bpk_product.ob22%type,
  p_doc       bpk_product.id_doc%type,
  p_doccred   bpk_product.id_doc_cred%type );

-------------------------------------------------------------------------------
-- product_delete
-- Процедура удаления продукта БПК
--
procedure product_delete (p_id bpk_product.id%type);

-------------------------------------------------------------------------------
-- product_change
-- Процедура изменения продукта БПК
--
procedure product_change (
  p_id        bpk_product.id%type,
  p_name      bpk_product.name%type,
  p_type      bpk_product.type%type,
  p_kv        bpk_product.kv%type,
  p_kk        bpk_product.kk%type,
  p_condset   bpk_product.cond_set%type,
  p_limit     bpk_product.limit%type,
  p_nbs       bpk_product.nbs%type,
  p_ob22      bpk_product.ob22%type,
  p_doc       bpk_product.id_doc%type,
  p_doccred   bpk_product.id_doc_cred%type );

-------------------------------------------------------------------------------
-- open_card
-- Процедура регистрации БПК
--
procedure open_card (
  p_rnk         customer.rnk%type,
  p_product_id  bpk_product.id%type,
  p_filial      demand_filiales.code%type,
  p_limit       number,
  p_kl          number,
  p_branch      accounts.tobo%type,
  p_dm_name     varchar2,
  p_dm_mname    varchar2,
  p_work        varchar2,
  p_office      varchar2,
  p_wphone      varchar2,
  p_wcntry      varchar2,
  p_wpcode      varchar2,
  p_wcity       varchar2,
  p_wstreet     varchar2,
  p_nd      out number       /* номер договора */
);

-------------------------------------------------------------------------------
-- open_kl
-- Процедура открытия кредитной линии
--
procedure open_kl (
  p_nd   in number,
  p_acc out number );

-------------------------------------------------------------------------------
-- imp_proect
-- Процедура импорта файла для регистрации клиентов и карт
--
procedure imp_proect (
  p_filename  in varchar2, 
  p_id       out number );

-------------------------------------------------------------------------------
-- crete_deal
-- Процедура регистрации БПК по файлу
--
procedure create_deal (
  p_file_id     number,
  p_product_id  number,
  p_filial      varchar2,
  p_branch      varchar2,
  p_isp         number );

-------------------------------------------------------------------------------
-- can_close_deal
-- Процедура проверки: можно закрыть БПК?
--
procedure can_close_deal (
  p_nd   in number,
  p_msg out varchar2 );

-------------------------------------------------------------------------------
-- close_deal
-- Процедура закрытия счетов БПК
--
procedure close_deal (
  p_nd   in number,
  p_msg out varchar2 );

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_BPK is

g_body_version constant varchar2(64)  := 'Version 2.3 17/01/2015';
g_body_defs    constant varchar2(512) := '';

g_modcode      constant varchar2(3)   := 'BPK';

--subtype t_proect is bpk_imp_proect_data%rowtype;

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header bars_bpk ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body bars_bpk ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

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
     elsif p_mode = '3570' and l_nbs <> '3570' and l_nbs <> '3579' then
        -- Неверно указан БС для счета комиссии
        bars_error.raise_nerror(g_modcode, 'INCORRECT_NBS_3570', p_nls);
     elsif p_mode = '2208' and l_nbs not like '2__8' and l_nbs not like '2__9' then
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
-- set_bpk_acc
-- Процедура привязки счетов
--
procedure set_bpk_acc (
  p_acc_pk    accounts.acc%type,
  p_nls_ovr   accounts.nls%type,
  p_nls_9129  accounts.nls%type,
  p_nls_tovr  accounts.nls%type,
  p_nls_3570  accounts.nls%type,
  p_nls_2208  accounts.nls%type,
  p_nls_2207  accounts.nls%type,
  p_nls_3579  accounts.nls%type,
  p_nls_2209  accounts.nls%type )
is
  l_kv        accounts.kv%type;
  l_rnk       accounts.rnk%type;
  l_acc_ovr   accounts.acc%type;
  l_acc_9129  accounts.acc%type;
  l_acc_3570  accounts.acc%type;
  l_acc_2208  accounts.acc%type;
  l_acc_2207  accounts.acc%type;
  l_acc_3579  accounts.acc%type;
  l_acc_2209  accounts.acc%type;
begin

  if p_acc_pk is not null then

     begin

        select kv, rnk into l_kv, l_rnk
          from accounts
         where acc = p_acc_pk;

        l_acc_ovr  := search_acc('OVR',  l_rnk, p_nls_ovr,  l_kv);
        l_acc_9129 := search_acc('9129', l_rnk, p_nls_9129, l_kv);
        l_acc_3570 := search_acc('3570', l_rnk, p_nls_3570, l_kv);
        l_acc_2208 := search_acc('2208', l_rnk, p_nls_2208, l_kv);
        l_acc_2207 := search_acc('2207', l_rnk, p_nls_2207, l_kv);
        l_acc_3579 := search_acc('3579', l_rnk, p_nls_3579, l_kv);
        l_acc_2209 := search_acc('2209', l_rnk, p_nls_2209, l_kv);

        update bpk_acc
           set acc_ovr  = l_acc_ovr,
               acc_9129 = l_acc_9129,
               acc_3570 = l_acc_3570,
               acc_2208 = l_acc_2208,
               acc_2207 = l_acc_2207,
               acc_3579 = l_acc_3579,
               acc_2209 = l_acc_2209
         where acc_pk = p_acc_pk;

     exception when no_data_found then null;
     end;

  end if;

end set_bpk_acc;

-------------------------------------------------------------------------------
procedure check_params (
  p_name      bpk_product.name%type,
  p_type      bpk_product.type%type,
  p_kv        bpk_product.kv%type,
  p_kk        bpk_product.kk%type,
  p_condset   bpk_product.cond_set%type,
  p_nbs       bpk_product.nbs%type,
  p_ob22      bpk_product.ob22%type )
is
  l_merr      varchar2(100);
begin

  l_merr := null;

  if p_name is null then
     l_merr := 'NAME_NOT_SET';
  elsif p_type is null then
     l_merr := 'TYPE_NOT_SET';
  elsif p_kv is null then
     l_merr := 'KV_NOT_SET';
  elsif p_kk is null then
     l_merr := 'KK_NOT_SET';
  elsif p_condset is null then
     l_merr := 'CONDSET_NOT_SET';
  elsif p_nbs is null then
     l_merr := 'NBS_NOT_SET';
  elsif p_ob22 is null then
     l_merr := 'OB22_NOT_SET';
  end if;

  if l_merr is not null then
     bars_error.raise_nerror(g_modcode, l_merr);
  end if;

end check_params;

-------------------------------------------------------------------------------
function get_card_type (p_type bpk_product.type%type) return number
is
  l_cardtype  number;
  l_merr      varchar2(100);
begin

  begin
     select card_type into l_cardtype from demand_acc_type where type = p_type;
  exception when no_data_found then
     l_merr := 'CARDTYPE_NOT_FOUND';
  end;

  if l_merr is not null then
     bars_error.raise_nerror(g_modcode, l_merr);
  end if;

  return l_cardtype;

end get_card_type;

-------------------------------------------------------------------------------
procedure check_cond_set (
  p_type      bpk_product.type%type,
  p_cardtype  bpk_product.card_type%type,
  p_kv        bpk_product.kv%type,
  p_condset   bpk_product.cond_set%type )
is
  l_cardtype  number;
  l_kv        number;
  l_name      varchar2(100);
  l_merr      varchar2(100);
  l_par1      varchar2(100);
  l_par2      varchar2(100);
  l_par3      varchar2(100);
begin

  begin
     select c.card_type, decode(c.currency,'UAH',980,840), substr(a.name,1,100)
       into l_cardtype, l_kv, l_name
       from demand_cond_set c, demand_acc_type a
      where a.type = p_type
        and a.card_type = c.card_type
        and c.cond_set  = p_condset;

     if p_cardtype <> l_cardtype then
        l_merr := 'CONDSET_CARDTYPE_INCORRECT';
        l_par1 := l_name;
        l_par2 := to_char(p_condset);
        l_par3 := null;
     end if;

     if p_kv <> l_kv then
        l_merr := 'CONDSET_KV_INCORRECT';
        l_par1 := l_name;
        l_par2 := to_char(p_condset);
        l_par3 := to_char(p_kv);
     end if;
  exception when no_data_found then
     l_merr := 'CONDSET_NOT_FOUND';
        l_par1 := l_name;
        l_par2 := to_char(p_condset);
        l_par3 := null;
  end;

  if l_merr is not null then
     bars_error.raise_nerror(g_modcode, l_merr, l_par1, l_par2, l_par3);
  end if;

end check_cond_set;

-------------------------------------------------------------------------------
-- product_add
-- Процедура добавления продукта БПК
--
procedure product_add (
  p_id        bpk_product.id%type, 
  p_name      bpk_product.name%type,
  p_type      bpk_product.type%type,
  p_kv        bpk_product.kv%type,
  p_kk        bpk_product.kk%type,
  p_condset   bpk_product.cond_set%type,
  p_limit     bpk_product.limit%type,
  p_nbs       bpk_product.nbs%type,
  p_ob22      bpk_product.ob22%type,
  p_doc       bpk_product.id_doc%type,
  p_doccred   bpk_product.id_doc_cred%type )
is
  l_id        number;
  l_cardtype  number;
begin

  check_params(p_name, p_type, p_kv, p_kk, p_condset, p_nbs, p_ob22);

  l_cardtype := get_card_type(p_type);

  check_cond_set(p_type, l_cardtype, p_kv, p_condset);

  -- если продукт с такими параметрами закрыт, удаляем его
  delete from bpk_product
   where type      = p_type
     and card_type = l_cardtype
     and kv        = p_kv
     and kk        = p_kk
     and cond_set  = p_condset
     and nbs       = p_nbs
     and ob22      = p_ob22
     and d_close is not null;

  if p_id is null or p_id = 0 then
     select nvl(min(id),0) + 1 into l_id
       from bpk_product b
      where not exists ( select id from bpk_product where id = b.id + 1)
        and rownum = 1;
  else
     l_id := p_id;
  end if;

  begin
     insert into bpk_product (id, name, type, card_type, kv, 
            kk, cond_set, limit, nbs, ob22, id_doc, id_doc_cred)
     values (l_id, p_name, p_type, l_cardtype, p_kv, 
            p_kk, p_condset, p_limit, p_nbs, p_ob22, p_doc, p_doccred);
  exception when dup_val_on_index then
     bars_error.raise_nerror(g_modcode, 'DUBL_PRODUCT');
  end;

end product_add;

-------------------------------------------------------------------------------
-- product_delete
-- Процедура удаления продукта БПК
--
procedure product_delete (p_id bpk_product.id%type)
is
begin

  update bpk_product
     set d_close = trunc(sysdate)
   where id = p_id
     and d_close is null;

end product_delete;

-------------------------------------------------------------------------------
-- product_change
-- Процедура изменения продукта БПК
--
procedure product_change (
  p_id        bpk_product.id%type,
  p_name      bpk_product.name%type,
  p_type      bpk_product.type%type,
  p_kv        bpk_product.kv%type,
  p_kk        bpk_product.kk%type,
  p_condset   bpk_product.cond_set%type,
  p_limit     bpk_product.limit%type,
  p_nbs       bpk_product.nbs%type,
  p_ob22      bpk_product.ob22%type,
  p_doc       bpk_product.id_doc%type,
  p_doccred   bpk_product.id_doc_cred%type )
is
  l_cardtype  number;
begin

  check_params(p_name, p_type, p_kv, p_kk, p_condset, p_nbs, p_ob22);

  l_cardtype := get_card_type(p_type);

  check_cond_set(p_type, l_cardtype, p_kv, p_condset);

  begin

     -- если продукт с такими параметрами закрыт, удаляем его
     delete from bpk_product
      where type      = p_type
        and card_type = l_cardtype
        and kv        = p_kv
        and kk        = p_kk
        and cond_set  = p_condset
        and nbs       = p_nbs
        and ob22      = p_ob22
        and d_close is not null;

     update bpk_product
        set name        = p_name,
            type        = p_type,
            card_type   = l_cardtype,
            kv          = p_kv,
            kk          = p_kk,
            cond_set    = p_condset,
            limit       = p_limit,
            nbs         = p_nbs,
            ob22        = p_ob22,
            id_doc      = p_doc,
            id_doc_cred = p_doccred
      where id = p_id;

  exception when dup_val_on_index then

     bars_error.raise_nerror(g_modcode, 'DUBL_PRODUCT');

  end;

end product_change;

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
-- add_deal
-- добавление договора в портфель БПК
--
procedure add_deal (p_acc in number, p_nd out number, p_product_id number)
is
  l_nd number;
begin

  begin
     select nd into l_nd from bpk_acc where acc_pk = p_acc;
     update bpk_acc set product_id = p_product_id where nd = l_nd;
  exception when no_data_found then
     select bars_sqnc.get_nextval('S_OBPCDEAL') into l_nd from dual;
     insert into bpk_acc (nd, acc_pk, product_id)
     values (l_nd, p_acc, p_product_id);
  end;

  p_nd := l_nd;

end add_deal;

-------------------------------------------------------------------------------
-- open_card
-- Процедура регистрации БПК
--
procedure open_card (
  p_rnk         customer.rnk%type,          /* РНК */
  p_product_id  bpk_product.id%type,        /* код продукта */
  p_filial      demand_filiales.code%type,  /* код филиала */
  p_limit       number,                     /* лимит */
  p_kl          number,                     /* признак кредитной линии */
  p_branch      accounts.tobo%type,         /* код отделения */
  p_dm_name     varchar2,                   /* имя на крточке */
  p_dm_mname    varchar2,                   /* девичья фамилия матери */
  p_work        varchar2,                   /* место работы */
  p_office      varchar2,                   /* должность */
  p_wphone      varchar2,                   /* телефон места работы */
  p_wcntry      varchar2,                   /* страна места работы */
  p_wpcode      varchar2,                   /* почтовый индекс места работы */
  p_wcity       varchar2,                   /* город места работы */
  p_wstreet     varchar2,                   /* адрес места работы */
  p_nd      out number                      /* номер договора */
)
is
  l_kv          accounts.kv%type;
  l_kk          demand_kk.kk%type;
  l_condset     demand_cond_set.cond_set%type;
  l_nbs_pk      accounts.nbs%type;
  l_ob22        specparam_int.ob22%type;
  l_tip         accounts.tip%type;
  l_custtype    bpk_nbs.custtype%type;
  l_term        demand_cond_set.c_validity%type;
  l_ctype       number;
  l_nd          number;
  l_nls_pk      accounts.nls%type;
  l_nms_pk      accounts.nms%type;
  l_acc_pk      accounts.acc%type;
  l_acc_ovr     accounts.acc%type;
  l_grp         number;
  l_vid         number;
  l_tmp         number;
  l_mfo         varchar2(6);
  i             number;
begin

  l_mfo := gl.amfo;

  -- данные продукта
  select b.kv, b.kk, b.cond_set, b.nbs, b.ob22, n.tip, n.custtype, d.c_validity
    into l_kv, l_kk, l_condset, l_nbs_pk, l_ob22, l_tip, l_custtype, l_term
    from bpk_product b, bpk_nbs n, demand_cond_set d
   where b.id   = p_product_id
     and b.nbs  = n.nbs
     and b.ob22 = n.ob22
     and b.card_type = d.card_type
     and b.cond_set  = d.cond_set;

  -- проверка соответствия продукта и типа клиента
  select decode(custtype, 3, decode(nvl(trim(sed),'00'),'91',2,1), 2) into l_ctype
    from customer
   where rnk = p_rnk;

  if l_custtype <> l_ctype then
     bars_error.raise_nerror(g_modcode, 'CTYPE_ERROR');
  end if;

  -- 1. карточный счет -------
  select f_newnls2(null, l_tip, l_nbs_pk, p_rnk, null, l_kv),
         f_newnms (null, l_tip, l_nbs_pk, p_rnk, null)
    into l_nls_pk, l_nms_pk
    from dual;

  -- проверка: счет не занят
  begin
     select 1 into l_tmp from accounts where nls = l_nls_pk and kv = l_kv;

     -- счет нашли, он занят, определяем свободный
     i := 0;
     loop
        -- ищем счет
        l_nls_pk := vkrzn(substr(l_mfo,1,5),
          l_nbs_pk || '0' || lpad(to_char(i), 2, '0') || lpad(to_char(p_rnk), 7, '0'));

        begin
           select 1 into l_tmp from accounts where nls = l_nls_pk and kv = l_kv;
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

  -- физ. лицо
  if l_custtype = 1 then
     l_vid := 0;
  -- юр. лицо / физ. лицо-предприниматель
  else
     l_vid := 1;
  end if;

  -- открытие карточного счета
  op_reg_lock(99, 0, 0, l_grp, l_tmp, p_rnk, l_nls_pk, l_kv, l_nms_pk,
     l_tip, user_id, l_acc_pk, '1', 2,
     l_vid, null, null, null, null, null, null, p_limit, null, null, p_branch);

  -- добавление в портфель БПК
  add_deal(l_acc_pk, l_nd, p_product_id);

  -- specparams:
  obpc.set_sparam('2625', l_acc_pk);

  -- specparam_int: OB22
  if l_ob22 is not null then
     accreg.setAccountSParam(l_acc_pk, 'OB22', l_ob22);
  end if;
  -- specparam
  if l_kk is not null then
     accreg.setAccountSParam(l_acc_pk, 'DEMAND_KK', l_kk);
  end if;
  if l_condset is not null then
     accreg.setAccountSParam(l_acc_pk, 'DEMAND_COND_SET', l_condset);
  end if;
  if p_filial is not null then
     accreg.setAccountSParam(l_acc_pk, 'DEMAND_BRN', p_filial);
  end if;
  -- accountsw
  if p_dm_name is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_NAME',  p_dm_name);
  end if;
  if p_work is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_WORK', p_work);
  end if;
  if p_office is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_OFFIC', p_office);
  end if;
  if p_wphone is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_PHONE', p_wphone);
  end if;
  if p_wcntry is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_CNTRW', p_wcntry);
  end if;
  if p_wpcode is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_PCODW', p_wpcode);
  end if;
  if p_wcity is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_CITYW', p_wcity);
  end if;
  if p_wstreet is not null then
     accreg.setAccountwParam(l_acc_pk, 'PK_STRTW', p_wstreet);
  end if;
  -- customerw
  kl.setCustomerElement(p_rnk, 'PC_MF', p_dm_mname, 0);

  -- 2. кредит --------------
  if p_kl = 1 then

     obpc.open_acc(l_nd, '2202', l_acc_ovr);

  end if;

  p_nd := l_nd;

end open_card;

-------------------------------------------------------------------------------
-- open_kl
-- Процедура открытия кредитной линии
--
procedure open_kl (
  p_nd   in number,
  p_acc out number )
is
  l_acc number;
begin

  begin
     select o.acc_ovr into l_acc
       from bpk_acc o
      where o.nd = p_nd;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'DEAL_NOT_FOUND', to_char(p_nd));
  end;

  if l_acc is null then
     obpc.open_acc(p_nd, '2202', l_acc);
  end if;

  p_acc := l_acc;

end open_kl;

/*
-------------------------------------------------------------------------------
-- check_proect
-- Процедура проверки данных для регистрации БПК по файлу
--
procedure check_proect (p_proect in out t_proect)
is
begin
  if p_proect.name         is null
  or p_proect.okpo         is null
  or p_proect.adr_street   is null
  or p_proect.passp_ser    is null
  or p_proect.passp_numdoc is null
  or p_proect.passp_organ  is null
  or p_proect.passp_date   is null
  or p_proect.bday         is null
  or p_proect.bplace       is null
  or p_proect.mname        is null then
     p_proect.str_err := 'Не заповнено обов''язкові реквізити';
  else
     p_proect.str_err := null;
  end if;

end check_proect;
*/

-------------------------------------------------------------------------------
-- imp_proect
-- Процедура импорта файла для регистрации клиентов и карт
--
procedure imp_proect ( 
  p_filename  in varchar2, 
  p_id       out number )
is
  refcur SYS_REFCURSOR;
--  l_proect t_proect;
  l_fileid number;
  i number;
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  select nvl(max(id),0) + 1 into l_fileid from bpk_imp_proect_files;

  insert into bpk_imp_proect_files (id, file_name, file_date)
  values (l_fileid, p_filename, sysdate);

  i := 0;

  open refcur for 
    'select name, okpo, adr_pcode, adr_domain, adr_region, adr_city, adr_street, 
            passp_ser, passp_num, passp_org, passp_date, bday, bplace, mname, 
            w_place, w_office, w_phone, w_pcode, w_city, w_street
       from test_bpk_impproect';
  loop
     fetch refcur into l_proect.name, l_proect.okpo, l_proect.adr_pcode, l_proect.adr_domain, l_proect.adr_region, l_proect.adr_city, l_proect.adr_street, 
           l_proect.passp_ser, l_proect.passp_numdoc, l_proect.passp_organ, l_proect.passp_date, l_proect.bday, l_proect.bplace, l_proect.mname, 
           l_proect.work_place, l_proect.work_office, l_proect.work_phone, l_proect.work_pcode, l_proect.work_city, l_proect.work_street;
     exit when refcur%notfound;

     check_proect(l_proect);

     i := i + 1;

     insert into bpk_imp_proect_data (id, idn, name, okpo, 
        adr_pcode, adr_domain, adr_region, adr_city, adr_street,
        passp_ser, passp_numdoc, passp_organ, passp_date,
        bday, bplace, mname, work_place, work_office,
        work_phone, work_pcode, work_city, work_street, str_err)
     values (l_fileid, i, l_proect.name, l_proect.okpo,
        l_proect.adr_pcode, l_proect.adr_domain, l_proect.adr_region,
        l_proect.adr_city, l_proect.adr_street, 
        l_proect.passp_ser, l_proect.passp_numdoc, l_proect.passp_organ, l_proect.passp_date,
        l_proect.bday, l_proect.bplace, l_proect.mname, 
        l_proect.work_place, l_proect.work_office, l_proect.work_phone, l_proect.work_pcode,
        l_proect.work_city, l_proect.work_street, l_proect.str_err);

  end loop;
  close refcur;

  p_id := l_fileid;
*/
end imp_proect;

/*
-------------------------------------------------------------------------------
-- add_customer
-- Процедура регистрации клиента по файлу
--
procedure add_customer (
  p_proect in out t_proect,
  p_branch        varchar2 )
is
  l_rnk number := null;
  l_adr varchar2(70);
begin

  check_proect(p_proect);

  bars_audit.trace('bpk_imp: p_proect.str_err=>' || p_proect.str_err);

  if p_proect.str_err is null then

  bars_audit.trace('bpk_imp: p_proect.str_err is null');

     select substr(trim(p_proect.adr_domain) || 
              nvl2(trim(p_proect.adr_region), ' ' || trim(p_proect.adr_region), '') ||
              nvl2(trim(p_proect.adr_city  ), ' ' || trim(p_proect.adr_city  ), '') ||
              nvl2(trim(p_proect.adr_street), ' ' || trim(p_proect.adr_street), ''), 1, 70)
       into l_adr from dual;

     kl.setCustomerAttr (
        Rnk_         => l_rnk,         -- Customer number
        Custtype_    => 3,             -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
        Nd_          => null,          -- № договора
        Nmk_         => substr(trim(p_proect.name),1,70),                         -- Наименование клиента
        Nmkv_        => substr(f_translate_kmu(trim(p_proect.name)),1,70),        -- Наименование клиента международное
        Nmkk_        => substr(trim(p_proect.name),1,38),                         -- Наименование клиента краткое
        Adr_         => l_adr,                     -- Адрес клиента
        Codcagent_   => 5,                         -- Характеристика
        Country_     => 804,                       -- Страна
        Prinsider_   => 99,                        -- Признак инсайдера
        Tgr_         => 2,                         -- Тип гос.реестра
        Okpo_        => trim(p_proect.okpo),       -- ОКПО
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
        Ise_         => null,                      -- Инст. сек. экономики
        Fs_          => null,                      -- Форма собственности
        Oe_          => null,                      -- Отрасль экономики
        Ved_         => null,                      -- Вид эк. деятельности
        Sed_         => null,                      -- Форма хозяйствования
        Notes_       => null,                      -- Примечание
        Notesec_     => null,                      -- Примечание для службы безопасности
        CRisk_       => null,                      -- Категория риска
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
        Val_   => trim(p_proect.adr_pcode),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGOBL',
        Val_   => trim(p_proect.adr_domain),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGDST',
        Val_   => trim(p_proect.adr_region),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGTWN',
        Val_   => trim(p_proect.adr_city),
        Otd_   => 0
     );

     kl.setCustomerElement(
        Rnk_   => l_rnk,
        Tag_   => 'FGADR',
        Val_   => trim(p_proect.adr_street),
        Otd_   => 0
     );

     kl.setCustomerAddressByTerritory (
        Rnk_           => l_rnk,
        TypeId_        => 2,
        Country_       => 804,
        Zip_           => trim(p_proect.adr_pcode),
        Domain_        => trim(p_proect.adr_domain),
        Region_        => trim(p_proect.adr_region),
        Locality_      => trim(p_proect.adr_city),
        Address_       => trim(p_proect.adr_street),
        TerritoryId_   => null
     );

     kl.setPersonAttr (
        Rnk_      => l_rnk,
        Sex_      => 0,
        Passp_    => 1,
        Ser_      => trim(p_proect.passp_ser),
        Numdoc_   => trim(p_proect.passp_numdoc),
        Pdate_    => trim(p_proect.passp_date),
        Organ_    => trim(p_proect.passp_organ),
        Bday_     => p_proect.bday,
        Bplace_   => p_proect.bplace,
        Teld_     => null,
        Telw_     => null
     );

     p_proect.rnk := l_rnk;

  end if;

end add_customer;
*/

/*
-------------------------------------------------------------------------------
-- add_bpk
-- Процедура регистрации карточки по файлу
--
procedure add_bpk
( p_proect     in out t_proect,
  p_product_id number,
  p_filial     varchar2,
  p_branch     varchar2,
  p_isp        number )
is
  l_dm_name varchar2(24);
begin

  select substr(
         substr(trim(replace(nmkv, '  ', ' ')), 1, 
                decode(instr(trim(replace(nmkv, '  ', ' ')), ' ',1,2),0,24,
                       instr(trim(replace(nmkv, '  ', ' ')), ' ',1,2)-1)), 1, 24)
    into l_dm_name
    from customer where rnk = p_proect.rnk;

  bars_bpk.open_card (
     p_rnk          => p_proect.rnk,
     p_product_id   => p_product_id,
     p_filial       => p_filial,
     p_limit        => 0,
     p_kl           => 0,
     p_branch       => p_branch,
     p_dm_name      => l_dm_name,
     p_dm_mname     => trim(p_proect.mname),
     p_work         => p_proect.work_place,
     p_office       => p_proect.work_office,
     p_wphone       => p_proect.work_phone,
     p_wcntry       => 'Україна',
     p_wpcode       => p_proect.work_pcode,
     p_wcity        => p_proect.work_city,
     p_wstreet      => p_proect.work_street,
     p_nd           => p_proect.nd       -- номер договора
  );

  update accounts set isp = p_isp
   where acc = ( select acc_pk from bpk_acc where nd = p_proect.nd );

exception when no_data_found then null;
end add_bpk;
*/

-------------------------------------------------------------------------------
-- crete_deal
-- Процедура регистрации БПК по файлу
--
procedure create_deal (
  p_file_id     number,
  p_product_id  number,
  p_filial      varchar2,
  p_branch      varchar2,
  p_isp         number )
is
--  l_proect t_proect;
begin

  raise_application_error(-20000, 'Нерабочая процедура');
/*
  for z in ( select idn from bpk_imp_proect_data where id = p_file_id and rnk is null )
  loop

     select * into l_proect from bpk_imp_proect_data where id = p_file_id and idn = z.idn;

     -- регистрация клиента
     add_customer(l_proect, p_branch);

     -- регистрация БПК
     if l_proect.rnk is not null then
        add_bpk(l_proect, p_product_id, p_filial, p_branch, p_isp);
     end if;

     -- сохранение данных по новому клиенту
     if l_proect.nd is not null then

        update bpk_imp_proect_data
           set rnk = l_proect.rnk,
               nd = l_proect.nd
         where id = p_file_id and idn = z.idn;

     end if;

  end loop;

  update bpk_imp_proect_files
     set product_id = p_product_id,
         filial = p_filial,
         branch = p_branch,
         isp = p_isp
   where id = p_file_id;
*/
end create_deal;

-------------------------------------------------------------------------------
-- can_close_deal
-- Процедура проверки: можно закрыть БПК?
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

  for z in ( select acc from v_bpk_nd_acc where nd = p_nd and name <> 'ACC_9129' )
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
-- Процедура закрытия счетов БПК
--
procedure close_deal (
  p_nd   in number,
  p_msg out varchar2 )
is
  i number;

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

  for z in ( select v.acc, a.nls, a.kv
               from v_bpk_nd_acc v, accounts a
              where v.nd  = p_nd
                and v.name <> 'ACC_9129'
                and v.acc = a.acc
                and a.dazs is null )
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

end close_deal;

end;
/
 show err;
 
PROMPT *** Create  grants  BARS_BPK ***
grant EXECUTE                                                                on BARS_BPK        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_BPK        to OBPC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_bpk.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 