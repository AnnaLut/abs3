
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dr_ch.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DR_CH 
is
----- АРМ "Реєстр позичальників"
g_header_version  constant varchar2(64)  :=  'ver.1.0 28.11.2016';


----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

---------

----- "Заблокованi клiєнти (по файлах PF)"
procedure del_debreg_blk (
                         p_requestid debreg_query.requestid%type
                         );
procedure upd_debreg_blk (
                         p_requestid debreg_query.requestid%type,
                         p_errorcode debreg_query.errorcode%type,
                         p_okpo      debreg.okpo%type,
                         p_nmk       debreg.nmk%type,
                         p_adr       debreg.adr%type,
                         p_eventtype debreg_query.eventtype%type,
                         p_eventdate debreg_query.eventdate%type,
                         p_debnum    debreg.debnum%type,
                         p_kv        debreg.kv%type,
                         p_crdagrnum debreg.crdagrnum%type,
                         p_crddate   debreg.crddate%type,
                         p_summ      debreg.summ%type
                         );
-----"Запити/Вiдповiдi до ЦБД"
procedure del_debreg_query_c (
                         p_requestid debreg_query.requestid%type
                         );
procedure upd_debreg_query_c (
                         p_requestid debreg_query.requestid%type,
                         p_okpo      debreg_query.okpo%type,
                         p_nmk       debreg_query.nmk%type,
                         p_querytype debreg_query.querytype%type,
                         p_osn       debreg_query.osn%type ,
                         p_sos       debreg_query.sos%type
                         );
procedure ins_debreg_query_c (
                         p_okpo      debreg_query.okpo%type,
                         p_nmk       debreg_query.nmk%type,
                         p_querytype debreg_query.querytype%type,
                         p_osn       debreg_query.osn%type
                         ) ;

------"Реєстр боржникiв (iнф.про файли)"
--кнопка - Переформувати файл
procedure upd_zag_pf (
                         p_otm zag_pf.otm%type,
                         p_fn zag_pf.fn%type
                          ) ;

--для фильтра клиентов при населении
procedure pop_v_debreg_res_s (
                         p_custtype debreg_custtype.custtype%type
                         );

--для кнопок
procedure ins_debreg_res_s (
                         p_type debreg_type_ref.type%type
                          ) ;

-----Монiторинг/Поставка iнформацiї в ЦБД
procedure del_deb_reg_tmp (
                         p_acc deb_reg_tmp.acc%type
                         );
procedure upd_deb_reg_tmp (
                         p_adr       deb_reg_tmp.adr%type,
                         p_crddate   deb_reg_tmp.crddate%type,
                         p_crdagrnum deb_reg_tmp.crdagrnum%type,
                         p_debdate   deb_reg_tmp.debdate%type,
                         p_osn       deb_reg_tmp.osn%type,
                         p_nmk       deb_reg_tmp.nmk%type,
                         p_eventdate deb_reg_tmp.eventdate%type,
                         p_acc       deb_reg_tmp.acc%type,
                         p_sum_float deb_reg_tmp.sum%type,
                         p_sumd      deb_reg_tmp.sumd%type,
                         p_denom     tabval.denom%type,
                         p_eventtype deb_reg_tmp.eventtype%type
                         ) ;

procedure p_nsi_deb_reg_tmp(
                        p_acc          debreg.debnum%type,
                        p_adr          varchar2,
                        p_crdagrnum    varchar2,
                        p_crddate      debreg.crddate%type,
                        p_custtype     debreg.custtype%type,
                        p_kv           debreg.kv%type,
                        p_nmk          varchar2,
                        p_okpo         varchar2,
                        p_prinsider    debreg.prinsider%type,
                        p_summ         debreg.summ%type,
                        p_rezid        debreg.rezid%type,
                        p_debdate      debreg.debdate%type,
                        p_osn          varchar2,
                        p_eventdate    debreg_query.eventdate%type,
                        p_eventtype    debreg_query.eventtype%type,
                        p_demom        number ) ;

