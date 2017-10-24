
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kasz_w.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KASZ_W 
is
----- АРМ Контроль за підкріпленням кас (процедури для веба)

g_header_version  constant varchar2(64)  :=  'ver.1.0 22.12.2016';

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

---------

----- для населения бмд с возможностью закидывать переменную в CONDITION
procedure pop_kass_v
        (p_idm number,
        p_mode number,
        p_tip  number,
        p_dat  date
        );

----- вызов KASZ.UPD_SOS + алгоритм центуры
procedure KASZ_UPD_SOS_all;

-----вызов kasz.opl1 + алгоритм центуры
procedure opl1_ (p_refa    kas_zv.refa%type,
                                   p_sos     kas_zv.sos%type,
                                   p_s1      kas_zv.s1%type,
                                   p_k2      kas_zv.k2%type,
                                   p_k3      kas_zv.k3%type,
                                   p_k4      kas_zv.k4%type,
                                   p_idz     kas_zv.idz%type,
                                   p_ids     kas_zv.ids%type);

-------вызов kasz.upd_kasz + алгоритм центуры
procedure kass_upd (p_s1        kas_zv.s1%type,
                                      p_k2        kas_zv.k2%type,
                                      p_k3        kas_zv.k3%type,
                                      p_k4        kas_zv.k4%type,
                                      p_idz       kas_zv.idz%type,
                                      p_ids       kas_zv.ids%type,
                                      p_cena      number,
                                      p_branch    kas_zv.branch%type,
                                      p_vid       kas_zv.vid%type);
procedure lock1_idz (p_dat date) ;


END kasz_w;
/
CREATE OR REPLACE PACKAGE BODY BARS.KASZ_W 
IS
G_BODY_VERSION  CONSTANT VARCHAR2(64)  :='ver.1.0 22.12.2016';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
function header_version return varchar2 is
  begin
    return 'Package header DR '||G_HEADER_VERSION||'.';
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
function body_version return varchar2 is
  begin
    return 'Package body DR '||G_BODY_VERSION||'.';
  end body_version;

procedure pop_kass_v
        (p_idm number,
        p_mode number,
        p_tip  number,
        p_dat  date
        )
is
begin

if p_idm is not null
then
execute immediate 'truncate table kass_v_pop';
insert into kass_v_pop values(p_idm);
end if;
end pop_kass_v;

procedure KASZ_UPD_SOS_all

is
begin

for c in  (select * from V_KASM
          where sosb>=4)
loop
      KASZ.UPD_SOS(5,c.idz);
end loop;
end KASZ_UPD_SOS_all;

procedure opl1_ (p_refa    kas_zv.refa%type,
                                   p_sos     kas_zv.sos%type,
                                   p_s1      kas_zv.s1%type,
                                   p_k2      kas_zv.k2%type,
                                   p_k3      kas_zv.k3%type,
                                   p_k4      kas_zv.k4%type,
                                   p_idz     kas_zv.idz%type,
                                   p_ids     kas_zv.ids%type)
is
   l_dat   date;
   l_ref   number;
begin
   l_dat := gl.bd;

   if p_ids is null
   then
      raise_application_error (
         -20001,
         'Введіть системний номер сумки із довідника данного відділення');
   else
      if     p_refa is null
         and p_sos = 1
         and (p_s1 > 0 or p_k2 > 0 or p_k3 > 0 or p_k4 > 0)
      then
         kasz.opl1 (l_dat,
                    p_idz,
                    p_ids,
                    p_s1,
                    p_k2,
                    p_k3,
                    p_k4,
                    l_ref);
      end if;
   end if;

   commit;
end opl1_;

procedure kass_upd (p_s1        kas_zv.s1%type,
                                      p_k2        kas_zv.k2%type,
                                      p_k3        kas_zv.k3%type,
                                      p_k4        kas_zv.k4%type,
                                      p_idz       kas_zv.idz%type,
                                      p_ids       kas_zv.ids%type,
                                      p_cena      number,
                                      p_branch    kas_zv.branch%type,
                                      p_vid       kas_zv.vid%type)
is
   l_k     kas_zv.k2%type;
   l_s     kas_zv.s1%type;
   l_ids   kas_zv.ids%type;
begin
   if p_vid = 1
   then
      l_k := null;
      l_s := p_s1;
   elsif p_vid = 2
   then
      l_k := p_k2;
      l_s := p_k2 * p_cena;
   elsif p_vid = 3
   then
      l_k := p_k3;
      l_s := p_k3 * p_cena;
   elsif p_vid = 4
   then
      l_k := p_k4;
      l_s := p_k4 * p_cena;
   end if;

   select count (*)
     into l_ids
     from kas_u
    where     kas_u.d_clos is null
          and kas_u.ids in (select ids
                              from kas_bu
                             where kas_bu.branch = p_branch)
          and kas_u.ids = p_ids;

   if l_ids > 0 or p_ids is null
   then
      l_ids := p_ids;
   else
      raise_application_error (
         -20001,
         'Введіть системний номер сумки із довідника данного відділення');
   end if;


   kasz.upd_kasz (p_idz,
                  l_ids,
                  l_s,
                  l_k);

   commit;
end kass_upd;


procedure lock1_idz (p_dat date)
is
   l_idm   number;
begin
   select idm into l_idm from kass_v_pop;

   kasz.lock1 (l_idm, p_dat);
end lock1_idz;


begin
null;
end kasz_w;

/
 show err;
 
PROMPT *** Create  grants  KASZ_W ***
grant EXECUTE                                                                on KASZ_W          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KASZ_W          to DEB_REG;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kasz_w.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 