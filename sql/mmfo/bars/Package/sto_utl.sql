
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sto_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.STO_UTL is

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'version 2.0  01.05.2016';
 function header_version return varchar2;
 function body_version   return varchar2;

    STO_TYPE_SEP_PAYMENT           constant integer := 1;
    STO_TYPE_SBON_PAYMENT_FREE     constant integer := 2;
    STO_TYPE_SBON_PAYMENT_CONTR    constant integer := 3;
    STO_TYPE_SBON_PAYMENT_NOCONTR  constant integer := 4;

    STO_FREQ_DAILY                 constant integer := 1;
    STO_FREQ_MONTHLY               constant integer := 5;
    STO_FREQ_QUARTERLY             constant integer := 7;
    STO_FREQ_YEARLY                constant integer := 360;

    PROD_ACCESS_MODE_WHOLE_BANK    constant integer := 1;
    PROD_ACCESS_MODE_WHOLE_MFO     constant integer := 2;
    PROD_ACCESS_MODE_WHOLE_BRANCH  constant integer := 3;
    PROD_ACCESS_MODE_EXACT_BRANCHS constant integer := 4;

    STO_ORDER_STATE_NEW            constant integer := 1;
    STO_ORDER_STATE_APPROVED       constant integer := 2;
    STO_ORDER_STATE_CANCELED       constant integer := 3;

    STO_PRODUCT_STATE_ACTIVE       constant integer := 0;
    STO_PRODUCT_STATE_BLOCKED      constant integer := 1;
    STO_PRODUCT_STATE_CLOSED       constant integer := 2;

    CURRENCY_CODE_HRYVNIA          constant integer := 980;

    MINIMAL_DATE                   constant date := date '0001-01-01';

    FORMAT_DATE                    constant varchar2(10 char) := 'dd.mm.yyyy';
    FORMAT_DATE_TIME               constant varchar2(21 char) := 'dd.mm.yyyy hh24:mi:ss';

    procedure cor_order_type(
        p_type_id in integer,
        p_order_type_name in varchar2);

    function get_order_type_name(
        p_order_type_id in integer)
    return varchar2;

    function create_product(
        p_order_type_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_branch_access_mode in integer,
        p_branch in varchar2 default null)
    return integer;

    function read_product(
        p_product_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return sto_product%rowtype;

    function create_order(
        p_order_type_id in integer,
        p_payer_account_id in integer,
        p_product_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_sendsms in varchar2)
    return integer;

    function create_sep_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    return integer;

    function read_order(
        p_order_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return sto_order%rowtype;

    function read_sep_order(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sep_order%rowtype;

    procedure update_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
       p_holiday_shift in integer,
        p_sendsms in varchar2);

    procedure update_sep_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
       p_purpose in varchar2,
        p_sendsms in varchar2);

    procedure update_order_type(
        p_order_id in integer,
        p_order_type_id in integer);

    procedure update_order_product(
        p_order_id in integer,
        p_procuct_id  in  integer);
        
    procedure close_order(
        p_order_id in integer,
        p_close_date in date);
                            
    function get_next_priority(
        p_payer_account_id in integer)
    return integer;

    procedure check_receiver(
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2);

    function get_product_extra_attributes(
        p_product_id in integer)
    return clob;

    function get_order_extra_info(
        p_order_id in integer)
    return clob;

    procedure set_order_priority(
        p_order_id in integer,
        p_priority in integer);

    procedure set_order_extra_attributes(
        p_order_id in integer,
        p_extra_attributes in clob);
        
    procedure set_product_extra_attributes(
        p_product_id in integer,
        p_extra_attributes_metadata in clob);
   
   procedure track_order_state(
        p_order_id in integer,       
        p_comment in varchar2);
                
   procedure set_order_state(
        p_order_id in integer,
        p_state_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.STO_UTL as

  G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 2.0 01.05.2016';

  FUNCTION header_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package header sto_utl ' || G_HEADER_VERSION;
  END header_version;

  FUNCTION body_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package body sto_utl ' || G_BODY_VERSION;
  END body_version;
  

    function read_order_type(
        p_type_id in integer,
        p_raise_ndf in boolean default true)
    return sto_type%rowtype
    is
        l_order_type_row sto_type%rowtype;
    begin
        select *
        into   l_order_type_row
        from   sto_type t
        where  t.id = p_type_id;

        return l_order_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Тип регулярних платежів з ідентифікатором {' || p_type_id || '} не знайдений');
             else return null;
             end if;
    end;

    procedure cor_order_type(
        p_type_id in integer,
        p_order_type_name in varchar2)
    is
    begin
        merge into sto_type t
        using (select 1 from DUAL) s
        on (t.id = p_type_id)
        when matched then update
             set t.type_name = p_order_type_name
        when not matched then insert
             values (p_type_id, p_order_type_name);
    end;

    function read_product(
        p_product_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return sto_product%rowtype
    is
        l_product_row sto_product%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_product_row
            from   sto_product t
            where  t.id = p_product_id
            for update;
        else
            select *
            into   l_product_row
            from   sto_product t
            where  t.id = p_product_id;
        end if;

        return l_product_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Вид регулярних платежів з ідентифікатором {' || p_product_id || '} не знайдений');
             else return null;
             end if;
    end;

    function create_product(
        p_order_type_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_branch_access_mode in integer,
        p_branch in varchar2 default null)
    return integer
    is
        l_product_id integer;
        l_branch varchar2(30 char) default trim(p_branch);
    begin
        if (l_branch is null) then
            l_branch := sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH);
        end if;

        insert into sto_product(id, product_code, product_name, order_type_id, branch_access_mode, state, branch)
        values (bars_sqnc.get_nextval('sto_product_seq'), p_product_code, p_product_name, p_order_type_id, p_branch_access_mode, sto_utl.STO_PRODUCT_STATE_ACTIVE, l_branch)
        returning id
        into l_product_id;

        return l_product_id;
    end;

    function read_order(
        p_order_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return sto_order%rowtype
    is
        l_order_row sto_order%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_order_row
            from   sto_order o
            where  o.id = p_order_id
            for update;
        else
            select *
            into   l_order_row
            from   sto_order o
            where  o.id = p_order_id;
        end if;

        return l_order_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Розпорядження на перерахування коштів з ідентифікатором {' || p_order_id || '} не знайдено');
             else return null;
             end if;
    end;

    function read_sep_order(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sep_order%rowtype
    is
        l_sep_order_row sto_sep_order%rowtype;
    begin
        select *
        into   l_sep_order_row
        from   sto_sep_order osep
        where  osep.id = p_order_id;

        return l_sep_order_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Параметри розпорядження на перерахування коштів по СЕП з ідентифікатором {' ||
                                                p_order_id || '} не знайдені');
             else return null;
             end if;
    end;

    procedure track_order_state(
        p_order_id in integer,       
        p_comment in varchar2)
    is
    begin
        insert into sto_order_tracking
        values (bars_sqnc.get_nextval('sto_order_tracking_seq'), p_order_id,user_id, p_comment, sysdate);
    end;

    procedure set_order_state(
        p_order_id in integer,
        p_state_id in integer) is
    l_statename varchar2(100);
    begin
      begin
        select name 
          into l_statename
          from V_STO_ORDER_STATE
         where id = p_state_id;
      exception when no_data_found then l_statename := to_char(p_state_id);         
      end;  
      
        update sto_order o
        set    o.state = p_state_id
        where  o.id = p_order_id;
        track_order_state(p_order_id, 'Змінено статус договору на '||l_statename);    
    end;

    function create_order(
        p_order_type_id in integer,
        p_payer_account_id in integer,
        p_product_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_sendsms in varchar2)
    return integer
    is
        l_order_id integer;
        l_priority integer;
    begin
        l_priority := get_next_priority(p_payer_account_id);

        insert into sto_order
        values (bars_sqnc.get_nextval('sto_order_seq'),
                p_order_type_id,
                p_payer_account_id,
                p_product_id,
                nvl(p_start_date, bankdate()),
                p_stop_date,
                p_payment_frequency,
                p_holiday_shift,
                null,
                l_priority,
                sto_utl.STO_ORDER_STATE_NEW,
                user_id(),
                sys_context('bars_context', 'user_branch'),
                gl.kf(),
                sysdate,
                nvl(p_sendsms,'N'))
        returning id
        into l_order_id;

        track_order_state(l_order_id, 'Створено договір. Пріоритет '||to_char(l_priority));

        return l_order_id;
    end;

    procedure create_sep_order(
        p_order_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
       p_purpose in varchar2,
        p_sendsms in varchar2)
    is
    begin
        insert into sto_sep_order
        values (p_order_id, p_regular_amount, p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou, p_purpose, p_sendsms);
    end;

    function create_sep_order(
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    return integer
    is
        l_order_id integer;
    begin
        l_order_id := create_order(sto_utl.STO_TYPE_SEP_PAYMENT,
                                   p_payer_account_id,
                                   null,
                                   p_start_date,
                                   p_stop_date,
                                   p_payment_frequency,
                                   p_holiday_shift,
                                   p_sendsms);

        create_sep_order(l_order_id, p_regular_amount, p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou, p_purpose,p_sendsms);

        return l_order_id;
    end;

    procedure update_order_type(
        p_order_id in integer,
        p_order_type_id in integer)
    is
    begin
       update sto_order o
        set    o.order_type_id = p_order_type_id
        where  o.id = p_order_id;

        track_order_state(p_order_id, 'Змінено тип договору на '||p_order_type_id);    
    end;    
    
    procedure update_order_product(
        p_order_id in integer,
        p_procuct_id in integer)
    is
    begin
       update sto_order o
        set    o.product_id = p_procuct_id
        where  o.id = p_order_id;
        track_order_state(p_order_id, 'Змінено продукт договору на '||p_procuct_id);            
    end;    
    procedure update_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_sendsms in varchar2)
    is
    l_sto_order sto_order%rowtype;
    begin
        update sto_order t
        set    t.payer_account_id = p_payer_account_id,
               t.start_date = p_start_date,
               t.stop_date = p_stop_date,
               t.payment_frequency = p_payment_frequency,
               t.holiday_shift = p_holiday_shift,
               t.state = decode (t.state,sto_utl.STO_ORDER_STATE_APPROVED,sto_utl.STO_ORDER_STATE_NEW,t.state),
               t.send_sms = p_sendsms
        where t.id = p_order_id;

        l_sto_order:= sto_utl.read_order(p_order_id);

        track_order_state(l_sto_order.id, 'Договір змінено. Рахунок:'||to_char(l_sto_order.payer_account_id)||
                          ' Дата початку:'||to_char(l_sto_order.start_date)||' Дата закінченння:'||to_char(l_sto_order.stop_date)||' Періодичність виплат:'||(l_sto_order.payment_frequency)||
                          'Порядок переносу дати платежа: '||to_char(l_sto_order.holiday_shift)||' '||to_char(l_sto_order.state) ||'Послуга СМС '||to_char(l_sto_order.send_sms));
    end;

    procedure update_sep_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    is
    begin
        update_order(p_order_id,
                     p_payer_account_id,
                     p_start_date,
                     p_stop_date,
                     p_payment_frequency,
                     p_holiday_shift,
                     p_sendsms);

        update sto_sep_order t
        set    t.regular_amount = p_regular_amount,
               t.receiver_mfo = p_receiver_mfo,
               t.receiver_account = p_receiver_account,
               t.receiver_name = p_receiver_name,
               t.receiver_edrpou = p_receiver_edrpou,
               t.purpose = p_purpose,
               t.send_sms = p_sendsms
        where t.id = p_order_id;
    end;
    procedure close_order(
        p_order_id in integer,
        p_close_date in date)
    is
    begin
        update sto_order o
        set    o.cancel_date = p_close_date        
        where  o.id = p_order_id;

        set_order_state(p_order_id, sto_utl.STO_ORDER_STATE_CANCELED);

        track_order_state(p_order_id, 'Договір закрито. Дата Закриття'||to_char(p_close_date));
    end;  
    
    procedure check_receiver(
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2)
    is
        l_bank_row banks$base%rowtype;
    begin
        if (p_receiver_mfo is null) then
            raise_application_error(-20000, 'Код МФО банку отримувача коштів не вказаний');
        end if;
        if (p_receiver_account is null) then
            raise_application_error(-20000, 'Рахунок отримувача коштів не вказаний');
        end if;

        l_bank_row := customer_utl.read_bank(p_receiver_mfo);
        if (l_bank_row.blk <> 0) then
            raise_application_error(-20000, 'Код МФО {' || p_receiver_mfo || '} банка-отримувача заблокований');
        end if;
        if (vkrzn(substr(p_receiver_mfo, 1, 5), p_receiver_account) <> p_receiver_account) then
            raise_application_error(-20000, 'Не пройшла перевірка ключового розряду рахунку ' || p_receiver_account ||
                                            ' (' || p_receiver_mfo || ')');
        end if;

        if (p_receiver_edrpou is null) then
            raise_application_error(-20000, 'Код ЄДРПОУ отримувача коштів не вказаний');
        end if;
        if (p_receiver_name is null) then
            raise_application_error(-20000, 'Назва отримувача коштів на вказана');
        end if;

        if (v_okpo(p_receiver_edrpou) <> p_receiver_edrpou) then
            raise_application_error(-20000,'Код ЄРДПОУ отримувача {' || p_receiver_edrpou ||
                                           '} не пройшов перевірку контрольного розряду');
        end if;
    end;

    function get_order_type_name(
        p_order_type_id in integer)
    return varchar2
    is
    begin
        return read_order_type(p_order_type_id, p_raise_ndf => false).type_name;
    end;

    function get_next_priority(
        p_payer_account_id in integer)
    return integer
    is
        l_next_priority integer;
    begin
        select nvl(max(o.priority), 0) + 1
        into   l_next_priority
        from   sto_order o
        where  o.payer_account_id = p_payer_account_id;

        return l_next_priority;
    end;

    function get_product_extra_attributes(
        p_product_id in integer)
    return clob
    is
        l_clob clob;
    begin
        select ea.extra_attributes_metadata
        into   l_clob
        from   sto_prod_extra_attributes ea
        where  ea.product_id = p_product_id;

        return l_clob;
    exception
        when no_data_found then
             return null;
    end;

    function get_order_extra_info(
        p_order_id in integer)
    return clob
    is
        l_clob clob;
    begin
        select ea.extra_attributes
        into   l_clob
        from   sto_order_extra_attributes ea
        where  ea.order_id = p_order_id;

        return l_clob;
    exception
        when no_data_found then
             return null;
    end;

    procedure set_product_extra_attributes(
        p_product_id in integer,
        p_extra_attributes_metadata in clob)
    is
    begin
        if (p_extra_attributes_metadata is null) then
            delete sto_prod_extra_attributes t where t.product_id = p_product_id;
        else
            merge into sto_prod_extra_attributes a
            using (select 1 from DUAL) s
            on (a.product_id = p_product_id)
            when matched then update
                 set a.extra_attributes_metadata = p_extra_attributes_metadata
            when not matched then insert
                 values (p_product_id, p_extra_attributes_metadata);
        end if;
    end;

    procedure set_order_priority(
        p_order_id in integer,
        p_priority in integer)
    is
    begin
        update sto_order o
        set    o.priority = p_priority
        where  o.id = p_order_id;

        track_order_state(p_order_id, 'Змінено пріоритет сплати договору на '||p_priority);    
    end;

    procedure set_order_extra_attributes(
        p_order_id in integer,
        p_extra_attributes in clob)
    is
    begin
        if (p_extra_attributes is null) then
            delete sto_order_extra_attributes t
            where  t.order_id = p_order_id;
        else
            update sto_order_extra_attributes t
            set    t.extra_attributes = p_extra_attributes
            where  t.order_id = p_order_id;

            if (sql%rowcount = 0) then
                insert into sto_order_extra_attributes
                values (p_order_id, p_extra_attributes);
            end if;
        end if;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  STO_UTL ***
grant DEBUG,EXECUTE                                                          on STO_UTL         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sto_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 