procedure upsert_debreg_res_s(p_int int);

------Ручне введення інформації в ЦБД

procedure set_ins_deb_reg_man(
                        p_par             varchar2,
                        p_eventtype       deb_reg_man.eventtype%type ,
                        p_rezid           deb_reg_man.rezid%type default null,
                        p_okpo            deb_reg_man.okpo%type default null,
                        p_adr             deb_reg_man.adr%type default null,
                        p_kv              deb_reg_man.kv%type default null,
                        p_prinsider       deb_reg_man.prinsider%type default null,
                        p_debdate         deb_reg_man.debdate%type default null,
                        p_nmk             deb_reg_man.nmk%type default null,
                        p_sum             deb_reg_man.sum%type default null,
                        p_day             deb_reg_man.day%type default null,
                        p_crdagrnum       deb_reg_man.crdagrnum%type default null,
                        p_crddate         deb_reg_man.crddate%type default null,
                        p_custtype        deb_reg_man.custtype%type default null,
                        p_acc             deb_reg_man.acc%type default null,
                        p_osn             deb_reg_man.osn%type default null,
                        p_eventdate       deb_reg_man.eventdate%type  default null
                                );
procedure p_nsi_deb_reg_man(
                        p_acc          debreg.debnum%type,
                        p_adr          varchar2,
                        p_crdagrnum    varchar2,
                        p_crddate      debreg.crddate%type,
                        p_custtype     debreg.custtype%type,
                        p_kv           debreg.kv%type,
                        p_nmk          varchar2,
                        p_okpo         varchar2,
                        p_prinsider    debreg.prinsider%type,
                        p_summ         debreg.summ%type,
                        p_rezid        debreg.rezid%type,
                        p_debdate      debreg.debdate%type,
                        p_osn          varchar2,
                        p_eventdate    debreg_query.eventdate%type,
                        p_eventtype    debreg_query.eventtype%type
                        )          ;

END dr_ch;
/
CREATE OR REPLACE PACKAGE BODY BARS.DR_CH 
IS
G_BODY_VERSION  CONSTANT VARCHAR2(64)  :='ver.1.0 28.11.2016';


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


procedure del_debreg_blk (
  p_requestid debreg_query.requestid%type
  )
is
begin
update debreg_query
   set errorcode='-1'
 where phaseid='F'
   and requestid=p_requestid;
commit;
end del_debreg_blk;


procedure upd_debreg_blk (
 p_requestid debreg_query.requestid%type,
 p_errorcode debreg_query.errorcode%type,
 p_okpo      debreg.okpo%type,
 p_nmk       debreg.nmk%type,
 p_adr       debreg.adr%type,
 p_eventtype debreg_query.eventtype%type,
 p_eventdate debreg_query.eventdate%type,
 p_debnum    debreg.debnum%type,
 p_kv        debreg.kv%type,
 p_crdagrnum debreg.crdagrnum%type,
 p_crddate   debreg.crddate%type,
 p_summ      debreg.summ%type
 )
is
begin
update debreg
   set okpo     = p_okpo,
       nmk      = p_nmk,
       adr      = p_adr,
       kv       = p_kv,
       crdagrnum= p_crdagrnum,
       crddate  = p_crddate,
       summ     = p_summ
 where debnum   = p_debnum;
update debreg_query
   set errorcode = p_errorcode,
       eventtype = p_eventtype,
       eventdate = p_eventdate
 where debnum    = p_debnum
   and requestid = p_requestid;
commit;
end upd_debreg_blk;




procedure del_debreg_query_c (
 p_requestid debreg_query.requestid%type
 )
is
begin

delete from debreg_query
where requestid=p_requestid
  and phaseid='C';

commit;
end del_debreg_query_c;

procedure upd_debreg_query_c (
 p_requestid debreg_query.requestid%type,
 p_okpo      debreg_query.okpo%type,
 p_nmk       debreg_query.nmk%type,
 p_querytype debreg_query.querytype%type,
 p_osn       debreg_query.osn%type ,
 p_sos       debreg_query.sos%type
 )
