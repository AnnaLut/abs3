

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORTS_STAFF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORTS_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORTS_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_STAFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORTS_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORTS_STAFF 
   (	ID_U NUMBER, 
	ID_R NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORTS_STAFF ***
 exec bpa.alter_policies('REPORTS_STAFF');


COMMENT ON TABLE BARS.REPORTS_STAFF IS '';
COMMENT ON COLUMN BARS.REPORTS_STAFF.ID_U IS '';
COMMENT ON COLUMN BARS.REPORTS_STAFF.ID_R IS '';



PROMPT *** Create  grants  REPORTS_STAFF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_STAFF   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPORTS_STAFF   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTS_STAFF   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORTS_STAFF.sql =========*** End ***
PROMPT ===================================================================================== 
