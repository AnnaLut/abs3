-- спецконсолидация файлов #D3, #C9, #E2, #70
-- отдельные процедуры консолидации P_FILED3, p_FILEC9, P_FILEE2, P_FILE70

delete from rnbu_1 where kodf in ('D3', 'C9', 'E2', '70');

insert into RNBU_1 (kodf, kod_maska, kod)
            values ('D3', null,      91);

insert into RNBU_1 (kodf, kod_maska, kod)
            values ('C9', null,      91);

insert into RNBU_1 (kodf, kod_maska, kod)
            values ('E2', null,      91);

insert into RNBU_1 (kodf, kod_maska, kod)
            values ('70', null,      91);

commit;

