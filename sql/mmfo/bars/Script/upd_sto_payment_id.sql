declare
    l_payment_ids number_list;
    l_version varchar2(32767 byte);
    component_must_be_declared exception;
    pragma exception_init(component_must_be_declared, -302);
begin
    begin
        execute immediate 'begin :l_version := sto_payment_utl.get_version(); end;'
        using out l_version;

        return;
    exception
        when others then
             if (sqlerrm like '%PLS-00302%') then
                 null;
             else raise;
             end if;
    end;

    select t.payment_id
    bulk collect into l_payment_ids
    from   bars.sto_payment_tracking t
    where  t.sys_time >= date '2017-05-27'
    order by t.id;

    if (l_payment_ids is empty) then
        return;
    end if;

    execute immediate 'alter table sto_payment_tracking disable constraint fk_paym_track_ref_payment';
    execute immediate 'alter table sto_payment_document_link disable constraint fk_pm_doc_link_ref_paym';

    update sto_payment t
    set    t.id = t.id * 100 + 11
    where  t.id member of l_payment_ids;

    update sto_payment_que t
    set    t.id = t.id * 100 + 11
    where  t.id member of l_payment_ids;

    update sto_payment_document_link t
    set    t.payment_id = t.payment_id * 100 + 11
    where  t.payment_id member of l_payment_ids;

    update sto_payment_tracking t
    set    t.payment_id = t.payment_id * 100 + 11
    where  t.payment_id member of l_payment_ids;

    execute immediate 'alter table sto_payment_tracking enable novalidate constraint fk_paym_track_ref_payment';
    execute immediate 'alter table sto_payment_document_link enable novalidate constraint fk_pm_doc_link_ref_paym';
end;
