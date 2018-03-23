-- ======================================================================================
-- Author : KVA
-- Date   : 09.01.2018
-- ===================================== <Comments> =====================================
-- update column KF if is null
-- ======================================================================================

declare
  l_kf                   varchar2(6);
begin

  l_kf := F_OURMFO_G;

  begin

    bpa.disable_policies('W4_ACC_UPDATE');

    bc.subst_mfo( l_kf );

    update W4_ACC_UPDATE
       set KF = l_kf
     where KF is Null;
    dbms_output.put_line( to_char(sql%rowcount)||' row(s) updated.' );
    commit;

    begin   
     execute immediate '
      ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (KF CONSTRAINT CC_W4ACCUPD_KF_NN NOT NULL ENABLE)';
    exception when others then
      if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
     end;

    bc.set_context;

    bpa.enable_policies('W4_ACC_UPDATE');

  exception
    when others
    then bc.set_context;
         bpa.enable_policies('W4_ACC_UPDATE');
         raise;
  end;

end;
/

