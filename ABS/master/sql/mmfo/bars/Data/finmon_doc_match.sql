prompt finmon_doc_match: refill

delete from finmon_doc_match;
/
insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (-1, '8');

insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (1, '1');

insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (2, '5');

insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (3, '8');

insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (4, '8');

insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (5, '8');

insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (99, '8');

insert into finmon_doc_match (BARS_CODE, FINMON_CODE)
values (7, '10');

commit;
/
