-- корректировка значений тега DATEOFKK из вида '11-MAY-17' к виду '11/04/2017'
begin
    for lc_kf in (select kf from bars.mv_kf)
    loop
        bars.bc.go(lc_kf.kf);
        update bars.accountsw
           set value = to_char(to_date(value, 'DD-MON-YY','NLS_DATE_LANGUAGE = American'), 'dd/mm/yyyy')
         where tag = 'DATEOFKK'
           and kf = lc_kf.kf
           and value like '%-%';
        DBMS_OUTPUT.PUT_LINE('Sinchronize ACCOUNTSW = ' || sql%rowcount || ' row(s) updated for ' || lc_kf.kf || ' =');
        commit;
    end loop;
end;
/

begin
bars.bc.home;
end;
/



