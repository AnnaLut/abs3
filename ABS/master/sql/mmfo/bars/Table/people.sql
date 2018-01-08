

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEOPLE.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEOPLE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEOPLE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PEOPLE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PEOPLE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEOPLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEOPLE 
   (	FIO VARCHAR2(43)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEOPLE ***
 exec bpa.alter_policies('PEOPLE');


COMMENT ON TABLE BARS.PEOPLE IS '';
COMMENT ON COLUMN BARS.PEOPLE.FIO IS '';



PROMPT *** Create  grants  PEOPLE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEOPLE          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEOPLE          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEOPLE.sql =========*** End *** ======
PROMPT ===================================================================================== 
