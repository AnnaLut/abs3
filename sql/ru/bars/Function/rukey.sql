CREATE OR REPLACE function BARS.rukey(p_key varchar2)
return varchar2
is
begin
    return mgr_utl.rukey(p_key);
end rukey;
/
