

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VN_NLS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VN_NLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VN_NLS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VN_NLS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VN_NLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VN_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.VN_NLS 
   (	NLS VARCHAR2(14)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VN_NLS ***
 exec bpa.alter_policies('VN_NLS');


COMMENT ON TABLE BARS.VN_NLS IS '';
COMMENT ON COLUMN BARS.VN_NLS.NLS IS '';



PROMPT *** Create  grants  VN_NLS ***
grant SELECT                                                                 on VN_NLS          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VN_NLS          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VN_NLS          to START1;
grant SELECT                                                                 on VN_NLS          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VN_NLS.sql =========*** End *** ======
PROMPT ===================================================================================== 
