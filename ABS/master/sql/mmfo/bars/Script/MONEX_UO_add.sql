begin
    bc.go('300465');
    update MONEX_UO z set rnk = (select max(rnk) from customer where okpo = z.okpo and date_off is null) ;
 commit ;
end;

/

declare  p4_ int ; nls_ varchar2 (15) ;
begin bc.go('300465');
  update monex_mv_uo set OB22_2909 = trim (OB22_2909), OB22_KOM = trim (OB22_KOM);
  update monex_mv_uo set OB22_2809 = OB22_2909 ;
  for  x in (select a.* from accounts a, monex_mv_uo m  where a.kv = 980 and  a.nls= m.OB22_2909 and m.OB22_KOM = m.OB22_2909 )
  loop nls_ := Get_NLS( p_KV =>x.kv,  p_B4 =>x.NBS )  ;
       x.nms := Substr( x.NMS|| '(комісія)', 1, 70 );
       op_reg_ex( mod_=>99, p1_=>0, p2_=>0, p3_=>x.grp, p4_=>p4_, rnk_=>x.rnk, nls_=>nls_, kv_=>x.kv, nms_=>x.nms, tip_=>'ODB', isp_=>x.isp, accR_=>x.acc, tobo_ =>x.branch );
       Accreg.setAccountSParam(x.Acc, 'OB22', x.ob22 );
       update monex_mv_uo set  OB22_KOM = NLS_ where OB22_2909 = x.nls ;
  end loop;
  bc.go('/');
  commit ;
end ;

/

