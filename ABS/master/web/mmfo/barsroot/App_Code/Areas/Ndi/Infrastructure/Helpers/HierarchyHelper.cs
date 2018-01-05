using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using BarsWeb.Areas.Ndi.Models.Attributes;
using BarsWeb.Areas.Ndi.Models;

/// <summary>
/// Summary description for HierarchyHelper
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers
{
    public class HierarchyHelper
    {
        public HierarchyHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static void BuildFromBaseOptions(FunNSIEditFParams baseNsiParams, FunNSIEditFParams nsiParams)
        {
            if (baseNsiParams.BaseOptionsNames == null || baseNsiParams.BaseOptionsNames.Count < 1)
                return;
            Type type = typeof(FunNSIEditFParams);
            Type typeBase = baseNsiParams.GetType();
            Type typeNative = nsiParams.GetType();
            List<PropertyInfo> props = type.GetProperties().Where(prop => prop.IsDefined(typeof(MainOptionAttribute), false)).ToList();//.Where(u => u.GetCustomAttributes(false) != null && u.GetCustomAttributes(false).ToList().Count > 0).ToList();
            foreach (var item in props)
            {
                MainOptionAttribute attr = (MainOptionAttribute)
           item.GetCustomAttributes(typeof(MainOptionAttribute), false).ToList()[0] as MainOptionAttribute;
                if (attr != null && baseNsiParams.BaseOptionsNames.Contains(attr.OptionName) && attr.CanInheritance)
                {
                    string propName = item.Name;
                    typeNative.GetProperty(propName).SetValue(nsiParams, typeBase.GetProperty(propName).GetValue(baseNsiParams, null), null);
                }
            }

        }


    }
}