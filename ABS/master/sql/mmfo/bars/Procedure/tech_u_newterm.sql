

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TECH_U_NEWTERM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TECH_U_NEWTERM ***

  CREATE OR REPLACE PROCEDURE BARS.TECH_U_NEWTERM 
IS
BEGIN
   UPDATE bars.web_usermap
      SET chgdate = NULL
    WHERE webuser IN ('absadm',
                      'avtokassa',
                      'clim_sync',
                      'crmzapit',
                      --'dwh_loader',
                      'ead_sync',
                      'fnvr',
                      'kred_res',
                      'notary',
                      'sto_service',
                      'swift',
                      'zay_recipient',
                      'crca',
                      'wbarsebk');

   COMMIT;
END TECH_U_NEWTERM;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TECH_U_NEWTERM.sql =========*** En
PROMPT ===================================================================================== 
