declare
L_form_proc clob:='declare
l_cbirep_q DWH_CBIREP_QUERIES%rowtype;
l_reports  DWH_REPORTS%rowtype;
p_cbirep_queries_id number := #P_ID#;
l_file_name varchar2(254);
l_sqlprepare varchar2(32000);
l_file varchar2(50);
l_blob blob;
begin
select *
  into l_cbirep_q
  from DWH_CBIREP_QUERIES
 where id =  p_cbirep_queries_id;
select *
  into l_reports
  from DWH_REPORTS
 where id = l_cbirep_q.rep_id;
     dwh_cbirep.set_status(p_cbirep_queries_id, ''startcreatedfile'');
     commit;
for c0 in (select distinct rnk, nls, kv from
           (SELECT a.rnk, a.nls, a.kv
            FROM V_ND_ACCOUNTS a
           WHERE     a.nd in  (select d.ND from cc_deal d where d.ndg =  ~p_nd)
                 AND a.nls LIKE ~p_nls
                 AND CASE
                        WHEN ~p_kv = 0 THEN 1
                        WHEN ~p_kv = 980 AND a.kv = 980 THEN 1
                        WHEN ~p_kv = -980 AND a.kv != 980 THEN 1
                        ELSE 0
                     END = 1
             union
             SELECT a.rnk, a.nls, a.kv
            FROM V_ND_ACCOUNTS a
           WHERE     a.nd in  (select d.ND from cc_deal d where d.nd =  ~p_nd)
                 AND a.nls LIKE ~p_nls
                 AND CASE
                        WHEN ~p_kv = 0 THEN 1
                        WHEN ~p_kv = 980 AND a.kv = 980 THEN 1
                        WHEN ~p_kv = -980 AND a.kv != 980 THEN 1
                        ELSE 0
                     END = 1))
loop
p_lic_blob_nls (p_rnk   => c0.rnk,
                p_nls   => c0.nls,
                p_dat1  => to_date(p_sFdat1,''dd-mm-yyyy''),
                p_dat2  => to_date(p_sFdat2,''dd-mm-yyyy''),
                p_kv    => c0.kv,
                p_filemask => l_file,
                p_blob     => l_blob
                );
If DBMS_LOB.GETLENGTH (l_blob) > 476 then
    Insert into BARS.DWH_CBIREP_QUERIES_DATA  (  CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
     Values  (  p_cbirep_queries_id, l_file, DBMS_LOB.GETLENGTH (l_blob)   , l_blob);
end if;
end loop;
end;';
begin
update dwh_reports set form_proc =L_form_proc where id = 3004;
commit;
end;
/