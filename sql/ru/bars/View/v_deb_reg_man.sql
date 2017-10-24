create or replace force view bars.v_deb_reg_man
(
   eventtype,
   acc,
   okpo,
   nmk,
   adr,
   custtype,
   prinsider,
   kv,
   crdagrnum,
   crddate,
   sum,
   debdate,
   day,
   rezid,
   sumd,
   osn,
   eventdate
)
as
     select eventtype,
            acc,
            okpo,
            nmk,
            adr,
            custtype,
            prinsider,
            kv,
            crdagrnum,
            crddate,
            sum,
            debdate,
            day,
            rezid,
            sum / 100 sumd,
            osn,
            eventdate
       from deb_reg_man
   order by custtype, okpo;



GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.v_deb_reg_man TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.v_deb_reg_man TO DEB_REG;
/