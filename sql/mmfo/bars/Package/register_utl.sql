PROMPT =================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/REGISTER_UTL.sql ===== *** Run ***
PROMPT =================================================================================== 

                        
create or replace package register_utl as            

    SMB_PRINCIPAL_AMOUNT_CODE      constant  varchar2(100) := 'SMB_PRINCIPAL_AMOUNT';
    SMB_INTEREST_AMOUNT_CODE       constant  varchar2(100) := 'SMB_INTEREST_AMOUNT';
    SMB_MILITARY_TAX_CODE          constant  varchar2(100) := 'SMB_MILITARY_TAX';
    SMB_INCOME_TAX_CODE            constant  varchar2(100) := 'SMB_INCOME_TAX';
    SMB_INTEREST_PAID_CODE         constant  varchar2(100) := 'SMB_INTEREST_PAID';
    SMB_PENALTY_AMOUNT_CODE        constant  varchar2(100) := 'SMB_PENALTY_AMOUNT';
    SMB_BLOCKED_AMOUNT_CODE        constant  varchar2(100) := 'SMB_BLOCKED_AMOUNT';
-- 
    -- deposit on demand DoD
    SMB_DOD_PRINCIPAL_AMOUNT_CODE  constant  varchar2(100) := 'SMB_DOD_PRINCIPAL_AMOUNT';
    SMB_DOD_INTEREST_AMOUNT_CODE   constant  varchar2(100) := 'SMB_DOD_INTEREST_AMOUNT';
    SMB_DOD_MILITARY_TAX_CODE      constant  varchar2(100) := 'SMB_DOD_MILITARY_TAX';
    SMB_DOD_INCOME_TAX_CODE        constant  varchar2(100) := 'SMB_DOD_INCOME_TAX';
    SMB_DOD_INTEREST_PAID_CODE     constant  varchar2(100) := 'SMB_DOD_INTEREST_PAID';
    SMB_DOD_PENALTY_AMOUNT_CODE    constant  varchar2(100) := 'SMB_DOD_PENALTY_AMOUNT';
     -- 
    COMMON_PRINCIPAL_AMOUNT_CODE   constant  varchar2(100) := 'COMMON_PRINCIPAL_AMOUNT';
    COMMON_INTEREST_AMOUNT_CODE    constant  varchar2(100) := 'COMMON_INTEREST_AMOUNT';
    COMMON_MILITARY_TAX_CODE       constant  varchar2(100) := 'COMMON_MILITARY_TAX';
    COMMON_INCOME_TAX_CODE         constant  varchar2(100) := 'COMMON_INCOME_TAX';
    COMMON_INTEREST_PAID_CODE      constant  varchar2(100) := 'COMMON_INTEREST_PAID';
    COMMON_PENALTY_AMOUNT_CODE     constant  varchar2(100) := 'COMMON_PENALTY_AMOUNT';
    --
    SMB_INTEREST_RATE_CODE         constant  varchar2(100) := 'SMB_INTEREST_RATE';  -- for attribute


   
    function read_register_type(
                               p_register_type_id in number
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              ) return register_type%rowtype;

    function read_register_type(
                               p_register_code    in varchar2
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              ) return register_type%rowtype;

    function create_register_type(
                              p_object_type_code varchar2
                             ,p_register_code    varchar2
                             ,p_register_name    varchar2
                             ,p_is_active        varchar2 default 'Y'   
                              ) return number; 

    function create_register_history(
                              p_register_id    in number
                             ,p_value_date     in date
                             ,p_amount         in number
                             ,p_is_active      in varchar2
                             ,p_is_planned     in varchar2
                             ,p_document_id       in number default null)
                  return number;           

    function update_register_history(
                              p_register_history_id in number
                             ,p_value_date          in date
                             ,p_amount              in number
                             ,p_is_active           in varchar2
                             ,p_date_from           in date
                             ,p_date_to             in date
                             ,p_is_planned          in varchar2
                             ,p_document_id         in number default null)
                 return number;            

    function cor_register_value(
                           p_register_value_id in out number
                          ,p_object_id         in number
                          ,p_register_code     in varchar2
                          ,p_plan_value        in number
                          ,p_value             in number
                          ,p_date              in date
                          ,p_currency_id       in number
                          ,p_is_planned        in varchar2
                          ,p_document_id       in number default null)
                  return number;            

    function cor_register_value(
                           p_register_value_id in out number
                          ,p_object_id         in number
                          ,p_register_type_id  in number
                          ,p_plan_value        in number
                          ,p_value             in number
                          ,p_date              in date
                          ,p_currency_id       in number
                          ,p_is_planned        in varchar2
                          ,p_document_id       in number default null)
                   return number;        
    -- создание регистра по общему коду - код регистра зависит от типа объекта 
    function cor_register_value_common_type(
                           p_register_value_id         in out number
                          ,p_object_id                 in number
                          ,p_register_common_type_code in varchar2
                          ,p_plan_value                in number
                          ,p_value                     in number
                          ,p_date                      in date
                          ,p_currency_id               in number
                          ,p_is_planned                in varchar2
                          ,p_document_id               in number default null)
                return number;

                          
    function read_register_value(
                               p_register_value_id in number
                              ,p_lock              in boolean default false
                              ,p_raise_ndf         in boolean default false
                              ) return register_value%rowtype;

    function read_register_value(
                               p_object_id        in number   
                              ,p_register_code    in varchar2
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              ) return register_value%rowtype;

    function read_register_value(
                               p_object_id        in number   
                              ,p_register_type_id in number
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              ) return register_value%rowtype;

    function read_register_history(
                               p_register_history_id in number
                              ,p_lock                in boolean default false
                              ,p_raise_ndf           in boolean default false
                              ) return register_history%rowtype;

    procedure set_register_actual_value(
                              p_object_id        in number   
                             ,p_register_code    in varchar2
                             ,p_value_date       in date
                             ,p_amount           in number      
                             ,p_document_id      in number default null);


    procedure set_register_actual_value(
                              p_register_id    in number
                             ,p_value_date     in date
                             ,p_amount         in number
                             ,p_document_id    in number default null);

    procedure set_register_actual_value(
                             p_register_history_id in number
                            ,p_value_date          in date
                            ,p_document_id         in number default null
                                );

