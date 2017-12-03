exec bc.go('300465');

begin
   delete from PROC_DR$BASE where nbs in ('2700','2701','3660');
   Insert into BARS.PROC_DR$BASE (NBS, G67, V67, SOUR, NBSN, G67N, V67N, NBSZ, REZID, IO, BRANCH, KF, TT, TTV)
                          Values ('2700','70604010101210', '70604010101210', 4, '2708', '70604010101210','70604010101210', '9510', 
                                  0, 0, '/300465/000010/', '300465','%%1','%%1');
exception when dup_val_on_index then  null;
end;
/
begin                                                              
   Insert into BARS.PROC_DR$BASE (NBS, G67, V67, SOUR, NBSN, G67N, V67N, NBSZ, REZID, IO, BRANCH, KF, TT, TTV)
                          Values ('2701','70615010101210', '70615010101210', 4, '2708', '70615010101210','70615010101210', '9510', 
                                  0, 0, '/300465/000010/', '300465','%%1','%%1');
exception when dup_val_on_index then  null;
end;
/
begin
   Insert into BARS.PROC_DR$BASE (NBS, G67, V67, SOUR, NBSN, G67N, V67N, NBSZ, REZID, IO, BRANCH, KF, TT, TTV)
                          Values ('3660','70961010100523', '70961010100523', 4, '3668', '70961010100523', '70961010100523', '9510', 
                                  0, 0, '/300465/000010/', '300465','%%1','%%1');
exception when dup_val_on_index then  null;
end;
/
COMMIT;

begin
   Insert into BARS.PROC_DR$BASE (NBS, G67, V67, SOUR, NBSN, G67N, V67N, NBSZ, REZID, IO, BRANCH, KF, TT, TTV)
                          Values ('2700','70604010101210', '70604010101210', 4, '2708', '70604010101210','70604010101210', '9510', 
                                  0, 0, '/300465/', '300465','%%1','%%1');
exception when dup_val_on_index then  null;
end;
/
begin                                                              
   Insert into BARS.PROC_DR$BASE (NBS, G67, V67, SOUR, NBSN, G67N, V67N, NBSZ, REZID, IO, BRANCH, KF, TT, TTV)
                          Values ('2701','70615010101210', '70615010101210', 4, '2708', '70615010101210','70615010101210', '9510', 
                                  0, 0, '/300465/', '300465','%%1','%%1');
exception when dup_val_on_index then  null;
end;
/
begin
   Insert into BARS.PROC_DR$BASE (NBS, G67, V67, SOUR, NBSN, G67N, V67N, NBSZ, REZID, IO, BRANCH, KF, TT, TTV)
                          Values ('3660','70961010100523', '70961010100523', 4, '3668', '70961010100523', '70961010100523', '9510', 
                                  0, 0, '/300465/', '300465','%%1','%%1');
exception when dup_val_on_index then  null;
end;
/
COMMIT;


exec bc.go('/');