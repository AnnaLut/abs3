declare
  l_user_name staff$base.logname%type;
  l_user_id   staff$base.id%type;
begin
     l_user_name := 'BARS';
     select id into l_user_id from bars.staff$base where LOGNAME = l_user_name;
     bars.bars_login.login_user( p_sessionid => substr(sys_guid(), 1, 32),
                                 p_userid    => l_user_id,
                                 p_hostname  => null,
                                 p_appname   => null);
     --bars.bc.go('/');


Insert into BARS.XOZ_REF_UPDATE(
    IDUPD ,CHGACTION, EFFECTDATE, GLOBAL_BD, CHGDATE, DONEBY,
    ID, REF1, STMT1, REF2, ACC, MDATE, S, FDAT, S0, NOTP, PRG, BU, DATZ, REFD, KF)
with db as (select id from bars.staff$base where logname = 'BARSUPL')
select 
    bars.bars_sqnc.get_nextval('s_xoz_ref_update', xozr.KF) as IDUPD,
    decode(xozr.id, null, 'D', 'U') as EFFECTDATE,
    COALESCE(bars.gl.bd, bars.glb_bankdate),
    bars.glb_bankdate as GLOBAL_BD,
    sysdate as CHGDATE,
    db.id as DONEBY,
    xozr.ID, xozr.REF1, xozr.STMT1, xozr.REF2, xozr.ACC, xozr.MDATE, xozr.S, xozr.FDAT, xozr.S0, xozr.NOTP, xozr.PRG, xozr.BU, xozr.DATZ, xozr.REFD, xozr.KF 
 from BARS.XOZ_REF xozr
      full outer join
      (select * 
         from BARS.XOZ_REF_UPDATE upd
        where upd.idupd in (select max(upd1.idupd) from BARS.XOZ_REF_UPDATE upd1 group by upd1.id )
       )xozrupd 
       on(xozr.id = xozrupd.id ),
      db
where(decode(xozr.REF1 ,xozrupd.REF1 ,1,0)=0 or
      decode(xozr.STMT1,xozrupd.STMT1,1,0)=0 or
      decode(xozr.REF2 ,xozrupd.REF2 ,1,0)=0 or
      decode(xozr.ACC  ,xozrupd.ACC  ,1,0)=0 or
      decode(xozr.MDATE,xozrupd.MDATE,1,0)=0 or
      decode(xozr.S    ,xozrupd.S    ,1,0)=0 or
      decode(xozr.FDAT ,xozrupd.FDAT ,1,0)=0 or
      decode(xozr.S0   ,xozrupd.S0   ,1,0)=0 or
      decode(xozr.NOTP ,xozrupd.NOTP ,1,0)=0 or
      decode(xozr.PRG  ,xozrupd.PRG  ,1,0)=0 or
      decode(xozr.BU   ,xozrupd.BU   ,1,0)=0 or
      decode(xozr.DATZ ,xozrupd.DATZ ,1,0)=0 or
      decode(xozr.REFD ,xozrupd.REFD ,1,0)=0 or
      decode(xozr.KF   ,xozrupd.KF   ,1,0)=0 or
      decode(xozr.ID   ,xozrupd.ID   ,1,0)=0 ) or 
      (xozrupd.CHGACTION ='D' and xozr.ID is not null) or
      (xozrupd.CHGACTION <>'D' and xozr.ID is null)
;

commit;

end;
/