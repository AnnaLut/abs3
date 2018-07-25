declare
l_res number;
begin
select count(sess_id) into l_res from ob_corp_data_doc;
if l_res = 0 then
insert into ob_corp_data_doc 
select SESS_ID, ACC, KF,ref, DK,
POSTDAT, DOCDAT,VALDAT, ND, VOB,  MFOA, NLSA, KVA, NAMA, OKPOA, MFOB, NLSB, 
KVB, NAMB, OKPOB, S, DOCKV, SQ, NAZN, TT from (
select  session_id as  SESS_ID, 
   coalesce((select acc from accounts a where a.kf = d.kf and a.kv = d.kv and a.nls = d.nls),
            (select acc from accounts a where a.kf = d.kf and a.kv = d.kv and a.nlsalt = d.nls)) as ACC, 
   KF, rownum as ref, doctype as DK,
   POSTDAT, DOCDAT,VALDAT, ND, VOB,  MFOA, NLSA, KVA, NAMA, OKPOA, MFOB, NLSB, 
   KVB, NAMB, OKPOB, S, DOCKV, SQ, NAZN, TT
   from ob_corporation_data d where rowtype = 1) d
   where exists (select 1 from ob_corp_data_acc a where a.sess_id = d.sess_id and a.kf = d.kf and a.acc = d.acc);
   l_res:=sql%rowcount;
   dbms_output.put_line(l_res||' rows Insertede into ob_corp_data_doc from ob_corporation_data');
end if; 
   exception when dup_val_on_index then
   dbms_output.put_line('0 rows Insertede into ob_corp_data_doc from ob_corporation_data');
end;
/
commit;
/