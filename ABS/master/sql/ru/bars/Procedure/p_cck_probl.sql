

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CCK_PROBL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CCK_PROBL ***

  CREATE OR REPLACE PROCEDURE BARS.P_CCK_PROBL 
(
 p_dat01 date,  -- �������� ����
 p_mode int    -- =0 ��� , =1 - ��, =11 ��
 )
Is

str_z TMP_CC_DEAL_PROBL%rowtype;
p_dat1  varchar2(10);

begin

EXECUTE IMMEDIATE 'truncate table TMP_CC_DEAL_PROBL';

p_dat1:=to_char(p_dat01,'dd/mm/yyyy');

 for k in (

           select  d.nd,
           d.kf , --  ��� �������� ����� (���),  �� ������ ��� ����������� �������������
           d.branch , -- � �������� (����), �� ������� ������������� ���������� ������� (10015/00000)
           c.okpo ,  -- ������������ ����� ������� ������ �������� ������� - ������� �����
           c.nmk,  -- ϲ� ������������ - ������� �����
           d.cc_id, -- ����� �������� �����
           d.sdate, -- ���� ��������� �������� �����
           D.WDATE,  -- ����� ���� ��������� ������� ����� � �������� ������ � ����
           d.prod,  -- ��� ���������� �������� (� ���. ���. ��22)
           a8.kv  kv, -- ������, � ��� ����������� ������ �� ����� ���� (����� � �������������� KL_R030)
           d.kat23 kat_j, --  �������_� �����_ �������� ������_�
           null dat_sp_nobal,  --  ���� �������� � ������ �������������_ �� �������� (�� ������������_ �������)
           to_date(nt.txt,'dd/mm/yyyy' ) dat_p_kk -- ���� �������� ������� ���������� �� ��
           from cc_deal d, customer c, nd_txt nt, cc_add da, accounts a8
          where d.nd=nt.nd and nt.tag='NOHOP' and nt.txt is not null
                and d.rnk=c.rnk
                and d.nd=da.nd
                and a8.nls like '8999_'||trim(to_char(d.nd))
                and (d.sos<14 or (d.sos>=14 and a8.dazs is not null and a8.dazs>last_day( add_months(p_dat01,-1) )+1))
                and d.vidd in (11,12,13)
          order by d.nd
/*
(tip_<=2 and vidd in (1,2,3)   or
                 tip_=3 and vidd in (11,12,13) )
            AND d.sos >0 AND d.sos<14
*/

          )
 loop
           str_z.nd               :=  k.nd ;                  --  �������� ��
           str_z.kf                :=  k.kf ;                  --  ��� �������� ����� (���),  �� ������ ��� ����������� �������������
           str_z.branch         :=  k.branch ;           -- � �������� (����), �� ������� ������������� ���������� ������� (10015/00000)
           str_z.okpo            :=  k.okpo;               -- ������������ ����� ������� ������ �������� ������� - ������� �����
           str_z.nmk             :=  k.nmk;               -- ϲ� ������������ - ������� �����
           str_z.cc_id            :=  k.cc_id ;             -- ����� �������� �����
           str_z.sdate            :=  k.sdate;             -- ���� ��������� �������� �����
           str_z.WDATE         :=  k.wdate;            -- ����� ���� ��������� ������� ����� � �������� ������ � ����
           str_z.prod             :=  k.prod;               -- ��� ���������� �������� (� ���. ���. ��22)
           str_z.kv                 :=  k.kv;                  -- ������, � ��� ����������� ������ �� ����� ���� (����� � �������������� KL_R030)
           str_z.kat_j             :=  k.kat_j;              --  �������_� �����_ �������� ������_�
           str_z.dat_sp_nobal :=  k.dat_sp_nobal;  --  ���� �������� � ������ �������������_ �� �������� (�� ������������_ �������)
           str_z.dat_p_kk        :=  k.dat_p_kk;        -- ���� �������� ������� ���������� �� ��

           select  abs(sum(
           gl.p_icurval( na2.kv,fost(na2.acc, to_date('01/01'||substr( p_Dat1 ,7,4),'dd/mm/yyyy')-1),to_date('01/01'||substr(p_Dat1,7,4),'dd/mm/yyyy')-1))/100) into str_z.st_eqv_ng -- ���� �������������_ �� �������� �� ������� ����,���. ���.
           from accounts na2, nd_acc nna2 where na2.acc=nna2.acc and na2.tip in ('SS ','SP ','SL ') and nna2.nd=k.nd;   -- ���� �������������_ �� �������� �� ������� ����,���. ���.

           if  (sql%rowcount = 0) then
                str_z.st_eqv_ng:=0;
           end if;

           if  str_z.st_eqv_ng=0 then
               str_z.st_nom_ng:=0; -- ���� �������������_ �� �������� �� ������� ����, ���_���
           else
               str_z.st_nom_ng:=gl.p_ncurval(k.kv,str_z.st_eqv_ng,to_date('01/01'||substr(p_Dat1,7,4),'dd/mm/yyyy')-1);
           end if;



           select  abs(sum(
           gl.p_icurval( na2.kv,fost(na2.acc, to_date('01/01'||substr( p_Dat1 ,7,4),'dd/mm/yyyy')-1),to_date('01/01'||substr(p_Dat1,7,4),'dd/mm/yyyy')-1))/100) into str_z.sp_eqv_ng -- ���� �������������_ �� ���������� �� ������� ����, ���. ���.
           from accounts na2, nd_acc nna2 where na2.acc=nna2.acc and na2.tip in ('SN ','SPN','SLN') and nna2.nd=k.nd;   -- ���� �������������_ �� ���������� �� ������� ����, ���. ���.

           if  (sql%rowcount = 0) then
                str_z.sp_eqv_ng:=0;
           end if;

           if  str_z.sp_eqv_ng=0 then
               str_z.sp_nom_ng:=0; -- ���� �������������_ �� �������� �� ������� ����, ���_���
           else
               str_z.sp_nom_ng:=gl.p_ncurval(k.kv,str_z.sp_eqv_ng,to_date('01/01'||substr(p_Dat1,7,4),'dd/mm/yyyy')-1);
           end if;


          select  abs(sum(
           gl.p_icurval( na2.kv,fost(na2.acc, to_date( p_Dat1,'dd/mm/yyyy')-1),to_date(p_Dat1,'dd/mm/yyyy')-1))/100) into str_z.st_eqv_od -- ���� �������������_ �� �������� �� ��_��� ����,���. ���.
           from accounts na2, nd_acc nna2 where na2.acc=nna2.acc and na2.tip in ('SS ','SP ','SL ') and nna2.nd=k.nd;   -- ���� �������������_ �� �������� �� ��_��� ����,���. ���.

           if  (sql%rowcount = 0) then
                str_z.st_eqv_od:=0;
           end if;

           if  str_z.st_eqv_od=0 then
               str_z.st_nom_od:=0; -- -- ���� �������������_ �� �������� �� ��_��� ����, ���_���
           else
               str_z.st_nom_od:=gl.p_ncurval(k.kv,str_z.st_eqv_od,to_date(p_Dat1,'dd/mm/yyyy')-1);
           end if;



           select  abs(sum(
           gl.p_icurval( na2.kv,fost(na2.acc, to_date( p_Dat1 ,'dd/mm/yyyy')-1),to_date(p_Dat1,'dd/mm/yyyy')-1))/100) into str_z.sp_eqv_od -- ���� �������������_ �� ���������� �� ��_��� ����,���. ���.
           from accounts na2, nd_acc nna2 where na2.acc=nna2.acc and na2.tip in ('SN ','SPN','SLN') and nna2.nd=k.nd;   -- ���� �������������_ �� ���������� �� ��_��� ����,���. ���.

           if  (sql%rowcount = 0) then
                str_z.sp_eqv_od:=0;
           end if;

           if  str_z.sp_eqv_od=0 then
               str_z.sp_nom_od:=0; -- ���� �������������_ �� ���������� �� ��_��� ����, ���_���
           else
               str_z.sp_nom_od:=gl.p_ncurval(k.kv,str_z.sp_eqv_od,to_date(p_Dat1,'dd/mm/yyyy'));
           end if;


         select min(fdat) into str_z.dat_max_zb -- ���� �_�������� ������� ���� �������/������� �������/����������� �����_� �� ������� ����������� �������������_, ��� �� ����_����� ����_� ������������ ( ��_��� ��������� �� _�����������_��_� �_������_ ������_�)
         from saldoa sas, accounts ssa, nd_acc sna where sas.acc=ssa.acc and sna.acc=ssa.acc and SSA.TIP in ('SP ','SPN','SL ','SLN') and SAS.OSTF=0 and sas.dos<>0 and sna.nd=k.nd ; --),to_date(cck_app.get_nd_txt(d.nd,'DATSP'),'dd/mm/yyyy'),to_date(cck_app.get_nd_txt(d.nd,'DASPN'),'dd/mm/yyyy')

          if  (sql%rowcount = 0) then
                str_z.dat_max_zb:=null ;  -- ���� �_�������� ������� ���� �������/������� �������/����������� �����_� �� ������� ����������� �������������_, ��� �� ����_����� ����_� ������������ ( ��_��� ��������� �� _�����������_��_� �_������_ ������_�)
           end if;


         SELECT greatest(NVL(SUM(gl.p_Icurval(at2.kv,st2.kos,to_date(p_Dat1,'dd/mm/yyyy'))),0) - --1
                    NVL(SUM(gl.p_Icurval(at2.kv,decode(at2.tip,'SP ',st2.DOS,0),to_date(p_Dat1,'dd/mm/yyyy'))),0) --
                  ,0) /100 into str_z.pog_ss_eqv -- ���� ��������� ��������� ����� �� �_���� �� ��_��� ����, ���. ���.
                  FROM accounts at2, nd_acc nt2,saldoa st2
                  WHERE nt2.nd=k.ND and nt2.acc=at2.acc and at2.tip in ('SS ','SP ')
                              and st2.acc=at2.acc
                              and st2.fdat>add_months(to_date(p_Dat1,'dd/mm/yyyy'),-1)
                               and st2.fdat<=to_date(p_Dat1,'dd/mm/yyyy');


         if  (sql%rowcount = 0) then
                str_z.pog_ss_eqv := 0 ;  -- -- ���� ��������� ��������� ����� �� �_���� �� ��_��� ����, ���. ���.
           end if;

           if  str_z.pog_ss_eqv =0 then
               str_z.pog_ss_nom :=0; -- ���� ��������� ��������� ����� �� �_���� �� ��_��� ����, ���_���
           else
               str_z.pog_ss_nom:=gl.p_ncurval(k.kv,str_z.pog_ss_eqv,to_date(p_Dat1,'dd/mm/yyyy'));
           end if;


         SELECT greatest(NVL(SUM(gl.p_Icurval(at2.kv,st2.kos,to_date(p_Dat1,'dd/mm/yyyy'))),0) - --1
                    NVL(SUM(gl.p_Icurval(at2.kv,decode(at2.tip,'SPN',st2.DOS,0),to_date(p_Dat1,'dd/mm/yyyy'))),0) --
                  ,0) /100 into str_z.pog_sn_eqv -- ���� ��������� �������_� �� �_���� �� ��_��� ����, ���. ���.
                  FROM accounts at2, nd_acc nt2,saldoa st2
                  WHERE nt2.nd=k.ND and nt2.acc=at2.acc and at2.tip in ('SN ','SPN')
                              and st2.acc=at2.acc
                              and st2.fdat>add_months(to_date(p_Dat1,'dd/mm/yyyy'),-1)
                               and st2.fdat<=to_date(p_Dat1,'dd/mm/yyyy');


         if  (sql%rowcount = 0) then
                str_z.pog_sn_eqv := 0 ;  -- ���� ��������� �������_� �� �_���� �� ��_��� ����, ���. ���.
           end if;

         if  str_z.pog_sn_eqv =0 then
               str_z.pog_sn_nom :=0; -- ���� ��������� �������_� �� �_���� �� ��_��� ����, ���_���
           else
             str_z.pog_sn_nom:=gl.p_ncurval(k.kv,str_z.pog_sn_eqv,to_date(p_Dat1,'dd/mm/yyyy'));
         end if;


        Insert into BARS.TMP_CC_DEAL_PROBL
                  (ND, KF, BRANCH, OKPO, NMK, CC_ID, SDATE, WDATE, PROD, KV, ST_NOM_NG, ST_EQV_NG, SP_NOM_NG, SP_EQV_NG, ST_NOM_OD, ST_EQV_OD, SP_NOM_OD, SP_EQV_OD, KAT_J, DAT_MAX_ZB, DAT_SP_NOBAL, DAT_P_KK, POG_SS_NOM, POG_SS_EQV, POG_SN_NOM, POG_SN_EQV)
         Values
                  (str_z.ND, str_z.KF, str_z.BRANCH, str_z.OKPO, str_z.NMK, str_z.CC_ID, str_z.SDATE, str_z.WDATE, str_z.PROD, str_z.KV, str_z.ST_NOM_NG, str_z.ST_EQV_NG, str_z.SP_NOM_NG, str_z.SP_EQV_NG, str_z.ST_NOM_OD, str_z.ST_EQV_OD, str_z.SP_NOM_OD, str_z.SP_EQV_OD, str_z.KAT_J, str_z.DAT_MAX_ZB, str_z.DAT_SP_NOBAL, str_z.DAT_P_KK, str_z.POG_SS_NOM, str_z.POG_SS_EQV, str_z.POG_SN_NOM, str_z.POG_SN_EQV);

   <<RecNext>> null;


 end loop;

end ;
/
show err;

PROMPT *** Create  grants  P_CCK_PROBL ***
grant EXECUTE                                                                on P_CCK_PROBL     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CCK_PROBL     to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CCK_PROBL.sql =========*** End *
PROMPT ===================================================================================== 