is
begin


update debreg_query
   set nmk       = p_nmk,
       okpo      = p_okpo,
       querytype = p_querytype,
       osn       = p_osn
 where requestid = p_requestid
   and sos = 0
   and phaseid = 'C';

commit;

end upd_debreg_query_c;


procedure ins_debreg_query_c (
 p_okpo      debreg_query.okpo%type,
 p_nmk       debreg_query.nmk%type,
 p_querytype debreg_query.querytype%type,
 p_osn       debreg_query.osn%type
 )
is
begin

insert into debreg_query (requestid,sos,phaseid,nmk,okpo,querytype,osn)
values (0,0,'C',p_nmk,p_okpo,p_querytype,p_osn);

commit;

end ins_debreg_query_c  ;


procedure upd_zag_pf (
  p_otm zag_pf.otm%type,
  p_fn zag_pf.fn%type
  )
is
begin
if p_otm=3
then
    update zag_pf
       set otm = 1
     where fn = p_fn;
else
    raise_application_error ( -20001, 'Для виконання процедури стан файлу повинен дорівнювати - 3');
end if;
commit;
end upd_zag_pf;

procedure pop_v_debreg_res_s (
    p_custtype debreg_custtype.custtype%type
    )
is
begin
execute immediate '
truncate table  bars.debreg_custtype_tmp';

if p_custtype='2 - Всі клієнти'
then
    insert into debreg_custtype_tmp values(0,'Фізичні особи');
    insert into debreg_custtype_tmp values(1,'Юридичні особи і Банки');
elsif p_custtype='0 - Фізичні особи'
then
    insert into debreg_custtype_tmp values(0,'Фізичні особи');
elsif p_custtype='1 - Юридичні особи і Банки'
then
    insert into debreg_custtype_tmp values(1,'Юридичні особи і Банки');
else
    insert into debreg_custtype_tmp values(0,'Фізичні особи');
    insert into debreg_custtype_tmp values(1,'Юридичні особи і Банки');
end if;
commit;
end pop_v_debreg_res_s;


 procedure ins_debreg_res_s (
    p_type debreg_type_ref.type%type
    )
is
begin
if p_type='Тільки непогашені заборгованості'
then
insert into debreg_query (requestid,querytype, phaseid) values (0,1,'Q');
elsif p_type='Всі заборгованості'
then
insert into debreg_query (requestid,querytype, phaseid) values (0,2,'Q');
elsif p_type='Вилучити всю "нашу" інформацію з ЦБД'
then
insert into debreg_query (requestid, eventtype, eventdate, phaseid ) values (0,4,sysdate,'R');
elsif p_type='Погасити всю "нашу" заборгованість в ЦБД'
then
insert into debreg_query (requestid, eventtype, eventdate, phaseid ) values (0,3,sysdate,'R');
end if;
commit;
end ins_debreg_res_s;



procedure del_deb_reg_tmp(
 p_acc deb_reg_tmp.acc%type
 )
is
begin

delete from deb_reg_tmp
where acc=p_acc;

commit;
end del_deb_reg_tmp;


procedure upd_deb_reg_tmp (
 p_adr       deb_reg_tmp.adr%type,
 p_crddate   deb_reg_tmp.crddate%type,
 p_crdagrnum deb_reg_tmp.crdagrnum%type,
 p_debdate   deb_reg_tmp.debdate%type,
 p_osn       deb_reg_tmp.osn%type,
 p_nmk       deb_reg_tmp.nmk%type,
 p_eventdate deb_reg_tmp.eventdate%type,
 p_acc       deb_reg_tmp.acc%type,
 p_sum_float deb_reg_tmp.sum%type,
 p_sumd      deb_reg_tmp.sumd%type,
 p_denom     tabval.denom%type,
 p_eventtype deb_reg_tmp.eventtype%type
 )
is
begin

