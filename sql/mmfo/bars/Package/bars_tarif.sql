
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_tarif.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_TARIF 
is

g_header_version  constant varchar2(64)  := 'version 1.0 06/01/2015';
g_header_defs     constant varchar2(512) := '';

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

-------------------------------------------------------------------------------
procedure set_tarif (
  p_kod       tarif.kod%type,
  p_name      tarif.name%type,
  p_tip       tarif.tip%type,
  p_kv        tarif.kv%type,
  p_tar       tarif.tar%type,
  p_pr        tarif.pr%type,
  p_smin      tarif.smin%type,
  p_kv_smin   tarif.kv_smin%type,
  p_smax      tarif.smax%type,
  p_kv_smax   tarif.kv_smax%type,
  p_nbs       tarif.nbs%type,
  p_ob22      tarif.ob22%type,
  p_pdv       tarif.pdv%type,
  p_razova    tarif.razova%type,
  p_dat_begin tarif.dat_begin%type,
  p_dat_end   tarif.dat_end%type );

-------------------------------------------------------------------------------
procedure del_tarif (p_kod tarif.kod%type);

-------------------------------------------------------------------------------
procedure set_tarif_scale (
  p_kod       tarif_scale.kod%type,
  p_sum_limit tarif_scale.sum_limit%type,
  p_sum_tarif tarif_scale.sum_tarif%type,
  p_pr        tarif_scale.pr%type,
  p_smin      tarif_scale.smin%type,
  p_smax      tarif_scale.smax%type );

-------------------------------------------------------------------------------
procedure del_tarif_scale (p_kod tarif.kod%type, p_sum_limit tarif_scale.sum_limit%type);

-------------------------------------------------------------------------------
procedure set_sh_tarif (
  p_ids      sh_tarif.ids%type,
  p_kod      sh_tarif.kod%type,
  p_tar      sh_tarif.tar%type,
  p_pr       sh_tarif.pr%type,
  p_smin     sh_tarif.smin%type,
  p_smax     sh_tarif.smax%type,
  p_nbs_ob22 sh_tarif.nbs_ob22%type );

-------------------------------------------------------------------------------
procedure del_sh_tarif (p_ids sh_tarif.ids%type, p_kod sh_tarif.kod%type);

-------------------------------------------------------------------------------
procedure set_sh_tarif_scale (
  p_ids       sh_tarif_scale.ids%type,
  p_kod       sh_tarif_scale.kod%type,
  p_sum_limit sh_tarif_scale.sum_limit%type,
  p_sum_tarif sh_tarif_scale.sum_tarif%type,
  p_pr        sh_tarif_scale.pr%type,
  p_smin      sh_tarif_scale.smin%type,
  p_smax      sh_tarif_scale.smax%type );

-------------------------------------------------------------------------------
procedure del_sh_tarif_scale (
  p_ids       sh_tarif_scale.ids%type,
  p_kod       sh_tarif_scale.kod%type,
  p_sum_limit sh_tarif_scale.sum_limit%type );

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_TARIF 
is

--
-- constants
--
g_body_version    constant varchar2(64)  := 'version 1.0 06/01/2015';
g_body_defs       constant varchar2(512) := '';

g_modcode         constant varchar2(3)   := 'TAR';
g_pkbcode         constant varchar2(100) := 'bars_tarif';

-------------------------------------------------------------------------------
-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header ' || g_pkbcode || ' ' || g_header_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      ||  g_header_defs;
end header_version;

-------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body ' || g_pkbcode || ' ' || g_body_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
procedure set_tarif (
  p_kod       tarif.kod%type,
  p_name      tarif.name%type,
  p_tip       tarif.tip%type,
  p_kv        tarif.kv%type,
  p_tar       tarif.tar%type,
  p_pr        tarif.pr%type,
  p_smin      tarif.smin%type,
  p_kv_smin   tarif.kv_smin%type,
  p_smax      tarif.smax%type,
  p_kv_smax   tarif.kv_smax%type,
  p_nbs       tarif.nbs%type,
  p_ob22      tarif.ob22%type,
  p_pdv       tarif.pdv%type,
  p_razova    tarif.razova%type,
  p_dat_begin tarif.dat_begin%type,
  p_dat_end   tarif.dat_end%type )
is
begin
  begin
     insert into tarif (kod, name, tip, kv, tar, pr, smin, kv_smin, smax, kv_smax, nbs, ob22, pdv, razova, dat_begin, dat_end, kf)
     values (p_kod, p_name, p_tip, p_kv, p_tar, p_pr, p_smin, p_kv_smin, p_smax, p_kv_smax, p_nbs, p_ob22, p_pdv, p_razova, p_dat_begin, p_dat_end, getglobaloption('GLB-MFO'));
  exception when dup_val_on_index then
     update tarif
        set name      = p_name,
            tip       = p_tip,
            kv        = p_kv,
            tar       = p_tar,
            pr        = p_pr,
            smin      = p_smin,
            kv_smin   = p_kv_smin,
            smax      = p_smax,
            kv_smax   = p_kv_smax,
            nbs       = p_nbs,
            ob22      = p_ob22,
            pdv       = p_pdv,
            razova    = p_razova,
            dat_begin = p_dat_begin,
            dat_end   = p_dat_end
      where kod = p_kod;
  end;
