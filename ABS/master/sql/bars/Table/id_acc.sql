

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ID_ACC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ID_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ID_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ID_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ID_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ID_ACC 
   (	ID NUMBER(*,0), 
	ACC NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ID_ACC ***
 exec bpa.alter_policies('ID_ACC');


COMMENT ON TABLE BARS.ID_ACC IS '';
COMMENT ON COLUMN BARS.ID_ACC.ID IS '';
COMMENT ON COLUMN BARS.ID_ACC.ACC IS '';



PROMPT *** Create  grants  ID_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ID_ACC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ID_ACC          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ID_ACC          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ID_ACC.sql =========*** End *** ======
PROMPT ===================================================================================== 
