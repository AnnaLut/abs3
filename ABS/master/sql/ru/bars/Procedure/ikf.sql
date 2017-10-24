CREATE OR REPLACE procedure BARS.ikf(p_kf varchar2)
is
begin
    -- устанавливаем импортируемый код филиала
    mgr_utl.set_kf(p_kf);
end ikf;
/