end register_utl;
/
create or replace package body register_utl as



    type tt_register_type_list is table of number
                               index by varchar2(100);

    g_common_register_type tt_register_type_list;

    procedure init_register_type 
     is
        l_object_type_id  number;
    begin
        g_common_register_type.delete; 
        l_object_type_id       := object_utl.read_object_type(p_object_type_code => 'SMB_DEPOSIT_TRANCHE').id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_PRINCIPAL_AMOUNT_CODE)  := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_PRINCIPAL_AMOUNT_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_INTEREST_AMOUNT_CODE)   := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_INTEREST_AMOUNT_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_MILITARY_TAX_CODE)      := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_MILITARY_TAX_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_INCOME_TAX_CODE)        := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_INCOME_TAX_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_INTEREST_PAID_CODE)     := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_INTEREST_PAID_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_PENALTY_AMOUNT_CODE)    := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_PENALTY_AMOUNT_CODE).id;

        l_object_type_id       := object_utl.read_object_type(p_object_type_code => 'SMB_DEPOSIT_ON_DEMAND').id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_PRINCIPAL_AMOUNT_CODE)  := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_DOD_PRINCIPAL_AMOUNT_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_INTEREST_AMOUNT_CODE)   := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_DOD_INTEREST_AMOUNT_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_MILITARY_TAX_CODE)      := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_DOD_MILITARY_TAX_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_INCOME_TAX_CODE)        := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_DOD_INCOME_TAX_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_INTEREST_PAID_CODE)     := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_DOD_INTEREST_PAID_CODE).id;
        g_common_register_type(l_object_type_id||'#'||register_utl.COMMON_PENALTY_AMOUNT_CODE)    := register_utl.read_register_type(
                                                                                                      p_register_code => SMB_DOD_PENALTY_AMOUNT_CODE).id;
    end;

    function read_register_type(
                               p_register_type_id in number
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              )
        return register_type%rowtype
    is
        l_register_type_row register_type%rowtype;
    begin
        if (p_lock) then
            select *
              into l_register_type_row
              from register_type r
             where  r.id = p_register_type_id
            for update;
        else
            select *
              into l_register_type_row
              from register_type r
             where r.id = p_register_type_id;
        end if;

        return l_register_type_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Тип регістру з ідентифікатором {' || p_register_type_id ||'} не знайдений');
           else return null;
           end if;
    end read_register_type;

    function read_register_type(
                               p_register_code    in varchar2
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              )
        return register_type%rowtype
    is
        l_register_type_row register_type%rowtype;
    begin
        if (p_lock) then
            select *
              into l_register_type_row
              from register_type r
             where r.register_code = p_register_code
            for update;
        else
            select *
              into l_register_type_row
              from register_type r
             where r.register_code = p_register_code;
        end if;

        return l_register_type_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Тип регістру з кодом {' || p_register_code ||'} не знайдений');
           else return null;
           end if;
    end read_register_type;

    function create_register_type(
                              p_object_type_code varchar2
                             ,p_register_code    varchar2
                             ,p_register_name    varchar2
                             ,p_is_active        varchar2 default 'Y'   
                              ) return number
     is
        l_register_type_id  number;
        l_object_type_id    number;
    begin
        l_object_type_id := object_utl.read_object_type(p_object_type_code).id;
        
        insert into register_type(id, object_type_id, register_code, register_name, is_active)
          values(register_seq.nextVal, l_object_type_id, p_register_code, p_register_name, p_is_active) 
          return id into l_register_type_id;

        return l_register_type_id;
    end create_register_type;                          
 
    function cor_register_value(
                           p_register_value_id in out number
                          ,p_object_id         in number
                          ,p_register_code     in varchar2
                          ,p_plan_value        in number
                          ,p_value             in number
                          ,p_date              in date
                          ,p_currency_id       in number
                          ,p_is_planned        in varchar2
                          ,p_document_id       in number default null)
                return number           
     is 
        l_register_type_id number;
    begin
        l_register_type_id := read_register_type(p_register_code  => p_register_code
                                                ,p_raise_ndf     => true).id;    
        return cor_register_value(
                           p_register_value_id => p_register_value_id
                          ,p_object_id         => p_object_id
                          ,p_register_type_id  => l_register_type_id
                          ,p_plan_value        => p_plan_value
                          ,p_value             => p_value
                          ,p_date              => p_date
                          ,p_currency_id       => p_currency_id
                          ,p_is_planned        => p_is_planned
                          ,p_document_id       => p_document_id);    
    end;                      

    function cor_register_value(
                           p_register_value_id in out number
                          ,p_object_id         in number
                          ,p_register_type_id  in number
                          ,p_plan_value        in number
                          ,p_value             in number
                          ,p_date              in date
                          ,p_currency_id       in number
                          ,p_is_planned        in varchar2
                          ,p_document_id       in number default null)
                return number          
     is 
        l_operation_type varchar2(1) := 'U';
    begin
        if p_register_value_id is null then
            p_register_value_id := read_register_value(p_object_id        => p_object_id   
                                                      ,p_register_type_id => p_register_type_id).id;
        end if;
        if p_register_value_id is not null then 
            update register_value set
                   plan_value   = plan_value + p_plan_value
                  ,actual_value = actual_value + case when p_is_planned = 'N' then p_value else 0 end  
              where id = p_register_value_id;
        else
            l_operation_type := 'I';
            insert into register_value(id, object_id, register_type_id, plan_value, actual_value, currency_id)
              values (register_seq.nextVal, p_object_id, p_register_type_id, p_plan_value, case when p_is_planned = 'N' then p_value else 0 end, p_currency_id) 
            returning id into p_register_value_id;
        end if;   

        return create_register_history(
                                  p_register_id    => p_register_value_id
                                 ,p_value_date     => p_date
                                 ,p_amount         => p_plan_value
                                 ,p_is_active      => 'Y'
                                 ,p_is_planned     => p_is_planned
                                 ,p_document_id    => p_document_id);
    end;                     

    -- создание регистра по общему коду - код регистра зависит от типа объекта 
    function cor_register_value_common_type(
                           p_register_value_id         in out number
                          ,p_object_id                 in number
                          ,p_register_common_type_code in varchar2
                          ,p_plan_value                in number
                          ,p_value                     in number
                          ,p_date                      in date
                          ,p_currency_id               in number
                          ,p_is_planned                in varchar2
                          ,p_document_id               in number default null)
                return number
     is
        l_register_type_id  number;
        l_object_row       object%rowtype;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.cor_register_value_common_type',
                        p_log_message    => 'p_register_value_id         : '|| p_register_value_id || chr(10) ||
                                            'p_register_common_type_code : '|| p_register_common_type_code || chr(10) ||
                                            'p_value                     : '|| p_value || chr(10) ||
                                            'p_date                      : '|| to_char(p_date, 'yyyy-mm-dd') || chr(10) ||
                                            'p_is_planned                : '|| p_is_planned
                       ,p_object_id      => p_object_id
                        );
        l_object_row       := object_utl.read_object(p_object_id => p_object_id);
        l_register_type_id := g_common_register_type(l_object_row.object_type_id||'#'||p_register_common_type_code);
        return cor_register_value(
                           p_register_value_id => p_register_value_id
                          ,p_object_id         => p_object_id
                          ,p_register_type_id  => l_register_type_id
                          ,p_plan_value        => p_plan_value
                          ,p_value             => p_value
                          ,p_date              => p_date
                          ,p_currency_id       => p_currency_id
                          ,p_is_planned        => p_is_planned
                          ,p_document_id       => p_document_id);
    end; 



    function read_register_history(
                               p_register_history_id in number
                              ,p_lock                in boolean default false
                              ,p_raise_ndf           in boolean default false
                              ) return register_history%rowtype
    is
        l_register_hist_row register_history%rowtype;
    begin
        if (p_lock) then
            select *
              into l_register_hist_row
              from register_history r
             where  r.id = p_register_history_id
            for update;
        else
            select *
              into l_register_hist_row
              from register_history r
             where  r.id = p_register_history_id;
        end if;

        return l_register_hist_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Регістр з ідентифікатором {' || p_register_history_id ||'} не знайдений');
           else return null;
           end if;
    end read_register_history;                              


    function read_register_value(
                               p_register_value_id in number
                              ,p_lock              in boolean default false
                              ,p_raise_ndf         in boolean default false
                              ) return register_value%rowtype
    is
        l_register_value_row register_value%rowtype;
    begin
        if (p_lock) then
            select *
              into l_register_value_row
              from register_value r
             where  r.id = p_register_value_id
            for update;
        else
            select *
              into l_register_value_row
              from register_value r
             where  r.id = p_register_value_id;
        end if;
        return l_register_value_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Регістр з ідентифікатором {' || p_register_value_id ||'} не знайдений');
           else return null;
           end if;
    end read_register_value;                              

    function read_register_value(
                               p_object_id        in number   
                              ,p_register_type_id in number
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              ) return register_value%rowtype
     is
        l_register_value_row    register_value%rowtype;
    begin                          
        if (p_lock) then
            select *
              into l_register_value_row
              from register_value r
             where r.object_id = p_object_id
               and r.register_type_id = p_register_type_id
            for update;
        else
            select *
              into l_register_value_row
              from register_value r
             where r.object_id = p_object_id
               and r.register_type_id = p_register_type_id;
        end if;
        return l_register_value_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, q'[Регістр об'єкта {]' || p_object_id ||
                                               '} з ідентифікаторм {'|| p_register_type_id ||'} не знайдений');
           else return null;
           end if;
    end read_register_value;                              

    function read_register_value(
                               p_object_id        in number   
                              ,p_register_code    in varchar2
                              ,p_lock             in boolean default false
                              ,p_raise_ndf        in boolean default false
                              ) return register_value%rowtype
     is
        l_register_value_row    register_value%rowtype;
        l_register_type_id      number;
        l_object_row            object%rowtype;
    begin
        l_object_row       := object_utl.read_object(p_object_id => p_object_id);
        l_register_type_id := read_register_type(p_register_code  => p_register_code
                                                ,p_raise_ndf      => true).id;
        l_register_value_row := read_register_value(p_object_id        => p_object_id    
                                                   ,p_register_type_id => l_register_type_id
                                                   ,p_lock             => p_lock
                                                   ,p_raise_ndf        => p_raise_ndf
                                                   );
        return l_register_value_row;
    end read_register_value;                              

    function create_register_history(
                              p_register_id    in number
                             ,p_value_date     in date
                             ,p_amount         in number
                             ,p_is_active      in varchar2
                             ,p_is_planned     in varchar2
                             ,p_document_id    in number default null)
             return number                
     is
        l_id    number;
    begin
        insert into register_history  
             (id, register_value_id, value_date, amount, is_active, is_planned, document_id)
          values(register_seq.nextVal, p_register_id, trunc(p_value_date), p_amount, p_is_active, p_is_planned, p_document_id)
        returning id into l_id;
        return l_id;   
    end;                         

    function update_register_history(
                              p_register_history_id in number
                             ,p_value_date          in date
                             ,p_amount              in number
                             ,p_is_active           in varchar2
                             ,p_date_from           in date
                             ,p_date_to             in date
                             ,p_is_planned          in varchar2
                             ,p_document_id         in number default null)
                return number                     
     is
        l_register_value_row register_value%rowtype;
        l_register_hist_row  register_history%rowtype;
        l_amount_total       number;
        l_amount             number;
        l_register_hist_id   number;   
    begin
        l_register_hist_row := read_register_history(
                                   p_register_history_id => p_register_history_id
                                  ,p_lock              => false
                                  ,p_raise_ndf         => true
                                  );
              
        l_register_value_row := read_register_value(
                                   p_register_value_id => l_register_hist_row.register_value_id
                                  ,p_lock              => true
                                  ,p_raise_ndf         => true
                                  );
        -- сохраняем историю    
        update register_history h set
               is_active = 'N'
              ,sys_time  = sysdate 
         where h.id = p_register_history_id;

        l_register_hist_id := create_register_history(
                                  p_register_id    => l_register_value_row.id
                                 ,p_value_date     => p_value_date
                                 ,p_amount         => p_amount
                                 ,p_is_active      => p_is_active
                                 ,p_is_planned     => p_is_planned
                                 ,p_document_id    => p_document_id);

        select sum(amount), nvl(sum(case when is_planned = 'N' then amount end), 0) 
          into l_amount_total, l_amount  
          from register_history h
        where  h.register_value_id = l_register_value_row.id
          and h.is_active = 'Y';

        update register_value v set
               plan_value   = l_amount_total
              ,actual_value = l_amount                  
         where v.id = l_register_value_row.id;
        return l_register_hist_id; 
    end;                         

    procedure set_register_actual_value(
                              p_register_id    in number
                             ,p_value_date     in date
                             ,p_amount         in number
                             ,p_document_id    in number)
     is
        l_register_value_row register_value%rowtype;
        l_amount_total       number;
        l_amount             number;   
    begin
        l_register_value_row := read_register_value(
                                   p_register_value_id => p_register_id
                                  ,p_lock              => true
                                  ,p_raise_ndf         => true
                                  );
        update register_history h set
               h.is_planned = 'N'
              ,h.document_id  = p_document_id 
              ,h.sys_time = sysdate 
         where h.register_value_id = l_register_value_row.id
           and h.value_date = p_value_date
           and h.amount = p_amount
           and h.is_planned = 'Y';
        if sql%rowcount = 0 then
            raise_application_error(-20000, 'Не знайдена сума {'||p_amount||
                                            '} і дата {'||to_char(p_value_date, 'dd.mm.yyyy')||
                                            '} для встановлення актуального значення регістру {'||
                                            l_register_value_row.id||'}');
        end if;                                        

        select sum(amount), nvl(sum(case when is_planned = 'N' then amount end), 0) 
          into l_amount_total, l_amount  
          from register_history h
        where  h.register_value_id = p_register_id
          and h.is_active = 'Y';

        update register_value v set
               plan_value   = l_amount_total
              ,actual_value = l_amount              
         where v.id = p_register_id;
        
    end set_register_actual_value;

    procedure set_register_actual_value(
                              p_object_id        in number   
                             ,p_register_code    in varchar2
                             ,p_value_date       in date
                             ,p_amount           in number
                             ,p_document_id      in number default null )
     is
    begin 
        set_register_actual_value(
                              p_register_id  => read_register_value(
                                                               p_object_id        => p_object_id   
                                                              ,p_register_code    => p_register_code
                                                              ).id
                             ,p_value_date   => p_value_date
                             ,p_amount       => p_amount
                             ,p_document_id  => p_document_id);
               
    end;                         

    procedure set_register_actual_value(
                             p_register_history_id in number
                            ,p_value_date          in date
                            ,p_document_id      in number default null
                                )
     is
        l_register_value_row register_value%rowtype;
        l_amount_total       number;
        l_amount             number;
    begin
             
        l_register_value_row := read_register_value(
                                   p_register_value_id => read_register_history(
                                                               p_register_history_id => p_register_history_id
                                                              ,p_raise_ndf         => true
                                                              ).register_value_id
                                  ,p_lock              => true
                                  ,p_raise_ndf         => true
                                  );
                                  
        update register_history h set
               h.is_planned = 'N'
              ,h.value_date = p_value_date 
              ,document_id  = p_document_id
              ,h.sys_time = sysdate 
         where h.id = p_register_history_id
           and h.is_planned = 'Y';

        select sum(amount), nvl(sum(case when is_planned = 'N' then amount end), 0) 
          into l_amount_total, l_amount  
          from register_history h
        where  h.register_value_id = l_register_value_row.id
          and h.is_active = 'Y';

        update register_value v set
               plan_value   = l_amount_total
              ,actual_value = l_amount              
         where v.id = l_register_value_row.id;

    end;              
               
--declare
    
begin
    init_register_type;
end Register_UTL;
/
PROMPT *** Create  grants  REGISTER_UTL ***
grant EXECUTE   on register_utl   to BARS_ACCESS_DEFROLE;

PROMPT =================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/REGISTER_UTL.sql ===== *** End ***
PROMPT ===================================================================================