if p_debdate>gl.bd
    then raise_application_error ( -20001, 'Невірна дата виникнення боргу');
end if;

update deb_reg_tmp
   set
       adr       = p_adr,
       crddate   = p_crddate,
       crdagrnum = p_crdagrnum,
       debdate   = p_debdate,
       day       = gl.bd-p_debdate,
       osn       = p_osn,
       nmk       = p_nmk,
       eventdate = p_eventdate,
       sum       = to_number ( p_sum_float) * p_denom,
       sumd      = to_number ( p_sumd) * 100

 where acc       = p_acc;

update deb_reg_tmp
   set eventtype    = p_eventtype
 where acc          = p_acc
   and p_eventtype  = 4;

commit;

end upd_deb_reg_tmp;


procedure p_nsi_deb_reg_tmp(
    p_acc          debreg.debnum%type,
    p_adr          varchar2,
    p_crdagrnum    varchar2,
    p_crddate      debreg.crddate%type,
    p_custtype     debreg.custtype%type,
    p_kv           debreg.kv%type,
    p_nmk          varchar2,
    p_okpo         varchar2,
    p_prinsider    debreg.prinsider%type,
    p_summ         debreg.summ%type,
    p_rezid        debreg.rezid%type,
    p_debdate      debreg.debdate%type,
    p_osn          varchar2,
    p_eventdate    debreg_query.eventdate%type,
    p_eventtype    debreg_query.eventtype%type,
    p_demom        number )
is
begin

dr.refresh_debreg(
               p_acc,
               p_adr,
               p_crdagrnum,
               p_crddate,
               p_custtype,
               p_kv,
               p_nmk,
               p_okpo,
               p_prinsider,
               p_summ*p_demom,
               p_rezid,
               p_debdate,
               p_osn);


insert into debreg_query (
              requestid,
              debnum,
              eventdate,
              eventtype,
              phaseid)
     values ( 0,
              p_acc,
              p_eventdate,
              p_eventtype,
             'F');

dr.pf_name;
commit;

end p_nsi_deb_reg_tmp;

procedure upsert_debreg_res_s(p_int int)
is
begin
insert into debreg_res_s (debnum,
                          adr,
                          crdagrnum,
                          crddate,
                          custtype,
                          kv,
                          nmk,
                          okpo,
                          prinsider,
                          summ,
                          rezid,
                          debdate,
                          eventtype,
                          eventdate,
                          regdatetime,
                          filename,
                          ilnum,
                          osn)
   select debreg.debnum,
          adr,
          crdagrnum,
          crddate,
          custtype,
          kv,
          debreg.nmk,
          debreg.okpo,
          prinsider,
          summ,
          rezid,
          debdate,
          eventtype,
          eventdate,
          bankdate_g,
          debreg_query.filename,
          debreg_query.ilnum,
          debreg.osn
     from debreg, debreg_query
    where     debreg.debnum = debreg_query.debnum
          and debreg.debnum not in (select debnum from debreg_res_s);
/*
update debreg_res_s s
   set (adr,
        crdagrnum,
        crddate,
        custtype,
        kv,
        nmk,
        okpo,
        prinsider,
        summ,
        rezid,
        debdate,
        eventtype,
        eventdate,
        regdatetime,
        filename,
        ilnum,
        osn) =
          (select adr,
                  crdagrnum,
                  crddate,
                  custtype,
                  kv,
                  d.nmk,
                  d.okpo,
                  prinsider,
                  summ,
                  rezid,
                  debdate,
                  eventtype,
                  eventdate,
                  bankdate_g,
                  q.filename,
                  q.ilnum,
                  d.osn
             from debreg d, debreg_query q
            where     d.debnum = q.debnum
                  and d.debnum = s.debnum
                  and (q.requestid, q.eventdate) =
                         (  select requestid, max (eventdate)
                              from debreg_query qq
                             where q.debnum = qq.debnum
                          group by requestid))
 where debnum in (select debnum from debreg_res_s);
 */
 commit;

 end upsert_debreg_res_s;

