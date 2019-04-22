

prompt create view vw_ref_staff


CREATE OR REPLACE VIEW vw_ref_staff (
   ID,
   FIO,
   LOGNAME,
   BRANCH )
AS
select ID, FIO, LOGNAME , BRANCH from bars.staff$base sb 
where sb.disable =0;

-- Grants  

GRANT SELECT ON vw_ref_staff TO ibmesb;

-- Comments  

COMMENT ON TABLE vw_ref_staff IS 'Активні користувачі (COBUMMFO-11186)';
