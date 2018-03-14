begin
    bars.branch_attribute_utl.add_new_attribute('NBU_601_CORE_DATA_REQUEST_MODE',
                                                'Режим обміну даними для формування звіту 601 (CENTRALIZED - запити на формування даних надходять з ЦА, DECENTRALIZED - дані надаються РУ)',
                                                'C');

    bars.branch_attribute_utl.set_attribute_value('/', 'NBU_601_CORE_DATA_REQUEST_MODE', 'CENTRALIZED');

    commit;
end;
/
