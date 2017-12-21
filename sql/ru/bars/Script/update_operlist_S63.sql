update operlist set funcname = 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''22%'' or s.tip=''SK9'') and exists(select 1 from v_cc_lfs1 where a=s.acc and j=i.acra and l=i.acrb)","A")'
where funcname = 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''22%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs1 where a=s.acc and j=i.acra and l=i.acrb)","A")';


update operlist set funcname = 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.tip=''SK9'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")'
where funcname = 'Sel010(hWndMDI,0,0,"and i.ID=2 and (s.nls like ''20%'' or s.nbs=''3579'') and exists(select 1 from v_cc_lfs2 where a=s.acc and j=i.acra and l=i.acrb)","A")';

commit;