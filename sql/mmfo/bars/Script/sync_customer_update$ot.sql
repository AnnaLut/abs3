-- ======================================================================================
-- Module : UPL - Вивантаження даних до DWH
-- Author : BAA
-- Date   : 04.04.2019
-- Update : RILESIV 04.04.2019
-- синхронизация CUSTOMER_UPDATE vs CUSTOMER
-- ======================================================================================

set serveroutput on size unlimited
set termout   on
set trimspool on
set autotrace on

--ALTER SESSION ENABLE PARALLEL DML;

declare
  l_bd                date;
  l_glb_bankdate      date;
  l_kf                varchar2(6);
begin
  --l_kf := '322669';               -- закомментировать если выполнять для всех РУ в ММФО, иначе только для этого МФО
  for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
  loop
    DBMS_OUTPUT.PUT_LINE('Start CUSTOMER_UPDATE sinchronize for = ' || lc_kf.kf);
    begin
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);
		l_bd           := bars.gl.bd;        -- локальна БД
        l_glb_bankdate := bars.glb_bankdate; -- глобальная банковская дата
			
	    execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_ise'       ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_fs'        ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_branch'    ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupdate_tobo'   ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_custtype'  ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_oe'        ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_stmt'      ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_sprreg'    ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_codcagent' ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_country'   ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_ved'       ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_sed'       ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_staff'     ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_tgr'       ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_customer'  ;
        execute immediate 'alter table bars.customer_update disable constraint fk_customerupd_prinsider' ;
        execute immediate 'alter table bars.customer_update disable constraint cc_customer_globalbd_nn'  ;		
		
        INSERT INTO bars.customer_update (chgdate,chgaction,idupd,doneby,effectdate,global_bdate,
                                          rnk,tgr,custtype,country,nmk,nmkv,nmkk,codcagent,prinsider,
                                          okpo,adr,sab,c_reg,c_dst,rgtax,datet,adm,datea,stmt,date_on,
                                          date_off,notes,notesec,crisk,pincode,nd,rnkp,ise,fs,oe,ved,sed,
                                          lim,mb,rgadm,bc,branch, tobo,isp,taxf,nompdv,k050,nrezid_code,kf)		
	    select sysdate                                             as chgdate,
               case 
                   when c.rnk is not null and cu.rnk is null then 2            -- Customer Opened/Changed (1 does not use because dont know when INSERT operation to carried out)
                   when c.date_off is not null and cu.date_off is null then 3  -- Customer Closed
                   when c.date_off is null and cu.date_off is not null then 0  -- Resurection
                   else 2 end                                                  -- Customer Changed           
               as chgaction,
               bars.bars_sqnc.get_nextval('s_customer_update', coalesce(c.kf, cu.kf)) as idupd,
               'BARSUPL'                                           as doneby,   -- SET TRIGGER TI_CUSTOMER_UPD :new.doneby:= user_name;
               coalesce(l_bd, l_glb_bankdate)                      as effectdate, 
               l_glb_bankdate                                      as global_bdate,
               decode(c.rnk, null, cu.rnk,         c.rnk         ) as rnk,
               decode(c.rnk, null, cu.tgr,         c.tgr         ) as tgr,         
               decode(c.rnk, null, cu.custtype,    c.custtype    ) as custtype,    
               decode(c.rnk, null, cu.country,     c.country     ) as country,     
               decode(c.rnk, null, cu.nmk,         c.nmk         ) as nmk,         
               decode(c.rnk, null, cu.nmkv,        c.nmkv        ) as nmkv,        
               decode(c.rnk, null, cu.nmkk,        c.nmkk        ) as nmkk,        
               decode(c.rnk, null, cu.codcagent,   c.codcagent   ) as codcagent,   
               decode(c.rnk, null, cu.prinsider,   c.prinsider   ) as prinsider,   
               decode(c.rnk, null, cu.okpo,        c.okpo        ) as okpo,        
               decode(c.rnk, null, cu.adr,         c.adr         ) as adr,         
               decode(c.rnk, null, cu.sab,         c.sab         ) as sab,         
               decode(c.rnk, null, cu.c_reg,       c.c_reg       ) as c_reg,       
               decode(c.rnk, null, cu.c_dst,       c.c_dst       ) as c_dst,       
               decode(c.rnk, null, cu.rgtax,       c.rgtax       ) as rgtax,       
               decode(c.rnk, null, cu.datet,       c.datet       ) as datet,       
               decode(c.rnk, null, cu.adm,         c.adm         ) as adm,         
               decode(c.rnk, null, cu.datea,       c.datea       ) as datea,       
               decode(c.rnk, null, cu.stmt,        c.stmt        ) as stmt,        
               decode(c.rnk, null, cu.date_on,     c.date_on     ) as date_on,     
               decode(c.rnk, null, cu.date_off,    c.date_off    ) as date_off,    
               decode(c.rnk, null, cu.notes,       c.notes       ) as notes,       
               decode(c.rnk, null, cu.notesec,     c.notesec     ) as notesec,     
               decode(c.rnk, null, cu.crisk,       c.crisk       ) as crisk,       
               decode(c.rnk, null, cu.pincode,     c.pincode     ) as pincode,     
               decode(c.rnk, null, cu.nd,          c.nd          ) as nd,          
               decode(c.rnk, null, cu.rnkp,        c.rnkp        ) as rnkp,        
               decode(c.rnk, null, cu.ise,         c.ise         ) as ise,         
               decode(c.rnk, null, cu.fs,          c.fs          ) as fs,          
               decode(c.rnk, null, cu.oe,          c.oe          ) as oe,          
               decode(c.rnk, null, cu.ved,         c.ved         ) as ved,         
               decode(c.rnk, null, cu.sed,         c.sed         ) as sed,         
               decode(c.rnk, null, cu.lim,         c.lim         ) as lim,         
               decode(c.rnk, null, cu.mb,          c.mb          ) as mb,          
               decode(c.rnk, null, cu.rgadm,       c.rgadm       ) as rgadm,       
               decode(c.rnk, null, cu.bc,          c.bc          ) as bc,          
               decode(c.rnk, null, cu.branch,      c.branch      ) as branch,      
               decode(c.rnk, null, cu.tobo,        c.tobo        ) as tobo,        
               decode(c.rnk, null, cu.isp,         c.isp         ) as isp,         
               decode(c.rnk, null, cu.taxf,        c.taxf        ) as taxf,        
               decode(c.rnk, null, cu.nompdv,      c.nompdv      ) as nompdv,      
               decode(c.rnk, null, cu.k050,        c.k050        ) as k050,        
               decode(c.rnk, null, cu.nrezid_code, c.nrezid_code ) as nrezid_code, 
               decode(c.rnk, null, cu.kf,          c.kf          ) as kf          
        from bars.customer c 
        left outer join (select cus.* 
                          from bars.customer_update cus  
                         where cus.idupd in (select max(u.idupd)
                                              from  bars.customer_update u   
                                             where u.kf = l_kf                -- There is policy but use l_kf because customer_update includes index which are partitions  
                                             group by u.rnk)
                         and cus.kf = l_kf) cu on cu.rnk = c.rnk
        where(decode(c.tgr,         cu.tgr,         1, 0) = 0 or
              decode(c.custtype,    cu.custtype,    1, 0) = 0 or
              decode(c.country,     cu.country,     1, 0) = 0 or
              decode(c.nmk,         cu.nmk,         1, 0) = 0 or
              decode(c.nmkv,        cu.nmkv,        1, 0) = 0 or
              decode(c.nmkk,        cu.nmkk,        1, 0) = 0 or
              decode(c.codcagent,   cu.codcagent,   1, 0) = 0 or
              decode(c.prinsider,   cu.prinsider,   1, 0) = 0 or
              decode(c.okpo,        cu.okpo,        1, 0) = 0 or
              decode(c.adr,         cu.adr,         1, 0) = 0 or
              decode(c.sab,         cu.sab,         1, 0) = 0 or
              decode(c.c_reg,       cu.c_reg,       1, 0) = 0 or
              decode(c.c_dst,       cu.c_dst,       1, 0) = 0 or
              decode(c.rgtax,       cu.rgtax,       1, 0) = 0 or
              decode(c.datet,       cu.datet,       1, 0) = 0 or
              decode(c.adm,         cu.adm,         1, 0) = 0 or
              decode(c.datea,       cu.datea,       1, 0) = 0 or
              decode(c.stmt,        cu.stmt,        1, 0) = 0 or
              decode(c.date_on,     cu.date_on,     1, 0) = 0 or
              decode(c.date_off,    cu.date_off,    1, 0) = 0 or
              decode(c.notes,       cu.notes,       1, 0) = 0 or
              decode(c.notesec,     cu.notesec,     1, 0) = 0 or
              decode(c.crisk,       cu.crisk,       1, 0) = 0 or
              decode(c.pincode,     cu.pincode,     1, 0) = 0 or
              decode(c.nd,          cu.nd,          1, 0) = 0 or
              decode(c.rnkp,        cu.rnkp,        1, 0) = 0 or
              decode(c.ise,         cu.ise,         1, 0) = 0 or
              decode(c.fs,          cu.fs,          1, 0) = 0 or
              decode(c.oe,          cu.oe,          1, 0) = 0 or
              decode(c.ved,         cu.ved,         1, 0) = 0 or
              decode(c.sed,         cu.sed,         1, 0) = 0 or
              decode(c.lim,         cu.lim,         1, 0) = 0 or
              decode(c.mb,          cu.mb,          1, 0) = 0 or
              decode(c.rgadm,       cu.rgadm,       1, 0) = 0 or
              decode(c.bc,          cu.bc,          1, 0) = 0 or
              decode(c.branch,      cu.branch,      1, 0) = 0 or
              decode(c.tobo,        cu.tobo,        1, 0) = 0 or
              decode(c.isp,         cu.isp,         1, 0) = 0 or
              decode(c.taxf,        cu.taxf,        1, 0) = 0 or
              decode(c.nompdv,      cu.nompdv,      1, 0) = 0 or
              decode(c.k050,        cu.k050,        1, 0) = 0 or
              decode(c.nrezid_code, cu.nrezid_code, 1, 0) = 0 or
              decode(c.kf,          cu.kf,          1, 0) = 0 )
              and c.kf = l_kf;                                          -- There is policy but use l_kf because customer perhaps WILL include partitions 

        DBMS_OUTPUT.PUT_LINE('Sinchronize CUSTOMER_UPDATE = ' || sql%rowcount || ' row(s) inserted/updated =');
        exception when others then
           if sqlcode = -6550 then null;
           else
              rollback;
              raise;
           end if;
        end;
    COMMIT;
	end loop;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_ise'       ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_fs'        ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_branch'    ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupdate_tobo'   ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_custtype'  ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_oe'        ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_stmt'      ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_sprreg'    ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_codcagent' ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_country'   ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_ved'       ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_sed'       ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_staff'     ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_tgr'       ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_customer'  ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint fk_customerupd_prinsider' ;
    execute immediate 'alter table bars.customer_update enable novalidate constraint cc_customer_globalbd_nn'  ; 
	
end;
/

exec bars.bc.home;

--rollback;
--COMMIT;

--set autotrace off

