

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_TARIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_TARIF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_TARIF ("PRODUCT_GROUPS", "TARIF_CODE", "TARIF_NAME", "TARIF_VAL", "CARD") AS 
  (SELECT product_groups,
           tarif_code,
           tarif_name,
           velctr_maestro_melctr tarif_val,
           'VELCTR' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           velctr_maestro_melctr tarif_val,
           'VECCST' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           velctr_maestro_melctr tarif_val,
           'VELCTRINST' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           velctr_maestro_melctr tarif_val,
           'MAESTRO' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           velctr_maestro_melctr tarif_val,
           'MELCTR' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vclassdom tarif_val,
           'VCLASSDOM' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vclass tarif_val,
           'VCLASSVLN' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vclass tarif_val,
           'VCLASS' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           MWORLD tarif_val,
           'MWORLD' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           mstnd tarif_val,
           'MSTND' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           mstnddeb tarif_val,
           'MDVSK' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           mstnddeb tarif_val,
           'MSTNDDEB' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vgold_mgold tarif_val,
           'VGOLD' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vgold_mgold tarif_val,
           'VGOLDPW' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vgold_mgold tarif_val,
           'MGOLD' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           mgolddeb tarif_val,
           'MGOLDDEB' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vplat tarif_val,
           'VPLAT' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           mplat tarif_val,
           'MPLAT' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           mplatdeb tarif_val,
           'MPLATDEB' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           msign tarif_val,
           'MSIGN' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           msign tarif_val,
           'MELIT' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vvirtual tarif_val,
           'VVIRTUAL' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vbsns tarif_val,
           'VBSNS' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           vbsnselctr tarif_val,
           'VBSNSELCTR' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           mcorp tarif_val,
           'MCORP' card
      FROM w4_tarif
    UNION ALL
    SELECT product_groups,
           tarif_code,
           tarif_name,
           msign tarif_val,
           'VINFIN' card
      FROM w4_tarif);

PROMPT *** Create  grants  V_W4_TARIF ***
grant SELECT                                                                 on V_W4_TARIF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_TARIF      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_TARIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
