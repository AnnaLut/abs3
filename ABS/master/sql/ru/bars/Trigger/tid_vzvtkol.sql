

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TID_VZVTKOL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TID_VZVTKOL ***

  CREATE OR REPLACE TRIGGER BARS.TID_VZVTKOL 
       INSTEAD OF INSERT OR DELETE
       ON BARS.V_ZVT_KOL REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   If deleting then
      -- удаляем старые партиции
      execute immediate
       'alter table PART_ZVT_DOC drop partition for ('||
       'to_date('''|| to_char(:old.FDAT,'dd.mm.yyyy') ||''',''dd.mm.yyyy''))';
      logger.trace('партиция %s за дату удалена', to_char(:old.FDAT,'dd.mm.yyyy'));
   Elsif inserting then
         p_zvt_doc ( to_char(:new.FDAT, 'dd.mm.yyyy') );
      logger.trace('партиция %s за дату накоплена', to_char(:new.FDAT,'dd.mm.yyyy'));
   end if;
END;
/
ALTER TRIGGER BARS.TID_VZVTKOL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TID_VZVTKOL.sql =========*** End ***
PROMPT ===================================================================================== 
