PROMPT ===================================================================================== 
PROMPT *** Run *** === Scripts /Sql/BARS/Script/upd_prvn_flow_details.sql ===*** Run *** ===
PROMPT ===================================================================================== 


-- *** Add  columns OBJECT_TYPE ***
begin
   execute immediate ' alter table BARS.PRVN_FLOW_DETAILS add ( OBJECT_TYPE      VARCHAR2(5) )';
exception
   when others  then 
        if sqlcode = -1430 then null;
        else raise;
        end if;
end;
/

declare
   l_lim            number        := 50000;
   type             tbl_rec       is record (rid rowid);
   type             t_tbl_rec     is table of tbl_rec;
   l_tbl            t_tbl_rec;
   l_kf             varchar2(6)   := null;
   l_cnt           number        := 0;
   cursor c_data is select u.rowid rid
                      from bars.prvn_flow_details u
                     where u.object_type is null;
begin


    -- *** Fill  columns OBJECT_TYPE ***
    for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
    loop
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);

        open c_data;
        loop
           fetch c_data bulk collect into l_tbl limit l_lim;
           exit when l_tbl.count = 0;
           forall i in l_tbl.first .. l_tbl.last
              update bars.prvn_flow_details
                 set object_type='CCK'
               where rowid = l_tbl(i).rid;

           commit;

           l_cnt := l_cnt + 1;
           dbms_application_info.set_action('ROWS: ' || to_char(l_cnt*l_lim)||'/ '||l_kf);

        end loop;

        close c_data;

    end loop;

    -- *** DROP constraint PK_PRVNFLOWDETAILS ***
    begin
      execute immediate 'ALTER TABLE BARS.PRVN_FLOW_DETAILS DROP PRIMARY KEY';
    exception when others then
      if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-2441 then null; else raise; end if;
    end;

    -- *** DROP index PK_PRVNFLOWDETAILS ***
    begin
      execute immediate 'drop index BARS.PK_PRVNFLOWDETAILS';
    exception when others then
      if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-1418 then null; else raise; end if;
    end;

    -- *** Create  constraint PK_PRVNFLOWDETAILS ***
    begin   
     execute immediate '
      ALTER TABLE BARS.PRVN_FLOW_DETAILS ADD CONSTRAINT PK_PRVNFLOWDETAILS PRIMARY KEY (KF, ND, MDAT, FDAT, OBJECT_TYPE)
      USING INDEX COMPUTE STATISTICS
      TABLESPACE BRSDYND
      ENABLE VALIDATE';
    exception when others then
      if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
    end;

    -- *** DROP index UK_PRVNDEALSFLOW ***
    begin
      execute immediate 'drop index BARS.UK_PRVNDEALSFLOW';
    exception when others then
      if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-1418 then null; else raise; end if;
    end;

    -- *** Create  index UK_PRVNDEALSFLOW ***
    begin   
     execute immediate '
      CREATE UNIQUE INDEX BARS.UK_PRVNDEALSFLOW ON BARS.PRVN_FLOW_DETAILS (MDAT, KF, ND, FDAT, OBJECT_TYPE)
      COMPUTE STATISTICS COMPRESS 2
      TABLESPACE BRSMDLI';
    exception when others then
      if  sqlcode=-955  then null; else raise; end if;
    end;


end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARS/Script/upd_prvn_flow_details.sql =====*** End *** ====
PROMPT ===================================================================================== 

