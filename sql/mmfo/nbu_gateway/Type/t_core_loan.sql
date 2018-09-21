create or replace type t_core_loan under t_core_object
(
    customer_code varchar2(30 char),
    customer_id   integer,
    core_customer_id integer,

    ordernum      number(2),
    flagosoba     varchar2(5 char),
    codcredit     number(20),
    codman        number(20),
    typecredit    number(2),
    numberdog     varchar2(50 char),
    dogday        date,
    endday        date,
    sumzagal      number(32),
    r030          varchar2(3 char),
    proccredit    number(5,2),
    sumpay        number(32),
    periodbase    number(1),
    periodproc    number(1),
    sumarrears    number(32),
    arrearbase    number(32),
    arrearproc    number(32),
    daybase       number(5),
    dayproc       number(5),
    factendday    date,
    flagz         varchar2(5 char),
    klass         varchar2(1 char),
    risk          number(32),
    flaginsurance varchar2(5 char),

    pledge        t_core_loan_pledges,
    tranche       t_core_loan_tranches,

    constructor function t_core_loan(
        p_report_id in integer,
        p_loan_id in integer,
        p_loan_kf in varchar2)
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
create or replace type body t_core_loan is

    constructor function t_core_loan(
        p_report_id in integer,
        p_loan_id in integer,
        p_loan_kf in varchar2)
    return self as result
    is
        l_loan_object_row nbu_reported_object%rowtype;
        l_loan_row nbu_reported_loan%rowtype;
        l_customer_object_row nbu_reported_object%rowtype;
        l_core_loan_row core_credit%rowtype;
        l_core_company_row core_person_uo%rowtype;
        l_core_person_row core_person_fo%rowtype;
    begin

        l_core_loan_row := nbu_core_service.get_core_credit_row(p_report_id, p_loan_id, p_loan_kf);

        ordernum         := 1;

        flagosoba        := l_core_loan_row.flagosoba;
        typecredit       := l_core_loan_row.typecredit;
        numberdog        := l_core_loan_row.numdog;
        dogday           := l_core_loan_row.dogday;
        endday           := l_core_loan_row.endday;
        sumzagal         := abs(l_core_loan_row.sumzagal);
        r030             := l_core_loan_row.r030;
        proccredit       := l_core_loan_row.proccredit;
        sumpay           := abs(l_core_loan_row.sumpay);
        periodbase       := l_core_loan_row.periodbase;
        periodproc       := l_core_loan_row.periodproc;
        sumarrears       := abs(l_core_loan_row.sumarrears);
        arrearbase       := abs(l_core_loan_row.arrearbase);
        arrearproc       := abs(l_core_loan_row.arrearproc);
        daybase          := l_core_loan_row.daybase;
        dayproc          := l_core_loan_row.dayproc;
        factendday       := l_core_loan_row.factendday;
        flagz            := l_core_loan_row.flagz;
        klass            := l_core_loan_row.klass;
        risk             := l_core_loan_row.risk;
        flaginsurance    := l_core_loan_row.flaginsurance;

        pledge           := nbu_core_service.get_core_credit_pledges(p_report_id, p_loan_id, p_loan_kf);
        tranche          := nbu_core_service.get_core_credit_tranches(p_report_id, p_loan_id, p_loan_kf);

        l_core_company_row := nbu_core_service.get_core_company_row(p_report_id, l_core_loan_row.rnk, l_core_loan_row.kf);

        if (l_core_company_row.rnk is null) then
            l_core_person_row := nbu_core_service.get_core_person_row(p_report_id, l_core_loan_row.rnk, l_core_loan_row.kf);

            customer_code := l_core_person_row.person_code;
        else
            customer_code := l_core_company_row.company_code;
        end if;

        if (customer_code is not null) then
            customer_id := nbu_object_utl.read_customer(customer_code, p_raise_ndf => false).id;

            if (customer_id is not null) then
                l_customer_object_row := nbu_object_utl.read_object(customer_id);
                l_loan_row := nbu_object_utl.read_loan(customer_id, numberdog, dogday, p_raise_ndf => false);

                if (l_loan_row.id is not null) then
                    l_loan_object_row := nbu_object_utl.read_object(l_loan_row.id);
                end if;
            end if;
        end if;

        codcredit := l_loan_object_row.external_id;
        codman := l_customer_object_row.external_id;

        core_object_kf      := p_loan_kf;
        core_object_id      := p_loan_id;
        core_customer_id    := l_core_loan_row.rnk;

        reported_object_id  := l_loan_object_row.id;
        external_object_id  := l_loan_object_row.external_id;

        return;
    end;

    overriding member function equals(
        p_core_object in t_core_object)
    return boolean
    is
        l_core_loan t_core_loan;
        l_equals boolean;
        l integer;
    begin
        if (p_core_object is null) then
            return null;
        end if;

        if (p_core_object is of (t_core_loan)) then
            l_core_loan := treat(p_core_object as t_core_loan);
        else
            raise_application_error(-20000, 'Тип об''єкта з ідентифікатором {' || p_core_object.core_object_id || '/' || p_core_object.core_object_kf || '} не є Договором запозичення');
        end if;

        l_equals := bars.tools.equals(l_core_loan.customer_code, customer_code) and
                    bars.tools.equals(l_core_loan.flagosoba    , flagosoba    ) and
                    bars.tools.equals(l_core_loan.typecredit   , typecredit   ) and
                    bars.tools.equals(l_core_loan.numberdog    , numberdog    ) and
                    bars.tools.equals(l_core_loan.dogday       , dogday       ) and
                    bars.tools.equals(l_core_loan.endday       , endday       ) and
                    bars.tools.equals(l_core_loan.sumzagal     , sumzagal     ) and
                    bars.tools.equals(l_core_loan.r030         , r030         ) and
                    bars.tools.equals(l_core_loan.proccredit   , proccredit   ) and
                    bars.tools.equals(l_core_loan.sumpay       , sumpay       ) and
                    bars.tools.equals(l_core_loan.periodbase   , periodbase   ) and
                    bars.tools.equals(l_core_loan.periodproc   , periodproc   ) and
                    bars.tools.equals(l_core_loan.sumarrears   , sumarrears   ) and
                    bars.tools.equals(l_core_loan.arrearbase   , arrearbase   ) and
                    bars.tools.equals(l_core_loan.arrearproc   , arrearproc   ) and
                    bars.tools.equals(l_core_loan.daybase      , daybase      ) and
                    bars.tools.equals(l_core_loan.dayproc      , dayproc      ) and
                    bars.tools.equals(l_core_loan.factendday   , factendday   ) and
                    bars.tools.equals(l_core_loan.flagz        , flagz        ) and
                    bars.tools.equals(l_core_loan.klass        , klass        ) and
                    bars.tools.equals(l_core_loan.risk         , risk         ) and
                    bars.tools.equals(l_core_loan.flaginsurance, flaginsurance);

        if (l_equals) then
            if ((l_core_loan.pledge is null or l_core_loan.pledge is empty) and (pledge is null or pledge is empty)) then
                l_equals := true;
            else
                -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                if (l_core_loan.pledge is not null and pledge is not null) then
                    if (l_core_loan.pledge.count = pledge.count) then
                        l := l_core_loan.pledge.first;
                        while (l_equals and l is not null) loop
                            l_equals := bars.tools.equals(l_core_loan.pledge(l).codzastava , pledge(l).codzastava ) and
                                        bars.tools.equals(l_core_loan.pledge(l).sumpledge  , pledge(l).sumpledge  ) and
                                        bars.tools.equals(l_core_loan.pledge(l).pricepledge, pledge(l).pricepledge);
                            l := l_core_loan.pledge.next(l);
                        end loop;
                    else
                        l_equals := false;
                    end if;
                else
                    l_equals := false;
                end if;
            end if;
        end if;

        if (l_equals) then
            if ((l_core_loan.tranche is null or l_core_loan.tranche is empty) and (tranche is null or tranche is empty)) then
                l_equals := true;
            else
                -- для порівняння вмісту колекцій таким чином їх значення повинні бути відсортовані в одному і тому самому порядку
                if (l_core_loan.tranche is not null and tranche is not null) then
                    if (l_core_loan.tranche.count = tranche.count) then
                        l := l_core_loan.tranche.first;
                        while (l_equals and l is not null) loop
                            l_equals := bars.tools.equals(l_core_loan.tranche(l).numdogtr    , tranche(l).numdogtr    ) and
                                        bars.tools.equals(l_core_loan.tranche(l).dogdaytr    , tranche(l).dogdaytr    ) and
                                        bars.tools.equals(l_core_loan.tranche(l).enddaytr    , tranche(l).enddaytr    ) and
                                        bars.tools.equals(l_core_loan.tranche(l).sumzagaltr  , tranche(l).sumzagaltr  ) and
                                        bars.tools.equals(l_core_loan.tranche(l).r030tr      , tranche(l).r030tr      ) and
                                        bars.tools.equals(l_core_loan.tranche(l).proccredittr, tranche(l).proccredittr) and
                                        bars.tools.equals(l_core_loan.tranche(l).periodbasetr, tranche(l).periodbasetr) and
                                        bars.tools.equals(l_core_loan.tranche(l).periodproctr, tranche(l).periodproctr) and
                                        bars.tools.equals(l_core_loan.tranche(l).sumarrearstr, tranche(l).sumarrearstr) and
                                        bars.tools.equals(l_core_loan.tranche(l).arrearbasetr, tranche(l).arrearbasetr) and
                                        bars.tools.equals(l_core_loan.tranche(l).arrearproctr, tranche(l).arrearproctr) and
                                        bars.tools.equals(l_core_loan.tranche(l).daybasetr   , tranche(l).daybasetr   ) and
                                        bars.tools.equals(l_core_loan.tranche(l).dayproctr   , tranche(l).dayproctr   ) and
                                        bars.tools.equals(l_core_loan.tranche(l).factenddaytr, tranche(l).factenddaytr) and
                                        bars.tools.equals(l_core_loan.tranche(l).klasstr     , tranche(l).klasstr     ) and
                                        bars.tools.equals(l_core_loan.tranche(l).risktr      , tranche(l).risktr      );
                            l := l_core_loan.tranche.next(l);
                        end loop;
                    else
                        l_equals := false;
                    end if;
                else
                    l_equals := false;
                end if;
            end if;
        end if;

        return l_equals;
    end;

    overriding member procedure perform_check(
        p_is_valid out boolean,
        p_validation_message out varchar2)
    is
    begin
       p_is_valid := true;

       if (numberdog is null) then
           p_is_valid := false;
           p_validation_message := 'Номер кредитного договору не вказаний';
       end if;

       if (dogday is null) then
           p_is_valid := false;
           p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                   'Дата кредитного договору не вказана';
       end if;

       if (typecredit is null) then
           p_is_valid := false;
           p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                   'Не визначений тип кредиту';
       end if;

       if (proccredit is null) then
           p_is_valid := false;
           p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                   'Не вказана номінальна відсоткова ставка';
       end if;

       if (periodbase is null) then
           p_is_valid := false;
           p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                   'Не вказана періодичність сплати основного боргу';
       end if;

       if (periodproc is null) then
           p_is_valid := false;
           p_validation_message := case when p_validation_message is null then null else p_validation_message || ', ' end ||
                                   'Не вказана періодичність сплати відсотків';
       end if;

       if (customer_id is null) then
           p_is_valid := false;
           p_validation_message := 'Клієнт-позичальник з ідентифікатором {' || core_customer_id || '/' || core_object_kf || '} не зареєстрований для передачі до НБУ';
       end if;
    end;

    overriding member function get_json
    return clob
    is
        l_clob clob;
        l_attributes bars.string_list := bars.string_list();
        l_pledge_items bars.string_list;
        l_pledge_keys bars.string_list;
        l_tranche_items bars.string_list;
        l_tranche_keys bars.string_list;
        l integer;
    begin

        l_attributes.extend(100);
        l_attributes(1) := json_utl.make_json_value('orderNum', '1', p_mandatory => true);
        l_attributes(2) := json_utl.make_json_value('flagOsoba', flagOsoba, p_mandatory => true);
        l_attributes(3) := json_utl.make_json_value('codCredit', nvl(codCredit, 0), p_mandatory => true);
        l_attributes(4) := json_utl.make_json_value('codMan', codMan, p_mandatory => true);
        l_attributes(5) := json_utl.make_json_value('typeCredit', typeCredit, p_mandatory => true);
        l_attributes(6) := json_utl.make_json_string('numberDog', numberDog, p_mandatory => true);
        l_attributes(7) := json_utl.make_json_date('dogDay', dogDay, p_mandatory => true);
        l_attributes(8) := json_utl.make_json_date('endDay', endDay, p_mandatory => true);
        l_attributes(9) := json_utl.make_json_value('sumZagal', sumZagal, p_mandatory => true);
        l_attributes(10) := json_utl.make_json_string('r030', r030, p_mandatory => true);
        l_attributes(11) := json_utl.make_json_value('procCredit', to_char(procCredit, 'FM99990.00'), p_mandatory => true);
        l_attributes(12) := json_utl.make_json_value('sumPay', nvl(sumPay, 0), p_mandatory => true);
        l_attributes(13) := json_utl.make_json_value('periodBase', periodBase, p_mandatory => true);
        l_attributes(14) := json_utl.make_json_value('periodProc', periodProc, p_mandatory => true);
        l_attributes(15) := json_utl.make_json_value('sumArrears', nvl(sumArrears, 0), p_mandatory => true);
        l_attributes(16) := json_utl.make_json_value('arrearBase', nvl(arrearBase, 0), p_mandatory => true);
        l_attributes(17) := json_utl.make_json_value('arrearProc', nvl(arrearProc, 0), p_mandatory => true);
        l_attributes(18) := json_utl.make_json_value('dayBase', nvl(dayBase, 0), p_mandatory => true);
        l_attributes(19) := json_utl.make_json_value('dayProc', nvl(dayProc, 0), p_mandatory => true);
        l_attributes(20) := json_utl.make_json_date('factEndDay', factEndDay, p_mandatory => false);
        l_attributes(21) := json_utl.make_json_value('flagZ', nvl(flagZ, 'false'), p_mandatory => true);
        l_attributes(22) := json_utl.make_json_value('klass', klass, p_mandatory => true);
        l_attributes(23) := json_utl.make_json_value('risk', risk, p_mandatory => true);
        l_attributes(24) := json_utl.make_json_value('flagInsurance', nvl(flagInsurance, 'false'), p_mandatory => true);

        if (pledge is not null and pledge is not empty) then
            l_pledge_items := bars.string_list();
            l_pledge_items.extend(pledge.count);

            l_pledge_keys := bars.string_list();
            l_pledge_keys.extend(3);

            l := pledge.first;
            while (l is not null) loop

                l_pledge_keys(1) := json_utl.make_json_value('codZastava', pledge(l).codZastava, p_mandatory => true);
                l_pledge_keys(2) := json_utl.make_json_value('sumPledge', nvl(pledge(l).sumPledge, 0), p_mandatory => true);
                l_pledge_keys(3) := json_utl.make_json_value('pricePledge', nvl(pledge(l).pricePledge, 0), p_mandatory => true);

                l_pledge_items(l) := '{' || bars.tools.words_to_string(l_pledge_keys, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || '}';

                l := pledge.next(l);
            end loop;

            l_attributes(25) := json_utl.make_json_value('pledge',
                                                         '[' || bars.tools.words_to_string(l_pledge_items, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ']',
                                                         p_mandatory => true);
        end if;

        if (tranche is not null and tranche is not empty) then
            l_tranche_items := bars.string_list();
            l_tranche_items.extend(tranche.count);

            l_tranche_keys := bars.string_list();
            l_tranche_keys.extend(16);

            l := tranche.first;
            while (l is not null) loop
                l_tranche_keys(1) := json_utl.make_json_string('numDogTr', tranche(l).numDogTr, p_mandatory => true);
                l_tranche_keys(2) := json_utl.make_json_date('dogDayTr', tranche(l).dogDayTr, p_mandatory => true);
                l_tranche_keys(3) := json_utl.make_json_date('endDayTr', tranche(l).endDayTr, p_mandatory => true);
                l_tranche_keys(4) := json_utl.make_json_value('sumZagalTr', tranche(l).sumZagalTr, p_mandatory => true);
                l_tranche_keys(5) := json_utl.make_json_string('r030Tr', tranche(l).r030Tr, p_mandatory => true);
                l_tranche_keys(6) := json_utl.make_json_value('procCreditTr', to_char(tranche(l).procCreditTr, 'FM99990.00'), p_mandatory => true);
                l_tranche_keys(7) := json_utl.make_json_value('periodBaseTr', tranche(l).periodBaseTr, p_mandatory => true);
                l_tranche_keys(8) := json_utl.make_json_value('periodProcTr', tranche(l).periodProcTr, p_mandatory => true);
                l_tranche_keys(9) := json_utl.make_json_value('sumArrearsTr', tranche(l).sumArrearsTr, p_mandatory => true);
                l_tranche_keys(10) := json_utl.make_json_value('arrearBaseTr', tranche(l).arrearBaseTr, p_mandatory => true);
                l_tranche_keys(11) := json_utl.make_json_value('arrearProcTr', tranche(l).arrearProcTr, p_mandatory => true);
                l_tranche_keys(12) := json_utl.make_json_value('dayBaseTr', tranche(l).dayBaseTr, p_mandatory => true);
                l_tranche_keys(13) := json_utl.make_json_value('dayProcTr', tranche(l).dayProcTr, p_mandatory => true);
                l_tranche_keys(14) := json_utl.make_json_date('factEndDayTr', tranche(l).factEndDayTr, p_mandatory => false);
                l_tranche_keys(15) := json_utl.make_json_value('klassTr', tranche(l).klassTr, p_mandatory => true);
                l_tranche_keys(16) := json_utl.make_json_value('riskTr', tranche(l).riskTr, p_mandatory => true);

                l_tranche_items(l) := '{' || bars.tools.words_to_string(l_tranche_keys, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ' }';
                l := tranche.next(l);
            end loop;

            /*l_attributes(26) := json_utl.make_json_value('tranche',
                                                         '[' || bars.tools.words_to_string(l_tranche_items, p_splitting_symbol => ', ', p_ignore_nulls => 'Y') || ']',
                                                         p_mandatory => true);*/
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
        dbms_lob.append(l_clob, '}] }');

        return l_clob;
    end;
end;
/
