

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_VOB96.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_VOB96 ***

  CREATE OR REPLACE PROCEDURE BARS.P_VOB96 (IDD_ int, isp_ int, dat1_ date, dat2_ date ) is
  ID_    NUMBER (24);
  kol_   int;
 ern  CONSTANT POSITIVE := 021; erm  VARCHAR2(80); err  EXCEPTION;
begin
delete from tmp_vob96 where id=idd_;
   deb.trace(ern, '1.1=IDD_',IDD_ );
ID_:=IDD_;

for k in (  select distinct
            o.ref           REF,
            m.NAME_PLAIN    VDAT,
            pa.fdat         FDAT,  o.nd        ND,
            pa.nls        NLSA,  pa.kv        KVA,
            pa.nms        NAMA,  pb.nls       NLSB,
            pb.kv           KVB,   pb.nms    NAMB,
            pa.s    SUMM,   pa.sq sq,
            pa.nazn    NAZN,
            to_char(o.userid) ISP,
            substr(to_char(o.vdat,'dd-mm-yyyy'),-4,4)   JEAR,substr(o.tt,1,3) tt
            from oper o, opl pa ,opl pb,meta_month m
            where m.n=to_number(substr(TO_CHAR(vDAT,'dd-mm-yyyy'),4,2)) and
                  o.ref=pa.ref and o.vob in (96,99)
                  and o.sos=5
                  and pa.fdat>=dat1_ and pa.fdat<=dat2_
                  and pa.stmt=pb.stmt and pa.fdat=pb.fdat
                  and pa.dk=0 and pb.dk=1
                  and (isp_ = 0 and o.branch like sys_context('bars_context', 'user_branch_mask')) or o.userid = isp_)
loop
     insert into tmp_vob96 (ID,REF,VDAT,FDAT,ND,NLSA,KVA,NAMA,NLSB,KVB,NAMB,
                            SUMM,SQ,NAZN,ISP,JEAR,TT,CC,D6,K6,D7,K7)
            VALUES (ID_,k.REF,k.VDAT,k.FDAT,k.ND,k.NLSA,k.KVA,k.NAMA,k.NLSB,
                        k.KVB,k.NAMB,
                       k.SUMM,k.SQ,k.NAZN,k.ISP,k.JEAR,k.TT,0,0,0,0,0);
end loop;
for n in (
          select sum(sq) d6 from tmp_vob96 where isp>=isp_
          and isp<=decode(isp_,0,100000,isp_) and id=idd_
          and substr(nlsa,1,1)='6' group by substr(nlsa,1,1))
loop
       update tmp_vob96 set d6=n.d6 where id=idd_;
end loop;
for n in (
          select sum(sq) k6 from tmp_vob96 where isp>=isp_
          and isp<=decode(isp_,0,100000,isp_) and id=idd_
          and substr(nlsb,1,1)='6' group by substr(nlsb,1,1))
loop
       update tmp_vob96 set k6=n.k6 where id=idd_;
end loop;
FOR N IN (
          SELECT SUM(SQ) d7 FROM TMP_VOB96 WHERE ISP>=ISP_
          AND ISP<=DECODE(ISP_,0,100000,ISP_) AND ID=IDD_
          AND SUBSTR(NLSA,1,1)='7' GROUP BY SUBSTR(NLSA,1,1))
LOOP
       UPDATE TMP_VOB96 SET d7=N.d7 WHERE ID=IDD_;
END LOOP;
for n in (
          select sum(sq) k7 from tmp_vob96 where isp>=isp_
          and isp<=decode(isp_,0,100000,isp_) and id=idd_
          and substr(nlsb,1,1)='7' group by substr(nlsb,1,1))
loop
       update tmp_vob96 set k7=n.k7 where id=idd_;
end loop;

for n in (
select distinct userid,count(*) kol
       from oper  where ref in (select distinct ref from tmp_vob96
       where id=idd_ and isp>=isp_
                  and isp<=decode(isp_,0,100000,isp_)) group by userid)
loop
   update tmp_vob96 set cc=n.kol where id=idd_ and isp=n.userid;
end loop;
end  P_vob96;
/
show err;

PROMPT *** Create  grants  P_VOB96 ***
grant EXECUTE                                                                on P_VOB96         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_VOB96         to RPBN001;
grant EXECUTE                                                                on P_VOB96         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_VOB96.sql =========*** End *** =
PROMPT ===================================================================================== 
