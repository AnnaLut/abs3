CREATE OR REPLACE function BARS.ruuser(p_user varchar2)
return varchar2
is
begin
    return mgr_utl.ruuser(p_user);
end ruuser;
/
