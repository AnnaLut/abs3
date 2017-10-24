create or replace view v_compen_passp_benef as
select * from passp p
where p.passp in (1, --Паспорт громадянина України
                  3, --Свідоцтво про  народження
                  7, --Паспорт ID-картка(Резидент)
--                 98, --Свідоцтво про смерть
--                 95, --Свідоцтво про смерть (закордонний)
                 13, --Паспорт нерезидента
                 11 --Закордонний паспорт гр.України
--                 15, --Тимчасове посвідчення особи
--                 96, --Заповіт
--                 97  --Свідоцтво про спадщину
                 )
order by p.name;

COMMENT ON TABLE v_compen_passp_benef  IS 'Список видів документів, які для вказаування на беніфіціарі';
GRANT SELECT ON v_compen_passp_benef TO BARS_ACCESS_DEFROLE;