


PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_UPDATE_TBL_STAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_UPDATE_TBL_STAT ***

begin
  execute immediate 'CREATE SEQUENCE BARS.S_UPDATE_TBL_STAT
                       START WITH 1
                       MAXVALUE 9999999999999999999999999
                       MINVALUE 1
                       NOCYCLE
                       CACHE 20
                       NOORDER';
  dbms_output.put_line('sequence S_UPDATE_TBL_STAT created.');
exception 
  when others then 
    if (sqlcode = -00955) 
    then 
      dbms_output.put_line('sequence S_UPDATE_TBL_STAT already exists.');
    else 
      raise; 
    end if;
end;  
/

grant SELECT                                                                 on S_UPDATE_TBL_STAT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_UPDATE_TBL_STAT         to START1;
grant SELECT                                                                 on S_UPDATE_TBL_STAT         to BARSUPL;
grant SELECT                                                                 on S_UPDATE_TBL_STAT         to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_UPDATE_TBL_STAT.sql =========*** End *** =
PROMPT ===================================================================================== 

