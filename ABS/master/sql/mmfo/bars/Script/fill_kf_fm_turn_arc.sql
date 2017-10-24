prompt политизируем таблицу fm_turn_arc. 
prompt add KF
begin
  execute immediate 'alter table bars.fm_turn_arc add kf varchar2(6)';
exception
  when others then
     if sqlcode = -1430 then null; else raise; end if;
end;
/

prompt fill kf

begin
  update fm_turn_arc
  set kf = bars_sqnc.get_kf(substr(to_char(rnk), -2));
end;
/
commit;
/

prompt add KF
begin
  execute immediate 'alter table bars.fm_turn_arc modify kf DEFAULT sys_context(''bars_context'',''user_mfo'')';
exception
  when others then
     if sqlcode = -1430 then null; else raise; end if;
end;
/

PROMPT *** ALTER_POLICY_INFO to FM_TURN_ARC ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_TURN_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FM_TURN_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/
PROMPT *** ALTER_POLICIES to FM_TURN_ARC ***
 begin bpa.alter_policies('FM_TURN_ARC'); end;
/