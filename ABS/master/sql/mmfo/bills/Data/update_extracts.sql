prompt Добавляем записи в список выдержек из ca_receivers
insert /*+ ignore_row_on_dupkey_index(EXTRACTS XPK_EXTRACTS) */ into extracts
select distinct extract_number_id, trunc(sysdate, 'MONTH') from ca_receivers t 
where extract_number_id is not null;
commit;