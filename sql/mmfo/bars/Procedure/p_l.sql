

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_L.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_L ***

  CREATE OR REPLACE PROCEDURE BARS.P_L (id_ SMALLINT, p_s DATE) IS

--==============================================================
-- Module : SBB
-- Author : MOM
-- Date   : 18.10.2007
--==============================================================
-- Процедура отбора остатков для расширенной технической выписки
--==============================================================

  acc_     SMALLINT;
  fdat_    DATE;
  ostf_    DECIMAL(24);
  ostq_    DECIMAL(24);
  nls_     varchar2(15);
  kv_      SMALLINT;
  amfo_    varchar2(12);
  id_kli_  varchar2(2);
  okpo_    varchar2(15);
  nmk_     varchar2(80);
  dos_     DECIMAL(24);
  kos_     DECIMAL(24);
  dosq_    DECIMAL(24);
  kosq_    DECIMAL(24);

CURSOR ACC1 IS
       SELECT a.nls,a.kv,a.acc,c.okpo,c.nmk,o.id_kli
       FROM   accounts a, cust_acc cu, customer c, okpo_afd o
       WHERE  cu.acc=a.acc and cu.rnk=c.rnk and c.okpo=o.okpo and
              a.daos<=p_s and (a.dazs is null or a.dazs>p_s) and
              substr(a.nls,1,4) in (select nbs from tv_nbs) and
              a.tip not in
              ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00');

BEGIN
delete from tmp_tvost where id=id_;
begin
   select TO_CHAR(f_ourmfo)
   into amfo_
   from dual;
exception when no_data_found then
   amfo_:='300465';
end;

OPEN ACC1;
LOOP
   FETCH ACC1 INTO nls_,kv_,acc_,okpo_,nmk_,id_kli_;
   EXIT WHEN ACC1%NOTFOUND;

   begin
      SELECT s.fdat,s.dos,s.kos,nvl(s.ostf,0)-nvl(s.dos,0)+nvl(s.kos,0)
      INTO   fdat_,dos_,kos_,ostf_
      FROM   saldoa s
      WHERE  s.fdat=p_s and s.acc=acc_;
   EXCEPTION when no_data_found then
      fdat_ := p_s;
      dos_  := 0;
      kos_  := 0;
      ostf_ := fost(acc_,p_s);
   end;

   if kv_<>980 then
      begin
         SELECT s.dos,s.kos,nvl(s.ostf,0)-nvl(s.dos,0)+nvl(s.kos,0),s.fdat
         INTO   dosq_,kosq_,ostq_,fdat_
         FROM   saldob s
         WHERE  s.fdat=p_s and s.acc=acc_;
      EXCEPTION when no_data_found then
         fdat_ := p_s;
--       dosq_ := gl.p_icurval(kv_,dos_, p_s);
--       kosq_ := gl.p_icurval(kv_,kos_, p_s);
--       ostq_ := gl.p_icurval(kv_,ostf_,p_s);
         dosq_ := 0;
         kosq_ := 0;
         ostq_ := fostq(acc_,p_s);
      end;

      if ostf_ is null then
         ostf_ := gl.p_ncurval(kv_,ostq_,p_s);
      else
--       надо вычислить еще дополнительно в обороты переоценку
         if gl.p_ncurval(kv_,ostq_,p_s)-ostf_>0 then
--          здесь
            dosq_ := dosq_+
                     gl.p_icurval(kv_,gl.p_ncurval(kv_,ostq_,p_s)-ostf_,p_s);
         else -- if gl.p_ncurval(kv_,ostq_,p_s)-ostf_<=0
--          и здесь
            kosq_ := kosq_ +
                     gl.p_icurval(kv_,ostf_-gl.p_ncurval(kv_,ostq_,p_s),p_s);
         end if;
      end if;

   else
      dosq_ := dos_;
      kosq_ := kos_;
      ostq_ := ostf_;
      fdat_ := p_s;
   end if;

   insert
   into tmp_tvost (id,
                   datod,
                   mfo,
                   nls,
                   kv,
                   dos,
                   dosq,
                   kos,
                   kosq,
                   ostf,
                   ostq,
                   okpo,
                   nmk,
                   id_kli)
   values         (id_,
                   fdat_,
                   amfo_,
                   nls_,
                   kv_,
                   dos_,
                   dosq_,
                   kos_,
                   kosq_,
                   ostf_,
                   ostq_,
                   okpo_,
                   nmk_,
                   id_kli_);
END LOOP;
CLOSE ACC1;

END p_l;
/
show err;

PROMPT *** Create  grants  PUL ***
grant EXECUTE                                                                on PUL             to ABS_ADMIN;
grant EXECUTE                                                                on PUL             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PUL             to FINMON01;
grant EXECUTE                                                                on PUL             to RCC_DEAL;
grant EXECUTE                                                                on PUL             to START1;
grant EXECUTE                                                                on PUL             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_L.sql =========*** End *** =====
PROMPT ===================================================================================== 
