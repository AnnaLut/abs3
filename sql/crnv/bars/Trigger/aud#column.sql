create or replace trigger tiu_aud#column
after update on asvo_immobile 
for each row 
begin 
audit_pkg.check_val( 'asvo_immobile', 'FIO ', :new.FIO , :old.FIO ,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'IDCODE', :new.IDCODE, :old.IDCODE,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'PASP_S', :new.PASP_S, :old.PASP_S,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'PASP_N', :new.PASP_N, :old.PASP_N,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'PASP_W', :new.PASP_W, :old.PASP_W,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'PASP_D', :new.PASP_D, :old.PASP_D,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'BIRTHDAT', :new.BIRTHDAT, :old.BIRTHDAT,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'BIRTHPL', :new.BIRTHPL, :old.BIRTHPL,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'REGION', :new.REGION, :old.REGION,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'DISTRICT', :new.DISTRICT, :old.DISTRICT,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'CITY', :new.CITY, :old.CITY,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'ADDRESS', :new.ADDRESS, :old.ADDRESS,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'PHONE_H', :new.PHONE_H, :old.PHONE_H,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'PHONE_J', :new.PHONE_J, :old.PHONE_J,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'DOCTYPE', :new.DOCTYPE, :old.DOCTYPE,:old.key); 
audit_pkg.check_val( 'asvo_immobile', 'FL', :new.FL, :old.FL,:old.key); 
end; 
/ 








