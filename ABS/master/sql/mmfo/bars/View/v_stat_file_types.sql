create or replace view V_STAT_FILE_TYPES as
select s.ID,
       s.CODE, 
       s.NAME,
       s.WF_ID,
       w.name workflow_name,
       s.EXT_ID

from stat_file_types s,
     stat_workflows w,
     stat_file_extensions e
where w.id = s.wf_id   
  and e.id = s.ext_id;
