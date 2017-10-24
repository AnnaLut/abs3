update cim_f504_detail t 
set t.w = decode(t.w, 'А', 'A', 'В', 'B','С', 'C', t.w)
where t.w in ('А','В','С');

update cim_f504_detail2 t 
set t.w = decode(t.w, 'А', 'A', 'В', 'B','С', 'C', t.w)
where t.w in ('А','В','С');

commit;