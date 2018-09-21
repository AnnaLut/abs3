create or replace type t_core_pledge under t_core_object
(
    customer_code       varchar2(30 char),
    customer_id         integer,
    core_customer_id    integer,

    ordernum            number(2),
    codzastava          number(20),
    codman              number(20),
    numberpledge        varchar2(30 char),
    pledgeday           date,
    s031                varchar2(2 char),
    r030                varchar2(3 char),
    sumpledge           number(32),
    pricepledge         number(32),
    lastpledgeday       date,
    codrealty           number(1),
    ziprealty           varchar2(10 char),
    squarerealty        number(16,4),
    real6income         number(32),
    noreal6income       number(32),
    flaginsurancepledge varchar2(5 char),
    sumBail             number(32),
    sumGuarantee        number(32),

    deposit t_core_pledge_deposits,

    constructor function t_core_pledge(
        p_report_id in integer,
        p_pledge_id in integer,
        p_pledge_kf in varchar2)
    return self as result,

    overriding member function equals(
        p_core_object in t_core_object)
    return boolean,

    overriding member procedure perform_check(
        p_is_valid out boolean,
        p_validation_message out varchar2),

    overriding member function get_json
    return clob
)
/
create or replace type body t_core_pledge is

    constructor function t_core_pledge(
        p_report_id in integer,
        p_pledge_id in integer,
        p_pledge_kf in varchar2)
    return self as result
    is
        l_customer_object_row nbu_reported_object%rowtype;
        l_core_pledge_row core_pledge_dep%rowtype;
        l_core_company_row core_person_uo%rowtype;
        l_core_person_row core_person_fo%rowtype;
        l_pledge_row nbu_reported_pledge%rowtype;
        l_pledge_object_row nbu_reported_object%rowtype;
    begin
        l_core_pledge_row := nbu_core_service.get_core_pledge_row(p_report_id, p_pledge_id, p_pledge_kf);

        numberpledge        := l_core_pledge_row.numberpledge;
        pledgeday           := l_core_pledge_row.pledgeday;
        s031                := l_core_pledge_row.s031;
        r030                := l_core_pledge_row.r030;
        sumpledge           := abs(l_core_pledge_row.sumpledge);
        pricepledge         := l_core_pledge_row.pricepledge;
        lastpledgeday       := l_core_pledge_row.lastpledgeday;
        codrealty           := l_core_pledge_row.codrealty;
        ziprealty           := l_core_pledge_row.ziprealty;
        squarerealty        := l_core_pledge_row.squarerealty;
        real6income         := l_core_pledge_row.real6income;
        noreal6income       := l_core_pledge_row.noreal6income;
        flaginsurancepledge := l_core_pledge_row.flaginsurancepledge;
        sumBail             := l_core_pledge_row.sumbail;
        sumGuarantee        := l_core_pledge_row.sumGuarantee;

        if (l_core_pledge_row.numdogdp is not null or
            l_core_pledge_row.dogdaydp is not null or
            l_core_pledge_row.r030dp is not null or
            l_core_pledge_row.sumdp is not null) then

            deposit := t_core_pledge_deposits(t_core_pledge_deposit(l_core_pledge_row.numdogdp, l_core_pledge_row.dogdaydp, l_core_pledge_row.r030dp, l_core_pledge_row.sumdp));
        end if;


        l_core_company_row := nbu_core_service.get_core_company_row(p_report_id, l_core_pledge_row.rnk, l_core_pledge_row.kf);

        if (l_core_company_row.rnk is null) then
            l_core_person_row := nbu_core_service.get_core_person_row(p_report_id, l_core_pledge_row.rnk, l_core_pledge_row.kf);

            customer_code := l_core_person_row.person_code;
        else
            customer_code := l_core_company_row.company_code;
        end if;

        if (customer_code is not null) then
            customer_id := nbu_object_utl.read_customer(customer_code, p_raise_ndf => false).id;

            if (customer_id is not null) then
                l_customer_object_row := nbu_object_utl.read_object(customer_id);
                l_pledge_row := nbu_object_utl.read_pledge(customer_id, numberPledge, pledgeday, p_raise_ndf => false);

                if (l_pledge_row.id is not null) then
                    l_pledge_object_row := nbu_object_utl.read_object(l_pledge_row.id);
                end if;
            end if;
        end if;

        codman              := l_customer_object_row.external_id;

        ordernum            := l_pledge_row.order_number;
        codzastava          := l_pledge_object_row.external_id;

        --pledge_code         := l_core_pledge_row.pledge_code;

        core_object_kf      := p_pledge_kf;
        core_object_id      := p_pledge_id;
        core_customer_id    := l_core_pledge_row.rnk;

        reported_object_id  := l_pledge_object_row.id;
        external_object_id  := l_pledge_object_row.external_id;

        return;
    end;

    overriding member function equals(
        p_core_object in t_core_object)
    return boolean
    is
        l_core_pledge t_core_pledge;
        l_equals boolean;
        l integer;
    begin
        if (p_core_object is null) then
            return null;
        end if;

        if (p_core_object is of (t_core_pledge)) then
            l_core_pledge := treat(p_core_object as t_core_pledge);

            l_equals := bars.tools.equals(l_core_pledge.numberPledge       , numberPledge       ) and
                        bars.tools.equals(l_core_pledge.customer_id        , customer_id        ) and
                        bars.tools.equals(l_core_pledge.s031               , s031               ) and
                        bars.tools.equals(l_core_pledge.r030               , r030               ) and
                        bars.tools.equals(l_core_pledge.sumpledge          , sumpledge          ) and
                        bars.tools.equals(l_core_pledge.pricepledge        , pricepledge        ) and
                        bars.tools.equals(l_core_pledge.lastpledgeday      , lastpledgeday      ) and
                        bars.tools.equals(l_core_pledge.codrealty          , codrealty          ) and
                        bars.tools.equals(l_core_pledge.ziprealty          , ziprealty          ) and
                        bars.tools.equals(l_core_pledge.squarerealty       , squarerealty       ) and
                        bars.tools.equals(l_core_pledge.real6income        , real6income        ) and
                        bars.tools.equals(l_core_pledge.noreal6income      , noreal6income      ) and
                        bars.tools.equals(l_core_pledge.flaginsurancepledge, flaginsurancepledge);

            if (l_equals) then
                if ((l_core_pledge.deposit is null or l_core_pledge.deposit is empty) and (deposit is null or deposit is empty)) then
                    l_equals := true;
                else
                    -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                    if (l_core_pledge.deposit is not null and deposit is not null) then
                        if (l_core_pledge.deposit.count = deposit.count) then
                            l := l_core_pledge.deposit.first;
                            while (l_equals and l is not null) loop
                                l_equals := bars.tools.equals(l_core_pledge.deposit(l).numDogDp, deposit(l).numDogDp) and
                                            bars.tools.equals(l_core_pledge.deposit(l).dogDayDp, deposit(l).dogDayDp) and
                                            bars.tools.equals(l_core_pledge.deposit(l).r030Dp, deposit(l).r030Dp) and
                                            bars.tools.equals(l_core_pledge.deposit(l).sumDp, deposit(l).sumDp);
                                l := l_core_pledge.deposit.next(l);
                            end loop;
                        else
                            l_equals := false;
                        end if;
                    else
                        l_equals := false;
                    end if;
                end if;
            end if;
        else
            raise_application_error(-20000, 'Тип об''єкта з ідентифікатором {' || p_core_object.core_object_id || '/' || p_core_object.core_object_kf || '} не є Заставою');
        end if;

        return l_equals;
    end;

    overriding member procedure perform_check(
        p_is_valid out boolean,
        p_validation_message out varchar2)
    is
    begin
       p_is_valid := true;

       if (numberpledge is null) then
           p_is_valid := false;
           p_validation_message := 'Номер договору застави не вказаний';
       end if;

       if (pledgeday is null) then
           p_is_valid := false;
           p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                   'Дата договору застави не вказана';
       end if;

       if (customer_id is null) then
           p_is_valid := false;
           p_validation_message := 'Клієнт-власник застави з ідентифікатором {' || core_customer_id || '/' || core_object_kf || '} не зареєстрований для передачі до НБУ';
       end if;
    end;

    overriding member function get_json
    return clob
    is
        l_clob clob;
        l_attributes bars.string_list := bars.string_list();
        l_deposit_attributes bars.string_list;
        l integer;
    begin
        l_attributes.extend(30);
        -- l_attributes(1) := json_utl.make_json_value('orderNum', nvl(ordernum, '1'));
        l_attributes(1) := json_utl.make_json_value('orderNum', '1', p_mandatory => true);
        l_attributes(2) := json_utl.make_json_value('codZastava', nvl(codzastava, '0'), p_mandatory => true);
        l_attributes(3) := json_utl.make_json_value('codMan', codman, p_mandatory => true);
        l_attributes(4) := json_utl.make_json_string('numberPledge', numberPledge, p_mandatory => true);
        l_attributes(5) := json_utl.make_json_date('pledgeDay', pledgeday, p_mandatory => true);
        l_attributes(6) := json_utl.make_json_string('s031', s031, p_mandatory => true);
        l_attributes(7) := json_utl.make_json_value('orderZastava', '1', p_mandatory => true);
        l_attributes(8) := json_utl.make_json_string('r030', r030, p_mandatory => false);
        l_attributes(9) := json_utl.make_json_value('sumPledge', sumpledge, p_mandatory => true);
        l_attributes(10) := json_utl.make_json_value('pricePledge', pricePledge, p_mandatory => false);
        l_attributes(11) := json_utl.make_json_date('lastPledgeDay', lastPledgeDay, p_mandatory => false);
        l_attributes(12) := json_utl.make_json_value('codRealty', codRealty, p_mandatory => false);
        l_attributes(13) := json_utl.make_json_string('zipRealty', zipRealty, p_mandatory => false);
        l_attributes(14) := json_utl.make_json_value('squareRealty', squareRealty, p_mandatory => false);
        l_attributes(15) := json_utl.make_json_value('sumBail', sumBail, p_mandatory => true);
        l_attributes(16) := json_utl.make_json_value('sumGuarantee', sumGuarantee, p_mandatory => true); 
        l_attributes(17) := json_utl.make_json_value('real6income', real6income, p_mandatory => false);
        l_attributes(18) := json_utl.make_json_value('noreal6income', noreal6income, p_mandatory => false);
        
        l_attributes(19) := json_utl.make_json_value('flagInsurancePledge', nvl(flaginsurancepledge, 'false'), p_mandatory => true);

        if (deposit is not null and deposit is not empty) then
            l_deposit_attributes := bars.string_list();
            l_deposit_attributes.extend(deposit.count);

            l := deposit.first;
            while (l is not null) loop
                l_deposit_attributes(l) := '{' ||
                                                  json_utl.make_json_string('numDogDp', deposit(l).numdogdp, p_mandatory => true) || ', ' ||
                                                  json_utl.make_json_date('dogDayDp', deposit(l).dogdaydp, p_mandatory => true) || ', ' ||
                                                  json_utl.make_json_string('r030Dp', deposit(l).r030dp, p_mandatory => true) || ', ' ||
                                                  json_utl.make_json_value('sumDp', deposit(l).sumdp, p_mandatory => true) ||
                                           '}';
                l := deposit.next(l);
            end loop;

            l_attributes(20) := json_utl.make_json_value('deposit', '[' || bars.tools.words_to_string(l_deposit_attributes, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ']');
        end if;

        dbms_lob.createtemporary(l_clob, false);

        dbms_lob.append(l_clob, '{ "data": [{ ');

        l := l_attributes.first;
        while (l is not null) loop
            if (l_attributes(l) is not null) then
                dbms_lob.append(l_clob, l_attributes(l) || ', ');
            end if;
            l := l_attributes.next(l);
        end loop;

        l_clob := rtrim(l_clob, ', ');
        dbms_lob.append(l_clob, ' }] }');

        return l_clob;
    end;
end;
/
