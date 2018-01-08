

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MOD_ACC_BAK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MOD_ACC_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MOD_ACC_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.MOD_ACC_BAK 
   (	ACC NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MOD_ACC_BAK ***
 exec bpa.alter_policies('MOD_ACC_BAK');


COMMENT ON TABLE BARS.MOD_ACC_BAK IS '';
COMMENT ON COLUMN BARS.MOD_ACC_BAK.ACC IS '';



PROMPT *** Create  grants  MOD_ACC_BAK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MOD_ACC_BAK     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MOD_ACC_BAK     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MOD_ACC_BAK.sql =========*** End *** =
PROMPT ===================================================================================== 