end set_tarif;

-------------------------------------------------------------------------------
procedure del_tarif (p_kod tarif.kod%type)
is
begin
  delete from tarif where kod = p_kod;
end del_tarif;

-------------------------------------------------------------------------------
procedure set_tarif_scale (
  p_kod       tarif_scale.kod%type,
  p_sum_limit tarif_scale.sum_limit%type,
  p_sum_tarif tarif_scale.sum_tarif%type,
  p_pr        tarif_scale.pr%type,
  p_smin      tarif_scale.smin%type,
  p_smax      tarif_scale.smax%type )
is
begin
  begin
     insert into tarif_scale (kod, sum_limit, sum_tarif, pr, smin, smax, kf)
     values (p_kod, p_sum_limit, p_sum_tarif, p_pr, p_smin, p_smax, getglobaloption('GLB-MFO'));
  exception when dup_val_on_index then
     update tarif_scale
        set sum_tarif = p_sum_tarif,
            pr        = p_pr,
            smin      = p_smin,
            smax      = p_smax
      where kod = p_kod
        and sum_limit = p_sum_limit;
  end;
end set_tarif_scale;

-------------------------------------------------------------------------------
procedure del_tarif_scale (p_kod tarif.kod%type, p_sum_limit tarif_scale.sum_limit%type)
is
begin
  delete from tarif_scale where kod = p_kod and sum_limit = p_sum_limit;
end del_tarif_scale;

-------------------------------------------------------------------------------
procedure set_sh_tarif (
  p_ids      sh_tarif.ids%type,
  p_kod      sh_tarif.kod%type,
  p_tar      sh_tarif.tar%type,
  p_pr       sh_tarif.pr%type,
  p_smin     sh_tarif.smin%type,
  p_smax     sh_tarif.smax%type,
  p_nbs_ob22 sh_tarif.nbs_ob22%type )
is
begin
  begin
     insert into sh_tarif (ids, kod, tar, pr, smin, smax, nbs_ob22, kf)
     values (p_ids, p_kod, p_tar, p_pr, p_smin, p_smax, p_nbs_ob22, getglobaloption('GLB-MFO'));
  exception when dup_val_on_index then
     update sh_tarif
        set tar      = p_tar,
            pr       = p_pr,
            smin     = p_smin,
            smax     = p_smax,
            nbs_ob22 = p_nbs_ob22
      where ids = p_ids
        and kod = p_kod;
  end;
end set_sh_tarif;

-------------------------------------------------------------------------------
procedure del_sh_tarif (p_ids sh_tarif.ids%type, p_kod sh_tarif.kod%type)
is
begin
  delete from sh_tarif where ids = p_ids and kod = p_kod;
end del_sh_tarif;

-------------------------------------------------------------------------------
procedure set_sh_tarif_scale (
  p_ids       sh_tarif_scale.ids%type,
  p_kod       sh_tarif_scale.kod%type,
  p_sum_limit sh_tarif_scale.sum_limit%type,
  p_sum_tarif sh_tarif_scale.sum_tarif%type,
  p_pr        sh_tarif_scale.pr%type,
  p_smin      sh_tarif_scale.smin%type,
  p_smax      sh_tarif_scale.smax%type )
is
begin
  begin
     insert into sh_tarif_scale (ids, kod, sum_limit, sum_tarif, pr, smin, smax, kf)
     values (p_ids, p_kod, p_sum_limit, p_sum_tarif, p_pr, p_smin, p_smax, getglobaloption('GLB-MFO'));
  exception when dup_val_on_index then
     update sh_tarif_scale
        set sum_tarif = p_sum_tarif,
            pr        = p_pr,
            smin      = p_smin,
            smax      = p_smax
      where kod = p_kod
        and sum_limit = p_sum_limit;
  end;
end set_sh_tarif_scale;

-------------------------------------------------------------------------------
procedure del_sh_tarif_scale (
  p_ids       sh_tarif_scale.ids%type,
  p_kod       sh_tarif_scale.kod%type,
  p_sum_limit sh_tarif_scale.sum_limit%type )
is
begin
  delete from sh_tarif_scale
   where ids = p_ids
     and kod = p_kod
     and sum_limit = p_sum_limit;
end del_sh_tarif_scale;

end;
/
 show err;
 
PROMPT *** Create  grants  BARS_TARIF ***
grant EXECUTE                                                                on BARS_TARIF      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_TARIF      to TECH005;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_tarif.sql =========*** End *** 
 PROMPT ===================================================================================== 
 