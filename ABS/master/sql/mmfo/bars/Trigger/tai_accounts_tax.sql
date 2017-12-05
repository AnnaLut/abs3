PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/tai_accounts_tax.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger tai_accounts_tax ***

BEGIN
  EXECUTE IMMEDIATE 'DROP trigger tai_accounts_tax';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -4080 THEN
      NULL;
    ELSE
      RAISE;
    END IF;
END;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/tai_accounts_tax.sql =========*** En
PROMPT ===================================================================================== 
