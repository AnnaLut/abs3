

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/B_C_OT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to B_C_OT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''B_C_OT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''B_C_OT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''B_C_OT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table B_C_OT ***
begin 
  execute immediate '
  CREATE TABLE BARS.B_C_OT 
   (	C_OTV VARCHAR2(24), 
	N_C_OTV NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to B_C_OT ***
 exec bpa.alter_policies('B_C_OT');


COMMENT ON TABLE BARS.B_C_OT IS '';
COMMENT ON COLUMN BARS.B_C_OT.C_OTV IS '';
COMMENT ON COLUMN BARS.B_C_OT.N_C_OTV IS '';



PROMPT *** Create  grants  B_C_OT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on B_C_OT          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on B_C_OT          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on B_C_OT          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/B_C_OT.sql =========*** End *** ======
PROMPT ===================================================================================== 
