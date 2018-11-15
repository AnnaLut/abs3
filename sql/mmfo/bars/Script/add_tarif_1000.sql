begin
bc.home;
Insert into BARS.TARIF
   (KOD, KV, NAME, TAR, PR, 
    SMIN, TIP, KF)
 Values
   (1000, 980, 'ЕСКРОУ за здійснення переказу коштів бенефіціару', 0, 1, 
    0, 0, '322669');
exception when dup_val_on_index then null;

end; 
/   
COMMIT;
/