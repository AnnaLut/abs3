create or replace package smb_deposit_proc is

    function get_smb_interest_expense_acc(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_value_date in date)
    return number_list;

    function  get_smb_penalty_expense_acc(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_value_date in date)
    return number_list;

    procedure run_reserve_accounts_in_ea(
        p_activity_id in integer);

    procedure run_new_tranche_contract(
        p_activity_id in integer);
        
    procedure create_new_tranche(p_process_id in number);
            
    procedure can_run_back_office_confirm(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    procedure can_run_new_tranche(
        p_process_id in number,
        p_can_run_flag out varchar2,
        p_explanation out varchar2);

    procedure can_create_new_tranche(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2);
    
    procedure create_new_tranche_contract(p_activity_id  in number);
    
    procedure create_transfer_tranche_funds(p_activity_id  in number);
    
    procedure revert_new_tranche_contract(
        p_activity_id in integer);
        
    procedure revert_transfer_tranche_funds(
        p_activity_id in integer);

    procedure can_run_transfer_tranche_funds(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    procedure run_transfer_tranche_funds(
            p_activity_id in integer);
    
    procedure exec_failed_process(
            p_process_id in number
           ,p_comment     in varchar2 
            );

    procedure bo_confirm_replenish_tranche(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    procedure can_create_replenish_tranche(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2);

    procedure can_run_replenish_tranche(
        p_process_id   in number,
        p_can_run_flag out varchar2,
        p_explanation  out varchar2);

    procedure create_replenish_tranche(
        p_process_id in number);

    procedure can_run_transfer_replenishment(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    procedure run_transfer_replenishment(
        p_activity_id in integer);

    procedure revert_transfer_replenishment(
        p_activity_id in integer);

    procedure can_create_tranche_blocking(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2);

    procedure create_tranche_blocking(
        p_process_id in number);

    procedure run_tranche_blocking(
        p_activity_id in integer);

    procedure can_create_tranche_unblocking(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2);

    procedure create_tranche_unblocking(
        p_process_id in number);

    procedure run_tranche_unblocking(
        p_activity_id in integer);

    procedure can_create_return_tranche(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2);

    procedure can_run_return_tranche(
        p_process_id in number,
        p_can_run_flag out varchar2,
        p_explanation out varchar2);

    procedure create_return_tranche(
        p_process_id in number);

    procedure can_run_return_transfer_funds(
        p_activity_id  in integer,
        p_can_run_flag out char,
        p_explanation  out varchar2);

    procedure can_run_bo_confirm_ret_tranche(
        p_activity_id  in integer,
        p_can_run_flag out char,
        p_explanation  out varchar2);

    procedure run_return_transfer_funds(
        p_activity_id in integer);

    --- ON DEMAND
    -- ��� - ������� �� ����������
    -- DoD - deposit on demand
    -- �������� �� ����������� �������� ���
    procedure can_create_new_on_demand(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2);

    -- �������� �� ����������� ���������� �������� ��� ���
    procedure can_run_new_on_demand(
        p_process_id in number,
        p_can_run_flag out varchar2,
        p_explanation out varchar2);

    -- �������� �������� ��� ���
    procedure create_new_on_demand(p_process_id in number);

    -- ��� ������������� ���-������
    procedure can_run_bo_confirm_on_demand(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    -- �������� ������ ��� ��� 
    procedure run_new_on_demand_contract(
        p_activity_id in integer);

    -- ����� ����������� ��� ��� 
    procedure revert_new_on_demand_contract(
        p_activity_id in integer);

    -- �������� ������� ����� �� ����� ��� ��������
    procedure can_run_transfer_on_demand(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    -- ������� �����
    -- ��������� ��������� ��� � ACTIVE
    procedure run_transfer_on_demand(
            p_activity_id in integer);

    -- ����� �������� �����        
    procedure revert_transfer_on_demand(
        p_activity_id in integer);

    ---CLOSE_ON DEMAND
    -- �������� �� ����������� �������� ���
    procedure can_create_close_on_demand(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2);

    -- �������� �� ����������� ���������� �������� ��� �������� ���
    procedure can_run_close_on_demand(
        p_process_id in number,
        p_can_run_flag out varchar2,
        p_explanation out varchar2);

    -- �������� �������� ��� �������� ���
    procedure create_close_on_demand(p_process_id in number);

    -- ��� ������������� ���-������
    procedure can_bo_confirm_close_on_demand(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    -- �������� ������� ����� �� ����� ���������� �����
    procedure can_run_action_close_on_demand(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    -- ������� �����
    -- ��������� ��������� ��� � CLOSED
    procedure run_action_close_on_demand(
            p_activity_id in integer);

    -- �������� �������� ��� ��������� ���� ���������� ��� ���
    procedure create_change_calc_type_dod(p_process_id in number);

    -- ��� ������������� ���-������ - ��������� ���� ���������� ��� ���
    procedure can_confirm_change_calc_type(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2);

    -- ��������� ���� ���������� ��� ���
    procedure change_calc_type_dod_run(
            p_activity_id in number);

    -- ��������, ���������� �� process_utl        
    procedure remove_new_tranche(p_process_id in number);
    procedure remove_return_tranche(p_process_id in number);
    procedure remove_new_on_demand(p_process_id in number);
    procedure remove_replenish_tranche(p_process_id in number);
    procedure remove_close_on_demand(p_process_id in number);


end;
/
create or replace package body smb_deposit_proc as

/*
operation_type
1          DU$    DU$ �������� ���������������� ������� � 
2          DU%   DU% ����������� �������
3          DU0    DU0 �������� ����� �� ���������� �������  - ��������� ������ ��� ��������� ����������� ����� ��� �������� ��������� �������
4          DU1    DU1 ������� ������� (�����.)
6          DU3    DU3 ��������� �������� (�����.)
8          DU5    DU5 ���������� �������� -- ��������� ������ ��� ��������� ����������� ����� ��� �������� ��������� �������
16        DUT    DUT ��������� ������.���� ������ � ���.������� � 
*/

    function check_available(p_account_row in accounts%rowtype
                            ,p_amount       in number)
      return number is
      l_result number := 1;
    begin
      if p_account_row.acc is null then
        l_result := 0; 
      elsif p_account_row.pap = 1 and p_account_row.lim + p_account_row.ostc + p_amount > 0 then
        l_result := 0;
      elsif p_account_row.pap = 2 and p_account_row.lim + p_account_row.ostc - p_amount < 0 then
        l_result := 0;
      elsif p_account_row.ostc - p_amount < 0 then
        l_result := 0;
      end if;
      return l_result;
    end;

    function get_smb_interest_expense_acc(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_value_date in date)
    return number_list
    is
        l_interest_expense_account_id integer;
    begin
        l_interest_expense_account_id := smb_deposit_utl.get_expense_account(
                                               p_object_id         => p_deal_id
                                              ,p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT');

        return case when l_interest_expense_account_id is null then null else number_list(l_interest_expense_account_id) end;
    end;

    function  get_smb_penalty_expense_acc(
        p_deal_id in integer,
        p_account_type_id in integer,
        p_value_date in date)
    return number_list
    is
        l_interest_expense_account_id integer;
    begin
        l_interest_expense_account_id := smb_deposit_utl.get_expense_account(
                                               p_object_id         => p_deal_id
                                              ,p_account_type_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT' );
        return case when l_interest_expense_account_id is null then null else number_list(l_interest_expense_account_id) end;
    end;

    -- TODO : ������� � ACCREG
    function read_account_reserve(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_kf in varchar2)
    return accounts_rsrv%rowtype
    is
        l_account_reserve_row accounts_rsrv%rowtype;
    begin
        select *
        into   l_account_reserve_row
        from   accounts_rsrv t
        where  t.nls = p_account_number and
               t.kv = p_currency_id and
               t.kf = p_kf;

        return l_account_reserve_row;
    exception
        when no_data_found then
             return null;
    end;

    procedure put_new_object_to_ea_queue(
        p_type_id in varchar2,
        p_object_id in varchar2,
        p_customer_id in integer,
        p_object_kf in varchar2)
    is
        l_requests_count integer;
    begin
        select count(*)
        into   l_requests_count
        from   ead_sync_queue t
        where  t.type_id = p_type_id and
               t.obj_id = p_object_id and
               rownum <= 1;

        -- ����� ��������� ������������ � ����, �� ��'��� �� ����������� �����
        if (l_requests_count = 0) then
            ead_pack.msg_create(p_type_id, p_object_id, p_customer_id, p_object_kf);
        end if;
    end;

    procedure determine_tranche_balance_acc(
            p_account_type_code      in varchar2,
            p_deal_group_id          in number,
            p_deal_currency_id       in number,
            p_deal_product_type_code in varchar2,
            p_deal_product_code      in varchar2,
            p_balance_account        out varchar2,
            p_ob22_code              out varchar2)
     is
    begin
        deal_utl.get_deal_balance_acc_settings(
                        p_account_type_id   => attribute_utl.get_attribute_id(p_account_type_code)
                       ,p_deal_group_id     => p_deal_group_id
                       ,p_currency_id       => p_deal_currency_id
                       ,p_product_id        => product_utl.read_product(
                                                        p_product_type_id => object_utl.read_object_type(p_object_type_code => p_deal_product_type_code).id
                                                       ,p_product_code    => p_deal_product_code).id
                       ,p_balance_account   => p_balance_account
                       ,p_ob22_code         => p_ob22_code);
    end;
        
    procedure check_main_account(
                    p_object_id         in number
                   ,p_customer_id       in number
                   ,p_currency_id       in number
                   ,p_branch_code       in varchar2 
                   ,p_product_type_code in varchar2
                   ,p_product_code      in varchar2
                   ,p_account_number    in out varchar2
                   ,p_balance_account   in out varchar2
                   ,p_ob22_code         in out varchar2
                   ,p_is_tranche        in number default 1
                    )
     is
        l_smb_account_type_id  number;
        l_mfo                  varchar2(6 char) := bars_context.extract_mfo(p_branch_code);
        l_deal_group_id        number;           
    begin
        /* ����� � ��������� ���������
           ����� ��������� � 2-� ������ (��� �������� ����� ��������� ������ � ��� ��������)
           ���� ���� ����������� �� ��� ����� �������������, 
           � ��� �������� � ������� � �������� ����������� �������� ������� (� ����� ���� �� ������ exception) 
            */
        l_smb_account_type_id := attribute_utl.get_attribute_id('DEPOSIT_PRIMARY_ACCOUNT');
        -- 
        if p_object_id is not null then
            l_deal_group_id := attribute_utl.get_number_value(p_object_id, 'DEAL_BALANCE_GROUP');
        else
            -- ������ ��� �� ������ (������ � can_create )  
            l_deal_group_id := smb_deposit_utl.get_customer_group (
                                                           p_customer_id => p_customer_id
                                                          ,p_is_tranche  => p_is_tranche);
        end if;

        determine_tranche_balance_acc(
                         p_account_type_code      => 'DEPOSIT_PRIMARY_ACCOUNT'
                        ,p_deal_group_id          => l_deal_group_id
                        ,p_deal_currency_id       => p_currency_id
                        ,p_deal_product_type_code => p_product_type_code 
                        ,p_deal_product_code      => p_product_code 
                        ,p_balance_account        => p_balance_account 
                        ,p_ob22_code              => p_ob22_code);

        -- ������������� ��� ������� ������� ��� ���� ����, ���� �
        -- ����� ���������
        select min(a.nls) keep (dense_rank last order by a.daos)
        into   p_account_number
        from   accounts a
        where  a.rnk = p_customer_id and
               a.kv = p_currency_id and
               a.kf = l_mfo and
               a.nbs = p_balance_account and
               a.ob22 = p_ob22_code and
               a.dazs is null and
               exists (select 1
                       from   deal_account d
                       where  d.account_id = a.acc and
                              d.account_type_id = l_smb_account_type_id);
    end;    
    
    function find_or_create_main_account(
        p_object_id         in number,
        p_customer_id       in integer,
        p_currency_id       in integer,
        p_branch_code       in varchar2,
        p_product_type_code in varchar2,
        p_product_code      in varchar2,
        p_is_tranche        in number default 1
        )
    return varchar2
    is
        l_account_number      varchar2(15 char);
        l_mfo                 varchar2(6 char) := bars_context.extract_mfo(p_branch_code);
        l_error_message       varchar2(32767 byte);
        l_balance_account     varchar2(4 char);
        l_ob22_code           varchar2(2 char);
    begin
        -- ��������� �� ������������ ����� ��� ��������� ����
        check_main_account(
                    p_object_id         => p_object_id
                   ,p_customer_id       => p_customer_id
                   ,p_currency_id       => p_currency_id
                   ,p_branch_code       => p_branch_code 
                   ,p_product_type_code => p_product_type_code 
                   ,p_product_code      => p_product_code 
                   ,p_account_number    => l_account_number
                   ,p_balance_account   => l_balance_account
                   ,p_ob22_code         => l_ob22_code
                   ,p_is_tranche        => p_is_tranche
                    );

        logger.log_info(p_procedure_name => $$plsql_unit||'.find_or_create_main_account'
                       ,p_log_message    => 'balance_account  : ' || l_balance_account || chr(10) ||
                                            'ob22_code        : ' || l_ob22_code
                       ,p_object_id      => p_object_id     
                            );

        if l_account_number is null then 
            -- �� ������� ����� �������� ������� - ������ ����� ��������������
            select min(a.nls) keep (dense_rank last order by a.crt_dt)
            into   l_account_number
            from   accounts_rsrv a
            where  a.kf = l_mfo and
                   a.kv = p_currency_id and
                   a.rnk = p_customer_id and
                   a.ob22 = l_ob22_code and
                   substr(a.nls, 1, 4) = l_balance_account;

            if (l_account_number is null) then
                -- ���� ����� �������������� - �������� ����� ������ �������
                l_account_number := f_newnls2(null,
                                              'DPU',
                                              l_balance_account,
                                              p_customer_id,
                                              null,
                                              p_currency_id);

                -- ��������� ������� �� �������� ���� �� ��
                accreg.rsrv_acc_num( p_nls      => l_account_number,
                                     p_kv       => p_currency_id,
                                     p_nms      => customer_utl.get_customer_name(p_customer_id),
                                     p_branch   => p_branch_code, 
                                     p_isp      => sys_context('bars_global', 'user_id'),
                                     p_vid      => 4 /*����������*/,
                                     p_rnk      => p_customer_id,
                                     p_agrm_num => kl.get_customerw(p_customer_id, 'NDBO'), -- 'NUMD') ��������� ������ ������ ����������� �������� (NUMD) 
                                                                                            -- �� ����� �������� ��� (NDBO) � ����� � ����������� 
                                                                                            -- ������ ����������� �������� (NUMD) � �������������� ��������� ��������
                                     p_trf_id   => 0,
                                     p_ob22     => l_ob22_code,
                                     p_errmsg   => l_error_message);

                 if (l_error_message is not null) then
                    logger.log_info(
                                      p_procedure_name => $$plsql_unit||'.find_or_create_main_account'
                                     ,p_log_message    => l_error_message
                                     ,p_object_id      => null
                                     ,p_auxiliary_info => null
                                      );

                     raise_application_error(-20000, '������� ��� ����������� ������ ����������� �������: ' || l_error_message);
                 end if;
            end if;
        end if;

        return l_account_number;
    end;    
    
    function open_interest_account(
        p_deal_id in integer,
        p_main_account_row in accounts%rowtype)
    return integer
    is
        l_interest_account_number varchar2(15 char);
        l_int_accn_row int_accn%rowtype;
        l_int_account_row accounts%rowtype;
        l_interest_account_id integer;
        l_interest_expense_account_id integer;
        l_interest_balance_account varchar2(4 char);
        l_interest_ob22_code varchar2(2 char);
    begin
        -- ������� �������� ������� ��� ��������, ������ ������� �������, �� ��������������� ����� � �������� ��������
        l_int_accn_row := interest_utl.read_int_accn(p_main_account_row.acc, interest_utl.INTEREST_KIND_LIABILITIES, p_raise_ndf => false);
        
        --  ������ �� ����
        l_int_account_row := account_utl.read_account(p_account_id => l_int_accn_row.acra
                                                     ,p_raise_ndf => false);
        -- 
        if (l_int_account_row.acc is null) or (l_int_account_row.dazs is not null) then
            -- �� ������� ��������� ������ ��� ��������� ������� - �.�. �� ������ ��������� ���� � �������� ������� ��������������� ��� ���������� ���� ����������� �������
            -- ���� ��������� ����� (�� ���������, � ���� ���������, ������� �������� ������� ��� ������)

            deal_utl.get_deal_balance_acc_settings('DEPOSIT_INTEREST_ACCOUNT',
                                                   attribute_utl.get_number_value(p_deal_id, 'DEAL_BALANCE_GROUP'),
                                                   p_main_account_row.kv,
                                                   deal_utl.get_deal_product_id(p_deal_id),
                                                   l_interest_balance_account,
                                                   l_interest_ob22_code);
                                                   
            -- ���� ��������
            l_interest_expense_account_id := smb_deposit_utl.get_expense_account(
                                      p_object_id         => p_deal_id
                                     ,p_account_type_code => 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT');

            /*                         
            l_interest_expense_account_id := deal_utl.get_deal_account_settings('DEPOSIT_INTEREST_EXPENSE_ACCOUNT',
                                                                                attribute_utl.get_number_value(p_deal_id, 'DEAL_BALANCE_GROUP'),
                                                                                case when p_main_account_row.kv = gl.baseval 
                                                                                     then p_main_account_row.kv 
                                                                                end,    -- ���� �������� ���� �� ���.������ ������� null
                                                                                null,
                                                                                p_main_account_row.branch);*/
                                                                         
            l_interest_account_number := f_newnls2(
                                                    acc2_       => null                        -- ACC �����
                                                   ,descrname_  => 'DPU'                       -- ��� �����
                                                   ,nbs2_       => l_interest_balance_account  -- ����� ����������� �����
                                                   ,rnk2_       => p_main_account_row.rnk      -- ��������������� ����� �������
                                                   ,idd2_       => null                        -- ����� ������
                                                   ,kv_         => p_main_account_row.kv       -- ������
                                                   );
            logger.log_info(p_procedure_name => $$plsql_unit||'.open_interest_account',
                            p_log_message    => 'l_interest_account_number : ' || l_interest_account_number --  || chr(10) ||
                        );

            accreg.opn_acc(
                           p_acc            => l_interest_account_id       -- Account Id
                          ,p_rnk            => p_main_account_row.rnk      -- Customer number
                          ,p_nbs            => l_interest_balance_account  -- R020
                          ,p_ob22           => l_interest_ob22_code        -- OB22
                          ,p_nls            => l_interest_account_number   -- Account number
                          ,p_nms            => substr('����������� ������� �'||customer_utl.get_customer_name(p_main_account_row.rnk)||'�', 1, 70)  -- Account name
                          ,p_kv             => p_main_account_row.kv       -- Currency code
                          ,p_isp            => sys_context('bars_global', 'user_id')
                          ,p_tip            => 'DEN'
                          ,p_vid            => 4 -- ����������
                          ,p_branch         => p_main_account_row.branch);

            interest_utl.create_int_accn(p_main_account_id => p_main_account_row.acc,
                                         p_interest_kind_id => interest_utl.INTEREST_KIND_LIABILITIES,
                                         p_rest_kind_id => interest_utl.BALANCE_KIND_CALENDAR_OUT, -- �� �����������, ��� ������� �� ������� - �������� �� ���������� ���� (��� ���������� ������� ��������������� ����� ������� �� ������)
                                         p_accrual_method_id => interest_utl.INTEREST_METH_NORMAL, -- �� �����������, ����� ����������� �� ������� - ���������� (��� ���������� ������� ��������������� ������� ����������� �� ������)
                                         p_base_year_id => 0,                                      -- �� �����������, ������� �� �� ������� - 365/366 (��� ���������� ������� ��������������� ����������� ������)
                                         p_accrual_frequency_id => 1,
                                         p_accrual_stop_date => null,                              -- �� ������������ ���� ���������� ���������� - ��� ������� ������ ���� ����
                                         p_accrual_operation_code => 'DU%',                        -- ���������� �������� ����������� �������
                                         p_interest_account_id => l_interest_account_id,
                                         p_opposite_account_id => l_interest_expense_account_id,
                                         p_interest_remnant => 0);
        else
            l_interest_account_id := l_int_account_row.acc;
        end if;

        return l_interest_account_id;
    end;

    procedure create_new_tranche(
        p_process_id in number)
    is
        l_process_row                   process%rowtype;
        l_tranche_row                   smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_main_account_row              accounts%rowtype;
        l_interest_account_row          accounts%rowtype;
        l_deal_group_id                 integer;
        l_object_id                     number;
    begin
        l_object_id   := smb_deposit_utl.create_tranche(p_process_id => p_process_id);
        l_process_row := process_utl.read_process(p_process_id);
        l_process_row.object_id := l_object_id;
        l_tranche_row           := smb_deposit_utl.get_tranche_from_xml(l_process_row.process_data);
        -- ������� ���������� ���������� ������� �� ��������� ����
        -- ������� : ����� ����� ������� �� ������ ��������������� ���������� 2610 (��� ��������� �������) � 2600 (��� ������ �� ������) 
        --           �� ��� �������� ���-���������, ��� � ��� ��������� ���. �����, ���������� �������� �������� ������ ��������������� ������� 
        --           2651 (������� ������) �� 2650 (������ �� ������). �� ������� ��� ���������� �������� �������� �� ���� �볺���, ��� ���� ������
        --           ����������� �������� ����? ���� �� �������, �� �� ������� ���������� ��������� �������� �������� ���� ����� �볺����?
        -- 
        --           ����� ������� ��������, �� ���� ����������� ������������ �볺��� �� ���� �������.
        -- 
        -- ³������ : ���������� �������� �������� ������� �� ���� �볺���, ���� ������ ����������� �������� ����,
        --             - �������� ��������� ��������� ������� 2650
        
        l_deal_group_id := smb_deposit_utl.get_customer_group (p_customer_id => l_tranche_row.customer_id);

        if (l_deal_group_id is not null) then
            attribute_utl.set_value(l_process_row.object_id, 'DEAL_BALANCE_GROUP', l_deal_group_id);
        end if;

        -- ����'����� ������ �� ����� ���������� ��'����
        update process p
        set    p.object_id = l_process_row.object_id
        where  p.id = p_process_id;

        if (l_tranche_row.primary_account is null) then
            -- ��� ������� ����������� ������ - ������/��������� �������� ������� ��� ���������� ���������� �������
            l_tranche_row.primary_account := find_or_create_main_account(
                                                    p_object_id         => l_process_row.object_id,
                                                    p_customer_id       => l_tranche_row.customer_id,
                                                    p_currency_id       => l_tranche_row.currency_id,
                                                    p_branch_code       => l_tranche_row.branch,
                                                    p_product_type_code => 'SMB_DEPOSIT_TRANCHE',
                                                    p_product_code      => 'SMB_DEPOSIT_TRANCHE'
                                                    );
        end if;

        -- ������ �������� ������� ����� �������� (�� ��������������)
        l_main_account_row := account_utl.read_account(l_tranche_row.primary_account,
                                                       l_tranche_row.currency_id,
                                                       bars_context.extract_mfo(l_tranche_row.branch),
                                                       p_raise_ndf => false);

        logger.log_info(p_procedure_name => $$plsql_unit||'.create_new_tranche account',
                                p_log_message    => 'p_process_id     : ' || p_process_id || chr(10) ||
                                                    'PrimaryAccountId : ' || l_main_account_row.acc  ||' open'
                               ,p_object_id      => l_object_id
                                );
        if (l_main_account_row.acc is not null) then
            l_interest_account_row.acc := open_interest_account(l_process_row.object_id, l_main_account_row);
            logger.log_info(p_procedure_name => $$plsql_unit||'.create_new_tranche account',
                                    p_log_message    => 'p_process_id     : ' || p_process_id || chr(10) ||
                                                        'PrimaryAccountId : ' || l_main_account_row.acc  ||' add into deal_account'
                                   ,p_object_id      => l_object_id
                                    );
            -- ���� ������� ��� ��������, ����'����� ���� �� ������������ ����� ����������� ������
            deal_utl.set_deal_account(l_process_row.object_id, 'DEPOSIT_PRIMARY_ACCOUNT', l_main_account_row.acc);
            deal_utl.set_deal_account(l_process_row.object_id, 'DEPOSIT_INTEREST_ACCOUNT', l_interest_account_row.acc);
        end if;
        
        -- ��� ��� �������� ���� ����� ���� ������ ��������������, �� ������ � process -> process_data � ���� �����
        if l_tranche_row.primary_account is not null then
            -- ������ ���� � process_data
            -- ���������� ����
            l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                                    l_process_row.process_data
                                                                   ,'PrimaryAccount'
                                                                   ,l_tranche_row.primary_account
                                                                   ,smb_deposit_utl.PARENT_NODE_TRANCHE);
            -- ���� ���������� ���������                                                        
            if l_interest_account_row.acc is not null then
               -- � ��� ���� ������ id ����� (acc), ����� nls  
                l_interest_account_row := account_utl.read_account(p_account_id => l_interest_account_row.acc 
                                                                  ,p_lock       => false
                                                                  ,p_raise_ndf  => true);
            
                l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                            l_process_row.process_data
                                                           ,'InterestAccount'
                                                           ,l_interest_account_row.nls
                                                           ,smb_deposit_utl.PARENT_NODE_TRANCHE);
            end if;     
           
        end if; 
        smb_deposit_utl.set_process_data (
                           p_process_id => p_process_id
                          ,p_data       => l_process_row.process_data
                          );
        
    end create_new_tranche;
    
    procedure can_create_new_tranche(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2)
     is
        l_tranche_row      smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_account_number   varchar2(15);
        l_balance_account  varchar2(4 char);
        l_ob22_code        varchar2(2 char);
        l_interest_rate    number;
        l_accounts_row     accounts%rowtype;
    begin
        p_can_create_flag := 'Y';
        l_tranche_row := smb_deposit_utl.get_tranche_from_xml(p_data => p_process_data);

        if l_tranche_row.start_date is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ���� �������';
            return;
        end if;

        if l_tranche_row.expiry_date is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ���� ���������';
            return;
        end if;
        if l_tranche_row.is_prolongation = 1 and
           nvl(l_tranche_row.number_prolongation, 0) <= 0 then
            p_can_create_flag := 'N';
            p_explanation     := '������ ������� �����������';
            return;
        end if;
        if l_tranche_row.is_prolongation = 0 and
           l_tranche_row.number_prolongation > 0 then
            p_can_create_flag := 'N';
            p_explanation     := '����������� �� �������, ��� ������� ������� { '|| l_tranche_row.number_prolongation || ' }';
            return;
        end if;
        if l_tranche_row.is_prolongation = 1 and
           nvl(l_tranche_row.apply_bonus_prolongation, 0) not in (1, 2) then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ����� ������������ ������� ������ ��� ����������� (��� �����/��� �����)';
            return;
        end if;
        -- �� ������ ��������� 5 ��� � ������������� (???)
        if case when l_tranche_row.is_prolongation = 1 
               -- ����������� �� 1 ��� ����� ������� ������� 
               then l_tranche_row.number_prolongation  + 1
               else 1
           end * (l_tranche_row.expiry_date - l_tranche_row.start_date) > 5 * 365 then
            p_can_create_flag := 'N';
            p_explanation     := '����� ������ �� ������� ������������ {'||5*365||'} ���';
            return;
        end if;

        -- ��������� �� �������������
        if nvl(l_tranche_row.frequency_payment, 0) not in (1, 2, 3 ) then
            p_can_create_flag := 'N';
            p_explanation     := '������ ����������� ������� �������';
            return;
        end if;
        
        -- ���� ������������� �����, �������  
        --   - ���� ������ ������ ���� ������ 30 ��� 90 ���� ��������������      
        if l_tranche_row.frequency_payment < 3 and
           case when l_tranche_row.frequency_payment = 1 then 30
                when l_tranche_row.frequency_payment = 2 then 90
           end > l_tranche_row.expiry_date - l_tranche_row.start_date + 1 then
            p_can_create_flag := 'N';
            p_explanation     := '����� ������ ����� �� ����������� ������� �������';
            return;
        end if;

        -- ������ ������� ������������� ����� �� ����� �������
        if l_tranche_row.is_capitalization = 1 and l_tranche_row.frequency_payment not in (1, 2) then
            p_can_create_flag := 'N';
            p_explanation     := '��� ����������� ����������� ������� '||chr(10)||
                                 '������� ���� {'||smb_deposit_utl.PAYMENT_TERM_MONTHLY||' / '||
                                 smb_deposit_utl.PAYMENT_TERM_QUARTERLY||'}';
            return;
        end if;

        -- ������  ���� ������ 2-� ����
        if l_tranche_row.expiry_date - l_tranche_row.start_date + 1 < 3 then
            p_can_create_flag := 'N';
            p_explanation     := '����� ������ ������� ���� ������ �� 2 ��';
            return;
        end if;

        if nvl(l_tranche_row.amount_tranche, 0) <= 0 then
            p_can_create_flag := 'N';
            p_explanation     := '������ ���� ������';
            return;
        end if;

        if l_tranche_row.debit_account is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������� ��� �������� �����';
            return;
        end if;
        -- � ���� �� ����� ����
        l_accounts_row := account_utl.read_account(
                                         p_account_number => l_tranche_row.debit_account
                                        ,p_currency_id    => l_tranche_row.currency_id
                                        ,p_raise_ndf      => true);
        -- ���� �����������
        if l_tranche_row.customer_id <> l_accounts_row.rnk then
            p_can_create_flag := 'N';
            p_explanation     := '������� ��� �������� �� �������� ������� �볺���';
            return;
        end if; 
        if l_tranche_row.return_account is not null then
           -- � ���� �� ����� ����
           l_accounts_row := account_utl.read_account(
                                           p_account_number => l_tranche_row.return_account
                                          ,p_currency_id    => l_tranche_row.currency_id
                                          ,p_raise_ndf      => true);
          -- ���� �����������
          if l_tranche_row.customer_id <> l_accounts_row.rnk then
              p_can_create_flag := 'N';
              p_explanation     := '������� ��� ���������� �� �������� ������� �볺���';
              return;
          end if; 
        end if;

        if nvl(case when l_tranche_row.is_individual_rate = 1 
                     then l_tranche_row.individual_interest_rate 
                     else l_tranche_row.interest_rate 
               end, 0) = 0 then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ��������� ������';
            return;
        end if;

        if nvl(l_tranche_row.is_individual_rate, 0) = 0 then
           select Interest_Rate
             into l_interest_rate     
             from xmltable('/SMBDepositTrancheInterestRate' passing xmltype(smb_deposit_utl.get_interest_rate(p_data => p_process_data)) columns   
                                               Interest_Rate                 number         path 'InterestRate');
             if l_tranche_row.interest_rate <> l_interest_rate then
                 p_can_create_flag := 'N';
                 -- ���� ��������� (�� ������ �� ������������ % ������) ������� ��������� ���������� % ������ 
                 p_explanation     := '������� ��������� ������ {'||to_char(l_tranche_row.interest_rate, 'fm990.00')||
                                      '} �� ������� ������������ {'||to_char(l_interest_rate , 'fm990.00')||'}.'||chr(10)||
                                      '������� ��������� ������';
                 return;
             end if;
        end if;

        if l_tranche_row.is_individual_rate = 1 and trim(l_tranche_row.comment_) is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������� ������������ ������������ ������';
            return;
        end if;
       
        -- ��� ����� ��������� ��� �������� ����� �� �������
        -- �.�. ���� ����� ��� ��� �� � �������
        if l_tranche_row.primary_account is null then
            -- ��������� ���� �� �������� ����
            check_main_account(
                      p_object_id         => null
                     ,p_customer_id       => l_tranche_row.customer_id
                     ,p_currency_id       => l_tranche_row.currency_id
                     ,p_branch_code       => l_tranche_row.branch
                     ,p_product_type_code => 'SMB_DEPOSIT_TRANCHE'
                     ,p_product_code      => 'SMB_DEPOSIT_TRANCHE'
                     ,p_account_number    => l_account_number
                     ,p_balance_account   => l_balance_account
                     ,p_ob22_code         => l_ob22_code
                      ); 
            if l_account_number is null then          
               -- ����� ��� ������ �� � ������� ��� ����� ������ � ��������������
               -- ����� ������������� ���-������ - ������� � ������� � ��������
               -- ��� ���� �������� ����������� �������� kl.get_empty_attr_foropenacc
               -- � accreg.p_unreserve_acc
                p_explanation := kl.get_empty_attr_foropenacc(l_tranche_row.customer_id);
                if p_explanation is not null  then
                    p_can_create_flag := 'N';
                    p_explanation     := '��� �������� ������� � ������ �볺��� ��������� ��������� ����: '|| chr(10) ||p_explanation;
                    return;
                end if;
            end if;   
        end if;    
    end;    

    procedure can_run_new_tranche(
        p_process_id in number,
        p_can_run_flag out varchar2,
        p_explanation out varchar2)
    is
        l_last_user_id integer;
    begin
        p_can_run_flag := 'Y';
        
        select min(t.user_id) keep (dense_rank last order by t.id)
          into l_last_user_id
          from process_history t
         where t.process_id = p_process_id 
           and t.process_state_id = process_utl.GC_PROCESS_STATE_CREATE
           and nvl(t.comment_text, '.') = smb_deposit_utl.G_PROCESS_INFO_FRONT_OFFICE;

        if (l_last_user_id = to_number(sys_context('bars_global', 'user_id'))) then
            p_can_run_flag := 'N';
            p_explanation := '����������, ���� ��������� ��������� ����� �� ���� �� �������������';
        end if;
    end;

    procedure can_run_back_office_confirm(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2)
    is
        l_qty          number;
        l_activity_row activity%rowtype;
        l_user_id      number := to_number(sys_context('bars_global', 'user_id'));
    begin
        p_can_run_flag := 'Y';
        l_activity_row := process_utl.read_activity(p_activity_id);
        select count(t.user_id)
          into l_qty
          from process_history t
         where t.process_id = l_activity_row.process_id
           and t.process_state_id in (process_utl.GC_PROCESS_STATE_CREATE, process_utl.GC_PROCESS_STATE_RUN)
           and nvl(t.comment_text, '.') = smb_deposit_utl.G_PROCESS_INFO_FRONT_OFFICE
           and t.user_id = l_user_id;

        if l_qty <> 0 then
            p_can_run_flag := 'N';
            p_explanation := '�����������, �� �������� ������ � ��������� �������� �� ������ ���������� ���� �������� ���-������';
            raise_application_error(-20000, p_explanation);
        end if;
    end;

    -- �������� ����� �� ������������ ������ �� �������������� �������� �� ������ ������
    procedure run_reserve_accounts_in_ea(
        p_activity_id in integer)
    is
        l_activity_row activity%rowtype;
        l_process_row process%rowtype;
        l_xml xmltype;
        l_deposit_main_account varchar2(15 char);
        l_tranche_currency_id integer;
        l_tranche_kf varchar2(6 char);
        l_account_reserve_row accounts_rsrv%rowtype;
    begin
        l_activity_row := process_utl.read_activity(p_activity_id);
        l_process_row := process_utl.read_process(l_activity_row.process_id);
        l_xml := xmltype(l_process_row.process_data);

        l_deposit_main_account := l_xml.extract('SMBDepositTranche/DepositMainAccount/text()').GetStringVal();
        l_tranche_currency_id := to_number(l_xml.extract('SMBDepositTranche/TrancheCurrencyId/text()').GetStringVal());
        l_tranche_kf := l_xml.extract('SMBDepositTranche/TrancheMFO/text()').GetStringVal();

        l_account_reserve_row := read_account_reserve(l_deposit_main_account, l_tranche_currency_id, l_tranche_kf);

        -- �������� ��������������� ��������� ������� �� �������� �� ��
        if (l_account_reserve_row.rsrv_id is not null) then
            put_new_object_to_ea_queue('UACC', 'ACC;' || l_account_reserve_row.rsrv_id || ';RSRV', l_account_reserve_row.rnk, l_tranche_kf);
        end if;
    end;

    procedure run_new_tranche_contract(
        p_activity_id in integer)
    is
        l_tranche_row               smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_process_row               process%rowtype;
        l_main_account_row          accounts%rowtype;
        l_primary_acount_id         number;
        l_interest_account_id       number;
        l_interest_account_number   varchar2(20);
    begin
        -- ������������ ��� �����, ���� ����������
        l_process_row      := process_utl.read_process(process_utl.read_activity(p_activity_id => p_activity_id).process_id);  
        l_tranche_row      := smb_deposit_utl.get_tranche_from_xml(l_process_row.id);
        -- �������������� �� ��� ����, ���� �� �� ���������        
        l_main_account_row := account_utl.read_account(
                                            p_account_number => l_tranche_row.primary_account
                                           ,p_currency_id => l_tranche_row.currency_id
                                           ,p_mfo => bars_context.extract_mfo(l_tranche_row.branch)
                                           ,p_raise_ndf => false);

        logger.log_info(p_procedure_name => $$plsql_unit||'.run_new_tranche_contract account',
                                    p_log_message    => 'p_process_id     : ' || l_process_row.id || chr(10) ||
                                                        'PrimaryAccountId : ' || l_main_account_row.acc
                                   ,p_object_id      => l_process_row.object_id
                                    );
    
        -- ������� ����� �� ������� "������" � "��������"
        if l_main_account_row.acc is null then
            accreg.p_unreserve_acc
                                ( p_nls  => l_tranche_row.primary_account
                                , p_kv   => l_tranche_row.currency_id 
                                , p_acc  => l_primary_acount_id 
                                );
            l_main_account_row := account_utl.read_account(    
                                         p_account_id => l_primary_acount_id);

            logger.log_info(p_procedure_name => $$plsql_unit||'.run_new_tranche_contract account from reserv',
                                    p_log_message    => 'p_process_id     : ' || l_process_row.id || chr(10) ||
                                                        'PrimaryAccountId : ' || l_main_account_row.acc
                                   ,p_object_id      => l_process_row.object_id);

            -- ����'����� ���� �� ������������ ����� ����������� ������
            deal_utl.set_deal_account(p_deal_id => l_process_row.object_id 
                                     ,p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                     ,p_account_id => l_main_account_row.acc);
           -- + !!!!!! ��������� � �� ���������� �� �������� �����  ????
        end if;
        -- ������ �� ���� ��� ����� ����������� ���������
        l_interest_account_id := deal_utl.get_deal_account(
                                  p_deal_id           => l_process_row.object_id
                                 ,p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT');
        -- ��������� ���� ��� ����� ����������� ���������                         
        if l_interest_account_id is null then
            l_interest_account_id := open_interest_account(
                                            p_deal_id          => l_process_row.object_id             
                                           ,p_main_account_row => l_main_account_row);
            -- ��������� ��� ����� ����� � �������                               
            deal_utl.set_deal_account(p_deal_id => l_process_row.object_id 
                                     ,p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT'
                                     ,p_account_id => l_interest_account_id);
        end if;
        -- ��������� ���� ��� ����������� ��������� � ��������
        l_interest_account_number := account_utl.read_account(
                                            p_account_id => l_interest_account_id).nls;
        l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                            p_data        => l_process_row.process_data
                                           ,p_tag         => 'InterestAccount'
                                           ,p_value       => l_interest_account_number
                                           ,p_parent_node =>  smb_deposit_utl.PARENT_NODE_TRANCHE);
                                                   
        if l_tranche_row.primary_account is not null and
            deal_utl.get_deal_account(
                                  p_deal_id           => l_process_row.object_id
                                 ,p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT') is null then

            l_main_account_row := account_utl.read_account(
                                            p_account_number => l_tranche_row.primary_account
                                           ,p_currency_id => l_tranche_row.currency_id
                                           ,p_mfo => bars_context.extract_mfo(l_tranche_row.branch)
                                           ,p_raise_ndf => true);

            -- ��������� ��� ����� ����� � �������                               
            deal_utl.set_deal_account(p_deal_id => l_process_row.object_id 
                                     ,p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                     ,p_account_id => l_main_account_row.acc);
        end if;
        smb_deposit_utl.set_process_data (
                           p_process_id => l_process_row.id
                          ,p_data       => l_process_row.process_data
                          );
    end;

    procedure revert_new_tranche_contract(
        p_activity_id in integer)
    is
    begin
        null;
    end;

    procedure can_run_transfer_tranche_funds(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2)
    is
        l_tranche_row       smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_process_row       process%rowtype;
        l_account_rest_row  accounts%rowtype;
    begin
        p_can_run_flag := 'Y';
        l_process_row :=   process_utl.read_process(p_process_id => process_utl.read_activity(p_activity_id => p_activity_id).process_id);  
        
        l_tranche_row := smb_deposit_utl.get_tranche_from_xml(l_process_row.id);
        -- ���� �� ���������� ����
        if l_tranche_row.primary_account is null then
           p_can_run_flag := 'N'; 
           p_explanation  := '�� ������� ���������� �������';
           return; 
        end if;
        l_account_rest_row := account_utl.read_account(
                                      p_account_number => l_tranche_row.debit_account
                                     ,p_currency_id    => l_tranche_row.currency_id
                                     );
          -- ��������� ����� �� ����� ��� ��������
        if check_available(p_account_row => l_account_rest_row
                          ,p_amount    => l_tranche_row.Amount_Tranche) = 0 then
            p_can_run_flag := 'N';
            p_explanation  := smb_deposit_utl.ERR_NOT_ENOUGH_MONEY||l_tranche_row.debit_account||'}';
            -- ������ raise - ����� ������ �������� �� ����� FAILED
            raise_application_error(-20000, p_explanation);
        end if;
    end;

    procedure run_transfer_tranche_funds(
        p_activity_id in integer)
    is
        l_document_id      number;
        l_sender_amount    number;
        l_recipient_amount number;
        l_operation_type   varchar2(3);
        l_tranche_row      smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_tranche_type     varchar2(50);
        l_process_row      process%rowtype;
        l_recipient_row    accounts%rowtype;
        l_sender_row       accounts%rowtype;
        l_purpose          oper.nazn%type;
        l_deal_row         deal%rowtype;
    begin
        -- !!!! �������� process_data ���������� �������
        -- ��������� ��������� �������� ��� �������� ����� � �������� ��� ��������� � ����� ����� ������.
        -- ��������� ��������� �������� ��� ����������� ����� ������ �� ���������� �������. ���� �������� ������� ����������� (������ �� �����);
        
        l_process_row    := process_utl.read_process(process_utl.read_activity(p_activity_id => p_activity_id).process_id);
        l_tranche_type   := process_utl.get_proc_type_code(p_proc_type_id => l_process_row.process_type_id);
        if l_tranche_type = smb_deposit_utl.PROCESS_TRANCHE_CREATE then
            l_operation_type := 'DU0'; -- �������� ����� �� ���������� �������
        elsif l_tranche_type = smb_deposit_utl.PROCESS_REPLENISH_TRANCHE then
            l_operation_type := 'DU5'; -- ���������� �������� -- ��������� ������ ��� ��������� ����������� ����� ��� �������� ��������� �������
        end if;    
        l_tranche_row    := smb_deposit_utl.get_tranche_from_xml(l_process_row.id);
        l_recipient_row  := account_utl.read_account(
                                            p_account_number => l_tranche_row.primary_account
                                           ,p_currency_id => l_tranche_row.currency_id
                                           ,p_mfo => bars_context.extract_mfo(l_tranche_row.branch)
                                           ,p_raise_ndf => false);
                                           
        l_sender_row     := account_utl.read_account(
                                            p_account_number => l_tranche_row.debit_account
                                           ,p_currency_id => l_tranche_row.currency_id
                                           ,p_mfo => bars_context.extract_mfo(l_tranche_row.branch)
                                           ,p_raise_ndf => false);        
        
        l_sender_amount    := l_tranche_row.amount_tranche;
        l_recipient_amount := l_sender_amount;
        l_deal_row := deal_utl.read_deal(p_deal_id => l_process_row.object_id);
        -- ������������� ����� �� ������� ����� ����� ��� ��������� ������ � 272850211170616143646/2 �� 23 ������ 2018 �.
        l_purpose          := '������������� ����� �� ������� ����� ����� ��� ��������� ������ � '||     
                              l_deal_row.deal_number||
                              ' �� '||f_dat_lit(l_deal_row.start_date, substr(bars_msg.get_lang, 1, 1)); 
        -- ������� �����
        -- � ������� ��� �������� �� ���������� �������                      
 
        l_document_id := smb_calculation_deposit.money_transfer(
                              p_sender_row       => l_sender_row
                             ,p_recipient_row    => l_recipient_row
                             ,p_sender_amount    => l_sender_amount
                             ,p_recipient_amount => l_recipient_amount
                             ,p_operation_type   => l_operation_type
                             ,p_purpose          => l_purpose
                                            );
        -- ������� ���. ��������                                     
        smb_calculation_deposit.fill_operw (
              p_ref  => l_document_id
             ,p_tag  => 'ND'
             ,p_val  => to_char(l_process_row.object_id));

           -- ������� l_document_id � process_data
        l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                                    l_process_row.process_data
                                                                   ,'Ref_'
                                                                   ,l_document_id
                                                                   ,smb_deposit_utl.PARENT_NODE_TRANCHE);
        smb_deposit_utl.set_process_data (
                           p_process_id => l_process_row.id
                          ,p_data       => l_process_row.process_data
                          );
        -- ��������� �������� �������� � ��������� �� ����������� �������� 
        -- ����� �� ���� � �����
        register_utl.set_register_actual_value(
                          p_register_history_id => l_tranche_row.register_history_id
                         ,p_value_date          => l_tranche_row.start_date -- ����� ���� ���������� ���������� ��� ���� ������ (���� ���� ������)???
                         ,p_document_id         => l_document_id
                                             );   
        -- ������������� ������ �������� 
        object_utl.set_object_state(
                          p_object_id  => l_process_row.object_id 
                         ,p_state_code => 'ACTIVE'
                                    ); 
        smb_deposit_utl.set_parameter_deposit(p_object_id => l_process_row.object_id);
        -- + !!!!!! ��������� � �� ���������� �� �������� ������ ������ ������������
    end;

    procedure revert_transfer_tranche_funds(
        p_activity_id in integer)
    is
    begin
        null;
    end;

    procedure create_new_tranche_contract(p_activity_id  in number)
     is
    begin
        null;
    end;

    procedure create_transfer_tranche_funds(p_activity_id  in number)
     is
    begin
        null;
    end;

    procedure exec_failed_process(
            p_process_id  in number
           ,p_comment     in varchar2)
     is
        l_process_row       process%rowtype;
        l_proc_workflow_row process_workflow%rowtype;
    begin
        l_process_row := process_utl.read_process(p_process_id => p_process_id);     
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_FAILURE then
            raise_application_error(-20000, '������  {' || p_process_id || '} � ���� {'||
                                                list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                                       ,p_item_id   => l_process_row.state_id)||'}');            
        end if;
        -- ��� ������ ���� ������ ���� ������ � ������� FAILED    
        for l_activity_row in (select a.*
                                 from process p
                                     ,activity a
                                where p.id = p_process_id
                                  and a.process_id(+) = p.id
                                  and a.state_id(+) = process_utl.ACT_STATE_FAILED) loop
            if l_activity_row.id is null then
               -- ��������� ������� �������
               process_utl.process_run(p_process_id  => p_process_id);
            else
               -- ��������� ������� �������� 
               l_proc_workflow_row := process_utl.read_proc_flow(p_proc_flow_id  => l_activity_row.activity_type_id);
               process_utl.activity_run(p_activity_row       => l_activity_row
                                       ,p_activity_type_row  => l_proc_workflow_row);
            end if;
        end loop;            
    end; 

    procedure bo_confirm_replenish_tranche(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2)
    is
    begin
        can_run_back_office_confirm(
                 p_activity_id  => p_activity_id
                ,p_can_run_flag => p_can_run_flag
                ,p_explanation  => p_explanation);
    end;

    procedure can_create_replenish_tranche(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2)
     is
        l_tranche_row       smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_main_tranche_row  smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_process_row       process%rowtype;    
        l_object_row        object%rowtype;
        l_accounts_row      accounts%rowtype; 
    begin
        p_can_create_flag  := 'Y';
        l_tranche_row      := smb_deposit_utl.get_tranche_from_xml(p_data => p_process_data);
        l_main_tranche_row := smb_deposit_utl.read_base_tranche(p_object_id => l_tranche_row.object_id);
        l_process_row      := process_utl.read_process(
                                                      p_process_id => l_main_tranche_row.process_id
                                                     ,p_raise_ndf => true);

        if nvl(l_main_tranche_row.is_replenishment_tranche, 0) <> 1 then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ������ �� �����������.';
            return;
        end if;

        l_object_row       := object_utl.read_object(
                                               p_object_id => l_tranche_row.object_id
                                              ,p_raise_ndf => true);

        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'ACTIVE' then
            p_can_create_flag := 'N';
            p_explanation     := '��������� ���������� ����������. �����  {' || l_main_tranche_row.deal_number || 
                                 '} � ���� {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}';
            return;                                            
        end if;

        if l_tranche_row.action_date is null then
            p_can_create_flag := 'N';
            p_explanation     := '������ ���� ���������� ������';
            return;
        end if;

        if l_tranche_row.action_date < l_main_tranche_row.start_date then
            p_can_create_flag := 'N';
            p_explanation     := '���� ���������� ������ ����� �� ���� ������� 䳿 ������';
            return;
        end if;

        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_SUCCESS then
            p_can_create_flag := 'N';
            p_explanation     := '��������� ���������� ����������. �����  {' || l_process_row.object_id || 
                                 '} � ���� {'||
                                 list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                        ,p_item_id   => l_process_row.state_id)||'}';
            return;                                            
        end if;  
        if nvl(l_tranche_row.amount_tranche, 0) <= 0 then
            p_can_create_flag := 'N';
            p_explanation     := '������ ���� ���������� ������';
            return;
        end if;
        if l_tranche_row.primary_account is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ���������� �������';
            return;
        end if;

        if l_tranche_row.debit_account is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������� ��� �������� �����';
            return;
        end if;
        -- � ���� �� ����� ����
        -- ���� ��� �� ����� exception
        l_accounts_row := account_utl.read_account(
                                         p_account_number => l_tranche_row.debit_account
                                        ,p_currency_id    => l_tranche_row.currency_id
                                        ,p_raise_ndf      => true);
        -- ���� �����������
        if l_tranche_row.customer_id <> l_accounts_row.rnk then
            p_can_create_flag := 'N';
            p_explanation     := '������� ��� �������� �� �������� ������� �볺���';
            return;
        end if; 
    end can_create_replenish_tranche;

    procedure can_run_replenish_tranche(
        p_process_id   in number,
        p_can_run_flag out varchar2,
        p_explanation  out varchar2) 
     is 
    begin
        
        -- �������� ���������� ��� ��� ��������� ������
        can_run_new_tranche(
                  p_process_id   => p_process_id
                 ,p_can_run_flag => p_can_run_flag
                 ,p_explanation  => p_explanation);
    end can_run_replenish_tranche;    

    procedure create_replenish_tranche(
        p_process_id in number)
    is
        l_process_row   process%rowtype;
    begin
        l_process_row := process_utl.read_process(p_process_id);

        l_process_row.object_id := smb_deposit_utl.create_replenish_tranche(p_process_id => p_process_id);

        -- ����'����� ������ �� ��'����
        update process p
        set    p.object_id = l_process_row.object_id
        where  p.id = p_process_id;

    end create_replenish_tranche;
    
    procedure can_run_transfer_replenishment(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2)
    is
    begin
        -- �������� ��������� �������� ��� ��� ��������� ������
        can_run_transfer_tranche_funds(
                p_activity_id  => p_activity_id
               ,p_can_run_flag => p_can_run_flag
               ,p_explanation  => p_explanation);
    end;

    procedure run_transfer_replenishment(
        p_activity_id in integer)
     is
    begin
        -- ��������� ���� ��� ��� ��������� ������ (??)
        run_transfer_tranche_funds(
                      p_activity_id => p_activity_id);
    end;    

    procedure revert_transfer_replenishment(
        p_activity_id in integer)
    is
    begin
        null;
    end;

    procedure can_create_tranche_blocking(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2)
     is
        l_tranche_row       smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_main_tranche_row  smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_process_row       process%rowtype;    
        l_object_row        object%rowtype;
    begin
        p_can_create_flag  := 'Y';
        l_tranche_row      := smb_deposit_utl.get_tranche_from_xml(p_data => p_process_data);
        l_main_tranche_row := smb_deposit_utl.read_base_tranche(p_object_id => l_tranche_row.object_id);
        l_object_row := object_utl.read_object(p_object_id => l_tranche_row.object_id
                                              ,p_raise_ndf => true);
        l_process_row      := process_utl.read_process(
                                                      p_process_id => l_main_tranche_row.process_id
                                                     ,p_raise_ndf => true);
                                                     
        -- �������� ������� ������ ���� � ������� DONE                                             
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_SUCCESS then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ������ ����������. �����  {' || l_tranche_row.deal_number || 
                                 '} � ���� {'||
                                 list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                        ,p_item_id   => l_process_row.state_id)||'}';
            return;                                            
        end if;  
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'ACTIVE' then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ������ ����������. �����  {' || l_tranche_row.deal_number || 
                                 '} � ���� {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}';
            return;                                            
        end if;
        if l_tranche_row.action_date is null then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ������ ����������. �� ������� ���� ���������� ������';
            return;                                            
        end if;

        if l_tranche_row.action_date < l_tranche_row.start_date
            then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ������ ����������. ���� ���������� ����� �� ���� ������� 䳿 ������';
            return;                                            
        end if;

        if l_tranche_row.comment_ is null then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ������ ����������. �� ������� ������� ����������';
            return;                                            
        end if;
        if l_tranche_row.lock_tranche_id not in  (smb_deposit_utl.LOCK_ARREST_ID, smb_deposit_utl.LOCK_DPT_ON_CREDIT_ID) then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ������ ����������. �� ������� ��� ����������';
            return;                                            
        end if;

        -- !!! ���� ������� ��� ��������
        /*if l_tranche_row.transit_account is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ���������� �������';
            return;                                            
        end if;*/
    end;    
 
    procedure create_tranche_blocking(
        p_process_id in number)
    is
        l_tranche_row smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_process_row process%rowtype;
    begin
        l_process_row := process_utl.read_process(p_process_id);
        l_tranche_row := smb_deposit_utl.get_tranche_from_xml(
                                                 l_process_row.process_data); 
                                 
        -- ����'����� ������ �� ��'����
        update process p
        set    p.object_id = l_tranche_row.object_id
        where  p.id = p_process_id;

        l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                          p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ProcessId'
                                                         ,p_value       => to_char(p_process_id)
                                                         ,p_parent_node => smb_deposit_utl.PARENT_NODE_TRANCHE);
        smb_deposit_utl.set_process_data (
                           p_process_id => p_process_id
                          ,p_data       => l_process_row.process_data
                          );
       
        -- ��������� ������������� ��������� ��������
        process_utl.process_run(p_process_id  => p_process_id);
        -- ���������� �������
        smb_deposit_utl.set_process_info(
                               p_process_id => p_process_id
                              ,p_info       => l_tranche_row.comment_);
    end create_tranche_blocking;

    procedure run_tranche_blocking(
        p_activity_id in integer)
     is
        l_process_row        process%rowtype;
    begin
        l_process_row := process_utl.read_process(process_utl.read_activity(p_activity_id => p_activity_id).process_id);
        -- ������ �� �������                                                                        
        smb_calculation_deposit.blocking_deposit (
                                   p_id         => l_process_row.object_id
                                  ,p_process_id => l_process_row.id);
         -- ������ ������ ������� �� BLOCKED
         object_utl.set_object_state(
                              p_object_id  => l_process_row.object_id
                             ,p_state_code => 'BLOCKED'
                                        ); 
    end; 

    procedure can_create_tranche_unblocking(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2)
     is
        l_tranche_row       smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_object_row        object%rowtype;
    begin
        p_can_create_flag := 'Y';
        l_tranche_row      := smb_deposit_utl.get_tranche_from_xml(p_data => p_process_data);
        l_object_row := object_utl.read_object(p_object_id => l_tranche_row.object_id
                                              ,p_raise_ndf => true);
        -- ����� ������ ���� � ��������� BLOCKED                                             
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'BLOCKED' then
            p_can_create_flag := 'N';
            p_explanation     := '������������ ������ ����������. �����  {' || l_tranche_row.deal_number || 
                                 '} � ���� {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}';
            return;                                            
        end if;
        if l_tranche_row.action_date is null then
            p_can_create_flag := 'N';
            p_explanation     := '������������� ������ ����������. �� ������� ���� ������������� ������';
            return;                                            
        end if;
        if l_tranche_row.comment_ is null then
            p_can_create_flag := 'N';
            p_explanation     := '������������� ������ ����������. �� ������� ������� �������������';
            return;                                            
        end if;
    end; 

    procedure create_tranche_unblocking(
        p_process_id in number)
    is
        l_tranche_row smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_process_row process%rowtype;
    begin
        l_process_row := process_utl.read_process(p_process_id);
        l_tranche_row := smb_deposit_utl.get_tranche_from_xml(
                                                 l_process_row.process_data); 
                                 
        -- ����'����� ������ �� ����� ���������� ��'����
        update process p
        set    p.object_id = l_tranche_row.object_id
        where  p.id = p_process_id;

        l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                          p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ProcessId'
                                                         ,p_value       => to_char(p_process_id)
                                                         ,p_parent_node => smb_deposit_utl.PARENT_NODE_TRANCHE);
        smb_deposit_utl.set_process_data (
                           p_process_id => p_process_id
                          ,p_data       => l_process_row.process_data
                          );
        -- ��������� ������������� ��������� ��������
        process_utl.process_run(p_process_id  => p_process_id);
        -- ���������� �������
        smb_deposit_utl.set_process_info(
                               p_process_id => p_process_id
                              ,p_info       => l_tranche_row.comment_);
    end create_tranche_unblocking;

    procedure run_tranche_unblocking(
        p_activity_id in integer)
     is
        l_process_row  process%rowtype;
        l_expiry_date  date;
    begin
        l_process_row := process_utl.read_process(
                                 p_process_id => process_utl.read_activity(p_activity_id => p_activity_id).process_id);

        smb_calculation_deposit.unblocking_deposit (
                                   p_id         => l_process_row.object_id
                                  ,p_process_id => l_process_row.id);

    end;    
    
    procedure can_create_return_tranche(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2)
     is
        l_tranche_row         smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_object_row          object%rowtype;
        l_register_value_row  register_value%rowtype;
        l_account_row         accounts%rowtype;
    begin
        p_can_create_flag := 'Y';
        l_tranche_row := smb_deposit_utl.get_tranche_from_xml(p_data => p_process_data);

        if l_tranche_row.action_date is null then
            p_can_create_flag := 'N';
            p_explanation     := '������ ���� ���������� ������.';
            raise_application_error(-20000, p_explanation);
        end if;
        
        if not l_tranche_row.action_date between l_tranche_row.start_date and l_tranche_row.expiry_date then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ���������� ������ ����������. ���� �������� '|| to_char(l_tranche_row.action_date, '"{"dd.mm.yyyy"}" ')||
                                  '�� ������� � ������� ' ||
                                  to_char(l_tranche_row.start_date, '"{"dd.mm.yyyy"}" - ') || 
                                  to_char(l_tranche_row.expiry_date, '"{"dd.mm.yyyy"}"');
            raise_application_error(-20000, p_explanation);
        end if;
       
        l_object_row := object_utl.read_object(p_object_id => l_tranche_row.object_id
                                              ,p_raise_ndf => true);        
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'ACTIVE' then
            p_can_create_flag := 'N';
            p_explanation     := '���������� ���������� ������ ����������. �����  {' || l_tranche_row.deal_number || 
                                 '} � ���� {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}';
            raise_application_error(-20000, p_explanation);
        end if;
        -- �������� �� ���������� ����� ����� ������ �� ����������� �����
        l_account_row := account_utl.read_account(l_tranche_row.primary_account
                                                 ,l_tranche_row.currency_id
                                                 ,bars_context.extract_mfo(l_tranche_row.branch)
                                                 ,p_raise_ndf => false);
        
        l_register_value_row := register_utl.read_register_value(
                                                       p_object_id        => l_tranche_row.object_id
                                                      ,p_register_code    => register_utl.SMB_PRINCIPAL_AMOUNT_CODE
                                                      ,p_raise_ndf        => true);
        -- ����� �� ��� �������� (???) 
        -- ���� �����
        /*
        if nvl(l_register_value_row.actual_value, 0) = 0 then 
            p_can_create_flag := 'N';
            p_explanation     := '���� ������ ������� ����.';
            raise_application_error(-20000, p_explanation);
        end if;
        */
        if check_available(p_account_row => l_account_row 
                          ,p_amount      => l_register_value_row.actual_value) = 0 then
            p_can_create_flag := 'N';
            p_explanation     := '�� ��������� ����� �� ����������� �������';
            raise_application_error(-20000, p_explanation);
        end if;

        if l_tranche_row.return_account is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������� ��� ���������� �����';
            raise_application_error(-20000, p_explanation);
        end if;
        -- � ���� �� ����� ����
        tools.hide_hint( 
                account_utl.read_account(l_tranche_row.return_account
                                        ,l_tranche_row.currency_id
                                        ,p_raise_ndf => true).acc );
    end;    

    procedure can_run_return_tranche(
        p_process_id in number,
        p_can_run_flag out varchar2,
        p_explanation out varchar2)
     is
    begin
        -- �������� �� ������������ �������� ��� ��� �������� ������
        can_run_new_tranche(
               p_process_id   => p_process_id 
              ,p_can_run_flag => p_can_run_flag
              ,p_explanation  => p_explanation);
    end;    
-- 
    procedure create_return_tranche(
        p_process_id in number)
     is
        l_tranche_row smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_process_row process%rowtype;
    begin
        l_process_row := process_utl.read_process(p_process_id);
        l_tranche_row := smb_deposit_utl.get_tranche_from_xml(
                                                 l_process_row.process_data); 
                                 
        -- ����'����� ������ �� ����� ���������� ��'����
        update process p
        set    p.object_id = l_tranche_row.object_id
        where  p.id = p_process_id;

        l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                          p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ProcessId'
                                                         ,p_value       => to_char(p_process_id)
                                                         ,p_parent_node => smb_deposit_utl.PARENT_NODE_TRANCHE);
        smb_deposit_utl.set_process_data (
                           p_process_id => p_process_id
                          ,p_data       => l_process_row.process_data
                          );
    end;    

    procedure can_run_bo_confirm_ret_tranche(
        p_activity_id  in integer,
        p_can_run_flag out char,
        p_explanation  out varchar2)
     is
    begin
        can_run_back_office_confirm(
                p_activity_id  => p_activity_id
               ,p_can_run_flag => p_can_run_flag
               ,p_explanation  => p_explanation);
    end;    

    procedure can_run_return_transfer_funds(
        p_activity_id  in integer,
        p_can_run_flag out char,
        p_explanation  out varchar2)
     is
        l_tranche_row         smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_object_row          object%rowtype;
        l_register_value_row  register_value%rowtype;
        l_account_row         accounts%rowtype;
    begin
        p_can_run_flag := 'Y';
        l_tranche_row := smb_deposit_utl.get_tranche_from_xml(
                                                 process_utl.read_activity(p_activity_id => p_activity_id).process_id);
        l_object_row := object_utl.read_object(p_object_id => l_tranche_row.object_id
                                              ,p_raise_ndf => true);        
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'ACTIVE' then
            p_can_run_flag := 'N';
            p_explanation     := '���������� ���������� ������ ����������. �����  {' || l_tranche_row.deal_number || 
                                 '} � ���� {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}';
            return;                                            
        end if;
        -- �������� �� ���������� ����� ����� ������ �� ����������� �����
        l_account_row := account_utl.read_account(l_tranche_row.primary_account
                                                 ,l_tranche_row.currency_id
                                                 ,bars_context.extract_mfo(l_tranche_row.branch)
                                                 ,p_raise_ndf => false);
        
        l_register_value_row := register_utl.read_register_value(
                                                       p_object_id        => l_tranche_row.object_id
                                                      ,p_register_code    => register_utl.SMB_PRINCIPAL_AMOUNT_CODE
                                                      ,p_raise_ndf        => true);

        if check_available(p_account_row => l_account_row 
                            ,p_amount    => l_register_value_row.actual_value) = 0 then
            p_can_run_flag := 'N';
            p_explanation     := '�� ��������� ����� �� ����������� �������';
            -- ������ raise - ����� ������ �������� �� ����� FAILED
            raise_application_error(-20000, p_explanation);
        end if;
    end;    

    procedure run_return_transfer_funds(
        p_activity_id in integer)
    is
        l_process_row         process%rowtype;
        l_tranche_row       smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_main_tranche_row  smb_deposit_utl.c_tranche_from_xml%rowtype;
    begin
        -- ��������� ��������� �������� ��� �������� ����� � ������������ ������� �� �������� ��� ����������� � ������� ����� ����� ������.
        l_process_row    := process_utl.read_process(process_utl.read_activity(p_activity_id => p_activity_id).process_id);
        -- ��������� ����� ��� �������� 
        -- ��������� �������� ������ � �������� �������� ������
        l_tranche_row      := smb_deposit_utl.get_tranche_from_xml(p_data   => l_process_row.process_data);
        l_main_tranche_row := smb_deposit_utl.read_base_tranche(p_object_id => l_process_row.object_id);
        -- �������� � �������� �������� ����
        if l_tranche_row.return_account <> l_main_tranche_row.return_account then
           -- ���������� �������� �������
            l_process_row    := process_utl.read_process(p_process_id => l_main_tranche_row.process_id);
            l_process_row.process_data := smb_deposit_utl.update_value_in_xml(p_data        => l_process_row.process_data
                                               ,p_tag         => 'ReturnAccount'
                                               ,p_value       => l_tranche_row.return_account
                                               ,p_parent_node => smb_deposit_utl.PARENT_NODE_TRANCHE);
            smb_deposit_utl.set_process_data (
                       p_process_id => l_process_row.id
                      ,p_data       => l_process_row.process_data);
        end if;
        -- ������� �� ���� �����
        smb_calculation_deposit.manual_deposit_closing(
                                p_id  => l_process_row.object_id);
    end;    

    --- ON DEMAND
    -- ��� - ������� �� ����������
    -- DoD - deposit on demand
    -- �������� �� ����������� �������� ���
    procedure can_create_new_on_demand(
                 p_process_data     in clob
                ,p_process_type_id  in number
                ,p_can_create_flag  out varchar2
                ,p_explanation      out varchar2)
     is
        l_on_demand_row        smb_deposit_utl.c_on_demand_from_xml%rowtype;
        l_account_number       varchar2(15);
        l_balance_account      varchar2(4 char);
        l_ob22_code            varchar2(2 char);
        l_object_type_id       number;
        l_deal_on_demand       number;
        l_calculation_type_id  number;
        l_calculation_name     varchar2(200);
        l_deal_row             deal%rowtype;
        l_accounts_row         accounts%rowtype;
    begin
        p_can_create_flag := 'Y';
        l_on_demand_row   := smb_deposit_utl.get_on_demand_from_xml(p_data => p_process_data);

        -- � ������� ����� ���� ������ ���� ����������� ��� � ������������ ������
        -- �������� �� ������������� ��� �� ������� ������� � ������

        if l_on_demand_row.customer_id is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� �볺���';
            return;
        end if;
        if l_on_demand_row.currency_id is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������';
            return;
        end if;

        l_object_type_id := object_utl.read_object_type(p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE).id;

        select max(o.id)
          into l_deal_on_demand
          from object o
              ,deal d
              ,process p
              ,process_type pt 
              ,xmltable ('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                     Currency_Id                   number         path 'CurrencyId') t
         where o.object_type_id = l_object_type_id
           and d.id = o.id
           and o.id = p.object_id
           and o.state_id not in 
                     (select s.id
                        from   object_state s
                        join   (select t.*
                                from   object_type t
                                connect by t.id = prior t.parent_type_id
                                start with t.id = l_object_type_id
                                ) y on y.id = s.object_type_id
                        where s.state_code in ('CLOSED', 'DELETED')
                           and s.is_active = 'Y')
           and d.customer_id = l_on_demand_row.customer_id
           and t.currency_id = l_on_demand_row.currency_id
           and p.process_type_id = pt.id
           and pt.module_code = smb_deposit_utl.PROCESS_TRANCHE_MODULE
           and pt.process_code = smb_deposit_utl.PROCESS_ON_DEMAND_CREATE
           -- �������� 
           and l_on_demand_row.process_id is null
               ;   
        -- � ������� ��� ���� ���   
        if l_deal_on_demand is not null then
            l_deal_row :=  deal_utl.read_deal(p_deal_id => l_deal_on_demand);
            p_can_create_flag := 'N';
            p_explanation     := '�볺�� ��� �� ����� �� ������ {'|| l_deal_row.deal_number ||'}';
            return;
        end if;   
        if nvl(l_on_demand_row.Calculation_Type, 0) not in (1, 2) then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ����� ����������� %';
            return;
        end if;
        
        if l_on_demand_row.start_date is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ���� �������';
            return;
        end if;

        -- �������� ����������� ��������� ������ ��� �������
        select min(c.calculation_type_id) keep (dense_rank first order by o.valid_from desc) 
          into l_calculation_type_id
          from deal_interest_rate_kind k
              ,deal_interest_option o 
              ,deposit_on_demand_calc_type c
         where k.kind_code = smb_deposit_utl.ON_DEMAND_CALC_TYPE_KIND_CODE
           and o.rate_kind_id = k.id
           and o.id = c.interest_option_id
           and o.is_active = 1
           and o.valid_from <= l_on_demand_row.start_date;

        if l_calculation_type_id is not null and 
           l_calculation_type_id <> 0 and 
           l_calculation_type_id <> l_on_demand_row.Calculation_Type then
            p_can_create_flag := 'N';
            select max(x.item_name)                  
              into l_calculation_name
              from table(smb_deposit_ui.get_calculation_type_list()) x
             where x.item_id = l_calculation_type_id;
            p_explanation     := '����� ����������� ������� ���� {'||l_calculation_name ||'}';
            return;
        end if;

        if l_on_demand_row.return_account is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������� ��� ���������� �����';
            return;
        end if;
        -- � ���� �� ����� ����
        l_accounts_row := account_utl.read_account(
                                         p_account_number => l_on_demand_row.return_account
                                        ,p_currency_id    => l_on_demand_row.currency_id
                                        ,p_raise_ndf      => true);
        -- ���� �����������
        if l_on_demand_row.customer_id <> l_accounts_row.rnk then
            p_can_create_flag := 'N';
            p_explanation     := '������� ��� ���������� ����� �� �������� ������� �볺���';
            return;
        end if; 

        -- ������ �������������� ���������, ���� ����
        --   �� �������������� ������������� "�� ����" �� ����� �� �����
        if l_on_demand_row.is_individual_rate = 1 
           and nvl(l_on_demand_row.individual_interest_rate, 0) = 0 then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ��������� ������';
            return;
        end if;

        if l_on_demand_row.is_individual_rate = 1 and trim(l_on_demand_row.comment_) is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������� ������������ ������������ ������';
            return;
        end if;
        -- ��������� �� �������������
        if nvl(l_on_demand_row.frequency_payment, 0) not in (1) then
            p_can_create_flag := 'N';
            p_explanation     := '������ ����������� ������� �������';
            return;
        end if;
       
        -- ��� ����� ��������� ��� �������� ����� �� �������
        -- �.�. ���� ����� ��� ��� �� � �������
        if l_on_demand_row.primary_account is null then
            -- ��������� ���� �� �������� ����
            check_main_account(
                      p_object_id         => null
                     ,p_customer_id       => l_on_demand_row.customer_id
                     ,p_currency_id       => l_on_demand_row.currency_id
                     ,p_branch_code       => l_on_demand_row.branch
                     ,p_product_type_code => 'SMB_DEPOSIT_ON_DEMAND'
                     ,p_product_code      => 'SMB_DEPOSIT_ON_DEMAND'
                     ,p_account_number    => l_account_number
                     ,p_balance_account   => l_balance_account
                     ,p_ob22_code         => l_ob22_code
                     ,p_is_tranche        => 0
                      ); 

            if l_account_number is null then          
               -- ����� ��� ������ �� � ������� ��� ����� ������ � ��������������
               -- ����� ������������� ���-������ - ������� � ������� � ��������
               -- ��� ���� �������� ����������� �������� kl.get_empty_attr_foropenacc
               -- � accreg.p_unreserve_acc
                p_explanation := kl.get_empty_attr_foropenacc(l_on_demand_row.customer_id);
                if p_explanation is not null  then
                    p_can_create_flag := 'N';
                    p_explanation     := '��� �������� ������� � ������ �볺��� ��������� ��������� ����: '|| chr(10) ||p_explanation;
                    return;
                end if;
            end if;   
        end if;  
    end; 

    -- �������� �� ����������� ���������� �������� ��� ���
    procedure can_run_new_on_demand(
                 p_process_id in number
                ,p_can_run_flag out varchar2
                ,p_explanation out varchar2)
    is
    begin
        can_run_new_tranche(
                    p_process_id   => p_process_id
                   ,p_can_run_flag => p_can_run_flag
                   ,p_explanation  => p_explanation);
    end; 

    -- �������� �������� ��� ���
    procedure create_new_on_demand(p_process_id in number)
    is
        l_process_row                   process%rowtype;
        l_on_demand_row                 smb_deposit_utl.c_on_demand_from_xml%rowtype;
        l_main_account_row              accounts%rowtype;
        l_interest_account_row          accounts%rowtype;
        l_deal_group_id                 integer;
        l_object_id                     number;
    begin
        l_object_id      := smb_deposit_utl.create_deposit_on_demand(p_process_id => p_process_id);
        l_process_row    := process_utl.read_process(p_process_id);
        l_on_demand_row  := smb_deposit_utl.get_on_demand_from_xml(l_process_row.process_data);
        l_process_row.object_id := l_object_id;
        -- ������� ���������� ���������� ������� �� ��������� ����
        -- ������� : ����� ����� ������� �� ������ ��������������� ���������� 2610 (��� ��������� �������) � 2600 (��� ������ �� ������) 
        --           �� ��� �������� ���-���������, ��� � ��� ��������� ���. �����, ���������� �������� �������� ������ ��������������� ������� 
        --           2651 (������� ������) �� 2650 (������ �� ������). �� ������� ��� ���������� �������� �������� �� ���� �볺���, ��� ���� ������
        --           ����������� �������� ����? ���� �� �������, �� �� ������� ���������� ��������� �������� �������� ���� ����� �볺����?
        -- 
        --           ����� ������� ��������, �� ���� ����������� ������������ �볺��� �� ���� �������.
        -- 
        -- ³������ : ���������� �������� �������� ������� �� ���� �볺���, ���� ������ ����������� �������� ����,
        --             - �������� ��������� ��������� ������� 2650
        
        l_deal_group_id := smb_deposit_utl.get_customer_group (
                                                       p_customer_id => l_on_demand_row.customer_id
                                                      ,p_is_tranche  => 0);

        if (l_deal_group_id is not null) then
            attribute_utl.set_value(l_process_row.object_id, 'DEAL_BALANCE_GROUP', l_deal_group_id);
        end if;

        -- ����'����� ������ �� ����� ���������� ��'����
        update process p
        set    p.object_id = l_process_row.object_id
        where  p.id = p_process_id;

        if (l_on_demand_row.primary_account is null) then
            -- ��� ������� ����������� ������ - ������/��������� �������� ������� ��� ���������� ���������� �������
            l_on_demand_row.primary_account := find_or_create_main_account(
                                                    p_object_id         => l_process_row.object_id,
                                                    p_customer_id       => l_on_demand_row.customer_id,
                                                    p_currency_id       => l_on_demand_row.currency_id,
                                                    p_branch_code       => l_on_demand_row.branch,
                                                    p_product_type_code => 'SMB_DEPOSIT_ON_DEMAND',
                                                    p_product_code      => 'SMB_DEPOSIT_ON_DEMAND',
                                                    p_is_tranche        => 0
                                                    );
        end if;

        -- ������ �������� ������� ����� �������� (�� ��������������)
        l_main_account_row := account_utl.read_account(l_on_demand_row.primary_account,
                                                       l_on_demand_row.currency_id,
                                                       bars_context.extract_mfo(l_on_demand_row.branch),
                                                       p_raise_ndf => false);

        logger.log_info(p_procedure_name => $$plsql_unit||'.create_new_on_demand',
                                    p_log_message    => 'p_process_id     : ' || p_process_id || chr(10) ||
                                                        'PrimaryAccountId : ' || l_main_account_row.acc
                                   ,p_object_id      => l_process_row.object_id);
        if (l_main_account_row.acc is not null) then
            l_interest_account_row.acc := open_interest_account(l_process_row.object_id, l_main_account_row);
            logger.log_info(p_procedure_name => $$plsql_unit||'.create_new_on_demand add into deal_account',
                                        p_log_message    => 'p_process_id     : ' || p_process_id || chr(10) ||
                                                            'PrimaryAccountId : ' || l_main_account_row.acc
                                       ,p_object_id      => l_process_row.object_id);
            -- ���� ������� ��� ��������, ����'����� ���� �� ������������ ����� ����������� ������
            deal_utl.set_deal_account(l_process_row.object_id, 'DEPOSIT_PRIMARY_ACCOUNT', l_main_account_row.acc);
            deal_utl.set_deal_account(l_process_row.object_id, 'DEPOSIT_INTEREST_ACCOUNT', l_interest_account_row.acc);
        end if;
        
        -- ��� ��� �������� ���� ����� ���� ������ ��������������, �� ������ � process -> process_data � ���� �����
        if l_on_demand_row.primary_account is not null then
            -- ������ ���� � process_data
            -- ���������� ����
            l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                                    l_process_row.process_data
                                                                   ,'PrimaryAccount'
                                                                   ,l_on_demand_row.primary_account
                                                                   ,smb_deposit_utl.PARENT_NODE_ON_DEMAND);
            -- ���� ���������� ���������                                                        
            if l_interest_account_row.acc is not null then
               -- � ��� ���� ������ id ����� (acc), ����� nls  
                l_interest_account_row := account_utl.read_account(p_account_id => l_interest_account_row.acc 
                                                                  ,p_lock       => false
                                                                  ,p_raise_ndf  => true);
            
                l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                            l_process_row.process_data
                                                           ,'InterestAccount'
                                                           ,l_interest_account_row.nls
                                                           ,smb_deposit_utl.PARENT_NODE_ON_DEMAND);
            end if;     
        end if; 
        smb_deposit_utl.set_process_data (
                           p_process_id => p_process_id
                          ,p_data       => l_process_row.process_data
                          );

    end; 

    -- ��� ������������� ���-������
    procedure can_run_bo_confirm_on_demand(
                  p_activity_id in integer
                 ,p_can_run_flag out char
                 ,p_explanation out varchar2)
    is
    begin
        can_run_back_office_confirm(
                 p_activity_id  => p_activity_id
                ,p_can_run_flag => p_can_run_flag
                ,p_explanation  => p_explanation);
    end; 

    -- �������� ������ ��� ��� 
    procedure run_new_on_demand_contract(
                  p_activity_id in integer)
    is
        l_on_demand_row             smb_deposit_utl.c_on_demand_from_xml%rowtype;
        l_process_row               process%rowtype;
        l_main_account_row          accounts%rowtype;
        l_primary_acount_id         number;
        l_interest_account_id       number;
        l_interest_account_number   varchar2(20);
    begin
        -- ������������ ��� �����, ���� ����������
        l_process_row      := process_utl.read_process(process_utl.read_activity(p_activity_id => p_activity_id).process_id);  
        l_on_demand_row    := smb_deposit_utl.get_on_demand_from_xml(p_process_id => l_process_row.id);
        -- �������������� �� ��� ����, ���� �� �� ���������        
        l_main_account_row := account_utl.read_account(
                                            p_account_number => l_on_demand_row.primary_account
                                           ,p_currency_id => l_on_demand_row.currency_id
                                           ,p_mfo => bars_context.extract_mfo(l_on_demand_row.branch)
                                           ,p_raise_ndf => false);
        logger.log_info(p_procedure_name => $$plsql_unit||'.run_new_on_demand_contract',
                                    p_log_message    => 'p_process_id     : ' || l_process_row.id || chr(10) ||
                                                        'PrimaryAccountId : ' || l_main_account_row.acc
                                   ,p_object_id      => l_process_row.object_id);
                                           
        -- ������� ����� �� ������� "������" � "��������"
        if l_main_account_row.acc is null then
            accreg.p_unreserve_acc
                                ( p_nls  => l_on_demand_row.primary_account
                                , p_kv   => l_on_demand_row.currency_id 
                                , p_acc  => l_primary_acount_id 
                                );
            l_main_account_row := account_utl.read_account(    
                                         p_account_id => l_primary_acount_id);
            logger.log_info(p_procedure_name => $$plsql_unit||'.run_new_on_demand_contract from reserv',
                                        p_log_message    => 'p_process_id     : ' || l_process_row.id || chr(10) ||
                                                            'PrimaryAccountId : ' || l_main_account_row.acc
                                       ,p_object_id      => l_process_row.object_id);

            -- ����'����� ���� �� ������������ ����� ����������� ������
            deal_utl.set_deal_account(p_deal_id => l_process_row.object_id 
                                     ,p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                     ,p_account_id => l_main_account_row.acc);
           -- + !!!!!! ��������� � �� ���������� �� �������� �����  ????
        end if;
        -- ������ �� ���� ��� ����� ����������� ���������
        l_interest_account_id := deal_utl.get_deal_account(
                                  p_deal_id           => l_process_row.object_id
                                 ,p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT');
        -- ��������� ���� ��� ����� ����������� ���������                         
        if l_interest_account_id is null then
            l_interest_account_id := open_interest_account(
                                            p_deal_id          => l_process_row.object_id
                                           ,p_main_account_row => l_main_account_row);
            -- ��������� ��� ����� ����� � �������                               
            deal_utl.set_deal_account(p_deal_id => l_process_row.object_id 
                                     ,p_account_type_code => 'DEPOSIT_INTEREST_ACCOUNT'
                                     ,p_account_id => l_interest_account_id);
        end if;
        -- ��������� ���� ��� ����������� ��������� � ��������
        l_interest_account_number := account_utl.read_account(
                                            p_account_id => l_interest_account_id).nls;
        l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                            p_data        => l_process_row.process_data
                                           ,p_tag         => 'InterestAccount'
                                           ,p_value       => l_interest_account_number
                                           ,p_parent_node => smb_deposit_utl.PARENT_NODE_ON_DEMAND);
        if l_on_demand_row.primary_account is not null and
            deal_utl.get_deal_account(
                                  p_deal_id           => l_process_row.object_id
                                 ,p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT') is null then

            l_main_account_row := account_utl.read_account(
                                            p_account_number => l_on_demand_row.primary_account
                                           ,p_currency_id => l_on_demand_row.currency_id
                                           ,p_mfo => bars_context.extract_mfo(l_on_demand_row.branch)
                                           ,p_raise_ndf => true);

            -- ��������� ��� ����� ����� � �������                               
            deal_utl.set_deal_account(p_deal_id => l_process_row.object_id 
                                     ,p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                     ,p_account_id => l_main_account_row.acc);
        end if;
        smb_deposit_utl.set_process_data (
                           p_process_id => l_process_row.id
                          ,p_data       => l_process_row.process_data
                          );
    end;

    -- ����� ����������� ��� ��� 
    procedure revert_new_on_demand_contract(
                   p_activity_id in integer)
    is
    begin
        null;
    end;

    -- �������� ������� ����� �� ����� ��� ��������
    procedure can_run_transfer_on_demand(
                   p_activity_id in integer
                  ,p_can_run_flag out char
                  ,p_explanation out varchar2)
    is
        l_on_demand_row       smb_deposit_utl.c_on_demand_from_xml%rowtype;
        l_process_row       process%rowtype;
    begin
        p_can_run_flag := 'Y';
        l_process_row :=   process_utl.read_process(p_process_id => process_utl.read_activity(p_activity_id => p_activity_id).process_id);  

        l_on_demand_row := smb_deposit_utl.get_on_demand_from_xml(p_process_id => l_process_row.id);
        -- ���� �� ���������� ����
        if l_on_demand_row.primary_account is null then
           p_can_run_flag := 'N'; 
           p_explanation  := '�� ������� ���������� �������';
           return; 
        end if;
        -- ����� �� ���������, ������ ��� ��������� ����
    end;
    
    -- ������� �����
    -- ��������� ��������� ��� � ACTIVE
    procedure run_transfer_on_demand(
                   p_activity_id in integer)
    is
        l_process_row      process%rowtype;
    begin
        l_process_row    := process_utl.read_process(process_utl.read_activity(p_activity_id => p_activity_id).process_id);
        -- ������������� ������ �������� � �������
        object_utl.set_object_state(
                          p_object_id  => l_process_row.object_id 
                         ,p_state_code => 'ACTIVE'
                                    ); 
        -- ������ �� ���������, ������ ��� ��������� ����, ����� ������������ ���������
        -- ������� ���������                        
        smb_deposit_utl.set_parameter_deposit(p_object_id => l_process_row.object_id);
    end;

    -- ����� �������� �����        
    procedure revert_transfer_on_demand(
                    p_activity_id in integer)
    is
    begin
        null;
    end; 

    ---CLOSE_ON DEMAND
   -- �������� �� ����������� �������� ���
    procedure can_create_close_on_demand(
         p_process_data     in clob
        ,p_process_type_id  in number
        ,p_can_create_flag  out varchar2
        ,p_explanation      out varchar2)
     is
        l_on_demand_row         smb_deposit_utl.c_on_demand_from_xml%rowtype;
        l_object_row          object%rowtype;
        l_account_row         accounts%rowtype;
    begin
        p_can_create_flag := 'Y';
        l_on_demand_row := smb_deposit_utl.get_on_demand_from_xml(p_data => p_process_data);

        l_object_row := object_utl.read_object(p_object_id => l_on_demand_row.object_id
                                              ,p_raise_ndf => true);        

        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'ACTIVE' then
            p_can_create_flag := 'N';
            p_explanation     := '�������� ������ �� ������ ����������. �����  {' || l_on_demand_row.deal_number || 
                                 '} � ���� {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}';
            raise_application_error(-20000, p_explanation);
        end if;
        -- �������� �� ����������� ����� ����� ������ �� ����������� �����
        l_account_row := account_utl.read_account(l_on_demand_row.primary_account
                                                 ,l_on_demand_row.currency_id
                                                 ,bars_context.extract_mfo(l_on_demand_row.branch)
                                                 ,p_raise_ndf => false);
        
        if l_on_demand_row.return_account is null then
            p_can_create_flag := 'N';
            p_explanation     := '�� ������� ������� ��� ���������� �����';
            raise_application_error(-20000, p_explanation);
        end if;
        -- � ���� �� ����� ����
        tools.hide_hint( 
                account_utl.read_account(l_on_demand_row.return_account
                                        ,l_on_demand_row.currency_id
                                        ,p_raise_ndf => true).acc );
    end;    

    -- �������� �� ����������� ���������� �������� ��� �������� ���
    procedure can_run_close_on_demand(
        p_process_id in number,
        p_can_run_flag out varchar2,
        p_explanation out varchar2)
     is
    begin
         -- ����������� �� �����������
         -- ��������� ����������, ��� ��� �������� ���
         can_run_new_on_demand(
                 p_process_id   => p_process_id  
                ,p_can_run_flag => p_can_run_flag
                ,p_explanation  => p_explanation);
    end; 

    -- �������� �������� ��� �������� ���
    procedure create_close_on_demand(p_process_id in number)
     is
        l_on_demand_row smb_deposit_utl.c_on_demand_from_xml%rowtype;
        l_process_row process%rowtype;
    begin
        l_process_row := process_utl.read_process(p_process_id);
        l_on_demand_row := smb_deposit_utl.get_on_demand_from_xml(
                                                 l_process_row.process_data); 
                                 
        -- ����'����� ������ �� ����� ���������� ��'����
        update process p
        set    p.object_id = l_on_demand_row.object_id
        where  p.id = p_process_id;

        l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                          p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ProcessId'
                                                         ,p_value       => to_char(p_process_id)
                                                         ,p_parent_node => smb_deposit_utl.PARENT_NODE_ON_DEMAND);
       smb_deposit_utl.set_process_data (
                           p_process_id => p_process_id
                          ,p_data       => l_process_row.process_data
                          );
    end;    

    -- ��� ������������� ���-������
    procedure can_bo_confirm_close_on_demand(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2)
     is
    begin
        -- �������� �������� ���������� ��� ��� �������� ���
        can_run_bo_confirm_on_demand(
                  p_activity_id  => p_activity_id
                 ,p_can_run_flag => p_can_run_flag
                 ,p_explanation  => p_explanation);
    end; 

    -- �������� ������� ����� �� ����� ���������� �����
    procedure can_run_action_close_on_demand(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2)
     is
    begin
        -- ������ �� ������ �������� ���� ������������ � can_create_close_on_demand
        p_can_run_flag := 'Y';
        null;
    end; 

    -- ������� �����
    -- ��������� ��������� ��� � CLOSED
    procedure run_action_close_on_demand(
            p_activity_id in integer)
    is
        l_process_row        process%rowtype;
        l_on_demand_row      smb_deposit_utl.c_on_demand_from_xml%rowtype;
        l_main_on_demand_row smb_deposit_utl.c_on_demand_from_xml%rowtype;

    begin
        -- ��������� ��������� �������� ��� �������� ����� � ������������ ������� �� �������� ��� ����������� � ������� ����� ����� ������.
        l_process_row    := process_utl.read_process(process_utl.read_activity(p_activity_id => p_activity_id).process_id);
        -- ��������� ����� ��� �������� 
        -- ��������� �������� ��� � �������� �������� ���
        l_on_demand_row      := smb_deposit_utl.get_on_demand_from_xml(p_data   => l_process_row.process_data);
        l_main_on_demand_row := smb_deposit_utl.read_base_on_demand(p_object_id => l_process_row.object_id);
        -- �������� � �������� �������� ����
        if l_on_demand_row.return_account <> l_main_on_demand_row.return_account then
           -- ���������� �������� �������
            l_process_row    := process_utl.read_process(p_process_id => l_main_on_demand_row.process_id);
            l_process_row.process_data := smb_deposit_utl.update_value_in_xml(
                                                p_data        => l_process_row.process_data
                                               ,p_tag         => 'ReturnAccount'
                                               ,p_value       => l_on_demand_row.return_account
                                               ,p_parent_node => smb_deposit_utl.PARENT_NODE_ON_DEMAND);
            smb_deposit_utl.set_process_data (
                       p_process_id => l_process_row.id
                      ,p_data       => l_process_row.process_data);
        end if;
        smb_calculation_deposit.manual_deposit_closing(
                                              p_id  => l_process_row.object_id);

    end; 

    procedure create_change_calc_type_dod(p_process_id in number) 
     is
    begin
        -- ������� ������ ��� ������ �������
        null;  
    end;

    -- ��� ������������� ���-������
    procedure can_confirm_change_calc_type(
        p_activity_id in integer,
        p_can_run_flag out char,
        p_explanation out varchar2)
     is
    begin
        -- �������� �������� ���������� ��� ��� �������� ���
        can_run_bo_confirm_on_demand(
                  p_activity_id  => p_activity_id
                 ,p_can_run_flag => p_can_run_flag
                 ,p_explanation  => p_explanation);
    end; 

    -- ��������� ���� ���������� ��� ���        
    procedure change_calc_type_dod_run(
            p_activity_id in number)
     as
    begin
        -- ������� ������ ��� ������ �������
        null; 
    end; 

    -- ��������, ���������� �� process_utl    
    procedure remove_new_tranche(p_process_id in number)
     is
    begin
        null;
    end;

    procedure remove_return_tranche(p_process_id in number)
     is
    begin
        null;
    end;

    procedure remove_new_on_demand(p_process_id in number)
     is
    begin
        null;
    end;

    procedure remove_replenish_tranche(p_process_id in number)
     is
    begin
        null;
    end;

    procedure remove_close_on_demand(p_process_id in number)
     is
    begin
        null;
    end;


end;
/
PROMPT *** Create  grants  smb_deposit_proc ***
grant EXECUTE   on smb_deposit_proc   to BARS_ACCESS_DEFROLE;
grant EXECUTE   on SMB_DEPOSIT_UTL    to BARSREADER_ROLE;