procedure set_ins_deb_reg_man(
            p_par             varchar2,
            p_eventtype       deb_reg_man.eventtype%type ,
            p_rezid           deb_reg_man.rezid%type default null,
            p_okpo            deb_reg_man.okpo%type default null,
            p_adr             deb_reg_man.adr%type default null,
            p_kv              deb_reg_man.kv%type default null,
            p_prinsider       deb_reg_man.prinsider%type default null,
            p_debdate         deb_reg_man.debdate%type default null,
            p_nmk             deb_reg_man.nmk%type default null,
            p_sum             deb_reg_man.sum%type default null,
            p_day             deb_reg_man.day%type default null,
            p_crdagrnum       deb_reg_man.crdagrnum%type default null,
            p_crddate         deb_reg_man.crddate%type default null,
            p_custtype        deb_reg_man.custtype%type default null,
            p_acc             deb_reg_man.acc%type default null,
            p_osn             deb_reg_man.osn%type default null,
            p_eventdate       deb_reg_man.eventdate%type  default null
                                )
is
begin

if p_par='DELETE'
then
delete from deb_reg_man where acc=p_acc and acc <0;
elsif p_par='INSERT'
then
insert into deb_reg_man (eventtype,
                         rezid,
                         okpo,
                         adr,
                         kv,
                         prinsider,
                         debdate,
                         nmk,
                         sum,
                         day,
                         crdagrnum,
                         crddate,
                         custtype,
                         acc,
                         osn,
                         eventdate)
     values (1,
             p_rezid,
             p_okpo,
             p_adr,
             p_kv,
             p_prinsider,
             p_debdate,
             p_nmk,
             p_sum*100,
             p_day,
             p_crdagrnum,
             p_crddate,
             p_custtype,
             p_acc,
             p_osn,
             p_eventdate);
elsif p_par='UPDATE'
then

update deb_reg_man
   set eventtype    = p_eventtype,
       rezid        = p_rezid,
       okpo         = p_okpo,
       adr          = p_adr,
       kv           = p_kv,
       prinsider    = p_prinsider,
       debdate      = p_debdate,
       nmk          = p_nmk,
       sum          = p_sum*100,
       day          = p_day,
       crdagrnum    = p_crdagrnum,
       crddate      = p_crddate,
       custtype     = p_custtype,
       osn          = p_osn,
       eventdate    = p_eventdate
where acc = p_acc;

end if;
commit;
end set_ins_deb_reg_man;


procedure p_nsi_deb_reg_man(
    p_acc          debreg.debnum%type,
    p_adr          varchar2,
    p_crdagrnum    varchar2,
    p_crddate      debreg.crddate%type,
    p_custtype     debreg.custtype%type,
    p_kv           debreg.kv%type,
    p_nmk          varchar2,
    p_okpo         varchar2,
    p_prinsider    debreg.prinsider%type,
    p_summ         debreg.summ%type,
    p_rezid        debreg.rezid%type,
    p_debdate      debreg.debdate%type,
    p_osn          varchar2,
    p_eventdate    debreg_query.eventdate%type,
    p_eventtype    debreg_query.eventtype%type
    )
is
begin

dr.refresh_debreg(
               p_acc,
               p_adr,
               p_crdagrnum,
               p_crddate,
               p_custtype,
               p_kv,
               p_nmk,
               p_okpo,
               p_prinsider,
               p_summ*100,
               p_rezid,
               p_debdate,
               p_osn);


insert into debreg_query (
              requestid,
              debnum,
              eventdate,
              eventtype,
              phaseid)
     values ( 0,
              p_acc,
              p_eventdate,
              p_eventtype,
             'F');

commit;

end p_nsi_deb_reg_man;

begin
null;
end dr_ch;

/
 show err;
 
PROMPT *** Create  grants  DR_CH ***
grant EXECUTE                                                                on DR_CH           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DR_CH           to DEB_REG;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dr_ch.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 